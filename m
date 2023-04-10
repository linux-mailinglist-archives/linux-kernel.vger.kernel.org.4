Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A336DC671
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDJL61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJL6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:58:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8FAC2D79
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:58:22 -0700 (PDT)
Received: from loongson.cn (unknown [121.236.115.151])
        by gateway (Coremail) with SMTP id _____8Cxxtjc+TNk0hYZAA--.38463S3;
        Mon, 10 Apr 2023 19:58:20 +0800 (CST)
Received: from localhost.localdomain (unknown [121.236.115.151])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxfb7W+TNk33McAA--.54982S2;
        Mon, 10 Apr 2023 19:58:18 +0800 (CST)
From:   WANG rui <wangrui@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, WANG rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Improve memory ops
Date:   Mon, 10 Apr 2023 19:57:34 +0800
Message-Id: <20230410115734.93365-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxfb7W+TNk33McAA--.54982S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvAXoWfWw1UCFWfJw48Kw4xXFW3trb_yoW8Zw1xWo
        W3Zr4qkws3W3y3uF9rWw47Jw18urWxCryaqrW8Aw18Wr93GFW7WrZ8uFs5u343Xrn8KrW7
        WwnruwsrWF4xKr1Un29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a jump table to dispatch cases for short data lengths, and for long data
lengths, we use unaligned memory access instruction to process the first and
last 8 bytes. The data in the middle is processed at an aligned destination
address.

We have tested micro-bench[1] on a Loongson-3C5000 16-core machine (2.2GHz):

1. memset

| length | src offset | dst offset | speed before | speed after | %       |
|--------|------------|------------|--------------|-------------|---------|
| 8      | 0          | 0          | 696.191      | 1518.785    | 118.16% |
| 8      | 0          | 1          | 696.325      | 1518.937    | 118.14% |
| 50     | 0          | 0          | 969.976      | 8053.902    | 730.32% |
| 50     | 0          | 1          | 970.034      | 8058.475    | 730.74% |
| 300    | 0          | 0          | 5876.612     | 16544.703   | 181.53% |
| 300    | 0          | 1          | 5030.849     | 16549.011   | 228.95% |
| 1200   | 0          | 0          | 11797.077    | 16752.137   | 42.00%  |
| 1200   | 0          | 1          | 5687.141     | 16645.233   | 192.68% |
| 4000   | 0          | 0          | 15723.27     | 16761.557   | 6.60%   |
| 4000   | 0          | 1          | 5906.114     | 16732.316   | 183.30% |
| 8000   | 0          | 0          | 16751.403    | 16770.002   | 0.11%   |
| 8000   | 0          | 1          | 5995.449     | 16754.07    | 179.45% |

2. memcpy

| length | src offset | dst offset | speed before | speed after | %       |
|--------|------------|------------|--------------|-------------|---------|
| 8      | 0          | 0          | 696.2        | 1670.605    | 139.96% |
| 8      | 0          | 1          | 696.325      | 1671.138    | 139.99% |
| 50     | 0          | 0          | 969.974      | 8724.999    | 799.51% |
| 50     | 0          | 1          | 970.032      | 8730.138    | 799.98% |
| 300    | 0          | 0          | 5564.662     | 16272.652   | 192.43% |
| 300    | 0          | 1          | 4670.436     | 14972.842   | 220.59% |
| 1200   | 0          | 0          | 10740.23     | 16751.728   | 55.97%  |
| 1200   | 0          | 1          | 5027.741     | 14874.564   | 195.85% |
| 4000   | 0          | 0          | 15122.367    | 16737.642   | 10.68%  |
| 4000   | 0          | 1          | 5536.918     | 14890.397   | 168.93% |
| 8000   | 0          | 0          | 16505.453    | 16553.543   | 0.29%   |
| 8000   | 0          | 1          | 5821.619     | 14841.804   | 154.94% |

3. memmove

| length | src offset | dst offset | speed before | speed after | %       |
|--------|------------|------------|--------------|-------------|---------|
| 8      | 0          | 0          | 982.693      | 1670.568    | 70.00%  |
| 8      | 0          | 1          | 983.023      | 1671.174    | 70.00%  |
| 50     | 0          | 0          | 1230.87      | 8727.625    | 609.06% |
| 50     | 0          | 1          | 1232.515     | 8730.138    | 608.32% |
| 300    | 0          | 0          | 6490.375     | 16296.993   | 151.09% |
| 300    | 0          | 1          | 4282.687     | 14972.842   | 249.61% |
| 1200   | 0          | 0          | 11742.755    | 16752.546   | 42.66%  |
| 1200   | 0          | 1          | 5039.338     | 14872.951   | 195.14% |
| 4000   | 0          | 0          | 15467.786    | 16737.09    | 8.21%   |
| 4000   | 0          | 1          | 5009.905     | 14890.542   | 197.22% |
| 8000   | 0          | 0          | 16489.664    | 16553.273   | 0.39%   |
| 8000   | 0          | 1          | 5823.786     | 14858.646   | 155.14% |

