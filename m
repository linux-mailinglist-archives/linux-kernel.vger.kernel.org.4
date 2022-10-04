Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E35F411A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJDKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJDKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:52:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C51DFF4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664880739; x=1696416739;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=GsLBEQ+iiyq0tqzhsDbPlBVlnya42aOoxzUP/81MpLo=;
  b=cmkuQDFm3MY32J55kWLXWypke/KFmcxLfIh8zOGgbAe2KVnQkndCdDsd
   xS/iLQpJ+m3cocLexId46i2nEOsIBVibVSiH1fxy2QyytyR77w1hFn80B
   xRfAGhexLXPOTsI5Dr9KLz2fUlIdfM3VogBdDZ0ulXKNaqa8oAGzwKqUU
   WPmYBa/nKYu1q/Z5xW1hro9NU1n+O/nx8SIvqxN03/r0nEcFd+mv/Yl98
   GdhPv0zUGNa8BZTXu+7mL/G3d4F1SyeWmzkdKoA0k4/heSt/YMmclDRqj
   LQFnvEQyZCyU+QWEdlTcSVJdXpJVPt7ebCkdOi6IPaGxDZhPJHw/e5YBT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="282592905"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="282592905"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:52:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="686506525"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="686506525"
Received: from pvarla-mobl4.gar.corp.intel.com (HELO localhost) ([10.252.39.104])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 03:52:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>
Subject: Re: [PATCH 1/2] drm/i915/display: fix randconfig build
In-Reply-To: <20221004102837.12181-1-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221004102837.12181-1-jirislaby@kernel.org>
Date:   Tue, 04 Oct 2022 13:52:08 +0300
Message-ID: <87mtabuahz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
> When DRM_I915=3Dy and BACKLIGHT_CLASS_DEVICE=3Dm, the build fails:
> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_ba=
cklight_device_register':
> intel_backlight.c:(.text+0x5587): undefined reference to `backlight_devic=
e_get_by_name'
>
> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_ba=
cklight_device_unregister':
> intel_backlight.c:(.text+0x576e): undefined reference to `backlight_devic=
e_unregister'
>
> To fix this, use IS_REACHABLE(), not IS_ENABLED() in backlight. That is,
> with the above config, backlight support is disabled.

So I don't want this. I'll take a patch that fixes the dependencies to
block DRM_I915=3Dy and BACKLIGHT_CLASS_DEVICE=3Dm. Nobody wants that combo,
and IMO using IS_REACHABLE() is a workaround to hide a broken config
under the carpet.

The right thing to do is

config DRM_I915
	depends on BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=3Dn.

We're selecting BACKLIGHT_CLASS_DEVICE because almost everyone else is
too, and a combo of selecting and depending leads to circular
dependencies. But depending is the right fix.

Documentation/kbuild/kconfig-language.rst:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.


BR,
Jani.

>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/gpu/drm/i915/display/intel_backlight.c | 2 +-
>  drivers/gpu/drm/i915/display/intel_backlight.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu=
/drm/i915/display/intel_backlight.c
> index beba39a38c87..c1ba68796b6d 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -825,7 +825,7 @@ void intel_backlight_enable(const struct intel_crtc_s=
tate *crtc_state,
>  	mutex_unlock(&dev_priv->display.backlight.lock);
>  }
>=20=20
> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  static u32 intel_panel_get_backlight(struct intel_connector *connector)
>  {
>  	struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu=
/drm/i915/display/intel_backlight.h
> index 339643f63897..207fe1c613d8 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.h
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.h
> @@ -36,7 +36,7 @@ u32 intel_backlight_invert_pwm_level(struct intel_conne=
ctor *connector, u32 leve
>  u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 =
level);
>  u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u3=
2 val);
>=20=20
> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  int intel_backlight_device_register(struct intel_connector *connector);
>  void intel_backlight_device_unregister(struct intel_connector *connector=
);
>  #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */

--=20
Jani Nikula, Intel Open Source Graphics Center
