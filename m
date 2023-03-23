Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469726C5B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCWAKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCWAKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:10:33 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5332CD8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:10:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeS2z75_1679530192;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeS2z75_1679530192)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 08:09:53 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] erofs: simplify erofs_xattr_generic_get()
Date:   Thu, 23 Mar 2023 08:09:44 +0800
Message-Id: <20230323000949.57608-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
References: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
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

erofs_xattr_generic_get() won't be called from xattr handlers other than
user/trusted/security xattr handler, and thus there's no need of extra
checking.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/xattr.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index ab4517e5ec84..b83331a694f3 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -431,20 +431,9 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, void *buffer, size_t size)
 {
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
-
-	switch (handler->flags) {
-	case EROFS_XATTR_INDEX_USER:
-		if (!test_opt(&sbi->opt, XATTR_USER))
-			return -EOPNOTSUPP;
-		break;
-	case EROFS_XATTR_INDEX_TRUSTED:
-		break;
-	case EROFS_XATTR_INDEX_SECURITY:
-		break;
-	default:
-		return -EINVAL;
-	}
+	if (handler->flags == EROFS_XATTR_INDEX_USER &&
+	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
+		return -EOPNOTSUPP;
 
 	return erofs_getxattr(inode, handler->flags, name, buffer, size);
 }
-- 
2.19.1.6.gb485710b

