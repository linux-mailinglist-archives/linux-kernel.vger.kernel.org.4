Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3364C51A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiLNIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiLNIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:31:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D0C165A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:31:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxI_DFiZljJ3sFAA--.12983S3;
        Wed, 14 Dec 2022 16:31:01 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx5VbEiZljUfIuAA--.29325S2;
        Wed, 14 Dec 2022 16:31:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Correct the definition of is_branch_ins()
Date:   Wed, 14 Dec 2022 16:30:59 +0800
Message-Id: <1671006659-23859-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cx5VbEiZljUfIuAA--.29325S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr1xJw43Ww1rJFy3JFW3GFg_yoW8GrWDpF
        Z8ArZ5Gr4kKr93CFs8Ja1kZF1YyrZ3Wr42qF17Kw17ursFqw1Utrn5Gr1FyFnrKa92gr10
        qrW3Jr47WF45A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current definition of is_branch_ins() is not correct, it was
first introduced in commit 49aef111e2da ("LoongArch: Add prologue
unwinder support"), in fact, there exist three branch instruction
formats rather than only reg1i21_format.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index c00e151..42be39be 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -329,8 +329,31 @@ static inline bool is_pc_ins(union loongarch_instruction *ip)
 
 static inline bool is_branch_ins(union loongarch_instruction *ip)
 {
-	return ip->reg1i21_format.opcode >= beqz_op &&
-		ip->reg1i21_format.opcode <= bgeu_op;
+	switch (ip->reg0i26_format.opcode) {
+	case b_op:
+	case bl_op:
+		return true;
+	}
+
+	switch (ip->reg1i21_format.opcode) {
+	case beqz_op:
+	case bnez_op:
+	case bceqz_op:
+		return true;
+	}
+
+	switch (ip->reg2i16_format.opcode) {
+	case jirl_op:
+	case beq_op:
+	case bne_op:
+	case blt_op:
+	case bge_op:
+	case bltu_op:
+	case bgeu_op:
+		return true;
+	}
+
+	return false;
 }
 
 static inline bool is_ra_save_ins(union loongarch_instruction *ip)
-- 
2.1.0

