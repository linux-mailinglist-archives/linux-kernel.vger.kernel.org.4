Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C805F8277
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJHCid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJHCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:38:30 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA776127BED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:38:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowABHTbWc4kBjvPCNAw--.12816S2;
        Sat, 08 Oct 2022 10:38:20 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     qiang.zhao@nxp.com, leoyang.li@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] soc: fsl: qe: Add check for ioremap
Date:   Sat,  8 Oct 2022 10:38:18 +0800
Message-Id: <20221008023819.47679-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTbWc4kBjvPCNAw--.12816S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW5KFWDuF1UJr48Zr17Awb_yoW8trW3p3
        yDJFy5Ary5KFZ7W397Jw1kXF15uayIkas3GrWvg3s3uwnxJ34DCwsaqFyYvFsxKrWFkryr
        tF47J3W5uF1UtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbYhF7UUUUU==
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ioremap can return NULL pointer, it should
be better to check the return value return error
if fails.
Moreover, the return value of qe_reset should be
checked by cascade.

Fixes: 68f047e3d62e ("fsl/qe: add rx_sync and tx_sync for TDM mode")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/soc/fsl/qe/qe.c | 23 ++++++++++++++++++-----
 include/soc/fsl/qe/qe.h |  4 ++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index b3c226eb5292..88e335e8eef7 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -83,10 +83,13 @@ static phys_addr_t get_qe_base(void)
 	return qebase;
 }
 
-void qe_reset(void)
+int qe_reset(void)
 {
-	if (qe_immr == NULL)
+	if (qe_immr == NULL) {
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
+		if (qe_immr == NULL)
+			return -ENOMEM;
+	}
 
 	qe_snums_init();
 
@@ -98,6 +101,8 @@ void qe_reset(void)
 
 	if (qe_sdma_init())
 		panic("sdma init failed!");
+
+	return 0;
 }
 
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
@@ -640,11 +645,14 @@ EXPORT_SYMBOL(qe_get_num_of_snums);
 static int __init qe_init(void)
 {
 	struct device_node *np;
+	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (!np)
 		return -ENODEV;
-	qe_reset();
+	ret = qe_reset();
+	if (ret)
+		return ret;
 	of_node_put(np);
 	return 0;
 }
@@ -653,8 +661,13 @@ subsys_initcall(qe_init);
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx)
 static int qe_resume(struct platform_device *ofdev)
 {
-	if (!qe_alive_during_sleep())
-		qe_reset();
+	int ret;
+
+	if (!qe_alive_during_sleep()) {
+		ret = qe_reset();
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index b02e9fe69146..71129b8a5807 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -84,9 +84,9 @@ extern spinlock_t cmxgcr_lock;
 
 /* Export QE common operations */
 #ifdef CONFIG_QUICC_ENGINE
-extern void qe_reset(void);
+extern int qe_reset(void);
 #else
-static inline void qe_reset(void) {}
+static inline int qe_reset(void) {}
 #endif
 
 int cpm_muram_init(void);
-- 
2.25.1

