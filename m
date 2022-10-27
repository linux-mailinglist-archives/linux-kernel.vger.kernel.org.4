Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93B860FD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiJ0Q24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiJ0Q2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188238442;
        Thu, 27 Oct 2022 09:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D36F623D0;
        Thu, 27 Oct 2022 16:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6FCC433C1;
        Thu, 27 Oct 2022 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666888132;
        bh=LtAbTc4oHjsc7CsB0RZFmCgJaDHyi66KNVvcsO+tF64=;
        h=From:To:Cc:Subject:Date:From;
        b=dFAXjWPhTBNepjo+WzLlzFG3D5UjZlHgWEEbarhq/a31lrVSDOT7ryrgHXUbXJAYd
         ixOMMJsbagIxDOsHrkWrmJXg26V/MJNmYpk+GANFjjh+9Ekf1tm5Oyu/e+K0uvlyqR
         fs34N4xpVjUTSIj0PuhbRSuHqPQFEOAFy27gVqNSRqCS/Jtkn2nhFGiidFq+Hps1JY
         wBnUFa8sJax9y68bCUHljiUk38r34azGZ2kPlyRVf8mI59mneAvPQtGnhwbm2J2GCa
         p/Fd7roSVzCf1w9i2To3dyO9im8SMh7+btZZLXQ8vvIy3UXmHr3ZRrDbNbfU5r21TV
         ILd4153NyQ/1g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2] kbuild: fix SIGPIPE error message for AR=gcc-ar and AR=llvm-ar
Date:   Fri, 28 Oct 2022 01:28:39 +0900
Message-Id: <20221027162839.410720-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby reported that building the kernel with AR=gcc-ar shows:
  /usr/bin/ar terminated with signal 13 [Broken pipe]

Nathan Chancellor reported the latest AR=llvm-ar shows
  error: write on a pipe with no reader

The latter occurs since LLVM commit 51b557adc131 ("Add an error message
to the default SIGPIPE handler").

The resulting vmlinux is correct, but it is better to silence it.

'head -n1' exits after reading the first line, so the pipe is closed.

Use 'sed -n 1p' to eat the stream till the end.

Fixes: 321648455061 ("kbuild: use obj-y instead extra-y for objects placed at the head")
Link: https://github.com/ClangBuiltLinux/linux/issues/1651
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2:
  - Update commit description to mention llvm-ar

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e90bb2b38607..e9e7eff906a5 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
       cmd_ar_vmlinux.a = \
 	rm -f $@; \
 	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
-	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
+	$(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
 
 targets += vmlinux.a
 vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
-- 
2.34.1

