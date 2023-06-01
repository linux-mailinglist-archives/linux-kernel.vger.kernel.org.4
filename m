Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B77719A67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjFAK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjFAK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:59:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8137012C;
        Thu,  1 Jun 2023 03:59:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351Ax8s5121002;
        Thu, 1 Jun 2023 05:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685617148;
        bh=Su7R47v4W5yO6beC23P257B1E8f3gfa6U+NgWZ0c6fE=;
        h=From:To:CC:Subject:Date;
        b=ILYoAtU434Bw9nLblRFw0m8HJnE2yBrkz5O91voAn1RFqb4HjzLJTt0rEpd70S5js
         MSyhffXPvZIoyUahdsQ397ivTu8wWV5fyldw0HNzAfLMASfH6rMD02GQQfaJgH94Mf
         5xgjFPnA8+1Uqt2Uz+lXQzO32ch8AwyRwFWEMAO8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351Ax8nS087594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 05:59:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 05:59:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 05:59:07 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351Ax7ZJ027859;
        Thu, 1 Jun 2023 05:59:07 -0500
Received: from localhost (uda0501179.dhcp.ti.com [10.24.69.114])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 351Ax6BY024592;
        Thu, 1 Jun 2023 05:59:06 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <rogerq@kernel.org>, <vigneshr@ti.org>, <nm@ti.com>, <srk@ti.com>,
        <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] remoteproc: pru: add support for configuring GPMUX based on client setup
Date:   Thu, 1 Jun 2023 16:29:04 +0530
Message-ID: <20230601105904.3204260-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Client device node property ti,pruss-gp-mux-sel can now be used to
configure the GPMUX config value for PRU.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 2874c8d324f7..29d3a5a930c1 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -109,6 +109,7 @@ struct pru_private_data {
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
  * @evt_count: number of mapped events
+ * @gpmux_save: saved value for gpmux config
  */
 struct pru_rproc {
 	int id;
@@ -127,6 +128,7 @@ struct pru_rproc {
 	u32 dbg_single_step;
 	u32 dbg_continuous;
 	u8 evt_count;
+	u8 gpmux_save;
 };
 
 static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
@@ -228,6 +230,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	struct device *dev;
 	const char *fw_name;
 	int ret;
+	u32 mux;
 
 	rproc = __pru_rproc_get(np, index);
 	if (IS_ERR(rproc))
@@ -252,6 +255,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	if (pru_id)
 		*pru_id = pru->id;
 
+	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
+	if (ret) {
+		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
+		goto err;
+	}
+
+	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
+					 &mux);
+	if (!ret) {
+		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
+		if (ret) {
+			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
+			goto err;
+		}
+	}
+
 	ret = of_property_read_string_index(np, "firmware-name", index,
 					    &fw_name);
 	if (!ret) {
@@ -290,6 +309,8 @@ void pru_rproc_put(struct rproc *rproc)
 
 	pru = rproc->priv;
 
+	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
+
 	pru_rproc_set_firmware(rproc, NULL);
 
 	mutex_lock(&pru->lock);
-- 
2.34.1

