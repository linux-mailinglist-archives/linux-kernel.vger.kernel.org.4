Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB857052AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjEPPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjEPPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8D7DB4;
        Tue, 16 May 2023 08:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7F763BA4;
        Tue, 16 May 2023 15:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5187BC433D2;
        Tue, 16 May 2023 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252009;
        bh=hEUlhy3x74ptZihWpTN1KOaQRhy1uwVK0q8Cu7Mv2w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mr8YfsTNoulwGWvD0tgfBs0wwbldurQP87cM+bffA6WAgrco/DCyut4Dk70ezgjb3
         s+rcP0dVrALpiBxiwpppiZJCgDuNbXrQSlgKiqUzYbO7Rp9FPZky/idQVj59srnUR/
         rU5ySRLhnEFvMtEDm3VCLjjON95rItlQ0ofQSzC6qTpwmt7yv2NA5bbccWy1G95VpL
         Ni6quHY5h7Rellf3j00PpuwafyY7yuh5yx53gzMJhUU4h9EnUWGtc5RnodHFsYa6Xa
         9o7hMEhJE2nmTZm4FB9Rxq6yXF+IouUgEI4K7ghU/pF44VvDOSr8LtHs/0OrY9bcJe
         M2bdA3bv1aK7Q==
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
Subject: [PATCH 09/16] ARM: cacheflush: avoid __flush_anon_page() missing-prototype warning
Date:   Tue, 16 May 2023 17:45:58 +0200
Message-Id: <20230516154605.517690-10-arnd@kernel.org>
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

The prototype for __flush_anon_page() is intentionally hidden
inside the flush_anon_page() inline function to prevent it from
being called from drivers.

When building with 'W=1', this causes a warning:

arch/arm/mm/flush.c:358:6: error: no previous prototype for '__flush_anon_page' [-Werror=missing-prototypes]

Work around this by adding a prototype directly next to the function
definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 9b112009c708..43678137a9b2 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -355,6 +355,7 @@ EXPORT_SYMBOL(flush_dcache_page);
  *  memcpy() to/from page
  *  if written to page, flush_dcache_page()
  */
+void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr);
 void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
 {
 	unsigned long pfn;
-- 
2.39.2

