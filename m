Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DB6230B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKIQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiKIQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176E27903;
        Wed,  9 Nov 2022 08:53:58 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNja027347;
        Wed, 9 Nov 2022 10:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=1/iqdbl79p07gdmIWrlfhsD3njth3q+lAyMGYPPce6s=;
 b=qTstbbsq0uaNGrb9U9nPZAfnISIIkYaZ0BRhOBGsG1dhW5/ZKqm6ay9vt7NkDLQCt8Ct
 /lQsropm3vuktG8MdsjJcfjZ8WRYfWA/GL5vSUmuhCQV6PBLwUGcR9/8HcN+MrQiihjE
 p/c6qS8E/ydQ2yjW+uZJL4HPGe/8qhQJk2j6BxTUyIb+CCcUsE3VTXrSLWbN1TZ2el/T
 aPqfheLmFfbA5sWoGJFykNIzgqUoPE+uUxP6H0ZRAf0JH7z3gluaLXtpNJ9yct2GVsF0
 aV962D0xDcrT53mqhKzA3wdwW23D/yZ6uZXkuHI0Ng/SUFllLLJ5Vyr4WOJS8+mcedai SQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:41 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:37 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:37 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2FFE0468;
        Wed,  9 Nov 2022 16:53:37 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 10/12] ASoC: wm_adsp: Allow client to hook into pre_run callback
Date:   Wed, 9 Nov 2022 16:53:29 +0000
Message-ID: <20221109165331.29332-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: d-QuLTs7FgaCQWnVepVFNDjx8Dyo62fV
X-Proofpoint-GUID: d-QuLTs7FgaCQWnVepVFNDjx8Dyo62fV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some HALO-based codecs need some additional custom setup in the
pre_run stage of cs_dsp. Implement the callback in wm_adsp to call
an optional codec driver callback.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 11 +++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8a2e9771bb50..34a94b011518 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1035,6 +1035,16 @@ int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(wm_adsp_early_event);
 
+static int wm_adsp_pre_run(struct cs_dsp *cs_dsp)
+{
+	struct wm_adsp *dsp = container_of(cs_dsp, struct wm_adsp, cs_dsp);
+
+	if (!dsp->pre_run)
+		return 0;
+
+	return (*dsp->pre_run)(dsp);
+}
+
 static int wm_adsp_event_post_run(struct cs_dsp *cs_dsp)
 {
 	struct wm_adsp *dsp = container_of(cs_dsp, struct wm_adsp, cs_dsp);
@@ -2043,6 +2053,7 @@ static const struct cs_dsp_client_ops wm_adsp1_client_ops = {
 static const struct cs_dsp_client_ops wm_adsp2_client_ops = {
 	.control_add = wm_adsp_control_add,
 	.control_remove = wm_adsp_control_remove,
+	.pre_run = wm_adsp_pre_run,
 	.post_run = wm_adsp_event_post_run,
 	.post_stop = wm_adsp_event_post_stop,
 	.watchdog_expired = wm_adsp_fatal_error,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 375009a65828..dc2f7a096e26 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -36,6 +36,7 @@ struct wm_adsp {
 	int fw;
 
 	struct work_struct boot_work;
+	int (*pre_run)(struct wm_adsp *dsp);
 
 	bool preloaded;
 	bool fatal_error;
-- 
2.30.2

