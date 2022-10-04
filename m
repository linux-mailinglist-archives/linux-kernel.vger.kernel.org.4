Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BD5F3DEA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJDIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJDILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9B4F3B5;
        Tue,  4 Oct 2022 01:10:33 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D66356602294;
        Tue,  4 Oct 2022 09:10:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664871031;
        bh=ZvCAm6tas1NrY/vnDxW7QcXzurXuLfu0ajhNiV8HyBo=;
        h=From:To:Cc:Subject:Date:From;
        b=OENs02aLbgUG9m6QjlhFfKDqMp+ilEYLoY0r3wugU0XeJy8Icn0iO3l5C7/XI3zjx
         jAYPdXsgEro4ygwgSfohgyAG6T/EMb0lBcwRUFazBBxjGmciJ0Fz9HzyBRbgyMEaB2
         egkVhUf3ppvzp7jQi5jbgxorPfS81jaOQCVO1frQxPj4WucKFyNSffK3V2EMvQt1U3
         /WKBFWoQPOUadY4Zyi8+9sSjb9tyXjYGlAcXAsPxU5Ar0PLlWw5562Errkkjzkow0G
         EOY0giDeRQ8tNFS0mDuxIulZbpny9953JuWYcONTkc6oe1DcAu7bU5GtEY0FoGYcF4
         ASgdb7nODtDBw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: pass the struct by reference
Date:   Tue,  4 Oct 2022 13:10:19 +0500
Message-Id: <20221004081019.619193-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
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

The out structure should be passed by reference instead of passing by
value. This saves the extra copy of the structure.

Fixes: 1738061c9ec8 ("platform/x86/amd/pmf: Add support for CnQF")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/platform/x86/amd/pmf/cnqf.c | 92 ++++++++++++++---------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
index 668c7c0fea83..3f9731a2ac28 100644
--- a/drivers/platform/x86/amd/pmf/cnqf.c
+++ b/drivers/platform/x86/amd/pmf/cnqf.c
@@ -158,100 +158,100 @@ int amd_pmf_trans_cnqf(struct amd_pmf_dev *dev, int socket_power, ktime_t time_l
 	return 0;
 }
 
-static void amd_pmf_update_trans_data(int idx, struct apmf_dyn_slider_output out)
+static void amd_pmf_update_trans_data(int idx, struct apmf_dyn_slider_output *out)
 {
 	struct cnqf_tran_params *tp;
 
 	tp = &config_store.trans_param[idx][CNQF_TRANSITION_TO_QUIET];
-	tp->time_constant = out.t_balanced_to_quiet;
+	tp->time_constant = out->t_balanced_to_quiet;
 	tp->target_mode = CNQF_MODE_QUIET;
 	tp->shifting_up = false;
 
 	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_BALANCE_TO_PERFORMANCE];
-	tp->time_constant = out.t_balanced_to_perf;
+	tp->time_constant = out->t_balanced_to_perf;
 	tp->target_mode = CNQF_MODE_PERFORMANCE;
 	tp->shifting_up = true;
 
 	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_QUIET_TO_BALANCE];
-	tp->time_constant = out.t_quiet_to_balanced;
+	tp->time_constant = out->t_quiet_to_balanced;
 	tp->target_mode = CNQF_MODE_BALANCE;
 	tp->shifting_up = true;
 
 	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_PERFORMANCE_TO_BALANCE];
-	tp->time_constant = out.t_perf_to_balanced;
+	tp->time_constant = out->t_perf_to_balanced;
 	tp->target_mode = CNQF_MODE_BALANCE;
 	tp->shifting_up = false;
 
 	tp = &config_store.trans_param[idx][CNQF_TRANSITION_FROM_TURBO_TO_PERFORMANCE];
-	tp->time_constant = out.t_turbo_to_perf;
+	tp->time_constant = out->t_turbo_to_perf;
 	tp->target_mode = CNQF_MODE_PERFORMANCE;
 	tp->shifting_up = false;
 
 	tp = &config_store.trans_param[idx][CNQF_TRANSITION_TO_TURBO];
