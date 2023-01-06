Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73779660542
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjAFRFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjAFRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:05:00 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71307CBC6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:04:57 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306ECrpZ031858;
        Fri, 6 Jan 2023 18:04:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=L48ESav4pphvO/55xGupo7Sioi2tIUpTcjjWUCvhrAI=;
 b=G0yO0xEuSO0CFGvLQU0+yAp8oaRH4X6KyDL8FoCOmPUSaQdOEGpROYIclB0A+FpYCqO5
 n0UCsHjMvv3KVJ1WZ5T7j2Q9j5A9zOy0eaScmB4Vjvg3DTC0MbVAqJd7iGkMxcwEnHHN
 p84Hrq3iPiHWNAtnDan9S34GqMhRQimWJIsrk68r+eY+h6NqosQscm5baz1LSaCX+AyZ
 gSBQIph2yG8hr2vuRWAknWLoZpNLRQbW6/hahIeTJxzty1JyZvJ4TDf2L/fc4xAx4mgb
 iOh+POlU8nUvCCE/uqnEAUOuFCspacCMSZSGmXsSSE4hu4NE8/oz3fpx0FBDQFHf/02W IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mwtasjm8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 18:04:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 734B110002A;
        Fri,  6 Jan 2023 18:04:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CF50219D9E;
        Fri,  6 Jan 2023 18:04:43 +0100 (CET)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 6 Jan
 2023 18:04:42 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 3/3] nvmem: stm32: detect bsec pta presence for STM32MP15x
Date:   Fri, 6 Jan 2023 18:04:30 +0100
Message-ID: <20230106180414.v5.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106170430.1214186-1-patrick.delaunay@foss.st.com>
References: <20230106170430.1214186-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_11,2023-01-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STM32MP15x SoC, the SMC backend is optional when OP-TEE is used;
the PTA BSEC should be used as it is done on STM32MP13x platform,
but the BSEC SMC can be also used: it is a legacy mode in OP-TEE,
not recommended but used in previous OP-TEE firmware.

The presence of OP-TEE is dynamically detected in STM32MP15x device tree
and the supported NVMEM backend is dynamically detected:
- PTA with stm32_bsec_pta_find
- SMC with stm32_bsec_check

With OP-TEE but without PTA and SMC detection, the probe is deferred for
STM32MP15x devices.

On STM32MP13x platform, only the PTA is supported with cfg->ta = true
and this detection is skipped.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v5:
- update the BSEC SMC detection logic in stm32_romem_probe()
  after Etienne Carierre review to support NVMEM probe after OP-TEE probe

Changes in v3:
- use of_find_compatible_node in optee_presence_check function
  instead of of_find_node_by_path("/firmware/optee")

Changes in v2:
- Added patch in the serie for BSEC PTA support on STM32MP15x
  with dynamic detection of OP-TEE presence and SMC support (legacy mode)

 drivers/nvmem/stm32-romem.c | 38 +++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 978a63edf297..e0babc2cebd7 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -159,6 +159,31 @@ static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
 	return stm32_bsec_optee_ta_write(priv->ctx, priv->lower, offset, buf, bytes);
 }
 
+static bool stm32_bsec_smc_check(void)
+{
+	u32 val;
+	int ret;
+
+	/* check that the OP-TEE support the BSEC SMC (legacy mode) */
+	ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, 0, 0, &val);
+
+	return !ret;
+}
+
+static bool optee_presence_check(void)
+{
+	struct device_node *np;
+	bool tee_detected = false;
+
+	/* check that the OP-TEE node is present and available. */
+	np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
+	if (np && of_device_is_available(np))
+		tee_detected = true;
+	of_node_put(np);
+
+	return tee_detected;
+}
+
 static int stm32_romem_probe(struct platform_device *pdev)
 {
 	const struct stm32_romem_cfg *cfg;
@@ -195,11 +220,16 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	} else {
 		priv->cfg.size = cfg->size;
 		priv->lower = cfg->lower;
-		if (cfg->ta) {
+		if (cfg->ta || optee_presence_check()) {
 			rc = stm32_bsec_optee_ta_open(&priv->ctx);
-			/* wait for OP-TEE client driver to be up and ready */
-			if (rc)
-				return rc;
+			if (rc) {
+				/* wait for OP-TEE client driver to be up and ready */
+				if (rc == -EPROBE_DEFER)
+					return -EPROBE_DEFER;
+				/* BSEC PTA is required or SMC not ready */
+				if (cfg->ta || !stm32_bsec_smc_check())
+					return rc;
+			}
 		}
 		if (priv->ctx) {
 			rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
-- 
2.25.1

