Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553CC6B3B59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCJJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCJJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:51:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AE76B97E;
        Fri, 10 Mar 2023 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678441906; x=1709977906;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=H7wVVvPfFy1MyAOa9uwmgXzoHT8I272jaqbMmZj1xXM=;
  b=Q/2SMaDFUuVYrQs5TkeznR19v8ww/4v+VwRIYMCqQYAhxHf0Ws0EugOk
   Jjat4nchgdgCdIE+hyfBOsvCx2dRGQ9SbzGsYUHpU+3/YTJqVlMeT7SoJ
   dp80YbrAxC8zTbwa8G+y8mvn6a1CHNvZk9f+/2BB4i2bPu0eHgsNBL98x
   LNAcIEJicpcpDa2Yf1o3wY1BcRwrFMyAAGgnGWeNeFKK/9Aoeg2wjoi95
   BX1714kUMLmURaG3LnV2idAcodv6umLFRIHlF1gmoKBEw7h8bxySvgq//
   nB7mWIP4OYcGe0FVYlwERraWcvOdSbmJFsCb5B/i9am1+JGnPa9Cd3rEW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="325044858"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="325044858"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 01:51:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="627749748"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="627749748"
Received: from sischoen-mobl.ger.corp.intel.com ([10.252.60.19])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 01:51:43 -0800
Message-ID: <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
Subject: Re: BUG: hid-sensor-ids code includes binary data in device name
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     todd.e.brandt@linux.intel.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Cc:     p.jungkamp@gmx.net, Jonathan.Cameron@huawei.com, jkosina@suse.cz,
        todd.e.brandt@intel.com
Date:   Fri, 10 Mar 2023 01:51:41 -0800
In-Reply-To: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
References: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Even

On Thu, 2023-03-09 at 15:33 -0800, Todd Brandt wrote:
> Hi all, I've run into an issue in 6.3.0-rc1 that causes problems with
> ftrace and I've bisected it to this commit:
>=20
> commit 98c062e8245199fa9121141a0bf1035dc45ae90e (HEAD,
> refs/bisect/bad)
> Author: Philipp Jungkamp p.jungkamp@gmx.net
> Date:=C2=A0=C2=A0 Fri Nov 25 00:38:38 2022 +0100
>=20
> =C2=A0=C2=A0=C2=A0 HID: hid-sensor-custom: Allow more custom iio sensors
>=20
> =C2=A0=C2=A0=C2=A0 The known LUID table for established/known custom HID =
sensors was
> =C2=A0=C2=A0=C2=A0 limited to sensors with "INTEL" as manufacturer. But s=
ome vendors
> such
> =C2=A0=C2=A0=C2=A0 as Lenovo also include fairly standard iio sensors (e.=
g. ambient
> light)
> =C2=A0=C2=A0=C2=A0 in their custom sensors.
>=20
> =C2=A0=C2=A0=C2=A0 Expand the known custom sensors table by a tag used fo=
r the
> platform
> =C2=A0=C2=A0=C2=A0 device name and match sensors based on the LUID as wel=
l as
> optionally
> =C2=A0=C2=A0=C2=A0 on model and manufacturer properties.
>=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Philipp Jungkamp p.jungkamp@gmx.net
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Jonathan Cameron Jonathan.Cameron@huawei.=
com
> =C2=A0=C2=A0=C2=A0 Acked-by: Srinivas Pandruvada srinivas.pandruvada@linu=
x.intel.com
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Jiri Kosina jkosina@suse.cz
>=20
> You're using raw data as part of the devname in the "real_usage"
> string, but it includes chars other than ASCII, and those chars end
> up being printed out in the ftrace log which is meant to be ASCII
> only.
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* HID-SENSOR-INT-REAL_USAGE_ID */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name =3D kasprintf(GFP_KERNEL, =
"HID-SENSOR-INT-%s",
> real_usage);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* HID-SENSOR-TAG-REAL_USAGE_ID */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name =3D kasprintf(GFP_KERNEL, =
"HID-SENSOR-%s-%s",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 match->tag, real_usage);
>=20
> My sleepgraph tool started to crash because it read these lines from
> ftrace:
>=20
> device_pm_callback_start: platform HID-SENSOR-INT-020b?.39.auto,
> parent: 001F:8087:0AC2.0003, [suspend]
> device_pm_callback_end: platform HID-SENSOR-INT-020b?.39.auto, err=3D0
>=20

Here tag is:
.tag =3D "INT",
.luid =3D "020B000000000000",


The LUID is still a string. Probably too long for a dev_name.

Even,

Please check.

Thanks.
Srinivas


> The "HID-SENSOR-INT-020b?.39.auto" string includes a binary char that
> kills
> python3 code that loops through an ascii file as such:
>=20
> =C2=A0 File "/usr/bin/sleepgraph", line 5579, in executeSuspend
> =C2=A0=C2=A0=C2=A0 for line in fp:
> =C2=A0 File "/usr/lib/python3.10/codecs.py", line 322, in decode
> =C2=A0=C2=A0=C2=A0 (result, consumed) =3D self._buffer_decode(data, self.=
errors,
> final)
> UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in position
> 1568: invalid start byte
>=20
> I've updated sleepgraph to handle random non-ascii chars, but other
> tools
> may suffer the same fate. Can you rewrite this to ensure that no
> binary
> chars make it into the devname?
>=20

