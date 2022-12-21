Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84E65328F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLUOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:43:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47C164B6;
        Wed, 21 Dec 2022 06:43:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so2277940pjo.3;
        Wed, 21 Dec 2022 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAWHPEdicK+v8KQVffUr5ACCC/uEXMMTXL2oNSyLzUc=;
        b=XbLS+IZkSNq7JWTLfBD9UTEy7+kwsNWG455cVEHdUP3dn/1dnXuDFxULQn5ltYd4ez
         shHrqfo0FLZD4BfJg68vGJyX1OQFVupMkRrWarBfZaq4lEX/6sbzznz7etyxWlaK1jQF
         trcwtf31NDh/v9il4zLaaTIkcOjxVitgnUztzGfQ62wIe63T4Qa8mdYUCCygsbY9MVQV
         LMEvmNw1WQzMSEU1dUJKKWYKaNd8oflwSmu+faxjqGcDDw5F5+nWJCHOkG4XXVmIBoSc
         ggoHmHQ+JOw5LilqEfrEOlY2lkaTaucOhLkj/A7brQU9EL44YYhm7Pbqoo8HENkgjU5Q
         DBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAWHPEdicK+v8KQVffUr5ACCC/uEXMMTXL2oNSyLzUc=;
        b=3psLegNO7g3HI2ilewXQt0BOkH1bgCLMiW8/03hBptPM8yeViTl5S1+yUHB2XChJzu
         eWd5UKkp521lPjTsuLt10mCdhaj3shdPqlLtvBURBVr9uETV3HneUEUPlOKBLQdHaFhm
         l5TprWaLITzOSDLONmYcN5cni7HvpSmO9s/L9HQN8Y/Cpzz/CvJC5WebqFJ29Q+u6UMe
         9atXhXg3wF+c0paSX2neE8Sb/3/SlDG0EE6emGFEfG6HTyl026EtL4vjsmwbwuhsEsVC
         xY59I2wPTU/ZoJztgtfuooDMlLVuOhVkVlsC7GRm1vZe+2Amkvf4PM6T15S/gaK+ctCP
         v7Fw==
X-Gm-Message-State: AFqh2kqdYsfiIGM0XRqqO2JBd+2H1edXveGz/TI+LreTTdYHALnGue+J
        8maR0tY/WStzApUbjCt0cA==
X-Google-Smtp-Source: AMrXdXvE8eN0aMXdaEyMjhnsS1KjZ+gJcn2MLJnMveyzLx0Vb6wY12Ex2AciixoMn9ZZ4TMRSBaoVg==
X-Received: by 2002:a05:6a20:8341:b0:ad:a5fd:b659 with SMTP id z1-20020a056a20834100b000ada5fdb659mr2353428pzc.7.1671633781342;
        Wed, 21 Dec 2022 06:43:01 -0800 (PST)
Received: from localhost.localdomain (n119236129232.netvigator.com. [119.236.129.232])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b00177efb56475sm11550994plb.85.2022.12.21.06.42.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Dec 2022 06:43:00 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, daniel@iogearbox.net,
        terrelln@fb.com, linux-security-module@vger.kernel.org,
        Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v2] mm: new primitive kvmemdup()
Date:   Wed, 21 Dec 2022 22:42:45 +0800
Message-Id: <20221221144245.27164-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to kmemdup(), but support large amount of bytes with kvmalloc()
and does *not* guarantee that the result will be physically contiguous.
Use only in cases where kvmalloc() is needed and free it with kvfree().
Also adapt policy_unpack.c in case someone bisect into this.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
This pattern has been used in several places and we're also going to
do this[1], seems reasonable to add this so that bpf and in future
others could make use of it.

v1 -> v2 adapt policy_unpack.c to fix compile error

[1] https://lore.kernel.org/bpf/7d274284-0fcc-061c-582e-3dfb629c6a44@iogearbox.net/T/#t
---
 include/linux/string.h            |  1 +
 mm/util.c                         | 24 +++++++++++++++++++++++-
 security/apparmor/policy_unpack.c | 11 +----------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index db28802ab0a6..c062c581a98b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -177,6 +177,7 @@ extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
+extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
diff --git a/mm/util.c b/mm/util.c
index b56c92fb910f..cec9327b27b4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -120,7 +120,8 @@ EXPORT_SYMBOL(kstrndup);
  * @len: memory region length
  * @gfp: GFP mask to use
  *
- * Return: newly allocated copy of @src or %NULL in case of error
+ * Return: newly allocated copy of @src or %NULL in case of error,
+ * result is physically contiguous. Use kfree() to free.
  */
 void *kmemdup(const void *src, size_t len, gfp_t gfp)
 {
@@ -133,6 +134,27 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup);
 
+/**
+ * kvmemdup - duplicate region of memory
+ *
+ * @src: memory region to duplicate
+ * @len: memory region length
+ * @gfp: GFP mask to use
+ *
+ * Return: newly allocated copy of @src or %NULL in case of error,
+ * result may be not physically contiguous. Use kvfree() to free.
+ */
+void *kvmemdup(const void *src, size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = kvmalloc(len, gfp);
+	if (p)
+		memcpy(p, src, len);
+	return p;
+}
+EXPORT_SYMBOL(kvmemdup);
+
 /**
  * kmemdup_nul - Create a NUL-terminated string from unterminated data
  * @s: The data to stringify
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 66915653108c..5e9949832af6 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -161,15 +161,6 @@ VISIBLE_IF_KUNIT bool aa_inbounds(struct aa_ext *e, size_t size)
 }
 EXPORT_SYMBOL_IF_KUNIT(aa_inbounds);
 
-static void *kvmemdup(const void *src, size_t len)
-{
-	void *p = kvmalloc(len, GFP_KERNEL);
-
-	if (p)
-		memcpy(p, src, len);
-	return p;
-}
-
 /**
  * aa_unpack_u16_chunk - test and do bounds checking for a u16 size based chunk
  * @e: serialized data read head (NOT NULL)
@@ -1027,7 +1018,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 			data->key = key;
 			data->size = aa_unpack_blob(e, &data->data, NULL);
-			data->data = kvmemdup(data->data, data->size);
+			data->data = kvmemdup(data->data, data->size, GFP_KERNEL);
 			if (data->size && !data->data) {
 				kfree_sensitive(data->key);
 				kfree_sensitive(data);

base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
-- 
2.39.0

