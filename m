Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15C6978CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjBOJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjBOJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:17:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39181F496
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC02B81F5F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E76DC433EF;
        Wed, 15 Feb 2023 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676452630;
        bh=uNbyhfFF7dB/914brsLtnjUU5jomIQd9AeTJjXAJJSw=;
        h=From:To:Cc:Subject:Date:From;
        b=Is4IA3Qu4ylaVKqSLmbPUpibQM6Qu2KiARziWsCrFEE19iTf/oayUWKMnG3gC/b+n
         K6ZL5HRF5kVS5GYJzOtN/WOfVtx8bNM6jX1qteqqDubkL6au1LfaAZ5Ut2lnHB0F71
         WiUL9/aMMAxpCANT9zlbtimps4IjlMqrgouB9Dp0nlPerfmirvG1VRi/e7JMkjO8a0
         LMz5B0/AVisMgFlNCpPrxeS/W8qIcEEsTV77426bEp04QizLUMmezOlM1vhYbQ1Jdr
         R+HI/LrdlbLwWt40L6St/wssDUl0EpTHKZctX51F9NGNmr0s54Bln3otFJiTUFUN/o
         Mt0NPzri/d2Rw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: make 64-bit defconfig the default
Date:   Wed, 15 Feb 2023 10:16:56 +0100
Message-Id: <20230215091706.1623070-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Running 'make ARCH=x86 defconfig' on anything other than an x86_64
machine currently results in a 32-bit build, which is rarely what
anyone wants these days.

Change the default so that the 64-bit config gets used unless
the user asks for i386_defconfig, uses ARCH=i386 or runs on
a system that "uname -m" identifies as i386/i486/i586/i686.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a27b27d1418d..cc7efb6e6e6b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -3,10 +3,10 @@
 
 # select defconfig based on actual architecture
 ifeq ($(ARCH),x86)
-  ifeq ($(shell uname -m),x86_64)
-        KBUILD_DEFCONFIG := x86_64_defconfig
-  else
+  ifeq ($(shell uname -m | sed -e 's/i.86/i386/'),i386)
         KBUILD_DEFCONFIG := i386_defconfig
+  else
+        KBUILD_DEFCONFIG := x86_64_defconfig
   endif
 else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
-- 
2.39.1

