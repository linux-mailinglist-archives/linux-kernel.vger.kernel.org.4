Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DAC718265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjEaNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjEaNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9287DE40;
        Wed, 31 May 2023 06:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D9763AF5;
        Wed, 31 May 2023 13:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3079C433EF;
        Wed, 31 May 2023 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540474;
        bh=T+b1Mld9xi7m8dULwPfvheiEogr8e/MnWZp9YePKVo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFwVI67r+NNtV3qfBDAdj010Uzvb/Pfg0rBKhXwkfXvvl1uWAsnUi42ZFjA4inr9K
         /mAJt7elrwHyC+aPCWLA4uy/LKhf4134XBZKOzp8/PUaQIRyOP4ZrZXP0kwn1hzGPK
         2JfzJbD65WdGK6ha45nZLmmn14O/MkZt2MP3glH6ZL+nfKTTpgurRl096kioFpYGSS
         RBf+Oy/HaS5VLn4nf/Y6dy6CLcf/QnHghG/cX1ysa5+Q0d0u8MscTfO7lRZZfnyARw
         utUwc69p1iVvcyRGGi2myafzdEjCmLDXng1YCPjty/R/URVhXyJOD30u7fU6gxuI2w
         zPk5C/LoGP3Kw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        piotrx.maziarz@linux.intel.com, zhangyiqun@phytium.com.cn,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 23/37] ASoC: Intel: avs: Fix avs_path_module::instance_id size
Date:   Wed, 31 May 2023 09:40:05 -0400
Message-Id: <20230531134020.3383253-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 320f4d868b83a804e3a4bd61a5b7d0f1db66380e ]

All IPCs using instance_id use 8 bit value. Original commit used 16 bit
value because FW reports possible max value in 16 bit field, but in
practice FW limits the value to 8 bits.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-7-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/avs.h    | 4 ++--
 sound/soc/intel/avs/dsp.c    | 4 ++--
 sound/soc/intel/avs/path.h   | 2 +-
 sound/soc/intel/avs/probes.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/avs/avs.h b/sound/soc/intel/avs/avs.h
index d7fccdcb9c167..0cf38c9e768e7 100644
--- a/sound/soc/intel/avs/avs.h
+++ b/sound/soc/intel/avs/avs.h
@@ -283,8 +283,8 @@ void avs_release_firmwares(struct avs_dev *adev);
 
 int avs_dsp_init_module(struct avs_dev *adev, u16 module_id, u8 ppl_instance_id,
 			u8 core_id, u8 domain, void *param, u32 param_size,
-			u16 *instance_id);
-void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u16 instance_id,
+			u8 *instance_id);
+void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u8 instance_id,
 			   u8 ppl_instance_id, u8 core_id);
 int avs_dsp_create_pipeline(struct avs_dev *adev, u16 req_size, u8 priority,
 			    bool lp, u16 attributes, u8 *instance_id);
diff --git a/sound/soc/intel/avs/dsp.c b/sound/soc/intel/avs/dsp.c
index b881100d3e02a..aa03af4473e94 100644
--- a/sound/soc/intel/avs/dsp.c
+++ b/sound/soc/intel/avs/dsp.c
@@ -225,7 +225,7 @@ static int avs_dsp_put_core(struct avs_dev *adev, u32 core_id)
 
 int avs_dsp_init_module(struct avs_dev *adev, u16 module_id, u8 ppl_instance_id,
 			u8 core_id, u8 domain, void *param, u32 param_size,
-			u16 *instance_id)
+			u8 *instance_id)
 {
 	struct avs_module_entry mentry;
 	bool was_loaded = false;
@@ -272,7 +272,7 @@ int avs_dsp_init_module(struct avs_dev *adev, u16 module_id, u8 ppl_instance_id,
 	return ret;
 }
 
-void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u16 instance_id,
+void avs_dsp_delete_module(struct avs_dev *adev, u16 module_id, u8 instance_id,
 			   u8 ppl_instance_id, u8 core_id)
 {
 	struct avs_module_entry mentry;
diff --git a/sound/soc/intel/avs/path.h b/sound/soc/intel/avs/path.h
index 197222c5e008e..657f7b093e805 100644
--- a/sound/soc/intel/avs/path.h
+++ b/sound/soc/intel/avs/path.h
@@ -37,7 +37,7 @@ struct avs_path_pipeline {
 
 struct avs_path_module {
 	u16 module_id;
-	u16 instance_id;
+	u8 instance_id;
 	union avs_gtw_attributes gtw_attrs;
 
 	struct avs_tplg_module *template;
diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 70a94201d6a56..275928281c6c6 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -18,7 +18,7 @@ static int avs_dsp_init_probe(struct avs_dev *adev, union avs_connector_node_id
 {
 	struct avs_probe_cfg cfg = {{0}};
 	struct avs_module_entry mentry;
-	u16 dummy;
+	u8 dummy;
 
 	avs_get_module_entry(adev, &AVS_PROBE_MOD_UUID, &mentry);
 
-- 
2.39.2

