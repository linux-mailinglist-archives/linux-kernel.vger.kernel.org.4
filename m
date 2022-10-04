Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAC5F4796
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJDQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJDQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:30:16 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C1422C7;
        Tue,  4 Oct 2022 09:30:13 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 294GT79j026312;
        Wed, 5 Oct 2022 01:29:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 294GT79j026312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664900947;
        bh=LA7pqlfes/2P9l9Bhci4XpSBME8emrNvEhJZgnfuV9c=;
        h=From:To:Cc:Subject:Date:From;
        b=Hm2iovcpw0vGc0uaHHKbGxw6IrctYgjvqSHXzfSlQ4VfPAmA9fKDxEDrRdu1EV2nA
         QJg8p3vA/sMApm/uy4F5f6a37gFhXvbpUiANe+cjMomvf+Z/Y2BSbvtiDMhBBEIQYH
         9eVbHx1YKXDVfUNtH+Q6uphGZI5ssWIsJVjXf5xy1syXzfUwr7pBdZd0Rkq3zmtUl1
         C/06YrUQFN22YZr5+Yl8g41+X/VSYrLKhW1zoSrvz7sxh5Kr2MySjHz1eES7nd/FW2
         JpruQYkd4hcM5Re/Xck+6BVSY9OPFy8fr3P8Ep+HIf4nB9AeojAChGHMF8g/O8qDTb
         UkOCLMUGz+IvQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/3] Kconfig.debug: simplify the dependency of DEBUG_INFO_DWARF4/5
Date:   Wed,  5 Oct 2022 01:29:03 +0900
Message-Id: <20221004162905.24997-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0a5c81ca9be ("Kconfig.debug: drop GCC 5+ version check for
DWARF5") could have cleaned up the code a bit more.

"CC_IS_CLANG &&" is unneeded. No functional change is intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v1)

 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d3e5f36bb01e..f4b2165f24db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -264,7 +264,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
 	  if using clang without clang's integrated assembler, and gdb 7.0+.
@@ -276,7 +276,7 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
 	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
-- 
2.34.1

