Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC1646F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLHMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:18:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A12D1C6;
        Thu,  8 Dec 2022 04:18:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q7so1394312wrr.8;
        Thu, 08 Dec 2022 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kopWTdbABaX27Ds/Hj4PqMWXfvaDUN36/cUz0Y8oP4=;
        b=gTAiB+NDA4q4RkNrdK8ny3mvNG7zigQt0hoAOXyxEWCG3t0qIjs+hXrOqIQ7phfdz2
         w/vpeYkIK5PETD/IGl4Vcv4RbmeG4rof286B3jqwmbeOpeQ2bQrhvlUuB4txRZaitdpF
         NGF9MKQK1O2rMZL8iNCz6FxzH9BdtW4jeFB/5Nty7ETE1P96gscgRNEzC+NXtZ/Zuf/i
         Xk0J04MUbEhgyNZjrlEg75gDEdwylRsKSPXSIR4j8k45p31/YzmnlbHPWuccwXPK5fEO
         CbHf1g3kPPGeQoXea7thOYNNarD8Tta6O8nSWzj+SzMBs8mnRNlUVcnK0h0CGPLxfLXV
         kSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kopWTdbABaX27Ds/Hj4PqMWXfvaDUN36/cUz0Y8oP4=;
        b=Pqale9/CZ08JBzEYpHigdHs4eM8sN/pTfRgXPo1F9OqRznUBO/BUPJVmxHqqiFeRKM
         AOqXn20WazoXKgNJ9AM2R7y0ayevET/0idozORD7SaHxqWvctENplKNl5hD8UmHM0MCr
         sX77AEON6d2GD/ARkgnVO5wyR4ch0n2qmOks/ZIrvUiy+0HUogj7OW/kZCiJKM4xRJ/A
         kOP7S8PTIzeplpuJHeStpgxcyxzPjIClPxcplwdwjS4efqjIhLYO+9ABb25a1RVhvi7p
         BNvOrs+pB06Gq4iyAuleiGmyHs9IT2XYwt6/rNT2D755hB4SJSos3cDMIE5MukJuwpyd
         gjeA==
X-Gm-Message-State: ANoB5pmngPx/iGdJgWzUpXpSDgiPdsXCJLfp2UTk4O/eoVNEMQFOdwxA
        uIVCyRr9OOOaz9iYK6tzhao=
X-Google-Smtp-Source: AA0mqf6s8UEyYgael4xxckJTHwAIw5k4DHHoxl6yjRVNilALHooaY5s2ffAy8TukRUdhQ24HePygQQ==
X-Received: by 2002:a5d:4d41:0:b0:241:e91e:ca9c with SMTP id a1-20020a5d4d41000000b00241e91eca9cmr42050992wru.417.1670501936640;
        Thu, 08 Dec 2022 04:18:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b002425dc49024sm11857985wru.43.2022.12.08.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:18:56 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix spelling mistake: "dram_clk_chanage" -> "dram_clk_change"
Date:   Thu,  8 Dec 2022 12:18:54 +0000
Message-Id: <20221208121854.2436398-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the struct field dram_clk_chanage. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c       | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c       | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c       | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c       | 8 ++++----
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h          | 2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index 0f746bb4e500..d51f1ce02874 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -55,7 +55,7 @@ void hubbub1_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A);
 
 	s = &wm->sets[1];
 	s->wm_set = 1;
@@ -65,7 +65,7 @@ void hubbub1_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B);
 
 	s = &wm->sets[2];
 	s->wm_set = 2;
@@ -75,7 +75,7 @@ void hubbub1_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C);
 
 	s = &wm->sets[3];
 	s->wm_set = 3;
