Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172BC6B10D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCHSNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCHSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:13:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152753669C;
        Wed,  8 Mar 2023 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678299193; x=1709835193;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XGDiXvIFElyNZuTg+iCZX3wGMZQziuYEnraWMH5AgVk=;
  b=I0rSCgERsKlT+kKk/0mnnFBeB1dGcwZ3lQUzrA3adBINobhxQm8iD6gI
   E9QovygpHAHMpiDSsxKKE3hYRSyvc+Si0CdhTplO6HHx9zE2G6dJ9o+gd
   nlMFqkaYW5iXHW3ya1fFcUCoTvCTi5rdopUSOSIC7ZodKz+5oocbcKWiM
   8M0GCjOcHGdo/FBoOJWNMx2TV8o+sR2AQzEwhjJn+sroccX7JohmWVhKG
   q4bIjOc70SfnB8y4qQAWhGgkmybuMXg+Phlty8jaHJfZx1OsLgev9OvxH
   TDLZXmLZbWxyvxn9iZzC2X+TaVluUjtjEt/jPXnSC2yOSZP3TzD8LauNx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320064720"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="320064720"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="677079806"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="677079806"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2023 10:12:20 -0800
Received: from madesina-mobl.amr.corp.intel.com (madesina-mobl.amr.corp.intel.com [10.212.172.13])
        by linux.intel.com (Postfix) with ESMTP id 73CBB58097C;
        Wed,  8 Mar 2023 10:12:20 -0800 (PST)
Message-ID: <702721b279dd864db1b8ea468136b96075df3994.camel@linux.intel.com>
Subject: Re: [PATCH linux-next 2/3] drivers/platform/x86/intel: fix a memory
 leak in intel_vsec_add_aux
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Mar 2023 10:12:20 -0800
In-Reply-To: <20230308135538.479223-2-dzm91@hust.edu.cn>
References: <20230308135538.479223-1-dzm91@hust.edu.cn>
         <20230308135538.479223-2-dzm91@hust.edu.cn>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

Thanks for your patch. Do cc the mailing list next time.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

On Wed, 2023-03-08 at 21:55 +0800, Dongliang Mu wrote:
> The first error handling code in intel_vsec_add_aux misses the
> deallocation of intel_vsec_dev->resource.
>=20
> Fix this by adding kfree(intel_vsec_dev->resource) in the error handling
> code.
>=20
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> =C2=A0drivers/platform/x86/intel/vsec.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/platform/x86/intel/vsec.c
> b/drivers/platform/x86/intel/vsec.c
> index 13decf36c6de..2311c16cb975 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -154,6 +154,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct d=
evice
> *parent,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ida_alloc(intel_v=
sec_dev->ida, GFP_KERNEL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&vsec_ida_lo=
ck);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev->resource);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

