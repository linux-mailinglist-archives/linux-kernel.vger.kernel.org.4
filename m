Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC76FD9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjEJIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjEJIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:50:23 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCE10C0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:50:21 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230510085020epoutp048771002cb7c6498d50e1e50e9f6a6f16~dvBHIi8TV2618026180epoutp04b
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:50:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230510085020epoutp048771002cb7c6498d50e1e50e9f6a6f16~dvBHIi8TV2618026180epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708620;
        bh=2uIhNIvaUDqD62d3MZOJy319yIzbYqTLMuJPQ32qIts=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=HI58pAC3T92fLBNh14/TrCp6S4sYxewN8NaQ5IjE1qp9pRn8N1+ywN3qcn55q6IMh
         qt9P/uVbTOlqgcxAtCO1s1jq4DiK3zKnPG9nk34PpvAzXD4Pp7QWzoFp0lxWBGHhsl
         rxb5Xjo3dCPxplkaCmRi2SIuEHPmikRoQhX6deOw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230510085019epcas2p2a3e50c925ac64ea08544707ad1f82bc2~dvBGjVMiL2936129361epcas2p2G;
        Wed, 10 May 2023 08:50:19 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QGTHv0bMRz4x9Pv; Wed, 10 May
        2023 08:50:19 +0000 (GMT)
X-AuditID: b6c32a47-c29ff70000002007-32-645b5acac020
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.95.08199.ACA5B546; Wed, 10 May 2023 17:50:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 03/14] block: bio-integrity: cleanup bio_integrity_prep
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
Message-ID: <20230510085018epcms2p5a3830e37b13e9a6799298050abdc77dc@epcms2p5>
Date:   Wed, 10 May 2023 17:50:18 +0900
X-CMS-MailID: 20230510085018epcms2p5a3830e37b13e9a6799298050abdc77dc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmqe7pqOgUg9tZFqvv9rNZvDykabFy
        9VEmi97+rWwWi25sY7L423WPyWLSoWuMFk+vzmKy2HtL2+LyrjlsFsuP/2OyWPf6PYvF7x9z
        2Bx4Pc7f28jisXmFlsfls6Uem1Z1snlMWHSA0WP3zQY2j97md2weH5/eYvHo27KK0ePzJjmP
        9gPdTAHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUDXKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0M
        jEyBChOyMz4tWc1ecJKv4uqxGywNjA+4uxg5OCQETCSOXGPtYuTkEBLYwSixcbIkSJhXQFDi
        7w5hEFNYwEuiYZ4SRIWSxLk1sxghwgYSt3rNQcJsAnoSP5fMYOti5OIQEdjJIvH9/lFGkISE
        AK/EjPanLBC2tMT25VvBejkF/CRaH1tChDUkfizrZYawRSVurn7LDmO/PzYfaoyIROu9s1A1
        ghIPfu6GiktKHDr0lQ3ij3yJDQcCIcI1Em+XH4Aq0Ze41rER7AJeAV+Jh+dWsIHYLAKqEhvX
        bIK6zEWie8kqsPHMAvIS29/OYQYZySygKbF+lz7EdGWJI7dYICr4JDoO/2WH+a9h42+s7B3z
        njBBtKpJLGoyggjLSHw9PJ99AqPSLEQYz0KydhbC2gWMzKsYxVILinPTU4uNCozhkZqcn7uJ
        EZyAtdx3MM54+0HvECMTB+MhRgkOZiURXu/QqBQh3pTEyqrUovz4otKc1OJDjKZAD09klhJN
        zgfmgLySeEMTSwMTMzNDcyNTA3MlcV5p25PJQgLpiSWp2ampBalFMH1MHJxSDUw8915FzQjf
        ZZTvqPxt/t75hjks68/o/pVYu31L13cbgRMp+8pzHxUfMPI78oVlMcP8fWfzZswJmV3fvEws
        QbYuo9DifrBhpZUTyxfbqbLhZ9p75vv+qF6pcj/CTHixxd2O2dZ+ivs3B3hrb0tkmexWkFw3
        e42SmOJjr86QyrMX926s2xezmePTkdpck4NSawW5/n3a0FVb+Wc+80yF9Sa8krUz2jnYBU5z
        M0Q/zhM0M1kyifU/B895sQDOuq8eZp36LWdWG8tZm00K0ZgbIMgQoMAlsV3pXkGQ1H9/lcf7
        KkpO2Mu+4S/wUDhuqZA68/GB3QK5j9ScNPRYKz75pjszHCtYpm6bzyfzqvWlEktxRqKhFnNR
        cSIAP0C7YEkEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p5>
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

If a problem occurs in the process of creating an integrity payload, the
status of bio is always BLK_STS_RESOURCE.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 20444ec447cb..c49deed67bb2 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -245,7 +245,6 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
 	unsigned int intervals;
-	blk_status_t status;
 
 	if (!bi)
 		return true;
@@ -274,7 +273,6 @@ bool bio_integrity_prep(struct bio *bio)
 	/* Allocate kernel buffer for protection data */
 	len = intervals * bi->tuple_size;
 	buf = kmalloc(len, GFP_NOIO);
-	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
@@ -289,7 +287,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (IS_ERR(bip)) {
 		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
-		status = BLK_STS_RESOURCE;
 		goto err_end_io;
 	}
 
@@ -313,7 +310,6 @@ bool bio_integrity_prep(struct bio *bio)
 		if (bio_integrity_add_page(bio, virt_to_page(buf),
 					   bytes, offset) < bytes) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
 
@@ -332,10 +328,9 @@ bool bio_integrity_prep(struct bio *bio)
 	return true;
 
 err_end_io:
-	bio->bi_status = status;
+	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
 	return false;
-
 }
 EXPORT_SYMBOL(bio_integrity_prep);
 
-- 
2.34.1
