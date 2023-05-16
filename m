Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A67052AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjEPPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjEPPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586847EDD;
        Tue, 16 May 2023 08:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C09463B9D;
        Tue, 16 May 2023 15:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8BDC433A0;
        Tue, 16 May 2023 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252005;
        bh=1m6Ec7twcC2NaPKOcuVM9lqODfTf5Y70mYt0kY6b7Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzAdBbWlRCx5TDu2jFFXn3n3DHysi9+vGwC0OBd7f12eUbKsSemdnlSDW3q6NrJGx
         Sx1LPRHBbeaaOIGPV5Oqn4wHxc9Wy+tYfs5RtyzErb6id1wcUuT6v87ecvr23dchZc
         3nqiENT39Md26RlUzH+95As0vTZcHfmJn+NuGWomLfwdG/9BranS8XX98YuzvfMB9V
         sdAVg1wVi5/qeBf8CYTB+VHKQfI+VRnnVOehKeLaGk5QS6VrzNnXggzacrI7WO3M6k
         VurEaGGym4T17vwJ7/3+mb0OxWk2rD1XpLWU6JFQMC34XlrQvpGLhuBjj1n/wwozc0
         rS1sgWSyPmm/g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 08/16] ARM: add clear/copy_user_highpage declarations
Date:   Tue, 16 May 2023 17:45:57 +0200
Message-Id: <20230516154605.517690-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The CPU specific helpers have to be global functions when building
a kernel for just one CPU, but are called through indirect function
pointers in a multi-CPU kernel. This config currently lacks the
declarations for the individual helpers, e.g.:

arch/arm/mm/copypage-v4wb.c:47:6: error: no previous prototype for 'v4wb_copy_user_highpage' [-Werror=missing-prototypes]
arch/arm/mm/copypage-v4wb.c:65:6: error: no previous prototype for 'v4wb_clear_user_highpage' [-Werror=missing-prototypes]

Add the complete set of prototypes in asm/page.h to allow
building iwth -Wmissing-prototypes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/page.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 74bb5947b387..28c63d172a96 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -113,6 +113,28 @@ struct cpu_user_fns {
 			unsigned long vaddr, struct vm_area_struct *vma);
 };
 
+void fa_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void fa_clear_user_highpage(struct page *page, unsigned long vaddr);
+void feroceon_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr);
+void v4_mc_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void v4_mc_clear_user_highpage(struct page *page, unsigned long vaddr);
+void v4wb_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void v4wb_clear_user_highpage(struct page *page, unsigned long vaddr);
+void v4wt_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void v4wt_clear_user_highpage(struct page *page, unsigned long vaddr);
+void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr);
+void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+void xscale_mc_clear_user_highpage(struct page *page, unsigned long vaddr);
+
 #ifdef MULTI_USER
 extern struct cpu_user_fns cpu_user;
 
-- 
2.39.2

