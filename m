Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6685FA2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJJRvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJJRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:51:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1721B15800
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:51:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o4-20020a258d84000000b006bcfc1aafbdso11341580ybl.14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBlnd4XOswp/sg9aQW3gv5szg86tXu6TkQ8l/Mwzfog=;
        b=nk/3rxvqJoK9SyUHQWL4FrcBRa1u5cO4vRwonLiomf+mwgVgWWJI1zDI2WrsG4X70S
         nmYcNaaINMTJvz4X+rhldlAAsnDEIdQ1m/0le3N3a4jcmuJBnx7ADpYTD37EtiIQ8Ek4
         UdZRVtpQ9jRuCSlVU0a7FPDzhLIVxEVRtxg1As+928YvNnSFB/ebJx9BGRXZ+TqF7Yvx
         1RE2jxe2d5hBME089OeAg4k07EJx1sEL1FXum8kBR1LYise8GCM5CrRWtjtenaTYKGO8
         7ToFnDGrUdgCeG5TNXYr09gkPBJU4y/mo/PCaw7hg1fsyCBRDaiMRFl5EKrZexrFlMpB
         5aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBlnd4XOswp/sg9aQW3gv5szg86tXu6TkQ8l/Mwzfog=;
        b=6QGaUOqdvG3ITk7OeMKQbH1x2MtEyONPXZdUOj/CgBxacVcZdO3+kykbmb1gz2IfT5
         zxR9MYSVYNwSfpfd3HWBnbyZrvQw0Rta87EKRzOt5Rn0B04T94fZ70faaYATFKCXGO4M
         JBjAjPQG23PUosIXsNFj3RiVR2AFC9mPaAK7l0HMSuczbBGyDbeiHoYZCUArQ6l3Y52J
         29JhG1DxEAM4/5+2LmmvuIRKKzZ3S9QVMWrLbp2O70Doldim6M3wSNJzFRtEzZzNeWI8
         5E3FNqTMjcmAW1qSkumdDvezZyuI9TetO7JGLDi5p0M5c6Z5Kc7FFTL/tVKZov2OY73E
         2YNQ==
X-Gm-Message-State: ACrzQf2i88HR0Xlj12lWUKhH/JN/v1fzLwUDGnWOb4DSSGgMNiOJkMwM
        nHOJDxH78TdKPB9KJQCZeATOEJ5QPm1Rxnr/HRI=
X-Google-Smtp-Source: AMsMyM5jkqv1zz43050m6pWEovXCAiaua+rKQiGXBtEfN0TkeuKfcUR3yW7cLziDOqKL4IlVFs/66K0FaURGRe5s6Ow=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:883d:1c60:2d47:598d])
 (user=ndesaulniers job=sendgmr) by 2002:a81:d45:0:b0:356:d50d:d010 with SMTP
 id 66-20020a810d45000000b00356d50dd010mr18174102ywn.437.1665424302401; Mon,
 10 Oct 2022 10:51:42 -0700 (PDT)
Date:   Mon, 10 Oct 2022 10:51:34 -0700
In-Reply-To: <202210072120.V1O2SuKY-lkp@intel.com>
Mime-Version: 1.0
References: <202210072120.V1O2SuKY-lkp@intel.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665424294; l=2791;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=79P/bvbEb7lOxoUitL3cE1zzO5WZPlSo0wty3dVeQAY=;
 b=B5zs5846RZppHTs/CE8/c+09IEq445Jvsd3Vdr73h8bHw68EC4yYmabbF1udsPYDDSop/Y6KuyI3
 Q9t55mKQDsfxtPXBKw7hoZQJMbxVuxixwsIYFa/HaIIjtnJ9joA3
X-Mailer: git-send-email 2.38.0.rc2.412.g84df46c1b4-goog
Message-ID: <20221010175134.2671410-1-ndesaulniers@google.com>
Subject: [PATCH] lib/xor: use r10 rather than r7 in xor_arm4regs_{2|3}
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Nick Desaulniers <ndesaulniers@google.com>
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

kbuild test robot reports:
In file included from crypto/xor.c:17:
./arch/arm/include/asm/xor.h:61:3: error: write to reserved register 'R7'
                GET_BLOCK_4(p1);
                ^
./arch/arm/include/asm/xor.h:20:10: note: expanded from macro 'GET_BLOCK_4'
        __asm__("ldmia  %0, {%1, %2, %3, %4}" \
                ^
./arch/arm/include/asm/xor.h:63:3: error: write to reserved register 'R7'
                PUT_BLOCK_4(p1);
                ^
./arch/arm/include/asm/xor.h:42:23: note: expanded from macro 'PUT_BLOCK_4'
        __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
                             ^
./arch/arm/include/asm/xor.h:83:3: error: write to reserved register 'R7'
                GET_BLOCK_4(p1);
                ^
./arch/arm/include/asm/xor.h:20:10: note: expanded from macro 'GET_BLOCK_4'
        __asm__("ldmia  %0, {%1, %2, %3, %4}" \
                ^
./arch/arm/include/asm/xor.h:86:3: error: write to reserved register 'R7'
                PUT_BLOCK_4(p1);
                ^
./arch/arm/include/asm/xor.h:42:23: note: expanded from macro 'PUT_BLOCK_4'
        __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
                             ^
Thumb2 uses r7 rather than r11 as the frame pointer. Let's use r10
rather than r7 for these temporaries.

Link: https://github.com/ClangBuiltLinux/linux/issues/1732
Link: https://lore.kernel.org/llvm/202210072120.V1O2SuKY-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/include/asm/xor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index 669cad5194d3..934b549905f5 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -51,7 +51,7 @@ xor_arm4regs_2(unsigned long bytes, unsigned long * __restrict p1,
 	register unsigned int a1 __asm__("r4");
 	register unsigned int a2 __asm__("r5");
 	register unsigned int a3 __asm__("r6");
-	register unsigned int a4 __asm__("r7");
+	register unsigned int a4 __asm__("r10");
 	register unsigned int b1 __asm__("r8");
 	register unsigned int b2 __asm__("r9");
 	register unsigned int b3 __asm__("ip");
@@ -73,7 +73,7 @@ xor_arm4regs_3(unsigned long bytes, unsigned long * __restrict p1,
 	register unsigned int a1 __asm__("r4");
 	register unsigned int a2 __asm__("r5");
 	register unsigned int a3 __asm__("r6");
-	register unsigned int a4 __asm__("r7");
+	register unsigned int a4 __asm__("r10");
 	register unsigned int b1 __asm__("r8");
 	register unsigned int b2 __asm__("r9");
 	register unsigned int b3 __asm__("ip");
-- 
2.38.0.rc2.412.g84df46c1b4-goog

