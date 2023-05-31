Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEB71727E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjEaAeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjEaAd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:33:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D563133
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:33:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b039168ba0so27946075ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685493231; x=1688085231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGk2pPm/R2xKDXUfInvH1/h+MKIoGyTSxvkj4j75uvQ=;
        b=aU9sbqjO6FOH4OjHoZl9HCu8w/9xFMav6a897k/UNh3MC8NvnuK8nJlfdSu3YfMy1S
         CfoHqGPLmWhetd1Q5v0nU8M1ozEgDrehBFnsGr+ttleR0mG5alsZBiiTjFv1/zGQatgv
         1jDpDfrm6eOsQRx76YhDPeR9EzpJY3mGWNVno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493231; x=1688085231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGk2pPm/R2xKDXUfInvH1/h+MKIoGyTSxvkj4j75uvQ=;
        b=QHm4wTrBWtuIwvRGrlUbKyQPvHyX3GOEU6wddHD1t3PMRkkdC2/d9FiDuu09Asdzy2
         gOaFuOPyy234Vh9Ftsps4as/oYz2TWU5Awm/gbj3i97aLB4dzLnybTUN6XcN3Z2nc/gj
         TR+Jgt2288CisY/I3u00tYWHArho87mJ9laE5xRB+foOhaDvMPF8LDeAJBYjE6Kixb44
         twgGBcYgMnf7XvXEe9KuhtCUqLvLBqDM6pACk6kOxHDjwg37cjWNxHQot27Kj1xvLTdY
         YEr8QvG2mKEBYbTp3H4viJXiqffkcWP3kUNSXmYQXn7iSLbTCmXVyHLmy3RCVdLe6h8Z
         np+g==
X-Gm-Message-State: AC+VfDz0VvhA/4QPfTpcdHzPiv4EHmKCvFwrjgLtDnkqKjtbbZe1iZZ+
        oM415WPM0Vk+3fShgSqb6UuvWw==
X-Google-Smtp-Source: ACHHUZ5fk8QCsWPoJjlvPaydRD9HRoCpd8hVDiA+bJV6S+ue+UATXP1xekTwg/CC89wKlvW+rnxt/w==
X-Received: by 2002:a17:903:1251:b0:1ad:cb4b:1d50 with SMTP id u17-20020a170903125100b001adcb4b1d50mr4275796plh.43.1685493230823;
        Tue, 30 May 2023 17:33:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy11-20020a170903130b00b001afba6edc8esm5834730plb.166.2023.05.30.17.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:33:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alyssa Ross <hi@alyssa.is>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/purgatory: Do not use fortified string functions
Date:   Tue, 30 May 2023 17:33:48 -0700
Message-Id: <20230531003345.never.325-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; h=from:subject:message-id; bh=ao5LV8uhf7AW6uhvz7/l2r0HIMgkZx9x0D0AtBfW3cQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkdpXsKi6U/2JC1CTPb5w5WKm00pGVcRtMNu3mO2PT ukZUgdqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHaV7AAKCRCJcvTf3G3AJuJPD/ 4jQvnkIP/GfJ5l2I6LZc3LzzDonJiLJoBvfrAC9OlQ1irZ57dwtVNiaLBia6ntczj2vMPkpvKA82Up IPZhD2zNpQEqcMd4fU6l2RWFa0725iW/wFVsCQ8+WcUXWFrnDL0jutjOV/GpOPUwYzWdW6lp4Q6aqJ jEvPKmb7m/3GbQ5MoW6vVxZW/PP8tD3w6Z5HYaoCly3pwbBwPte5DRCfEDNp4KM3W92m6/ozAk6Yjc KcwU2xh0qXJLgPATih7BaAkzR904LQT/MlNtj9LOj96JheoC/oHfAN0lqq5oy9x3azrzFI2mX65yK3 2VJ8IKpQYFI1IgW2DuVnSqbuxMBQsvu95b/KZ8cYOZbOYgN5gKtUGfC20cIeE+U6YRGGj5lbGUI9uc 0gmaFC1/rYmhb9N+O7ascEYWke6YEpZXkcAPyiXhCCcz1V1W/ZPoEV5CGyCFBn44yVSobhbAuAgiFW OAMGyPDa6wjF7lgbg1mglUYGCgmwa2ZWlOcgdA/KEuiUyNmiJ8EASE4okSVBs6mTjlA3kAw2jxEag5 cvC7sAW4OzJiLfHIYBB6FOqDe/0oMNOZ4r9N4rIMNh7HhbUDEJdRVGgmk6u2+8o+0Hf7luhfG1MgD8 ASgJHFC4bQ6T989JNVoiRv0QD8bn1Fsxh53wFwaWEwqWiRyYED+bNszUUDeA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of -fstrict-flex-arrays=3, struct sha256_state's
trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:

struct sha256_state {
        u32 state[SHA256_DIGEST_SIZE / 4];
        u64 count;
        u8 buf[SHA256_BLOCK_SIZE];
};

This means that the memcpy() calls with "buf" as a destination in
sha256.c's code will attempt to perform run-time bounds checking, which
could lead to calling missing functions, specifically a potential
WARN_ONCE, which isn't callable from purgatory.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Alyssa Ross <hi@alyssa.is>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 82fec66d46d2..005324d6c76b 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -12,7 +12,7 @@ $(obj)/string.o: $(srctree)/arch/x86/boot/compressed/string.c FORCE
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-CFLAGS_sha256.o := -D__DISABLE_EXPORTS
+CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-- 
2.34.1

