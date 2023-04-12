Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFB6DFD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDLSc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDLScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:32:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C29B30E5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:32:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f87e44598so41690597b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681324338; x=1683916338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Xgas6M12Xeefyhuwpcw2QRuGFdbq5fzUL3tcrdyh4=;
        b=iXUKQ4qfjAJuEFEwE7bdAyWokHRp29Bkdy0/40Xr1KYAPy/R1oFAjwtb5MfmqW0MEL
         CuMyB/Pib2tveCK9kHWVq0CiC/kOMqR+mKlYwJ0ZqrxrTANHa7sorz9Zb5Xm++r51iTF
         4IOQi3aUhO+VEmKHgjdbJldVaRYantgbmWt7Iy9cOgwpY1EmH6XE2TqYbDyjg+J45Moa
         /f0VTPjJRc2yHFY8tos/JCnb5PUKaLk3rH9Y5dWztWapkP1cEiHqSc08rF+6dOVbCjFO
         gGtOWaoMZZ+Ky2GC29N8XqY/5KoA3WJyFQ5WLZUhlxCVgEIbZRD9pfULe4snmF45XhLl
         HhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324338; x=1683916338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Xgas6M12Xeefyhuwpcw2QRuGFdbq5fzUL3tcrdyh4=;
        b=hzgFrszblw5DydqpOrcBzaDNYtaujhiLbbwlcEBvvi/Lfs1BjoqzUKNMc4NZU0Vawo
         YGSYfQvkJK3pujElRfMbTExKZFba9DdNW7Is/qm719aDOH6mTKQ4SVC11cr7VV1j88K7
         trNJQEj43XrV9P4ts1tj7z5bdcuAILAVfPum0fUKfQvYchR6dIyTga57TWDNblQ4WoXB
         sMh5zSDNB6r0ZMAWMu/eNJ38NweAo5OpAL9u/npQBZ8jcoF7IeKwG1gE52+wVu3eW+KK
         lnjwy5xG+sn08CePzHJBYmZf0L0nKi3RIzq6KSqqZw2KW2Fv2M5DiRFsYjYvaVn4t8hc
         h0Ow==
X-Gm-Message-State: AAQBX9cXdbBTSPoi07OO8CyUMQJjghD9cxyizaOplo+wcPybRMuTpcxj
        a/qUDjDfyM3BQvrlqwmpM1MYqnBkdsVFkrTSLvw=
X-Google-Smtp-Source: AKy350ZhORFRgJUhNBaLXid7ygzoYPP5dfsoaQnQskVB+BY7JA/4LnvZjY2JChL2Zljh+aTmG9RZ34lscPJ7XcDFS90=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:4a4a:51a1:19b:61ab])
 (user=ndesaulniers job=sendgmr) by 2002:a25:cc82:0:b0:b76:ceb2:661b with SMTP
 id l124-20020a25cc82000000b00b76ceb2661bmr2380016ybf.3.1681324338347; Wed, 12
 Apr 2023 11:32:18 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:32:13 -0700
In-Reply-To: <20230412-no_stackp-v1-0-46a69b507a4b@google.com>
Mime-Version: 1.0
References: <20230412-no_stackp-v1-0-46a69b507a4b@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681324332; l=1116;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=s0k+6zvdpnLQbD0+TLmmKpo5vAb09vI+qi7R6I+XsOY=; b=haZdkgE6f9QEECC4Hsv98p4rJHUbeBYImb1czOd8DpDLHJCRdPdH3Tdj+/a/776i2EokUGbMCSDu
 nT26vAGYDn2j4pldHwJAdweaA6wBsljZvKEypjxart3UNyaO9cSw
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v1-2-46a69b507a4b@google.com>
Subject: [PATCH 2/2] start_kernel: omit prevent_tail_call_optimization for
 newer toolchains
From:   ndesaulniers@google.com
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prevent_tail_call_optimization was added in
commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
to work around stack canaries getting inserted into functions that would
initialize the stack canary in the first place.

Now that we have no_stack_protector function attribute (gcc-11+,
clang-7+) and use it on start_kernel, remove the call to
prevent_tail_call_optimization such that we may one day remove it
outright.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 init/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/main.c b/init/main.c
index 213baf7b8cb1..c8503d02dfa6 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1152,7 +1152,12 @@ void start_kernel(void)
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
+	/* Avoid stack canaries in callers of boot_init_stack_canary for gcc-10
+	 * and older.
+	 */
+#if !__has_attribute(__no_stack_protector__)
 	prevent_tail_call_optimization();
+#endif
 }
 
 /* Call all constructor functions linked into the kernel. */

-- 
2.40.0.577.gac1e443424-goog

