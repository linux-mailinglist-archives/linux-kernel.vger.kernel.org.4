Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57548667047
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjALKzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjALKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:54:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010905D68E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:45:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5008D6600357;
        Thu, 12 Jan 2023 10:45:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673520349;
        bh=q6MN89SwxOfQZMxHmc6kKxnaAaHPdvgAVWDRJPuUHgw=;
        h=From:To:Cc:Subject:Date:From;
        b=Rfmotd9sfiSPNX1Z88yAJhM3KDW3HuJ4Kranp8EZMj2zoHt6RWBboKf4PuHx7qwKy
         t4Ipt4muFGK+PSOJCn0i/QEplyDHdAe+71juM7Fiq3NGqrrK2EQLOCKSNppvUhl7u3
         4Pg5xfaD1yAlzXlSzwIoSbwn0tX4lLg9ZLHyFz9gKwZqRI2FXzDLFyRbv1egt/uI55
         SeaQFvpZKsahOJCpdZXa4Ym6jGzDKDicD2bfc4m8kKfb8sHza4sW7/l2JjV2lfMJO4
         CEdneS+W+vOOJt7LKZwoaB2ciQZNR4MNY8+Lc5k9rdWMBRRPp8FHoHuI8LuHhY1Mta
         WLMAWze50DBnw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        rander.wang@intel.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] ASoC: SOF: sof-audio: Check snd_sof_widget pointer not NULL
Date:   Thu, 12 Jan 2023 11:45:42 +0100
Message-Id: <20230112104542.115151-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sof_unprepare_widgets_in_path(), check if swidget is
actually not NULL, as the widget may not have been initialized at all.

This commit solves the following kernel panic seen on MediaTek MT8195:

[   18.025215] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
[   18.034266] Mem abort info:
[   18.037314]   ESR = 0x0000000096000004
[   18.041314]   EC = 0x25: DABT (current EL), IL = 32 bits
[   18.046876]   SET = 0, FnV = 0
[   18.050180]   EA = 0, S1PTW = 0
[   18.053572]   FSC = 0x04: level 0 translation fault
[   18.058700] Data abort info:
[   18.061832]   ISV = 0, ISS = 0x00000004
[   18.065919]   CM = 0, WnR = 0
[   18.069137] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000115495000
[   18.075826] [0000000000000014] pgd=0000000000000000, p4d=0000000000000000
[   18.082867] Internal error: Oops: 0000000096000004 [#1] SMP
[   18.088688] Modules linked in: af_alg qrtr btusb btrtl btintel btmtk btbcm bluetooth 8021q garp uvcvideo mrp stp ecdh_generic llc ecc videobuf2_vmalloc mt7921e mt7921_common mt76_connac_lib mt76 mac80211 snd_sof_ipc_msg_injector snd_sof_ipc_flood_test cfg80211 snd_sof_mt8195 mtk_adsp_common snd_sof_xtensa_dsp snd_sof_of panfrost rfkill snd_sof crct10dif_ce cros_ec_sensors cros_ec_lid_angle gpu_sched sbs_battery cros_usbpd_logger cros_ec_sensors_core hid_multitouch snd_sof_utils fuse ipv6
[   18.132109] CPU: 5 PID: 657 Comm: wireplumber Tainted: G        W          6.2.0-rc3-next-20230111+ #230
[   18.141834] Hardware name: Acer Tomato (rev2) board (DT)
[   18.147392] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.154600] pc : sof_unprepare_widgets_in_path.isra.0+0x28/0x10c [snd_sof]
[   18.161735] lr : sof_walk_widgets_in_order+0x198/0x1d0 [snd_sof]
[   18.167996] sp : ffff80000eb0b870
[   18.171558] x29: ffff80000eb0b870 x28: 0000000000000001 x27: ffff5d8e178c4c00
[   18.178939] x26: ffffbd50140fd758 x25: ffffbd50140fd760 x24: 0000000000000000
[   18.186321] x23: 0000000000000000 x22: ffff5d8e109dd080 x21: ffff5d8e0a429280
[   18.193702] x20: 0000000000000000 x19: ffff5d8e11fe4800 x18: 0000000000000000
[   18.201083] x17: 0000000000000000 x16: ffffbd5073deabb0 x15: 0000000000000000
[   18.208464] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   18.215846] x11: 0000000000000000 x10: 0000000000002780 x9 : ffffbd50140eb4bc
[   18.223228] x8 : ffff5d8e1b5327e0 x7 : 0000000000000000 x6 : ffff5d8e1b530000
[   18.230610] x5 : 0000000000000003 x4 : 0000000000000001 x3 : 0000000000000000
[   18.237991] x2 : 0000000000000000 x1 : ffff5d8e11fe4800 x0 : ffff5d8e0a429280
[   18.245372] Call trace:
[   18.248066]  sof_unprepare_widgets_in_path.isra.0+0x28/0x10c [snd_sof]
[   18.254847]  sof_walk_widgets_in_order+0x198/0x1d0 [snd_sof]
[   18.260760]  sof_widget_list_free+0x7c/0xbc [snd_sof]
[   18.266066]  sof_pcm_hw_free+0x10c/0x1c0 [snd_sof]
[   18.271110]  snd_soc_pcm_component_hw_free+0x8c/0xe0
[   18.276327]  soc_pcm_hw_clean+0x60/0x11c
[   18.280498]  dpcm_fe_dai_hw_free+0x98/0x110
[   18.284930]  snd_pcm_common_ioctl+0xc48/0x1a2c
[   18.289624]  snd_pcm_ioctl+0x38/0x50
[   18.293448]  __arm64_sys_ioctl+0xb0/0xf4
[   18.297620]  invoke_syscall+0x50/0x120
[   18.301618]  el0_svc_common.constprop.0+0x17c/0x1b0
[   18.306744]  do_el0_svc+0x40/0xc4
[   18.310307]  el0_svc+0x48/0xf0
[   18.313611]  el0t_64_sync_handler+0xb8/0xc0
[   18.318041]  el0t_64_sync+0x1a0/0x1a4
[   18.321953] Code: aa0103f3 f90013f5 aa0003f5 f9406834 (39405280)
[   18.328293] ---[ end trace 0000000000000000 ]---

Fixes: 9862dcf70245 ("ASoC: SOF: don't unprepare widget used other pipelines")
Fixes: ce59804d2643 ("ASoC: SOF: clear prepare state when widget is unprepared")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/sof-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index e1ab8380e7d8..1988717762b3 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -274,7 +274,7 @@ sof_unprepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widg
 	struct snd_soc_dapm_path *p;
 
 	/* return if the widget is in use or if it is already unprepared */
-	if (!swidget->prepared || swidget->use_count > 1)
+	if (!swidget || !swidget->prepared || swidget->use_count > 1)
 		return;
 
 	widget_ops = tplg_ops ? tplg_ops->widget : NULL;
-- 
2.39.0

