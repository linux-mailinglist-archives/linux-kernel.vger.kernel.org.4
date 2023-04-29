Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A166F22EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347206AbjD2Efi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347188AbjD2Efd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:35:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A483C16
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 21:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zoaWVfddz3wSNejdOB9fyZIWSf2ml9M80D57wQbXMq0=; b=Pq8GzrekrPUopyeaBCJsLfAs0n
        VMSHuF7fVf0BLIJxcduAVr7tjagQFFwScA9qgUruIotmipu/5gB+zC2JYoIzcpHet4LnLTiv+5ykg
        TAEioIHe8rGLXPTLrZ5ZiPxBIcSWth/VYfxxMuXSOoYeTFSV0TDlAhZ7mENUrarz2/Z38wHL7t0Vt
        ziPFwuE98vOXyyujhJA/JCSAoCgui23tssIwugN0zPn4S64wp0JgjfxqGyHWd5ni3sAlyXrvrkQjm
        zEhQeix5/gqzJ5N52zyc522Ku/gOH/9HlnBvBu77LDybq4E9EIgVv61f6El1+o5kloaZSA5pQzCv/
        GCfA7lSA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pscJ0-00CE8t-2g;
        Sat, 29 Apr 2023 04:35:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: fix sifive and thead section mismatches in errata
Date:   Fri, 28 Apr 2023 21:35:30 -0700
Message-Id: <20230429043530.20503-1-rdunlap@infradead.org>
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

It appears that CONFIG_MODULES not set is not tested very much.

Fixes: a8e910168bba ("riscv: implement module alternatives")
Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
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