* speed: MB/s
* length: byte

[1] https://github.com/heiher/mem-bench

Signed-off-by: WANG rui <wangrui@loongson.cn>
---
 arch/loongarch/lib/clear_user.S | 137 +++++++++++++++--
 arch/loongarch/lib/copy_user.S  | 251 +++++++++++++++++++++++++-------
 arch/loongarch/lib/memcpy.S     | 147 +++++++++++++++----
 arch/loongarch/lib/memmove.S    | 120 ++++++++-------
 arch/loongarch/lib/memset.S     | 117 ++++++++++++---
 5 files changed, 605 insertions(+), 167 deletions(-)

diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
index 2dc48e61a2c8..02f112b265cd 100644
--- a/arch/loongarch/lib/clear_user.S
+++ b/arch/loongarch/lib/clear_user.S
@@ -13,7 +13,14 @@
 
 .irp to, 0, 1, 2, 3, 4, 5, 6, 7
 .L_fixup_handle_\to\():
-	addi.d	a0, a1, (\to) * (-8)
+	sub.d	a0, a2, a0
+	addi.d	a0, a0, (\to) * (-8)
+	jr	ra
+.endr
+
+.irp to, 0, 2, 4
+.L_fixup_handle_s\to\():
+	addi.d	a0, a1, -\to
 	jr	ra
 .endr
 
@@ -44,7 +51,7 @@ SYM_FUNC_START(__clear_user_generic)
 2:	move	a0, a1
 	jr	ra
 
-	_asm_extable 1b, .L_fixup_handle_0
+	_asm_extable 1b, .L_fixup_handle_s0
 SYM_FUNC_END(__clear_user_generic)
 
 /*
@@ -54,12 +61,22 @@ SYM_FUNC_END(__clear_user_generic)
  * a1: size
  */
 SYM_FUNC_START(__clear_user_fast)
-	beqz	a1, 10f
+	sltui	t0, a1, 9
+	bnez	t0, .Lsmall
 
-	ori	a2, zero, 64
-	blt	a1, a2, 9f
+	add.d	a2, a0, a1
+0:	st.d	zero, a0, 0
+
+	/* align up address */
+	andi	t1, a0, 7
+	sub.d	a0, a0, t1
+	addi.d	a0, a0, 8
+
+	addi.d	a3, a2, -64
+	bgeu	a0, a3, .Llt64
 
 	/* set 64 bytes at a time */
+.Lloop64:
 1:	st.d	zero, a0, 0
 2:	st.d	zero, a0, 8
 3:	st.d	zero, a0, 16
@@ -68,24 +85,95 @@ SYM_FUNC_START(__clear_user_fast)
 6:	st.d	zero, a0, 40
 7:	st.d	zero, a0, 48
 8:	st.d	zero, a0, 56
-
 	addi.d	a0, a0, 64
-	addi.d	a1, a1, -64
-	bge	a1, a2, 1b
-
-	beqz	a1, 10f
+	bltu	a0, a3, .Lloop64
 
 	/* set the remaining bytes */
-9:	st.b	zero, a0, 0
-	addi.d	a0, a0, 1
-	addi.d	a1, a1, -1
-	bgt	a1, zero, 9b
+.Llt64:
+	addi.d	a3, a2, -32
+	bgeu	a0, a3, .Llt32
+9:	st.d	zero, a0, 0
+10:	st.d	zero, a0, 8
+11:	st.d	zero, a0, 16
+12:	st.d	zero, a0, 24
+	addi.d	a0, a0, 32
+
+.Llt32:
+	addi.d	a3, a2, -16
+	bgeu	a0, a3, .Llt16
+13:	st.d	zero, a0, 0
+14:	st.d	zero, a0, 8
+	addi.d	a0, a0, 16
+
+.Llt16:
+	addi.d	a3, a2, -8
+	bgeu	a0, a3, .Llt8
+15:	st.d	zero, a0, 0
+
+.Llt8:
+16:	st.d	zero, a2, -8
 
 	/* return */
-10:	move	a0, a1
+	move	a0, zero
+	jr	ra
+
+	.align	4
+.Lsmall:
+	pcaddi	t0, 4
+	slli.d	a2, a1, 4
+	add.d	t0, t0, a2
+	jr	t0
+
+	.align	4
+	move	a0, zero
+	jr	ra
+
+	.align	4
+17:	st.b	zero, a0, 0
+	move	a0, zero
+	jr	ra
+
+	.align	4
+18:	st.h	zero, a0, 0
+	move	a0, zero
+	jr	ra
+
+	.align	4
+19:	st.h	zero, a0, 0
+20:	st.b	zero, a0, 2
+	move	a0, zero
+	jr	ra
+
+	.align	4
+21:	st.w	zero, a0, 0
+	move	a0, zero
+	jr	ra
+
+	.align	4
+22:	st.w	zero, a0, 0
+23:	st.b	zero, a0, 4
+	move	a0, zero
+	jr	ra
+
+	.align	4
+24:	st.w	zero, a0, 0
+25:	st.h	zero, a0, 4
+	move	a0, zero
+	jr	ra
+
+	.align	4
+26:	st.w	zero, a0, 0
+27:	st.w	zero, a0, 3
+	move	a0, zero
+	jr	ra
+
+	.align	4
+28:	st.d	zero, a0, 0
+	move	a0, zero
 	jr	ra
 
 	/* fixup and ex_table */
