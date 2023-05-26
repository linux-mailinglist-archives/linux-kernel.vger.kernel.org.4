Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68540711AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbjEZAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:04:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9638189;
        Thu, 25 May 2023 17:04:42 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q022ES008327;
        Thu, 25 May 2023 19:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=YxsKnTKBrlut2Zf3TicIz3cmx/oQMiseL7SMTQy7c+U=;
 b=HMZepwgkJEUpBVWr4GwbUx6n5hL9RvcdV3TZgmUFp4SpqvTZvvhXVCloz2/KU53k2KyK
 p908KWAr0AU5JRHd+4O0yaxQfjquHyEq+i+FJQvt6UmXLfGUBLYCa1IslclVv9MlYjxc
 lzPxga/n1umPmylXmOVFK9n6+mU0itiyEJ+BNm+zcFhn/r7YBZ6KTC92zUsSZLu13/9W
 /nEI6sBO19fBLdUcqC/jVkEinTiYk1BRO8QUpzJ5mUDXXTorkfUQHxL9ewyK9xkdrGuZ
 qUcxCzSoyip8oALALizX9/P1Lx4hWLXHYsLU2RTMV+tWtEQ87PAwzZRQc29oBJHGX06d YA== 
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8jhx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 19:04:37 -0500
Received: from ausex02.ad.cirrus.com (141.131.37.96) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 19:04:36 -0500
Received: from ftrev.crystal.cirrus.com (141.131.38.212) by
 anon-ausex02.ad.cirrus.com (141.131.37.96) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 19:04:36 -0500
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
Subject: [PATCH 3/5] firmware: cs_dsp: Add ability to loa multiple coefficient files
Date:   Thu, 25 May 2023 19:04:29 -0500
Message-ID: <1685059471-9598-3-git-send-email-fred.treven@cirrus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JqwquFTYrX7szNWi9ORmnbKkzHeFFWlJ
X-Proofpoint-GUID: JqwquFTYrX7szNWi9ORmnbKkzHeFFWlJ
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

Add cs_dsp_power_up_multiple() which accepts an array of
cs_dsp_coeff_desc firmware-filename pairs to load.

This enables the user to load more than one tuning file
along with the associated firmware.

Change cs_dsp_power_up() to make use of the new function
with a single coefficient file.

Signed-off-by: Fred Treven <fred.treven@cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 61 ++++++++++++++++++++++++++--------
 include/linux/firmware/cirrus/cs_dsp.h | 20 +++++++++--
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index f558b390fbfe..3242095c1b13 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -2515,28 +2515,30 @@ static void cs_dsp_halo_stop_watchdog(struct cs_dsp *dsp)
 }
 
 /**
- * cs_dsp_power_up() - Downloads firmware to the DSP
- * @dsp: pointer to DSP structure
+ * cs_dsp_power_up_multiple() - Downloads firmware and multiple coefficient files to the DSP
+ * @dsp: pointer to the DSP structure
  * @wmfw_firmware: the firmware to be sent
  * @wmfw_filename: file name of firmware to be sent
- * @coeff_firmware: the coefficient data to be sent
- * @coeff_filename: file name of coefficient to data be sent
+ * @coeffs: coefficient data and filename pairs to be sent
+ * @num_coeffs: number of coefficient files to be sent
  * @fw_name: the user-friendly firmware name
  *
  * This function is used on ADSP2 and Halo DSP cores, it powers-up the DSP core
  * and downloads the firmware but does not start the firmware running. The
  * cs_dsp booted flag will be set once completed and if the core has a low-power
  * memory retention mode it will be put into this state after the firmware is
- * downloaded.
+ * downloaded. Differs from cs_dsp_power_up() in that it allows for multiple
+ * coefficient files to be downloaded.
  *
  * Return: Zero for success, a negative number on error.
+ *
+ *
  */
