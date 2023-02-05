Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76668ADEF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBEB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBEB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:29:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6961F5FB;
        Sat,  4 Feb 2023 17:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vflI9QwxBWvZUVUitWFOOTwfrc8FmqkBpNvFhbTy3aU=; b=FcNFdk3ZJH/W6wi1X0ZNt1obkg
        Jmf3BmHQf2x1AoE+y6D2XZZ8ivKUPSOA5X1yiUfTKNoRsd3Jiw3Pu4zrbpHHXBHg50rR7m3tvv1Y8
        mfI0uHFVKrfaZB1sec/E2/EMXJjfXzxjz2xkIAADlB9xTeYuG6aIXRdaxgDsC1NDlIPqd/g+qD+xH
        6X9HgXK1lS48TLc6CjqyLczh8RfNB+3cTtivBbFsSi59BLFwxLZifW/vprUWZ9eCSP2cPDppuAHz6
        pgsxfZpe46c2vZ9/tXGcjXRtkFIr1ciU3VPJC9EFNB41b0/aXjYSJ09PU7X5QEDsxL6KrQXEEYW0b
        GZqJ2qGA==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOTqH-005orr-0P; Sun, 05 Feb 2023 01:29:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] sparc: allow sparc32 alias for archhelp
Date:   Sat,  4 Feb 2023 17:29:15 -0800
Message-Id: <20230205012915.11330-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, entering
$ make ARCH=sparc32 help
prints the archhelp text for sparc64.

Since "sparc32" is documented (Documentation/kbuild/kbuild.rst)
to be a recognized alias for 32-bit sparc, also support that
string in sparc's archhelp by allowing either ARCH=sparc or
ARCH=sparc32 for sparc32 archhelp.

Fixes: 5e53879008b9 ("sparc,sparc64: unify Makefile")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/sparc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -83,7 +83,7 @@ vdso_install:
 KBUILD_IMAGE := $(boot)/zImage
 
 # Don't use tabs in echo arguments.
-ifeq ($(ARCH),sparc)
+ifeq ($(ARCH),$(filter $(ARCH),sparc sparc32))
 define archhelp
   echo  '* image        - kernel image ($(boot)/image)'
   echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