+	_asm_extable 0b, .L_fixup_handle_0
 	_asm_extable 1b, .L_fixup_handle_0
 	_asm_extable 2b, .L_fixup_handle_1
 	_asm_extable 3b, .L_fixup_handle_2
@@ -95,4 +183,23 @@ SYM_FUNC_START(__clear_user_fast)
 	_asm_extable 7b, .L_fixup_handle_6
 	_asm_extable 8b, .L_fixup_handle_7
 	_asm_extable 9b, .L_fixup_handle_0
+	_asm_extable 10b, .L_fixup_handle_1
+	_asm_extable 11b, .L_fixup_handle_2
+	_asm_extable 12b, .L_fixup_handle_3
+	_asm_extable 13b, .L_fixup_handle_0
+	_asm_extable 14b, .L_fixup_handle_1
+	_asm_extable 15b, .L_fixup_handle_0
+	_asm_extable 16b, .L_fixup_handle_1
+	_asm_extable 17b, .L_fixup_handle_s0
+	_asm_extable 18b, .L_fixup_handle_s0
+	_asm_extable 19b, .L_fixup_handle_s0
+	_asm_extable 20b, .L_fixup_handle_s2
+	_asm_extable 21b, .L_fixup_handle_s0
+	_asm_extable 22b, .L_fixup_handle_s0
+	_asm_extable 23b, .L_fixup_handle_s4
+	_asm_extable 24b, .L_fixup_handle_s0
+	_asm_extable 25b, .L_fixup_handle_s4
+	_asm_extable 26b, .L_fixup_handle_s0
+	_asm_extable 27b, .L_fixup_handle_s4
+	_asm_extable 28b, .L_fixup_handle_s0
 SYM_FUNC_END(__clear_user_fast)
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
index 55ac6020a1ad..b21f6d5d38f5 100644
--- a/arch/loongarch/lib/copy_user.S
+++ b/arch/loongarch/lib/copy_user.S
@@ -13,7 +13,14 @@
 
 .irp to, 0, 1, 2, 3, 4, 5, 6, 7
 .L_fixup_handle_\to\():
-	addi.d	a0, a2, (\to) * (-8)
+	sub.d	a0, a2, a0
+	addi.d	a0, a0, (\to) * (-8)
+	jr	ra
+.endr
+
+.irp to, 0, 2, 4
+.L_fixup_handle_s\to\():
+	addi.d	a0, a2, -\to
 	jr	ra
 .endr
 
@@ -47,8 +54,8 @@ SYM_FUNC_START(__copy_user_generic)
 3:	move	a0, a2
 	jr	ra
 
-	_asm_extable 1b, .L_fixup_handle_0
-	_asm_extable 2b, .L_fixup_handle_0
+	_asm_extable 1b, .L_fixup_handle_s0
+	_asm_extable 2b, .L_fixup_handle_s0
 SYM_FUNC_END(__copy_user_generic)
 
 /*
@@ -59,65 +66,209 @@ SYM_FUNC_END(__copy_user_generic)
  * a2: n
  */
 SYM_FUNC_START(__copy_user_fast)
-	beqz	a2, 19f
+	sltui	t0, a2, 9
+	bnez	t0, .Lsmall
 
-	ori	a3, zero, 64
-	blt	a2, a3, 17f
+	add.d	a3, a1, a2
+	add.d	a2, a0, a2
+0:	ld.d	t0, a1, 0
+1:	st.d	t0, a0, 0
 
-	/* copy 64 bytes at a time */
-1:	ld.d	t0, a1, 0
-2:	ld.d	t1, a1, 8
-3:	ld.d	t2, a1, 16
-4:	ld.d	t3, a1, 24
-5:	ld.d	t4, a1, 32
-6:	ld.d	t5, a1, 40
-7:	ld.d	t6, a1, 48
-8:	ld.d	t7, a1, 56
-9:	st.d	t0, a0, 0
-10:	st.d	t1, a0, 8
-11:	st.d	t2, a0, 16
-12:	st.d	t3, a0, 24
-13:	st.d	t4, a0, 32
-14:	st.d	t5, a0, 40
-15:	st.d	t6, a0, 48
-16:	st.d	t7, a0, 56
+	/* align up destination address */
+	andi	t1, a0, 7
+	sub.d	t0, zero, t1
+	addi.d	t0, t0, 8
+	add.d	a1, a1, t0
+	add.d	a0, a0, t0
 