-	tp->time_constant = out.t_perf_to_turbo;
+	tp->time_constant = out->t_perf_to_turbo;
 	tp->target_mode = CNQF_MODE_TURBO;
 	tp->shifting_up = true;
 }
 
-static void amd_pmf_update_mode_set(int idx, struct apmf_dyn_slider_output out)
+static void amd_pmf_update_mode_set(int idx, struct apmf_dyn_slider_output *out)
 {
 	struct cnqf_mode_settings *ms;
 
 	/* Quiet Mode */
 	ms = &config_store.mode_set[idx][CNQF_MODE_QUIET];
-	ms->power_floor = out.ps[APMF_CNQF_QUIET].pfloor;
-	ms->power_control.fppt = out.ps[APMF_CNQF_QUIET].fppt;
-	ms->power_control.sppt = out.ps[APMF_CNQF_QUIET].sppt;
-	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_QUIET].sppt_apu_only;
-	ms->power_control.spl = out.ps[APMF_CNQF_QUIET].spl;
-	ms->power_control.stt_min = out.ps[APMF_CNQF_QUIET].stt_min_limit;
+	ms->power_floor = out->ps[APMF_CNQF_QUIET].pfloor;
+	ms->power_control.fppt = out->ps[APMF_CNQF_QUIET].fppt;
+	ms->power_control.sppt = out->ps[APMF_CNQF_QUIET].sppt;
+	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_QUIET].sppt_apu_only;
+	ms->power_control.spl = out->ps[APMF_CNQF_QUIET].spl;
+	ms->power_control.stt_min = out->ps[APMF_CNQF_QUIET].stt_min_limit;
 	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
-		out.ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_APU];
+		out->ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_APU];
 	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
-		out.ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_HS2];
-	ms->fan_control.fan_id = out.ps[APMF_CNQF_QUIET].fan_id;
+		out->ps[APMF_CNQF_QUIET].stt_skintemp[STT_TEMP_HS2];
+	ms->fan_control.fan_id = out->ps[APMF_CNQF_QUIET].fan_id;
 
 	/* Balance Mode */
 	ms = &config_store.mode_set[idx][CNQF_MODE_BALANCE];
-	ms->power_floor = out.ps[APMF_CNQF_BALANCE].pfloor;
-	ms->power_control.fppt = out.ps[APMF_CNQF_BALANCE].fppt;
-	ms->power_control.sppt = out.ps[APMF_CNQF_BALANCE].sppt;
-	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_BALANCE].sppt_apu_only;
-	ms->power_control.spl = out.ps[APMF_CNQF_BALANCE].spl;
-	ms->power_control.stt_min = out.ps[APMF_CNQF_BALANCE].stt_min_limit;
+	ms->power_floor = out->ps[APMF_CNQF_BALANCE].pfloor;
+	ms->power_control.fppt = out->ps[APMF_CNQF_BALANCE].fppt;
+	ms->power_control.sppt = out->ps[APMF_CNQF_BALANCE].sppt;
+	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_BALANCE].sppt_apu_only;
+	ms->power_control.spl = out->ps[APMF_CNQF_BALANCE].spl;
+	ms->power_control.stt_min = out->ps[APMF_CNQF_BALANCE].stt_min_limit;
 	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
-		out.ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_APU];
+		out->ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_APU];
 	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
-		out.ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_HS2];
-	ms->fan_control.fan_id = out.ps[APMF_CNQF_BALANCE].fan_id;
+		out->ps[APMF_CNQF_BALANCE].stt_skintemp[STT_TEMP_HS2];
+	ms->fan_control.fan_id = out->ps[APMF_CNQF_BALANCE].fan_id;
 
 	/* Performance Mode */
 	ms = &config_store.mode_set[idx][CNQF_MODE_PERFORMANCE];
