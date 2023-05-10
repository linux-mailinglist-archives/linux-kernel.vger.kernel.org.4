Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82596FD9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbjEJIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEJIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:47:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB4E69
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:47:01 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230510084659epoutp03253b0f4dffb06895a9427620023d0d9b~du_MHoXQ61154311543epoutp03A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:46:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230510084659epoutp03253b0f4dffb06895a9427620023d0d9b~du_MHoXQ61154311543epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708419;
        bh=10R6BCaaEqGyGL0MgOrzq5i+lOe75yKt/yscCIlKzXQ=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=kjPo5RgI9b97q13fvO9lOvxgeZaXd9IhaDZDX98t7W/lbPw2sSRVFHTnTQkSv+fJ/
         ethYx/0GM+YJewT5Qi3HbVXUEqErBALoiYREWkbwjCSyByEpNt5HyMQbnIISEQjr3Y
         cjoK0SS/8yDqh+8QDPIXsSto7/4YrWi3MBebViy8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510084658epcas2p1e0dd52b73331be2c655a782cc2f8c05d~du_LkEh-T1606116061epcas2p1Z;
        Wed, 10 May 2023 08:46:58 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGTD20lk4z4x9Px; Wed, 10 May
        2023 08:46:58 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-7d-645b5a01987d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.F3.08199.10A5B546; Wed, 10 May 2023 17:46:58 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 01/14] block: bio: separation to reuse a part of the
 function
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230510084657epcms2p69b0c426899251151a5cc7d84cedeacc7@epcms2p6>
Date:   Wed, 10 May 2023 17:46:57 +0900
X-CMS-MailID: 20230510084657epcms2p69b0c426899251151a5cc7d84cedeacc7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmuS5TVHSKwbnVzBar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjOW91kULJOsOPjMqoFxhkgXIyeHhICJxL/n/1m6GLk4hAR2MErs3DaZtYuRg4NX
        QFDi7w5hkBphgSCJCT9nsoLYQgJKEufWzGIEKREWMJC41WsOEmYT0JP4uWQGG8gYEYGdLBLf
        7x9lhJjPKzGj/SkLhC0tsX35VrBeTgE/idbHlhBhDYkfy3qZIWxRiZur37LD2O+PzYcaIyLR
        eu8sVI2gxIOfu6HikhKHDn1lAxkpIZAvseFAIES4RuLt8gNQJfoS1zo2gl3AK+ArcW/nHrA4
        i4CqxPG/LawQNS4Sc7fvBFvLLCAvsf3tHGaQkcwCmhLrd+lDTFeWOHKLBaKCT6Lj8F92mP8a
        Nv7Gyt4x7wkTRKuaxKImI4iwjMTXw/PZJzAqzUIE8iwka2chrF3AyLyKUSy1oDg3PbXYqMAY
        HqvJ+bmbGMFJWMt9B+OMtx/0DjEycTAeYpTgYFYS4fUOjUoR4k1JrKxKLcqPLyrNSS0+xGgK
        9PBEZinR5HxgHsgriTc0sTQwMTMzNDcyNTBXEueVtj2ZLCSQnliSmp2aWpBaBNPHxMEp1cBU
        3q4sEHqrmXXFz+LXMQnm/Z/7f8zcUmPU1j87/kFW5smlZydvuFidwZ24N8DSfc17TTe7ow0b
        e/fr9V0svvr42N+uYsMMkwmPDl+O/t3Zdll9zaUXErvf+NZ9CrzI3vGsZSbL1AXaNZY/Jz+0
        7npRnJHwYlnUj4ht7JoZalOvX3E3nv2ycrXOOrX3y96dFfUsdO0tDKtsy0h2v7XyoLeWleTs
        0Oc73vfqvlsqmLTyfu+UIyk6zy2Knj6XLLkee6C0hP+d2y/ZgF9fvItZW65pHYrLXvn+9gu2
        +3JphSGbDJc/iN2pPT/j07xtzdwT7pp9aZ5fzuJWt+zd1QTun8UHnTXPhdx1NP9Rcu71dsaJ
        SizFGYmGWsxFxYkAmMa9d0sEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__bio_try_merge_page(), which is called by the general page-add functions
and the function considering the constraints of hw, was separated.

Condition tests for general page-add functions were performed in
bio_try_merge_page(). And when the parameters of __bio_try_merge_page()
were changed, there were fewer functions affected by this.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fd11614bba4d..1be17dea603a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -926,8 +926,28 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
+static bool __bio_try_merge_page(struct bio *bio, struct page *page,
+				 unsigned int len, unsigned int off,
+				 bool *same_page)
+{
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+	if (!page_is_mergeable(bv, page, len, off, same_page))
+		return false;
+
+	if (bio->bi_iter.bi_size > UINT_MAX - len) {
+		*same_page = false;
+		return false;
+	}
+
+	bv->bv_len += len;
+	bio->bi_iter.bi_size += len;
+
+	return true;
+}
+
 /**
- * __bio_try_merge_page - try appending data to an existing bvec.
+ * bio_try_merge_page - try appending data to an existing bvec.
  * @bio: destination bio
  * @page: start page to add
  * @len: length of the data to add
@@ -942,26 +962,17 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
  *
  * Return %true on success or %false on failure.
  */
-static bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page)
+static bool bio_try_merge_page(struct bio *bio, struct page *page,
+			       unsigned int len, unsigned int off,
+			       bool *same_page)
 {
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return false;
 
-	if (bio->bi_vcnt > 0) {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
-				*same_page = false;
-				return false;
-			}
-			bv->bv_len += len;
-			bio->bi_iter.bi_size += len;
-			return true;
-		}
-	}
-	return false;
+	if (!bio->bi_vcnt)
+		return false;
+
+	return __bio_try_merge_page(bio, page, len, off, same_page);
 }
 
 /*
@@ -1129,7 +1140,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
-	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+	if (!bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (bio_full(bio, len))
 			return 0;
 		__bio_add_page(bio, page, len, offset);
@@ -1199,7 +1210,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
-	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+	if (!bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		__bio_add_page(bio, page, len, offset);
 		return 0;
 	}
-- 
2.34.1
