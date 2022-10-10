Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8985F96CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiJJC3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJJC26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985822BE3F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bW00+3CNMe4I7RwtZMffKEyycBp1VFQ01aFjOTkzmCc=; b=TFadtXSx5e8TK+GkPBm3cRbAP/
        QO5L999z2KcZ6BXBlH1ztfy2uR/T/zWT0H4HSXGPnCK2gHQXJyqHWCNhj6Y7+rIdQKEudS1ul8/yk
        vL3CMe0gXDHK7SvcjUEYc13a2/wGjmlDmUsL5F41knHs9mgtcrAd7eQe2v9q+EvFRVHbrK5Vx8Ofk
        Xen52aKkZQt2SvkTCkQ2KLOxE6gPbEYJR5ahggCliramY9Q1dpDW0ViiR3hZoERz6FE8/WrTq6uK2
        nvggi/siXcFTO7d3pRPoMDkEqb2eUMwxSg37MsDAJSY07rhOfUvY3+q1awyRkFSuECK25JuGEMFK7
        LLbKTP2g==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohiXG-003sr6-Gg; Mon, 10 Oct 2022 02:28:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] arc: iounmap() arg is volatile
Date:   Sun,  9 Oct 2022 19:28:46 -0700
Message-Id: <20221010022846.20101-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'volatile' to iounmap()'s argument to prevent build warnings.
This make it the same as other major architectures.

Placates these warnings: (12 such warnings)

../drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
../drivers/video/fbdev/riva/fbdev.c:2067:42: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
 2067 |                 iounmap(default_par->riva.PRAMIN);

Fixes: 1162b0701b14b ("ARC: I/O and DMA Mappings")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
v2: add Arnd to Cc: list

 arch/arc/include/asm/io.h |    2 +-
 arch/arc/mm/ioremap.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -32,7 +32,7 @@ static inline void ioport_unmap(void __i
 {
 }
 
-extern void iounmap(const void __iomem *addr);
+extern void iounmap(const volatile void __iomem *addr);
 
 /*
  * io{read,write}{16,32}be() macros
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -94,7 +94,7 @@ void __iomem *ioremap_prot(phys_addr_t p
 EXPORT_SYMBOL(ioremap_prot);
 
 
-void iounmap(const void __iomem *addr)
+void iounmap(const volatile void __iomem *addr)
 {
 	/* weird double cast to handle phys_addr_t > 32 bits */
 	if (arc_uncached_addr_space((phys_addr_t)(u32)addr))