-	ms->power_floor = out.ps[APMF_CNQF_PERFORMANCE].pfloor;
-	ms->power_control.fppt = out.ps[APMF_CNQF_PERFORMANCE].fppt;
-	ms->power_control.sppt = out.ps[APMF_CNQF_PERFORMANCE].sppt;
-	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_PERFORMANCE].sppt_apu_only;
-	ms->power_control.spl = out.ps[APMF_CNQF_PERFORMANCE].spl;
-	ms->power_control.stt_min = out.ps[APMF_CNQF_PERFORMANCE].stt_min_limit;
+	ms->power_floor = out->ps[APMF_CNQF_PERFORMANCE].pfloor;
+	ms->power_control.fppt = out->ps[APMF_CNQF_PERFORMANCE].fppt;
+	ms->power_control.sppt = out->ps[APMF_CNQF_PERFORMANCE].sppt;
+	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_PERFORMANCE].sppt_apu_only;
+	ms->power_control.spl = out->ps[APMF_CNQF_PERFORMANCE].spl;
+	ms->power_control.stt_min = out->ps[APMF_CNQF_PERFORMANCE].stt_min_limit;
 	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
-		out.ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_APU];
+		out->ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_APU];
 	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
-		out.ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_HS2];
-	ms->fan_control.fan_id = out.ps[APMF_CNQF_PERFORMANCE].fan_id;
+		out->ps[APMF_CNQF_PERFORMANCE].stt_skintemp[STT_TEMP_HS2];
+	ms->fan_control.fan_id = out->ps[APMF_CNQF_PERFORMANCE].fan_id;
 
 	/* Turbo Mode */
 	ms = &config_store.mode_set[idx][CNQF_MODE_TURBO];
-	ms->power_floor = out.ps[APMF_CNQF_TURBO].pfloor;
-	ms->power_control.fppt = out.ps[APMF_CNQF_TURBO].fppt;
-	ms->power_control.sppt = out.ps[APMF_CNQF_TURBO].sppt;
-	ms->power_control.sppt_apu_only = out.ps[APMF_CNQF_TURBO].sppt_apu_only;
-	ms->power_control.spl = out.ps[APMF_CNQF_TURBO].spl;
-	ms->power_control.stt_min = out.ps[APMF_CNQF_TURBO].stt_min_limit;
+	ms->power_floor = out->ps[APMF_CNQF_TURBO].pfloor;
+	ms->power_control.fppt = out->ps[APMF_CNQF_TURBO].fppt;
+	ms->power_control.sppt = out->ps[APMF_CNQF_TURBO].sppt;
+	ms->power_control.sppt_apu_only = out->ps[APMF_CNQF_TURBO].sppt_apu_only;
+	ms->power_control.spl = out->ps[APMF_CNQF_TURBO].spl;
+	ms->power_control.stt_min = out->ps[APMF_CNQF_TURBO].stt_min_limit;
 	ms->power_control.stt_skin_temp[STT_TEMP_APU] =
-		out.ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_APU];
+		out->ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_APU];
 	ms->power_control.stt_skin_temp[STT_TEMP_HS2] =
-		out.ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_HS2];
-	ms->fan_control.fan_id = out.ps[APMF_CNQF_TURBO].fan_id;
+		out->ps[APMF_CNQF_TURBO].stt_skintemp[STT_TEMP_HS2];
+	ms->fan_control.fan_id = out->ps[APMF_CNQF_TURBO].fan_id;
 }
 
 static int amd_pmf_check_flags(struct amd_pmf_dev *dev)
@@ -284,8 +284,8 @@ static int amd_pmf_load_defaults_cnqf(struct amd_pmf_dev *dev)
 			return ret;
 		}
 
-		amd_pmf_update_mode_set(i, out);
-		amd_pmf_update_trans_data(i, out);
+		amd_pmf_update_mode_set(i, &out);
+		amd_pmf_update_trans_data(i, &out);
 		amd_pmf_update_power_threshold(i);
 
 		for (j = 0; j < CNQF_MODE_MAX; j++) {
-- 
2.30.2

