Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC066F5616
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjECKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:25:49 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA33C01
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:25:45 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503102544epoutp0330a64cf2863dd54745fbc569bec2ac34~bmzaHMjUN3193131931epoutp03n
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:25:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503102544epoutp0330a64cf2863dd54745fbc569bec2ac34~bmzaHMjUN3193131931epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109544;
        bh=Qu9Yx8AHfpqjx58Hv8uRZKjzvr/nHdB5F0/a51oGkO8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=MsXLWRzSWTXLUHxXqBeStKoWzjkGL85pXYRwZ6bTcsezk1Lwlk04RJfZcSpj76Oa5
         CoFZ4hrb8sVi/9cZHNo02L3lummecQv1Od8Shdnkxn2AhGV5JrYnwLn9cdxScmOFlg
         ljaG5uQukl8GbPks/Ug+CrtV5HhPxHAPhQZz27dU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230503102543epcas2p2ca5917ded82f913c41eaf6e72457d945~bmzZgxulP0035600356epcas2p2h;
        Wed,  3 May 2023 10:25:43 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBClB6HYFz4x9Q5; Wed,  3 May
        2023 10:25:42 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-29-645236a6590e
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.88.17293.6A632546; Wed,  3 May 2023 19:25:42 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 13/15] block: add helper function for iteration of bip's
 bvec
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "willy@infradead.org" <willy@infradead.org>,
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
Message-ID: <20230503102542epcms2p371143d5975c9fa4e4a081b96f6bfc2c0@epcms2p3>
Date:   Wed, 03 May 2023 19:25:42 +0900
X-CMS-MailID: 20230503102542epcms2p371143d5975c9fa4e4a081b96f6bfc2c0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmue4ys6AUg94OI4vVd/vZLF4e0rRY
        ufook0Vv/1Y2i79d95gsnl6dxWSx95a2xeVdc9gslh//x2Tx+8ccNgcuj80rtDwuny312H2z
        gc2jt/kdm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8
        qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul
        1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMBT+2sBU84q2Y1d7I3sC4mruLkZNDQsBE
        Yt2u6cxdjFwcQgI7GCVunNgM5HBw8AoISvzdIQxSIyzgL9G+9x87iC0koCRxbs0sRpASYQED
        iVu95iBhNgE9iZ9LZrCBjBER2MUs8fXcRiaI+bwSM9qfskDY0hLbl29lBLE5BfwkHm+4xQgR
        15D4sayXGcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5Q4dOgrG8g9EgL5EhsOBEKE
        ayTeLj8AVaIvca1jI9gJvAK+Ege+HmEFsVkEVCWuz2mBGukisWfFVLA4s4C8xPa3c8ChwCyg
        KbF+lz7EdGWJI7dYICr4JDoO/2WHebBh42+s7B3znjBBtKpJLGoyggjLSHw9PJ99AqPSLEQo
        z0KydhbC2gWMzKsYxVILinPTU4uNCozgEZucn7uJEZxOtdx2ME55+0HvECMTB+MhRgkOZiUR
        3g+FfilCvCmJlVWpRfnxRaU5qcWHGE2BHp7ILCWanA9M6Hkl8YYmlgYmZmaG5kamBuZK4rzS
        tieThQTSE0tSs1NTC1KLYPqYODilGphij/3gmCJr/2jC07abSUw7XgnlXCt5FyzczPjqb7z/
        +mLFWxxWU88fU9mmcZ/R5+e1wv6VqfETFp291h3nWrrs3PZF9kf1m2dxp6seWpwVmfp5qbvX
        +lKXp3uWFbSoJ8vt4azK5mab8v9492qzqRNLOCYyfGNkaY31Tdrz5Jt62qnOaMavnkzrIh0L
        I6rnnD+6bX0EY8WLgOZXG56+23Ts0ZIZC51T2IynL+atCI/T9zyllPv71I9+Xf/a1qXiPesi
        g/7fYXPZ8Di0Xo5b2P39j1ixp9cD/vUFy/RwmJZ90i/MXexVf2ujDd/D5u3JwptZfW/GRL4o
        W3K+J9YnQuhSflNFfG/WtWy+5v3dlkosxRmJhlrMRcWJAB06peUwBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p3>
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
index b53a595b519a..e3e437ce694c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -695,6 +695,10 @@ static inline bool bioset_initialized(struct bio_set *bs)
 
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