-int cs_dsp_power_up(struct cs_dsp *dsp,
-		    const struct firmware *wmfw_firmware, char *wmfw_filename,
-		    const struct firmware *coeff_firmware, char *coeff_filename,
-		    const char *fw_name)
+int cs_dsp_power_up_multiple(struct cs_dsp *dsp, const struct firmware *wmfw_firmware,
+		char *wmfw_filename, struct cs_dsp_coeff_desc *coeffs, int num_coeffs,
+		const char *fw_name)
 {
-	int ret;
+	int i, ret;
 
 	mutex_lock(&dsp->pwr_lock);
 
@@ -2562,9 +2564,12 @@ int cs_dsp_power_up(struct cs_dsp *dsp,
 	if (ret != 0)
 		goto err_ena;
 
-	ret = cs_dsp_load_coeff(dsp, coeff_firmware, coeff_filename);
-	if (ret != 0)
-		goto err_ena;
+	for (i = 0; i < num_coeffs; i++) {
+		ret = cs_dsp_load_coeff(dsp, coeffs[i].coeff_firmware,
+					coeffs[i].coeff_filename);
+		if (ret != 0 && !coeffs[i].optional)
+			goto err_ena;
+	}
 
 	/* Initialize caches for enabled and unset controls */
 	ret = cs_dsp_coeff_init_control_caches(dsp);
@@ -2590,6 +2595,36 @@ int cs_dsp_power_up(struct cs_dsp *dsp,
 
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(cs_dsp_power_up_multiple, FW_CS_DSP);
+
+/**
+ * cs_dsp_power_up() - Downloads firmware to the DSP
+ * @dsp: pointer to DSP structure
+ * @wmfw_firmware: the firmware to be sent
+ * @wmfw_filename: file name of firmware to be sent
+ * @coeff_firmware: the coefficient data to be sent
+ * @coeff_filename: file name of coefficient data to be sent
+ * @fw_name: the user-friendly firmware name
+ *
+ * This function is used on ADSP2 and Halo DSP cores, it powers-up the DSP core
+ * and downloads the firmware but does not start the firmware running. The
+ * cs_dsp booted flag will be set once completed and if the core has a low-power
+ * memory retention mode it will be put into this state after the firmware is
+ * downloaded.
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_power_up(struct cs_dsp *dsp, const struct firmware *wmfw_firmware, char *wmfw_filename,
+		const struct firmware *coeff_firmware, char *coeff_filename, const char *fw_name)
+{
+	struct cs_dsp_coeff_desc coeff_desc;
+
+	coeff_desc.coeff_firmware = coeff_firmware;
+	coeff_desc.coeff_filename = coeff_filename;
+	coeff_desc.optional = false;
+
+	return cs_dsp_power_up_multiple(dsp, wmfw_firmware, wmfw_filename, &coeff_desc, 1, fw_name);
+}
 EXPORT_SYMBOL_NS_GPL(cs_dsp_power_up, FW_CS_DSP);
 
 /**
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index cad828e21c72..1fda4104140c 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -43,6 +43,18 @@
 #define CS_DSP_ACKED_CTL_MAX_VALUE           0xFFFFFF
 
 /**
+ * struct cs_dsp_coeff_desc - Describes a coeff. file + filename pair
+ * @coeff_firmware:	Firmware struct to populate with coeff. data
+ * @coeff_filename:	File from which coeff. data is loaded
+ * @optional:		Designates whether or not to error out if file fails to load
+ */
+struct cs_dsp_coeff_desc {
+	const struct firmware *coeff_firmware;
+	char *coeff_filename;
+	bool optional;
+};
+
+/**
  * struct cs_dsp_region - Describes a logical memory region in DSP address space
  * @type:	Memory region type
  * @base:	Address of region
@@ -217,10 +229,14 @@ int cs_dsp_adsp1_power_up(struct cs_dsp *dsp,
 			  const struct firmware *coeff_firmware, char *coeff_filename,
 			  const char *fw_name);
 void cs_dsp_adsp1_power_down(struct cs_dsp *dsp);
-int cs_dsp_power_up(struct cs_dsp *dsp,
+int cs_dsp_power_up_multiple(struct cs_dsp *dsp,
 		    const struct firmware *wmfw_firmware, char *wmfw_filename,
-		    const struct firmware *coeff_firmware, char *coeff_filename,
+		    struct cs_dsp_coeff_desc *coeffs, int num_coeffs,
 		    const char *fw_name);
+int cs_dsp_power_up(struct cs_dsp *dsp,
+		const struct firmware *wmfw_firmware, char *wmfw_filename,
+		const struct firmware *coeff_firmware, char *coeff_filename,
+		const char *fw_name);
 void cs_dsp_power_down(struct cs_dsp *dsp);
 int cs_dsp_run(struct cs_dsp *dsp);
 void cs_dsp_stop(struct cs_dsp *dsp);
-- 
2.7.4

