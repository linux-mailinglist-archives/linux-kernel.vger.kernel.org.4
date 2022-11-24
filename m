Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41725637A31
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKXNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKXNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:46:15 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22509108937
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:46:14 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO7V2Aj007527;
        Thu, 24 Nov 2022 07:45:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FYUAbQ6G5Y5j98iLtUCCLLhHUJK7mXE/nnmydN6ls9s=;
 b=rCzcXACZYvQjdya93wl4fSJN2AgFaIgOxf/HA5GsnGVS35KaKr9tPxTJM79i5CeqUoOn
 8gcLpLcnqmsGXvFHwL73H3TkZ1iEcv31Bn6gPw8BNjuD5Nq3kqWkjem/mWguiQZJia+S
 FzbEwflpJs7yq9/xCgaQkVqtnkfZqHfx9ogy/UO323YhQY+aO/dLmIlS2EDCOdTNJZzx
 fcIznQzkg4zXmZCJyZNEoXG9kklArqcb7eoWHP7aWQNASK0SEYP32FE/GAsAIKJf/1Si
 VqhJDIxAASnc11Cn5noSgaQRiIjzAjTTMy4YwHE6viuknPw8zaYWKJVbiTuykVZ0Dk6r SA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet664u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 07:45:58 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 07:45:56 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 24 Nov 2022 07:45:56 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8A7EF477;
        Thu, 24 Nov 2022 13:45:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] firmware: cs_dsp: Make the exports namespaced
Date:   Thu, 24 Nov 2022 13:45:56 +0000
Message-ID: <20221124134556.3343784-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221124134556.3343784-1-rf@opensource.cirrus.com>
References: <20221124134556.3343784-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I-jldAkpslsykUZkwCz9pGemzvEXEsdk
X-Proofpoint-GUID: I-jldAkpslsykUZkwCz9pGemzvEXEsdk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all the exports into a namespace.
This also adds the MODULE_IMPORT_NS to the 3 drivers that use the
exported functions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 62 ++++++++++++++++----------------
 sound/pci/hda/cs35l41_hda.c      |  1 +
 sound/pci/hda/hda_cs_dsp_ctl.c   |  1 +
 sound/soc/codecs/wm_adsp.c       |  1 +
 4 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 81cc3d0f6eec..f8b56f8f6e84 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -369,7 +369,7 @@ const char *cs_dsp_mem_region_name(unsigned int type)
 		return NULL;
 	}
 }
-EXPORT_SYMBOL_GPL(cs_dsp_mem_region_name);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mem_region_name, FW_CS_DSP);
 
 #ifdef CONFIG_DEBUG_FS
 static void cs_dsp_debugfs_save_wmfwname(struct cs_dsp *dsp, const char *s)
