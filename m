Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17F7702ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbjEOKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbjEOKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:39:47 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B070619D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:39:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vigv17V_1684147181;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vigv17V_1684147181)
          by smtp.aliyun-inc.com;
          Mon, 15 May 2023 18:39:42 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] erofs: fix null-ptr-deref caused by erofs_xattr_prefixes_init
Date:   Mon, 15 May 2023 18:39:41 +0800
Message-Id: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fragments and dedupe share one feature bit, and thus packed inode may not
exist when fragment feature bit (dedupe feature bit exactly) is set, e.g.
when deduplication feature is in use while fragments feature is not.  In
this case, sbi->packed_inode could be NULL while fragments feature bit
is set.

Fix this by accessing packed inode only when it exists.

Reported-by: syzbot+902d5a9373ae8f748a94@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=902d5a9373ae8f748a94
Fixes: 9e382914617c ("erofs: add helpers to load long xattr name prefixes")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2: polish the commit message (Gao Xiang)
---
 fs/erofs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index cd80499351e0..bbfe7ce170d2 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -675,7 +675,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	if (!pfs)
 		return -ENOMEM;
 
-	if (erofs_sb_has_fragments(sbi))
+	if (sbi->packed_inode)
 		buf.inode = sbi->packed_inode;
 	else
 		erofs_init_metabuf(&buf, sb);
-- 
2.19.1.6.gb485710b

