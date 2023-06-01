Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34D71A38F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjFAQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFAQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:00:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C15199
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:00:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b0478487c3so4940655ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685635233; x=1688227233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSSMVbhKiQKes2FXn07HT2PehTcS3LvEK8iBz94W+GE=;
        b=G40YuqS1UsFpH+HN2SRB+wSxhkekURBx9NKclSP3kmF3V6Fhww8jiP3cDwI15wLucl
         SVk/ii9MR6JUzAtMSQ3vdNuC9icNcRIH+N5v2o4AiDjDBIa49c6JdpsvTGQJfLdq/7lp
         S3EubNPyT2dJIDTD1Pvpj6u6Qf5IlwBF0m/Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635233; x=1688227233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSSMVbhKiQKes2FXn07HT2PehTcS3LvEK8iBz94W+GE=;
        b=fb5V4PBrYW13U+wuQ/8OvUYhMkS6iG9LKZdKqH9GR8laYv3V4rTRJBr64UhvIB6v6T
         JjiNuVqCZk3YoaP9jeTo/xnYJZD28nOSdTdCVXLWaCWf5CT1g/PgpEDxh8lVh/i4/fLk
         kxyi02d4JzJhvE9qv4ptq2meq2E6fVcIDJK3BzAy5Dkilvs9dgHtkcI4EbrdFDnKsd9a
         ZCEDAJMDH951UwStio0Wu831gCNCOk01gRawIzorIxHjmblOTu4vQscZKzGtp4e5aLzv
         4oQ9tyhDRN62jWZr2cnhmC/Hx5lb8lgFGzmE09vNwmHo1mdoe0yFhg7dyUQL+WxltXID
         ILYQ==
X-Gm-Message-State: AC+VfDwV5dd8+i0G07I5jcAUfJU10efWWrMoOInzM4S+slw4uo1j3m6x
        eCVjgiDJ1NOhZ3tkBvYt5fV47or4W4uakW47QiA=
X-Google-Smtp-Source: ACHHUZ7Y/j1K0K+OI8RiBenflSTAHsKRmF86JYQCC8TX/WswDP9/djNgLEAJ0bZT13bWWUVoH+F2WQ==
X-Received: by 2002:a17:902:8307:b0:1ae:305f:e949 with SMTP id bd7-20020a170902830700b001ae305fe949mr5823287plb.6.1685635232876;
        Thu, 01 Jun 2023 09:00:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b001ae42480c82sm3662096ple.226.2023.06.01.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:00:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alyssa Ross <hi@alyssa.is>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] riscv/purgatory: Do not use fortified string functions
Date:   Thu,  1 Jun 2023 09:00:28 -0700
Message-Id: <20230601160025.gonna.868-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; h=from:subject:message-id; bh=D3i2fx38SuZJfTLJnG4ariCLKDkYJ4XMlsdasO2er94=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkeMCcr4GEaZm3mIC8bLTgzCfv0iCFwT3u6pSWp2/4 oidJwVuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHjAnAAKCRCJcvTf3G3AJosmD/ 9VUGMkQRPLvYkOTpl4FX/cepeYlRCO0IrieC8te7msoWdE6Be3W2w+fdYWKAqFdqWAsxpFdq+r1dWa OlSjzEEEhmDAzdQyqllhVMRdKGSYQXUnj2QrDrq+ZHaMpAAQK9xDhDdsqtgpfpUQkfH4HPnJKn7EUJ 9fiG93rORBeoFqTeTjFguaR7qgPET/W/RhadhoeETdqeYKEibyeHTwnrONdW6SLkfmuXn9M4FOCE44 z+z7CZMwLYp5MxSQptwNFeg/XsQXCZlf2ieOvsS3J4xAoOFHGXaSQNorAzm+woUUMP2rdiK6xa08Hl IrCYt5TNpi/0oL0SEUnrEwj+wqCUQ1KPP2AnmfvST8kW/YDCCgEmonSuSNLtPw3LmUcEkc4nLXVPbN wul8nbMNGrFwms1JhbMFkjxGW1xvvqv3uqVahy0MPNOf9a7rABAbfmx5KQE3IjK8OQb75ieWxK5F+s shhk0Qz/JS5E8PM9YKzwIpMFA+I48NuQOSc0zNmxwCvKvJMUspLhUQaqqyosz+IGQw9wLNPLLycEdX PS+r83Gn1ZtHgbteZK2hGOlv4oDVxDE4OYZL/Fl2lHCvjDnXUxGqeqA40rVpidDWZyMkQMP372jPwa WbKuQ7fIa8qQqvkrjU8EzNp/oqETsJZs6fuaXUDAj5uLbRH6uHn2fB2I9BvQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alyssa Ross <hi@alyssa.is>
Cc: Heiko Stuebner <heiko.stuebner@vrull.eu>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: - only limit fortify for sha256 (conor)
v1: https://lore.kernel.org/lkml/20230531003404.never.167-kees@kernel.org
---
 arch/riscv/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 5730797a6b40..8c73360c42bb 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -31,7 +31,7 @@ $(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-CFLAGS_sha256.o := -D__DISABLE_EXPORTS
+CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
-- 
2.34.1

