Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80156FDA12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbjEJIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbjEJIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:54:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD27DA3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:54:03 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230510085401epoutp012e387331bfb2f345a3a5ff9d9e133a68~dvEVTP7_w1497914979epoutp01v
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:54:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230510085401epoutp012e387331bfb2f345a3a5ff9d9e133a68~dvEVTP7_w1497914979epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708841;
        bh=dsClYh4QK7KsYkk+2+MP7q9EBU8OpMqvWeVl/PtqLS8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=nHbZ8YUCOc/bj9xs1OdEEqEwoUOBBGETC9B4hiFEBrQaYD2POIkx8oSOv0LGdH720
         D9yLZhAMIMeMsxU6rbK+iDDdxUlYT1fgoHUrcing7B3L4Nr/zKAZDSe7J7c5k7RqWL
         a7Jfpe5ikASZ704ubrw7HJr0iK6anb69/iq8g/n8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510085401epcas2p1ee8ea140a9d25a916316bc676335698a~dvEUuwE-00054500545epcas2p1e;
        Wed, 10 May 2023 08:54:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QGTN82Gbyz4x9Q7; Wed, 10 May
        2023 08:54:00 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-bf-645b5ba85d8f
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.06.17293.8AB5B546; Wed, 10 May 2023 17:54:00 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 07/14] block: add helper function to get the number of
 integrity segments
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
Message-ID: <20230510085359epcms2p5a8e36cf9c7147054e024669f5811c782@epcms2p5>
Date:   Wed, 10 May 2023 17:53:59 +0900
X-CMS-MailID: 20230510085359epcms2p5a8e36cf9c7147054e024669f5811c782
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmue6K6OgUg69b+C1W3+1ns3h5SNNi
        5eqjTBa9/VvZLBbd2MZk8bfrHpPFpEPXGC2eXp3FZLH3lrbF5V1z2CyWH//HZLHu9XsWi98/
        5rA58Hqcv7eRxWPzCi2Py2dLPTat6mTzmLDoAKPH7psNbB69ze/YPD4+vcXi0bdlFaPH501y
        Hu0HupkCuKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGdMfnOJseA9V8WU67+YGxi7OLsYOTkkBEwkbn74xtbFyMUhJLCDUaJh/hQgh4OD
        V0BQ4u8OYZAaYYE4iQuH9rOD2EICShLn1sxiBCkRFjCQuNVrDhJmE9CT+LlkBtgYEYGdLBLf
        7x9lhJjPKzGj/SkLhC0tsX35VrBeTgE/idbHlhBhDYkfy3qZIWxRiZur37LD2O+PzYcaIyLR
        eu8sVI2gxIOfu6HikhKHDn0Fu1hCIF9iw4FAiHCNxNvlB6BK9CWudWwEu4BXwFei7+ZDJhCb
        RUBV4vjna1A1LhJtr56B1TALyEtsfzuHGWQks4CmxPpd+hDTlSWO3IKq4JPoOPyXHea/ho2/
        sbJ3zHvCBNGqJrGoyQgiLCPx9fB89gmMSrMQgTwLydpZCGsXMDKvYhRLLSjOTU8tNiowgsdr
        cn7uJkZwItZy28E45e0HvUOMTByMhxglOJiVRHi9Q6NShHhTEiurUovy44tKc1KLDzGaAj08
        kVlKNDkfmAvySuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeWpGanphakFsH0MXFwSjUwHRPL
        5A3I/SbLVRyifqNm4q37t3ZNybn2r7r/47euVL3VXbdV5L8Z23VMXO1TO7sryUti47raIKMr
        qbrlX7a4nnl5Z++Ekwmzri/q+HRTtK1LVOl5rJXzup1P4tRfbIzq/FlTHGm0+nPHr/AH2e9f
        azHOvBlndmV7mHWRk65L4Iuljqomiz3iFRhZK+JnZXK5l7JNfLFlVmL+zN4jSQtXsB/PrNl/
        yd/kafvku9XJP1/fnum9QWCfb9iMj52LY/OTMnZbhugqeR65f0nE5+K04EdZB6bKXVZoXDT9
        w9HLm488vtzq2Pxu3/4L4g7V79u3eAg7yZyV0p7AkHLmu81Mji9dbq8j6tcrt/3h3LCiVYml
        OCPRUIu5qDgRADTtrYRNBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p5>
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

Since request always has the number of integrity segments in the process
of generating and merging, a function for simply obtained this has been
added.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 include/linux/blk-integrity.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2..45b9fde1fee1 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -43,6 +43,11 @@ int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 
+static inline unsigned short blk_rq_nr_integrity_segments(struct request *rq)
+{
+	return rq->nr_integrity_segments;
+}
+
 static inline struct blk_integrity *blk_get_integrity(struct gendisk *disk)
 {
 	struct blk_integrity *bi = &disk->queue->integrity;
@@ -120,6 +125,10 @@ static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 {
 	return 0;
 }
+static inline unsigned short blk_rq_nr_integrity_segments(struct request *rq)
+{
+	return 0;
+}
 static inline int blk_rq_map_integrity_sg(struct request_queue *q,
 					  struct bio *b,
 					  struct scatterlist *s)
-- 
2.34.1