-	addi.d	a0, a0, 64
-	addi.d	a1, a1, 64
-	addi.d	a2, a2, -64
-	bge	a2, a3, 1b
+	addi.d	a4, a3, -64
+	bgeu	a1, a4, .Llt64
 
-	beqz	a2, 19f
+	/* copy 64 bytes at a time */
+.Lloop64:
+2:	ld.d	t0, a1, 0
+3:	ld.d	t1, a1, 8
+4:	ld.d	t2, a1, 16
+5:	ld.d	t3, a1, 24
+6:	ld.d	t4, a1, 32
+7:	ld.d	t5, a1, 40
+8:	ld.d	t6, a1, 48
+9:	ld.d	t7, a1, 56
+	addi.d	a1, a1, 64
+10:	st.d	t0, a0, 0
+11:	st.d	t1, a0, 8
+12:	st.d	t2, a0, 16
+13:	st.d	t3, a0, 24
+14:	st.d	t4, a0, 32
+15:	st.d	t5, a0, 40
+16:	st.d	t6, a0, 48
+17:	st.d	t7, a0, 56
+	addi.d	a0, a0, 64
+	bltu	a1, a4, .Lloop64
 
 	/* copy the remaining bytes */
-17:	ld.b	t0, a1, 0
-18:	st.b	t0, a0, 0
-	addi.d	a0, a0, 1
-	addi.d	a1, a1, 1
-	addi.d	a2, a2, -1
-	bgt	a2, zero, 17b
+.Llt64:
+	addi.d	a4, a3, -32
+	bgeu	a1, a4, .Llt32
+18:	ld.d	t0, a1, 0
+19:	ld.d	t1, a1, 8
+20:	ld.d	t2, a1, 16
+21:	ld.d	t3, a1, 24
+	addi.d	a1, a1, 32
+22:	st.d	t0, a0, 0
+23:	st.d	t1, a0, 8
+24:	st.d	t2, a0, 16
+25:	st.d	t3, a0, 24
+	addi.d	a0, a0, 32
+
+.Llt32:
+	addi.d	a4, a3, -16
+	bgeu	a1, a4, .Llt16
+26:	ld.d	t0, a1, 0
+27:	ld.d	t1, a1, 8
+	addi.d	a1, a1, 16
+28:	st.d	t0, a0, 0
+29:	st.d	t1, a0, 8
+	addi.d	a0, a0, 16
+
+.Llt16:
+	addi.d	a4, a3, -8
+	bgeu	a1, a4, .Llt8
+30:	ld.d	t0, a1, 0
+31:	st.d	t0, a0, 0
+
+.Llt8:
+32:	ld.d	t0, a3, -8
+33:	st.d	t0, a2, -8
 
 	/* return */
-19:	move	a0, a2
+	move	a0, zero
+	jr	ra
+
+	.align	5
+.Lsmall:
+	pcaddi	t0, 8
+	slli.d	a3, a2, 5
+	add.d	t0, t0, a3
+	jr	t0
+
+	.align	5
+	move	a0, zero
+	jr	ra
+
+	.align	5
+34:	ld.b	t0, a1, 0
+35:	st.b	t0, a0, 0
+	move	a0, zero
+	jr	ra
+
+	.align	5
+36:	ld.h	t0, a1, 0
+37:	st.h	t0, a0, 0
+	move	a0, zero
+	jr	ra
+
+	.align	5
+38:	ld.h	t0, a1, 0
+39:	ld.b	t1, a1, 2
+40:	st.h	t0, a0, 0
+41:	st.b	t1, a0, 2
+	move	a0, zero
+	jr	ra
+
+	.align	5
+42:	ld.w	t0, a1, 0
+43:	st.w	t0, a0, 0
+	move	a0, zero
+	jr	ra
+
+	.align	5
+44:	ld.w	t0, a1, 0
+45:	ld.b	t1, a1, 4
+46:	st.w	t0, a0, 0
+47:	st.b	t1, a0, 4
+	move	a0, zero
+	jr	ra
+
+	.align	5
+48:	ld.w	t0, a1, 0
+49:	ld.h	t1, a1, 4
+50:	st.w	t0, a0, 0
+51:	st.h	t1, a0, 4
+	move	a0, zero
+	jr	ra
+
+	.align	5
+52:	ld.w	t0, a1, 0
+53:	ld.w	t1, a1, 3
+54:	st.w	t0, a0, 0
+55:	st.w	t1, a0, 3
+	move	a0, zero
+	jr	ra
+
+	.align	5
+56:	ld.d	t0, a1, 0
+57:	st.d	t0, a0, 0
+	move	a0, zero
 	jr	ra
 
 	/* fixup and ex_table */
+	_asm_extable 0b, .L_fixup_handle_0
 	_asm_extable 1b, .L_fixup_handle_0
