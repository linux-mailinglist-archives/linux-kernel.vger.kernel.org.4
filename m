Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08B57002FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjELIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjELIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:52:33 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D179D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:52:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437567|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0113127-0.000330278-0.988357;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=lixiaoyun@binary-semi.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.T.knj5Y_1683881536;
Received: from localhost.localdomain(mailfrom:lixiaoyun@binary-semi.com fp:SMTPD_---.T.knj5Y_1683881536)
          by smtp.aliyun-inc.com;
          Fri, 12 May 2023 16:52:25 +0800
From:   Amma Lee <lixiaoyun@binary-semi.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lixiaoyun@binary-semi.com, xiezx@binary-semi.com
Subject: [PATCH v2] riscv: optimize ELF relocation function in riscv
Date:   Fri, 12 May 2023 16:51:53 +0800
Message-Id: <1683881513-18730-1-git-send-email-lixiaoyun@binary-semi.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch can optimize the running times of "insmod" command by modify ELF
relocation function.
When install the riscv ELF driver which contains multiple
symbol table items to be relocated, kernel takes a lot of time to
execute the relocation. For example, we install a 3+MB driver need 180+s.
We focus on the riscv kernel handle R_RISCV_HI20 and R_RISCV_LO12 type
items relocation function and find that there are two for-loops in this
function. If we modify the begin number in the second for-loops iteration,
we could save significant time for installation. We install the 3+MB
driver could just need 2s.

Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
Reviewed-by: Conor Dooley <conor@kernel.org>

---
 arch/riscv/kernel/module.c | 53 ++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 55507b0..1683c1d 100755
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -385,9 +385,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 
 		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
 			unsigned int j;
-			/*Modify the j for-loops begin number from last iterates end value*/
+
+			/*
+			* In the second for-loops, each traversal for j is
+			* starts from 0 to the symbol table item index which
+			* is detected. By the tool "readelf", we find that all
+			* the symbol table items about R_RISCV_PCREL_HI20 type
+			* are incrementally added in order. It means that we
+			* could interate the j with the previous loop end
+			* value(j_idx) as the begin number in the next loop;
+			*/
 			for (j = j_idx; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
-			/* Modify end */
 				unsigned long hi20_loc =
 					sechdrs[sechdrs[relsec].sh_info].sh_addr
 					+ rel[j].r_offset;
@@ -420,22 +428,30 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 					break;
 				}
 			}
+
 			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
-				if(j_idx == 0){
+				if (j_idx == 0) {
 					pr_err(
 						"%s: Can not find HI20 relocation information\n",
 						me->name);
 					return -EINVAL;
 				}
-				
-				
-				for (j = 0; j < j_idx; j++){ 
+
+				/*
+				* If the last j-loop have been traversed to the
+				* maximum value but never match the
+				* corresponding symbol relocation item, the
+				* j-loop will execute the second loop which
+				* is begin from 0 to the prerious index (j_idx)
+				* unless the previous j_idx == 0;
+				*/
+				for (j = 0; j < j_idx; j++) {
 					unsigned long hi20_loc =
 						sechdrs[sechdrs[relsec].sh_info].sh_addr
 						+ rel[j].r_offset;
 					u32 hi20_type = ELF_RISCV_R_TYPE(rel[j].r_info);
-				
-				
+
+
 					/* Find the corresponding HI20 relocation entry */
 					if (hi20_loc == sym->st_value
 						&& (hi20_type == R_RISCV_PCREL_HI20
@@ -447,36 +463,37 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 						unsigned long hi20_sym_val =
 							hi20_sym->st_value
 							+ rel[j].r_addend;
-					
-				
+
+
 						/* Calculate lo12 */
 						size_t offset = hi20_sym_val - hi20_loc;
+						/* Calculate lo12 */
 						if (IS_ENABLED(CONFIG_MODULE_SECTIONS)
 							&& hi20_type == R_RISCV_GOT_HI20) {
 							offset = module_emit_got_entry(
 								me, hi20_sym_val);
 							offset = offset - hi20_loc;
-				
+
 						}
 						hi20 = (offset + 0x800) & 0xfffff000;
 						lo12 = offset - hi20;
 						v = lo12;
-					
+
 						break;
 					}
 				}
-				
-				if (j == j_idx)
-				{
+
+				if (j == j_idx) {
 					pr_err(
 						"%s: Can not find HI20 relocation information\n",
 						me->name);
 					return -EINVAL;
 				}
-				
-				
+
+
 			}
-			
+
+			/* Record the previous j-loop end index */
 			j_idx = j;
 		}
 
-- 
1.9.1

