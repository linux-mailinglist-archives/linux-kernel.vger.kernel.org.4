Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621736F5602
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjECKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjECKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:23:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBF35A6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:23:16 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230503102315epoutp04f0b13ee2f0d05507a3f91f0ef45d9d58~bmxPaNas92811028110epoutp04Z
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:23:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230503102315epoutp04f0b13ee2f0d05507a3f91f0ef45d9d58~bmxPaNas92811028110epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109395;
        bh=ZM+sCSOwfR6BMhP2ycEflPofWbLGNzFKU7U4qcknaW8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=uMFqmCmiUEeBZWiL9Sb6hAb6ydvxZNtemId5ZGobtPPI38INS2yHBf7GouLIc64fs
         h6Drg74VaNZ+cxboIWBKtVNNWF4p8w1ibL5/51gB+zzJpnhvIhGu5g2S+IoWERpepA
         bh43MtBAgOcGu/i+QYkUtfJoBagWscsr7doiCb5w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230503102314epcas2p47f783c917b77e312bf1314b109badd5d~bmxOoSSjZ1780817808epcas2p4J;
        Wed,  3 May 2023 10:23:14 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QBChK6q5Lz4x9Px; Wed,  3 May
        2023 10:23:13 +0000 (GMT)
X-AuditID: b6c32a48-6d3fa70000005998-5b-645236115133
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.DF.22936.11632546; Wed,  3 May 2023 19:23:13 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 12/15] nvme: rdma: change how to find the number of
 integrity of request
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
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
Message-ID: <20230503102313epcms2p52eb54df61b367ae233c4dfe7c6594918@epcms2p5>
Date:   Wed, 03 May 2023 19:23:13 +0900
X-CMS-MailID: 20230503102313epcms2p52eb54df61b367ae233c4dfe7c6594918
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmha6gWVCKwft7Jhar7/azWbw8pGmx
        cvVRJove/q1sFpMOXWO02HtL2+LyrjlsFsuP/2OyWPf6PYsDp8f5extZPC6fLfXYtKqTzWP3
        zQY2j49Pb7F49G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0F1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyMXZ82MxbsYa/o3jmHsYFxFVsXIyeHhICJRMOX+exdjFwc
        QgI7GCUaemcDJTg4eAUEJf7uEAapERaIkphzYjUTiC0koCRxbs0sRpASYQEDiVu95iBhNgE9
        iZ9LZoCNFBH4yySx80U+xHheiRntT1kgbGmJ7cu3MoLYnAJ+Eo833GKEiGtI/FjWywxhi0rc
        XP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktKHDr0FexiCYF8iQ0HAiHCNRJvlx+AKtGXuNax
        EewEXgFfiWcz/oLZLAKqEv/mX4aqcZHoXP8DbC2zgLzE9rdzmEFGMgtoSqzfpQ8xXVniyC0W
        iAo+iY7Df9lhHmzY+Bsre8e8J0wQrWoSi5qMIMIyEl8Pz2efwKg0CxHIs5CsnYWwdgEj8ypG
        sdSC4tz01GKjAhN4vCbn525iBKdOLY8djLPfftA7xMjEwXiIUYKDWUmE90OhX4oQb0piZVVq
        UX58UWlOavEhRlOghycyS4km5wOTd15JvKGJpYGJmZmhuZGpgbmSOO/HDuUUIYH0xJLU7NTU
        gtQimD4mDk6pBqY+qSD51z6didP3dxdsaNos//e/2NujIRdFq269/eXo0PLppqPvkhC7ze8P
        /+ANiev94eu6deFGlW3eyU+0U2uOsmf8b5W6t/+YffPLo/PW2Zzme7X6XVN1r9A81bWySv83
        zTvPkfT48CFV3VIzCaHFjPe43icbm8+8UKf3sOS94r41hQVfl/BvMHYVZ66r8jbMrmd4u6JR
        Ovbo7UtFexItxdOyevguOJ/TPHzk5bZD7y6uC34x/yvnbTvH3vpWy9867IsfVYSL2ji0b9Se
        cWCjmtQ0XTbtDoGvzL0pE25kVyQJmrf0r2JQvvgj8kZnFVPD7iuT/3bfvpjcP+3Kko61YcFu
        01M359vYNR3TF1NiKc5INNRiLipOBACEuYZEJgQAAA==
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

Since the request has the number of integrity segments, change to use
the relevant api.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..237d81ad54af 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1507,7 +1507,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		req->metadata_sgl->sg_table.sgl =
 			(struct scatterlist *)(req->metadata_sgl + 1);
 		ret = sg_alloc_table_chained(&req->metadata_sgl->sg_table,
-				blk_rq_count_integrity_sg(rq->q, rq->bio),
+				blk_rq_nr_integrity_segments(rq),
 				req->metadata_sgl->sg_table.sgl,
 				NVME_INLINE_METADATA_SG_CNT);
 		if (unlikely(ret)) {
-- 
2.34.1