-	_asm_extable 2b, .L_fixup_handle_1
-	_asm_extable 3b, .L_fixup_handle_2
-	_asm_extable 4b, .L_fixup_handle_3
-	_asm_extable 5b, .L_fixup_handle_4
-	_asm_extable 6b, .L_fixup_handle_5
-	_asm_extable 7b, .L_fixup_handle_6
-	_asm_extable 8b, .L_fixup_handle_7
+	_asm_extable 2b, .L_fixup_handle_0
+	_asm_extable 3b, .L_fixup_handle_0
+	_asm_extable 4b, .L_fixup_handle_0
+	_asm_extable 5b, .L_fixup_handle_0
+	_asm_extable 6b, .L_fixup_handle_0
+	_asm_extable 7b, .L_fixup_handle_0
+	_asm_extable 8b, .L_fixup_handle_0
 	_asm_extable 9b, .L_fixup_handle_0
-	_asm_extable 10b, .L_fixup_handle_1
-	_asm_extable 11b, .L_fixup_handle_2
-	_asm_extable 12b, .L_fixup_handle_3
-	_asm_extable 13b, .L_fixup_handle_4
-	_asm_extable 14b, .L_fixup_handle_5
-	_asm_extable 15b, .L_fixup_handle_6
-	_asm_extable 16b, .L_fixup_handle_7
-	_asm_extable 17b, .L_fixup_handle_0
+	_asm_extable 10b, .L_fixup_handle_0
+	_asm_extable 11b, .L_fixup_handle_1
+	_asm_extable 12b, .L_fixup_handle_2
+	_asm_extable 13b, .L_fixup_handle_3
+	_asm_extable 14b, .L_fixup_handle_4
+	_asm_extable 15b, .L_fixup_handle_5
+	_asm_extable 16b, .L_fixup_handle_6
+	_asm_extable 17b, .L_fixup_handle_7
 	_asm_extable 18b, .L_fixup_handle_0
+	_asm_extable 19b, .L_fixup_handle_0
+	_asm_extable 20b, .L_fixup_handle_0
+	_asm_extable 21b, .L_fixup_handle_0
+	_asm_extable 22b, .L_fixup_handle_0
+	_asm_extable 23b, .L_fixup_handle_1
+	_asm_extable 24b, .L_fixup_handle_2
+	_asm_extable 25b, .L_fixup_handle_3
+	_asm_extable 26b, .L_fixup_handle_0
+	_asm_extable 27b, .L_fixup_handle_0
+	_asm_extable 28b, .L_fixup_handle_0
+	_asm_extable 29b, .L_fixup_handle_1
+	_asm_extable 30b, .L_fixup_handle_0
+	_asm_extable 31b, .L_fixup_handle_0
+	_asm_extable 32b, .L_fixup_handle_0
+	_asm_extable 33b, .L_fixup_handle_1
+	_asm_extable 34b, .L_fixup_handle_s0
+	_asm_extable 35b, .L_fixup_handle_s0
+	_asm_extable 36b, .L_fixup_handle_s0
+	_asm_extable 37b, .L_fixup_handle_s0
+	_asm_extable 38b, .L_fixup_handle_s0
+	_asm_extable 39b, .L_fixup_handle_s0
+	_asm_extable 40b, .L_fixup_handle_s0
+	_asm_extable 41b, .L_fixup_handle_s2
+	_asm_extable 42b, .L_fixup_handle_s0
+	_asm_extable 43b, .L_fixup_handle_s0
+	_asm_extable 44b, .L_fixup_handle_s0
+	_asm_extable 45b, .L_fixup_handle_s0
+	_asm_extable 46b, .L_fixup_handle_s0
+	_asm_extable 47b, .L_fixup_handle_s4
+	_asm_extable 48b, .L_fixup_handle_s0
+	_asm_extable 49b, .L_fixup_handle_s0
+	_asm_extable 50b, .L_fixup_handle_s0
+	_asm_extable 51b, .L_fixup_handle_s4
+	_asm_extable 52b, .L_fixup_handle_s0
+	_asm_extable 53b, .L_fixup_handle_s0
+	_asm_extable 54b, .L_fixup_handle_s0
+	_asm_extable 55b, .L_fixup_handle_s4
+	_asm_extable 56b, .L_fixup_handle_s0
+	_asm_extable 57b, .L_fixup_handle_s0
 SYM_FUNC_END(__copy_user_fast)
diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
index 3b7e1dec7109..39ce6621c704 100644
--- a/arch/loongarch/lib/memcpy.S
+++ b/arch/loongarch/lib/memcpy.S
@@ -44,6 +44,66 @@ SYM_FUNC_START(__memcpy_generic)
 SYM_FUNC_END(__memcpy_generic)
 _ASM_NOKPROBE(__memcpy_generic)
 
