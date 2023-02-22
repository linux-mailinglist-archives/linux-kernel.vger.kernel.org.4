Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF32669FF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjBVXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBVXOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:14:41 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E4AB;
        Wed, 22 Feb 2023 15:14:39 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1722c48a773so8863237fac.2;
        Wed, 22 Feb 2023 15:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWtWIYTGNMyDOMqqOh9t6zGvy0m9O4dPql9gjsk0/Zw=;
        b=iIdpgNb0c5q4M2dQOzDGGvR++HfQmC46LKRbtsCGsETjgQ5P6n/Vf5mgNZ2ejrYv3a
         eEpk4mh8B5DHrozdEgeMsVa9C7Ed8BQN74vvcsGxcnSLMqj1eKSnpYKyyVVuf/u6tC8L
         sOf+z+1LUQPxP9eRg20srtpuodp5MWnxEWcnqsAMFzaXtCBQal/Q/4c8C1KZtaThZhUJ
         kVkNlc2+3BDOKmgVATFBcM/OKSyjE+6DaFc6uBM4xekagRxjs1b7kjfoMxqoYIL42qEJ
         pjRxxEMjnrHrR52ho/sMNS2dW5P0ReAq0ZWC/FHX3DxrBxAo+3xG25zsH0ZrR8p6Q9qv
         uYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWtWIYTGNMyDOMqqOh9t6zGvy0m9O4dPql9gjsk0/Zw=;
        b=sYOTs/h1zULYr900Avug8Nk3hu23VVBkgksQLNHX9+epLQ7pTWSQkliIpmx5z67xxy
         u9ixZ4cRbacBRPhsY0HqSqFUg2QfIEZrL172g6IvkySifF3y8Xgei1/wA+GchO4Z5Jug
         c17YkEoQIcziT6lHPBtAyPNSH+Ym9AD0HIWBFUxQSemkHQ6VTUqHeV0L2dqw6tzN2wna
         mC0ngtEAQHunD8bDFPUBVEMIY8f15sLTMykiGe10FV3S2JEwbo8lACX7oa5bKlb/Ib13
         eDV5a59BAnwfUoAAJYGPoHSAWQiTjUyi/gRPEZautMI0DxPDWeausoD2uNQipc7q2V+B
         iXng==
X-Gm-Message-State: AO0yUKWgaDSb8BCxyHsfnjzkvKmBbGwQFW5vwe9FrHlQIMMKK40S+lzl
        H2+BZRrV8KnToUr2nko2HJPd8HpSGGd9karn6hc=
X-Google-Smtp-Source: AK7set/vSOhCsjA3k/BmRsMD07qeudjbB6KHmncgnsdQiHmX7AqvCxii7B6mfmEHNkUURYYhVKOWgKR+7Kt+sVEKhwo=
X-Received: by 2002:a05:6870:808d:b0:16e:8a56:d0d2 with SMTP id
 q13-20020a056870808d00b0016e8a56d0d2mr1457790oab.38.1677107678554; Wed, 22
 Feb 2023 15:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Feb 2023 15:14:27 -0800
Message-ID: <CAF6AEGvFN-9_cr2EyGxuW5NVgk8CA99rVuv_Y80M+gvMviPcuA@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>, mikita.lipski@amd.com,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        harry.wentland@amd.com,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 3:12 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrot=
e:
>
> The stuff never really worked, and leads to lots of fun because it
> out-of-order frees atomic states. Which upsets KASAN, among other
> things.
>
> For async updates we now have a more solid solution with the
> ->atomic_async_check and ->atomic_async_commit hooks. Support for that
> for msm and vc4 landed. nouveau and i915 have their own commit
> routines, doing something similar.
>
> For everyone else it's probably better to remove the use-after-free
> bug, and encourage folks to use the async support instead. The
> affected drivers which register a legacy cursor plane and don't either
> use the new async stuff or their own commit routine are: amdgpu,
> atmel, mediatek, qxl, rockchip, sti, sun4i, tegra, virtio, and vmwgfx.
>
> Inspired by an amdgpu bug report.
>
> v2: Drop RFC, I think with amdgpu converted over to use
> atomic_async_check/commit done in
>
> commit 674e78acae0dfb4beb56132e41cbae5b60f7d662
> Author: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Date:   Wed Dec 5 14:59:07 2018 -0500
>
>     drm/amd/display: Add fast path for cursor plane updates
>
> we don't have any driver anymore where we have userspace expecting
> solid legacy cursor support _and_ they are using the atomic helpers in
> their fully glory. So we can retire this.
>
> v3: Paper over msm and i915 regression. The complete_all is the only
> thing missing afaict.
>
> v4: Fixup i915 fixup ...
>
> v5: Unallocate the crtc->event in msm to avoid hitting a WARN_ON in
> dpu_crtc_atomic_flush(). This is a bit a hack, but simplest way to
> untangle this all. Thanks to Abhinav Kumar for the debug help.

