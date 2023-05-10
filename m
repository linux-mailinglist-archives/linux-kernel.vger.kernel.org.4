Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA76FD9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjEJIvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjEJIvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:51:36 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F847EF1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:51:15 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230510085113epoutp017a57e5a9e383615e5eccac9235cdeb5d~dvB4rnWLC1212512125epoutp01G
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:51:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230510085113epoutp017a57e5a9e383615e5eccac9235cdeb5d~dvB4rnWLC1212512125epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708673;
        bh=SMZ7aaeVPcRwQ18QiSqKaop+raZWNO8lsaDIbQ+02HA=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=TWcJKNXImvYJvCzWTvitvOs5oXmTxT7WU4sVw38I28KIFR5u0mXaChDuIGC5YVNA2
         ZRZ8sEkjyfrfkQtrWLd33NWtBza9VGTrhMXjZ8WSWlmNPpLec3fbLymM5SoSNHWF0j
         3ZRJBURmSkAT6aoBv+wAvDwKsnA9TM8lDVDyqUm8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230510085112epcas2p3c8db972028412c72bfa8006f836edd58~dvB33_zG80654406544epcas2p3z;
        Wed, 10 May 2023 08:51:12 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QGTJw046Cz4x9Q7; Wed, 10 May
        2023 08:51:12 +0000 (GMT)
X-AuditID: b6c32a47-c29ff70000002007-20-645b5affbfbf
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.F5.08199.FFA5B546; Wed, 10 May 2023 17:51:11 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 04/14] block: fix not to apply bip information in
 blk_rq_bio_prep()
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
Message-ID: <20230510085111epcms2p7022e97fd97c1a32c59f935d72f8dda94@epcms2p7>
Date:   Wed, 10 May 2023 17:51:11 +0900
X-CMS-MailID: 20230510085111epcms2p7022e97fd97c1a32c59f935d72f8dda94
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmue7/qOgUgwkXLS1W3+1ns3h5SNNi
        5eqjTBa9/VvZLBbd2MZk8bfrHpPFpEPXGC2eXp3FZLH3lrbF5V1z2CyWH//HZLHu9XsWi98/
        5rA58Hqcv7eRxWPzCi2Py2dLPTat6mTzmLDoAKPH7psNbB69ze/YPD4+vcXi0bdlFaPH501y
        Hu0HupkCuKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGes3PmauaCVq2Lv8ybGBsadHF2MnBwSAiYSxw6uZuti5OIQEtjBKDHj6SvGLkYO
        Dl4BQYm/O4RBTGGBCInTO0VByoUElCTOrZnFCBE2kLjVaw4SZhPQk/i5ZAbYFBGBnSwS3+8f
        ZYQYzysxo/0pC4QtLbF9+VawXk4BP4nWx5YQYQ2JH8t6mSFsUYmbq9+yw9jvj82HGiMi0Xrv
        LFSNoMSDn7uh4pIShw59ZQMZKSGQL7HhQCBEuEbi7fIDUCX6Etc6NoJdwCvgK/Fz0VYmkHIW
        AVWJbfukIEpcJK7MWsgKYjMLyEtsfzuHGaSEWUBTYv0ufYjhyhJHbrFAVPBJdBz+yw7zXsPG
        31jZO+Y9YYJoVZNY1GQEEZaR+Hp4PvsERqVZiCCehWTtLIS1CxiZVzGKpRYU56anFhsVGMNj
        NTk/dxMjOAlrue9gnPH2g94hRiYOxkOMEhzMSiK83qFRKUK8KYmVValF+fFFpTmpxYcYTYH+
        ncgsJZqcD8wDeSXxhiaWBiZmZobmRqYG5krivNK2J5OFBNITS1KzU1MLUotg+pg4OKUamHo6
        prKLZkW5pU0J2xZ64pzGpuYLzw2WOBT7bFzt8/TFbK5FF55qpcxW4Gzeu7eIqcMm2DKj/3f8
        oSYbdufpyZOW+1bLXd9ok+iyMICXIShbbsUxj7TKL4dTjfY/65jygUvw7Mm3vHeWnzp6l79m
        0yp5y9WKvNrHrjn4nTaQ4L/bEbFq+/uXd1caR7Dsay5RcW9ePatp9+PAl/tT9X4U6H1Nz93T
        Gtf99/mumb2PKnzuHZro8fVCmVf5sZbj1QmFoWKFvUUaf1c3LJau2n9Qql0wcO7u5KnhvA1z
        /j/Y9ZbXOGJt+k75bUx3J8bfLV0q5eQ+J0hxxsNlzzIEbJMP5py4PLmxsWzicu6Zp7edeKzE
        UpyRaKjFXFScCAAYywQtSwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p7>
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

When a request is initialized through the bio, bio's integrity
information is not reflected in the request. It seems to be missing
when the codes associated with 'nr_integrity_segment' were added.

the lld such as scsi does not refer to this variable. It uses
integrity's bevc to calculate the number of segments for sg-list. So
there seems to be no problem related to this.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 13f05c8d8e98 ("block/scsi: Provide a limit on the number of integrity segments")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 include/linux/blk-mq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1dacb2c81fdd..9310c94577c7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -961,6 +961,11 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 	rq->ioprio = bio_prio(bio);
+
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	if (bio_integrity(bio))
+		rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
+#endif
 }
 
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
-- 
2.34.1
