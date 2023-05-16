Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6537058DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjEPU3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEPU3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8160E97;
        Tue, 16 May 2023 13:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16FE461B95;
        Tue, 16 May 2023 20:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DE4C433EF;
        Tue, 16 May 2023 20:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268940;
        bh=EDUXvpFm3oqJxXTKWuHtRcqYUh4Z5+wpsxniEd1SNNM=;
        h=From:To:Cc:Subject:Date:From;
        b=u6M22LySijck3w31eghLndGmrhlfpYacS+co8kUi9aEqP1Lig1QlZcwlbNKLsVCL3
         4jgjt7WtoZ2pcROHtcznqo7Z/oMVF7lp5azJZcaMKC2rNWejeLgRNbLetz58qr/x04
         /sBcoCNP5mTZ6JLpzDptnHu66pxK04FZZPAvIkgMVntvrAaGp/aBTQiVcwSQqkkLzv
         rPuV+SDbHs7qVPmEyqKu7e8mGjQ+yAgtabPuSuFWLq6l1d60AUb+LR7F/aHxGoVtPi
         8MyZy7Zyk32rrLnIlMHfqIn/cSc91eU00svjwLYRoOddp6mSTRWDYqJPfX/yK1wONE
         QWU1fiCe+87gw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: aegis: add header for internal prototypes
Date:   Tue, 16 May 2023 22:28:48 +0200
Message-Id: <20230516202855.561496-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns if prototypes are only visible to the caller but
not the callee:

crypto/aegis128-neon-inner.c:134:6: warning: no previous prototype for 'crypto_aegis128_init_neon' [-Wmissing-prototypes]
crypto/aegis128-neon-inner.c:164:6: warning: no previous prototype for 'crypto_aegis128_update_neon' [-Wmissing-prototypes]
crypto/aegis128-neon-inner.c:221:6: warning: no previous prototype for 'crypto_aegis128_encrypt_chunk_neon' [-Wmissing-prototypes]
crypto/aegis128-neon-inner.c:270:6: warning: no previous prototype for 'crypto_aegis128_decrypt_chunk_neon' [-Wmissing-prototypes]
crypto/aegis128-neon-inner.c:316:5: warning: no previous prototype for 'crypto_aegis128_final_neon' [-Wmissing-prototypes]

The prototypes cannot be in the regular aegis.h, as the inner neon code
cannot include normal kernel headers. Instead add a new header just for
the functions provided by this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/aegis-neon.h          | 17 +++++++++++++++++
 crypto/aegis128-neon-inner.c |  1 +
 crypto/aegis128-neon.c       | 12 +-----------
 3 files changed, 19 insertions(+), 11 deletions(-)
 create mode 100644 crypto/aegis-neon.h

diff --git a/crypto/aegis-neon.h b/crypto/aegis-neon.h
new file mode 100644
index 000000000000..61e5614b45de
--- /dev/null
+++ b/crypto/aegis-neon.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef _AEGIS_NEON_H
+#define _AEGIS_NEON_H
+
+void crypto_aegis128_init_neon(void *state, const void *key, const void *iv);
+void crypto_aegis128_update_neon(void *state, const void *msg);
+void crypto_aegis128_encrypt_chunk_neon(void *state, void *dst, const void *src,
+					unsigned int size);
+void crypto_aegis128_decrypt_chunk_neon(void *state, void *dst, const void *src,
+					unsigned int size);
+int crypto_aegis128_final_neon(void *state, void *tag_xor,
+			       unsigned int assoclen,
+			       unsigned int cryptlen,
+			       unsigned int authsize);
+
+#endif
diff --git a/crypto/aegis128-neon-inner.c b/crypto/aegis128-neon-inner.c
index 7de485907d81..b6a52a386b22 100644
--- a/crypto/aegis128-neon-inner.c
+++ b/crypto/aegis128-neon-inner.c
@@ -16,6 +16,7 @@
 #define AEGIS_BLOCK_SIZE	16
 
 #include <stddef.h>
+#include "aegis-neon.h"
 
 extern int aegis128_have_aes_insn;
 
diff --git a/crypto/aegis128-neon.c b/crypto/aegis128-neon.c
index a7856915ec85..9ee50549e823 100644
--- a/crypto/aegis128-neon.c
+++ b/crypto/aegis128-neon.c
@@ -7,17 +7,7 @@
 #include <asm/neon.h>
 
 #include "aegis.h"
-
-void crypto_aegis128_init_neon(void *state, const void *key, const void *iv);
-void crypto_aegis128_update_neon(void *state, const void *msg);
-void crypto_aegis128_encrypt_chunk_neon(void *state, void *dst, const void *src,
-					unsigned int size);
-void crypto_aegis128_decrypt_chunk_neon(void *state, void *dst, const void *src,
-					unsigned int size);
-int crypto_aegis128_final_neon(void *state, void *tag_xor,
-			       unsigned int assoclen,
-			       unsigned int cryptlen,
-			       unsigned int authsize);
+#include "aegis-neon.h"
 
 int aegis128_have_aes_insn __ro_after_init;
 
-- 
2.39.2

