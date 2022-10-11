Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3935FACD7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJKGck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKGch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:32:37 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E38FA88DCF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:32:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowACXQEn3DUVjuM4qBA--.32718S2;
        Tue, 11 Oct 2022 14:32:24 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     christophe.leroy@csgroup.eu, qiang.zhao@nxp.com, leoyang.li@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] soc: fsl: qe: Add check for ioremap
Date:   Tue, 11 Oct 2022 14:32:22 +0800
Message-Id: <20221011063222.43572-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXQEn3DUVjuM4qBA--.32718S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW5KFWDuF1UJr48WFW7Jwb_yoW8tF1fpa
        yDJFy5Ary5KFyxuan7Jwn5XF15ua4Ik3s3G3yvg3srCwnIq34DGrsaqFyj9FsxKrWFkryr
        JF43J3Wa93WUtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Change the position of the check for ioremap.
2. Simplify the check for qe_reset.
3. Remove the 'extern' keyword.
---
 drivers/soc/fsl/qe/qe.c | 12 ++++++++----
 include/soc/fsl/qe/qe.h |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index b3c226eb5292..33f76cc5872e 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -83,11 +83,14 @@ static phys_addr_t get_qe_base(void)
 	return qebase;
 }
 
-void qe_reset(void)
+int qe_reset(void)
 {
 	if (qe_immr == NULL)
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
 
+	if (qe_immr == NULL)
+		return -ENOMEM;
+
 	qe_snums_init();
 
 	qe_issue_cmd(QE_RESET, QE_CR_SUBBLOCK_INVALID,
@@ -98,6 +101,8 @@ void qe_reset(void)
 
 	if (qe_sdma_init())
 		panic("sdma init failed!");
+
+	return 0;
 }
 
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
@@ -644,9 +649,8 @@ static int __init qe_init(void)
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (!np)
 		return -ENODEV;
-	qe_reset();
 	of_node_put(np);
-	return 0;
+	return qe_reset();
 }
 subsys_initcall(qe_init);
 
@@ -654,7 +658,7 @@ subsys_initcall(qe_init);
 static int qe_resume(struct platform_device *ofdev)
 {
 	if (!qe_alive_during_sleep())
-		qe_reset();
+		return qe_reset();
 	return 0;
 }
 
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index b02e9fe69146..f6653f4b41df 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -84,9 +84,9 @@ extern spinlock_t cmxgcr_lock;
 
 /* Export QE common operations */
 #ifdef CONFIG_QUICC_ENGINE
-extern void qe_reset(void);
+int qe_reset(void);
 #else
-static inline void qe_reset(void) {}
+static inline int qe_reset(void) {}
 #endif
 
 int cpm_muram_init(void);
-- 
2.25.1

