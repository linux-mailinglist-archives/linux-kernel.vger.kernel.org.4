Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB92D6CA316
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjC0MKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjC0MKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:10:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339BA19BF;
        Mon, 27 Mar 2023 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679919017; x=1711455017;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jeepVfFfCQsHZs+6635Pz6VkoXSevOib+Apjcl9UAno=;
  b=ZO2D4pJkE/Us1O38/CbkB9XFN0DYEDCBeBG5lzX/qXaNrR5WuZsCn0cO
   WbxJvGTb1eejoljqDcu4wN2wBNeffo2l2ObLpQcJfkhMexLDej2rNW5qw
   KrmeDI35PZfHYT6/Es4vQVuDGXTIMqXKtGGg3ujoyXtfIvlltsPV/pVy6
   MjcTgPZ85aSvbAv1r9O9nsEJ654eEn9qA8mSh0vB/TF0xT9fMBxFoEgpt
   gARkXQmwe+yqrtF4n+i6g1RyeHMHFnEc21lk2fAcQrqR1+i86dux/6Wfn
   W6s+PagIHuPbNGHTZ11cVmcE1rk7n5MdnsjI4QresmKCbBH7EGl4qFIx1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341821758"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="341821758"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 05:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633583683"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="633583683"
Received: from biyengar-mobl.amr.corp.intel.com ([10.213.176.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 05:10:16 -0700
Message-ID: <c6b89edad5f74bf5ca82401a3d9cc5b4198baac8.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Fix kernel panic during warm reset
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Tanu Malhotra <tanu.malhotra@intel.com>, jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        even.xu@intel.com, Shaunak Saha <shaunak.saha@intel.com>
Date:   Mon, 27 Mar 2023 05:10:14 -0700
In-Reply-To: <20230327032310.2416272-1-tanu.malhotra@intel.com>
References: <20230327032310.2416272-1-tanu.malhotra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-03-26 at 20:23 -0700, Tanu Malhotra wrote:

some minor nits below.

> During warm reset device->fw_client is set to NULL. If a bus driver
> is
> registered after this NULL setting and before new firmware clients
> are
> enumerated by ISHTP, kernel panic will result in the function
> ishtp_cl_bus_match(). This is because of reference to
> device->fw_client->props.protocol_name.
>=20
> ISH firmware after getting successfully loaded, sends a warm reset
> notification to remove all clients from the bus and sets
> device->fw_client to NULL. Until kernel v5.15, all enabled ISHTP
> kernel
> module drivers were loaded after any of the first ISHTP device was
> registered, regardless of whether it was a matched or an unmatched
> device. This resulted in all drivers getting registered much before
> the
> warm reset notification from ISH. Starting kernel v5.16, this issue
> got
> exposed after the change was introduced to load only bus drivers for
> the
> respective matching devices.
One paragraph break will be better.

>  In this scenario, cros_ec_ishtp device and
> cros_ec_ishtp driver are registered after the warm reset
> device_fw_client NULL setting. cros_ec_ishtp driver_register()
> triggers
> the callback to ishtp_cl_bus_match() to match driver to the device
> and
> causes kernel panic in guid_equal() when dereferencing fw_client NULL
> pointer to get protocol_name.
>=20
> Fixes: f155dfeaa4ee ("platform/x86: isthp_eclite: only load for
> matching devices")
> Fixes: facfe0a4fdce ("platform/chrome: chros_ec_ishtp: only load for
> matching devices")
> Fixes: 0d0cccc0fd83 ("HID: intel-ish-hid: hid-client: only load for
> matching devices")
> Fixes: 44e2a58cb880 ("HID: intel-ish-hid: fw-loader: only load for
> matching devices")
>=20
No need of blank line.

> Signed-off-by: Tanu Malhotra <tanu.malhotra@intel.com>
> Tested-by: Shaunak Saha <shaunak.saha@intel.com>
You can also add=20
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


Also add
Cc: <stable@vger.kernel.org> # 5.16+

> ---
When you submit "PATCH v2", Add change log here. (That is below "---").
Something like this:
v2
- Updated commit description
- Added CC to stable

> =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 81385ab37fa9..4f540906268f 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -241,8 +241,8 @@ static int ishtp_cl_bus_match(struct device *dev,
> struct device_driver *drv)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ishtp_cl_device *d=
evice =3D to_ishtp_cl_device(dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ishtp_cl_driver *d=
river =3D to_ishtp_cl_driver(drv);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return guid_equal(&driver->id[=
0].guid,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &d=
evice->fw_client->props.protocol_name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return(device->fw_client ? gui=
d_equal(&driver->id[0].guid,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &device->fw_client-
> >props.protocol_name) : 0);
Align the second line to char "d" after "(".

Thanks,
Srinivas

> =C2=A0}
> =C2=A0
> =C2=A0/**

