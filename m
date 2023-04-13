Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEDF6E1600
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDMUjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:39:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313FB7ED6;
        Thu, 13 Apr 2023 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XWU1TSQ6EOSCyHR4PqujH3tZSHPeiwOeWBbnCTQsrgk=; b=NT8RHiLOa3gIdeqzNXIMLjWqQ8
        6wsa1JmK7i4y2HoC+OnEu3zAu1FiAq5V5tp1e+Soj5ZMG4v+GxtZygekxp7HC1cYl6sOPHGxHaPmX
        FwWBLVjJb+SPXKjCKTNb++EBk2VaAiObeTDtXgCz+AxK8Z+8lQqw8/vVTXqOuyfiZ2nqjl+4JYa/F
        55cP0/gn0n9bsKJ7VCTt1wvnx7sIDYpjMqp6Oxo5juwL1evFXOo+avLv17qFpZnCBjdaNYmkGZ/gh
        xhvPSPAeOWB+8j2H5wZTbCimdRLq0GqlrtuvfvaJZzJSOBkfk/1wifqnBothFbKBATPQ+3gfQLXGB
        LksbYtbw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pn3ie-0076lX-1d;
        Thu, 13 Apr 2023 20:39:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3] sparc: unify sparc32/sparc64 archhelp
Date:   Thu, 13 Apr 2023 13:38:57 -0700
Message-Id: <20230413203857.2629-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, entering
$ make ARCH=sparc32 help
prints the archhelp text for sparc64.
["sparc32" is documented (Documentation/kbuild/kbuild.rst)
to be a recognized alias for 32-bit sparc.]

Instead of handling ARCH=sparc or ARCH=sparc32 or ARCH=sparc64,
just unify all SPARC archhelp text in one place.

Fixes: 5e53879008b9 ("sparc,sparc64: unify Makefile")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
---
v2: rebase/resend; add Masahiro to Cc: list
v3: merge (unify) 32/64-bit help text (Masahiro);
    remove Sam's Ack since the patch has changed;

 arch/sparc/Makefile |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff -- a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -83,18 +83,11 @@ vdso_install:
 KBUILD_IMAGE := $(boot)/zImage
 
 # Don't use tabs in echo arguments.
-ifeq ($(ARCH),sparc)
 define archhelp
-  echo  '* image        - kernel image ($(boot)/image)'
-  echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
+  echo  '  vmlinux      - standard SPARC kernel'
+  echo  '  image        - kernel image ($(boot)/image)'
+  echo  '* zImage       - stripped/compressed kernel image ($(boot)/zImage)'
   echo  '  uImage       - U-Boot SPARC32 Image (only for LEON)'
+  echo  '  vmlinux.aout - a.out kernel for SPARC64'
   echo  '  tftpboot.img - image prepared for tftp'
 endef
-else
-define archhelp
-  echo  '* vmlinux      - standard sparc64 kernel'
-  echo  '* zImage       - stripped and compressed sparc64 kernel ($(boot)/zImage)'
-  echo  '  vmlinux.aout - a.out kernel for sparc64'
-  echo  '  tftpboot.img - image prepared for tftp'
-endef
-endif
