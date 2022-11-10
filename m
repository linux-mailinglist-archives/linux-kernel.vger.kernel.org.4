Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB0623CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiKJHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKJHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:40:28 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799E615F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:40:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VURxxwo_1668066023;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VURxxwo_1668066023)
          by smtp.aliyun-inc.com;
          Thu, 10 Nov 2022 15:40:24 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: enable large folio in device-based mode
Date:   Thu, 10 Nov 2022 15:40:23 +0800
Message-Id: <20221110074023.8059-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable large folio in device-based mode. Then the radahead routine will
pass down large folio containing multiple pages.

Enable this feature for non-compressed format for now, until the
compression part supports large folio later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
I have tested it under workload of Linux compiling. I know it's not a
perfect workload testing this feature, because large folio is less
likely hit in this case since source files are generally small. But I
indeed observed large folios (e.g. 16 pages) by peeking
readahead_count(rac) in erofs_readahead().
---
 fs/erofs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ad2a82f2eb4c..e457b8a59ee7 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -295,6 +295,8 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	if (!erofs_is_fscache_mode(inode->i_sb))
+		mapping_set_large_folios(inode->i_mapping);
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (erofs_is_fscache_mode(inode->i_sb))
 		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-- 
2.19.1.6.gb485710b

