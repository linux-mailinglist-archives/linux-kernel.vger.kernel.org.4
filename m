Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2C6F5590
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjECKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjECKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:06:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FCAE43
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:06:43 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503100641epoutp03f3afe4a3e1d9490e030e9a7f7cae59ae~bmiyBd5p-1770017700epoutp03a
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:06:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503100641epoutp03f3afe4a3e1d9490e030e9a7f7cae59ae~bmiyBd5p-1770017700epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108401;
        bh=1WhTIW3VLo5qDfXJ/0YEchijZafqk1XB4OYfht1gpEI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=DcUF9wb+SnzJEz0OCAcXzgBVuPqyetKe4JbMFY8vPe4dDVOcwtWFXmfvjWgTT0fD+
         0n0DnSrhmk1irqyipV8Cpy2JUMtQcg1kF8K4FjTH7hlJ3PjqOrZmj+mx0WY5HjyrY0
         ZqP/BT9TUKFeYa6pOcJ8Z/bjUdJtAxb8oseVE8Ac=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230503100640epcas2p4a916461813c8ba6adefad44e524d4480~bmixIQo-G2064220642epcas2p4I;
        Wed,  3 May 2023 10:06:40 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QBCKD1frvz4x9Py; Wed,  3 May
        2023 10:06:40 +0000 (GMT)
X-AuditID: b6c32a47-c29ff70000002007-a2-645232306dac
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.6D.08199.03232546; Wed,  3 May 2023 19:06:40 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 03/15] block: bio-integrity: modify bio_integrity_add_page()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
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
Message-ID: <20230503100639epcms2p5069df7346cfce6db9718b9adf7cc3718@epcms2p5>
Date:   Wed, 03 May 2023 19:06:39 +0900
X-CMS-MailID: 20230503100639epcms2p5069df7346cfce6db9718b9adf7cc3718
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmha6BUVCKwc73nBar7/azWbw8pGmx
        cvVRJove/q1sFpMOXWO0eHp1FpPF3lvaFpd3zWGzWH78H5PFutfvWRy4PM7f28jicflsqcem
        VZ1sHrtvNrB59Da/Y/P4+PQWi0ffllWMHp83yQVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzng0/TJTQatUxe69M5kaGM+JdDFyckgI
        mEgcWrCMtYuRi0NIYAejxMZze4EcDg5eAUGJvzuEQWqEBXwkTj38xQpiCwkoSZxbM4sRpERY
        wEDiVq85SJhNQE/i55IZbCBjRAQWMUtsmjeZDWI+r8SM9qcsELa0xPblWxlBbE4BP4nHG24x
        QsQ1JH4s62WGsEUlbq5+yw5jvz82H6pGRKL13lmoGkGJBz93Q8UlJQ4d+soGco+EQL7EhgOB
        EOEaibfLD0CV6Etc69gIdgKvgK/ElwPtYKexCKhKfP8wCWqki8TWg+uYQGxmAXmJ7W/nMIOM
        ZBbQlFi/Sx9iurLEkVssEBV8Eh2H/7LDPNiw8TdW9o55T5ggWtUkFjUZQYRlJL4ens8+gVFp
        FiKUZyFZOwth7QJG5lWMYqkFxbnpqcVGBcbwiE3Oz93ECE6oWu47GGe8/aB3iJGJg/EQowQH
        s5II74dCvxQh3pTEyqrUovz4otKc1OJDjKZAD09klhJNzgem9LySeEMTSwMTMzNDcyNTA3Ml
        cV5p25PJQgLpiSWp2ampBalFMH1MHJxSDUybZz9IyQwWv3lm9qH0jnRNjpudp3n+J//rT5ky
        uTfCybn9bnio5V+1xj2Z3p/u/w+XjVl7P9VNMOJuz6Fc5lV7Zkz5GC14KDjvxcXKYp6vzSe5
        M9tfu3IpLAjveb/Uqnhivs7R15LWRZPn9fnuXBi3Q2Vvv43/pZCI15ePJP7eJ8NvsOxnve67
        TEO++HNxSpIGrvvDy3omz+C+EZP4qovjrZXAjohNYY17LtQtPB/0eIlJwMRf2atOcE+r2Wdv
        NvupfNzPg2EuF46ft1KesFLndGXbD2Gbf64/NE7xzC1NirliaheifyQhdIfsyq3vhHoCHJ9z
        XDnOrtKx1X5b/TeLjqAlj8rd85etex+zS02JpTgj0VCLuag4EQDrnXkoMQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p5>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the constraints of hardware, the physically continuous pages
were to be composed of one bio_vec.

Previously, bio_vec was created separately for each page entering the
parameter.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 06b6a2c178d2..74cf9933c285 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -176,25 +176,45 @@ static bool bip_try_merge_hw_seg(struct request_queue *q,
  * @len:	number of bytes of integrity metadata in page
  * @offset:	start offset within page
  *
- * Description: Attach a page containing integrity metadata to bio.
+ * Add a page containing integrity metadata to a bio while respecting
+ * the hardware max_sectors, max_segment and gap limitations.
  */
 int bio_integrity_add_page(struct bio *bio, struct page *page,
 			   unsigned int len, unsigned int offset)
 {
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
+	if (((bip->bip_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
+		return 0;
+
+	if (bip->bip_vcnt > 0) {
+		struct bio_vec *bv;
+		bool same_page = false;
+
+		if (bip_try_merge_hw_seg(q, bip, page, len, offset, &same_page))
+			return len;
+
+		/*
+		 * If the queue doesn't support SG gaps and adding this segment
+		 * would create a gap, disallow it.
+		 */
+		bv = &bip->bip_vec[bip->bip_vcnt - 1];
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
+			return 0;
+	}
+
+	if (bip_full(bip, len)) {
 		printk(KERN_ERR "%s: bip_vec full\n", __func__);
 		return 0;
 	}
 
-	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
-			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
+	if (bip->bip_vcnt >= queue_max_integrity_segments(q))
 		return 0;
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
+	bip->bip_iter.bi_size += len;
 
 	return len;
 }
@@ -307,7 +327,6 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
-	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
@@ -316,7 +335,6 @@ bool bio_integrity_prep(struct bio *bio)
 	/* Map it */
 	offset = offset_in_page(buf);
 	for (i = 0 ; i < nr_pages ; i++) {
-		int ret;
 		bytes = PAGE_SIZE - offset;
 
 		if (len <= 0)
@@ -325,18 +343,13 @@ bool bio_integrity_prep(struct bio *bio)
 		if (bytes > len)
 			bytes = len;
 
-		ret = bio_integrity_add_page(bio, virt_to_page(buf),
-					     bytes, offset);
-
-		if (ret == 0) {
+		if (bio_integrity_add_page(bio, virt_to_page(buf),
+					   bytes, offset) < bytes) {
 			printk(KERN_ERR "could not attach integrity payload\n");
 			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
 
-		if (ret < bytes)
-			break;
-
 		buf += bytes;
 		len -= bytes;
 		offset = 0;
-- 
2.34.1
