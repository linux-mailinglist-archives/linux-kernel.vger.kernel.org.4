Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5A62D3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiKQG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:57:04 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A87605B588
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:57:02 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowADHZ2k123VjvyIjCg--.10142S2;
        Thu, 17 Nov 2022 14:56:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     p.zabel@pengutronix.de, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] media: coda: Add check for dcoda_iram_alloc
Date:   Thu, 17 Nov 2022 14:56:52 +0800
Message-Id: <20221117065652.44426-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHZ2k123VjvyIjCg--.10142S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxJrWfXw4UZr1kGF13twb_yoW8Xr4kpa
        yrtr4jyrWrJr9FkF1qyw1ruF98Jrn5WayY9F17Z3s5ZFnxAr4rury5GFy8uFWkAr1rJF1U
        tF93trWfX3WjkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0iiSUUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the coda_iram_alloc may return NULL pointer,
it should be better to check the return value
in order to avoid NULL poineter dereference,
same as the others.

Fixes: b313bcc9a467 ("[media] coda: simplify IRAM setup")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/media/platform/chips-media/coda-bit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/coda-bit.c b/drivers/media/platform/chips-media/coda-bit.c
index 2736a902e3df..6d816fd69a17 100644
--- a/drivers/media/platform/chips-media/coda-bit.c
+++ b/drivers/media/platform/chips-media/coda-bit.c
@@ -854,7 +854,7 @@ static void coda_setup_iram(struct coda_ctx *ctx)
 		/* Only H.264BP and H.263P3 are considered */
 		iram_info->buf_dbk_y_use = coda_iram_alloc(iram_info, w64);
 		iram_info->buf_dbk_c_use = coda_iram_alloc(iram_info, w64);
-		if (!iram_info->buf_dbk_c_use)
+		if (!iram_info->buf_dbk_y_use || !iram_info->buf_dbk_c_use)
 			goto out;
 		iram_info->axi_sram_use |= dbk_bits;
 
@@ -878,7 +878,7 @@ static void coda_setup_iram(struct coda_ctx *ctx)
 
 		iram_info->buf_dbk_y_use = coda_iram_alloc(iram_info, w128);
 		iram_info->buf_dbk_c_use = coda_iram_alloc(iram_info, w128);
-		if (!iram_info->buf_dbk_c_use)
+		if (!iram_info->buf_dbk_y_use || !iram_info->buf_dbk_c_use)
 			goto out;
 		iram_info->axi_sram_use |= dbk_bits;
 
-- 
2.25.1

