Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EA5FF462
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJNUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJNUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:14:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F32656F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:14:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t4-20020a635344000000b0045fe7baa222so3129447pgl.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8mJKRUhkPO00K8I7nJ7lKtujFUxdFbhGR6doaLvrDA=;
        b=BYM366/GijWPTopDA+VEKZCw8lt94RZAa7uz9fHy13iIxLmF/SiRvm6EKXw4XkFrVC
         0/AFpRSo+OkTcJcEowFM26R/wt2WYyUk++ENn0H40iFDFIrigMFwh8BWRUOE7iRYNd2P
         qKAY3+4ocVgvva99hRSjvPK9PZJ6zk4lV45RCTz0FkCeST3ME72YjlFgv3742PGmb+0j
         n7bXvVs99h6QQWxXId6qDWLzlfR0W5inoQJkEbJAKTb3U1mef5pUMKhTwlFV7xn8i8H5
         VWMmkzgTvlXM/Le7Z9DDzVYzaw2o6i0FoK8vu+l/U+FukJtX932a+ixfNqPrxYRR+d0a
         XGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8mJKRUhkPO00K8I7nJ7lKtujFUxdFbhGR6doaLvrDA=;
        b=h1ADXrqFHkjuLGFk/ibqUCSpfktmgIxF3tQHT8CI0zVWdHd+WDvbjSMazdwFrWlyc/
         UMcBiNdPLpBxrfO/enZw22chba83183o9vhmr86dTWxafM89zBKEYFz6kyM/nO+3NeCU
         F7OYzj2l3OJAGLSiCyDPIX8PU8cZxWcEu78WDte4EvrF8OuSti4dSL2GGOvU6x94WBVh
         40qlDYRcZKITMCpZU+1HNm5cDMLxsS/v/2Kp6qCT7DdgQ4m85Z1/2A8tlcb+MzommHqs
         xf/djs7wqk80sSpkYX6etnbHDpVHoZA09J9qADr3rVkGkhx4EROAlspSHmmld2RLLtv6
         PGJw==
X-Gm-Message-State: ACrzQf00Fkuy2silRZLDLE4HkWo/oVignwO5qg9wMEWlsOkbO+wGJ0bi
        jt7bLf1yV6aC1IZhG+5uRBJmAQzJv9lxRUPS8L0=
X-Google-Smtp-Source: AMsMyM6+9zpr2T0LPT/BeZEh1rZWUcFwUjwPvlqA2QZ7aSFLVdSq53MFZ5X702ajJs3ldp0bupobvrmNpHPhBX3GB+E=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:2ba5:63af:4077:4515])
 (user=ndesaulniers job=sendgmr) by 2002:a63:f20a:0:b0:464:8c6:f27e with SMTP
 id v10-20020a63f20a000000b0046408c6f27emr5950038pgh.411.1665778452643; Fri,
 14 Oct 2022 13:14:12 -0700 (PDT)
Date:   Fri, 14 Oct 2022 13:13:53 -0700
In-Reply-To: <20221014201354.3190007-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20221014201354.3190007-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665778434; l=938;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=ACjI4N5sTL9n0wpGEn6FRvgPw+8Rz09PIyJcQd9YCec=;
 b=sGDWzyqBWRtnFPlXYn6kJkJaWPxF/mHGnIFQ2BAlp1wGuBNBknNXQsLiZyXK2nnSLBk0d43jnQ3U
 fmzoIrnOCxUcdMi39cmhiVMeJKrVlAhtyIzU8eFJPCyQj5/IiRBo
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221014201354.3190007-4-ndesaulniers@google.com>
Subject: [PATCH v4 3/4] ARM: only use -mtp=cp15 for the compiler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
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

Avoids an error from the assembler for CONFIG_THUMB2 kernels:

clang-15: error: hardware TLS register is not supported for the thumbv4t
sub-architecture

This flag only makes sense to pass to the compiler, not the assembler.

Perhaps CFLAGS_ABI can be renamed to CPPFLAGS_ABI to reflect that they
will be passed to both the compiler and assembler for sources that
require pre-processing.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8dd943b50b7d..ee888070b2ff 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -111,7 +111,7 @@ CFLAGS_ABI	+= -meabi gnu
 endif
 
 ifeq ($(CONFIG_CURRENT_POINTER_IN_TPIDRURO),y)
-CFLAGS_ABI	+= -mtp=cp15
+KBUILD_CFLAGS	+= -mtp=cp15
 endif
 
 # Accept old syntax despite ".syntax unified"
-- 
2.38.0.413.g74048e4d9e-goog

