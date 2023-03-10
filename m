Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9666B5010
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCJS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:27:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672D15D44C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:27:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2005)
        id 038CF67373; Fri, 10 Mar 2023 19:27:27 +0100 (CET)
Date:   Fri, 10 Mar 2023 19:27:26 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Li Zhengyu <lizhengyu3@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: relocate R_RISCV_CALL_PLT in kexec_file
Message-ID: <20230310182726.GA25154@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the toolchain (here: gcc-12, binutils-2.40) the
relocation entries for function calls are no longer R_RISCV_CALL, but
R_RISCV_CALL_PLT. When trying kexec_load_file on such kernels, it will
fail with

 kexec_image: Unknown rela relocation: 19
 kexec_image: Error loading purgatory ret=-8

The binary code at the call site remains the same, so tell
arch_kexec_apply_relocations_add() to handle _PLT alike.

fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
Signed-off-by: Torsten Duwe <duwe@suse.de>
Cc: stable@vger.kernel.org

---
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		 * sym, instead of searching the whole relsec.
 		 */
 		case R_RISCV_PCREL_HI20:
+		case R_RISCV_CALL_PLT:
 		case R_RISCV_CALL:
 			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
 				 ENCODE_UJTYPE_IMM(val - addr);
