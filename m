Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3696E5429
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjDQVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjDQVyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:54:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493E213D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:54:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8e31155bso146618157b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681768456; x=1684360456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqlZpSOgvA1JLW3vzN7VqdCnxfAnggXybW0yzcDiFj0=;
        b=6Ok0UESUh26svpEt209uFygSyHBhPKwjJP2i5VUax6EplbX8ZR4r9D+qJgxeekR4XK
         6Dh99p7UoZMrY3HwK2wWp4r3Bw6dkbzaFd9ThydtwbIN2I3+eDfYB5ErJoEPmfqghLf0
         rwtmeBkQ+ySc7U5Zs5VZCi/MQrPDjJ84A1VrKMUWBhaBy1lMeMxtLLmbL0QV1WOG1GQf
         cyZNgAai2c6reZrcZzBnC0h2wPIRGVQPX0MliftBNYVAYJnVgnjziz8xTWOMY7e73FNW
         zL8UYzWheabjgDuIuJb6aSMdJR5XSkg3iac6BI0BIPTPysgkzR9ci86tf45CX2FT0U0x
         mfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768456; x=1684360456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqlZpSOgvA1JLW3vzN7VqdCnxfAnggXybW0yzcDiFj0=;
        b=dSWci9+aTE7iZ3HbmQ6sfb4IdlVl4Lp50Diti8NMXYd2OqP2CyR+eQ7w7NqQeTaBDk
         3QJbsLi78S/K7O53RYh8YgUMCDfd7zMVYr1DzGiCq5up4Jwm9TdOVEV3L+c65P9csuS7
         CMwKYc2tKygo/1XsGcyeGN+NcFXfwrSjswPiN/y6Ibrc9HG/2Vc4dNhLqM88Dea8t7ux
         4llW0UkWkN2HK21ZXhtC3Vyhg5iOyrUcTnAdc2dH0+h8/X148QfaHSbMdXAPAwxNFBnU
         n3Vc+9NWWGKTOfyoRCx0UGvB7zef0durlF3/Fp1cEYGRuO8v4c4J6naDISDRVeeNe9+Q
         tJLA==
X-Gm-Message-State: AAQBX9fyX2ps+T/GHABW21Doc3chwb727rUdlc7dBygLfkVvOWhqasMX
        qHm7lD+k2lWO+07MMU33vJMEG/57Rt1GxRhV5kA=
X-Google-Smtp-Source: AKy350ba6ZSdzfrXwGQ5fmWTSwEW508zmjFzpnm3zgJ1VAgvkc67q/5rJe5ITrn8QQW6az8rdP0cUFYN1wNh9cRxrW0=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:e8f1:df30:2fb2:cf8a])
 (user=ndesaulniers job=sendgmr) by 2002:a25:df41:0:b0:b8b:eea7:525e with SMTP
 id w62-20020a25df41000000b00b8beea7525emr10639174ybg.5.1681768455963; Mon, 17
 Apr 2023 14:54:15 -0700 (PDT)
Date:   Mon, 17 Apr 2023 14:54:08 -0700
In-Reply-To: <20230412-no_stackp-v1-0-86d2034a4d06@google.com>
Mime-Version: 1.0
References: <20230412-no_stackp-v1-0-86d2034a4d06@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681768450; l=1232;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=on2xOURJ9HOGHwPlBJaraE3eCNVECjunAe4jXLZvvs4=; b=BdjqNu+UYyKvhEjP5f6/uO90m0HacK6S31UoWPhMwomn/HE4zn7R//ZaCa1pvzN25cywrCbexalz
 5UZfSBkAD7ZLc+b4TJLKllZ9RD0Vlu6PiiUP8nAw6AhebQv03M0f
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v1-2-86d2034a4d06@google.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 init/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/init/main.c b/init/main.c
index 1265c8d11052..c6eef497c8c9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1152,7 +1152,13 @@ void start_kernel(void)
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
+	/*
+	 * Avoid stack canaries in callers of boot_init_stack_canary for gcc-10
+	 * and older.
+	 */
+#if !__has_attribute(__no_stack_protector__)
 	prevent_tail_call_optimization();
+#endif
 }
 
 /* Call all constructor functions linked into the kernel. */

-- 
2.40.0.634.g4ca3ef3211-goog

