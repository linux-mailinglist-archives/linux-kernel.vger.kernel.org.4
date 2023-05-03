Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7776D6F5584
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjECKBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjECKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:00:58 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C8B4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:00:53 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503100051epoutp03b4726934c3085c40f26e63077f623519~bmdr5pyeX1324113241epoutp03o
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:00:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503100051epoutp03b4726934c3085c40f26e63077f623519~bmdr5pyeX1324113241epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108051;
        bh=Lh/JoKhqwHvgqNqdwOhUU4xB3qjfNA9DOJp/qwOaGTM=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=SwzA/pbmu8lEKPrQtd05GBW8GO8WrxrE1PF4buYVMm7KDgsbq82mB1d+NZ0zy0QaA
         tilrDndq0ZDBZkD69z2qDxnWT38yJhyGoi/SO3o0F8MmZuEl3Lk+IyJ9q3nRK5Y9ly
         ZJSEzifAVj0JCoq4tjLqdZ1clswtOg743ZjWXtRQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230503100051epcas2p4226eb26512691c9a5b0fe5e8ab873761~bmdrfzeS-1761217612epcas2p4q;
        Wed,  3 May 2023 10:00:51 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBCBV3zyxz4x9Px; Wed,  3 May
        2023 10:00:50 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-a4-645230d274be
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.89.08199.2D032546; Wed,  3 May 2023 19:00:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 01/15] block: bio: rename page_is_mergeable to
 bio_page_is_mergeable and make non-static
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503100049epcms2p2c830ebb7b50beaa2663abd0cd274293c@epcms2p2>
Date:   Wed, 03 May 2023 19:00:49 +0900
X-CMS-MailID: 20230503100049epcms2p2c830ebb7b50beaa2663abd0cd274293c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhe4lg6AUg797ZC1W3+1ns3h5SNNi
        5eqjTBa9/VvZLPbe0ra4vGsOm8Xy4/+YHNg9Lp8t9dh9s4HN4+PTWywefVtWMXp83iQXwBqV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITuj
        /fc55oKzAhXP775hbWDcx9vFyMkhIWAisXPNPZYuRi4OIYEdjBJXt/9n7WLk4OAVEJT4u0MY
        pEZYIEti69Kb7CC2kICSxLk1sxhBSoQFDCRu9ZqDhNkE9CR+LpnBBmKLCKxmkmh+XgMxnldi
        RvtTFghbWmL78q2MIDangJ/E4w23GCHiGhI/lvUyQ9iiEjdXv2WHsd8fmw9VIyLReu8sVI2g
        xIOfu6HikhKHDn1lAzlHQiBfYsOBQIhwjcTb5QegSvQlrnVsBDuBV8BXYtHxVrDxLAKqEvN7
        ZkCtcpGY9+UxE4jNLCAvsf3tHGaQkcwCmhLrd+lDTFeWOHKLBaKCT6Lj8F92mAcbNv7Gyt4x
        7wkTRKuaxKImI4iwjMTXw/PZJzAqzUIE8iwka2chrF3AyLyKUSy1oDg3PbXYqMAYHq/J+bmb
        GMEpUct9B+OMtx/0DjEycTAeYpTgYFYS4f1Q6JcixJuSWFmVWpQfX1Sak1p8iNEU6OGJzFKi
        yfnApJxXEm9oYmlgYmZmaG5kamCuJM4rbXsyWUggPbEkNTs1tSC1CKaPiYNTqoEp42zr9p+F
        E1Qud2pKKRwoCN/rYnhmf/unX2U5nx/wnFW/63jDv1Jgsd131ud5VevUfT06eXZPk/34f8uZ
        /03muycamLRLFTmobtv8I4xP+HfEhb1nHzbkKLOxntQ1i+TXUvjUbPNkntr28NqWS9oXH+3r
        EFZ8IdZSdCcx2yEw+cyc2Wv2tS3VfTzj6c4dRwzrq5auNFOad+xSkdPHFyuq6x7uD72qNfdd
        qDHbskU3rf/vZpp3duXqtK/yPnOTuTUsWr4Ymy6P7dWUl179qTTgnUmh2Nb1c9avmbBep/fM
        1J38exxag2Kzo33LZb0+K6gknLf/GHWr6FV2Rfxka9GJ+fa1ZcY5py7rP562Ri9LiaU4I9FQ
        i7moOBEA7Q64whIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p2>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_is_meargeable() can be used to merge the page to the bio_vec of
bio's integrity payload. For this, the static was removed.

There is a page_is_mergeable() in F2FS filesystem, so the name was changed
to bio_page_is_mergeable.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio.c         | 8 ++++----
 include/linux/bio.h | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fd11614bba4d..3e5ab59502e2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -903,9 +903,9 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	return false;
 }
 
-static inline bool page_is_mergeable(const struct bio_vec *bv,
-		struct page *page, unsigned int len, unsigned int off,
-		bool *same_page)
+bool bio_page_is_mergeable(const struct bio_vec *bv, struct page *page,
+			   unsigned int len, unsigned int off,
+			   bool *same_page)
 {
 	size_t bv_end = bv->bv_offset + bv->bv_len;
 	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
@@ -951,7 +951,7 @@ static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (page_is_mergeable(bv, page, len, off, same_page)) {
+		if (bio_page_is_mergeable(bv, page, len, off, same_page)) {
 			if (bio->bi_iter.bi_size > UINT_MAX - len) {
 				*same_page = false;
 				return false;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..b53a595b519a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -418,6 +418,9 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		gfp_t gfp, struct bio_set *bs);
 int bio_init_clone(struct block_device *bdev, struct bio *bio,
 		struct bio *bio_src, gfp_t gfp);
+bool bio_page_is_mergeable(const struct bio_vec *bv, struct page *page,
+			   unsigned int len, unsigned int off,
+			   bool *same_page);
 
 extern struct bio_set fs_bio_set;
 
-- 
2.34.1
