Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAE6E1C83
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNGS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDNGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:18:25 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808FB72B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:18:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vg2OjnN_1681453090;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vg2OjnN_1681453090)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 14:18:11 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: fix potential overflow calculating xattr_isize
Date:   Fri, 14 Apr 2023 14:18:10 +0800
Message-Id: <20230414061810.6479-1-jefflexu@linux.alibaba.com>
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

Given on-disk i_xattr_icount is 16 bits and xattr_isize is calculated
from i_xattr_icount multiplying 4, xattr_isize has a theoretical maximum
of 256K (64K * 4).

Thus declare xattr_isize as unsigned int to avoid the potential overflow.

Fixes: bfb8674dc044 ("staging: erofs: add erofs in-memory stuffs")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8a563374b518..c86241a32ab3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -306,7 +306,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
-	unsigned short xattr_isize;
+	unsigned int xattr_isize;
 
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
-- 
2.19.1.6.gb485710b

