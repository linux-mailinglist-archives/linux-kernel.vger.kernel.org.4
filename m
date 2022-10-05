Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8355F5345
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJELVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJELVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:21:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF80643C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664968870; x=1696504870;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=hd++NpC3ndpFyNeT5yum/nUCxeioAdmd4KBzF0ZDFAs=;
  b=OrS8HUteK8HhVCZMkxhz5aLIr2DxLzw5ji8BH2G+fXCN8fdsRkFy5Gxa
   H8kRTGtyA9Sz5ApBbExhjU1d6Yafd11CDodLCySO4ffdKyOeR47Xe3bFw
   K1SAN/n/wN9i7Xg41zrz/sgF02jHK/GLzZ89yJ7lvkNRfC1PpQy27T8DD
   p/PlqkUzEn5Lz++bzn1ye5q8rQPWaDgUZ3IIR0u4A6wp+Dc0hDHCZ0u9v
   RqaNtFTTvj8npIOLSYD9R6ndr8d4a8kRknXzeN7QzHy+zyxB99wDFBx0U
   t3f4LURTYVAuWGBG6tzaxvJ1TskRpOdks5PMFgBCYP4p1mcAjB/Pmi8SO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="282849411"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="282849411"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 04:21:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="626545744"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="626545744"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.39.173])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 04:21:07 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>
Subject: Re: [PATCH 1/2] drm/i915/display: fix randconfig build
In-Reply-To: <4f54267f-a643-348c-ad71-4745e86d7fe1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221004102837.12181-1-jirislaby@kernel.org>
 <87mtabuahz.fsf@intel.com>
 <4f54267f-a643-348c-ad71-4745e86d7fe1@kernel.org>
Date:   Wed, 05 Oct 2022 14:21:05 +0300
Message-ID: <87zgeaqzxa.fsf@intel.com>
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

On Wed, 05 Oct 2022, Jiri Slaby <jirislaby@kernel.org> wrote:
> On 04. 10. 22, 12:52, Jani Nikula wrote:
>> On Tue, 04 Oct 2022, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
>>> When DRM_I915=3Dy and BACKLIGHT_CLASS_DEVICE=3Dm, the build fails:
>>> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_=
backlight_device_register':
>>> intel_backlight.c:(.text+0x5587): undefined reference to `backlight_dev=
ice_get_by_name'
>>>
>>> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_=
backlight_device_unregister':
>>> intel_backlight.c:(.text+0x576e): undefined reference to `backlight_dev=
ice_unregister'
>>>
>>> To fix this, use IS_REACHABLE(), not IS_ENABLED() in backlight. That is,
>>> with the above config, backlight support is disabled.
>>=20
>> So I don't want this. I'll take a patch that fixes the dependencies to
>> block DRM_I915=3Dy and BACKLIGHT_CLASS_DEVICE=3Dm. Nobody wants that com=
bo,
>> and IMO using IS_REACHABLE() is a workaround to hide a broken config
>> under the carpet.
>>=20
>> The right thing to do is
>>=20
>> config DRM_I915
>> 	depends on BACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DEVICE=3Dn.
>>=20
>> We're selecting BACKLIGHT_CLASS_DEVICE because almost everyone else is
>> too, and a combo of selecting and depending leads to circular
>> dependencies. But depending is the right fix.
>
> I'm not sure what should I do now. If I do:
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -4,6 +4,7 @@ config DRM_I915
>          depends on DRM
>          depends on X86 && PCI
>          depends on !PREEMPT_RT
> +       depends on (BACKLIGHT_CLASS_DEVICE && ACPI) ||=20
> (BACKLIGHT_CLASS_DEVICE=3Dn && ACPI=3Dn)
>          select INTEL_GTT if X86
>          select INTERVAL_TREE
>          # we need shmfs for the swappable backing store, and in particul=
ar
> @@ -21,7 +22,6 @@ config DRM_I915
>          select IRQ_WORK
>          # i915 depends on ACPI_VIDEO when ACPI is enabled
>          # but for select to work, need to select ACPI_VIDEO's=20
> dependencies, ick
> -       select BACKLIGHT_CLASS_DEVICE if ACPI
>          select INPUT if ACPI
>          select X86_PLATFORM_DEVICES if ACPI
>          select ACPI_WMI if ACPI
>
> I get:
> drivers/gpu/drm/i915/Kconfig:2:error: recursive dependency detected!
> drivers/gpu/drm/i915/Kconfig:2: symbol DRM_I915 depends on=20
> BACKLIGHT_CLASS_DEVICE
> drivers/video/backlight/Kconfig:143:    symbol BACKLIGHT_CLASS_DEVICE is=
=20
> selected by DRM_FSL_DCU
> drivers/gpu/drm/fsl-dcu/Kconfig:2:      symbol DRM_FSL_DCU depends on=20
> COMMON_CLK
> drivers/clk/Kconfig:21: symbol COMMON_CLK is selected by X86_INTEL_QUARK
> arch/x86/Kconfig:633:   symbol X86_INTEL_QUARK depends on=20
> X86_PLATFORM_DEVICES
> drivers/platform/x86/Kconfig:6: symbol X86_PLATFORM_DEVICES is selected=20
> by DRM_I915
>
>
> Those dependencies are really cumbersome :/.

Yes. They could be fixed, though [1]. IS_REACHABLE() is just band-aid.

BR,
Jani.


[1] https://lore.kernel.org/r/1413580403-16225-1-git-send-email-jani.nikula=
@intel.com

>
>> Documentation/kbuild/kconfig-language.rst:
>>=20
>>    Note:
>> 	select should be used with care. select will force
>> 	a symbol to a value without visiting the dependencies.
>> 	By abusing select you are able to select a symbol FOO even
>> 	if FOO depends on BAR that is not set.
>> 	In general use select only for non-visible symbols
>> 	(no prompts anywhere) and for symbols with no dependencies.
>> 	That will limit the usefulness but on the other hand avoid
>> 	the illegal configurations all over.
>>=20
>>=20
>> BR,
>> Jani.
>>=20
>>>
>>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: intel-gfx@lists.freedesktop.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> ---
>>>   drivers/gpu/drm/i915/display/intel_backlight.c | 2 +-
>>>   drivers/gpu/drm/i915/display/intel_backlight.h | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/g=
pu/drm/i915/display/intel_backlight.c
>>> index beba39a38c87..c1ba68796b6d 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
>>> @@ -825,7 +825,7 @@ void intel_backlight_enable(const struct intel_crtc=
_state *crtc_state,
>>>   	mutex_unlock(&dev_priv->display.backlight.lock);
>>>   }
>>>=20=20=20
>>> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>>   static u32 intel_panel_get_backlight(struct intel_connector *connecto=
r)
>>>   {
>>>   	struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev);
>>> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/g=
pu/drm/i915/display/intel_backlight.h
>>> index 339643f63897..207fe1c613d8 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_backlight.h
>>> +++ b/drivers/gpu/drm/i915/display/intel_backlight.h
>>> @@ -36,7 +36,7 @@ u32 intel_backlight_invert_pwm_level(struct intel_con=
nector *connector, u32 leve
>>>   u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u=
32 level);
>>>   u32 intel_backlight_level_from_pwm(struct intel_connector *connector,=
 u32 val);
>>>=20=20=20
>>> -#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>>   int intel_backlight_device_register(struct intel_connector *connector=
);
>>>   void intel_backlight_device_unregister(struct intel_connector *connec=
tor);
>>>   #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
>>=20

--=20
Jani Nikula, Intel Open Source Graphics Center
