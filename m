Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFD5B4326
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIIXn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiIIXnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:43:24 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F6DBD121
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:43:23 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id s192so1500772vkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yM/kvhJdsI8NBo5uNMFm8JlRP3HNMGQbZs8fTKlnEQM=;
        b=TS4swxQjHiLEbHAj3vKqdkMS1ch47fEWIsqb2o3dZdeDVdjCQyiQsRifCw0sWVOuXo
         x40vLFFVCjzDimP/9hUK/X98obdnxxdbKibUweQAeRGndm91NxkxvdcMBAgwchLbw8D8
         svly7WfSSESy4mWTg8k65fzYcIaQij+HSNhVFrkZ0R2CiRA9Ak3aOI1WSza2CdXKht9U
         x4MupFXFIQ7cs5jRSTDBf9Yjc5VTT/uZhHupLi2Xchv3e0D0ZPSWzJrgvMD0IMuYsiWf
         NnocaNi6QRN08Bu1qGQuRHzqamNKxC3n+xsOY2Al30rx60Nho4l65S300AWLZtNvXOK/
         hKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yM/kvhJdsI8NBo5uNMFm8JlRP3HNMGQbZs8fTKlnEQM=;
        b=afvAmrL1lzWbiIWBYzlBmeFnHOJew4joOdk92PiSRDmF2+SiJZCeCCogoIDva1auZU
         kKyCGqWOumy3tWciXXBk5XpABGqjDzOKfp8k45V+CsXCthiJklzeYlXoOvwKDJ+I1laz
         f/HnC6vt8jq2N3uqYaDccp9YnyfbUKCyOxMDwqdBe1XRtFB1YqAwHLvuvNzNtaA0H5Pk
         kXHK0OEPdB9d2zYyA6L1CqyqOfmaPxs8F0X1TL32+xvjJLLEHYUVhigiZ8lHMGkHFzDQ
         gYvacs/0+PiQcwh7pRb+GcRTpwYJcUj+1iPP1XRnN8bVJOubLelpLtmzN02weFJm0pc0
         JCGQ==
X-Gm-Message-State: ACgBeo1QiFOFCkil5E3M/f14QkJG+/j4CHUtQQQSvl0RUiR+R3HRfTOk
        26eo/Nt/cPs844Rlji38nHwMcWIpm/ewjdAEjj4=
X-Google-Smtp-Source: AA6agR7LGX14G3rAUr9BzeWCa0Er0i9E3ZBlG/vg0BrB9buV8rSqHWfvPInCBO6KJneE9thG9epmo6YcJmkLknluQBY=
X-Received: by 2002:a1f:2ad4:0:b0:38c:5a9c:2d98 with SMTP id
 q203-20020a1f2ad4000000b0038c5a9c2d98mr5862449vkq.24.1662767002164; Fri, 09
 Sep 2022 16:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220904214134.408619-1-jim.cromie@gmail.com> <20220904214134.408619-29-jim.cromie@gmail.com>
 <Yxg86v7UsB8jtyYi@phenom.ffwll.local>
