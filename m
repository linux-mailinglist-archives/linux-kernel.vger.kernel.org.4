Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643F66D4D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjDCQD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjDCQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:03:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD8D1BF0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:03:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d8so17798268pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680537803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8FCpB8VyTDa7xGIymJSP6quiMHLu0BKl13MUGC5tEo=;
        b=gOhjFd7SdsYOhqpl/CalWTPCh/GEwqqpFOM9QKtFC2do73lAMrnxi1lJQEbeMeWmXf
         sUZ7UAcq4ZydjNz/uEwPa9WUHGP+YqJ04RdoI5sVtL7Kgm80g76twyR5vidufyKXX0tc
         h+e1NbzxsMTqKQT7MUZ839V2blta7bm38J+LJ6fdDEP24FRue934eF2iz37D7GfZX7nU
         8th9FGDbvuZTE64Q79+RCO+z8uenbHRHTkaEouHkcOej1BLAyrCJnIgmXxLWY9vaVA/6
         7JOXhIAwfNNCIQS8z4t8BEaIpibn3alFpg5zRQG7gGCLXEFfxWjsJKWzhZ4TsbvvrSMl
         m85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8FCpB8VyTDa7xGIymJSP6quiMHLu0BKl13MUGC5tEo=;
        b=xq+rQu+mAVwqIfNLoth3lNCL1mC5vzJPdUtd+Ki9rFJFF+MpX72PXpqjLSAh5Xmwt3
         R+/TWQ9oWYjcukqBqd/rmekC5oYDNsgYBfnPkiCSiC/xKMuCzvGgXS6mSBXgrf7bvYF2
         cjLyj3vLvkZCbkdNYngyzfbqmoRQX9JfZuOQl2Uan+VhWet3x2d7JF8hJ4sgDB+3vwpt
         PyS+XeX9QMxeFoGxN+NYmva8OXVfMutf7biCXd4FTSs0FrJkY06Qi2U57TYDKo9NcgR9
         BgWH7xLbprcfeIKmsqLtVeauioTcCZ8JFbTCaNh0LpFhqtk60/q/qaoyxXN229B6OVdo
         aFOA==
X-Gm-Message-State: AAQBX9dq3N1lzm5EP//XRQ1RCwpDxAIiTHxPxHyJMH/4RjLbkSYfNfPQ
        6KhjTFmxcAcF306kL0QpwEbIXPJGluk=
X-Google-Smtp-Source: AKy350YbeUY426zgKjrmIxAH6Cu9UU4/ZLgkV7KRrsPLXo4+cjKIvkNL/SepWMMHEKyqIN6YO54nKw==
X-Received: by 2002:aa7:950d:0:b0:625:e728:4c5f with SMTP id b13-20020aa7950d000000b00625e7284c5fmr36478928pfp.22.1680537803214;
        Mon, 03 Apr 2023 09:03:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id z15-20020aa791cf000000b006237b9c1f14sm7115336pfa.121.2023.04.03.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:03:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/vblank: Fix for drivers that do not drm_vblank_init()