@@ -480,7 +480,7 @@ void cs_dsp_init_debugfs(struct cs_dsp *dsp, struct dentry *debugfs_root)
 
 	dsp->debugfs_root = root;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_init_debugfs);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_init_debugfs, FW_CS_DSP);
 
 /**
  * cs_dsp_cleanup_debugfs() - Removes DSP representation from debugfs
@@ -492,17 +492,17 @@ void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp)
 	debugfs_remove_recursive(dsp->debugfs_root);
 	dsp->debugfs_root = NULL;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_cleanup_debugfs);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_cleanup_debugfs, FW_CS_DSP);
 #else
 void cs_dsp_init_debugfs(struct cs_dsp *dsp, struct dentry *debugfs_root)
 {
 }
-EXPORT_SYMBOL_GPL(cs_dsp_init_debugfs);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_init_debugfs, FW_CS_DSP);
 
 void cs_dsp_cleanup_debugfs(struct cs_dsp *dsp)
 {
 }
-EXPORT_SYMBOL_GPL(cs_dsp_cleanup_debugfs);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_cleanup_debugfs, FW_CS_DSP);
 
 static inline void cs_dsp_debugfs_save_wmfwname(struct cs_dsp *dsp,
 						const char *s)
@@ -710,7 +710,7 @@ int cs_dsp_coeff_write_acked_control(struct cs_dsp_coeff_ctl *ctl, unsigned int
 
 	return -ETIMEDOUT;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_coeff_write_acked_control);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_coeff_write_acked_control, FW_CS_DSP);
 
 static int cs_dsp_coeff_write_ctrl_raw(struct cs_dsp_coeff_ctl *ctl,
 				       unsigned int off, const void *buf, size_t len)
@@ -778,7 +778,7 @@ int cs_dsp_coeff_write_ctrl(struct cs_dsp_coeff_ctl *ctl,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_coeff_write_ctrl);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_coeff_write_ctrl, FW_CS_DSP);
 
 static int cs_dsp_coeff_read_ctrl_raw(struct cs_dsp_coeff_ctl *ctl,
 				      unsigned int off, void *buf, size_t len)
@@ -850,7 +850,7 @@ int cs_dsp_coeff_read_ctrl(struct cs_dsp_coeff_ctl *ctl,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_coeff_read_ctrl);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_coeff_read_ctrl, FW_CS_DSP);
 
 static int cs_dsp_coeff_init_control_caches(struct cs_dsp *dsp)
 {
@@ -1493,7 +1493,7 @@ struct cs_dsp_coeff_ctl *cs_dsp_get_ctl(struct cs_dsp *dsp, const char *name, in
 
 	return rslt;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_get_ctl);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_get_ctl, FW_CS_DSP);
 
 static void cs_dsp_ctl_fixup_base(struct cs_dsp *dsp,
 				  const struct cs_dsp_alg_region *alg_region)
@@ -1583,7 +1583,7 @@ struct cs_dsp_alg_region *cs_dsp_find_alg_region(struct cs_dsp *dsp,
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_find_alg_region);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_find_alg_region, FW_CS_DSP);
 
 static struct cs_dsp_alg_region *cs_dsp_create_region(struct cs_dsp *dsp,
 						      int type, __be32 id,
@@ -2217,7 +2217,7 @@ int cs_dsp_adsp1_init(struct cs_dsp *dsp)
 
 	return cs_dsp_common_init(dsp);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_adsp1_init);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp1_init, FW_CS_DSP);
 
 /**
  * cs_dsp_adsp1_power_up() - Load and start the named firmware
@@ -2309,7 +2309,7 @@ int cs_dsp_adsp1_power_up(struct cs_dsp *dsp,
 	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_adsp1_power_up);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp1_power_up, FW_CS_DSP);
 
 /**
  * cs_dsp_adsp1_power_down() - Halts the DSP
@@ -2341,7 +2341,7 @@ void cs_dsp_adsp1_power_down(struct cs_dsp *dsp)
 
 	mutex_unlock(&dsp->pwr_lock);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_adsp1_power_down);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp1_power_down, FW_CS_DSP);
 
 static int cs_dsp_adsp2v2_enable_core(struct cs_dsp *dsp)
 {
@@ -2493,7 +2493,7 @@ int cs_dsp_set_dspclk(struct cs_dsp *dsp, unsigned int freq)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_set_dspclk);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_set_dspclk, FW_CS_DSP);
 
 static void cs_dsp_stop_watchdog(struct cs_dsp *dsp)
 {
@@ -2583,7 +2583,7 @@ int cs_dsp_power_up(struct cs_dsp *dsp,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_power_up);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_power_up, FW_CS_DSP);
 
 /**
  * cs_dsp_power_down() - Powers-down the DSP
@@ -2617,7 +2617,7 @@ void cs_dsp_power_down(struct cs_dsp *dsp)
 
 	cs_dsp_dbg(dsp, "Shutdown complete\n");
 }
-EXPORT_SYMBOL_GPL(cs_dsp_power_down);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_power_down, FW_CS_DSP);
 
 static int cs_dsp_adsp2_start_core(struct cs_dsp *dsp)
 {
@@ -2703,7 +2703,7 @@ int cs_dsp_run(struct cs_dsp *dsp)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_run);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_run, FW_CS_DSP);
 
 /**
  * cs_dsp_stop() - Stops the firmware
@@ -2742,7 +2742,7 @@ void cs_dsp_stop(struct cs_dsp *dsp)
 
 	cs_dsp_dbg(dsp, "Execution stopped\n");
 }
-EXPORT_SYMBOL_GPL(cs_dsp_stop);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_stop, FW_CS_DSP);
 
 static int cs_dsp_halo_start_core(struct cs_dsp *dsp)
 {
@@ -2804,7 +2804,7 @@ int cs_dsp_adsp2_init(struct cs_dsp *dsp)
 
 	return cs_dsp_common_init(dsp);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_adsp2_init);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp2_init, FW_CS_DSP);
 
 /**
  * cs_dsp_halo_init() - Initialise a cs_dsp structure representing a HALO Core DSP
@@ -2818,7 +2818,7 @@ int cs_dsp_halo_init(struct cs_dsp *dsp)
 
 	return cs_dsp_common_init(dsp);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_halo_init);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_halo_init, FW_CS_DSP);
 
 /**
  * cs_dsp_remove() - Clean a cs_dsp before deletion
@@ -2838,7 +2838,7 @@ void cs_dsp_remove(struct cs_dsp *dsp)
 		cs_dsp_free_ctl_blk(ctl);
 	}
 }
-EXPORT_SYMBOL_GPL(cs_dsp_remove);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_remove, FW_CS_DSP);
 
 /**
  * cs_dsp_read_raw_data_block() - Reads a block of data from DSP memory
@@ -2875,7 +2875,7 @@ int cs_dsp_read_raw_data_block(struct cs_dsp *dsp, int mem_type, unsigned int me
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_read_raw_data_block);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_read_raw_data_block, FW_CS_DSP);
 
 /**
  * cs_dsp_read_data_word() - Reads a word from DSP memory
@@ -2899,7 +2899,7 @@ int cs_dsp_read_data_word(struct cs_dsp *dsp, int mem_type, unsigned int mem_add
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_read_data_word);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_read_data_word, FW_CS_DSP);
 
 /**
  * cs_dsp_write_data_word() - Writes a word to DSP memory
@@ -2925,7 +2925,7 @@ int cs_dsp_write_data_word(struct cs_dsp *dsp, int mem_type, unsigned int mem_ad
 
 	return regmap_raw_write(dsp->regmap, reg, &val, sizeof(val));
 }
-EXPORT_SYMBOL_GPL(cs_dsp_write_data_word);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_write_data_word, FW_CS_DSP);
 
 /**
  * cs_dsp_remove_padding() - Convert unpacked words to packed bytes
@@ -2949,7 +2949,7 @@ void cs_dsp_remove_padding(u32 *buf, int nwords)
 		*pack_out++ = (u8)(word >> 16);
 	}
 }
-EXPORT_SYMBOL_GPL(cs_dsp_remove_padding);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_remove_padding, FW_CS_DSP);
 
 /**
  * cs_dsp_adsp2_bus_error() - Handle a DSP bus error interrupt
@@ -3019,7 +3019,7 @@ void cs_dsp_adsp2_bus_error(struct cs_dsp *dsp)
 error:
 	mutex_unlock(&dsp->pwr_lock);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_adsp2_bus_error);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp2_bus_error, FW_CS_DSP);
 
 /**
  * cs_dsp_halo_bus_error() - Handle a DSP bus error interrupt
@@ -3079,7 +3079,7 @@ void cs_dsp_halo_bus_error(struct cs_dsp *dsp)
 exit_unlock:
 	mutex_unlock(&dsp->pwr_lock);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_halo_bus_error);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_halo_bus_error, FW_CS_DSP);
 
 /**
  * cs_dsp_halo_wdt_expire() - Handle DSP watchdog expiry
@@ -3099,7 +3099,7 @@ void cs_dsp_halo_wdt_expire(struct cs_dsp *dsp)
 
 	mutex_unlock(&dsp->pwr_lock);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_halo_wdt_expire);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_halo_wdt_expire, FW_CS_DSP);
 
 static const struct cs_dsp_ops cs_dsp_adsp1_ops = {
 	.validate_version = cs_dsp_validate_version,
@@ -3221,7 +3221,7 @@ int cs_dsp_chunk_write(struct cs_dsp_chunk *ch, int nbits, u32 val)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_chunk_write);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_chunk_write, FW_CS_DSP);
 
 /**
  * cs_dsp_chunk_flush() - Pad remaining data with zero and commit to chunk
@@ -3240,7 +3240,7 @@ int cs_dsp_chunk_flush(struct cs_dsp_chunk *ch)
 
 	return cs_dsp_chunk_write(ch, CS_DSP_DATA_WORD_BITS - ch->cachebits, 0);
 }
-EXPORT_SYMBOL_GPL(cs_dsp_chunk_flush);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_chunk_flush, FW_CS_DSP);
 
 /**
  * cs_dsp_chunk_read() - Parse data from a DSP memory chunk
@@ -3282,7 +3282,7 @@ int cs_dsp_chunk_read(struct cs_dsp_chunk *ch, int nbits)
 
 	return result;
 }
-EXPORT_SYMBOL_GPL(cs_dsp_chunk_read);
+EXPORT_SYMBOL_NS_GPL(cs_dsp_chunk_read, FW_CS_DSP);
 
 MODULE_DESCRIPTION("Cirrus Logic DSP Support");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index e5f0549bf06d..91842c0c8c74 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1545,3 +1545,4 @@ MODULE_DESCRIPTION("CS35L41 HDA Driver");
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(FW_CS_DSP);
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 1622a22f96f6..5433f6227ac9 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -249,3 +249,4 @@ EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_read_ctl, SND_HDA_CS_DSP_CONTROLS);
 MODULE_DESCRIPTION("CS_DSP ALSA Control HDA Library");
 MODULE_AUTHOR("Stefan Binding, <sbinding@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(FW_CS_DSP);
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 34a94b011518..91f93c08afd7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2060,3 +2060,4 @@ static const struct cs_dsp_client_ops wm_adsp2_client_ops = {
 };
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(FW_CS_DSP);
-- 
2.30.2

