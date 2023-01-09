Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B16635F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjAJAAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjAIX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:59:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3A1D0FC;
        Mon,  9 Jan 2023 15:59:55 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673308792;
        bh=XbsyBGwFNX/+AhMDtn4NosVJq1CKEYv0BSyy10RgWi8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JGTxi12A9Q1nheqVStkHBKWzMEVW5z1qpY2qLGO9WHdBjI1WjHsUXawmS/cqTUAJj
         sVTTiEumgxwmWhWQIVdoGJxINu79EBLWDNLPiq/IH60IS/KvD65sb7andhXJkQJ7ti
         SzJUtSQ5OZg4S7vRQ4RbExw+/jjLFYwA7qC/y6dg=
Date:   Mon, 09 Jan 2023 23:59:43 +0000
Subject: [PATCH RESEND v6 3/3] certs: don't try to update blacklist keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221212-keys-blacklist-v6-3-933267a80582@weissschuh.net>
References: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
In-Reply-To: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Mark Pearson <markpearson@lenovo.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12-dev-3dd91
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673308789; l=1743;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XbsyBGwFNX/+AhMDtn4NosVJq1CKEYv0BSyy10RgWi8=;
 b=m22y9R8oSOW93S3ubz+AnnJoxZ9hUwAVd6c+F34GIiRUf5++/uFiiniR7WAkiS2gpmI1wx9XxO77
 HypSBqAlAj56LRUxNTvo5JiRklFZoOhzbOwoxmmJ3ckeThurk1TJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the same key is blacklisted repeatedly logging at pr_err() level is
excessive as no functionality is impaired.
When these duplicates are provided by buggy firmware there is nothing
the user can do to fix the situation.
Instead of spamming the bootlog with errors we use a warning that can
still be seen by OEMs when testing their firmware.

Link: https://lore.kernel.org/all/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/
Link: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 certs/blacklist.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6e260c4b6a19..675dd7a8f07a 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -183,16 +183,19 @@ static int mark_raw_hash_blacklisted(const char *hash)
 {
 	key_ref_t key;
 
-	key = key_create_or_update(make_key_ref(blacklist_keyring, true),
-				   "blacklist",
-				   hash,
-				   NULL,
-				   0,
-				   BLACKLIST_KEY_PERM,
-				   KEY_ALLOC_NOT_IN_QUOTA |
-				   KEY_ALLOC_BUILT_IN);
+	key = key_create(make_key_ref(blacklist_keyring, true),
+			 "blacklist",
+			 hash,
+			 NULL,
+			 0,
+			 BLACKLIST_KEY_PERM,
+			 KEY_ALLOC_NOT_IN_QUOTA |
+			 KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
-		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
+		if (PTR_ERR(key) == -EEXIST)
+			pr_warn("Duplicate blacklisted hash %s\n", hash);
+		else
+			pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
 		return PTR_ERR(key);
 	}
 	return 0;

-- 
2.39.0

