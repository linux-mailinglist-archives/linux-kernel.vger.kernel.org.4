Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82364588C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLGLF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLGLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:04:33 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549C630A;
        Wed,  7 Dec 2022 03:04:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B7B4LLa078630;
        Wed, 7 Dec 2022 05:04:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670411061;
        bh=8DMjwoVcaTgMOVJ9MjFsn5UCeByA+Y1reowlH1xE1uQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lv8ryXccuXBugelr8SIymOyyvSRb49R3+P7FhP99ADwYKKgZu38NXpPSOsQiFOmNd
         67VzMdsWzfbPFYxXQPMfaCKvXY0O4Oq/EtPnPKEzU88SXRMTTRus3dveDfCA+Hlf6n
         gR8R/DE+0OeNkL6lXC4tX7IZoGby620VNJZ7PMgQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B7B4L7I049236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 05:04:21 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 7
 Dec 2022 05:04:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 7 Dec 2022 05:04:21 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B7B4L9G092577;
        Wed, 7 Dec 2022 05:04:21 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2B7B4Kxx004499;
        Wed, 7 Dec 2022 05:04:20 -0600
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
Subject: [PATCH v11 3/6] remoteproc: pru: Add APIs to get and put the PRU cores
Date:   Wed, 7 Dec 2022 16:34:08 +0530
Message-ID: <20221207110411.441692-4-danishanwar@ti.com>
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

Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
driver to allow client drivers to acquire and release the remoteproc
device associated with a PRU core. The PRU cores are treated as
resources with only one client owning it at a time.

The pru_rproc_get() function returns the rproc handle corresponding
to a PRU core identified by the device tree "ti,prus" property under
the client node. The pru_rproc_put() is the complementary function
to pru_rproc_get().

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 133 ++++++++++++++++++++++++++++++++-
 include/linux/pruss.h          |  29 +++++++
 2 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index a1a208b31846..7d4ed39b3772 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -2,12 +2,14 @@
 /*
  * PRU-ICSS remoteproc driver for various TI SoCs
  *
- * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Author(s):
  *	Suman Anna <s-anna@ti.com>
  *	Andrew F. Davis <afd@ti.com>
  *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
+ *	Puranjay Mohan <p-mohan@ti.com>
+ *	Md Danish Anwar <danishanwar@ti.com>
  */
 
 #include <linux/bitops.h>
