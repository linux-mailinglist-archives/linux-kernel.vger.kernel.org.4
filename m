Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE26F2547
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjD2Pww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjD2Pwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 11:52:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851EC1730
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LWVacgMgbgTLP0u9Q7gpdWiCCGyCTSBmMaT6WHBufYk=; b=McYafudAIrdas3REyd1G79ymrY
        lSADLp1A6aCMlm5XpHXC0I5MTKTFbG7NROWGx5Hx94fP23qp2QCPj5h3MXTtlz8F/kb31TE+o5eOD
        yceQ9MJ10qt3LyrakIH9rJlPRkI+rDK6/49NEpByaRvRoP2JBL2w40904Z1yLnzApp0537lYnV/CA
        pw+1/uT+yPirwjXIR/9a9ZADZiZgr1BvEm15I50Lego1nsrkBzAWuttnt6Yg7pmdwCi1KypVCJE+1
        mrDJQkvouXX4PRWeAaeCFzjMBoos1GPWKjHMJvhPhvl/zw4NUEo11nSbQFaBvLGcn9EC+EG59uZwy
        ojOD9onQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psmsR-00Cruj-3C;
        Sat, 29 Apr 2023 15:52:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>
Subject: [PATCH v2] RISC-V: fix sifive and thead section mismatches in errata
Date:   Sat, 29 Apr 2023 08:52:47 -0700
Message-Id: <20230429155247.12131-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
CONFIG_MODULES is not set, __init_or_module becomes __init.
In the latter case, it causes section mismatch warnings:

WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.text)

Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_features()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>
Cc: Evan Green <evan@rivosinc.com>
---
v2: use corrected Fixes: commit info (thanks Conor)

 arch/riscv/errata/sifive/errata.c |    8 +++-----
 arch/riscv/errata/thead/errata.c  |    6 +++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff -- a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -82,11 +82,9 @@ static void __init_or_module warn_miss_e
 	pr_warn("----------------------------------------------------------------\n");
 }
 
-void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
-					       struct alt_entry *end,
-					       unsigned long archid,
-					       unsigned long impid,
-					       unsigned int stage)
+void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+			      unsigned long archid, unsigned long impid,
+			      unsigned int stage)
 {
 	struct alt_entry *alt;
 	u32 cpu_req_errata;
diff -- a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -83,9 +83,9 @@ static u32 thead_errata_probe(unsigned i
 	return cpu_req_errata;
 }
 
-void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
-					      unsigned long archid, unsigned long impid,
-					      unsigned int stage)
+void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+			     unsigned long archid, unsigned long impid,
+			     unsigned int stage)
 {
 	struct alt_entry *alt;
 	u32 cpu_req_errata = thead_errata_probe(stage, archid, impid);
