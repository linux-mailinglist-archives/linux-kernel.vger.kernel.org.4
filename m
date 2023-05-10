Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4D6FDA31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjEJI63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbjEJI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:58:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8BD12E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:58:24 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230510085822epoutp01535714262ecf6126964473e60f05414c~dvIIgINYU2057320573epoutp01I
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:58:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230510085822epoutp01535714262ecf6126964473e60f05414c~dvIIgINYU2057320573epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683709102;
        bh=ZfhC85BvKxKIuur1CoeZsaWeIlAnBRlkMNE/o0TIGEU=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=BNuUSbKPs0guXiN6nW9GD9PbT17ucuEwPrqtqZ9w0U/OLfg9Gjf37ZJVDiLVlju9F
         4Yu0KzlCNiRZ+d4Hh6ztEUy0UynxgXh4n/LSDotMqV4AnvKiFEVCn2LlZKnOXq3Ra/
         09i07CPwT9nF6WpxVxaSE2Up7tKZg1Im/CiG5R1w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510085822epcas2p12468ee6a15f4aa3e73bbe3afef6270ba~dvIIGsWkw2929929299epcas2p18;
        Wed, 10 May 2023 08:58:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QGTT95Bp6z4x9Q3; Wed, 10 May
        2023 08:58:21 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-40-645b5cadb711
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.5A.08199.DAC5B546; Wed, 10 May 2023 17:58:21 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 10/14] block: blk-integrity: change how to find the
 number of integrity of bio
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
Message-ID: <20230510085820epcms2p899d5cfca9a0aca4bd6654d9d0189b6f8@epcms2p8>
Date:   Wed, 10 May 2023 17:58:20 +0900
X-CMS-MailID: 20230510085820epcms2p899d5cfca9a0aca4bd6654d9d0189b6f8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhe7amOgUg+ePNSxW3+1ns3h5SNNi
        5eqjTBa9/VvZLBbd2MZk8bfrHpPFpEPXGC2eXp3FZLH3lrbF5V1z2CyWH//HZLHu9XsWi98/
        5rA58Hqcv7eRxWPzCi2Py2dLPTat6mTzmLDoAKPH7psNbB69ze/YPD4+vcXi0bdlFaPH501y
        Hu0HupkCuKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGdcnXOdtWADZ0Xn6lvMDYzP2LsYOTkkBEwkrh99w9rFyMUhJLCDUWLj+5NACQ4O
        XgFBib87hEFqhAWSJWbP/MoEYgsJKEmcWzOLEaREWMBA4lavOUiYTUBP4ueSGWwgY0QEdrJI
        fL9/lBFiPq/EjPanLBC2tMT25VvBejkF/CRaH1tChDUkfizrZYawRSVurn7LDmO/PzYfaoyI
        ROu9s1A1ghIPfu6GiktKHDr0lQ1kpIRAvsSGA4EQ4RqJt8sPQJXoS1zr2Ah2Aa+Ar8TbKVPB
        xrMIqEq0r2uAWuUiseLJM1YQm1lAXmL72znMICOZBTQl1u/Sh5iuLHHkFgtEBZ9Ex+G/7DD/
        NWz8jZW9Y94TJohWNYlFTUYQYRmJr4fns09gVJqFCORZSNbOQli7gJF5FaNYakFxbnpqsVGB
        MTxek/NzNzGCE7GW+w7GGW8/6B1iZOJgPMQowcGsJMLrHRqVIsSbklhZlVqUH19UmpNafIjR
        FOjhicxSosn5wFyQVxJvaGJpYGJmZmhuZGpgriTOK217MllIID2xJDU7NbUgtQimj4mDU6qB
        SYh1w+eev8+CP0/KzI2/9L3IRVjGjmNuNd8TXbFfr461B51fu37L3MtHj1vc37roQrrvlk/Z
        t1enzvywhSlxPh+XTytLo0hC+fUHJvO/rxd7vkworVOwTP7u1pr8O/XBx/0/lRUu80qc/Fvg
        9OKs4iu+4vybK1SFpyrb9kxLZDGfIbfUTmOezRZOm69nY05MClu25dCf7PB19t6ma06cLrj6
        /cDe3zmqhfuOf3N7m7xsz+NTZ29yacvJes3xDBZe48ZwYtvkp85nZJRMJor/sd5g5fpv1c1W
        3v1xCjpes58/efD1IuvFl9MCPka/KHCWrGl2WeuV1ftW98MZyc6bU9cdzHzvc1Op+3z2mrKn
        T1cosRRnJBpqMRcVJwIAz4+I5E0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method of constructing a bip has been changed, the number of
segments can be obtained through bip_vcnt.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/blk-integrity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index f97b7e8a6d4d..64407b412947 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -217,7 +217,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 			     struct bio *bio)
 {
 	int nr_integrity_segs;
-	struct bio *next = bio->bi_next;
 
 	if (blk_integrity_bypass_check(req, bio))
 		return true;
@@ -225,9 +224,7 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	if (!__blk_integrity_mergeable(q, req, bio))
 		return false;
 
-	bio->bi_next = NULL;
-	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
-	bio->bi_next = next;
+	nr_integrity_segs = bio_integrity(bio)->bip_vcnt;
 
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
-- 
2.34.1
