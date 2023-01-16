Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E64466C3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjAPPWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjAPPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:21:49 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2391D93D;
        Mon, 16 Jan 2023 07:19:22 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30GFJ9qV009701;
        Mon, 16 Jan 2023 09:19:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673882349;
        bh=pNVQc0hSPsZL4W0FLb/+psbHVCNOFe7OY57lkawxHjU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kKQVO+C8vUuz86Cb4cvqK+UVkY3bNEGJFzinJKpykhlRWEnurg24JnoWMJ70E0b+g
         58M41KuGkV6VV1PqfgPhrNO1zhqEtF6acUZNUFDMJw453MbKBlzHpTtGNyuTT57IUn
         ylab1DD+jGJ18QxkEdYmwplgeTEm9DQmaVuOkLAg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30GFJ9D0039170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 09:19:09 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 09:19:09 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 09:19:09 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30GFJ8Ri128205;
        Mon, 16 Jan 2023 09:19:09 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v6 1/3] remoteproc: k3-r5: Simplify single core config set
Date:   Mon, 16 Jan 2023 20:49:04 +0530
Message-ID: <20230116151906.549384-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116151906.549384-1-devarsht@ti.com>
References: <20230116151906.549384-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE
is set only when cluster mode is set to
CLUSTER_MODE_SINGLECPU and cluster mode
is already configured before setting this config.

So directly check for cluster mode instead of checking
soc_data->single_cpu_mode first and then checking
cluster mode.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V6: No change
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 0481926c6975..036c9dc217f3 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -875,15 +875,14 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
 	boot_vec = 0x0;
 	if (core == core0) {
 		clr_cfg = PROC_BOOT_CFG_FLAG_R5_TEINIT;
-		if (cluster->soc_data->single_cpu_mode) {
-			/*
-			 * Single-CPU configuration bit can only be configured
-			 * on Core0 and system firmware will NACK any requests
-			 * with the bit configured, so program it only on
-			 * permitted cores
-			 */
-			if (cluster->mode == CLUSTER_MODE_SINGLECPU)
-				set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
+		/*
+		 * Single-CPU configuration bit can only be configured
+		 * on Core0 and system firmware will NACK any requests
+		 * with the bit configured, so program it only on
+		 * permitted cores
+		 */
+		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
+			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
 		} else {
 			/*
 			 * LockStep configuration bit is Read-only on Split-mode
-- 
2.34.1

