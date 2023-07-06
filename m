Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01394749D68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjGFNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGFNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DF1996;
        Thu,  6 Jul 2023 06:23:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e39784a85so357558066b.1;
        Thu, 06 Jul 2023 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649827; x=1691241827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92d6Vul513gSV9/1vQgZrdNmQwl67uBvttC751CUwUE=;
        b=hS4AMI2jCzCL3VWz2p35RhxjI+7LKoR6iK5B1kPOAI0fEjm55EdD/OrT/Sy4qXZTEF
         Z4CykaL7llo75jRXvaoAo6wVteido48LdufNhcZ2mHtkrILnm/AB1OAZKhbsED3trTt2
         Wfxk20NdrlGc6DYdisyQZnGwc5CJmSiwLQFsomh43Hw0YxT8aF0jdxPVSDpAYJjw3dRg
         ZgKnobjhDLh0SHk5gH/7frbpbsyrjf9usDedrp0NKNuLHOu5LNvwy4zGDnKGCm7NI1Ex
         G0WAzthgfwQWDH7VXJBcSbU/4sX84b0LPfyZF//RelBojLiDm1fQa6lJWCCNp3dEFhew
         5PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649827; x=1691241827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92d6Vul513gSV9/1vQgZrdNmQwl67uBvttC751CUwUE=;
        b=II8NCWa2rx0ah24Kx2XjX2vUkF5ZYu72CzukmFENt7QmmTCNtrFSqmyufXAhFnXcwL
         7lmjNzz+mId7qfXxN4pZXtuR2MABFe2IyUAJZjfrRgqaHJ6G07ikhYuXU34Bg3t7MgN7
         GV/j5KbQF3sVDY/YtAPGXJSYPUOg6vZs4kr2EZMhXbFqm0zJcm9cO8JDwwkLQ7aKLTQX
         FrDUF6vP94TGCppOn9omF5XKqWmRpaTmikQfsEODvOGAabO4e8oeQbzOgccq5KQ6rdf7
         v1t880bNpiImrlBjmbbnNA9vv1euVNPlPrW021JLbfjBYNxOvYfXYbBpLtKvR5yYZjCI
         DE/Q==
X-Gm-Message-State: ABy/qLZP90UpImibpGbPvJvvB6LFZ9Aatk9lQkZlJcVYkmSOIuJlUXWF
        N2l4u/83Zk5HKUx2tSBbPCKnAGu73fLVlbT3
X-Google-Smtp-Source: APBJJlHoc5jnjV3vUFqN4/yWUCziBYDrlZcrRLYJuk93naI8hIqAmBTgFOJEjJnuyhwsVC30Tjvnzw==
X-Received: by 2002:a17:906:1041:b0:992:8d96:4de3 with SMTP id j1-20020a170906104100b009928d964de3mr2081378ejj.24.1688649827107;
        Thu, 06 Jul 2023 06:23:47 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/20] selinux: ebitmap: use u32 as bit type
Date:   Thu,  6 Jul 2023 15:23:19 +0200
Message-Id: <20230706132337.15924-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
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

The extensible bitmap supports bit positions up to U32_MAX due to the
type of the member highbit being u32.  Use u32 consistently as the type
for bit positions to announce to callers what range of values is
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 32 ++++++++++++++++----------------
 security/selinux/ss/ebitmap.h | 32 ++++++++++++++++----------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index d31b87be9a1e..17d2d9b0d444 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -24,7 +24,7 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
-#define BITS_PER_U64	(sizeof(u64) * 8)
+#define BITS_PER_U64	((u32)(sizeof(u64) * 8))
 
 static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
