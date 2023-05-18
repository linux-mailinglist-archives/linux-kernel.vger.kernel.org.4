Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56949707828
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjERCqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjERCp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:45:59 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6E30EC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:45:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Viut.Cy_1684377955;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Viut.Cy_1684377955)
          by smtp.aliyun-inc.com;
          Thu, 18 May 2023 10:45:55 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] erofs: make the size of read data stored in buffer_ofs
Date:   Thu, 18 May 2023 10:45:49 +0800
Message-Id: <20230518024551.123990-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
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

Since now xattr_iter structures have been unified, make the size of the
read data stored in buffer_ofs.  Don't bother reusing buffer_size for
this use, which may be confusing.

This is in preparation for the following further cleanup.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 1e44aa108134..87d76ccea692 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -338,7 +338,7 @@ static int xattr_checkbuffer(struct erofs_xattr_iter *it,
 {
 	int err = it->buffer_size < value_sz ? -ERANGE : 0;
 
-	it->buffer_size = value_sz;
+	it->buffer_ofs = value_sz;
 	return !it->buffer ? 1 : err;
 }
 
@@ -371,7 +371,7 @@ static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 		if (ret != -ENOATTR)
 			break;
 	}
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
@@ -393,7 +393,7 @@ static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 		if (ret != -ENOATTR)
 			break;
 	}
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
-- 
2.19.1.6.gb485710b

