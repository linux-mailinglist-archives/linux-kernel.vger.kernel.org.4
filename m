Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3D7093E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjESJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjESJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84E213A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62314655A8
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9A3C433EF;
        Fri, 19 May 2023 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684489252;
        bh=sczsbRpuY6qul0O2IVlTqPIb+oBjrjpfMfChzCygpVA=;
        h=From:To:Cc:Subject:Date:From;
        b=DDLt1yXsc4kiSMPPgaoLRVpN1ga2Jv10Ch5WxuSZ/NGfEMjcXINZ2rm5YShP05rhK
         CwNvEBpoLIf1AYj+LZ2loA306P1ZEwe2YNdSkgIPFjQhk7bTIrp4+olzDAw/ooqht2
         uJX6wY6WHiOsNcFjOQlHHUh1sB28ua4s0acCDfR/UfEk8W9z2wSwANhgxIjcghnvCF
         9cFqLTHhwNVuyxKfBuJqaobFUXx/s/rSlXUdrZx40vTXgJcVUGk9MfdxfeF+nKiI3j
         fORBXXpWQrj553ABJycTVZ219zTqxzk4vKIWx4AYptnv5t31/Jz+VucbynL6Sge9gV
         jEAvP7FnwD8vQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: alternative: add __alt_reloc_selftest prototype
Date:   Fri, 19 May 2023 11:40:27 +0200
Message-Id: <20230519094035.11259-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The newly introduced selftest function causes a warning when -Wmissing-prototypes
is enabled:

arch/x86/kernel/alternative.c:1461:32: error: no previous prototype for '__alt_reloc_selftest' [-Werror=missing-prototypes]

Since it's only used locally, add the prototype directly in front of it.

Fixes: 270a69c4485d ("x86/alternative: Support relocations in alternatives")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/alternative.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 93aa95afd005..4338bd74b663 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1458,6 +1458,7 @@ static noinline void __init int3_selftest(void)
 
 static __initdata int __alt_reloc_selftest_addr;
 
+extern void __init __alt_reloc_selftest(void *arg);
 __visible noinline void __init __alt_reloc_selftest(void *arg)
 {
 	WARN_ON(arg != &__alt_reloc_selftest_addr);
-- 
2.39.2

