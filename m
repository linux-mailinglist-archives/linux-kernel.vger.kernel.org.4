Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02065F4AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJDV3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJDV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:29:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279436CD0B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:29:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b20so1503692iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1FZVjIvYXSRdHNXnwigjTl8t5L9yvIG1Uu2GI3VrKMg=;
        b=x9S6hsONlOI9IC0kUHhsJftvOT17HrHkKX2c8+iRfYDItdh3Ccx6vrwWXu+8t11fmy
         ym8MYsVmozN4QyNYpad9XnWC1LPnuHJwSpRUy8el7bocoQRrutsHBeZLdgjChE9n5yzO
         AkgxmAw023+rJs5ggZp+UHoWiKN6ixl6MuxxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1FZVjIvYXSRdHNXnwigjTl8t5L9yvIG1Uu2GI3VrKMg=;
        b=H3K0k7i0J0aCBHZlWyD7j8bfftAwUAk5VGePx7V+9YHlYYNk+AaAfXA7sWv32sHFoh
         PyiJQgINd+1KP6iqXazPoFN8qPzTvaqPVHzG11g6Nw7ThLt/i2gVlWRpD/jJULrC1O17
         7WXKvKOabPGfOo37EMyqQaCAzMS61w5CuIdL4bc1asWOlgXcPO9ev4pz1+N4l/diKFaN
         576l+bO8oF1ZxaYhn+uBpMOMkD9jV8q/RLvZlrZjvFRDOcW6+I7re7dN+tHeq4VKGCEk
         FzyAWMABSrtHaNMyo51nkvp7eKfBub/3yR75/FiGSlDsCuY0jCTlROTJrctQsD8kR/8s
         SpyA==
X-Gm-Message-State: ACrzQf0Dzf7CM2zC84E5HyDQIYgOcmPFtEdeP8mUkxT/UYC72zT5eR/y
        s9XTAOcOZ7k25nAvmHEQ8FjidA==
X-Google-Smtp-Source: AMsMyM6GQ8zLH3Jl6WKS834eBV86epxXCsUNp0PabYS90l91t3gPB5aKvAtEMFMz4b/EJoswT5eL0A==
X-Received: by 2002:a05:6638:1686:b0:35a:2566:6786 with SMTP id f6-20020a056638168600b0035a25666786mr14025034jat.180.1664918972418;
        Tue, 04 Oct 2022 14:29:32 -0700 (PDT)
Received: from localhost.localdomain ([172.58.60.158])
        by smtp.gmail.com with ESMTPSA id g99-20020a02856c000000b00362983f80a3sm3430893jai.30.2022.10.04.14.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:29:31 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, hch@lst.de, smueller@chronox.de
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
Subject: [RFC PATCH 1/1] crypto: af_alg - Support symmetric encryption via keyring keys
Date:   Tue,  4 Oct 2022 16:29:27 -0500
Message-Id: <20221004212927.1539105-1-fred@cloudflare.com>
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
return their encrypted data back to user space on read, which make them not
ideal for symmetric encryption.

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
 Documentation/crypto/userspace-if.rst |  15 ++-
 crypto/af_alg.c                       | 142 +++++++++++++++++++++++++-
 include/uapi/linux/if_alg.h           |   1 +
 3 files changed, 154 insertions(+), 4 deletions(-)

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
index e893c0f6c879..da949089def2 100644
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
@@ -222,6 +228,136 @@ static int alg_setkey(struct sock *sk, sockptr_t ukey, unsigned int keylen)
 	return err;
 }
 
