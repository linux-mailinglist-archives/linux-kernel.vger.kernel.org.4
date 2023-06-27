Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81C273FC55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjF0NBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjF0NBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:01:38 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455A26BA;
        Tue, 27 Jun 2023 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687870895; bh=Gds07JdhXbkbt8/Vhe4lS60dTh4hWxzow1iLVsGOiF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzOF1JD38e5ptOv8EY2oRvZo6rAOenwsat1S8yfICrnQ8sowG1UxSDKRnZpJPSV9S
         jgqesWHPdoZTMdIarcEOYlBhufEP9yzxBfrbLwhltOsxKr5oMBw8aOOtmIqo8B/wC8
         Tm6SKa83zjepp0egjCSwm4XBQGtEleJt1fqBnYBc=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4DF19605CA;
        Tue, 27 Jun 2023 21:01:35 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Subject: [PATCH 2/2] LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
Date:   Tue, 27 Jun 2023 21:01:22 +0800
Message-Id: <20230627130122.1491765-3-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230627130122.1491765-1-kernel@xen0n.name>
References: <20230627130122.1491765-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

This is a port of commit 08f6554ff90e ("mips: Include KBUILD_CPPFLAGS
in CHECKFLAGS invocation") to arch/loongarch, for fixing
cross-compilation of Linux/LoongArch with Clang, where previously the
`--target` flag would no longer be present for the CHECKFLAGS cc
invocation leading to build failure.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1787#issuecomment-1608306002
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a63683da3bcf..09ba338a64de 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -112,7 +112,7 @@ KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
 KBUILD_LDFLAGS	+= -m $(ld-emul)
 
 ifdef CONFIG_LOONGARCH
-CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
-- 
2.40.0

