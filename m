Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9916191D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKDH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiKDH0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:26:16 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176518363;
        Fri,  4 Nov 2022 00:26:08 -0700 (PDT)
X-QQ-mid: bizesmtp75t1667546649tv9fay8q
Received: from localhost.localdomain ( [58.213.8.169])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Nov 2022 15:24:08 +0800 (CST)
X-QQ-SSF: 0140000000000030B000000A0000000
X-QQ-FEAT: FVl8EHhfVR5sZRNRY9/DeJL8TZ/JzmaTzPbfcQeUkmkwgHG3TgzG7YguMkqwy
        yaQfw+EnjutXfftW/VCbeBl/TfaZCKBW2+Tai+grdWNRQ7bVMqRo8eL5hj9XDxKwdnWVJa4
        3xp1I/AsLqrRDSXgrca14LAlBItPg97/+NoX/VhKn3jX2MiM0qBumuYrJx8lkRKC4kNRKY9
        PfgdnibQfjejhJ+eZZQkH71Qc4KY5e0m0y9gvNbDdeLcu9lW97h4P1sz051DZacDRatllrx
        bJWCDDK7cMDQ6rmSheAYzwzwahFpX4UL85BoK2x8Mni1J9E3ASq/Va5D7FUW42JeNQ/O/MS
        zEFNu67stA7otbGcPr/cJY/mlSuvovGkzZlA2pvnM944vlf/Okkl2i7p57MPTaKMyRWQR9M
X-QQ-GoodBg: 1
From:   Kunbo Zhang <absoler@smail.nju.edu.cn>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de,
        wsa+renesas@sang-engineering.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        security@kernel.org, Kunbo Zhang <absoler@smail.nju.edu.cn>
Subject: [PATCH] input: i8042 - fix a double-fetch vulnerability introduced by GCC
Date:   Fri,  4 Nov 2022 15:23:47 +0800
Message-Id: <20221104072347.74314-1-absoler@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.nju.edu.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found GCC (at least 9.4.0 and 12.1) introduces a double-fetch of `i8042_ports[I8042_AUX_PORT_NO].serio` at drivers/input/serio/i8042.c:408.

One comparison of the global variable `i8042_ports[I8042_AUX_PORT_NO].serio` has been compiled to three ones,
and thus two extra fetches are introduced.
As in the source code, the global variable is tested (at line 408) before three assignments of irq_bit, disable_bit and port_name.
However, as shown in the following disassembly of i8042_port_close(), 
the variable (0x0(%rip)) is fetched and tested three times for each 
assignment of irq_bit, disable_bit and port_name.

0000000000000e50 <i8042_port_close>:
i8042_port_close():
./drivers/input/serio/i8042.c:408
     e50:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # first load
./drivers/input/serio/i8042.c:403
     e57:	41 54                   push   %r12
./drivers/input/serio/i8042.c:408
     e59:	b8 ef ff ff ff          mov    $0xffffffef,%eax
     e5e:	49 c7 c4 00 00 00 00    mov    $0x0,%r12
./drivers/input/serio/i8042.c:403
     e65:	55                      push   %rbp
./drivers/input/serio/i8042.c:408
     e66:	48 c7 c2 00 00 00 00    mov    $0x0,%rdx
./drivers/input/serio/i8042.c:419
     e6d:	be 60 10 00 00          mov    $0x1060,%esi
./drivers/input/serio/i8042.c:403
     e72:	53                      push   %rbx
./drivers/input/serio/i8042.c:408
     e73:	bb df ff ff ff          mov    $0xffffffdf,%ebx
     e78:	0f 45 d8                cmovne %eax,%ebx
     e7b:	0f 95 c0                setne  %al
     e7e:	83 e8 03                sub    $0x3,%eax
     e81:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # second load
     e88:	40 0f 94 c5             sete   %bpl
     e8c:	83 c5 01                add    $0x1,%ebp
     e8f:	48 39 3d 00 00 00 00    cmp    %rdi,0x0(%rip)        # third load
./drivers/input/serio/i8042.c:419
     e96:	48 c7 c7 00 00 00 00    mov    $0x0,%rdi
./drivers/input/serio/i8042.c:408
     e9d:	4c 0f 45 e2             cmovne %rdx,%r12

We have not found any lock protection for the three fetches of `i8042_ports[I8042_AUX_PORT_NO].serio` yet.
If the value of this global variable is modified concurrently among the three fetches, the corresponding assignment of 
disable_bit or port_name will possibly be incorrect.

This patch fixs this by saving the checked value in advance and using a barrier() to prevent compiler optimizations.
This is inspired by a similar compiler-introduced double fetch situation [1] in driver/xen (?).

[1] GitHub link of commit <8135cf8b092723dbfcc611fe6fdcb3a36c9951c5> ( Save xen_pci_op commands before processing it )
---
 drivers/input/serio/i8042.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index f9486495baef..554a2340ca84 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -405,7 +405,9 @@ static void i8042_port_close(struct serio *serio)
 	int disable_bit;
 	const char *port_name;
 
-	if (serio == i8042_ports[I8042_AUX_PORT_NO].serio) {
+	struct serio *tmp = i8042_ports[I8042_AUX_PORT_NO].serio;
+	barrier();
+	if (serio == tmp) {
 		irq_bit = I8042_CTR_AUXINT;
 		disable_bit = I8042_CTR_AUXDIS;
 		port_name = "AUX";

Signed-off-by: Kunbo Zhang <absoler@smail.nju.edu.cn>

-- 
2.25.1

