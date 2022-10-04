Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3564C5F4799
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJDQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJDQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:30:30 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAB52FC8;
        Tue,  4 Oct 2022 09:30:28 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 294GT79k026312;
        Wed, 5 Oct 2022 01:29:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 294GT79k026312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664900948;
        bh=kc+1YRa8tio6pppjoCDOR/OHC5rXxnfGtOcgJlT+i9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ww40hvqXP1ONH1ClJh7gq2cNp5BryD4EN8NKkqHC+o6g4UKZxDZurxsBDi2esa3/B
         nkDx98mpAde43X6bItjHjGm817ezf6O1uTwPOZANBhGV+SmvokcC5MoNOvF/IC8PfT
         2e20J8Y8Dkbkbf9dGO0Ybmz/yT5CDN6ct7K9GCW6B4Lpn+bAzkVFEB0bbKN/hqR2MH
         4FH1nMiArI6D6TNnGeniGP35eBHpYOQe4Pxi0bFhO3sKdc9xQYF88j6Fqawg4yvIYv
         nRwl9tPaxG5K9FgsmNZw/EuBXChxxAyQNoL1aOXnYb9zXdwSxBkVYZUn9R2T9npf1V
         +FoVdos8EZ83Q==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/3] Kconfig.debug: add toolchain checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
Date:   Wed,  5 Oct 2022 01:29:04 +0900
Message-Id: <20221004162905.24997-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004162905.24997-1-masahiroy@kernel.org>
References: <20221004162905.24997-1-masahiroy@kernel.org>
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

CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT does not give explicit
-gdwarf-* flag. The actual DWARF version is up to the toolchain.

The combination of GCC and GAS works fine, and Clang with the integrated
assembler is good too.

The combination of Clang and GAS is tricky, but at least, the -g flag
works for Clang <=13, which defaults to DWARF v4.

Clang 14 switched its default to DWARF v5.

Now, CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT has the same issue as
addressed by commit 98cd6f521f10 ("Kconfig: allow explicit opt in to
DWARF v5").

CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y for Clang >= 14 and
GAS < 2.35 produces a ton of errors like follows:

  /tmp/main-c2741c.s: Assembler messages:
  /tmp/main-c2741c.s:109: Error: junk at end of line, first unrecognized character is `"'
  /tmp/main-c2741c.s:109: Error: file number less than one

Add 'depends on' to check toolchains.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v1)

 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f4b2165f24db..cc90414d492e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -253,6 +253,7 @@ config DEBUG_INFO_NONE
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
 	select DEBUG_INFO
+	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  The implicit default version of DWARF debug info produced by a
 	  toolchain changes over time.
-- 
2.34.1

