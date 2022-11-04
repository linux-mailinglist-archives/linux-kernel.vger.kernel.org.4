Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46F61900B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKDFkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKDFkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:40:36 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0FB275DB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 22:40:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VTvadhw_1667540430;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTvadhw_1667540430)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 13:40:31 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     zhujia.zj@bytedance.com, yinxin.x@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] erofs: get correct count for unmapped range in fscache mode
Date:   Fri,  4 Nov 2022 13:40:28 +0800
Message-Id: <20221104054028.52208-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unmapped range, the returned map.m_llen is zero, and thus the
calculated count is unexpected zero.

Prior to the refactoring introduced by commit 1ae9470c3e14 ("erofs:
clean up .read_folio() and .readahead() in fscache mode"), only the
readahead routine suffers from this. With the refactoring of making
.read_folio() and .readahead() calling one common routine, both
read_folio and readahead have this issue now.

Fix this by calculating count separately in unmapped condition.

Fixes: c665b394b9e8 ("erofs: implement fscache-based data readahead")
Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 83559008bfa8..260fa4737fc0 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -296,15 +296,16 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 		return PAGE_SIZE;
 	}
 
-	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
-	DBG_BUGON(!count || count % PAGE_SIZE);
-
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		count = len;
 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
 		return count;
 	}
 
+	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
+	DBG_BUGON(!count || count % PAGE_SIZE);
+
 	mdev = (struct erofs_map_dev) {
 		.m_deviceid = map.m_deviceid,
 		.m_pa = map.m_pa,
-- 
2.19.1.6.gb485710b

