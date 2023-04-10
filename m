Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD06DC398
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDJGjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDJGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:39:23 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5B40E0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 23:39:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfhGV3r_1681108758;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfhGV3r_1681108758)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 14:39:18 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] erofs: handle long xattr name prefixes properly
Date:   Mon, 10 Apr 2023 14:39:18 +0800
Message-Id: <20230410063918.47215-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-7-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make .{list,get}xattr routines adapted to long xattr name prefixes.
When the bit 7 of erofs_xattr_entry.e_name_index is set, it indicates
that it refers to a long xattr name prefix.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2: remove "idx" temporary variable (Gao Xiang)
---
 fs/erofs/xattr.c | 57 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 684571e83a2c..4ad290b6acb7 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -301,11 +301,38 @@ struct getxattr_iter {
 	struct qstr name;
 };
 
+static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+				       struct erofs_xattr_entry *entry)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
+	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+		return -ENOATTR;
+
+	if (it->index != pf->prefix->base_index)
+		return -ENOATTR;
+
+	if (strncmp(it->name.name, pf->prefix->infix, pf->infix_len))
+		return -ENOATTR;
+
+	it->name.name += pf->infix_len;
+	it->name.len -= pf->infix_len;
+	if (it->name.len != entry->e_name_len)
+		return -ENOATTR;
+	return 0;
+}
+
 static int xattr_entrymatch(struct xattr_iter *_it,
 			    struct erofs_xattr_entry *entry)
 {
 	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 
+	/* should also match the infix for long name prefixes */
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
+		return erofs_xattr_long_entrymatch(it, entry);
+
 	return (it->index != entry->e_name_index ||
 		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
 }
@@ -487,12 +514,24 @@ static int xattr_entrylist(struct xattr_iter *_it,
 {
 	struct listxattr_iter *it =
 		container_of(_it, struct listxattr_iter, it);
-	unsigned int prefix_len;
-	const char *prefix;
-
-	const struct xattr_handler *h =
-		erofs_xattr_handler(entry->e_name_index);
+	unsigned int base_index = entry->e_name_index;
+	unsigned int prefix_len, infix_len = 0;
+	const char *prefix, *infix = NULL;
+	const struct xattr_handler *h;
+
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
+		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+			return 1;
+		infix = pf->prefix->infix;
+		infix_len = pf->infix_len;
+		base_index = pf->prefix->base_index;
+	}
 
+	h = erofs_xattr_handler(base_index);
 	if (!h || (h->list && !h->list(it->dentry)))
 		return 1;
 
@@ -500,16 +539,18 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	prefix_len = strlen(prefix);
 
 	if (!it->buffer) {
-		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
+		it->buffer_ofs += prefix_len + infix_len +
+					entry->e_name_len + 1;
 		return 1;
 	}
 
-	if (it->buffer_ofs + prefix_len
+	if (it->buffer_ofs + prefix_len + infix_len +
 		+ entry->e_name_len + 1 > it->buffer_size)
 		return -ERANGE;
 
 	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
-	it->buffer_ofs += prefix_len;
+	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
+	it->buffer_ofs += prefix_len + infix_len;
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b

