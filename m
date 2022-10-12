Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9245FBEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLB6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLB6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED802A346A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B8F612A3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56EFC433C1;
        Wed, 12 Oct 2022 01:58:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Flush TLB earlier at initialization
Date:   Wed, 12 Oct 2022 09:57:07 +0800
Message-Id: <20221012015707.2139728-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move local_flush_tlb_all() earlier (just after setup_ptwalker() and
before page allocation). This can avoid stale TLB entries misguiding
the later page allocation. Without this patch the second kernel of
kexec/kdump fails to boot SMP.

BTW, move output_pgtable_bits_defines() into tlb_init() since it has
nothing to do with tlb handler setup.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/tlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 9818ce11546b..da3681f131c8 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -258,7 +258,7 @@ extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 void setup_tlb_handler(int cpu)
 {
 	setup_ptwalker();
-	output_pgtable_bits_defines();
+	local_flush_tlb_all();
 
 	/* The tlb handlers are generated only once */
 	if (cpu == 0) {
@@ -301,6 +301,7 @@ void tlb_init(int cpu)
 	write_csr_pagesize(PS_DEFAULT_SIZE);
 	write_csr_stlbpgsize(PS_DEFAULT_SIZE);
 	write_csr_tlbrefill_pagesize(PS_DEFAULT_SIZE);
+
 	setup_tlb_handler(cpu);
-	local_flush_tlb_all();
+	output_pgtable_bits_defines();
 }
-- 
2.31.1

