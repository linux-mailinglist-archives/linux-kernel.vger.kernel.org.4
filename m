Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD40B6A5410
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjB1ID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjB1IDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:03:48 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5380822000
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:03:31 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8AxJPxQtf1jymUGAA--.6379S3;
        Tue, 28 Feb 2023 16:03:28 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB707tf1jb3tAAA--.49681S4;
        Tue, 28 Feb 2023 16:03:18 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] LoongArch: Move the content defined by SYM_DATA to data or rodata section
Date:   Tue, 28 Feb 2023 16:02:53 +0800
Message-Id: <20230228080257.28807-3-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230228080257.28807-1-hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB707tf1jb3tAAA--.49681S4
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWrtFWxGF45uFy8GFyxXF1xAFb_yoW8Jr4fpr
        13ArykWrZ8KFn3Aas8Ja4F9rWDJ34DGw1ag3WqyFyrKanrWrykXrnYvr9FgFyjga1SkrWF
        qrn5J39rKa1UA3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the SYM_DATA do not give the section notes, manually set it.

Reported-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/kernel/genex.S | 2 ++
 arch/loongarch/kernel/head.S  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 1af169ca3734..de591a9270bd 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -77,7 +77,9 @@ SYM_FUNC_END(except_vec_cex)
 	668:
 	RESTORE_ALL_AND_RET
 	SYM_FUNC_END(handle_\exception)
+	.pushsection .rodata
 	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
+	.popsection
 	.endm
 
 	BUILD_HANDLER ade ade badv
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index aa64b179744f..7cfa1f850e54 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -32,9 +32,11 @@ _head:
 pe_header:
 	__EFI_PE_HEADER
 
+.pushsection .rodata
 SYM_DATA(kernel_asize, .long _end - _text);
 SYM_DATA(kernel_fsize, .long _edata - _text);
 SYM_DATA(kernel_offset, .long kernel_offset - _text);
+.popsection
 
 #endif
 
-- 
2.34.3

