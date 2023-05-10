Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB886FDA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjEJJAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjEJI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:59:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36030CB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:59:45 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230510085943epoutp02c9ea77a2d7f9de113bf76efb845ff268~dvJTlmUHi0979409794epoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:59:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230510085943epoutp02c9ea77a2d7f9de113bf76efb845ff268~dvJTlmUHi0979409794epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683709183;
        bh=sVfhvt67RI59s6Gd6R+cinzbvf6W3rrVcFHTc4WgexY=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Jafh8pKwRrQBYFkvCStEOURS774YofUXGgUTCWXS7qxKeEJGACfhGYNp1n/s1d8Kn
         8WZ7/bd8Hq5ve35JyndCPSH2gHnRetg0M5kPswdzZ5DGE9CtAsCCd4PM10vmIytAUv
         T5gtdtVy4jPHE6aWfFMj+/v3AplMV++1RBILfvKM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230510085942epcas2p267865a45cb0918325c9cef99237abf7e~dvJTKJJtS0405704057epcas2p21;
        Wed, 10 May 2023 08:59:42 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGTVk0ycTz4x9Q9; Wed, 10 May
        2023 08:59:42 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-9d-645b5cfe1932
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.0B.08199.EFC5B546; Wed, 10 May 2023 17:59:42 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 12/14] block: add helper function for iteration of bip's
 bvec
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
Message-ID: <20230510085941epcms2p8ad574939bc3edbd65b8f208c80a85911@epcms2p8>
Date:   Wed, 10 May 2023 17:59:41 +0900
X-CMS-MailID: 20230510085941epcms2p8ad574939bc3edbd65b8f208c80a85911
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmqe6/mOgUg5kvmC1W3+1ns3h5SNNi
        5eqjTBa9/VvZLBbd2MZk8bfrHpPFpEPXGC2eXp3FZLH3lrbF5V1z2CyWH//HZLHu9XsWi98/
        5rA58Hqcv7eRxWPzCi2Py2dLPTat6mTzmLDoAKPH7psNbB69ze/YPD4+vcXi0bdlFaPH501y
        Hu0HupkCuKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGdc27GfqeARb8XW7ztZGxhXc3cxcnJICJhI/JxxkbGLkYtDSGAHo8TPX59Zuxg5
        OHgFBCX+7hAGMYUFgiT+9bOClAsJKEmcWzOLESJsIHGr1xwkzCagJ/FzyQw2kCkiAjtZJL7f
        P8oIMZ5XYkb7UxYIW1pi+/KtYL2cAn4SrY8tIcIaEj+W9TJD2KISN1e/ZYex3x+bDzVGRKL1
        3lmoGkGJBz93Q8UlJQ4d+soGMlJCIF9iw4FAiHCNxNvlB6BK9CWudWwEu4BXwFdi9eqNYJ+w
        CKhKnNv5D+oyF4nn93aAxZkF5CW2v53DDDKSWUBTYv0ufYjpyhJHbrFAVPBJdBz+yw7zX8PG
        31jZO+Y9YYJoVZNY1GQEEZaR+Hp4PvsERqVZiDCehWTtLIS1CxiZVzGKpRYU56anFhsVGMOj
        NTk/dxMjOA1rue9gnPH2g94hRiYOxkOMEhzMSiK83qFRKUK8KYmVValF+fFFpTmpxYcYTYEe
        nsgsJZqcD8wEeSXxhiaWBiZmZobmRqYG5krivNK2J5OFBNITS1KzU1MLUotg+pg4OKUamPoL
        uPUDOePUD9/w453rYn9wjmCKssOpmUpShUVXJlrO2mGuXPHiZ/2GCPFF0xMDNkosfaM794Tw
        um3/CxiumZt+m3+j89W91viP5tvY9U//d9JeqveL1attaunp4s2H8zyvqqctm6XLNzMo8ueG
        /e/3zasp0T2hPW2tRvmZ9qUVk7jdts3XtT24v6B14mOOTVNNBb8ucjwxd09+SP7vTbuembq+
        +PV+W84s7q/B8jcXebXf7635alm1aUtzdHH7A/ZTH/Y2KL0vmB92QOVOf3ltvWdL4muJwM2V
        LR8ELuxbpev/1lbjZ7RE9fa2N1ktUjGv9k5uvZlewfNop0q+dkTUT887jwosL37v9PvzYLIS
        S3FGoqEWc1FxIgCJ9ijbTAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bip_for_each_vec() performs the iteration in a page unit.

Since a bio_vec of bip is composed of multi-page in the block, a macro
that can be carried out in multi-page units has been added.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 include/linux/bio.h  | 4 ++++
 include/linux/bvec.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..8b65463d4a55 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -692,6 +692,10 @@ static inline bool bioset_initialized(struct bio_set *bs)
 
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 
+/* iterate over multi-page bvec for integrity */
+#define bip_for_each_mp_bvec(bvl, bip, iter)				\
+	for_each_mp_bvec(bvl, (bip)->bip_vec, iter, (bip)->bip_iter)
+
 #define bip_for_each_vec(bvl, bip, iter)				\
 	for_each_bvec(bvl, (bip)->bip_vec, iter, (bip)->bip_iter)
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 555aae5448ae..9364c258513e 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -184,6 +184,12 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
 
+#define for_each_mp_bvec(bvl, bio_vec, iter, start)			\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = mp_bvec_iter_bvec((bio_vec), (iter))), 1);	\
+	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
+
 /* for iterating one bio from start to end */
 #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
 {									\
-- 
2.34.1
