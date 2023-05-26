Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2A2711AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbjEZAFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbjEZAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:04:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8C818D;
        Thu, 25 May 2023 17:04:43 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q022ET008327;
        Thu, 25 May 2023 19:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=m1QHDRa6+ejoVottyWJoC7AsF3F9Sk5+UAuj31WYWGw=;
 b=UrwfBJxSck9CZI5cYCR1Fu5Vmx/IwBZejzkcdUu1wlzeZVTlteQGRO6Qo5wwuYE9b+bD
 QPtveIzjFy/qp/E08oq3c/4F139r5aA0PsIgi/JTaf31LslmLzX4lO8kPxQn2yhCa8am
 2vL0spdRq/cXmikt6ZHtu6qlpCKSv1s92Ejk8IcayUYPZTZmclY1iLJ8s3M4qAhCVjaO
 v+ykVwlO6CXdmcDJ0cOFQfKr7WS3bevbcy13GY6ICy0ngxj9OSaDANQi6xRCvEiKWSOa
 hrLnhvdQoOcxZ0x1aV8MIS0Ae4fhemeoMWNGLqlCqgq2z6Lby6mEacANJTwstYxfKHFr RA== 
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8jhx5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 19:04:38 -0500
Received: from ausex02.ad.cirrus.com (141.131.37.96) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 19:04:37 -0500
Received: from ftrev.crystal.cirrus.com (141.131.38.212) by
 anon-ausex02.ad.cirrus.com (141.131.37.96) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 19:04:37 -0500
From:   Fred Treven <fred.treven@cirrus.com>
To:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lee@kernel.org>
Subject: [PATCH 4/5] Input: cs40l26 - Load multiple coefficient files
Date:   Thu, 25 May 2023 19:04:30 -0500
Message-ID: <1685059471-9598-4-git-send-email-fred.treven@cirrus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: APuPk_ZlDwXpaWZO-yGuwjQpupwxuAA4
X-Proofpoint-GUID: APuPk_ZlDwXpaWZO-yGuwjQpupwxuAA4
X-Proofpoint-Spam-Reason: orgsafe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the driver to load all necessary coefficient tuning
files:	cs40l26.bin (wavetable)
	cs40l26-svc.bin (Sensorless Velocity Control)
	cs40l26-dvl.bin (Dynamic Voltage Limiter)

Signed-off-by: Fred Treven <fred.treven@cirrus.com>
---
 drivers/input/misc/cs40l26.c  | 31 +++++++++++++++++++++++--------
 include/linux/input/cs40l26.h |  3 ++-
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
index 1959438dfe31..12c29cbd4ff0 100644
--- a/drivers/input/misc/cs40l26.c
+++ b/drivers/input/misc/cs40l26.c
@@ -2006,6 +2006,12 @@ static const struct cs_dsp_client_ops cs40l26_cs_dsp_client_ops = {
 	.post_run		= cs40l26_cs_dsp_post_run,
 };
 
+static struct cs_dsp_coeff_desc cs40l26_coeffs[] = {
+	{ .coeff_firmware = NULL,	.coeff_filename = "cs40l26.bin",	.optional = false },
+	{ .coeff_firmware = NULL,	.coeff_filename =  "cs40l26-svc.bin",	.optional = true },
+	{ .coeff_firmware = NULL,	.coeff_filename = "cs40l26-dvl.bin",	.optional = true },
+};
+
 static int cs40l26_cs_dsp_init(struct cs40l26_private *cs40l26)
 {
 	int error;
@@ -2035,14 +2041,16 @@ static int cs40l26_cs_dsp_init(struct cs40l26_private *cs40l26)
 static void cs40l26_dsp_start(struct cs40l26_private *cs40l26)
 {
 	struct device *dev = cs40l26->dev;
+	int i;
 
 	if (cs40l26_dsp_pre_config(cs40l26))
 		goto err_rls_fw;
 
 	mutex_lock(&cs40l26->lock);
 
-	if (cs_dsp_power_up(&cs40l26->dsp, cs40l26->wmfw, "cs40l26.wmfw",
-				cs40l26->bin, "cs40l26.bin", "cs40l26"))
+	if (cs_dsp_power_up_multiple(&cs40l26->dsp, cs40l26->wmfw, "cs40l26.wmfw",
+					cs40l26_coeffs, CS40L26_NUM_COEFF_FILES,
+					"cs40l26"))
 		goto err_mutex;
 
 	if (cs40l26->dsp.fw_id != CS40L26_FW_ID) {
@@ -2062,7 +2070,9 @@ static void cs40l26_dsp_start(struct cs40l26_private *cs40l26)
 	mutex_unlock(&cs40l26->lock);
 
 err_rls_fw:
-	release_firmware(cs40l26->bin);
+	for (i = 0; i < CS40L26_NUM_COEFF_FILES; i++)
+		release_firmware(cs40l26_coeffs[i].coeff_firmware);
+
 	release_firmware(cs40l26->wmfw);
 
 	cs40l26_pm_runtime_setup(cs40l26);
@@ -2074,17 +2084,20 @@ static void cs40l26_coeff_upload(const struct firmware *bin, void *context)
 
 	if (!bin) {
 		dev_err(cs40l26->dev, "Failed to request coefficient file\n");
+		cs40l26->ncoeffs++;
 		return;
 	}
 
-	cs40l26->bin = bin;
+	cs40l26_coeffs[cs40l26->ncoeffs++].coeff_firmware = bin;
 
-	cs40l26_dsp_start(cs40l26);
+	if (cs40l26->ncoeffs == CS40L26_NUM_COEFF_FILES)
+		cs40l26_dsp_start(cs40l26);
 }
 
 static void cs40l26_fw_upload(const struct firmware *wmfw, void *context)
 {
 	struct cs40l26_private *cs40l26 = (struct cs40l26_private *)context;
+	int i;
 
 	if (!wmfw) {
 		dev_err(cs40l26->dev, "Failed to request firmware file\n");
@@ -2098,9 +2111,11 @@ static void cs40l26_fw_upload(const struct firmware *wmfw, void *context)
 
 	cs40l26->wmfw = wmfw;
 
-	request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
-				"cs40l26.bin", cs40l26->dev, GFP_KERNEL,
-				cs40l26, cs40l26_coeff_upload);
+	for (i = 0; i < CS40L26_NUM_COEFF_FILES; i++)
+		request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+					"cs40l26.bin", cs40l26->dev,
+					GFP_KERNEL, cs40l26,
+					cs40l26_coeff_upload);
 }
 
 static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
diff --git a/include/linux/input/cs40l26.h b/include/linux/input/cs40l26.h
index bc0acec9cf23..2f74ef61b952 100644
--- a/include/linux/input/cs40l26.h
+++ b/include/linux/input/cs40l26.h
@@ -231,6 +231,7 @@
 /* Firmware Handling */
 #define CS40L26_FW_ID				0x1800D4
 #define CS40L26_FW_ID_VERSION_MIN		0x070237
+#define CS40L26_NUM_COEFF_FILES			3
 
 /* Algorithms */
 #define CS40L26_BUZZGEN_ALGO_ID			0x0004F202
@@ -473,8 +474,8 @@ struct cs40l26_private {
 	unsigned int vbst_uv;
 	bool exploratory_mode_enabled;
 	const struct firmware *wmfw;
-	const struct firmware *bin;
 	bool dsp_initialized;
+	int ncoeffs;
 };
 
 int cs40l26_probe(struct cs40l26_private *cs40l26);
-- 
2.7.4

