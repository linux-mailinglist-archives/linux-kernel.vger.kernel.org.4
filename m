Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF962BD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiKPMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiKPMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:19:04 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7636CDD;
        Wed, 16 Nov 2022 04:16:58 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGCGqJa067355;
        Wed, 16 Nov 2022 06:16:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668601012;
        bh=eudYAVsx6hlGlvS/Bo/pkRAQpJefAK5REsiWIAcFSeE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YEGVECVNoeH9ESkHnpX7qx1smN72df0yOfPHGOx8c2O3Be5s87JFCpg1IS009UhYk
         QalU+mEaVoMj8sIAp0KTQypc4Y9tP31RVsu7zXVabv9FXNS339gXKkgA73ql6brxtQ
         p0zoi01Sv2lio2BJ2SuxgJDTF1c0/RRqWGYsC0Lc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGCGqQi080413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 06:16:52 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 06:16:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 06:16:52 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGCGqYH016043;
        Wed, 16 Nov 2022 06:16:52 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2AGCGoaE032423;
        Wed, 16 Nov 2022 06:16:51 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v8 6/6] remoteproc: pru: Configure firmware based on client setup
Date:   Wed, 16 Nov 2022 17:46:34 +0530
Message-ID: <20221116121634.2901265-7-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116121634.2901265-1-danishanwar@ti.com>
References: <20221116121634.2901265-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Client device node property firmware-name is now used to configure
firmware for the PRU instances. The default firmware is also
restored once releasing the PRU resource.

Co-developed-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Tero Kristo <t-kristo@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index a7307a4c9308..bbee17522aac 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -172,6 +172,23 @@ void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
 	spin_unlock_irqrestore(&pru->rmw_lock, flags);
 }
 
+/**
+ * pru_rproc_set_firmware() - set firmware for a PRU core
+ * @rproc: the rproc instance of the PRU
+ * @fw_name: the new firmware name, or NULL if default is desired
+ *
+ * Return: 0 on success, or errno in error case.
+ */
+static int pru_rproc_set_firmware(struct rproc *rproc, const char *fw_name)
+{
+	struct pru_rproc *pru = rproc->priv;
+
+	if (!fw_name)
+		fw_name = pru->fw_name;
+
+	return rproc_set_firmware(rproc, fw_name);
+}
+
 static struct rproc *__pru_rproc_get(struct device_node *np, int index)
 {
 	struct rproc *rproc;
@@ -228,6 +245,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	struct rproc *rproc;
 	struct pru_rproc *pru;
 	struct device *dev;
+	const char *fw_name;
 	int ret;
 
 	rproc = __pru_rproc_get(np, index);
@@ -254,11 +272,25 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	if (pru_id)
 		*pru_id = pru->id;
 
+	ret = of_property_read_string_index(np, "firmware-name", index,
+					    &fw_name);
+	if (!ret) {
+		ret = pru_rproc_set_firmware(rproc, fw_name);
+		if (ret) {
+			dev_err(dev, "failed to set firmware: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return rproc;
 
 err_no_rproc_handle:
 	rproc_put(rproc);
 	return ERR_PTR(ret);
+
+err:
+	pru_rproc_put(rproc);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pru_rproc_get);
 
@@ -278,6 +310,8 @@ void pru_rproc_put(struct rproc *rproc)
 
 	pru = rproc->priv;
 
+	pru_rproc_set_firmware(rproc, NULL);
+
 	mutex_lock(&pru->lock);
 
 	if (!pru->client_np) {
-- 
2.25.1