@@ -82,7 +82,8 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
 {
 	struct ebitmap_node *n;
-	int bit, rc;
+	u32 bit;
+	int rc;
 
 	ebitmap_init(dst);
 
@@ -113,8 +114,7 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 {
 	struct ebitmap_node *e_iter = ebmap->node;
 	unsigned long e_map;
-	u32 offset;
-	unsigned int iter;
+	u32 offset, iter;
 	int rc;
 
 	if (e_iter == NULL) {
@@ -259,7 +259,7 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 las
 	return 1;
 }
 
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 {
 	const struct ebitmap_node *n;
 
@@ -276,7 +276,7 @@ int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
 	return 0;
 }
 
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
 {
 	struct ebitmap_node *n, *prev, *new;
 
@@ -287,7 +287,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 			if (value) {
 				ebitmap_node_set_bit(n, bit);
 			} else {
-				unsigned int s;
+				u32 s;
 
 				ebitmap_node_clr_bit(n, bit);
 
@@ -370,7 +370,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	u64 map;
 	__le64 mapbits;
 	__le32 buf[3];
-	int rc, i;
+	int rc;
 
 	ebitmap_init(e);
 
@@ -384,7 +384,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 	if (mapunit != BITS_PER_U64) {
 		pr_err("SELinux: ebitmap: map size %u does not "
-		       "match my size %zd (high bit was %d)\n",
+		       "match my size %d (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
@@ -401,7 +401,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	if (e->highbit && !count)
 		goto bad;
 
-	for (i = 0; i < count; i++) {
+	for (u32 i = 0; i < count; i++) {
 		rc = next_entry(&ebitmap_start, fp, sizeof(u32));
 		if (rc < 0) {
 			pr_err("SELinux: ebitmap: truncated map\n");
@@ -471,18 +471,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 int ebitmap_write(const struct ebitmap *e, void *fp)
 {
 	struct ebitmap_node *n;
-	u32 count;
+	u32 bit, count, last_bit, last_startbit;
 	__le32 buf[3];
 	u64 map;
-	int bit, last_bit, last_startbit, rc;
+	int rc;
 
 	buf[0] = cpu_to_le32(BITS_PER_U64);
 
 	count = 0;
 	last_bit = 0;
-	last_startbit = -1;
+	last_startbit = (u32)-1;
 	ebitmap_for_each_positive_bit(e, n, bit) {
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == (u32)-1 || rounddown(bit, BITS_PER_U64) > last_startbit) {
 			count++;
 			last_startbit = rounddown(bit, BITS_PER_U64);
 		}
@@ -496,9 +496,9 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
 		return rc;
 
 	map = 0;
-	last_startbit = INT_MIN;
+	last_startbit = (u32)-1;
 	ebitmap_for_each_positive_bit(e, n, bit) {
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == (u32)-1 || rounddown(bit, BITS_PER_U64) > last_startbit) {
 			__le64 buf64[1];
 
 			/* this is the very first bit */
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e5b57dc3fc53..fab3e5bef896 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -44,10 +44,10 @@ struct ebitmap {
 
 #define ebitmap_length(e) ((e)->highbit)
 
-static inline unsigned int ebitmap_start_positive(const struct ebitmap *e,
+static inline u32 ebitmap_start_positive(const struct ebitmap *e,
 						  struct ebitmap_node **n)
 {
-	unsigned int ofs;
+	u32 ofs;
 
 	for (*n = e->node; *n; *n = (*n)->next) {
 		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
@@ -62,11 +62,11 @@ static inline void ebitmap_init(struct ebitmap *e)
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
+static inline u32 ebitmap_next_positive(const struct ebitmap *e,
 						 struct ebitmap_node **n,
-						 unsigned int bit)
+						 u32 bit)
 {
-	unsigned int ofs;
+	u32 ofs;
 
 	ofs = find_next_bit((*n)->maps, EBITMAP_SIZE, bit - (*n)->startbit + 1);
 	if (ofs < EBITMAP_SIZE)
@@ -86,10 +86,10 @@ static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
 static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
-				       unsigned int bit)
+				       u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	if ((n->maps[index] & (EBITMAP_BIT << ofs)))
@@ -98,20 +98,20 @@ static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
 }
 
 static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
-					unsigned int bit)
+					u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
 static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
-					unsigned int bit)
+					u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	n->maps[index] &= ~(EBITMAP_BIT << ofs);
@@ -126,8 +126,8 @@ int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src);
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2);
 int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 last_e2bit);
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit);
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
 int ebitmap_read(struct ebitmap *e, void *fp);
 int ebitmap_write(const struct ebitmap *e, void *fp);
-- 
2.40.1

