Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F171674D63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjATGen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATGem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:34:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8A654C3;
        Thu, 19 Jan 2023 22:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04910B81B1C;
        Fri, 20 Jan 2023 06:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50181C433EF;
        Fri, 20 Jan 2023 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674196478;
        bh=BTZ5ynW9dFHI8pgU+nM0G7IYtTLPvBGRXUKA8tahUxE=;
        h=From:To:Cc:Subject:Date:From;
        b=P08vpsyuerHT57RhU3qAy42QsR7AGWBzh05St7h44YqpzP2+pEfgfTpZIEy8wiN3w
         hhuGBPJCzask6xjzaG9sAfn86lJZQXItSnXUHSxgVK3Q/HZuTrlMBC+gqyj0LshIYs
         1A3wN0RZncbFREnLe/Zn4LuEq+cS6obwqLIQCK2kAFigK8IekqnbClQaN/ZlDPn5S1
         9xZaxqV9ss/yz5uVlt63mMu56+ZfhvI+ZPJwzJw/kGo51I4/tchyq2RejLVsX9ItDH
         eEmK61VFjcCT5VuxnGtCNlfWC676WfVD68FY2gKLaw30DD0IKfqSN272FBFfbLtynn
         OHzNi+bfu3I5Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] MIPS: remove CONFIG_MIPS_LD_CAN_LINK_VDSO
Date:   Fri, 20 Jan 2023 15:33:51 +0900
Message-Id: <20230120063351.433502-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Given commit e4412739472b ("Documentation: raise minimum supported
version of binutils to 2.25"), CONFIG_MIPS_LD_CAN_LINK_VDSO is always
'y'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/vdso/Kconfig  | 14 +-------------
 arch/mips/vdso/Makefile |  3 ---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/mips/vdso/Kconfig b/arch/mips/vdso/Kconfig
index a665f6108cb5..70140248da72 100644
--- a/arch/mips/vdso/Kconfig
+++ b/arch/mips/vdso/Kconfig
@@ -1,18 +1,6 @@
-# For the pre-R6 code in arch/mips/vdso/vdso.h for locating
-# the base address of VDSO, the linker will emit a R_MIPS_PC32
-# relocation in binutils > 2.25 but it will fail with older versions
-# because that relocation is not supported for that symbol. As a result
-# of which we are forced to disable the VDSO symbols when building
-# with < 2.25 binutils on pre-R6 kernels. For more references on why we
-# can't use other methods to get the base address of VDSO please refer to
-# the comments on that file.
-#
 # GCC (at least up to version 9.2) appears to emit function calls that make use
 # of the GOT when targeting microMIPS, which we can't use in the VDSO due to
 # the lack of relocations. As such, we disable the VDSO for microMIPS builds.
 
-config MIPS_LD_CAN_LINK_VDSO
-	def_bool LD_VERSION >= 22500 || LD_IS_LLD
-
 config MIPS_DISABLE_VDSO
-	def_bool CPU_MICROMIPS || (!CPU_MIPSR6 && !MIPS_LD_CAN_LINK_VDSO)
+	def_bool CPU_MICROMIPS
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 1f7d5c6c10b0..18af9474ed0e 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -52,9 +52,6 @@ endif
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
 
 ifdef CONFIG_MIPS_DISABLE_VDSO
-  ifndef CONFIG_MIPS_LD_CAN_LINK_VDSO
-    $(warning MIPS VDSO requires binutils >= 2.25)
-  endif
   obj-vdso-y := $(filter-out vgettimeofday.o, $(obj-vdso-y))
 endif
 
-- 
2.34.1

