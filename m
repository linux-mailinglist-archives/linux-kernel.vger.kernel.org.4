Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8673554E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjFSLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjFSLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:02:58 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207701BC3;
        Mon, 19 Jun 2023 04:01:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VlV8FlL_1687172510;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlV8FlL_1687172510)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 19:01:51 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: add documentation for long xattr name prefixes feature
Date:   Mon, 19 Jun 2023 19:01:50 +0800
Message-Id: <20230619110150.107958-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Add documentation for the long xattr name prefixes feature, which has
landed upstream since v6.4.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 4654ee57c1d5..d3408d25165e 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -328,3 +328,50 @@ but it's easy to know the size of such pcluster is 1 lcluster as well.
 
 Since Linux v6.1, each pcluster can be used for multiple variable-sized extents,
 therefore it can be used for compressed data deduplication.
+
+Long xattr name prefixes
+------------------------
+In use cases together with overlayfs like Composefs model, there are xattrs with
+diverse xattr values but only a few common xattr names (trusted.overlay.redirect,
+trusted.overlay.digest, and maybe more in the future).  The existing predefined
+prefixes mechanism, e.g. {.e_name_index = EROFS_XATTR_INDEX_TRUSTED,
+.e_name = "overlay.redirect"} for "trusted.overlay.redirect", works inefficiently
+in both image size and runtime performance in such scenarios.
+
+The long xattr name prefixes feature is introduced (since Linux v6.4) to address
+this issue.  The general idea is that, apart from the existing predefined
+prefixes, the xattr entry could also refer to user specified long xattr name
+prefixes, e.g. "trusted.overlay." in above described use cases.
+
+When referring to a long xattr name prefix, the highest bit (bit 7) of
+erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6) as a whole
+represents the index of the referred long name prefix among all long xattr name
+prefixes.  Besides only the trailing part of the xattr name apart from the long
+xattr name prefix is stored in erofs_xattr_entry.e_name, which could be empty if
+the xattr name matches exactly as the long xattr name prefix.
+
+All long xattr prefixes are stored one by one in the packed inode as long as the
+packed inode exists, or meta inode otherwise.  The xattr_prefix_count (of
+on-disk superblock) represents the total number of the long xattr name prefixes,
+while (xattr_prefix_start * 4) indicates the start offset of long name prefixes
+in the packed/meta inode.  The long xattr name prefixes feature is not used when
+xattr_prefix_count is 0.
+
+Each long xattr name prefix (in packed/meta inode) is stored in the format:
+ALIGN({__le16 len, data}, 4), where len represents the total size of following
+data.  The data part, describing one long xattr name prefixes record, is
+represented by 'struct erofs_xattr_long_prefix', where base_index represents the
+index of the referred predefined short xattr name prefix, e.g.
+EROFS_XATTR_INDEX_TRUSTED for "trusted.overlay." long name prefix, while the
+infix string represents the string after stripping the short prefix, e.g.
+"overlay." for the above example.
+
+::
+
+         |-> aligned with 4 bytes               |-> aligned with 4 bytes
+     _________________________________________________________________________________
+    | .. | len | base_index | infix string | .. | len | base_index | infix string | ..
+    |____|_____|____________|______________|____|_____|____________|______________|___
+         ^     |<--  xattr_long_prefix  -->|          |<--  xattr_long_prefix  -->|
+	 .
+    + (xattr_prefix_start * 4) offset
-- 
2.19.1.6.gb485710b

