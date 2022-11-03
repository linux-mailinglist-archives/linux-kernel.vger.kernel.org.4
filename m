Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D30618A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiKCVKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKCVJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:09:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CDE23BF7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:08:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so3143498ybs.17
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvJEJ264ZheXx0sRztLACOjB54er/SHBBGAWfYziuwo=;
        b=pHqZDfEPOxY8hOzsv0ouJgt30fhvGw5PosROhzkdc1wNlLZejPwtw/j/LOA1O65C8k
         iJPybw/i/OoSblImCWxePOGCIurF3kagPrykiNc9hGc6ZEWWvBgpTDC0ciWZXALyi6Mf
         6glfoWS2F/0lTZ0vd/a8NBbZ9fpB5+y3dNg9IyVc8p07YlJe1cZEJEFOlBDciVUhSN4h
         tc52nPRj220IevYk7H930WzB40mbb2liyaXp7Gt06HDWYtciiV9uXv35jBldzdiVvnKy
         ax1c9kpDUYPYZw6C1npkZ6+kZrfMnATwGmIw1TPzs+G2SKl86SuRYr6NCSpa/E0zN+pz
         af5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvJEJ264ZheXx0sRztLACOjB54er/SHBBGAWfYziuwo=;
        b=Q34+hj39uDLiCfYwpAxOYrE/QYWSrbdGVlDvz0hcVN0MENinY7YLrE+hzhgpdSWC0K
         +OTDrsQVjfLxgHduRhKV1IdH0vnOEsi+gtonZcsbPasD7le5n8abTKXaRtQwJZfSI3m/
         qBs524bTz4RdYtWjiMHMczyBps9TlBx2tFrm4bVfyXMIuUpBygaZYbphOL8GfFxP0CP4
         y+afKOcBMxZNHueApTx7At+z24ekbTr/4U2Ibu99WvElKcNV35RqKS4gwGsL/WLsnq4B
         w3hdIZPp1CNOPNzDHVy8bn1hQSRyV2wC7JZtYHjh7hSpSbeDGRJHSwQcOVDEcVSAR3uA
         9+gQ==
X-Gm-Message-State: ACrzQf2gcXpm4khwRAtrH7X44M9vhaQWVY8Ha4mDt2/fWUhG4c5XPEiS
        x5YQaUNvPEwZsA2nKNeNACqJToYYZK6gp+on1AM=
X-Google-Smtp-Source: AMsMyM7HL+cBwLBXfUsLE3QPRvIhyBIZEBDNxBkQ7jAWm3oNaDcj+Q8ZbLfaubygdDcO1gjU9WTkL8+ZbADPJA+rCuA=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:33e8:ddbf:583c:50a8])
 (user=ndesaulniers job=sendgmr) by 2002:a25:bccf:0:b0:6cb:83c8:4ceb with SMTP
 id l15-20020a25bccf000000b006cb83c84cebmr182458ybm.635.1667509689312; Thu, 03
 Nov 2022 14:08:09 -0700 (PDT)
Date:   Thu,  3 Nov 2022 14:07:48 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667509668; l=2763;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=YqhBGxVFdvGLXPPYHWaXapaJALaw752j4veZvStNY7I=;
 b=C3CRtilMk0sQ0zoZnXPAuoWsu/v9ne9Gyvj9hg24XVyEmTOudrkm8wYpJxnWniDnk1IQbEI02x60
 4jnYEXMEBr5PyTn2KFYcbiz7JnkH96J7jomce+uNV2WyYwqdbimW
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221103210748.1343090-1-ndesaulniers@google.com>
Subject: [PATCH] x86/msr-index: make SPEC_CTRL_IBRS assembler-portable
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-team@android.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU binutils' assembler (GAS) didn't support L suffixes on immediates
until binutils 2.28 release. Building arch/x86/entry/entry_64.S with GAS
v2.27 will produce the following assembler errors:

  arch/x86/entry/entry_64.S: Assembler messages:
  arch/x86/entry/entry_64.S:308: Error: found 'L', expected: ')'
  arch/x86/entry/entry_64.S:308: Error: found 'L', expected: ')'
  arch/x86/entry/entry_64.S:308: Error: junk `L<<(0)))' after expression
  arch/x86/entry/entry_64.S:596: Error: found 'L', expected: ')'
  arch/x86/entry/entry_64.S:596: Error: found 'L', expected: ')'
  arch/x86/entry/entry_64.S:596: Error: junk `L<<(0)))' after expression

These come from the use of the preprocessor defined SPEC_CTRL_IBRS in
the IBRS_ENTER and IBRS_EXIT assembler macros. SPEC_CTRL_IBRS was using
the BIT macros from include/linux/bits.h which are only portable between
C and assembler for assemblers such as GAS v2.28 (or newer) or clang
because they use the L suffixes for immediate operands, which older GAS
releases cannot parse. The kernel still supports GAS v2.23 and newer
(and older for branches of stable). Let's expand the value of
SPEC_CTRL_IBRS in place so that assemblers don't have issues parsing the
value.

Fixes: 2dbb887e875b ("x86/entry: Add kernel IBRS implementation")
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Some other ideas considered:
* Use U64_C from include/asm-generic/int-ll64.h rather than BIT for the
  value of SPEC_CTRL_IBRS.
  * Do so for the entirety of arch/x86/include/asm/msr-index.h or just
    SPEC_CTRL_IBRS? include/asm-generic/int-ll64.h doesn't define a UL
    suffix; add one?
* Make include/linux/bits.h assembler-portable (for older assemblers)
  via the use of include/asm-generic/int-ll64.h.

 arch/x86/include/asm/msr-index.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac52705892..0192d853136c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -46,7 +46,7 @@
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
 
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
-#define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
+#define SPEC_CTRL_IBRS			1	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
 #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
 #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
-- 
2.38.1.431.g37b22c650d-goog

