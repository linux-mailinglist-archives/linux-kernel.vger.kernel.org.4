Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0274F6D32B7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDARBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDARBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:01:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D881C9018;
        Sat,  1 Apr 2023 10:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11DC0CE0977;
        Sat,  1 Apr 2023 17:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6598BC433EF;
        Sat,  1 Apr 2023 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680368497;
        bh=nuhDMccdMP0Y6Y4UcZv3WOK7g36PHDyTuOqCYd6Ot2s=;
        h=From:To:Cc:Subject:Date:From;
        b=uMu9nix7F2+se3pT6VMrygiTbes4sz8zTZlaAbHMAwxXoFK+rK48DromZFsYot/r1
         xVqV2JMGxMVMD1Qmg3+ADyM3Tuv4xNHsIJ5D7N/d7ge7FMVgAD46n/2Uct7l9Gf/v8
         JVwVOq7YFIk5Lvb4YEEqLshhDqcM9kWgwr31pthGyG5sSZxC3ZTnncfU9X2rSslPkz
         pGNEfBMRQLtAbaHzboDsOBAsMoTv+/yKRfNbqwLFFTbFv7a4rH/qhrb8nHAgcOBT1K
         Cz+tSSUFASey6e0qBv3l2pbO/Sr0+xTmN81X1Zpv1bZ+LKoJd9IQj2a4jSQrbTk9f9
         vr0VOqHfIdRJw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: clang: do not use CROSS_COMPILE for target triple
Date:   Sun,  2 Apr 2023 02:01:17 +0900
Message-Id: <20230401170117.1580840-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target triple is overridden by the user-supplied CROSS_COMPILE,
but I do not see a good reason to support it. Users can use a new
architecture without adding CLANG_TARGET_FLAGS_*, but that would be
a rare case.

Use the hard-coded and deterministic target triple all the time.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.clang | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 70b354fa1cb4..9076cc939e87 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -13,15 +13,11 @@ CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
 CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
-ifeq ($(CROSS_COMPILE),)
 ifeq ($(CLANG_TARGET_FLAGS),)
-$(error Specify CROSS_COMPILE or add '--target=' option to scripts/Makefile.clang)
+$(error add '--target=' option to scripts/Makefile.clang)
 else
 CLANG_FLAGS	+= --target=$(CLANG_TARGET_FLAGS)
-endif # CLANG_TARGET_FLAGS
-else
-CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif # CROSS_COMPILE
+endif
 
 ifeq ($(LLVM_IAS),0)
 CLANG_FLAGS	+= -fno-integrated-as
-- 
2.37.2

