Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330170A2D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjESWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:33:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB891BD;
        Fri, 19 May 2023 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dzkMn7jXhuW46G6N54fI9VSxhbfWQPb9eBen4fnyZMM=; b=oW7jKK9dD+JkZYQopHTtoZLdIf
        ifss5k+Ba6BO4/frKHPmNl85tmAk4YqdDhEOMgQznNFvPHj5/8/7esRY7q4PBd2yDceO38esCsptk
        Hq66dDEhvIakalnxaiNTw0uhYSLcrjsoO+8pcOYB6ic0Pzvfct4mOPU4Fs916n/IYmA30U+ogqdKC
        yyZ86xBRVgHWTutdUkAzx0MTyB4ufBlb6QyDazHWnSuWZKR+NI4MnedIgreM7ElDZCoFkAHpT8E+h
        lXzE29T9kkNXQpIzwfctQr8e82xBxy8b2XtqO3hwfpn8R1JkxyPdWbjWfegu8O45gKn5tmEUGa+er
        LkAS18Tg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q08fJ-00HShm-0H;
        Fri, 19 May 2023 22:33:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/crypto: fix build warnings when DEBUG_FS is not enabled
Date:   Fri, 19 May 2023 15:33:34 -0700
Message-Id: <20230519223334.11992-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warnings when DEBUG_FS is not enabled by using an empty
do-while loop instead of a value:

In file included from ../drivers/crypto/nx/nx.c:27:
../drivers/crypto/nx/nx.c: In function 'nx_register_algs':
../drivers/crypto/nx/nx.h:173:33: warning: statement with no effect [-Wunused-value]
  173 | #define NX_DEBUGFS_INIT(drv)    (0)
../drivers/crypto/nx/nx.c:573:9: note: in expansion of macro 'NX_DEBUGFS_INIT'
  573 |         NX_DEBUGFS_INIT(&nx_driver);
../drivers/crypto/nx/nx.c: In function 'nx_remove':
../drivers/crypto/nx/nx.h:174:33: warning: statement with no effect [-Wunused-value]
  174 | #define NX_DEBUGFS_FINI(drv)    (0)
../drivers/crypto/nx/nx.c:793:17: note: in expansion of macro 'NX_DEBUGFS_FINI'
  793 |                 NX_DEBUGFS_FINI(&nx_driver);

Also, there is no need to build nx_debugfs.o when DEBUG_FS is not
enabled, so change the Makefile to accommodate that.

Fixes: ae0222b7289d ("powerpc/crypto: nx driver code supporting nx encryption")
Fixes: aef7b31c8833 ("powerpc/crypto: Build files for the nx device driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Breno Leitão <leitao@debian.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/crypto/nx/Makefile |    2 +-
 drivers/crypto/nx/nx.h     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
--- a/drivers/crypto/nx/Makefile
+++ b/drivers/crypto/nx/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_NX_ENCRYPT) += nx-crypto.o
 nx-crypto-objs := nx.o \
-		  nx_debugfs.o \
 		  nx-aes-cbc.o \
 		  nx-aes-ecb.o \
 		  nx-aes-gcm.o \
@@ -11,6 +10,7 @@ nx-crypto-objs := nx.o \
 		  nx-sha256.o \
 		  nx-sha512.o
 
+nx-crypto-$(CONFIG_DEBUG_FS) += nx_debugfs.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES) += nx-compress-pseries.o nx-compress.o
 obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV) += nx-compress-powernv.o nx-compress.o
 nx-compress-objs := nx-842.o
diff -- a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -170,8 +170,8 @@ struct nx_sg *nx_walk_and_build(struct n
 void nx_debugfs_init(struct nx_crypto_driver *);
 void nx_debugfs_fini(struct nx_crypto_driver *);
 #else
-#define NX_DEBUGFS_INIT(drv)	(0)
-#define NX_DEBUGFS_FINI(drv)	(0)
+#define NX_DEBUGFS_INIT(drv)	do {} while (0)
+#define NX_DEBUGFS_FINI(drv)	do {} while (0)
 #endif
 
 #define NX_PAGE_NUM(x)		((u64)(x) & 0xfffffffffffff000ULL)
