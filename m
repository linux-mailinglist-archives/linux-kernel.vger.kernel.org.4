Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66422699158
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBPKdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBPKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E653559
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676543595; x=1708079595;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xewz+sS+QiFWv/ST2WtJNHlJXrBcta3cxPe5gr9V6N8=;
  b=VOlt2ckNqQvEpaadrKiUZs14mHe0tm2QKqdw70335htCw2l9/4QE5ZYl
   1O1SjpWqVX0n5dgvZuPBT4wMarakug1ENZB0zfRqsSs4NSRE3UYPJHrjk
   CDZpuang1cHUyWyy64hVOcO1qxII7PvuAzD7kvg+BHfkT3Fju2ZVLEvZ/
   5HNYU0LpeLHr03bQQmBRwoQZSA6IFkZv/SlchDu/9VPm3sJKdLdM9MCFR
   PwfrBDOjnzeNxYDWIwGfdU9Bt2ogt/q5L4dVbSAEmJ4YhDS/7FIAWfuzU
   q40/unViEwCZX7jR0yO9Y08wXZxZTqPc3j7KvwcLTWGPgoh67Y6+2c09h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="417906727"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="417906727"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 02:33:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="702505653"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="702505653"
Received: from aaronov-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.37.86])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 02:33:10 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] drm/i915: Make kobj_type structures constant
In-Reply-To: <20230216-kobj_type-i915-v1-1-ca65c9b93518@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230216-kobj_type-i915-v1-1-ca65c9b93518@weissschuh.net>
Date:   Thu, 16 Feb 2023 12:33:07 +0200
Message-ID: <87sff5293w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/gt/intel_gt_sysfs.c | 2 +-
>  drivers/gpu/drm/i915/gt/sysfs_engines.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c b/drivers/gpu/drm/i=
915/gt/intel_gt_sysfs.c
> index 9486dd3bed99..df15b17caf89 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
> @@ -71,7 +71,7 @@ static void kobj_gt_release(struct kobject *kobj)
>  {
>  }
>=20=20
> -static struct kobj_type kobj_gt_type =3D {
> +static const struct kobj_type kobj_gt_type =3D {
>  	.release =3D kobj_gt_release,
>  	.sysfs_ops =3D &kobj_sysfs_ops,
>  	.default_groups =3D id_groups,
> diff --git a/drivers/gpu/drm/i915/gt/sysfs_engines.c b/drivers/gpu/drm/i9=
15/gt/sysfs_engines.c
> index f2d9858d827c..b5e0fe5dbf6c 100644
> --- a/drivers/gpu/drm/i915/gt/sysfs_engines.c
> +++ b/drivers/gpu/drm/i915/gt/sysfs_engines.c
> @@ -421,7 +421,7 @@ static void kobj_engine_release(struct kobject *kobj)
>  	kfree(kobj);
>  }
>=20=20
> -static struct kobj_type kobj_engine_type =3D {
> +static const struct kobj_type kobj_engine_type =3D {
>  	.release =3D kobj_engine_release,
>  	.sysfs_ops =3D &kobj_sysfs_ops
>  };
>
> ---
> base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
> change-id: 20230216-kobj_type-i915-886bebc36129
>
> Best regards,

--=20
Jani Nikula, Intel Open Source Graphics Center