+	.align	5
+SYM_FUNC_START_NOALIGN(__memcpy_small)
+	pcaddi	t0, 8
+	slli.d	a2, a2, 5
+	add.d	t0, t0, a2
+	jr	t0
+
+	.align	5
+0:	jr	ra
+
+	.align	5
+1:	ld.b	t0, a1, 0
+	st.b	t0, a0, 0
+	jr	ra
+
+	.align	5
+2:	ld.h	t0, a1, 0
+	st.h	t0, a0, 0
+	jr	ra
+
+	.align	5
+3:	ld.h	t0, a1, 0
+	ld.b	t1, a1, 2
+	st.h	t0, a0, 0
+	st.b	t1, a0, 2
+	jr	ra
+
+	.align	5
+4:	ld.w	t0, a1, 0
+	st.w	t0, a0, 0
+	jr	ra
+
+	.align	5
+5:	ld.w	t0, a1, 0
+	ld.b	t1, a1, 4
+	st.w	t0, a0, 0
+	st.b	t1, a0, 4
+	jr	ra
+
+	.align	5
+6:	ld.w	t0, a1, 0
+	ld.h	t1, a1, 4
+	st.w	t0, a0, 0
+	st.h	t1, a0, 4
+	jr	ra
+
+	.align	5
+7:	ld.w	t0, a1, 0
+	ld.w	t1, a1, 3
+	st.w	t0, a0, 0
+	st.w	t1, a0, 3
+	jr	ra
+
+	.align	5
+8:	ld.d	t0, a1, 0
+	st.d	t0, a0, 0
+	jr	ra
+SYM_FUNC_END(__memcpy_small)
+_ASM_NOKPROBE(__memcpy_small)
+
 /*
  * void *__memcpy_fast(void *dst, const void *src, size_t n)
  *
@@ -52,14 +112,27 @@ _ASM_NOKPROBE(__memcpy_generic)
  * a2: n
  */
 SYM_FUNC_START(__memcpy_fast)
-	move	a3, a0
-	beqz	a2, 3f
+	sltui	t0, a2, 9
+	bnez	t0, __memcpy_small
+
+	add.d	a3, a1, a2
+	add.d	a2, a0, a2
+	ld.d	a6, a1, 0
+	ld.d	a7, a3, -8
+
+	/* align up destination address */
+	andi	t1, a0, 7
+	sub.d	t0, zero, t1
+	addi.d	t0, t0, 8
+	add.d	a1, a1, t0
+	add.d	a5, a0, t0
 
-	ori	a4, zero, 64
-	blt	a2, a4, 2f
+	addi.d	a4, a3, -64
+	bgeu	a1, a4, .Llt64
 
 	/* copy 64 bytes at a time */
-1:	ld.d	t0, a1, 0
+.Lloop64:
+	ld.d	t0, a1, 0
 	ld.d	t1, a1, 8
 	ld.d	t2, a1, 16
 	ld.d	t3, a1, 24
@@ -67,32 +140,54 @@ SYM_FUNC_START(__memcpy_fast)
 	ld.d	t5, a1, 40
 	ld.d	t6, a1, 48
 	ld.d	t7, a1, 56
-	st.d	t0, a0, 0
-	st.d	t1, a0, 8
-	st.d	t2, a0, 16
-	st.d	t3, a0, 24
-	st.d	t4, a0, 32
-	st.d	t5, a0, 40
-	st.d	t6, a0, 48
-	st.d	t7, a0, 56
-
-	addi.d	a0, a0, 64
 	addi.d	a1, a1, 64
-	addi.d	a2, a2, -64
-	bge	a2, a4, 1b
-
-	beqz	a2, 3f
+	st.d	t0, a5, 0
+	st.d	t1, a5, 8
+	st.d	t2, a5, 16
+	st.d	t3, a5, 24
+	st.d	t4, a5, 32
+	st.d	t5, a5, 40
+	st.d	t6, a5, 48
+	st.d	t7, a5, 56
+	addi.d	a5, a5, 64
+	bltu	a1, a4, .Lloop64
 
 	/* copy the remaining bytes */
-2:	ld.b	t0, a1, 0
-	st.b	t0, a0, 0
-	addi.d	a0, a0, 1
-	addi.d	a1, a1, 1
-	addi.d	a2, a2, -1
-	bgt	a2, zero, 2b
+.Llt64:
+	addi.d	a4, a3, -32
+	bgeu	a1, a4, .Llt32
+	ld.d	t0, a1, 0
+	ld.d	t1, a1, 8
+	ld.d	t2, a1, 16
+	ld.d	t3, a1, 24
+	addi.d	a1, a1, 32
+	st.d	t0, a5, 0
+	st.d	t1, a5, 8
+	st.d	t2, a5, 16
+	st.d	t3, a5, 24
+	addi.d	a5, a5, 32
+
+.Llt32:
+	addi.d	a4, a3, -16
+	bgeu	a1, a4, .Llt16
+	ld.d	t0, a1, 0
+	ld.d	t1, a1, 8
+	addi.d	a1, a1, 16
+	st.d	t0, a5, 0
+	st.d	t1, a5, 8
+	addi.d	a5, a5, 16
+
+.Llt16:
+	addi.d	a4, a3, -8
+	bgeu	a1, a4, .Llt8
+	ld.d	t0, a1, 0
+	st.d	t0, a5, 0
+
+.Llt8:
+	st.d	a6, a0, 0
+	st.d	a7, a2, -8
 
 	/* return */
