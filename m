Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0962EA66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiKRAe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKRAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:34:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399E79900
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6EDBCE1F6F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862D4C433D6;
        Fri, 18 Nov 2022 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668731691;
        bh=a0oKk28hds48kvk6Cz1Ecd3DjivBxBqAMGmz4lfIwe4=;
        h=From:To:Cc:Subject:Date:From;
        b=XOJgf8LyVo1gwHHADtM1ZldXG1S4EAISytDHFJcoF77pKw2K0aBcVPC5GpdlRZ/B4
         RuPR9xMKrMuekXmx88N+xR5iYOt6bH4ryXUVRVtlXs+IDXzdZH5+ZFGBzzfZalpygX
         UqDWt4l9ZmQDX06U/BkG70QDjXa0SnCC65Cy7kqluRJj4iI5FBQ4peNtD2ll6KBixB
         RSlaj6HdB1/5nLIyQ7H6k0LURYn+RMFE0Py4IyrpchjCJDVlL/U+rMcjnqP7yjLdar
         rlj4hSAOtm5G44eWrMINBWgejuoE7MqdAJ3nv5pG+zi+3jDRvetvUIS8Gx8MF3CZR7
         WfWX1dzSVbTIA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] ARM: Drop '-mthumb' from AFLAGS_ISA
Date:   Thu, 17 Nov 2022 17:30:58 -0700
Message-Id: <20221118003057.3223394-1-nathan@kernel.org>
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
Debian using CROSS_COMPILE=arm-linux-gnueabihf-, the following warning
occurs frequently:

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
Link: https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/raw/622dbcbd40b316ed3905a2d25d9623544a06e6b1/debian/patches/930008-arm.diff
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
v2:
  * Add Nick's review and test tags.
  * Call out explicitly that CROSS_COMPILE=arm-linux-gnueabihf- is
    needed to reproduce this issue in commit message (Nick).
  * Fix dead link in commit message (Nick).
  * Use the snapshot branch for the patch link, as the diff is more up
    to date against upstream LLVM (Nick).
v1: https://lore.kernel.org/20221114225719.1657174-1-nathan@kernel.org/
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

