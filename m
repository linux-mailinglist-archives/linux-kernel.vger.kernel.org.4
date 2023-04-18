Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC54A6E5E39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDRKHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:07:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF6619C;
        Tue, 18 Apr 2023 03:07:42 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681812460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hrIALWXAVvGDVGjm5iMETsfeRBQvW4diD917HCsP7SM=;
        b=zEdTygMBmxRbuq3UWYmaCKQ2N69eNcWO+DJgq7ecoguN5Yzf4sUJyMDQq6hQopX89E6po1
        PC2eKbKEWDYdrRdQf852aC2pXzS/1e9PXS+0VqJdhWWoNowH8XZOFqLzFyKfRe2iXgQTEt
        62Ikc55r7lA3rmmwU1IRv7OkjlrVeRI/O3Iy6NBwhSHMxSOx8C467NG+qVb4/Oz2xasPZO
        2BhbgBFWzce4Gxt1aj6m3Y9xpY9gUvnVbgIbA2IdrlbdPhqqcMFR0Xnge8h/zutWyrIF7y
        KAc9j9F1/gXX3mKTVrYav7NqhB11c2lU1Y1VI/8aMz2hzdA7QUadLcM9P8CnLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681812460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hrIALWXAVvGDVGjm5iMETsfeRBQvW4diD917HCsP7SM=;
        b=WdjaLI5SBAoUI6RRkyv99qgAJiSi7hA2VYlIj8kPAk84KCa+08HW+01Q7g8wHO7fY9Nc40
        hpab2McjZfARAfAQ==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternatives: Do not use integer constant
 suffixes in inline asm
Cc:     Willy Tarreau <w@1wt.eu>, "Borislav Petkov (AMD)" <bp@alien8.de>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168181245918.404.18412827126729944603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c22ef5684b64a3a1ac08db06a6f327f2695fd377
Gitweb:        https://git.kernel.org/tip/c22ef5684b64a3a1ac08db06a6f327f2695fd377
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Tue, 18 Apr 2023 08:42:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 18 Apr 2023 11:57:18 +02:00

x86/alternatives: Do not use integer constant suffixes in inline asm

The usage of the BIT() macro in inline asm code was introduced in 6.3 by
the commit in the Fixes tag. However, this macro uses "1UL" for integer
constant suffixes in its shift operation, while gas before 2.28 does not
support the "L" suffix after a number, and gas before 2.27 does not
support the "U" suffix, resulting in build errors such as the following
with such versions:

  ./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
  ./arch/x86/include/asm/uaccess_64.h:124: Error: junk at end of line,
  first unrecognized character is `L'

However, the currently minimal binutils version the kernel supports is
2.25.

There's a single use of this macro here, revert to (1 << 0) that works
with such older binutils.

As an additional info, the binutils PRs which add support for those
suffixes are:

  https://sourceware.org/bugzilla/show_bug.cgi?id=19910
  https://sourceware.org/bugzilla/show_bug.cgi?id=20732

  [ bp: Massage and extend commit message. ]

Fixes: 5d1dd961e743 ("x86/alternatives: Add alt_instr.flags")
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Link: https://lore.kernel.org/lkml/a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com/
---
 arch/x86/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index e2975a3..d7da28f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -8,7 +8,7 @@
 
 #define ALT_FLAGS_SHIFT		16
 
-#define ALT_FLAG_NOT		BIT(0)
+#define ALT_FLAG_NOT		(1 << 0)
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
 
 #ifndef __ASSEMBLY__
