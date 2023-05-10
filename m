Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD96FDA36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjEJI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbjEJI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:59:13 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F13525F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:59:09 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230510085907epoutp04a6bbb272ee1a38d40f18824fbe6ab393~dvIyfYGJz0387403874epoutp04D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:59:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230510085907epoutp04a6bbb272ee1a38d40f18824fbe6ab393~dvIyfYGJz0387403874epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683709147;
        bh=ZM+sCSOwfR6BMhP2ycEflPofWbLGNzFKU7U4qcknaW8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=uTMLtsP7OuMD8Qe1NqrYiLngFx3YXm+Z3OZdrpf4Dl5zxkHY4oADzvAE2qTTCJt/B
         LDlMc1cyDYqLs9QeSZPJn73kCtfnG+9SexheXSfl/WXeY2xoHj4us8IF2eKRMuMKUs
         wc2v6DMhX7Ho2TzqB9JX8TxDafVroUeFuz3MvCOo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230510085907epcas2p38c4de637761704a263ba3a299ff61bf1~dvIx6k1yA2639126391epcas2p3f;
        Wed, 10 May 2023 08:59:07 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGTV24ZlMz4x9Pw; Wed, 10 May
        2023 08:59:06 +0000 (GMT)
X-AuditID: b6c32a48-6d3fa70000005998-ee-645b5cda02e7
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.0E.22936.ADC5B546; Wed, 10 May 2023 17:59:06 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 11/14] nvme: rdma: change how to find the number of
 integrity of request
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
Message-ID: <20230510085905epcms2p19082f99cbf2c80135d9239e998be7928@epcms2p1>
Date:   Wed, 10 May 2023 17:59:05 +0900
X-CMS-MailID: 20230510085905epcms2p19082f99cbf2c80135d9239e998be7928
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmqe6tmOgUg/eTVCxW3+1ns3h5SNNi
        5eqjTBa9/VvZLBbd2MZk8bfrHpPFpEPXGC2eXp3FZLH3lrbF5V1z2CyWH//HZLHu9XsWi98/
        5rA58Hqcv7eRxWPzCi2Py2dLPTat6mTzmLDoAKPH7psNbB69ze/YPD4+vcXi0bdlFaPH501y
        Hu0HupkCuKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGfs+rSZsWAPe0X3zjmMDYyr2LoYOTgkBEwkjj8t7WLk4hAS2MEose3fEiaQOK+A
        oMTfHcJdjJwcwgKxEm/fnmACsYUElCTOrZnFCFIiLGAgcavXHCTMJqAn8XPJDDaQMSICO1kk
        vt8/ygiSkBDglZjR/pQFwpaW2L58K1gvp4CfROtjS4iwhsSPZb3MELaoxM3Vb9lh7PfH5kON
        EZFovXcWqkZQ4sHP3VBxSYlDh75CfZIvseFAIES4RuLt8gNQJfoS1zo2gl3AK+Ar0fVnARuI
        zSKgKnFywytWiBoXiefbP4KtZRaQl9j+dg4zyEhmAU2J9bv0IaYrSxy5xQJRwSfRcfgvO8x/
        DRt/Y2XvmPeECaJVTWJRkxFEWEbi6+H57BMYlWYhAnkWkrWzENYuYGRexSiWWlCcm55abFRg
        Ao/W5PzcTYzgNKzlsYNx9tsPeocYmTgYDzFKcDArifB6h0alCPGmJFZWpRblxxeV5qQWH2I0
        BXp4IrOUaHI+MBPklcQbmlgamJiZGZobmRqYK4nzfuxQThESSE8sSc1OTS1ILYLpY+LglGpg
        6jnwfeaXrbuUtr39J/AgZUdTjM2spKTt6dWl3akHHxm+atiw4fzLzPPC3zdOVz/zeObkc5cX
        +MlVPStgyJcQyXNLlq6MOBtRfmlX35Yl3y00fJdxySRNCrA9tFRMWUF6UkNc+q+vz1gitn4v
        +hNj0cVSuFmy5OanABm3PPYKNeWNK0weT08ySkqeKC8Wvltcvaq+zWDuSzkjV92vt40WZXXu
        K+18p+tzuVnT9N+1DT9OeC6Vsg/hcuUtWSzm/XNuod87/Q/6ak7PVyXctNPX6mMq5T0mbXB4
        pj3L1jvMBnd6HjVsjcl4Ljl96SLlX9L8Ao+1A8VKdv2O6/9kuPFCrFPq9mI2pSepwbzffGKV
        WIozEg21mIuKEwGStHPFTAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
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
