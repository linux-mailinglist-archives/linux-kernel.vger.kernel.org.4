Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160AD745429
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGCDdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGCDdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:33:07 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8764B123
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:33:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437741|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0371712-0.0010859-0.961743;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=lixiaoyun@binary-semi.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.TjpOQK9_1688355167;
Received: from localhost.localdomain(mailfrom:lixiaoyun@binary-semi.com fp:SMTPD_---.TjpOQK9_1688355167)
          by smtp.aliyun-inc.com;
          Mon, 03 Jul 2023 11:32:58 +0800
From:   Amma Lee <lixiaoyun@binary-semi.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     lixiaoyun@binary-semi.com, xiezx@binary-semi.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: optimize ELF relocation function in riscv
Date:   Mon,  3 Jul 2023 11:32:12 +0800
Message-Id: <1688355132-62933-1-git-send-email-lixiaoyun@binary-semi.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch can optimize the running times of insmod command by modify ELF
relocation function.
In the 5.10 and latest kernel, when install the riscv ELF drivers which
contains multiple symbol table items to be relocated, kernel takes a lot
of time to execute the relocation. For example, we install a 3+MB driver
need 180+s.
We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
type items relocation function in the arch\riscv\kernel\module.c and
find that there are two-loops in the function. If we modify the begin
number in the second for-loops iteration, we could save significant time
for installation. We install the same 3+MB driver could just need 2s.

Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
---
 arch/riscv/kernel/module.c | 67 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d5..b8df144 100755
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -345,13 +345,13 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
 	Elf_Sym *sym;
 	u32 *location;
-	unsigned int i, type;
+	unsigned int i, type, j_idx;
 	Elf_Addr v;
 	int res;
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
-
+	j_idx = 0;
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
@@ -386,7 +386,15 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
 			unsigned int j;
 
-			for (j = 0; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
+			/*In the second for-loops, each traversal for j is
+			 * starts from 0 to the symbol table item index which
+			 * is detected. By the tool "readelf", we find that all
+			 * the symbol table items about R_RISCV_PCREL_HI20 type
+			 * are incrementally added in order. It means that we
+			 * could interate the j with the previous loop end
+			 * value(j_idx) as the begin number in the next loop;
+			 */
+			for (j = j_idx; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
 				unsigned long hi20_loc =
 					sechdrs[sechdrs[relsec].sh_info].sh_addr
 					+ rel[j].r_offset;
@@ -420,11 +428,64 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 				}
 			}
 			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
+				if (j_idx == 0) {
 				pr_err(
 				  "%s: Can not find HI20 relocation information\n",
 				  me->name);
 				return -EINVAL;
+}
+
+				/*If the last j-loop have been traversed to the
+				 * maximum value but never match the
+				 * corresponding symbol relocation item, the
+				 * j-loop will execute the second loop which
+				 * is begin from 0 to the prerious index (j_idx)
+				 * unless the previous j_idx == 0;
+				 * */
+				for (j = 0; j < j_idx; j++) {
+				unsigned long hi20_loc =
+				sechdrs[sechdrs[relsec].sh_info].sh_addr
+						+ rel[j].r_offset;
+				u32 hi20_type = ELF_RISCV_R_TYPE(rel[j].r_info);
+
+				/* Find the corresponding HI20 relocation entry */
+				if (hi20_loc == sym->st_value
+					&& (hi20_type == R_RISCV_PCREL_HI20
+					|| hi20_type == R_RISCV_GOT_HI20)) {
+					s32 hi20, lo12;
+					Elf_Sym *hi20_sym =
+						(Elf_Sym *)sechdrs[symindex].sh_addr
+						+ ELF_RISCV_R_SYM(rel[j].r_info);
+					unsigned long hi20_sym_val =
+						hi20_sym->st_value
+						+ rel[j].r_addend;
+
+					/* Calculate lo12 */
+					size_t offset = hi20_sym_val - hi20_loc;
+					if (IS_ENABLED(CONFIG_MODULE_SECTIONS)
+					    && hi20_type == R_RISCV_GOT_HI20) {
+						offset = module_emit_got_entry(
+							 me, hi20_sym_val);
+						offset = offset - hi20_loc;
+					}
+					hi20 = (offset + 0x800) & 0xfffff000;
+					lo12 = offset - hi20;
+					v = lo12;
+
+					break;
+				}
 			}
+
+				if (j == j_idx) {
+					pr_err(
+						"%s: Can not find HI20 relocation information\n",
+						me->name);
+					return -EINVAL;
+				}
+			}
+
+			/* Record the previous j-loop end index */
+			j_idx = j;
 		}
 
 		res = handler(me, location, v);
-- 
1.9.1

