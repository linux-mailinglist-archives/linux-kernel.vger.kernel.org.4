Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9E7274FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjFHC1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHC1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:27:44 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE6851BF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:27:42 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.100.1])
        by gateway (Coremail) with SMTP id _____8AxnOqdPIFkg1MAAA--.1139S3;
        Thu, 08 Jun 2023 10:27:41 +0800 (CST)
Received: from lingfengzhe-ms7c94.loongson.cn (unknown [192.168.100.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPMqcPIFkCkMGAA--.11968S2;
        Thu, 08 Jun 2023 10:27:40 +0800 (CST)
From:   Qi Hu <huqi@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Qing Zhang <zhangqing@loongson.cn>, Enze Li <lienze@kylinos.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Qi Hu <huqi@loongson.cn>, Miao HAO <haomiao19@mails.ucas.ac.cn>
Subject: [PATCH v2] LoongArch: Fix function write_fcsr
Date:   Thu,  8 Jun 2023 10:27:38 +0800
Message-Id: <20230608022738.1861729-1-huqi@loongson.cn>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPMqcPIFkCkMGAA--.11968S2
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAQCWSAc4ELYQABsl
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw1DJw18uF48uryDXw4DJrc_yoW3Wrb_X3
        WxJw4kur48Jay7Jwn0vFyrJr1093W8XFsIvF93Zr4xA3W5tr13Aw48Xw4UZr1Yk3yqqFs5
        CrW0qry5CwsxtosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbhkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWU
        JVW8JwAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYZXOUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function "write_fcsr" uses wrong asm dest. Fix it!

Reported-by: Miao HAO <haomiao19@mails.ucas.ac.cn>
Signed-off-by: Qi Hu <huqi@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index b3323ab5b78d..35e8a52fea11 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1496,7 +1496,7 @@ __BUILD_CSR_OP(tlbidx)
 #define write_fcsr(dest, val) \
 do {	\
 	__asm__ __volatile__(	\
-	"	movgr2fcsr	%0, "__stringify(dest)"	\n"	\
+	"	movgr2fcsr	"__stringify(dest)", %0	\n"	\
 	: : "r" (val));	\
 } while (0)
 
-- 
2.40.1

