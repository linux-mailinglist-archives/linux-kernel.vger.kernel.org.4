Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7006D245D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjCaPrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjCaPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:47:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695F11EBA;
        Fri, 31 Mar 2023 08:47:32 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VF0v6C026206;
        Fri, 31 Mar 2023 17:47:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=eVxle4TZWTvY6ewnUGV7xXIwPe0XQBzxVHISXKvAK0I=;
 b=nUJSieOepSoDq3tZcQ7NCX3glSM8qzRxPOM8pf94ZfSrudj0WbRc9p0supAnzRQnqH/V
 GoQRdgEGgPxL8eOBart5OkW7YPkT8wc4/ntvMHMSJV3hA0dR2JAe9CRxmP4f9rf7mp3F
 tG5rkl8FIE9RNltfwXfgAIJHH7Nnzmr9BAoQQ33f1UHQO1hrVwbFGRJ7kRo1rfR5x3EV
 4XLR/J92/OW6PUiOz0hRWWUx0tIFMAR5wfRgjmXfgfuDZ+TIVd3n/DPlixDFz+ySUqXv
 XXUZk/gqfT/gPWCOpsrwu8XRei8p5FgaAKCgR/+Uq2I5NDiX0Hfwr6zxFhahjK4UP01x 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pns3ekscn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 17:47:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EC8F10003B;
        Fri, 31 Mar 2023 17:47:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38368222CAD;
        Fri, 31 Mar 2023 17:47:17 +0200 (CEST)
Received: from localhost (10.201.21.178) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 31 Mar
 2023 17:47:16 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the SCMI reset controller
Date:   Fri, 31 Mar 2023 17:46:50 +0200
Message-ID: <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hold boot can be managed by the SCMI controller as a reset.
If the "hold_boot" reset is defined in the device tree, use it.
Else use the syscon controller directly to access to the register.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/stm32_rproc.c | 34 ++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 4be651e734ee..6b0d8f30a5c7 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -78,6 +78,7 @@ struct stm32_mbox {
 
 struct stm32_rproc {
 	struct reset_control *rst;
+	struct reset_control *hold_boot_rst;
 	struct stm32_syscon hold_boot;
 	struct stm32_syscon pdds;
 	struct stm32_syscon m4_state;
@@ -398,6 +399,14 @@ static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
 	struct stm32_syscon hold_boot = ddata->hold_boot;
 	int val, err;
 
+	if (ddata->hold_boot_rst) {
+		/* Use the SCMI reset controller */
+		if (!hold)
+			return reset_control_deassert(ddata->hold_boot_rst);
+		else
+			return reset_control_assert(ddata->hold_boot_rst);
+	}
+
 	val = hold ? HOLD_BOOT : RELEASE_BOOT;
 
 	err = regmap_update_bits(hold_boot.map, hold_boot.reg,
@@ -693,16 +702,29 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 		dev_info(dev, "wdg irq registered\n");
 	}
 
-	ddata->rst = devm_reset_control_get_by_index(dev, 0);
+	ddata->rst = devm_reset_control_get(dev, "mcu_rst");
 	if (IS_ERR(ddata->rst))
 		return dev_err_probe(dev, PTR_ERR(ddata->rst),
 				     "failed to get mcu_reset\n");
 
-	err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
-				     &ddata->hold_boot);
-	if (err) {
-		dev_err(dev, "failed to get hold boot\n");
-		return err;
+	ddata->hold_boot_rst = devm_reset_control_get(dev, "hold_boot");
+	if (IS_ERR(ddata->hold_boot_rst)) {
+		if (PTR_ERR(ddata->hold_boot_rst) == -EPROBE_DEFER)
+			return PTR_ERR(ddata->hold_boot_rst);
+		ddata->hold_boot_rst = NULL;
+	}
+
+	if (!ddata->hold_boot_rst) {
+		/*
+		 * If the hold boot is not managed by the SCMI reset controller,
+		 * manage it through the syscon controller
+		 */
+		err = stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
+					     &ddata->hold_boot);
+		if (err) {
+			dev_err(dev, "failed to get hold boot\n");
+			return err;
+		}
 	}
 
 	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
-- 
2.25.1

