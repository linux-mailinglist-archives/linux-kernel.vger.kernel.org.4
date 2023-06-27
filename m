Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A274008C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjF0QNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjF0QNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:13:04 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC330DB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:12:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vm6X30h_1687882372;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm6X30h_1687882372)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 00:12:53 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Date:   Wed, 28 Jun 2023 00:12:40 +0800
Message-Id: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
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

Use memcpy_to_page() instead of open-coding them.

In addition, add a missing flush_dcache_page() even though almost all
modern architectures clear `PG_dcache_clean` flag for new file cache
pages so that it doesn't change anything in practice.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
preliminary tested with silesia dataset.

 fs/erofs/decompressor.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index ad53cf52d899..cfad1eac7fd9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -328,7 +328,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	const unsigned int interlaced_offset =
 		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
-	unsigned char *src, *dst;
+	u8 *src;
 
 	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		DBG_BUGON(1);
@@ -341,22 +341,19 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	}
 
 	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_local_page(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
-		       righthalf);
-		kunmap_local(dst);
-	}
+	if (rq->out[0])
+		memcpy_to_page(rq->out[0], rq->pageofs_out,
+			       src + interlaced_offset, righthalf);
 
 	if (outpages > inpages) {
 		DBG_BUGON(!rq->out[outpages - 1]);
 		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
-			dst = kmap_local_page(rq->out[outpages - 1]);
-			memcpy(dst, interlaced_offset ? src :
-					(src + righthalf), lefthalf);
-			kunmap_local(dst);
+			memcpy_to_page(rq->out[outpages - 1], 0, src +
+					(interlaced_offset ? 0 : righthalf),
+				       lefthalf);
 		} else if (!interlaced_offset) {
 			memmove(src, src + righthalf, lefthalf);
+			flush_dcache_page(rq->in[inpages - 1]);
 		}
 	}
 	kunmap_local(src);
-- 
2.24.4

