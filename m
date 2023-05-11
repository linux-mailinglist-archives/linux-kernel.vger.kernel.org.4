Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFA6FFAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbjEKTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjEKTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6AEDD8B;
        Thu, 11 May 2023 12:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 946E865121;
        Thu, 11 May 2023 19:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F90C433D2;
        Thu, 11 May 2023 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683834075;
        bh=DD2aM/JJlI9AmJhswCb2q6THb2WTgg1R14kyz4RwfdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOa4voYnFSVWVGpv0nWB4VkApJmkCgn/1Lze/eQzuD8tj31UpiGq0tz6EbmtSQWlh
         5/JdIqCQG62Mpgyno+amHZu4byH24HXs6/qFtxdhhMql90h4MrtFcZnqDhxBeDMSf6
         wmQUJK0eXcEKmQWIfVSX/44szJ/Y/igqvHPOZwbnMcNIXmnzwYnc7mUmdQGhxyyTkT
         wuzKLA74oGLnNKkU3KYVZVCbrixR6Lg7+h343asokQsuOnx1fWxWqz1zB701EKMfMu
         ejy3AmFieVWFtCj+HqHUoGbTntp/zAA+iH5YmDgm4AJCVDLWbajL4RFs3D9jBe2qUP
         VZSDLtRVB7rqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     jasontao <jasontao@glenfly.com>,
        Reaper Li <reaperlioc@glenfly.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        yung-chuan.liao@linux.intel.com, rander.wang@intel.com,
        orlandoch.dev@gmail.com, amadeuszx.slawinski@linux.intel.com,
        fred.oh@linux.intel.com, bhelgaas@google.com, mkumard@nvidia.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 2/3] ALSA: hda: Glenfly: add HD Audio PCI IDs and HDMI Codec Vendor IDs.
Date:   Thu, 11 May 2023 15:40:58 -0400
Message-Id: <20230511194059.623695-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511194059.623695-1-sashal@kernel.org>
References: <20230511194059.623695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jasontao <jasontao@glenfly.com>

[ Upstream commit c51e431052e2eacfb23fbf6b39bc6c8770d9827a ]

Add a set of HD Audio PCI IDS, and the HDMI codec vendor IDs for
Glenfly Gpus.

- In default_bdl_pos_adj, set bdl to 128 as Glenfly Gpus have hardware
limitation, need to increase hdac interrupt interval.
- In azx_first_init, enable polling mode for Glenfly Gpu. When the codec
complete the command, it sends interrupt and writes response entries to
memory, howerver, the write requests sometimes are not actually
synchronized to memory when driver handle hdac interrupt on Glenfly Gpus.
If the RIRB status is not updated in the interrupt handler,
azx_rirb_get_response keeps trying to recevie a response from rirb until
1s timeout. Enabling polling mode for Glenfly Gpu can fix the issue.
- In patch_gf_hdmi, set Glenlfy Gpu Codec's no_sticky_stream as it need
driver to do actual clean-ups for the linked codec when switch from one
codec to another.

Signed-off-by: jasontao <jasontao@glenfly.com>
Signed-off-by: Reaper Li <reaperlioc@glenfly.com>
Link: https://lore.kernel.org/r/20230426013059.4329-1-reaperlioc@glenfly.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c  | 21 +++++++++++++++++++++
 sound/pci/hda/patch_hdmi.c | 22 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index de1fe604905f3..1f641712233ef 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -264,6 +264,7 @@ enum {
 	AZX_DRIVER_ATI,
 	AZX_DRIVER_ATIHDMI,
 	AZX_DRIVER_ATIHDMI_NS,
+	AZX_DRIVER_GFHDMI,
 	AZX_DRIVER_VIA,
 	AZX_DRIVER_SIS,
 	AZX_DRIVER_ULI,
@@ -386,6 +387,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_ATI] = "HDA ATI SB",
 	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
 	[AZX_DRIVER_ATIHDMI_NS] = "HDA ATI HDMI",
+	[AZX_DRIVER_GFHDMI] = "HDA GF HDMI",
 	[AZX_DRIVER_VIA] = "HDA VIA VT82xx",
 	[AZX_DRIVER_SIS] = "HDA SIS966",
 	[AZX_DRIVER_ULI] = "HDA ULI M5461",
@@ -1783,6 +1785,12 @@ static int default_bdl_pos_adj(struct azx *chip)
 	}
 
 	switch (chip->driver_type) {
+	/*
+	 * increase the bdl size for Glenfly Gpus for hardware
+	 * limitation on hdac interrupt interval
+	 */
+	case AZX_DRIVER_GFHDMI:
+		return 128;
 	case AZX_DRIVER_ICH:
 	case AZX_DRIVER_PCH:
 		return 1;
@@ -1902,6 +1910,12 @@ static int azx_first_init(struct azx *chip)
 		pci_write_config_dword(pci, PCI_BASE_ADDRESS_1, 0);
 	}
 #endif
+	/*
+	 * Fix response write request not synced to memory when handle
+	 * hdac interrupt on Glenfly Gpus
+	 */
+	if (chip->driver_type == AZX_DRIVER_GFHDMI)
+		bus->polling_mode = 1;
 
 	err = pci_request_regions(pci, "ICH HD audio");
 	if (err < 0)
@@ -2011,6 +2025,7 @@ static int azx_first_init(struct azx *chip)
 			chip->playback_streams = ATIHDMI_NUM_PLAYBACK;
 			chip->capture_streams = ATIHDMI_NUM_CAPTURE;
 			break;
+		case AZX_DRIVER_GFHDMI:
 		case AZX_DRIVER_GENERIC:
 		default:
 			chip->playback_streams = ICH6_NUM_PLAYBACK;
@@ -2756,6 +2771,12 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	/* GLENFLY */
+	{ PCI_DEVICE(0x6766, PCI_ANY_ID),
+	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_NO_64BIT },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
 	/* VIA GFX VT7122/VX900 */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 1afe9cddb69eb..bd151465f2089 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4287,6 +4287,22 @@ static int patch_via_hdmi(struct hda_codec *codec)
 	return patch_simple_hdmi(codec, VIAHDMI_CVT_NID, VIAHDMI_PIN_NID);
 }
 
+static int patch_gf_hdmi(struct hda_codec *codec)
+{
+	int err;
+
+	err = patch_generic_hdmi(codec);
+	if (err)
+		return err;
+
+	/*
+	 * Glenfly GPUs have two codecs, stream switches from one codec to
+	 * another, need to do actual clean-ups in codec_cleanup_stream
+	 */
+	codec->no_sticky_stream = 1;
+	return 0;
+}
+
 /*
  * patch entries
  */
@@ -4376,6 +4392,12 @@ HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
+HDA_CODEC_ENTRY(0x67663d82, "Arise 82 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d83, "Arise 83 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d84, "Arise 84 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d85, "Arise 85 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d86, "Arise 86 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d87, "Arise 87 HDMI/DP",	patch_gf_hdmi),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
-- 
2.39.2

