Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFA601790
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiJQT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJQT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC0D349BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:26:12 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id q11so6346252ilj.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ywemWSzQEgLrmQuacaw5iRk/lkUQNsP9/rTACBO8Ro=;
        b=tJuH9MREbL0WBc5Okym6gAwEHDfARdsJPRE76iRKgsdg9/Xhk0Zec2zv91T8M0zF+8
         xY6XSWU2nYQRPJRiDEfIhxuJxpSMJkkYnI52PHLmlRwkbeGKzlxeVuuA4jTpQ91ZYQF+
         YN2JcIpOtU+z+s6aFd3VzdNciwH0GXpvKP3JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ywemWSzQEgLrmQuacaw5iRk/lkUQNsP9/rTACBO8Ro=;
        b=oy7wPNUnPx6mBTJNxNJyCyD8CqUqg0P5fc5wyHRsxWFaPPELf1w3kGHmddo7I5XUmw
         tlDAF1UT/Pb3Qr9+VoaaYToGJT61JkuTVcKaHDb775ArjwviH+inOw4ilfBv90X3A4XW
         JABP/Dl4raz8YoNhIIdXNQEw6halo976JWhTrwaJZX06Fx8zpX7LeXYHF5NroNUm5tdP
         sSUqRzc0iwik+hj1mMsA38p4HGJhq5tF5ZuX2zWWefmK6u25BKVZY/HDiwORiJHvK2XI
         jXVooFHhshVitBGtsbvwGeDtZ7kLeulzA5Aomis64+0sbQ9KRahuHXYp3nxVEQkda8bT
         g/eA==
X-Gm-Message-State: ACrzQf2HkBhykJUSLJabs/cjq44EWkG7nMD7GfoHw9oinE9O5cKk2Dz5
        9aLH0Mn9pYHIAdqQklUAPw7HZQ==
X-Google-Smtp-Source: AMsMyM6gJM0Qi+feH4k+oirnrB1XyS1UdO50vly9sZo+MtUPRXPCsk91hkvQ0ulplQNHc129lTCrDw==
X-Received: by 2002:a05:6e02:15c9:b0:2e1:a5b6:7e25 with SMTP id q9-20020a056e0215c900b002e1a5b67e25mr5268688ilu.185.1666034709141;
        Mon, 17 Oct 2022 12:25:09 -0700 (PDT)
