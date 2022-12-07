Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663E64588E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLGLFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLGLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:04:37 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D38F63BA;
        Wed,  7 Dec 2022 03:04:36 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B7B4SjX037981;
        Wed, 7 Dec 2022 05:04:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670411068;
        bh=AJIGQ1xf19B/ECiK/jFZy+fX171KnjSiBsh+JAXWCkg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IMZ5NIwp9SYN4uCocqZBL3dtMM9sxllw458IW1iwL4Wp3i5Qw7TUH+mzLjmv/K3Iu
         IkFd9EG32uwCsmTBAYtUHGoYNp+oW3XvuNCm0Assf1XuCp3MGV630suLd6qxzoETVy
         KgzuVkRAD7gpfyHqkprodoYzSCh4ka/+ZPkjnuKk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B7B4SQm106731
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 05:04:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 7
 Dec 2022 05:04:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 7 Dec 2022 05:04:28 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B7B4SoG017891;
        Wed, 7 Dec 2022 05:04:28 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2B7B4Rtl004518;
        Wed, 7 Dec 2022 05:04:27 -0600
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
Subject: [PATCH v11 6/6] remoteproc: pru: Configure firmware based on client setup
Date:   Wed, 7 Dec 2022 16:34:11 +0530
Message-ID: <20221207110411.441692-7-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207110411.441692-1-danishanwar@ti.com>
References: <20221207110411.441692-1-danishanwar@ti.com>
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

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/remoteproc/pru_rproc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index f4a34cc6bcc6..39e05623a84e 100644
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