+#ifdef CONFIG_KEYS
+
+static int read_key_type_user(const struct key *key, u8 **dest, u16 *dest_len)
+{
+	const struct user_key_payload *ukp;
+
+	ukp = user_key_payload_locked(key);
+	if (IS_ERR_OR_NULL(ukp))
+		return -EKEYREVOKED;
+
+	*dest_len = key->datalen;
+	*dest = kmalloc(*dest_len, GFP_KERNEL);
+	if (!*dest)
+		return -ENOMEM;
+
+	memcpy(*dest, ukp->data, *dest_len);
+	return 0;
+}
+
+static int read_key_type_encrypted(const struct key *key, u8 **dest, u16 *dest_len)
+{
+	const struct encrypted_key_payload *ekp;
+
+	ekp = dereference_key_locked(key);
+	if (IS_ERR_OR_NULL(ekp))
+		return -EKEYREVOKED;
+
+	*dest_len = ekp->decrypted_datalen;
+	*dest = kmalloc(*dest_len, GFP_KERNEL);
+	if (!*dest)
+		return -ENOMEM;
+
+	memcpy(*dest, ekp->decrypted_data, *dest_len);
+
+	return 0;
+}
+
+static int read_key_type_trusted(const struct key *key, u8 **dest, u16 *dest_len)
+{
+	const struct trusted_key_payload *tkp;
+
+	tkp = dereference_key_locked(key);
+	if (IS_ERR_OR_NULL(tkp))
+		return -EKEYREVOKED;
+
+	*dest_len = tkp->key_len;
+	*dest = kmalloc(*dest_len, GFP_KERNEL);
+	if (!*dest)
+		return -ENOMEM;
+
+	memcpy(*dest, tkp->key, *dest_len);
+	return 0;
+}
+
+static int alg_setkey_by_key_serial(struct sock *sk, sockptr_t ukey, unsigned int keylen)
+{
+	u8 *ukey_serial;
+	int err;
+	u8 *key_data;
+	u16 key_data_len;
+	struct key *key;
+	key_ref_t key_ref;
+	key_serial_t *key_serial;
+	int (*read_key)(const struct key *key, u8 **dest, u16 *dest_len);
+
+	struct alg_sock *ask = alg_sk(sk);
+	const struct af_alg_type *type = ask->type;
+
+	ukey_serial = sock_kmalloc(sk, keylen, GFP_KERNEL);
+	if (!ukey_serial)
+		return -ENOMEM;
+
+	err = -EFAULT;
+	if (copy_from_sockptr(ukey_serial, ukey, keylen))
+		goto out;
+
+	key_serial = (key_serial_t *)ukey_serial;
+	key_ref = lookup_user_key(*key_serial, 0, KEY_NEED_SEARCH);
+	if (IS_ERR(key_ref)) {
+		err = PTR_ERR(key_ref);
+		goto out;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	down_read(&key->sem);
+
+	err = -ENOPROTOOPT;
+	if (!strcmp(key->type->name, "user") ||
+	    !strcmp(key->type->name, "logon")) {
+		read_key = &read_key_type_user;
+	} else if (IS_ENABLED(CONFIG_ENCRYPTED_KEYS) &&
+			   !strcmp(key->type->name, "encrypted")) {
+		read_key = &read_key_type_encrypted;
+	} else if (IS_ENABLED(CONFIG_TRUSTED_KEYS) &&
+			   !strcmp(key->type->name, "trusted")) {
+		read_key = &read_key_type_trusted;
+	} else {
+		up_read(&key->sem);
+		goto out;
+	}
+
+	err = read_key(key, &key_data, &key_data_len);
+	if (err) {
+		up_read(&key->sem);
+		kfree_sensitive(key_data);
+		goto out;
+	}
+
+	up_read(&key->sem);
+
+	err = type->setkey(ask->private, key_data, key_data_len);
+
+	kfree_sensitive(key_data);
+
+out:
+	sock_kzfree_s(sk, ukey_serial, keylen);
+
+	return err;
+}
+
+#else
+
+static inline int alg_setkey_by_key_serial(struct sock *sk, sockptr_t ukey, unsigned int keylen)
+{
+	return -ENOPROTOOPT;
+}
+
+#endif
+
 static int alg_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -242,12 +378,16 @@ static int alg_setsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case ALG_SET_KEY:
+	case ALG_SET_KEY_BY_KEY_SERIAL:
 		if (sock->state == SS_CONNECTED)
 			goto unlock;
 		if (!type->setkey)
 			goto unlock;
 
-		err = alg_setkey(sk, optval, optlen);
+		if (optname == ALG_SET_KEY_BY_KEY_SERIAL)
+			err = alg_setkey_by_key_serial(sk, optval, optlen);
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

