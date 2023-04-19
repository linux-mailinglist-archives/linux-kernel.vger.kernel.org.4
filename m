Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D519B6E815D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDSSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDSSnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E813C32;
        Wed, 19 Apr 2023 11:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113E16419A;
        Wed, 19 Apr 2023 18:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC37BC433EF;
        Wed, 19 Apr 2023 18:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681929788;
        bh=5RTCILtLjE6PslW82/bAKw5NGHNOYNqtdIPg3yeeo2g=;
        h=From:Date:Subject:To:Cc:From;
        b=qrXVnJOByhNAA5zjYye9gYnVfeqD6b7nxk1duWNiS4OdnIlIjlHAVY3Z+B8HNPXPg
         l5a5wnty2Tszlt/9szdX8eIIKGdvs4ZNnd8QeafkbqSL/oB7lRMRz3hDuHoZOKlnVD
         yPUZRyVlROqpCqZ88BbsRXHxQKtU9wrGOF13xIj7Sh65Pw2emCsgJj4mTQncPCBAK/
         sSQKbPXnVrO2HPYucZCxin078KtedZuLSD3N5sUTa1Ur1OvZraHpMSKlverwQQ+MjK
         OjRZlhzJp3dmmQf6UHBnsetNvs3NNaJw3rU0OhKSrWVQHPTD+T7TZUOT29IPl/sDFJ
         4K29CbAJMlI/w==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 19 Apr 2023 11:42:54 -0700
Subject: [PATCH] MIPS: Mark check_bugs{,_early}() as __init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC02QGQC/x2N0QrCMAwAf2Xk2UDbOUF/RWQ0XVyDrI6kE2Hs3
 918PA7uVjBWYYNbs4LyR0zeZQd/aiDlWEZGGXaG4ELrzv6Kk8yGKXN69bSMhlKkYqxVhZbK6ML
 Fu5YGCl0He4SiMZLGkvKRmaJV1kPMyk/5/s/3x7b9AM63U+CJAAAA
To:     tsbogend@alpha.franken.de
Cc:     ndesaulniers@google.com, jpoimboe@kernel.org, peterz@infradead.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5RTCILtLjE6PslW82/bAKw5NGHNOYNqtdIPg3yeeo2g=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCkOZtZiVTXtbxMjXzFuv7FMe9NhA/vfM3q0ZjyoP7XhM
 Wc8x9WtHaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi128w/M+5PHXGmS0xvmt/
 ye9RCA5WXHzHQax+ndPinrxTqw7G3l/IyHBUsa+Y68MvTUXH+1Eiy5urcm5+WVWZ/pX9+nrH0m9
 781gA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly"), a compiler may choose not to inline a function marked with
just 'inline'. If check_bugs() is not inlined into start_kernel(), which
occurs when building with clang after commit 9ea7e6b62c2b ("init: Mark
[arch_call_]rest_init() __noreturn"), modpost complains with:

  WARNING: modpost: vmlinux.o: section mismatch in reference: check_bugs (section: .text) -> check_bugs32 (section: .init.text)

check_bugs() is only called from start_kernel(), which itself is marked
__init, so mark check_bugs() as __init as well to clear up the warning
and make everything work properly.

While there is currently no warning about check_bugs_early(), it could
have the same problem, as it is called from arch_setup() and calls
check_bugs64_early(), both marked __init. Mark it as __init for the same
reason as above.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
NOTE: This is based on v6.3-rc7, as the issue shows up due to a patch in
the tip tree, but this appears to be an ancient issue that could have
showed up at any point (hence why no explicit Fixes tag), so I chose a
base that should allow either the MIPS or tip folks to apply this patch.

Additionally, I was tempted to remove the explicit 'inline' since the
compiler is free to do whatever it wants anyways but this is a static
function in a header so we would need to add '__maybe_unused', which is
already added with 'inline' in a normal build so I just left it alone.
---
 arch/mips/include/asm/bugs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
index d72dc6e1cf3c..9b9bf9bc7d24 100644
--- a/arch/mips/include/asm/bugs.h
+++ b/arch/mips/include/asm/bugs.h
@@ -24,13 +24,13 @@ extern void check_bugs64_early(void);
 extern void check_bugs32(void);
 extern void check_bugs64(void);
 
-static inline void check_bugs_early(void)
+static inline void __init check_bugs_early(void)
 {
 	if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
 		check_bugs64_early();
 }
 
-static inline void check_bugs(void)
+static inline void __init check_bugs(void)
 {
 	unsigned int cpu = smp_processor_id();
 

---
base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
change-id: 20230419-mips-check_bugs-init-attribute-026103bdb255

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

