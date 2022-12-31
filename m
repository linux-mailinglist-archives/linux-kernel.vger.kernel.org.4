Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34C165A2FB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiLaGmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiLaGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:42:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F3DF42;
        Fri, 30 Dec 2022 22:42:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262A460684;
        Sat, 31 Dec 2022 06:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE19BC433EF;
        Sat, 31 Dec 2022 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672468946;
        bh=gnYVbwrikIqFSC/3hQA0CyfeKXskxX2NMICVYZNaQhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FySsNjORsocFCVs5MWPxbxZ/uUwAg1Ao0xxcSeEsF3GF26Nwp8FZovO1GLe1oRPYd
         tPKFUgmYCWIwCR0m2sSU72bZrdxdr/vbCj91BdLFTgz9gPe5bAwD8BI00gW1R/oySu
         j2sIYHF32rx0pujmkwACAMsaaXOwB/3cCFI8aX7DgiveDz9wvaBfzocZ/xZ/zylclf
         0kwNK9ASZdOjJmvutFLsR71ltsSGNm1lmsZF0rUhPLOIh5T2Ddyh/o/4LPa3/8EdVa
         A8EO8b+jAf2Bk0KGIKSERliCqbeH3gfFmPDuLwh6Mdmcfspne2wLX81bIkWwoBgT99
         KQymK2rgel9cQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/6] fixdep: refactor hash table lookup
Date:   Sat, 31 Dec 2022 15:42:01 +0900
Message-Id: <20221231064203.1623793-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221231064203.1623793-1-masahiroy@kernel.org>
References: <20221231064203.1623793-1-masahiroy@kernel.org>
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

Change the hash table code so it will be easier to add the second table.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/basic/fixdep.c | 47 ++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 37a40520686f..b20777b888d7 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -113,7 +113,7 @@ struct item {
 };
 
 #define HASHSZ 256
-static struct item *hashtab[HASHSZ];
+static struct item *config_hashtab[HASHSZ];
 
 static unsigned int strhash(const char *str, unsigned int sz)
 {
@@ -125,25 +125,11 @@ static unsigned int strhash(const char *str, unsigned int sz)
 	return hash;
 }
 
-/*
- * Lookup a value in the configuration string.
- */
-static int is_defined_config(const char *name, int len, unsigned int hash)
-{
-	struct item *aux;
-
-	for (aux = hashtab[hash % HASHSZ]; aux; aux = aux->next) {
-		if (aux->hash == hash && aux->len == len &&
-		    memcmp(aux->name, name, len) == 0)
-			return 1;
-	}
-	return 0;
-}
-
 /*
  * Add a new value to the configuration string.
  */
-static void define_config(const char *name, int len, unsigned int hash)
+static void add_to_hashtable(const char *name, int len, unsigned int hash,
+			     struct item *hashtab[])
 {
 	struct item *aux = malloc(sizeof(*aux) + len);
 
@@ -158,17 +144,34 @@ static void define_config(const char *name, int len, unsigned int hash)
 	hashtab[hash % HASHSZ] = aux;
 }
 
+/*
+ * Lookup a string in the hash table. If found, just return true.
+ * If not, add it to the hashtable and return false.
+ */
+static bool in_hashtable(const char *name, int len, struct item *hashtab[])
+{
+	struct item *aux;
+	unsigned int hash = strhash(name, len);
+
+	for (aux = hashtab[hash % HASHSZ]; aux; aux = aux->next) {
+		if (aux->hash == hash && aux->len == len &&
+		    memcmp(aux->name, name, len) == 0)
+			return true;
+	}
+
+	add_to_hashtable(name, len, hash, hashtab);
+
+	return false;
+}
+
 /*
  * Record the use of a CONFIG_* word.
  */
 static void use_config(const char *m, int slen)
 {
-	unsigned int hash = strhash(m, slen);
-
-	if (is_defined_config(m, slen, hash))
-	    return;
+	if (in_hashtable(m, slen, config_hashtab))
+		return;
 
-	define_config(m, slen, hash);
 	/* Print out a dependency path from a symbol name. */
 	printf("    $(wildcard include/config/%.*s) \\\n", slen, m);
 }
-- 
2.34.1

