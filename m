Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9DD6F55A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjECKKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:10:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE21A5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:10:51 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503101050epoutp0360221e9d08d67ce3904467d150dd43a9~bmmZWb3Oz2144121441epoutp03I
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:10:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503101050epoutp0360221e9d08d67ce3904467d150dd43a9~bmmZWb3Oz2144121441epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683108650;
        bh=ZtBNUgN0/grPa2YZpBQ/+703+N7AXHalnFNdUd9CK2g=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=QxLabi9gec1onP3dLuFgF6UlEGlHek9Kjr+0GdgDzqHAwyozTdSe/wX5pwdKH4fsU
         KQCZ3BeiJB4WqoR9N9yrHgq42r99F9YccebPTGb743seYBQox+/cFvTubDLIwx95Tx
         NKw/2ksDeK4zvBFmjdKKr8Tu6vXgTqfJBByPTPVI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503101049epcas2p38f6d0fb534262f57214878ba4a6ae640~bmmY8uVtU2866128661epcas2p3e;
        Wed,  3 May 2023 10:10:49 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QBCQ10n2Zz4x9Pw; Wed,  3 May
        2023 10:10:49 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-29-6452332814ef
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.7D.03265.82332546; Wed,  3 May 2023 19:10:49 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
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
Message-ID: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
Date:   Wed, 03 May 2023 19:10:48 +0900
X-CMS-MailID: 20230503101048epcms2p61d61df1431955d9517c9939999ee3478
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmma6mcVCKwd1pjBar7/azWbw8pGmx
        cvVRJove/q1sFntvaVtc3jWHzWL58X9MDuwel8+Weuy+2cDm8fHpLRaPvi2rGD0+b5ILYI3K
        tslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ3x
        secac8E09opfK7+xNjC2sXUxcnJICJhI/Ph3m6mLkYtDSGAHo8SPX99Zuxg5OHgFBCX+7hAG
        MYUFQiXmL9YHKRcSUJI4t2YWI0TYQOJWrzlImE1AT+LnkhlgE0UEVjNJND+vgZjOKzGj/SkL
        hC0tsX35VkYQm1PAT+LxhluMEHENiR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/d
        UHFJiUOHvrKBnCMhkC+x4UAgRLhG4u3yA1Al+hLXOjayQPzkK7F/VRhImEVAVWL7vecsEJ0u
        EhOn+4CEmQXkJba/ncMMEmYW0JRYv0sfokJZ4sgtFogKPomOw3/ZYd5r2PgbK3vHvCdMEK1q
        EouajCDCMhJfD89nn8CoNAsRwrOQrJ2FsHYBI/MqRrHUguLc9NRiowJDeKQm5+duYgQnQy3X
        HYyT337QO8TIxMF4iFGCg1lJhPdDoV+KEG9KYmVValF+fFFpTmrxIUZToH8nMkuJJucD03Fe
        SbyhiaWBiZmZobmRqYG5kjivtO3JZCGB9MSS1OzU1ILUIpg+Jg5OqQYmg5DXb4uWaP5g+mFt
        uORVxePWBvufskpP+MInH/+87PC5G+uCjok72FS87eOc9PvmsX2mj/aVuh3jSHsdsvWs3bvP
        C031t7f9Ztj+82fLN6vGz5czDNlsti04ENbZ5K1w6qqTbNiK8LQ9H988vCmQ7eDt2PtjYtL2
        1Lt/m5cEsT5xPXtbQNohIa8z+vnEVpumnNC2rY4+9tsfiigklHPIMrBszre7vSNn+amd2/xW
        xP9ZeVAg4NJiLn2ZVO4DnqkZsufEl0Q9CjW32f0x9dzOpdt3ZH72rlbqOVb8R2wef96hzlt+
        y9j/OJtfkNJxfMPYnr3/odXOm0YbfS9M0n0xUe+uw43muqd5J+PObRDbosRSnJFoqMVcVJwI
        AOw3ppIPBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p6>
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

When a request is initialized through the bio, bio's integrity
information is not reflected in the request.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 include/linux/blk-mq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1dacb2c81fdd..cdb95e090919 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -961,6 +961,11 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 	rq->ioprio = bio_prio(bio);
+
+	if (bio_integrity(bio)) {
+		rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
+		rq->cmd_flags |= REQ_INTEGRITY;
+	}
 }
 
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
-- 
2.34.1
