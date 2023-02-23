Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076586A030D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjBWHB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjBWHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:01:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC749890
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RvTZWKKLUKmH7kChhctBVFCNZXalhVpIiuRG6cu695g=; b=eAa/AbRr9OPxEuPgPTZYHiarGI
        4qM+4bn6VEo//HbDovWuJ6uM+xBT2IjD12xaYw6W2X7nfA3RVb11/wPR5pOEI/iQ+xEnIHU6XvByF
        ofGJpRGRY3gZFwPeL2mnv1FF+lJRZoD+Dxky+z2SOEjd2h1E7XQ5wT+jHxRwGmLqp6Wq8SYm8kco8
        bNg3TNb4aDdg9yj8yUi9e3JdXU0v1PRqBg9CioH+AY1ahJFXnwrmPcAFN0KFk1YkoathJ7KCNJID6
        hJDRjfjuIroAFEOt744Mq3kn8NSWduDzaTvXQppXEhgfNdOlJ48mfrpP4Q15bkDyHMdH1McyqyApq
        DiHJw91A==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV5bT-00FMG2-CG; Thu, 23 Feb 2023 07:01:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc: wii: fix resource printk format warnings
Date:   Wed, 22 Feb 2023 23:01:14 -0800
Message-Id: <20230223070116.660-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223070116.660-1-rdunlap@infradead.org>
References: <20230223070116.660-1-rdunlap@infradead.org>
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

Use "%pa" format specifier for resource_size_t to avoid compiler
printk format warnings.

../arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_init':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
../arch/powerpc/platforms/embedded6xx/flipper-pic.c:148:9: note: in expansion of macro 'pr_info'
  148 |         pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
      |         ^~~~~~~

../arch/powerpc/platforms/embedded6xx/hlwd-pic.c: In function 'hlwd_pic_init':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
../arch/powerpc/platforms/embedded6xx/hlwd-pic.c:174:9: note: in expansion of macro 'pr_info'
  174 |         pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
      |         ^~~~~~~

../arch/powerpc/platforms/embedded6xx/wii.c: In function 'wii_ioremap_hw_regs':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
../arch/powerpc/platforms/embedded6xx/wii.c:77:17: note: in expansion of macro 'pr_info'
   77 |                 pr_info("%s at 0x%08x mapped to 0x%p\n", name,
      |                 ^~~~~~~

Fixes: 028ee972f032 ("powerpc: gamecube/wii: flipper interrupt controller support")
Fixes: 9c21025c7845 ("powerpc: wii: hollywood interrupt controller support")
Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |    2 +-
 arch/powerpc/platforms/embedded6xx/wii.c         |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -145,7 +145,7 @@ static struct irq_domain * __init flippe
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff -- a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -74,8 +74,8 @@ static void __iomem *__init wii_ioremap_
 
 	hw_regs = ioremap(res.start, resource_size(&res));
 	if (hw_regs) {
-		pr_info("%s at 0x%08x mapped to 0x%p\n", name,
-			res.start, hw_regs);
+		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
+			&res.start, hw_regs);
 	}
 
 out_put:
diff -- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -171,7 +171,7 @@ static struct irq_domain *__init hlwd_pi
 		return NULL;
 	}
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
