Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5606E547D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDQWAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDQWAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:00:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7B6E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:00:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 77-20020a250550000000b00b952e25225cso304891ybf.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681768816; x=1684360816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqlZpSOgvA1JLW3vzN7VqdCnxfAnggXybW0yzcDiFj0=;
        b=Dcz34byVNZ9qV9IHk+YJ26BuUvaX6xN3JD1MLhhcg+vEs73z+4DnMFKPv1CZTPJDF9
         w5SErioB3/0qSbvCl7uZpcEP6ZuqhB4vtU9mU5iuvQSugVPtH29I+Vm9c15JkMxaP85s
         iDQ1jMAUki4MIVgrwkG9R4ZDzhSfvpvlfCfLeWD3uQp73n/8wfFBbq3G6XZ1cSoiSSCn
         br6k8v1KzuB8xzOZTiPzGtYBICkELxBLosBaF3DpddrqMKiuYqrtLVQGIXuvEygPzalq
         6A0hr6MADiEnlazeG1YRI5wVPCs0Px0nBb9Cv15BR09WFBqBXamuwWE9fHKuVeQ76WdC
         lzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768816; x=1684360816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqlZpSOgvA1JLW3vzN7VqdCnxfAnggXybW0yzcDiFj0=;
        b=X4ZxnLngd8iUM1WGPFOBhWIlD+tZYODq/lQjG6mtbClGm1ecXhTmcuIdQp61lWboft
         tzzSUqJrm4fySM3+Wq/J4+hyF/V5GXZHqpKU12ET5nPKPg/5PPeas3izwj5oh3nnLcCA
         GqLHQwOvNhsaNGjbJvKg0qH+fGcKIP+eMJvRoQ/nRXymPM2Mk8WwRLNykxmpCoF4/gj0
         WUKQz+a0E/Hnuc0Bv1dHLV6/HB9LtaIzITSGrO/Cj318rXq8Cs+YOu+3m5oGJE/+B6eD
         Lq5yKifaG14ySr+WuZg8KBWhb94ZkKsMWbWcxgztWyZJwAwEF+K45l4W03ZpTQAmcTR5
         39tQ==
X-Gm-Message-State: AAQBX9e2o5SRN4vMsp46LAPNNIRHOpLFqdZf+N1q8HavOJ67ERDvXAJu
        5CLuflDZHEbtok2UX/gtXX2cckl0fhjVlyYatjo=
X-Google-Smtp-Source: AKy350bI3hEMdN9THadORatwbKgb2gSp9/Sr1mQyCa7cKJufbONuj5Uq6gacrQcy+GEB1jC8NAtAPrOU9H1jIKB1E7c=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:e8f1:df30:2fb2:cf8a])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ca83:0:b0:b8f:6944:afeb with SMTP
 id a125-20020a25ca83000000b00b8f6944afebmr7279341ybg.3.1681768816329; Mon, 17
 Apr 2023 15:00:16 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:00:06 -0700
In-Reply-To: <20230412-no_stackp-v2-0-116f9fe4bbe7@google.com>
Mime-Version: 1.0
References: <20230412-no_stackp-v2-0-116f9fe4bbe7@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681768810; l=1232;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=on2xOURJ9HOGHwPlBJaraE3eCNVECjunAe4jXLZvvs4=; b=L0214FF9WU+WhlG7EzCoRDmJSFHfOLYgc5DpN0xGXJqbxpSQab4viRMfkP8gWde2O8Yg/xXdIYYu
 vTfwxxyzATDCCks6/5GnQp2JFk73gQwqAoQ2jgZRGhol7n4bDB+1
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v2-2-116f9fe4bbe7@google.com>
Subject: [PATCH v2 2/2] start_kernel: omit prevent_tail_call_optimization for
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

