Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48C749DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGFNaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGFNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:30:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1D10F7;
        Thu,  6 Jul 2023 06:30:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso89557766b.3;
        Thu, 06 Jul 2023 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688650208; x=1691242208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+r4qB5Yyg/pgrXiwZDTUnAOVLvTLgHpA3Uvo0HsgaAg=;
        b=JSQjT1QHfx4VkiRD66176ur56gKrN4qPlxIodiILIQiGANgZMqUlBNJx7jeEVVcOd5
         l3l2U+nrGaLLd3FW0n0wsnOF8bdNvFzpSvNcDToN4Y8h16VKZGfDjXC1TucM4g45OJcX
         p3ezmFDC8tNnDmq7HaQcvdf5J0dTTy/Eu5zx9iSZZSEX8cNooEsXaAoBNzpcSUb7Yp7A
         C56mi0o2lsabsqq0dle/7B4Lws5D5xqU6Fq0DMJmydqBir4IdIBeNNjr76cEUzII79MQ
         /YKeq6Y/Gf2TwqVqIU00mrjiL+JJhD55fY/+nBdrRx3zSKmia42wvzXnpTVOe7r0x60n
         OHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650208; x=1691242208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+r4qB5Yyg/pgrXiwZDTUnAOVLvTLgHpA3Uvo0HsgaAg=;
        b=k94qNrKUDOoCg2xOfmuTl89MqKE25BQzjFHXu1JuxpLI/b4cWaEnWEUz3GqKAO26oQ
         NoAakTp+qBdIkpHtD5/A/wZ6SrYd2yRCSb66wlLDmMXyYFYQguafU3HrKL6XVKuc8pj2
         WtPb8rrV7Qm84R7E3af7jhV/8iNP1vEx9gAOk8MVozoQAGLR9GVxPxDJ7wOyok8fSJ6b
         pnzV9iD77auH0C4V3NneBYkkXowfx1d34DGQ1G+ZDiHzSaWlxbAUAmDl07hl7mue+z/c
         UHXWV3U2UTB7rl0EkD6wPYC4P/rSh0hfLe95PToIdzzZIOim8FYjkwGlSqbgNO/wKRIO
         R9CQ==
X-Gm-Message-State: ABy/qLZoJdA9qxWuuauEN8SdgnwnfvthSvsYliMHMIEBMUNqvLoNlVZa
        yDnINkqqBJbkzjgOFrww1FTu6c9UJNe/Qk7U
X-Google-Smtp-Source: APBJJlHSe/vEbrhLpTlGr4dktDRERNZWfhvtYvBXMa6Dr6EVTfDaPShrHJjkxQPG6UffY504odoWpg==
X-Received: by 2002:a17:906:b88d:b0:98d:cd3e:c193 with SMTP id hb13-20020a170906b88d00b0098dcd3ec193mr1243417ejb.46.1688650208224;
        Thu, 06 Jul 2023 06:30:08 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906831000b00985ed2f1584sm808770ejx.187.2023.07.06.06.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:30:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: implement avtab_search() via avtab_search_node()
Date:   Thu,  6 Jul 2023 15:30:03 +0200
Message-Id: <20230706133004.19064-1-cgzones@googlemail.com>
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

Deduplicate avtab_search() by using the identical implementation from
avtab_search_node().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 32 --------------------------------
 security/selinux/ss/avtab.h | 11 ++++++++++-
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6766edc0fe68..33a54fbd989b 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -180,38 +180,6 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 	return avtab_insert_node(h, hvalue, prev, key, datum);
 }
 
-struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *key)
-{
-	int hvalue;
-	struct avtab_node *cur;
-	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
-
-	if (!h || !h->nslot)
-		return NULL;
-
-	hvalue = avtab_hash(key, h->mask);
-	for (cur = h->htable[hvalue]; cur;
-	     cur = cur->next) {
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class == cur->key.target_class &&
-		    (specified & cur->key.specified))
-			return &cur->datum;
-
-		if (key->source_type < cur->key.source_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type < cur->key.target_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class < cur->key.target_class)
-			break;
-	}
-
-	return NULL;
-}
-
 /* This search function returns a node pointer, and can be used in
  * conjunction with avtab_search_next_node()
  */
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d6742fd9c560..16238c7bcbba 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -90,7 +90,6 @@ struct avtab {
 void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
-struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, const char *tag);
 
@@ -110,6 +109,16 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key);
+static inline struct avtab_datum *avtab_search(struct avtab *h,
+					       const struct avtab_key *key)
+{
+	struct avtab_node *cur = avtab_search_node(h, key);
+
+	if (cur)
+		return &cur->datum;
+
+	return NULL;
+}
 
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
-- 
2.40.1

