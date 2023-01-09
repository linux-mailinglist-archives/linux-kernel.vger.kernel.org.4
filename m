Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D46635F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjAIX76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjAIX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:59:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB417042;
        Mon,  9 Jan 2023 15:59:54 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673308792;
        bh=tpnkczSX2FwWlmZTnCPhCbSJEIyoDbZvYiTjIxvF0jk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kN1d/2bOP/g/Sp+jL2FuaXmS542fD2wwbTdGM6v/CMAJspf/++H6sNafe0koB8rif
         XKO01Hh94u2KISkJKp2OKx7XkLGEfuog31tgdeydKGuj/UX9om0pjxiOHCUOxvdbdz
         mwQcQKs/AfcTEylR2GKr10C6IhgRBgIYrYciSJT4=
Date:   Mon, 09 Jan 2023 23:59:42 +0000
Subject: [PATCH RESEND v6 2/3] KEYS: Add new function key_create()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221212-keys-blacklist-v6-2-933267a80582@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673308789; l=7489;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tpnkczSX2FwWlmZTnCPhCbSJEIyoDbZvYiTjIxvF0jk=;
 b=B8UhbwBCWMsNObT0Eb5Ppp2q1hl9PRVWLVMjWU82TnY02qe0+hTRfSqanG3ePPjQjZOJ9TjsObEi
 x5dEVqgOCjLDOQ9r331JZLF9idgOsmN7hkVZ8URNosTdJJ+/YECh
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

key_create() works like key_create_or_update() but does not allow
updating an existing key, instead returning ERR_PTR(-EEXIST).

key_create() will be used by the blacklist keyring which should not
create duplicate entries or update existing entries.
Instead a dedicated message with appropriate severity will be logged.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/key.h |   8 +++
 security/keys/key.c | 137 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 108 insertions(+), 37 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index d27477faf00d..8dc7f7c3088b 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -386,6 +386,14 @@ extern int wait_for_key_construction(struct key *key, bool intr);
 
 extern int key_validate(const struct key *key);
 
+extern key_ref_t key_create(key_ref_t keyring,
+			    const char *type,
+			    const char *description,
+			    const void *payload,
+			    size_t plen,
+			    key_perm_t perm,
+			    unsigned long flags);
+
 extern key_ref_t key_create_or_update(key_ref_t keyring,
 				      const char *type,
 				      const char *description,
diff --git a/security/keys/key.c b/security/keys/key.c
index c45afdd1dfbb..5c0c7df833f8 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -788,38 +788,18 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
 	goto out;
 }
 
-/**
- * key_create_or_update - Update or create and instantiate a key.
- * @keyring_ref: A pointer to the destination keyring with possession flag.
- * @type: The type of key.
- * @description: The searchable description for the key.
- * @payload: The data to use to instantiate or update the key.
- * @plen: The length of @payload.
- * @perm: The permissions mask for a new key.
- * @flags: The quota flags for a new key.
- *
- * Search the destination keyring for a key of the same description and if one
- * is found, update it, otherwise create and instantiate a new one and create a
- * link to it from that keyring.
- *
- * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
- * concocted.
- *
- * Returns a pointer to the new key if successful, -ENODEV if the key type
- * wasn't available, -ENOTDIR if the keyring wasn't a keyring, -EACCES if the
- * caller isn't permitted to modify the keyring or the LSM did not permit
- * creation of the key.
- *
- * On success, the possession flag from the keyring ref will be tacked on to
- * the key ref before it is returned.
+/*
+ * Create or potentially update a key. The combined logic behind
+ * key_create_or_update() and key_create()
  */
