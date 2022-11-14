Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB69A628C72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiKNW6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiKNW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:58:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183021ADAC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:58:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3EF1B81250
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89B1C433D7;
        Mon, 14 Nov 2022 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466693;
        bh=z2liwwd8gcod1sLF+wz7lbOEfJTIH9wHoEzy8NzIIsM=;
        h=From:To:Cc:Subject:Date:From;
        b=AKx2hahilaGrxP4DvrTV2cksv2YTL451RIIVe4TPwQNuRQNToNnmAD/6IGKdD6xgf
         0la3A6xBrkIUxsEZZqAq0G6fJvHFpGzIJXXMOv+stAYqzhT39X0vwEmL07MGVpfTuk
         Bo4mgE7kkGm4MBneTTs8sfh6BbnqC+gLDaH+MSq713UGThuaX9DtwHa9oisvK65GZt
         KR1b2JiYMX64t5GlL1AEwJ5UVbAMXUoobSbmyidWlZe4rZgpGttkkHxcdO6So7CyBV
         MB8kv3zy0iec/liBKZpJUP9QKtrH59MeyAeuzCUHmKRp+QU/It6BAWfE7mAGh7B3Mj
         fw39e10Nro/Gg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] ARM: Drop '-mthumb' from AFLAGS_ISA
Date:   Mon, 14 Nov 2022 15:57:20 -0700
Message-Id: <20221114225719.1657174-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_THUMB2_KERNEL=y + a version of clang from
Debian, the following warning occurs frequently:

  <built-in>:383:9: warning: '__thumb2__' macro redefined [-Wmacro-redefined]
  #define __thumb2__ 2
          ^
  <built-in>:353:9: note: previous definition is here
  #define __thumb2__ 1
          ^
  1 warning generated.

Debian carries a downstream patch that changes the default CPU of the
arm-linux-gnueabihf target from 'arm1176jzf-s' (v6) to 'cortex-a7' (v7).
As a result, '-mthumb' defines both '__thumb__' and '__thumb2__'. The
define of '__thumb2__' via the command line was purposefully added to
catch a situation like this.

In a similar vein as commit 26b12e084bce ("ARM: 9264/1: only use
-mtp=cp15 for the compiler"), do not add '-mthumb' to AFLAGS_ISA, as it
is already passed to the assembler via '-Wa,-mthumb' and '__thumb2__' is
already defined for preprocessing.

Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")
Link: htps://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/17354b030ac4252ff6c5e9d01f4eba28bd406b2d/debian/patches/930008-arm.diff
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 357f0d9b8607..d1ebb746ff40 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -131,8 +131,9 @@ endif
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
-CFLAGS_ISA	:=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
+CFLAGS_ISA	:=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb -D__thumb2__=2
+CFLAGS_ISA	+=-mthumb
 else
 CFLAGS_ISA	:=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA)

base-commit: 0c52591d22e99759da3793f19249bbf45ad742bd
-- 
2.38.1