In-Reply-To: <Yxg86v7UsB8jtyYi@phenom.ffwll.local>
From:   jim.cromie@gmail.com
Date:   Fri, 9 Sep 2022 17:42:55 -0600
Message-ID: <CAJfuBxx_MnNbC=HDypKvG-aLxRu_k_jcPCwWqAwC+ghqjb9NmQ@mail.gmail.com>
Subject: Re: [PATCH v6 28/57] drm_print: refine drm_debug_enabled for jump-label
To:     Jim Cromie <jim.cromie@gmail.com>, Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, robdclark@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 12:40 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sun, Sep 04, 2022 at 03:41:05PM -0600, Jim Cromie wrote:
> > In order to use dynamic-debug's jump-label optimization in drm-debug,
> > its clarifying to refine drm_debug_enabled into 3 uses:
> >
> > 1.   drm_debug_enabled - legacy, public
> > 2. __drm_debug_enabled - optimized for dyndbg jump-label enablement.
> > 3.  _drm_debug_enabled - pr_debug instrumented, observable
> >
> > 1. The legacy version always checks the bits.
> >
> > 2. is privileged, for use by __drm_dbg(), __drm_dev_dbg(), which do an
> > early return unless the category is enabled.  For dyndbg builds, debug
> > callsites are selectively "pre-enabled", so __drm_debug_enabled()
> > short-circuits to true there.  Remaining callers of 1 may be able to
> > use 2, case by case.
> >
> > 3. is 1st wrapped in a macro, with a pr_debug, which reports each
> > usage in /proc/dynamic_debug/control, making it observable in the
> > logs.  The macro lets the pr_debug see the real caller, not an inline
> > function.
> >
> > When plugged into 1, 3 identified ~10 remaining callers of the
> > function, leading to the follow-on cleanup patch, and would allow
> > activating the pr_debugs, estimating the callrate, and the potential
> > savings by using the wrapper macro.  It is unused ATM, but it fills
> > out the picture.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> So instead of having 3 here as a "you need to hack it in to see what
> should be converted" I have a bit a different idea: Could we make the
> public version also a dyndbg callsite (like the printing wrappers), but
> instead of a dynamic call we'd have a dynamically fixed value we get out?
> I think that would take care of everything you have here as an open.
>
> Otherwise I'd just drop 3 for the series we're going to merge.
> -Daniel
>

OK - So here it is in use again,  with  modules drm amdgpu i915 loaded + deps

:#> grep todo /proc/dynamic_debug/control
drivers/gpu/drm/drm_edid_load.c:178 [drm]edid_load =_ "todo: maybe
avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:410 [drm]drm_crtc_accurate_vblank_count
=_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:787
[drm]drm_crtc_vblank_helper_get_vblank_timestamp_internal =_ "todo:
maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:1491 [drm]drm_vblank_restore =_ "todo:
maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:1433 [drm]drm_vblank_enable =_ "todo:
maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_plane.c:2168 [drm]drm_mode_setplane =_ "todo:
maybe avoid via dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:1359
[drm_display_helper]drm_dp_mst_wait_tx_reply =_ "todo: maybe avoid via
dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:2864
[drm_display_helper]process_single_tx_qlock =_ "todo: maybe avoid via
dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:2909
[drm_display_helper]drm_dp_queue_down_tx =_ "todo: maybe avoid via
dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:1686
[drm_display_helper]drm_dp_mst_update_slots =_ "todo: maybe avoid via
dyndbg\n"
drivers/gpu/drm/i915/display/intel_dp.c:1111
[i915]intel_dp_print_rates =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_backlight.c:5434
[i915]cnp_enable_backlight =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_backlight.c:5459
[i915]intel_backlight_device_register =_ "todo: maybe avoid via
dyndbg\n"
drivers/gpu/drm/i915/display/intel_opregion.c:43
[i915]intel_opregion_notify_encoder =_ "todo: maybe avoid via
dyndbg\n"
drivers/gpu/drm/i915/display/intel_opregion.c:53
[i915]asle_set_backlight =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_bios.c:1088
[i915]intel_bios_is_dsi_present =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_display_debugfs.c:6153
[i915]i915_drrs_ctl_set =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/intel_pcode.c:26 [i915]snb_pcode_read =_ "todo:
maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/i915_getparam.c:785 [i915]i915_getparam_ioctl =_
"todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:282
[amdgpu]vcn_v2_5_process_interrupt =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:433
[amdgpu]vcn_v2_0_process_interrupt =_ "todo: maybe avoid via dyndbg\n"

w/o actually looking, the vblank debug could be called frequently.
I'll build on my amdgpu box to run on real hardware.

And Im inclined to restore the instrumented version (with the "todo:")
care to suggest a better message than "maybe avoid" ?