@@ -85,7 +85,7 @@ void hubbub1_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D);
 }
 
 void hubbub1_allow_self_refresh_control(struct hubbub *hubbub, bool allow)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c8ec11839b4d..fe2023f18b7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -159,7 +159,7 @@ static void dcn10_log_hubbub_state(struct dc *dc,
 		DTN_INFO_MICRO_SEC(s->pte_meta_urgent);
 		DTN_INFO_MICRO_SEC(s->sr_enter);
 		DTN_INFO_MICRO_SEC(s->sr_exit);
-		DTN_INFO_MICRO_SEC(s->dram_clk_chanage);
+		DTN_INFO_MICRO_SEC(s->dram_clk_change);
 		DTN_INFO("\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index e8b6065fffad..a0f8e31d2adc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -83,7 +83,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf, unsigned i
 	memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
 	dc->res_pool->hubbub->funcs->wm_read_state(dc->res_pool->hubbub, &wm);
 
-	chars_printed = snprintf_count(pBuf, remaining_buffer, "wm_set_index,data_urgent,pte_meta_urgent,sr_enter,sr_exit,dram_clk_chanage\n");
+	chars_printed = snprintf_count(pBuf, remaining_buffer, "wm_set_index,data_urgent,pte_meta_urgent,sr_enter,sr_exit,dram_clk_change\n");
 	remaining_buffer -= chars_printed;
 	pBuf += chars_printed;
 
@@ -98,7 +98,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf, unsigned i
 			(s->pte_meta_urgent * frac) / ref_clk_mhz / frac, (s->pte_meta_urgent * frac) / ref_clk_mhz % frac,
 			(s->sr_enter * frac) / ref_clk_mhz / frac, (s->sr_enter * frac) / ref_clk_mhz % frac,
 			(s->sr_exit * frac) / ref_clk_mhz / frac, (s->sr_exit * frac) / ref_clk_mhz % frac,
-			(s->dram_clk_chanage * frac) / ref_clk_mhz / frac, (s->dram_clk_chanage * frac) / ref_clk_mhz % frac);
+			(s->dram_clk_change * frac) / ref_clk_mhz / frac, (s->dram_clk_change * frac) / ref_clk_mhz % frac);
 		remaining_buffer -= chars_printed;
 		pBuf += chars_printed;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index aacb1fb5c73e..24bd93219936 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -500,7 +500,7 @@ void hubbub2_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A);
 
 	s = &wm->sets[1];
 	s->wm_set = 1;
@@ -511,7 +511,7 @@ void hubbub2_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B);
 
 	s = &wm->sets[2];
 	s->wm_set = 2;
@@ -522,7 +522,7 @@ void hubbub2_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C);
 
 	s = &wm->sets[3];
 	s->wm_set = 3;
@@ -533,7 +533,7 @@ void hubbub2_wm_read_state(struct hubbub *hubbub,
 		s->sr_enter = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D);
 		s->sr_exit = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D);
 	}
-	s->dram_clk_chanage = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D);
+	s->dram_clk_change = REG_READ(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D);
 }
 
 void hubbub2_get_dchub_ref_freq(struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index c5e200d09038..aeb0e0d9b70a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -635,7 +635,7 @@ void hubbub21_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A,
-			 DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, &s->dram_clk_chanage);
+			 DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, &s->dram_clk_change);
 
 	s = &wm->sets[1];
 	s->wm_set = 1;
@@ -649,7 +649,7 @@ void hubbub21_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B,
-			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, &s->dram_clk_chanage);
+			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, &s->dram_clk_change);
 
 	s = &wm->sets[2];
 	s->wm_set = 2;
@@ -663,7 +663,7 @@ void hubbub21_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C,
-			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, &s->dram_clk_chanage);
+			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, &s->dram_clk_change);
 
 	s = &wm->sets[3];
 	s->wm_set = 3;
@@ -677,7 +677,7 @@ void hubbub21_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D,
-			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, &s->dram_clk_chanage);
+			DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, &s->dram_clk_change);
 }
 
 static void hubbub21_apply_DEDCN21_147_wa(struct hubbub *hubbub)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 5947c2cb0f30..9501403a48a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -865,7 +865,7 @@ static void hubbub32_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A,
-			 DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A, &s->dram_clk_chanage);
+			 DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A, &s->dram_clk_change);
 
 	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A,
 			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A, &s->usr_retrain);
@@ -885,7 +885,7 @@ static void hubbub32_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B,
-			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B, &s->dram_clk_chanage);
+			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B, &s->dram_clk_change);
 
 	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B,
 			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B, &s->usr_retrain);
@@ -905,7 +905,7 @@ static void hubbub32_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C,
-			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C, &s->dram_clk_chanage);
+			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C, &s->dram_clk_change);
 
 	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C,
 			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C, &s->usr_retrain);
@@ -925,7 +925,7 @@ static void hubbub32_wm_read_state(struct hubbub *hubbub,
 			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, &s->sr_exit);
 
 	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D,
-			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D, &s->dram_clk_chanage);
+			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D, &s->dram_clk_change);
 
 	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D,
 			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D, &s->usr_retrain);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index f2e1fcb668fb..5b0265c0df61 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -46,7 +46,7 @@ struct dcn_hubbub_wm_set {
 	uint32_t pte_meta_urgent;
 	uint32_t sr_enter;
 	uint32_t sr_exit;
-	uint32_t dram_clk_chanage;
+	uint32_t dram_clk_change;
 	uint32_t usr_retrain;
 	uint32_t fclk_pstate_change;
 };
-- 
2.38.1