Received: from localhost.localdomain ([172.58.84.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a92cf01000000b002fc681a6ad8sm195344ilo.78.2022.10.17.12.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:25:08 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, hch@lst.de, smueller@chronox.de
Cc:     dhowells@redhat.com, omosnace@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH 1/1] crypto: af_alg - Support symmetric encryption via keyring keys
Date:   Mon, 17 Oct 2022 14:25:00 -0500
Message-Id: <20221017192500.485962-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to leverage keyring to store sensitive keys, and then use those
keys for symmetric encryption via the crypto API. Among the key types we
wish to support are: user, logon, encrypted, and trusted.

User key types are already able to have their data copied to user space,
but logon does not support this. Further, trusted and encrypted keys will
return their encrypted data back to user space on read, which does not
make them ideal for symmetric encryption.

To support symmetric encryption for these key types, add a new
ALG_SET_KEY_BY_KEY_SERIAL setsockopt() option to the crypto API. This
allows users to pass a key_serial_t to the crypto API to perform
symmetric encryption. The behavior is the same as ALG_SET_KEY, but
the crypto key data is copied in kernel space from a keyring key,
which allows for the support of logon, encrypted, and trusted key types.

Keyring keys must have the KEY_(POS|USR|GRP|OTH)_SEARCH permission set
to leverage this feature. This follows the asymmetric_key type where key
lookup calls eventually lead to keyring_search_rcu() without the
KEYRING_SEARCH_NO_CHECK_PERM flag set.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
RFC: https://lore.kernel.org/all/20221004212927.1539105-1-fred@cloudflare.com/

We have an idea for handling the case of leaking key data with bad
algorithms, but asymmetric keys currently have the same problem if any were
added as a akcipher type. If KEY_*_SEARCH is not good enough, we thought
of possibly implementing a KConfig such that we disable leaky algorithms
when selected, or possibly the inverse where if a leaky algorithm is
enabled, we don't allow to enable this. The problem there is now there's
a list to maintain.
---
 Documentation/crypto/userspace-if.rst |  15 ++-
 crypto/af_alg.c                       | 135 +++++++++++++++++++++++++-
 include/uapi/linux/if_alg.h           |   1 +
 3 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
index b45dabbf69d6..f80f243e227e 100644
--- a/Documentation/crypto/userspace-if.rst
+++ b/Documentation/crypto/userspace-if.rst
@@ -131,9 +131,9 @@ from the kernel crypto API. If the buffer is too small for the message
 digest, the flag MSG_TRUNC is set by the kernel.
 
 In order to set a message digest key, the calling application must use
-the setsockopt() option of ALG_SET_KEY. If the key is not set the HMAC
-operation is performed without the initial HMAC state change caused by
-the key.
+the setsockopt() option of ALG_SET_KEY or ALG_SET_KEY_BY_KEY_SERIAL. If the
+key is not set the HMAC operation is performed without the initial HMAC state
+change caused by the key.
 
 Symmetric Cipher API
 --------------------
@@ -382,6 +382,15 @@ mentioned optname:
 
    -  the RNG cipher type to provide the seed
 
+- ALG_SET_KEY_BY_KEY_SERIAL -- Setting the key via keyring key_serial_t.
+   This operation behaves the same as ALG_SET_KEY. The decrypted
+   data is copied from a keyring key, and uses that data as the
+   key for symmetric encryption.
+
+   The passed in key_serial_t must have the KEY_(POS|USR|GRP|OTH)_SEARCH
+   permission set, otherwise -EPERM is returned. Supports key types: user,
+   logon, encrypted, and trusted.
+
 -  ALG_SET_AEAD_AUTHSIZE -- Setting the authentication tag size for
    AEAD ciphers. For a encryption operation, the authentication tag of
    the given size will be generated. For a decryption operation, the
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index e893c0f6c879..0a4fa2a429e2 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -12,6 +12,8 @@
 #include <linux/crypto.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/key.h>
+#include <linux/key-type.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/net.h>
@@ -19,6 +21,10 @@
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/security.h>
+#include <linux/string.h>
+#include <keys/user-type.h>
+#include <keys/trusted-type.h>
+#include <keys/encrypted-type.h>
 
 struct alg_type_list {
 	const struct af_alg_type *type;
@@ -222,6 +228,129 @@ static int alg_setkey(struct sock *sk, sockptr_t ukey, unsigned int keylen)
 	return err;
 }
 
+#ifdef CONFIG_KEYS
+
+static const u8 *key_data_ptr_user(const struct key *key,
+				   unsigned int *datalen)
+{
+	const struct user_key_payload *ukp;
+
+	ukp = user_key_payload_locked(key);
+	if (IS_ERR_OR_NULL(ukp))
+		return ERR_PTR(-EKEYREVOKED);
+
+	*datalen = key->datalen;
+
+	return ukp->data;
+}
+
+static const u8 *key_data_ptr_encrypted(const struct key *key,
+					unsigned int *datalen)
+{
+	const struct encrypted_key_payload *ekp;
+
+	ekp = dereference_key_locked(key);
+	if (IS_ERR_OR_NULL(ekp))
+		return ERR_PTR(-EKEYREVOKED);
+
+	*datalen = ekp->decrypted_datalen;
+
+	return ekp->decrypted_data;
+}
+
+static const u8 *key_data_ptr_trusted(const struct key *key,
+				      unsigned int *datalen)
+{
+	const struct trusted_key_payload *tkp;
+
+	tkp = dereference_key_locked(key);
+	if (IS_ERR_OR_NULL(tkp))
+		return ERR_PTR(-EKEYREVOKED);
+
+	*datalen = tkp->key_len;
+
+	return tkp->key;
+}
+
+static struct key *lookup_key(key_serial_t serial)
+{
+	key_ref_t key_ref;
+
+	key_ref = lookup_user_key(serial, 0, KEY_NEED_SEARCH);
+	if (IS_ERR(key_ref))
+		return ERR_CAST(key_ref);
+
+	return key_ref_to_ptr(key_ref);
+}
+
+static int alg_setkey_by_key_serial(struct alg_sock *ask, sockptr_t optval,
+				    unsigned int optlen)
+{
+	const struct af_alg_type *type = ask->type;
+	u8 *key_data = NULL;
+	unsigned int key_datalen;
+	key_serial_t serial;
+	struct key *key;
+	const u8 *ret;
+	int err;
+
+	if (optlen != sizeof(serial))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&serial, optval, optlen))
+		return -EFAULT;
+
+	key = lookup_key(serial);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	down_read(&key->sem);
+
+	ret = ERR_PTR(-ENOPROTOOPT);
+	if (!strcmp(key->type->name, "user") ||
+	    !strcmp(key->type->name, "logon")) {
+		ret = key_data_ptr_user(key, &key_datalen);
+	} else if (IS_REACHABLE(CONFIG_ENCRYPTED_KEYS) &&
+			   !strcmp(key->type->name, "encrypted")) {
+		ret = key_data_ptr_encrypted(key, &key_datalen);
+	} else if (IS_REACHABLE(CONFIG_TRUSTED_KEYS) &&
+			   !strcmp(key->type->name, "trusted")) {
+		ret = key_data_ptr_trusted(key, &key_datalen);
+	}
+
+	if (IS_ERR(ret)) {
+		up_read(&key->sem);
+		return PTR_ERR(ret);
+	}
+
+	key_data = sock_kmalloc(&ask->sk, key_datalen, GFP_KERNEL);
+	if (!key_data) {
+		up_read(&key->sem);
+		return -ENOMEM;
+	}
+
+	memcpy(key_data, ret, key_datalen);
+
+	up_read(&key->sem);
+
+	err = type->setkey(ask->private, key_data, key_datalen);
+
+	sock_kzfree_s(&ask->sk, key_data, key_datalen);
+
+	return err;
+}
+
+#else
+
+static inline int alg_setkey_by_key_serial(struct alg_sock *ask,
+					   sockptr_t optval,
+					   unsigned int optlen)
+{
+	return -ENOPROTOOPT;
+}
+
+#endif
+
 static int alg_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -242,12 +371,16 @@ static int alg_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case ALG_SET_KEY:
+	case ALG_SET_KEY_BY_KEY_SERIAL:
 		if (sock->state == SS_CONNECTED)
 			goto unlock;
 		if (!type->setkey)
 			goto unlock;
 
-		err = alg_setkey(sk, optval, optlen);
+		if (optname == ALG_SET_KEY_BY_KEY_SERIAL)
+			err = alg_setkey_by_key_serial(ask, optval, optlen);
+		else
+			err = alg_setkey(sk, optval, optlen);
 		break;
 	case ALG_SET_AEAD_AUTHSIZE:
 		if (sock->state == SS_CONNECTED)
diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
index 578b18aab821..0824fbc026a1 100644
--- a/include/uapi/linux/if_alg.h
+++ b/include/uapi/linux/if_alg.h
@@ -52,6 +52,7 @@ struct af_alg_iv {
 #define ALG_SET_AEAD_ASSOCLEN		4
 #define ALG_SET_AEAD_AUTHSIZE		5
 #define ALG_SET_DRBG_ENTROPY		6
+#define ALG_SET_KEY_BY_KEY_SERIAL	7
 
 /* Operations */
 #define ALG_OP_DECRYPT			0
-- 
2.30.2

