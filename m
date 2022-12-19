Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703E9650705
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 05:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiLSEWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 23:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLSEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 23:21:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1896355
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 20:21:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g10so7825031plo.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 20:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYOZHntsfq9Oqu0AIUyQ2czFdBjuydE+iWot/+A9tks=;
        b=fEja4+CjRKWn1HDf3oFuDpMNyY4ILeRfE6RyXf0N2LsVGmugFuW2LT6wBLvR6OZXw9
         s7Ow9Tn4mA/gsew93EA7bvJIULnSNmtXKHha8fd4yKp0848Rnd2RaM+zozllRMJQGKiD
         YzpUJErUX5fuOJ9C3DrXLrszMo6EGkBz7qB/UlNLp9AMG39/IhkTewQMLspDIb/7h5YR
         Jh+wMWr03nP/1Ezja2nIjoDlOek8aBKBej7A59SoRbd8+UQhut9sop6owyMfWOr40tCg
         +AnnrBajRSBuPP66YlCcU8f/TvAO45u1pOkTX9gcECAFBg6CJ6JqAONJQqspnXEmodWF
         BHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYOZHntsfq9Oqu0AIUyQ2czFdBjuydE+iWot/+A9tks=;
        b=pcjNS9e5KeB4JrI/3UXhAd4lkw9O0rnLcoFsdfBRxFVegPIfc8kUZOEGYlGBm6mEiZ
         r4zYIrHklGd8jGaogPz7NPgDWddQQniFIlCMBlaf8eMkZocxW995aIjwHt1xKycOGF6n
         U8cjZTgS5ACLUIi0kS7huXyxXHa1aJhuM4EghitQJPPvTrmd2fYvunr1NM/a4VenvPoX
         37ELuMo9t7wfjieQ+r9WTl5iGytQRpjGr/8pk9UK+6VI7HQayQMXx9GBC4zmZWDwMXRt
         ldf1uBmeByS0BtfvidPR6C380bDBWRB5xvVceJn8stOCK9wGzGdS0xcn43lpXn3oo6ew
         0jow==
X-Gm-Message-State: AFqh2krpeB5e68hwBHu1lMIJ30y+flRZ1AvElFdnFNuRAfWWASdoHfal
        qwW/lP8EuAZ+7zFYRVda1Q==
X-Google-Smtp-Source: AMrXdXsShbSg9tkRr9cAr4isOuGI/2MNiXO5pgVI8hqOMcUl02pgbWJV8ue4UcuPDHun13xdkKLxfA==
X-Received: by 2002:a17:902:cf08:b0:191:282:5d6c with SMTP id i8-20020a170902cf0800b0019102825d6cmr14622492plg.61.1671423716287;
        Sun, 18 Dec 2022 20:21:56 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm5896615plg.49.2022.12.18.20.21.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Dec 2022 20:21:55 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     daniel@iogearbox.net, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] mm: new primitive kvmemdup()
Date:   Mon, 19 Dec 2022 12:21:26 +0800
Message-Id: <20221219042126.3396-1-sunhao.th@gmail.com>
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

Suggested-by: Daniel Borkmann <daniel@iogearbox.net> 
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
This pattern has been used in several places and we're also going to
do this[1], seems reasonable to add this so that bpf and in future
others could make use of it.

[1] https://lore.kernel.org/bpf/7d274284-0fcc-061c-582e-3dfb629c6a44@iogearbox.net/T/#t
---
 include/linux/string.h |  1 +
 mm/util.c              | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

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

base-commit: f9ff5644bcc04221bae56f922122f2b7f5d24d62
-- 
2.39.0

