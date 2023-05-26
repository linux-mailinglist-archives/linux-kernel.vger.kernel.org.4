Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306E6712BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjEZRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEZRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:25:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9724125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:25:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b00f9c4699so7184295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685121914; x=1687713914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfNMXGcl/NoZyU1TMuXBgw5Vf3pYoZn7mpjEnfq/Mik=;
        b=a2oyvZaTloig24bEWaQzdNYWUOL6m4mXSiAbb6RBBz3Nc0GhC8q8035ImW8YDXfsUh
         oGlubxkuDhTTF5XTYh+RJ/MelMM+4absRCAZcrauneIQ70uzQgAPm0DV/Rna0GC9XW0f
         KuUeY+ky/cJoSnfql03OzSnmi4beNTvmrjrN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121914; x=1687713914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfNMXGcl/NoZyU1TMuXBgw5Vf3pYoZn7mpjEnfq/Mik=;
        b=gLd+AbikjLO/fRwJhqvaNAhb7JQSzqNl9+4VJcqf3nb5HW+5mjGGYt2cULJTfG/b8u
         3w9pFL1bw31OG/fxpnshgpFVlTaSzR26LFMFYjuBsCO7GDFxW8Wr6LjBjr/ci/aaSvyh
         oECUqDfm1j7Cn9vMRsngjuBFj8ODQq8bGW8y+OBdNRj+V4iTcsboEWKLZAx3cPnHAAlV
         R9Ja0pV3qAqsrWn2VhyerUKH1Sw9Ce7YCUwy1BSsuZjB2+m8tNKMIFS7hUxTJoHPqCjd
         YV+I5R3mrUdKM84VoAQBPSF4Ev2ZwCzWFWckDkWUhKQ50LlnEUlo1RicmEeBV0k5a18s
         /i4Q==
X-Gm-Message-State: AC+VfDx9UvgP1CWzJc2RSOFWQUm/ibm+OxwKgY/CIQN4o+ruk8J2ZERL
        6IYHMoJ9+710qyRSMlmueu24Bv7BpcZCnFsILF4=
X-Google-Smtp-Source: ACHHUZ7akEKdSRLtn7ET8rqSs2dwk9Y3rO9LoKvADJjmViawMnhh116yZkVkCI78s7Mf0hw1qQBjxA==
X-Received: by 2002:a17:902:db02:b0:1ac:750e:33ef with SMTP id m2-20020a170902db0200b001ac750e33efmr4095459plx.3.1685121913871;
        Fri, 26 May 2023 10:25:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902cecd00b001a064282b11sm3494052plg.151.2023.05.26.10.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:25:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] checkpatch: Check for strcpy and strncpy too
Date:   Fri, 26 May 2023 10:25:11 -0700
Message-Id: <20230526172508.gonna.793-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; h=from:subject:message-id; bh=gR1dVrDDLBhiUgLe7nt7jcC1so04DAJwfqgytUoUlaU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkcOt33rxJ0GO+/P9Nn4/quZbyds5yHyTRcxPEVafB 5vT4zqaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHDrdwAKCRCJcvTf3G3AJsqnD/ wNivL/mRH0uKxIm3r4cWNygeKy4bnw9P3mIryMSk/WWOkkzk/n/JMP+xAB/eCsXtdaZHcqEyyFWlZx QQVvFKON49UxTBpwx6D1P6Vvfn5RgXs2nKoIAAqgdyuURSWCwL/EGnSxb18EvD7DvkQay/n+UYl2gr udS9AyFd34M/GO60vjhQFgdroTmb0l/d7zfvVATewDowfPiccY4x5TjsDhYGREjdkCdrbcueDTBQ+k XyYKMQugRGefzHhe+aRYVe8f+QKHyZV9rZrDEpmmIs+mWddmwKhkr3wkHupDhiyGqKAV6Y6SEF3YDQ qkr8SfRwc3f//P3C5/+MO3oCGez0hW1Wt0lggTcuqkGx7avoYaAQdvwGnrknuPFiMLNZQ+ndzZtGKu zRWQ6P57N6T/i0BgEfMJfJK3xKY/bfMCepxBbjgamK2ayCwUNokXl/++oNrRTboekxX1an0QR11Bpq Nnd7+U02kCEOcM3KvP3mtml/IPYjW+WmiAXXIHMFrPzgfLw6ZiZLxurHbu0I5bVxu1XxYY/5jc3NYd efV+1L8ZN14Dh9mqIf4o1cIb8IBp1cB6e/MjhxPUyt/OY9LFJV1angi8zm+zGPSCpBd6tZoryJb2Km WgHWm/5PYtgvXQ66+OpCb5oWS6lqpkl0VU5rc+H7CXpzv4L0qqns+PuZorLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn about strcpy(), strncpy(), and strlcpy(). Suggest strscpy() and
include pointers to the open KSPP issues for each, which has further
details and replacement procedures.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230517201349.never.582-kees@kernel.org
---
v2: change language to use "Prefer ... over ..." (joe)
v1: https://lore.kernel.org/lkml/20230517201349.never.582-kees@kernel.org/
---
 scripts/checkpatch.pl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c4..30b0b4fdb3bf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6997,10 +6997,22 @@ sub process {
 #			}
 #		}
 
+# strcpy uses that should likely be strscpy
+		if ($line =~ /\bstrcpy\s*\(/) {
+			WARN("STRCPY",
+			     "Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
+		}
+
 # strlcpy uses that should likely be strscpy
 		if ($line =~ /\bstrlcpy\s*\(/) {
 			WARN("STRLCPY",
-			     "Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw\@mail.gmail.com/\n" . $herecurr);
+			     "Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
+		}
+
+# strncpy uses that should likely be strscpy or strscpy_pad
+		if ($line =~ /\bstrncpy\s*\(/) {
+			WARN("STRNCPY",
+			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
 # typecasts on min/max could be min_t/max_t
-- 
2.34.1