Hmm, are you sure about that double-put?

[  +0.501263] ------------[ cut here ]------------
[  +0.000032] refcount_t: underflow; use-after-free.
[  +0.000033] WARNING: CPU: 6 PID: 1854 at lib/refcount.c:28
refcount_warn_saturate+0xf8/0x134
[  +0.000043] Modules linked in: uinput rfcomm algif_hash
algif_skcipher af_alg veth venus_dec venus_enc xt_cgroup xt_MASQUERADE
qcom_spmi_temp_alarm qcom_spmi_adc_tm5 qcom_spmi_adc5 qcom_vadc_common
cros_ec_typec typec 8021q hci_uart btqca qcom_stats venus_core
coresight_etm4x coresight_tmc snd_soc_lpass_sc7180
coresight_replicator coresight_funnel coresight snd_soc_sc7180
ip6table_nat fuse ath10k_snoc ath10k_core ath mac80211 iio_trig_sysfs
bluetooth cros_ec_sensors cfg80211 cros_ec_sensors_core
industrialio_triggered_buffer kfifo_buf ecdh_generic ecc
cros_ec_sensorhub lzo_rle lzo_compress r8153_ecm cdc_ether usbnet
r8152 mii zram hid_vivaldi hid_google_hammer hid_vivaldi_common joydev
[  +0.000189] CPU: 6 PID: 1854 Comm: DrmThread Not tainted
5.15.93-16271-g5ecce40dbcd4 #46
cf9752a1c9e5b13fd13216094f52d77fa5a5f8f3
[  +0.000016] Hardware name: Google Wormdingler rev1+ INX panel board (DT)
[  +0.000008] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  +0.000013] pc : refcount_warn_saturate+0xf8/0x134
[  +0.000011] lr : refcount_warn_saturate+0xf8/0x134
[  +0.000011] sp : ffffffc012e43930
[  +0.000008] x29: ffffffc012e43930 x28: ffffff80d31aa300 x27: 000000000000=
024e
[  +0.000017] x26: 00000000000003bd x25: 0000000000000040 x24: 000000000000=
0040
[  +0.000014] x23: ffffff8083eb1000 x22: 0000000000000002 x21: ffffff80845b=
c800
[  +0.000013] x20: 0000000000000040 x19: ffffff80d0cecb00 x18: 000000006001=
4024
[  +0.000012] x17: 0000000000000000 x16: 000000000000003c x15: ffffffd97e21=
a1c0
[  +0.000012] x14: 0000000000000003 x13: 0000000000000004 x12: 000000000000=
0001
[  +0.000014] x11: c0000000ffffdfff x10: ffffffd97f560f50 x9 : 5749cdb40355=
0d00
[  +0.000014] x8 : 5749cdb403550d00 x7 : 0000000000000000 x6 : 372e31332020=
205b
[  +0.000012] x5 : ffffffd97f7b8b24 x4 : 0000000000000000 x3 : ffffffc012e4=
3588
[  +0.000013] x2 : ffffffc012e43590 x1 : 00000000ffffdfff x0 : 000000000000=
0026
[  +0.000014] Call trace:
[  +0.000008]  refcount_warn_saturate+0xf8/0x134
[  +0.000013]  drm_crtc_commit_put+0x54/0x74
[  +0.000013]  __drm_atomic_helper_plane_destroy_state+0x64/0x68
[  +0.000013]  dpu_plane_destroy_state+0x24/0x3c
[  +0.000017]  drm_atomic_state_default_clear+0x13c/0x2d8
[  +0.000015]  __drm_atomic_state_free+0x88/0xa0
[  +0.000015]  drm_atomic_helper_update_plane+0x158/0x188
[  +0.000014]  __setplane_atomic+0xf4/0x138
[  +0.000012]  drm_mode_cursor_common+0x2e8/0x40c
[  +0.000009]  drm_mode_cursor_ioctl+0x48/0x70
[  +0.000008]  drm_ioctl_kernel+0xe0/0x158
[  +0.000014]  drm_ioctl+0x214/0x480
[  +0.000012]  __arm64_sys_ioctl+0x94/0xd4
[  +0.000010]  invoke_syscall+0x4c/0x100
[  +0.000013]  do_el0_svc+0xa4/0x168
[  +0.000012]  el0_svc+0x20/0x50
[  +0.000009]  el0t_64_sync_handler+0x20/0x110
[  +0.000008]  el0t_64_sync+0x1a4/0x1a8
[  +0.000010] ---[ end trace 35bb2d245a684c9a ]---


