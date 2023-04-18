Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995636E598E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjDRGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRGnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:43:17 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09D131FFD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:43:14 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 33I6gYsK021620;
        Tue, 18 Apr 2023 08:42:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH] x86/alternatives: fix build issue with binutils before 2.28
Date:   Tue, 18 Apr 2023 08:42:28 +0200
Message-Id: <20230418064228.21577-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of the BIT() macro in asm code was introduced in 6.3 in by
commit 5d1dd961e743 ("x86/alternatives: Add alt_instr.flags") but this
macro uses "1UL" in the shift operations, while gas before 2.28 do not
support the "L" suffix after a number, and those before 2.27 do not
support the "U" suffix, resulting in build errors such as the following
with such versions:

  ./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
  ./arch/x86/include/asm/uaccess_64.h:124: Error: junk at end of line,
  first unrecognized character is `L'

There's a single use of this macro here, let's revert to (1 << 0) that
works with such older binutils.

Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/lkml/a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com/
Signed-off-by: Willy Tarreau <w@1wt.eu>
---

Boris, I understood from your message that 2.28 was the first working version,
so that's what I mentioned here. My tests showed that 2.27 wasn't sufficient
and that 2.29 was OK. If I was wrong and it's 2.29 instead, feel free to edit
the subject line, description and the comment, I'm totally fine with this!


 arch/x86/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index e2975a32d443..b119685c0b31 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -8,7 +8,7 @@
 
 #define ALT_FLAGS_SHIFT		16
 
-#define ALT_FLAG_NOT		BIT(0)
+#define ALT_FLAG_NOT		(1 << 0) /* note: gas < 2.28 can't use BIT(0) */
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
 
 #ifndef __ASSEMBLY__
-- 
2.35.3

