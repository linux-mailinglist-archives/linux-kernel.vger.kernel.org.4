Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E525FE916
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJNGta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJNGt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:49:27 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762F1849B0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:49:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VS6n2Py_1665730157;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VS6n2Py_1665730157)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 14:49:22 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix up inplace decompression success rate
Date:   Fri, 14 Oct 2022 14:49:15 +0800
Message-Id: <20221014064915.8103-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partial decompression should be checked after updating length.
It's a new regression when introducing multi-reference pclusters.

Fixes: 2bfab9c0edac ("erofs: record the longest decompressed size in this round")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..2417d7b73622 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -812,15 +812,14 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	++spiltted;
 	if (fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 		fe->pcl->multibases = true;
-
-	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
-	    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
-	    fe->pcl->length == map->m_llen)
-		fe->pcl->partial = false;
 	if (fe->pcl->length < offset + end - map->m_la) {
 		fe->pcl->length = offset + end - map->m_la;
 		fe->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	}
+	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
+	    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
+	    fe->pcl->length == map->m_llen)
+		fe->pcl->partial = false;
 next_part:
 	/* shorten the remaining extent to update progress */
 	map->m_llen = offset + cur - map->m_la;
-- 
2.24.4

