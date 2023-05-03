Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C816F558B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjECKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjECKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:02:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F221A5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:02:24 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230503100222epoutp02d194794b92fef39f7a764f03a81667df~bmfAjG2I61591015910epoutp02F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:02:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230503100222epoutp02d194794b92fef39f7a764f03a81667df~bmfAjG2I61591015910epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108142;
        bh=o/y7pqqreOOyNd3ZbjyVH5zrhKm5j2wzOS45niAlYE4=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=qXa2dMLgA5s9fizPdZRKXZ2zfZHhrjlKptjJ0gAa0Yarx+cauEYQ7uDBJCjNxOg9S
         887PELrA/+Dc/BsnFO9x4sqBi5lAu+30b7U9Dk9tIPKByk2Q4The8pnDf4jChUIAwi
         vDT8IMPjkIy3nTTH/8yLOKdt0yxYyaXjZ/cbCsPg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503100222epcas2p3cc0da536fd36757f90a1f16245acd6a4~bmfAM6Xm80396103961epcas2p3w;
        Wed,  3 May 2023 10:02:22 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QBCDF3Rl4z4x9Q3; Wed,  3 May
        2023 10:02:21 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-ca-6452312d7a18
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.A9.03265.D2132546; Wed,  3 May 2023 19:02:21 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 02/15] block: blk-integiry: add helper functions for
 bio_integrity_add_page
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
Message-ID: <20230503100220epcms2p33e69fd7d5f04b305c621799792e8155f@epcms2p3>
Date:   Wed, 03 May 2023 19:02:20 +0900
X-CMS-MailID: 20230503100220epcms2p33e69fd7d5f04b305c621799792e8155f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmua6uYVCKwZK/Ihar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ3x
        pqebqWC9aMX+Bd/YGxi7BLsYOTgkBEwk7i5n72Lk4hAS2MEo8WTRN2aQOK+AoMTfHcJdjJwc
        wgKxEoeufmIGsYUElCTOrZnFCFIiLGAgcavXHCTMJqAn8XPJDDYQW0RgNZNE8/MaEFtCgFdi
        RvtTFghbWmL78q2MIDangJ/E4w23GCHiGhI/lvUyQ9iiEjdXv2WHsd8fmw9VIyLReu8sVI2g
        xIOfu6HikhKHDn1lg/gkX2LDgUCIcI3E2+UHoEr0Ja51bAQ7gVfAV+LjuRlg41kEVCVu3e1k
        g6hxkdjR0c8KYjMLyEtsfzsHHAjMApoS63fpQ0xXljhyiwWigk+i4/BfdpgHGzb+xsreMe8J
        E0SrmsSiJiOIsIzE18Pz2ScwKs1CBPIsJGtnIaxdwMi8ilEstaA4Nz212KjAEB6tyfm5mxjB
        CVHLdQfj5Lcf9A4xMnEwHmKU4GBWEuH9UOiXIsSbklhZlVqUH19UmpNafIjRFOjhicxSosn5
        wJScVxJvaGJpYGJmZmhuZGpgriTOK217MllIID2xJDU7NbUgtQimj4mDU6qBqUC+lfVR5ZP/
        03h1GOM+pq052mrLcMDUyuTLsdUXd+tlnWE6oHF8AXPqZuYt/K3qcQLqU4rZXNfzbLCyLBBb
        eob7wClr9ZRZ3JKdOy+wPt/toTHXLfuM87/YG7O/nSydzv7q0d4S2bdPaoJmLfn5s2n76++H
        zh5++TRvT+JyLj8NOfb1wvd/73/em11wup3RPIohX+bn7a+7nTsqXlzdJiXFmZdtsvbuB8kD
        O2OmNfnvunVHd82Xw3e5jNdvDwi6phS7+uWDhHMWDJUnXntqJVnOmLujQHGvRmBywM6PlTPZ
        c9fWCj2eMoXfYqvZ+dN+z64/2CUVyrsyOPHk9TsXbct6TkWmzdvveTr36V2lcAklluKMREMt
        5qLiRAABKXjuEQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p3>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions that use the hardware limit to merge the page with
integrity's bio_vec.
Using the added functions, the physically continuous pages are made of
one bio_vec.

Previously, physically continuous pages were not created as one
bio_vec, but separately created.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb491661..06b6a2c178d2 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -111,6 +111,64 @@ void bio_integrity_free(struct bio *bio)
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 
+/**
+ * bip_full - check if the bip is full
+ * @bip:	bip to check
+ * @len:	length of one segment to be added
+ *
+ * Return true if @bip is full and one segment with @len bytes can't be
+ * added to the bip, otherwise return false
+ */
+static inline bool bip_full(struct bio_integrity_payload *bip, unsigned int len)
+{
+	if (bip->bip_vcnt >= bip->bip_max_vcnt)
+		return true;
+	if (bip->bip_iter.bi_size > UINT_MAX - len)
+		return true;
+	return false;
+}
+
+/**
+ * bip_try_merge_hw_seg - try to merge a page into a segment, while
+ * obeying the hardware segment size limit
+ * @q:		the target queue
+ * @bip:	bip to check
+ * @page:	page containing integrity metadata
+ * @len:	number of bytes of integrity metadata in page
+ * @offset:	start offset within page
+ * @same_page:  return if the segment has been merged inside the same page
+ *
+ * Return true if @page is merged to @bip, otherwise return false
+ */
+static bool bip_try_merge_hw_seg(struct request_queue *q,
+				 struct bio_integrity_payload *bip,
+				 struct page *page, unsigned int len,
+				 unsigned int offset, bool *same_page)
+{
+	struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
+	unsigned long mask = queue_segment_boundary(q);
+	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
+	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
+
+	if ((addr1 | mask) != (addr2 | mask))
+		return false;
+	if (bv->bv_len + len > queue_max_segment_size(q))
+		return false;
+
+	if (bip->bip_vcnt > 0) {
+		if (bio_page_is_mergeable(bv, page, len, offset, same_page)) {
+			if (bip->bip_iter.bi_size > UINT_MAX - len) {
+				*same_page = false;
+				return false;
+			}
+			bv->bv_len += len;
+			bip->bip_iter.bi_size += len;
+			return true;
+		}
+	}
+	return false;
+}
+
 /**
  * bio_integrity_add_page - Attach integrity metadata
  * @bio:	bio to update
-- 
2.34.1
