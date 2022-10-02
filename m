Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747C5F2481
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJBSMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJBSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:12:16 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4351A815;
        Sun,  2 Oct 2022 11:12:14 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 292IBAaC004037;
        Mon, 3 Oct 2022 03:11:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 292IBAaC004037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664734271;
        bh=j+CRdXzDCIk7h80ILGqHG4tBdM0hTFPUxyAM5SiBoS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAEivjclBA6W7LqmJhbRFutW83NUCp0xaCCbFtUdbSuNF9z5EsaFMSy2a7BK6qM4L
         nR/nvHbm5jQShAeZ3CdemC93qFAxhu7L/EJlFrgTQzlkU6XJTu3wTjDZnl7NIysOQX
         X+GmldZI3ExdcbgSqdOAxIwLohY7WAuuhFZ1TBOx0fqT0Hbg3zom2hbiGJmVAa2X58
         KaAQHLjlbBXJeN5SB8eYq8GZ8pphPQrpp0e8l90jbauGsJJVMUlCkGoYUwr7pvasVh
         rMXQqlRgik3fqxYOqKdEGSZZkZ3U9VOqtEsIWI7rAE/+aUNwD/nITsbZXZGhQVaZ+V
         atpSsY0Ps/0KA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] Kconfig.debug: simplify the dependency of DEBUG_INFO_DWARF4/5
Date:   Mon,  3 Oct 2022 03:11:05 +0900
Message-Id: <20221002181107.51286-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002181107.51286-1-masahiroy@kernel.org>
References: <20221002181107.51286-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0a5c81ca9be ("Kconfig.debug: drop GCC 5+ version check for
DWARF5") could have cleaned up the code a bit deeper.

"CC_IS_CLANG &&" is unneeded. No functional change is intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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

