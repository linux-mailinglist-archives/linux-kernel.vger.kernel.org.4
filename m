Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7983749DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjGFNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjGFNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:37:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF7E3;
        Thu,  6 Jul 2023 06:37:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso1007181e87.2;
        Thu, 06 Jul 2023 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688650674; x=1691242674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuEiPXjKjwUIdKAreCBVtaU25Eh4PG9V/Wqte4w7hxk=;
        b=YuAJBBuM7cxzYQ36GGql0ThppA9e4sGKzf6fDSyHcZCr7enEw22UlwOVsWf+IV+MqB
         lajNMNsEPkfbXfO1rIRsOfcI/01Q6rNHKqHyppcYh5XQfIHVoJ5oXXiNL1AQPt1anJJt
         N9R0j9pxl9/Oix201l5iJBhZArCTeyRS3Udc9tQYoMjzLzbBzTXlEfC5zJcM4tqN1Qls
         cHWboQEmL75DcjulTQHDJhhk0Wg9fixniRVG7VC6HmgigPH5bxPI3aOt/vwKP7g7pFtq
         74JcbjK1addLP4FIaWER5YQ5gvNbgXHYC7rXACoCmHO2wZikB7zAbE5re1usRvc6Oy5p
         hn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650674; x=1691242674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuEiPXjKjwUIdKAreCBVtaU25Eh4PG9V/Wqte4w7hxk=;
        b=dPajtKjFdPhilJ0KtFDPImxq9gwQN6IVoz+oBo8NrqkGA5TyXP8yLqTWJ4kg2d41rb
         6sUVHGf/aAzIVwEu02odovQO1uQpHr8VZ74WN27Ov5OLqvHUP7E2t21jeBAZ9DJ/dyd9
         KrsJFgft34/JatcWjreGx48ppwXWjoXEB3y2D/e712k+5hi0IdZzehpds2/K5H6vZIvg
         Tx1PFFGAxEgjOkthGOs1w8Kvf7G4kaVY9+P0mapSJKoF6/XFltnVziOxMkOz4vDYF/xz
         b0XanYFDPseJYNpJpfZkfxlRZonvj+86SzchzM4ztVNw/89m/RNEhujLLHDInMQGiDnX
         2/sg==
X-Gm-Message-State: ABy/qLZRdk+mDz7aVVXlY4a5U0CuHmhH/3fmnweH1udkFJ8wo6x386HX
        +fJSSK8G7DpkhcsnwphVEbqU1FbALnzok5EJ
X-Google-Smtp-Source: APBJJlGZ3am9zOfeBgWijBLbuF/tNDpOUBY57m2T6CWy3qGzqO/mdo5xjJCO2vtzAg3Vue0vh5ZSIQ==
X-Received: by 2002:a05:6512:1045:b0:4fb:ca59:50ff with SMTP id c5-20020a056512104500b004fbca5950ffmr1705108lfb.13.1688650674256;
        Thu, 06 Jul 2023 06:37:54 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7da57000000b0051debcb1fa2sm786198eds.69.2023.07.06.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:37:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: disable debug functions by default
Date:   Thu,  6 Jul 2023 15:37:49 +0200
Message-Id: <20230706133751.38149-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
the debug macro DEBUG_HASHES is defined.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c   | 2 ++
 security/selinux/ss/avtab.h   | 3 +++
 security/selinux/ss/hashtab.c | 3 ++-
 security/selinux/ss/hashtab.h | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6766edc0fe68..2fd1a21b4428 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -354,6 +354,7 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 	return avtab_alloc_common(new, orig->nslot);
 }
 
+#ifdef DEBUG_HASHES
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
@@ -384,6 +385,7 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
 }
+#endif
 
 static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d6742fd9c560..66c9077b7098 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -92,7 +92,10 @@ int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
+
+#ifdef DEBUG_HASHES
 void avtab_hash_eval(struct avtab *h, const char *tag);
+#endif
 
 struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 3fb8f9026e9b..672ea20ad1bb 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -103,7 +103,7 @@ int hashtab_map(struct hashtab *h,
 	return 0;
 }
 
-
+#ifdef DEBUG_HASHES
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
@@ -129,6 +129,7 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 	info->slots_used = slots_used;
 	info->max_chain_len = max_chain_len;
 }
+#endif
 
 int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		int (*copy)(struct hashtab_node *new,
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 043a773bf0b7..64010a7f01a1 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -143,6 +143,8 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		void *args);
 
 /* Fill info with some hash table statistics */
+#ifdef DEBUG_HASHES
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
+#endif
 
 #endif	/* _SS_HASHTAB_H */
-- 
2.40.1

