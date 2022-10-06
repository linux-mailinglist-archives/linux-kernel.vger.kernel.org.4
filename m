Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC15F6196
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJFHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJFHSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E728D0E7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE26C61840
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212D4C433D6;
        Thu,  6 Oct 2022 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040681;
        bh=q1P6JOc4LZgqnbSMLMvIBMsGeHNZHYmP6JQftBlIGdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9qkS9oNbnmHmAddKCyn+luppCnBMsmL1peXa0hNrUrrp6gMtETjSsdVjD8LkwKM9
         seG1/vliubyojeyCrHIj1oDAyiIbGcohZo67HvIRdaTzJWwmaIff+aZ4vzUGf3dfGQ
         1ATQu1DgnElg89SQK+CPYMOhlu8wT/0k+3049yXeozFcY0XKU3B4w2TXRI0yH6KNx2
         RM/JO+iX0MfhF29pI25yE/osiZZE49Qq8JVsqxeiMO/cUcdJTYmmbAjgOyd2NWQVbS
         QaWUeqbBQNfVW8p//s9t1MxLzxWgzABSZ4tfwrfw0Q+EC02YZ/X90yypP4JOlueCKN
         mtwyzZNypWTjw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] riscv: cpu_relax: switch to riscv_has_extension_likely()
Date:   Thu,  6 Oct 2022 15:08:17 +0800
Message-Id: <20221006070818.3616-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch cpu_relax() from statich branch to the new helper
riscv_has_extension_likely()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/vdso/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 1e4f8b4aef79..fb30480f36a0 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -10,7 +10,7 @@
 
 static inline void cpu_relax(void)
 {
-	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZIHINTPAUSE)) {
 #ifdef __riscv_muldiv
 		int dummy;
 		/* In lieu of a halt instruction, induce a long-latency stall. */
-- 
2.37.2

