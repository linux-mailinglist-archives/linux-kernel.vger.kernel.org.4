Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DAF6598B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiL3NZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiL3NZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:25:05 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858BB1B1CE;
        Fri, 30 Dec 2022 05:25:04 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDOseN049185;
        Fri, 30 Dec 2022 07:24:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672406694;
        bh=WO4Y8vUCp21lFUkUdF3407m4KVYqI2VCXfKh1g4gn+E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SGw/OL+XqQ69OBxjr/ZkNSkaA5aqLreW4/k3Cq/UkhjY4oiEhWXmO/s6A5mGTcqeh
         kvBmjGxi6eg8216QCSRbjccOD5cRDS3CKtSzMN7pK7LYrJnAgSLEkKr+b52+Ur1l5K
         GDEsnsuT7VrJnfbzWpbvPjsqaCu9uLPnv6m3Olyw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BUDOs0t099954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Dec 2022 07:24:54 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 30
 Dec 2022 07:24:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 30 Dec 2022 07:24:54 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDOsVp016910;
        Fri, 30 Dec 2022 07:24:54 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v2 2/2] remoteproc: k3-c7x: Add support for C7xv DSP on AM62A SoC
Date:   Fri, 30 Dec 2022 07:24:53 -0600
Message-ID: <20221230132453.32022-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221230132453.32022-1-hnagalla@ti.com>
References: <20221230132453.32022-1-hnagalla@ti.com>
MIME-Version: 1.0
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

From: Jai Luthra <j-luthra@ti.com>

Add support to the K3 DSP remoteproc driver to configure the C7xv
subsystem core on AM62A SoCs. The C7xv susbsytem is based on C71 DSP
with anlytics engine for deep learning purposes. The remoteproc
handling for device management is similar to the C66/C71 DSPs on K3
J7 family SoCs, even though there are additional hardware accelerators
and IP updates to C7xv subsystem.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
-----
V2: Correct original author and order of Signed-off-by
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index eb9c64f7b9b4..ec626a37fef6 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -870,6 +870,10 @@ static const struct k3_dsp_mem_data c71_mems[] = {
 	{ .name = "l1dram", .dev_addr = 0xe00000 },
 };
 
+static const struct k3_dsp_mem_data c7xv_mems[] = {
+	{ .name = "l2sram", .dev_addr = 0x800000 },
+};
+
 static const struct k3_dsp_dev_data c66_data = {
 	.mems = c66_mems,
 	.num_mems = ARRAY_SIZE(c66_mems),
@@ -884,10 +888,18 @@ static const struct k3_dsp_dev_data c71_data = {
 	.uses_lreset = false,
 };
 
+static const struct k3_dsp_dev_data c7xv_data = {
+	.mems = c7xv_mems,
+	.num_mems = ARRAY_SIZE(c7xv_mems),
+	.boot_align_addr = SZ_2M,
+	.uses_lreset = false,
+};
+
 static const struct of_device_id k3_dsp_of_match[] = {
 	{ .compatible = "ti,j721e-c66-dsp", .data = &c66_data, },
 	{ .compatible = "ti,j721e-c71-dsp", .data = &c71_data, },
 	{ .compatible = "ti,j721s2-c71-dsp", .data = &c71_data, },
+	{ .compatible = "ti,am62a-c7xv-dsp", .data = &c7xv_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, k3_dsp_of_match);
-- 
2.17.1

