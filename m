Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E99737CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjFUHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjFUHiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:38:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE91988
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687333129; x=1718869129;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=z9Sj3YeuNpGi+kC2OKSHhpUo2+Q4p5ltLVJ8mQ7FYcs=;
  b=mMgpHhcsQHqS6Pk3ARJvCBHCoTplVjrOT0zBjoclVaEhPZGsNaRr0KRh
   5QZE/aaDZJsHnT9hM487lOGzEejTNGuLiV4BRiOS0HHOBSI+zC46Lc/aa
   4R1fwFMH7abSe1gfevUP0Bwaoks9o/b2B5/+7oBmgJqOHSpFzABJcWu17
   8BKS1J1m9aLJPHREs2qvD5s+PcXG2CATIOhgoyWEoIPpV9iEHO2hs4Fmu
   BEUJFcTcfgGxYWliEMjTA4+3Zz0VNh45X5EPt7AecwL4XHLMmHUHhdm6s
   AIcMH5kJ/8t2NQyoHh3ulxDr8aBCBzki6b7C514VejJmoaBJ6W0drVASP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389532826"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="389532826"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888553416"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="888553416"
Received: from dafnaroz-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.63.122])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:38:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Subject: Re: [RFC PATCH v3 4/4] drm/i915: Implement DRM_IOCTL_GET_RESET
In-Reply-To: <20230621005719.836857-5-andrealmeid@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230621005719.836857-1-andrealmeid@igalia.com>
 <20230621005719.836857-5-andrealmeid@igalia.com>
Date:   Wed, 21 Jun 2023 10:38:06 +0300
Message-ID: <87ilbhfeox.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> Implement get_reset ioctl for i915.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c    | 18 ++++++++++++++++++
>  drivers/gpu/drm/i915/gem/i915_gem_context.h    |  2 ++
>  .../gpu/drm/i915/gem/i915_gem_context_types.h  |  2 ++
>  drivers/gpu/drm/i915/i915_driver.c             |  2 ++
>  4 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_context.c
> index 9a9ff84c90d7..fba8c9bbc7e9 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -1666,6 +1666,8 @@ i915_gem_create_context(struct drm_i915_private *i9=
15,
>  		ctx->uses_protected_content =3D true;
>  	}
>=20=20
> +	ctx->dev_reset_counter =3D i915_reset_count(&i915->gpu_error);
> +
>  	trace_i915_context_create(ctx);
>=20=20
>  	return ctx;
> @@ -2558,6 +2560,22 @@ int i915_gem_context_reset_stats_ioctl(struct drm_=
device *dev,
>  	return 0;
>  }
>=20=20
> +int i915_gem_get_reset(struct drm_file *filp, struct drm_device *dev,
> +		       struct drm_get_reset *reset)
> +{
> +	struct i915_gem_context *ctx;
> +
> +	ctx =3D i915_gem_context_lookup(file->driver_priv, reset->ctx_id);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	reset->dev_reset_count =3D i915_reset_count(&i915->gpu_error) - ctx->de=
v_reset_count;
> +	reset->ctx_reset_count =3D ctx->guilty_count;
> +
> +	i915_gem_context_put(ctx);

Usually return is preceded by a blank line.

> +	return 0;
> +}
> +
>  /* GEM context-engines iterator: for_each_gem_engine() */
>  struct intel_context *
>  i915_gem_engines_iter_next(struct i915_gem_engines_iter *it)
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.h b/drivers/gpu/dr=
m/i915/gem/i915_gem_context.h
> index e5b0f66ea1fe..9ee119d8123f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.h
> @@ -138,6 +138,8 @@ int i915_gem_context_setparam_ioctl(struct drm_device=
 *dev, void *data,
>  				    struct drm_file *file_priv);
>  int i915_gem_context_reset_stats_ioctl(struct drm_device *dev, void *dat=
a,
>  				       struct drm_file *file);
> +int i915_gem_get_reset(struct drm_file *file_priv, struct drm_device *de=
v,
> +		       struct drm_get_reset *reset);
>=20=20
>  struct i915_gem_context *
>  i915_gem_context_lookup(struct drm_i915_file_private *file_priv, u32 id);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/=
gpu/drm/i915/gem/i915_gem_context_types.h
> index cb78214a7dcd..2e4cf0f0d3dc 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> @@ -414,6 +414,8 @@ struct i915_gem_context {
>  		/** @engines: list of stale engines */
>  		struct list_head engines;
>  	} stale;
> +
> +	uint64_t dev_reset_counter;

u64 please. i915 only uses the kernel fixed types.

Please do wait for review on the actual content before reposting.

BR,
Jani.

>  };
>=20=20
>  #endif /* __I915_GEM_CONTEXT_TYPES_H__ */
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i9=
15_driver.c
> index 97244541ec28..640304141ada 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1805,6 +1805,8 @@ static const struct drm_driver i915_drm_driver =3D {
>  	.postclose =3D i915_driver_postclose,
>  	.show_fdinfo =3D i915_drm_client_fdinfo,
>=20=20
> +	.get_reset =3D i915_gem_get_reset,
> +
>  	.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
>  	.gem_prime_import =3D i915_gem_prime_import,

--=20
Jani Nikula, Intel Open Source Graphics Center