@@ -112,6 +114,8 @@ struct pru_private_data {
  * @rproc: remoteproc pointer for this PRU core
  * @data: PRU core specific data
  * @mem_regions: data for each of the PRU memory regions
+ * @client_np: client device node
+ * @lock: mutex to protect client usage
  * @fw_name: name of firmware image used during loading
  * @mapped_irq: virtual interrupt numbers of created fw specific mapping
  * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
@@ -127,6 +131,8 @@ struct pru_rproc {
 	struct rproc *rproc;
 	const struct pru_private_data *data;
 	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
+	struct device_node *client_np;
+	struct mutex lock;
 	const char *fw_name;
 	unsigned int *mapped_irq;
 	struct pru_irq_rsc *pru_interrupt_map;
@@ -147,6 +153,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
 	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
 }
 
+static struct rproc *__pru_rproc_get(struct device_node *np, int index)
+{
+	struct rproc *rproc;
+	phandle rproc_phandle;
+	int ret;
+
+	ret = of_property_read_u32_index(np, "ti,prus", index, &rproc_phandle);
+	if (ret)
+		return ERR_PTR(ret);
+
+	rproc = rproc_get_by_phandle(rproc_phandle);
+	if (!rproc) {
+		ret = -EPROBE_DEFER;
+		goto err_no_rproc_handle;
+	}
+
+	/* make sure it is PRU rproc */
+	if (!is_pru_rproc(rproc->dev.parent)) {
+		rproc_put(rproc);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return rproc;
+
+err_no_rproc_handle:
+	rproc_put(rproc);
+	return ERR_PTR(ret);
+}
+
+/**
+ * pru_rproc_get() - get the PRU rproc instance from a device node
+ * @np: the user/client device node
+ * @index: index to use for the ti,prus property
+ * @pru_id: optional pointer to return the PRU remoteproc processor id
+ *
+ * This function looks through a client device node's "ti,prus" property at
+ * index @index and returns the rproc handle for a valid PRU remote processor if
+ * found. The function allows only one user to own the PRU rproc resource at a
+ * time. Caller must call pru_rproc_put() when done with using the rproc, not
+ * required if the function returns a failure.
+ *
+ * When optional @pru_id pointer is passed the PRU remoteproc processor id is
+ * returned.
+ *
+ * Return: rproc handle on success, and an ERR_PTR on failure using one
+ * of the following error values
+ *    -ENODEV if device is not found
+ *    -EBUSY if PRU is already acquired by anyone
+ *    -EPROBE_DEFER is PRU device is not probed yet
+ */
+struct rproc *pru_rproc_get(struct device_node *np, int index,
+			    enum pruss_pru_id *pru_id)
+{
+	struct rproc *rproc;
+	struct pru_rproc *pru;
+	struct device *dev;
+	int ret;
+
+	rproc = __pru_rproc_get(np, index);
+	if (IS_ERR(rproc))
+		return rproc;
+
+	pru = rproc->priv;
+	dev = &rproc->dev;
+
+	mutex_lock(&pru->lock);
+
+	if (pru->client_np) {
+		mutex_unlock(&pru->lock);
+		put_device(dev);
+		ret = -EBUSY;
+		goto err_no_rproc_handle;
+	}
+
+	pru->client_np = np;
+
+	mutex_unlock(&pru->lock);
+
+	if (pru_id)
+		*pru_id = pru->id;
+
+	return rproc;
+
+err_no_rproc_handle:
+	rproc_put(rproc);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pru_rproc_get);
+
+/**
+ * pru_rproc_put() - release the PRU rproc resource
+ * @rproc: the rproc resource to release
+ *
+ * Releases the PRU rproc resource and makes it available to other
+ * users.
+ */
+void pru_rproc_put(struct rproc *rproc)
+{
+	struct pru_rproc *pru;
+
+	if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
+		return;
+
+	pru = rproc->priv;
+
+	mutex_lock(&pru->lock);
+
+	if (!pru->client_np) {
+		mutex_unlock(&pru->lock);
+		return;
+	}
+
+	pru->client_np = NULL;
+	mutex_unlock(&pru->lock);
+
+	rproc_put(rproc);
+}
+EXPORT_SYMBOL_GPL(pru_rproc_put);
+
 static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
 {
 	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
@@ -817,6 +942,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
 	pru->pruss = platform_get_drvdata(ppdev);
 	pru->rproc = rproc;
 	pru->fw_name = fw_name;
+	pru->client_np = NULL;
+	mutex_init(&pru->lock);
 
 	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -905,7 +1032,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
 
 static struct platform_driver pru_rproc_driver = {
 	.driver = {
-		.name   = "pru-rproc",
+		.name   = PRU_RPROC_DRVNAME,
 		.of_match_table = pru_rproc_match,
 		.suppress_bind_attrs = true,
 	},
@@ -917,5 +1044,7 @@ module_platform_driver(pru_rproc_driver);
 MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
 MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
 MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
+MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
+MODULE_AUTHOR("Md Danish Anwar <danishanwar@ti.com>");
 MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index fbe4fbb45807..6ea737e995e9 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -28,5 +28,34 @@ enum pruss_pru_id {
 	PRUSS_NUM_PRUS,
 };
 
+struct device_node;
+
+#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
+
+struct rproc *pru_rproc_get(struct device_node *np, int index,
+			    enum pruss_pru_id *pru_id);
+void pru_rproc_put(struct rproc *rproc);
+
+#else
+
+static inline struct rproc *
+pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void pru_rproc_put(struct rproc *rproc) { }
+
+#endif /* CONFIG_PRU_REMOTEPROC */
+
+static inline bool is_pru_rproc(struct device *dev)
+{
+	const char *drv_name = dev_driver_string(dev);
+
+	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
+		return false;
+
+	return true;
+}
 
 #endif /* __LINUX_PRUSS_H */
\ No newline at end of file
-- 
2.25.1