-3:	move	a0, a3
 	jr	ra
 SYM_FUNC_END(__memcpy_fast)
 _ASM_NOKPROBE(__memcpy_fast)
diff --git a/arch/loongarch/lib/memmove.S b/arch/loongarch/lib/memmove.S
index b796c3d6da05..45b725ba7867 100644
--- a/arch/loongarch/lib/memmove.S
+++ b/arch/loongarch/lib/memmove.S
@@ -11,23 +11,9 @@
 #include <asm/regdef.h>
 
 SYM_FUNC_START(memmove)
-	blt	a0, a1, 1f	/* dst < src, memcpy */
-	blt	a1, a0, 3f	/* src < dst, rmemcpy */
+	blt	a0, a1, memcpy	/* dst < src, memcpy */
+	blt	a1, a0, rmemcpy	/* src < dst, rmemcpy */
 	jr	ra		/* dst == src, return */
-
-	/* if (src - dst) < 64, copy 1 byte at a time */
-1:	ori	a3, zero, 64
-	sub.d	t0, a1, a0
-	blt	t0, a3, 2f
-	b	memcpy
-2:	b	__memcpy_generic
-
-	/* if (dst - src) < 64, copy 1 byte at a time */
-3:	ori	a3, zero, 64
-	sub.d	t0, a0, a1
-	blt	t0, a3, 4f
-	b	rmemcpy
-4:	b	__rmemcpy_generic
 SYM_FUNC_END(memmove)
 _ASM_NOKPROBE(memmove)
 
@@ -76,50 +62,80 @@ _ASM_NOKPROBE(__rmemcpy_generic)
  * a2: n
  */
 SYM_FUNC_START(__rmemcpy_fast)
-	move	a3, a0
-	beqz	a2, 3f
+	sltui	t0, a2, 9
+	bnez	t0, __memcpy_small
 
-	add.d	a0, a0, a2
-	add.d	a1, a1, a2
+	add.d	a3, a1, a2
+	add.d	a2, a0, a2
+	ld.d	a6, a1, 0
+	ld.d	a7, a3, -8
+
+	/* align up destination address */
+	andi	t1, a2, 7
+	sub.d	a3, a3, t1
+	sub.d	a5, a2, t1
 
-	ori	a4, zero, 64
-	blt	a2, a4, 2f
+	addi.d	a4, a1, 64
+	bgeu	a4, a3, .Llt64
 
 	/* copy 64 bytes at a time */
-1:	ld.d	t0, a1, -8
-	ld.d	t1, a1, -16
-	ld.d	t2, a1, -24
-	ld.d	t3, a1, -32
-	ld.d	t4, a1, -40
-	ld.d	t5, a1, -48
-	ld.d	t6, a1, -56
-	ld.d	t7, a1, -64
-	st.d	t0, a0, -8
-	st.d	t1, a0, -16
-	st.d	t2, a0, -24
-	st.d	t3, a0, -32
-	st.d	t4, a0, -40
-	st.d	t5, a0, -48
-	st.d	t6, a0, -56
-	st.d	t7, a0, -64
-
-	addi.d	a0, a0, -64
-	addi.d	a1, a1, -64
-	addi.d	a2, a2, -64
-	bge	a2, a4, 1b
-
-	beqz	a2, 3f
+.Lloop64:
+	ld.d	t0, a3, -8
+	ld.d	t1, a3, -16
+	ld.d	t2, a3, -24
+	ld.d	t3, a3, -32
+	ld.d	t4, a3, -40
+	ld.d	t5, a3, -48
+	ld.d	t6, a3, -56
+	ld.d	t7, a3, -64
+	addi.d	a3, a3, -64
+	st.d	t0, a5, -8
+	st.d	t1, a5, -16
+	st.d	t2, a5, -24
+	st.d	t3, a5, -32
+	st.d	t4, a5, -40
+	st.d	t5, a5, -48
+	st.d	t6, a5, -56
+	st.d	t7, a5, -64
+	addi.d	a5, a5, -64
+	bltu	a4, a3, .Lloop64
 
 	/* copy the remaining bytes */
-2:	ld.b	t0, a1, -1
-	st.b	t0, a0, -1
-	addi.d	a0, a0, -1
-	addi.d	a1, a1, -1
-	addi.d	a2, a2, -1
-	bgt	a2, zero, 2b
+.Llt64:
+	addi.d	a4, a1, 32
+	bgeu	a4, a3, .Llt32
+	ld.d	t0, a3, -8
+	ld.d	t1, a3, -16
+	ld.d	t2, a3, -24
+	ld.d	t3, a3, -32
+	addi.d	a3, a3, -32
+	st.d	t0, a5, -8
+	st.d	t1, a5, -16
+	st.d	t2, a5, -24
+	st.d	t3, a5, -32
+	addi.d	a5, a5, -32
+
+.Llt32:
+	addi.d	a4, a1, 16
+	bgeu	a4, a3, .Llt16
+	ld.d	t0, a3, -8
+	ld.d	t1, a3, -16
+	addi.d	a3, a3, -16
+	st.d	t0, a5, -8
+	st.d	t1, a5, -16
+	addi.d	a5, a5, -16
+
+.Llt16:
+	addi.d	a4, a1, 8
+	bgeu	a4, a3, .Llt8
+	ld.d	t0, a3, -8
+	st.d	t0, a5, -8
+
+.Llt8:
+	st.d	a6, a0, 0
+	st.d	a7, a2, -8
 
 	/* return */
