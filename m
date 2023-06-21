Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EED737D84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjFUIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFUIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:32:15 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF110E6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:32:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VlfGJyV_1687336330;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlfGJyV_1687336330)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:32:10 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [RFC 1/2] erofs: update on-disk format for xattr bloom filter
Date:   Wed, 21 Jun 2023 16:32:08 +0800
Message-Id: <20230621083209.116024-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xattr bloom filter feature is going to be introduced to speed up the
negative xattr lookup, e.g. system.posix_acl_[access|default] lookup
when running "ls -lR" workload.

The number of common used xattr (n) is approximately 8, including
system.[posix_acl_access|posix_acl_default], security.[capability|selinux]
and security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].  Given the
number of bits of the bloom filter (m) is 32, the optimal value for the
number of the hash functions (k) is 2 (ln2 * m/n = 2.7).

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2c7b16e340fe..9daea86cdb52 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -13,6 +13,7 @@
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_BLOOM	0x00000003
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -200,7 +201,7 @@ struct erofs_inode_extended {
  * for read-only fs, no need to introduce h_refcount
  */
 struct erofs_xattr_ibody_header {
-	__le32 h_reserved;
+	__le32 h_map;	/* bloom filter, bit value 1 indicates not-present */
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[];       /* shared xattr id array */
@@ -221,6 +222,11 @@ struct erofs_xattr_ibody_header {
 #define EROFS_XATTR_LONG_PREFIX		0x80
 #define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
 
+#define EROFS_XATTR_BLOOM_BITS		32
+#define EROFS_XATTR_BLOOM_MASK		(EROFS_XATTR_BLOOM_BITS - 1)
+#define EROFS_XATTR_BLOOM_DEFAULT	UINT32_MAX
+#define EROFS_XATTR_BLOOM_COUNTS	2
+
 /* xattr entry (for both inline & shared xattrs) */
 struct erofs_xattr_entry {
 	__u8   e_name_len;      /* length of name */
-- 
2.19.1.6.gb485710b

