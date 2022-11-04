Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F052618DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKDBr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:47:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72384233AB;
        Thu,  3 Nov 2022 18:47:25 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667526441;
        bh=zA6BOM4Lon4YmACr2oprtmCrkYDcna5kP8A9nDzjIyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Rti15vTqHTmnoxSOumHx9nR+wOhVCzHGsJIGz/GjeEvqALRluQ4JmqaFTXSR9/ZsO
         3Wgf3vdUZBQe9fpW+3MtGDX6/yarLXYRxp4YHXHnQ05fMtpqMwKoPt8eSdrMdvwUiQ
         Oi/xQpDov5sB+8j+Hp15a3fPfUhB5X52ZKdxs920=
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Date:   Fri,  4 Nov 2022 02:47:04 +0100
Message-Id: <20221104014704.3469-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1667526395; l=1345; s=20211113; h=from:subject; bh=zA6BOM4Lon4YmACr2oprtmCrkYDcna5kP8A9nDzjIyQ=; b=klhYPd0ukYGk28HhUv7Q+VCjWvIYNkiMK7eI+uQbQZQrX6nT9RAW7Usn0s9WXbbblQ8jFYeFg58y 3tOqsWOzDZ96hlDb8JcaHzxd+HDEHfWnSNhGJxtB3pcyTuA8wN5K
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the blacklist keyring was changed to allow updates from the root
user it gained an ->update() function that disallows all updates.
When the a hash is blacklisted multiple times from the builtin or
firmware-provided blacklist this spams prominent logs during boot:

[    0.890814] blacklist: Problem blacklisting hash (-13)

As all these repeated calls to mark_raw_hash_blacklisted() would create
the same keyring entry again anyways these errors can be safely ignored.

Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 certs/blacklist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 41f10601cc72..5f7f2882ced7 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -191,7 +191,9 @@ static int mark_raw_hash_blacklisted(const char *hash)
 				   BLACKLIST_KEY_PERM,
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
-	if (IS_ERR(key)) {
+
+	/* Blacklisting the same hash twice fails but would be idempotent */
+	if (IS_ERR(key) && PTR_ERR(key) != -EACCES) {
 		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
 		return PTR_ERR(key);
 	}

base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
-- 
2.38.1

