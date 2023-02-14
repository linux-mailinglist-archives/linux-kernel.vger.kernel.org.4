Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A7269579F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBNDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBNDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:54:57 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D313D68
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:54:56 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id t6-20020a056e02010600b0031417634f4bso8129020ilm.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S6nMros/llLdOXJegqR0CJWd8CtbBj3YwsU1eZ6n/QU=;
        b=AV+uwc4Wu/3TUe2Tq8ebGYJUlDknVB65+1thDMNYyz/jfFRCPg6gfjllMqFPj/zxT5
         nbfAz9aJQR5Wc3mFz5GXtCyjPLViDEfRvLsyQiS02Jo3rBIwBI8fERbQ1qOMXZ0IrLjp
         dvKSXgowJ/d4QSYscbDL93iLrBWrk7EPrTSBgIu7UNg/gJahW/ynVmQ8a6v1YAOgmtbn
         xELIGeKHFcgMWHxg5XKsrr1jJ3+TIGpIWLU4+KTojX3rVS726g5f1h9+iiNkU6qTCr3U
         Kq46XPk1j7oQlexXnXL5ZlMOOa6fKaB8eE8hUb7S1ZcK3h9pnicZDBa2v5V+AvU8InEO
         JqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6nMros/llLdOXJegqR0CJWd8CtbBj3YwsU1eZ6n/QU=;
        b=euUuxPxA4yzxxXRnGXiqHi4MRtaPOQqCn04piEYN04aarZ7YnCjsPiiKT5gbFy1Y3x
         /bg/hW3uIIFqPZekH05qXsT4IRFHYgjpc/Exrh8E/PrP2ZLyciFs5JnOYEALD/N/CKTm
         FfkkWHzNLiiW8YQJ6el5c0ShhekOoX7Z8bGH9fLV3SitFDOI+WJu9Mww48NFy+xxkwmr
         Cz4XpVJptPHSikhTe1zWdFl/CUbLxvdBdaiJHLJAZq08ADWqkzoyOIsHGSSwLFRB2Se7
         JbwgcldtR3C/lik+H1WBwaA9fQisvk4mR/4jdr2kaXaMvcce7aU0WUP/n0ag90fG4Vs2
         IY1w==
X-Gm-Message-State: AO0yUKVsXKGmeczolBKqPioV3Vw09FynQOUCrqvxZl+v0kebWvAVS+Cw
        4+1NXtQ5aymChDrrm7QGMzI3nszjn4NzuQ==
X-Google-Smtp-Source: AK7set+jb8ZXOF5zqKGlgzK/J/rvicIo4ppN/vI0cHmrisQ/locMHHlmXxARwZnhsiFVKT/KaNUNLrUVi3JKQQ==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a02:3318:0:b0:3c4:88de:524 with SMTP id
 c24-20020a023318000000b003c488de0524mr105734jae.3.1676346895649; Mon, 13 Feb
 2023 19:54:55 -0800 (PST)
Date:   Tue, 14 Feb 2023 03:54:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214035445.1250139-1-talumbau@google.com>
Subject: [PATCH mm-unstable v1 1/2] mm: multi-gen LRU: clean up sysfs code
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the sysfs code. Specifically,
  1. use sysfs_emit(),
  2. use __ATTR_RW(), and
  3. constify multi-gen LRU struct attribute_group.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 include/linux/mmzone.h |  2 +-
 mm/vmscan.c            | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9fb1b03b83b2..bf8786d45b31 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1369,7 +1369,7 @@ typedef struct pglist_data {
 
 #ifdef CONFIG_LRU_GEN
 	/* kswap mm walk data */
-	struct lru_gen_mm_walk	mm_walk;
+	struct lru_gen_mm_walk mm_walk;
 	/* lru_gen_folio list */
 	struct lru_gen_memcg memcg_lru;
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4b9fd1ae0ed..09c064accdb1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5658,14 +5658,14 @@ static void lru_gen_change_state(bool enabled)
  *                          sysfs interface
  ******************************************************************************/
 
-static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+static ssize_t min_ttl_ms_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)));
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)));
 }
 
 /* see Documentation/admin-guide/mm/multigen_lru.rst for details */
-static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
-			     const char *buf, size_t len)
+static ssize_t min_ttl_ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t len)
 {
 	unsigned int msecs;
 
@@ -5677,11 +5677,9 @@ static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
 	return len;
 }
 
-static struct kobj_attribute lru_gen_min_ttl_attr = __ATTR(
-	min_ttl_ms, 0644, show_min_ttl, store_min_ttl
-);
+static struct kobj_attribute lru_gen_min_ttl_attr = __ATTR_RW(min_ttl_ms);
 
-static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	unsigned int caps = 0;
 
@@ -5698,7 +5696,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
 }
 
 /* see Documentation/admin-guide/mm/multigen_lru.rst for details */
-static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *attr,
+static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 			     const char *buf, size_t len)
 {
 	int i;
@@ -5725,9 +5723,7 @@ static ssize_t store_enabled(struct kobject *kobj, struct kobj_attribute *attr,
 	return len;
 }
 
-static struct kobj_attribute lru_gen_enabled_attr = __ATTR(
-	enabled, 0644, show_enabled, store_enabled
-);
+static struct kobj_attribute lru_gen_enabled_attr = __ATTR_RW(enabled);
 
 static struct attribute *lru_gen_attrs[] = {
 	&lru_gen_min_ttl_attr.attr,
@@ -5735,7 +5731,7 @@ static struct attribute *lru_gen_attrs[] = {
 	NULL
 };
 
-static struct attribute_group lru_gen_attr_group = {
+static const struct attribute_group lru_gen_attr_group = {
 	.name = "lru_gen",
 	.attrs = lru_gen_attrs,
 };
-- 
2.39.1.581.gbfd45094c4-goog

