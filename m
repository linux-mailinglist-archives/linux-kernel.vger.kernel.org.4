Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7E708545
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjERPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjERPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FB107
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f450815d0bso21733695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424824; x=1687016824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjVNT6FV9uD4ZIBTI4+Tqe4kfo6zfAreNXmRgrWoob4=;
        b=r6xOHzDg4+fr+nUwFvipwrUF/Ms0L9MPqCQImkIGB7GqWvghxdL8IdZL8QhogWsfJ2
         Cnjxikff/hDjS9dEtP/5KyqLe1ul7qW1AtFHLDJgcJc9xTMWGnKQhLMtErz90RiNuFs2
         UDHKusDn8oU4ZrKFbQZAn7ssU06rzCA93v+tA+anlnmgBA+9xbWcIsyUp7jVhbXOkzwv
         NxuRElXOBw1axyRgxcRjPhLHTHBCNUtW0VinZ38/rG8YgyZd6uHV1DaOGdTskw+IAtA6
         CiPq3GfjvTFGludfvziDgNZvj1p3tCIAlE3o4Bkbee3AA5F9KpvZKPZWNwZcbqOWB/+g
         pZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424824; x=1687016824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjVNT6FV9uD4ZIBTI4+Tqe4kfo6zfAreNXmRgrWoob4=;
        b=T2iPGWN53CHhHbctMSxsdYxJakhH2y5zYhHcFiig3OQChBS71FJhwTjx0a8re1V4Tc
         QGcByw4ku415rgny9OOauFYfy8H9x7QrpzgAVTkDcfD2QDtD0Pk3lIIkBcxJkZha4g+M
         PSCrmnx1ua/PAP+H4WNFd2tFvahBsUiqx7pf7+k8kFWf95z6z5rPlrg2SkXDOdBD/h+B
         0iW8SajsqzoMrtrd9QApJzBAGwuX1t0jz7k8ly10pklCPDa5rCsMN/LuDo4WxXlwTPSp
         e7up6J/T8EhB6cdc7/zf+eq9U8Deu16KmGe8KEDfgo4gxD5oOBut1w/lMR/a3hDz+34m
         FFpg==
X-Gm-Message-State: AC+VfDw3PWqO5xR7yB5N10OjbBHZwrAdr3nGxEzmCXzx90RNXVR5G1gj
        IIzgPGXaA8Isr5OIdo5turXN1SVeAA==
X-Google-Smtp-Source: ACHHUZ7d415GVo6o/7LbkGpZ42OuiiUFjRcSzoDbfPCWI30MsPqNYmYslcOatrwSjTt/EAPlhYcCJg==
X-Received: by 2002:a05:600c:3659:b0:3f4:23e5:5bb0 with SMTP id y25-20020a05600c365900b003f423e55bb0mr1933202wmq.5.1684424823524;
        Thu, 18 May 2023 08:47:03 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:03 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 2/8] auto: add "auto" keyword as alias for __auto_type
Date:   Thu, 18 May 2023 18:46:43 +0300
Message-Id: <20230518154648.581643-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518154648.581643-1-adobriyan@gmail.com>
References: <20230518154648.581643-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has similar semantics to "auto" keyword from a language
which can not be named on this mailing list, in particular:

	{
		int a;
		const auto b = a; // const int b = a;
		b = 1;	// compile error
	}
	{
		char a;
		auto b = a; // char b = a;
		// no integer promotions
		static_assert(sizeof(b) == 1);
	}
	{
		int a;
		const auto p = &a; // int *const p = &a;
		*p = 1;	// works because const is applied only to top-level
	}

It can be used to save on macroexpansion inside macro forests which
use typeof() somewhere deep enough. It is cool regardless.

gcc 5.1 supports __auto_type.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 Documentation/process/coding-style.rst | 31 +++++++++++++++++++++-----
 include/linux/compiler_types.h         |  2 ++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 6db37a46d305..5bfa605c8bac 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1018,7 +1018,26 @@ result.  Typical examples would be functions that return pointers; they use
 NULL or the ERR_PTR mechanism to report failure.
 
 
-17) Using bool
+17) Using auto
+--------------
+
+Use ``auto`` macro-keyword (alias for ``__auto_type`` extension) in macros
+with "evaluate argument once" idiom:
+
+.. code-block:: c
+
+        #define min2(a, b)              \
+        ({                              \
+                auto a_ = (a);          \
+                auto b_ = (b);          \
+                a_ < b_ ? a_ : b_;      \
+        })
+
+Read https://gcc.gnu.org/onlinedocs/gcc/Typeof.html before using ``auto`` or
+changing anything with ``auto`` in it.
+
+
+18) Using bool
 --------------
 
 The Linux kernel bool type is an alias for the C99 _Bool type. bool values can
@@ -1048,7 +1067,7 @@ readable alternative if the call-sites have naked true/false constants.
 Otherwise limited use of bool in structures and arguments can improve
 readability.
 
-18) Don't re-invent the kernel macros
+19) Don't re-invent the kernel macros
 -------------------------------------
 
 The header file include/linux/kernel.h contains a number of macros that
@@ -1071,7 +1090,7 @@ need them.  Feel free to peruse that header file to see what else is already
 defined that you shouldn't reproduce in your code.
 
 
-19) Editor modelines and other cruft
+20) Editor modelines and other cruft
 ------------------------------------
 
 Some editors can interpret configuration information embedded in source files,
@@ -1105,7 +1124,7 @@ own custom mode, or may have some other magic method for making indentation
 work correctly.
 
 
-20) Inline assembly
+21) Inline assembly
 -------------------
 
 In architecture-specific code, you may need to use inline assembly to interface
@@ -1137,7 +1156,7 @@ the next instruction in the assembly output:
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
 
 
-21) Conditional Compilation
+22) Conditional Compilation
 ---------------------------
 
 Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
@@ -1186,7 +1205,7 @@ expression used.  For instance:
 	#endif /* CONFIG_SOMETHING */
 
 
-22) Do not crash the kernel
+23) Do not crash the kernel
 ---------------------------
 
 In general, the decision to crash the kernel belongs to the user, rather
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 547ea1ff806e..bf0ac2a04154 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -4,6 +4,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define auto __auto_type
+
 /*
  * Skipped when running bindgen due to a libclang issue;
  * see https://github.com/rust-lang/rust-bindgen/issues/2244.
-- 
2.40.1

