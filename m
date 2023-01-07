Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2F660D36
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAGJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjAGJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:18:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A3387F21;
        Sat,  7 Jan 2023 01:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD2FD606A0;
        Sat,  7 Jan 2023 09:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12214C433F2;
        Sat,  7 Jan 2023 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083125;
        bh=KHt1EK26ZGiCZ+hM8+UAROr2DkypHQCMEzGlrsxrzJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USGRmCPjYNX6ogQJTnr+bdgvTdiqwjDgydRFPehzZrcxPQrTVeokqOwv+Avf4WktR
         vFW8sKGqXKrXZaGi++fWsdr7nsu84MdtzoXbGZKylLXPVT9HiDTLo44c86Q7q6zpz2
         DpvYAaUDsYSV92YSHwQL095ySj2XQWIRlYhJAwB/tF8Z4uLSW4L3hbbCEVay8AYaao
         Dol9xUemVNxo70aRvkzGDds2LpbWIVOVH4+4cpHyK5wIq9DNO1MDdH1zsogel1m4IJ
         xzipdFimzMgUqb42WFYasicdrmUxqYOpwSDDh2JrWUxKUjIe/A9X4rC2+k7WXwXoYb
         eYSWNNye95KgA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 5/7] fixdep: refactor hash table lookup
Date:   Sat,  7 Jan 2023 18:18:18 +0900
Message-Id: <20230107091820.3382134-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107091820.3382134-1-masahiroy@kernel.org>
References: <20230107091820.3382134-1-masahiroy@kernel.org>
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
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
---

(no changes since v1)

 scripts/basic/fixdep.c | 47 ++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index f5a51770eb74..74f90a0deeb9 100644
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

