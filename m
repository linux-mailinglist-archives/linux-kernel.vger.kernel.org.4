Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB31743135
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF2XnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjF2Xm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:42:59 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D730DD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55b2ab496ecso729383a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688082179; x=1690674179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Xlw8wqmc7m2gTD7N39tQeUlWC1WXyQLWb4QZRUB8Y=;
        b=p3VLofC9uBlj4VqikzkpTVhIEDvSp6dp7csrh8LTmsJ2AioG7ohNPCyZXFqNRY4xl2
         67M3uESl94bLO1M1ieHMv3cFZxN3FFyNQ0yWBa3oxuxiEFwLMPd34J+muGl+kMjVt8sZ
         IaP7ZZcHfBi6OBW/hhL8waRnsfqbeMv3qP1yH2A1MZMIWsagGhMutscPGf6/l0CtmEJC
         eH4izIvergiWXqGTOpw9Vsbk5iEj4hbcxvhKT+YPCyTIG/cK4TBss9B64FaAeElrkph/
         /FmsTHj9LxHPV+CVsN5UMIBeeHMoz+ubIgnc4AlwKuZkWfAvt5iWCuI+vv7VU5neuWXL
         aJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082179; x=1690674179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Xlw8wqmc7m2gTD7N39tQeUlWC1WXyQLWb4QZRUB8Y=;
        b=ffHLdZTDRrjPKIk8mhe6WZpq9iJwWjGbMpOxevcTfgi/JyUpUEvDuokH3K4v9aGAHu
         J/FWGHFQaCcDX/bZeXyJTMM9TP/7i96g1C8GiQbmDaRrXg5WGKISvWdmRWyYXjg2lsil
         Wm8Rb0GsqzJxGteFO0vVnzebSyd5+hEu0GMhBcEk9N56mkKNwOacT4wmZDx6jyrNZlat
         jMC2K+T/ru2B23q7Aws8zN/EkDoiI/VqBxXPIrMZJ8hdx85vm7qKProDF0kEcl8Xdwty
         GW9BjoNYWoMaCzVgvpcZIVn7bWDUW+myUFnFrhuRsoNYPGdjS+rBCIKvaAc9pYT026n/
         jIwQ==
X-Gm-Message-State: ABy/qLYcv5rDsm+fQCd1KPsTARStuWdQqaeaftomC5Ir60oDWGDhiBVh
        x+cmVZMFDru4co6STV00Up3CFsKZbiiYVyvoXbw=
X-Google-Smtp-Source: APBJJlFHLSu7NeB6EU8tOB3/UHptwEsU/4w39fszUoslEvKjGXk+rTe4axHVWR092ZKjtQWWIfnwLK3jAyxYC69lOLA=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:1783:b0:668:69fa:f795 with
 SMTP id s3-20020a056a00178300b0066869faf795mr751698pfg.2.1688082178828; Thu,
 29 Jun 2023 16:42:58 -0700 (PDT)
Date:   Thu, 29 Jun 2023 23:42:50 +0000
In-Reply-To: <20230629234244.1752366-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230629234244.1752366-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=samitolvanen@google.com;
 h=from:subject; bh=gs+HqEOxqge1JD2H3C2OtV2QqbKbTGj0I3LUMBMWFOw=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBknhb1mBbGJYC+ijqffqvxPbBoNNe723klVhBkW
 m8HhCBORNaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZJ4W9QAKCRBMtfaEi7xW
 7nW7DACWpElrAA2aMey2/F1+uNsTn4cuQjvpzYjhSgMneDZUzTvG9j2obc9IHVDVv2V35NZZ4Rx
 qYnhvOXv6ow3iGv+8NVoRor2ccyLXINBkBk/bdzyJ+g5Iz6AutmOsyLdDODLa+au96lNnKDLqq+
 Txok6LqZKNvnTtmBO01sSp+NaX0Fhils37JKcU6zNe4QxFb9dq6jTzowqNUjIX5wJ5zoAHL2T0s
 tLymrEt+OZ5ON9rDFrhMSYiF/P47V6jz8+j2F6hEFzx/c06i14VwYtWoLPoOv/HD6BOPuit+m3q
 W9JWzrIJwcyWdDLlG9ukewzXluZOrbvAQVgin2f6Le7Y2mvWOHldJvFbUa8nYeErwxYpRjXoIFy
 8tVOHkO6lNvnaruOkuaq0Szw25ktCiQV0nrgU30ZQ/JnEO6BozZdXZC/CZ6K3n3QL1cUDQqAgHg I0w0CpD9whXokITAv8X6e6UXd4zEDbwHvv3Zk7/XIwHjMo0Doyr1T55fqBfmjLc35Zmb0=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629234244.1752366-13-samitolvanen@google.com>
Subject: [PATCH 5/6] riscv/purgatory: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter out CC_FLAGS_CFI when CONFIG_CFI_CLANG.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index dc20e166983e..9e6476719abb 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -77,6 +77,10 @@ ifdef CONFIG_STACKPROTECTOR_STRONG
 PURGATORY_CFLAGS_REMOVE		+= -fstack-protector-strong
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.41.0.255.g8b1d071c50-goog

