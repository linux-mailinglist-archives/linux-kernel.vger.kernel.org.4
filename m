Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC85F2485
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJBSMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJBSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:12:28 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F4334986;
        Sun,  2 Oct 2022 11:12:26 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 292IBAaD004037;
        Mon, 3 Oct 2022 03:11:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 292IBAaD004037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664734272;
        bh=R4t/6fMIwaYlwYPM6wHfjnpUbzkfUGo1Wg0yhRD/I3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtDj4kjXQHcvkPNqLOciJfgK9o2uMkx7+e6I20+8vFD1PFvteJhpRTtbcT9BWNlB3
         vdrxJnK+my43MGIlWax/+JmVCW24W0dojt7fIadApe4vL/MMUsSxsNOKlAJfVkBERw
         fpaxX49lk2zK+SCWezNUM7piUTxMTKvgMg9UfpXS31o8zI9EVQqpnXySyhGU7jWfI7
         VhqEuN3j+pTiGqaYjppTUR6pn6RCx4PZ4Omi0eNZioAX6P8vQM7+OJeFyvL8JiEbKV
         0K0oShESbv1vSjvPK6+OqEOsMfqrNScicc7odv8y75mpRSXN6v+FyqCiHcSFtPORz7
         rRLYn0fzGj7JA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH 2/3] Kconfig.debug: add toolchain checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
Date:   Mon,  3 Oct 2022 03:11:06 +0900
Message-Id: <20221002181107.51286-3-masahiroy@kernel.org>
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

CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT passes the -g option to the
command line. The actual DWARF version is up to the toolchain.

The combination of GCC and GAS works fine, and Clang with the integrated
assembler is good too.

The combination of Clang and GAS is a bit tricky, but at least, the
default -g flag worked until LLVM 14 was released because Clang <=13
defaults to DWARF v4.

Clang 14 switched to DWARF v5 by default.

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
---

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

