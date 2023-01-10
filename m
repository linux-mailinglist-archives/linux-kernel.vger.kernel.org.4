Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5E6638C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjAJFtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjAJFsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:48:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB838A8;
        Mon,  9 Jan 2023 21:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2F91B810DE;
        Tue, 10 Jan 2023 05:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759FEC433D2;
        Tue, 10 Jan 2023 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673329686;
        bh=nh3EWSCCitnBGOQVAZHJqaOMs4DihgLx+dinQpstJ0E=;
        h=From:To:Cc:Subject:Date:From;
        b=ZvACUF2HQ3vZizwMPza0mB1Nf5A3PTprZulYA07FyGLPP2jtepUGpWkMXfJjUSjmS
         fbHHgtfut+mzFKAoNAFybRRs1kqJ7CDdSNdJXRDBuRs8v4yznUmfbvcPispDcZHbpM
         XrY3uYwF5u/ZpRxYIcYpZrGIz2P/C1p9c9bVbVMaoPmZo6Go1JHKCHqeA26tXGS58a
         dLsZmWrMOl2YJq8x3vl0II0/yMsUxbT1MjNFed3Ym8vuf5sabUzQ/cnqDNoTJwQMBx
         mfDE8XaV9hgE1MTu2NjS7ojth9Sc10a54Ce7R2eEt74iICd0JdSDfYgBiOU0WgwQet
         QCkRjPXA4Iy2Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: fix 'make modules' error when CONFIG_DEBUG_INFO_BTF_MODULES=y
Date:   Tue, 10 Jan 2023 14:48:00 +0900
Message-Id: <20230110054800.119222-1-masahiroy@kernel.org>
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

When CONFIG_DEBUG_INFO_BTF_MODULES=y, running 'make modules'
in the clean kernel tree will get the following error.

  $ grep CONFIG_DEBUG_INFO_BTF_MODULES .config
  CONFIG_DEBUG_INFO_BTF_MODULES=y
  $ make -s clean
  $ make modules
    [snip]
    AR      vmlinux.a
  ar: ./built-in.a: No such file or directory
  make: *** [Makefile:1241: vmlinux.a] Error 1

'modules' depends on 'vmlinux', but builtin objects are not built.

Define KBUILD_BUILTIN.

Fixes: f73edc8951b2 ("kbuild: unify two modpost invocations")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 760640162db6..2ee3ab599477 100644
--- a/Makefile
+++ b/Makefile
@@ -1525,6 +1525,7 @@ endif
 # *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFOBTF_MODULES
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+KBUILD_BUILTIN := 1
 modules: vmlinux
 endif
 
-- 
2.34.1