Date:   Mon,  3 Apr 2023 09:03:14 -0700
Message-Id: <20230403160314.1210533-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This should fix a crash that was reported on ast (and possibly other
drivers which do not initialize vblank).

   fbcon: Taking over console
   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000074
   Mem abort info:
     ESR = 0x0000000096000004
     EC = 0x25: DABT (current EL), IL = 32 bits
     SET = 0, FnV = 0
     EA = 0, S1PTW = 0
     FSC = 0x04: level 0 translation fault
   Data abort info:
     ISV = 0, ISS = 0x00000004
     CM = 0, WnR = 0
   user pgtable: 4k pages, 48-bit VAs, pgdp=0000080009d16000
   [0000000000000074] pgd=0000000000000000, p4d=0000000000000000
   Internal error: Oops: 0000000096000004 [#1] SMP
   Modules linked in: ip6table_nat tun nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr sunrpc binfmt_misc vfat fat xfs snd_usb_audio snd_hwdep snd_usbmidi_lib snd_seq snd_pcm snd_rawmidi snd_timer snd_seq_device snd soundcore joydev mc ipmi_ssif ipmi_devintf ipmi_msghandler arm_spe_pmu arm_cmn arm_dsu_pmu arm_dmc620_pmu cppc_cpufreq loop zram crct10dif_ce polyval_ce nvme polyval_generic ghash_ce sbsa_gwdt igb nvme_core ast nvme_common i2c_algo_bit xgene_hwmon gpio_dwapb scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables dm_multipath fuse
   CPU: 12 PID: 469 Comm: kworker/12:1 Not tainted 6.3.0-rc2-00008-gd39e48ca80c0 #1
   Hardware name: ADLINK AVA Developer Platform/AVA Developer Platform, BIOS TianoCore 2.04.100.07 (SYS: 2.06.20220308) 09/08/2022
   Workqueue: events fbcon_register_existing_fbs
   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : drm_crtc_next_vblank_start+0x2c/0x98
   lr : drm_atomic_helper_wait_for_fences+0x90/0x240
   sp : ffff80000d583960
   x29: ffff80000d583960 x28: ffff07ff8fc187b0 x27: 0000000000000000
   x26: ffff07ff99c08c00 x25: 0000000000000038 x24: ffff07ff99c0c000
   x23: 0000000000000001 x22: 0000000000000038 x21: 0000000000000000
   x20: ffff07ff9640a280 x19: 0000000000000000 x18: ffffffffffffffff
   x17: 0000000000000000 x16: ffffb24d2eece1c0 x15: 0000003038303178
   x14: 3032393100000048 x13: 0000000000000000 x12: 0000000000000000
   x11: 0000000000000000 x10: 0000000000000000 x9 : ffffb24d2eeeaca0
   x8 : ffff80000d583628 x7 : 0000080077783000 x6 : 0000000000000000
   x5 : ffff80000d584000 x4 : ffff07ff99c0c000 x3 : 0000000000000130
   x2 : 0000000000000000 x1 : ffff80000d5839c0 x0 : ffff07ff99c0cc08
   Call trace:
    drm_crtc_next_vblank_start+0x2c/0x98
    drm_atomic_helper_wait_for_fences+0x90/0x240
    drm_atomic_helper_commit+0xb0/0x188
    drm_atomic_commit+0xb0/0xf0
    drm_client_modeset_commit_atomic+0x218/0x280
    drm_client_modeset_commit_locked+0x64/0x1a0
    drm_client_modeset_commit+0x38/0x68
    __drm_fb_helper_restore_fbdev_mode_unlocked+0xb0/0xf8
    drm_fb_helper_set_par+0x44/0x88
    fbcon_init+0x1e0/0x4a8
    visual_init+0xbc/0x118
    do_bind_con_driver.isra.0+0x194/0x3a0
    do_take_over_console+0x50/0x70
    do_fbcon_takeover+0x74/0xf8
    do_fb_registered+0x13c/0x158
    fbcon_register_existing_fbs+0x78/0xc0
    process_one_work+0x1ec/0x478
    worker_thread+0x74/0x418
    kthread+0xec/0x100
    ret_from_fork+0x10/0x20
   Code: f9400004 b9409013 f940a082 9ba30a73 (b9407662)
   ---[ end trace 0000000000000000 ]---

v2: Use drm_dev_has_vblank()

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: d39e48ca80c0 ("drm/atomic-helper: Set fence deadline for vblank")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 299fa2a19a90..877e2067534f 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -996,10 +996,16 @@ EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
 int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime)
 {
 	unsigned int pipe = drm_crtc_index(crtc);
-	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
-	struct drm_display_mode *mode = &vblank->hwmode;
+	struct drm_vblank_crtc *vblank;
+	struct drm_display_mode *mode;
 	u64 vblank_start;
 
+	if (!drm_dev_has_vblank(crtc->dev))
+		return -EINVAL;
+
+	vblank = &crtc->dev->vblank[pipe];
+	mode = &vblank->hwmode;
+
 	if (!vblank->framedur_ns || !vblank->linedur_ns)
 		return -EINVAL;
 
-- 
2.39.2

