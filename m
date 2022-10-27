Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE660FF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiJ0RRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiJ0RRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:17:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D6156255
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:17:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 192so2233086pfx.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zdjZv+IKq3ph1Ix4iiZ0nwCvy/5pBmnplSSKFf+POLY=;
        b=d9zSKpi6p0S91Q2V9qhJecbmYDzE3jyitR8boIIFcMct2U70ShHQqESa0PsTBoJLJm
         NjaIsFEk48yDlE3Ff88ENDHTlIxwERU9suxrHpciJg+SqYYEqWAg3m6D+TBWXiQRTZmW
         N85YdsfwBgByfbMeTO4G5aDzml9FEWJft9S6qkKvxRuyiDanjRdPVZUH1v0H3+gclbge
         aVbzdMhjEr+rksU8vO22yn+26hNJJQulcKX7L8N0PMHf41raEJ6kGIJFBrW81T6sl1UK
         M/xSY6XTN7tWqRoyvGdJdgz1tHRArwOWtGrIVxw0kFV8qahSE7e7Yf/JIBGN6RxVKDsr
         Ae/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdjZv+IKq3ph1Ix4iiZ0nwCvy/5pBmnplSSKFf+POLY=;
        b=NhuqHQN6zYzhGecCv1eZUAWkO8cnZLcqUfayzTzHOn6UfgwDy3hvta/APv12ejJa3D
         qBTs0TyS8WFM+RrzAD0bXD4hi9xa/AgC4CI6l5nF1Sts6tig4lvrGPrbefd6E/13zCUE
         zw64s0HUv8Bd1+H//7IySov8p8LBPEXp7Qc7xEU3dy8WRkDqgFJvMFIha09dqvLZDXm4
         Gfrgds1WQ7mtZfiGBrxK1u+FHUzlYRCqBRRPBee0wVpnwEGamhW38MEmXrbwGT/J6jx0
         avPaWBUHOpV12gKi1XF6YRGvYoNWd67a+r28lG2ZpNWF2FWDhonNvCoIMLE7VjbJEamZ
         M6nQ==
X-Gm-Message-State: ACrzQf3hShgWi0SKSRm7rsUhB1zainGR25mbIwHJHiV02LmENolSwmVy
        u7NI+RzR1WrWZXT4/ZEO4KlJyXZivSVFb1JonbhVuA==
X-Google-Smtp-Source: AMsMyM6C9FJi+RflmEyBNbFkvocpaOXOyAPTOIKqKeqwRQY+mzuqgIZaY9ryX4bLqiFfUG3kcd5vd1AhDTKJjw3033E=
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id
 s201-20020a632cd2000000b0041c590167d8mr42895576pgs.365.1666891019459; Thu, 27
 Oct 2022 10:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221024210953.1572998-1-gwan-gyeong.mun@intel.com>
 <87mt9kppb6.wl-ashutosh.dixit@intel.com> <Y1ercgaqQwfqt42U@ashyti-mobl2.lan>
 <87ilk7pwrw.wl-ashutosh.dixit@intel.com> <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan>
 <CAKwvOdkpQvk31zbipLDPXfsDZ8FpGHs9t-+9JfFQO85Bs4h=wg@mail.gmail.com> <877d0lxl6s.wl-ashutosh.dixit@intel.com>
In-Reply-To: <877d0lxl6s.wl-ashutosh.dixit@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Oct 2022 10:16:47 -0700
Message-ID: <CAKwvOdmVJn8HvfF9WTnOAc+HsdJ4c1Tdck8E7Caky7AoCq4ZTA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/hwmon: Fix a build error used with clang compiler
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        anshuman.gupta@intel.com, intel-gfx@lists.freedesktop.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 9:53 AM Dixit, Ashutosh
<ashutosh.dixit@intel.com> wrote:
>
> On Thu, 27 Oct 2022 09:35:24 -0700, Nick Desaulniers wrote:
> >
>
> Hi Nick,
>
> > On Tue, Oct 25, 2022 at 5:18 PM Andi Shyti <andi.shyti@linux.intel.com> wrote:
> > >
> > > Hi Ashutosh,
> > >
> > > > But I'd wait to hear from clang/llvm folks first.
> > >
> > > Yeah! Looking forward to getting some ideas :)
> >
> > Gwan-gyeong, which tree and set of configs are necessary to reproduce
> > the observed warning?
> >
> > Warnings are treated as errors, so I don't want this breaking our CI.
>
> The following or equivalent should do it:
>
> git clone https://anongit.freedesktop.org/git/drm/drm-tip
> git checkout drm-tip
>
> Kernel config:
> CONFIG_DRM_I915=m
> CONFIG_HWMON=y
>
> Files:
> drivers/gpu/drm/i915/i915_hwmon.c/.h
>
> Thanks for taking a look.

Thanks, I can repro now.

I haven't detangled the macro soup, but I noticed:

1. FIELD_PREP is defined in include/linux/bitfield.h which has the
following comment:
 18  * Mask must be a compilation time constant.

2. hwm_field_scale_and_write only has one callsite.

The following patch works:

```
diff --git a/drivers/gpu/drm/i915/i915_hwmon.c
b/drivers/gpu/drm/i915/i915_hwmon.c
index 9e9781493025..6ac29d90b92a 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat,
i915_reg_t rgadr,

 static void
 hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
-                         u32 field_msk, int nshift,
+                         int nshift,
                          unsigned int scale_factor, long lval)
 {
        u32 nval;
@@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata
*ddat, i915_reg_t rgadr,
        /* Computation in 64-bits to avoid overflow. Round to nearest. */
        nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);

-       bits_to_clear = field_msk;
-       bits_to_set = FIELD_PREP(field_msk, nval);
+       bits_to_clear = PKG_PWR_LIM_1;
+       bits_to_set = FIELD_PREP(PKG_PWR_LIM_1, nval);

        hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
                                            bits_to_clear, bits_to_set);
@@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32
attr, int chan, long val)
        case hwmon_power_max:
                hwm_field_scale_and_write(ddat,
                                          hwmon->rg.pkg_rapl_limit,
-                                         PKG_PWR_LIM_1,
                                          hwmon->scl_shift_power,
                                          SF_POWER, val);
                return 0;
```
Though I'm not sure if you're planning to add further callsites of
hwm_field_scale_and_write with different field_masks?

Alternatively, (without the above diff),

```
diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c9be1657f03d..6f40f12bcf89 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -8,6 +8,7 @@
 #define _LINUX_BITFIELD_H

 #include <linux/build_bug.h>
+#include <linux/const.h>
 #include <asm/byteorder.h>

 /*
@@ -62,7 +63,7 @@

 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
        ({                                                              \
-               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
+               BUILD_BUG_ON_MSG(!__is_constexpr(_mask),                \
                                 _pfx "mask is not constant");          \
                BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
                BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
```
will produce:
error: call to __compiletime_assert_407 declared with 'error'
attribute: FIELD_PREP: mask is not constant

I haven't tested if that change is also feasible (on top of fixing
this specific instance), but I think it might help avoid more of these
subtleties wrt. __builtin_constant_p that depende heavily on compiler,
compiler version, optimization level.
-- 
Thanks,
~Nick Desaulniers