-3:	move	a0, a3
 	jr	ra
 SYM_FUNC_END(__rmemcpy_fast)
 _ASM_NOKPROBE(__rmemcpy_fast)
diff --git a/arch/loongarch/lib/memset.S b/arch/loongarch/lib/memset.S
index a9eb732ab2ad..c5836d916736 100644
--- a/arch/loongarch/lib/memset.S
+++ b/arch/loongarch/lib/memset.S
@@ -56,39 +56,108 @@ _ASM_NOKPROBE(__memset_generic)
  * a2: n
  */
 SYM_FUNC_START(__memset_fast)
-	move	a3, a0
-	beqz	a2, 3f
-
-	ori	a4, zero, 64
-	blt	a2, a4, 2f
-
 	/* fill a1 to 64 bits */
 	fill_to_64 a1
 
-	/* set 64 bytes at a time */
-1:	st.d	a1, a0, 0
-	st.d	a1, a0, 8
-	st.d	a1, a0, 16
-	st.d	a1, a0, 24
-	st.d	a1, a0, 32
-	st.d	a1, a0, 40
-	st.d	a1, a0, 48
-	st.d	a1, a0, 56
+	sltui	t0, a2, 9
+	bnez	t0, .Lsmall
 
-	addi.d	a0, a0, 64
-	addi.d	a2, a2, -64
-	bge	a2, a4, 1b
+	add.d	a2, a0, a2
+	st.d	a1, a0, 0
 
-	beqz	a2, 3f
+	/* align up address */
+	andi	t1, a0, 7
+	sub.d	a3, a0, t1
+	addi.d	a3, a3, 8
+
+	addi.d	a4, a2, -64
+	bgeu	a3, a4, .Llt64
+
+	/* set 64 bytes at a time */
+.Lloop64:
+	st.d	a1, a3, 0
+	st.d	a1, a3, 8
+	st.d	a1, a3, 16
+	st.d	a1, a3, 24
+	st.d	a1, a3, 32
+	st.d	a1, a3, 40
+	st.d	a1, a3, 48
+	st.d	a1, a3, 56
+	addi.d	a3, a3, 64
+	bltu	a3, a4, .Lloop64
 
 	/* set the remaining bytes */
-2:	st.b	a1, a0, 0
-	addi.d	a0, a0, 1
-	addi.d	a2, a2, -1
-	bgt	a2, zero, 2b
+.Llt64:
+	addi.d	a4, a2, -32
+	bgeu	a3, a4, .Llt32
+	st.d	a1, a3, 0
+	st.d	a1, a3, 8
+	st.d	a1, a3, 16
+	st.d	a1, a3, 24
+	addi.d	a3, a3, 32
+
+.Llt32:
+	addi.d	a4, a2, -16
+	bgeu	a3, a4, .Llt16
+	st.d	a1, a3, 0
+	st.d	a1, a3, 8
+	addi.d	a3, a3, 16
+
+.Llt16:
+	addi.d	a4, a2, -8
+	bgeu	a3, a4, .Llt8
+	st.d	a1, a3, 0
+
+.Llt8:
+	st.d	a1, a2, -8
 
 	/* return */
-3:	move	a0, a3
+	jr	ra
+
+	.align	4
+.Lsmall:
+	pcaddi	t0, 4
+	slli.d	a2, a2, 4
+	add.d	t0, t0, a2
+	jr	t0
+
+	.align	4
+0:	jr	ra
+
+	.align	4
+1:	st.b	a1, a0, 0
+	jr	ra
+
+	.align	4
+2:	st.h	a1, a0, 0
+	jr	ra
+
+	.align	4
+3:	st.h	a1, a0, 0
+	st.b	a1, a0, 2
+	jr	ra
+
+	.align	4
+4:	st.w	a1, a0, 0
+	jr	ra
+
+	.align	4
+5:	st.w	a1, a0, 0
+	st.b	a1, a0, 4
+	jr	ra
+
+	.align	4
+6:	st.w	a1, a0, 0
+	st.h	a1, a0, 4
+	jr	ra
+
+	.align	4
+7:	st.w	a1, a0, 0
+	st.w	a1, a0, 3
+	jr	ra
+
+	.align	4
+8:	st.d	a1, a0, 0
 	jr	ra
 SYM_FUNC_END(__memset_fast)
 _ASM_NOKPROBE(__memset_fast)
-- 
2.40.0

