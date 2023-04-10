Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301856DC245
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDJBN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDJBN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:13:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1335A7;
        Sun,  9 Apr 2023 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cg1S3XoU3SPVIhEQjqsExfl3vAbSc03YUdI51frBIwo=; b=ihxSGen1Mdtj9zPUVP70jaRoFS
        jMkwJJ0+UbW1zpkqIlDrT69e58N0usHXr1ZvlWsqdl6eWt1EMfTYMQoi4Lzg+ki0TwsQhuafFw5rV
        E6LPC8k8x4r8p/UhokWeUrWFZ8mKnkg7kyH+pRsakwcyYw84cpecFtcrYeGoon/neG0UppLClZiat
        9TgmC11sJRG0itlxR27r2vwQPrEGmrxUY0s44flobNfleMtRncFY1OlWacepG1SYX4ao9xst9+xot
        2OprWMTPDaqaunoJcEV9Xkon1Pp0YIYzx8hZcIx+HqaO8HaaJ1Y0JInURGhNrIAEZ8AIHa4Os0W3f
        5moEquOw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1plg5t-00EPci-1A;
        Mon, 10 Apr 2023 01:13:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] sparc: allow sparc32 alias for archhelp
Date:   Sun,  9 Apr 2023 18:13:16 -0700
Message-Id: <20230410011316.26564-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
---
v2: rebase/resend; add Masahiro to Cc: list

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