BR,
-R



> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maxime Ripard <maxime@cerno.tech>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D199425
> References: https://lore.kernel.org/all/20220221134155.125447-9-maxime@ce=
rno.tech/
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D199425
> Cc: Maxime Ripard <maxime@cerno.tech>
> Tested-by: Maxime Ripard <maxime@cerno.tech>
> Cc: mikita.lipski@amd.com
> Cc: Michel D=C3=A4nzer <michel@daenzer.net>
> Cc: harry.wentland@amd.com
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: "Ville Syrj=C3=A4l=C3=A4" <ville.syrjala@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c          | 13 -------------
>  drivers/gpu/drm/i915/display/intel_display.c | 14 ++++++++++++++
>  drivers/gpu/drm/msm/msm_atomic.c             | 15 +++++++++++++++
>  3 files changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index d579fd8f7cb8..f6b4c3a00684 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1587,13 +1587,6 @@ drm_atomic_helper_wait_for_vblanks(struct drm_devi=
ce *dev,
>         int i, ret;
>         unsigned int crtc_mask =3D 0;
>
> -        /*
> -         * Legacy cursor ioctls are completely unsynced, and userspace
> -         * relies on that (by doing tons of cursor updates).
> -         */
> -       if (old_state->legacy_cursor_update)
> -               return;
> -
>         for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, ne=
w_crtc_state, i) {
>                 if (!new_crtc_state->active)
>                         continue;
> @@ -2244,12 +2237,6 @@ int drm_atomic_helper_setup_commit(struct drm_atom=
ic_state *state,
>                         continue;
>                 }
>
> -               /* Legacy cursor updates are fully unsynced. */
> -               if (state->legacy_cursor_update) {
> -                       complete_all(&commit->flip_done);
> -                       continue;
> -               }
> -
>                 if (!new_crtc_state->event) {
>                         commit->event =3D kzalloc(sizeof(*commit->event),
>                                                 GFP_KERNEL);
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 3479125fbda6..2454451fcf95 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -7651,6 +7651,20 @@ static int intel_atomic_commit(struct drm_device *=
dev,
>                 intel_runtime_pm_put(&dev_priv->runtime_pm, state->wakere=
f);
>                 return ret;
>         }
> +
> +       /*
> +        * FIXME: Cut over to (async) commit helpers instead of hand-roll=
ing
> +        * everything.
> +        */
> +       if (state->base.legacy_cursor_update) {
> +               struct intel_crtc_state *new_crtc_state;
> +               struct intel_crtc *crtc;
> +               int i;
> +
> +               for_each_new_intel_crtc_in_state(state, crtc, new_crtc_st=
ate, i)
> +                       complete_all(&new_crtc_state->uapi.commit->flip_d=
one);
> +       }
> +
>         intel_shared_dpll_swap_state(state);
>         intel_atomic_track_fbs(state);
>
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_a=
tomic.c
> index 1686fbb611fd..b7151767b567 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -189,6 +189,19 @@ void msm_atomic_commit_tail(struct drm_atomic_state =
*state)
>         bool async =3D kms->funcs->vsync_time &&
>                         can_do_async(state, &async_crtc);
>
> +       /*
> +        * FIXME: Convert to async plane helpers and remove the various h=
acks to
> +        * keep the old legacy_cursor_way of doing async commits working =
for the
> +        * dpu code, like the expectation that these don't have a crtc->e=
vent.
> +        */
> +       if (async) {
> +               /* both ->event itself and the pointer hold a reference! =
*/
> +               drm_crtc_commit_put(async_crtc->state->commit);
> +               drm_crtc_commit_put(async_crtc->state->commit);
> +               kfree(async_crtc->state->event);
> +               async_crtc->state->event =3D NULL;
> +       }
> +
>         trace_msm_atomic_commit_tail_start(async, crtc_mask);
>
>         kms->funcs->enable_commit(kms);
> @@ -222,6 +235,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *=
state)
>                 /* async updates are limited to single-crtc updates: */
>                 WARN_ON(crtc_mask !=3D drm_crtc_mask(async_crtc));
>
> +               complete_all(&async_crtc->state->commit->flip_done);
> +
>                 /*
>                  * Start timer if we don't already have an update pending
>                  * on this crtc:
> --
> 2.39.0
>