-key_ref_t key_create_or_update(key_ref_t keyring_ref,
-			       const char *type,
-			       const char *description,
-			       const void *payload,
-			       size_t plen,
-			       key_perm_t perm,
-			       unsigned long flags)
+static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
+					const char *type,
+					const char *description,
+					const void *payload,
+					size_t plen,
+					key_perm_t perm,
+					unsigned long flags,
+					bool allow_update)
 {
 	struct keyring_index_key index_key = {
 		.description	= description,
@@ -906,14 +886,23 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
-	/* if it's possible to update this type of key, search for an existing
-	 * key of the same type and description in the destination keyring and
-	 * update that instead if possible
+	/* if it's requested and possible to update this type of key, search
+	 * for an existing key of the same type and description in the
+	 * destination keyring and update that instead if possible
 	 */
-	if (index_key.type->update) {
+	if (allow_update) {
+		if (index_key.type->update) {
+			key_ref = find_key_to_update(keyring_ref, &index_key);
+			if (key_ref)
+				goto found_matching_key;
+		}
+	} else {
 		key_ref = find_key_to_update(keyring_ref, &index_key);
-		if (key_ref)
-			goto found_matching_key;
+		if (key_ref) {
+			key_ref_put(key_ref);
+			key_ref = ERR_PTR(-EEXIST);
+			goto error_link_end;
+		}
 	}
 
 	/* if the client doesn't provide, decide on the permissions we want */
@@ -985,8 +974,82 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 
 	goto error_free_prep;
 }
+
+/**
+ * key_create_or_update - Update or create and instantiate a key.
+ * @keyring_ref: A pointer to the destination keyring with possession flag.
+ * @type: The type of key.
+ * @description: The searchable description for the key.
+ * @payload: The data to use to instantiate or update the key.
+ * @plen: The length of @payload.
+ * @perm: The permissions mask for a new key.
+ * @flags: The quota flags for a new key.
+ *
+ * Search the destination keyring for a key of the same description and if one
+ * is found, update it, otherwise create and instantiate a new one and create a
+ * link to it from that keyring.
+ *
+ * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
+ * concocted.
+ *
+ * Returns a pointer to the new key if successful, -ENODEV if the key type
+ * wasn't available, -ENOTDIR if the keyring wasn't a keyring, -EACCES if the
+ * caller isn't permitted to modify the keyring or the LSM did not permit
+ * creation of the key.
+ *
+ * On success, the possession flag from the keyring ref will be tacked on to
+ * the key ref before it is returned.
+ */
+key_ref_t key_create_or_update(key_ref_t keyring_ref,
+			       const char *type,
+			       const char *description,
+			       const void *payload,
+			       size_t plen,
+			       key_perm_t perm,
+			       unsigned long flags)
+{
+	return __key_create_or_update(keyring_ref, type, description, payload,
+				      plen, perm, flags, true);
+}
 EXPORT_SYMBOL(key_create_or_update);
 
+/**
+ * key_create - Create and instantiate a key.
+ * @keyring_ref: A pointer to the destination keyring with possession flag.
+ * @type: The type of key.
+ * @description: The searchable description for the key.
+ * @payload: The data to use to instantiate or update the key.
+ * @plen: The length of @payload.
+ * @perm: The permissions mask for a new key.
+ * @flags: The quota flags for a new key.
+ *
+ * Create and instantiate a new key and link to it from the destination keyring.
+ *
+ * If perm is KEY_PERM_UNDEF then an appropriate key permissions mask will be
+ * concocted.
+ *
+ * Returns a pointer to the new key if successful, -EEXIST if a key with the
+ * same description already exists, -ENODEV if the key type wasn't available,
+ * -ENOTDIR if the keyring wasn't a keyring, -EACCES if the caller isn't
+ * permitted to modify the keyring or the LSM did not permit creation of the
+ * key.
+ *
+ * On success, the possession flag from the keyring ref will be tacked on to
+ * the key ref before it is returned.
+ */
+key_ref_t key_create(key_ref_t keyring_ref,
+		     const char *type,
+		     const char *description,
+		     const void *payload,
+		     size_t plen,
+		     key_perm_t perm,
+		     unsigned long flags)
+{
+	return __key_create_or_update(keyring_ref, type, description, payload,
+				      plen, perm, flags, false);
+}
+EXPORT_SYMBOL(key_create);
+
 /**
  * key_update - Update a key's contents.
  * @key_ref: The pointer (plus possession flag) to the key.

-- 
2.39.0

