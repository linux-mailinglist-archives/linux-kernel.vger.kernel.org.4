Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D746253DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiKKGc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiKKGcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:32:19 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388FA464
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:31:06 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221111062329epoutp0258d2bf4826123c93882c8b574c3ee3e3~mc5g9mN4q1766517665epoutp02j
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:23:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221111062329epoutp0258d2bf4826123c93882c8b574c3ee3e3~mc5g9mN4q1766517665epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668147809;
        bh=3xPjjXI1Nb04Dpddz4+jF2hh7bD+qn5TBdH/kS2axg0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tKrG5Atkf/NoxBiwoX3Cx+Npi8oZoG7gR6JiZfPdtkZYc318dqFYD1QfNufBAzIQP
         Z0ddWuyro4feTnKrVjMK7qwz6T2AN6Bg878Gr+02mOpm44UPsDVW0/v8QcD+eCyTdM
         A353vyJQQEF1D/PG/xNc3h6ufRvMRF5wAFhveF7s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20221111062329epcas1p3289590811e544a38d364e1c95840237d~mc5gokm0x0729907299epcas1p3K;
        Fri, 11 Nov 2022 06:23:29 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N7pYY1kF0z4x9Q2; Fri, 11 Nov
        2022 06:23:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.31.51827.16AED636; Fri, 11 Nov 2022 15:23:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221111062328epcas1p2c2d1f52fed1068579a1dad7fb4e60f52~mc5gQubZ01221612216epcas1p2H;
        Fri, 11 Nov 2022 06:23:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111062328epsmtrp2b40ed3b0f2a878bcb041d4a12a51c83c~mc5gQEdp62943729437epsmtrp2A;
        Fri, 11 Nov 2022 06:23:28 +0000 (GMT)
X-AuditID: b6c32a36-17bfa7000000ca73-4f-636dea6145d1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.7E.18644.06AED636; Fri, 11 Nov 2022 15:23:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221111062328epsmtip13743b0a647dd20191b444d2af948d48e~mc5gCPuXM1147511475epsmtip1W;
        Fri, 11 Nov 2022 06:23:28 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] scsi: ufs: core: Fix unnecessary operation for early return
Date:   Fri, 11 Nov 2022 15:23:01 +0900
Message-Id: <20221111062301.7423-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmnm7iq9xkgwlHuS0ezNvGZvHy51U2
        i4MPO1kspn34yWwx41Qbq8WiG9uYLC7vmsNm0X19B5vF8uP/mBw4PS5f8faYsOgAo8f39R1s
        Hh+f3mLx6NuyitHj8yY5j/YD3UwB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAlykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK
        9IoTc4tL89L18lJLrAwNDIxMgQoTsjOapl1gL5jEWdF5M7iB8Sh7FyMnh4SAicT2XR+AbC4O
        IYEdjBIrt9xjhnA+MUr8mrWSDcL5zCjRuGA7M0zL/MnroBK7GCUWzpvCCuF8YZTY9m8JUIaD
        g01AS+L2MW+QuIjAMUaJD2/OM4F0MwtoSJyc9QRsubCAj8TftleMIDaLgKrEuy0vwTbwClhJ
        dLy7wgSxTV7iz/0eqLigxMmZT1gg5shLNG+dDXarhMAjdom7p49DNbhInJu/jA3CFpZ4dXwL
        1KdSEp/f7WWDaGgGuvTrJSYIp4NRYmPrC0aIKmOJT58/M4K8wCygKbF+lz5EWFFi5++5jBCb
        +STefe1hBSmREOCV6GgTgihRkZjTdY4NZtfHG49ZIWwPifU3F4LdICQQK/Fz9zfWCYzys5D8
        MwvJP7MQFi9gZF7FKJZaUJybnlpsWGAEj9bk/NxNjODkqWW2g3HS2w96hxiZOBgPMUpwMCuJ
        8HJrZCcL8aYkVlalFuXHF5XmpBYfYjQFhvBEZinR5Hxg+s4riTc0sTQwMTMysTC2NDZTEudt
        mKGVLCSQnliSmp2aWpBaBNPHxMEp1cBkmyCausLrjnZXSiLjkivJxnyVZrV93MUCTD/TSrxK
        ulST+n+2Mll+YrI9usmtY5WeCkuI2/8o1bevy7VOBkQyMEgb7FSw+s24zGDvn843Qqwplk38
        cUIpD0wttbq51tW0rboseLYndtYDrnl/XJMem1cy+hbXBIR4BPVHbT0pdGzfqsPqOz0uM/8y
        uqUfnrT4qMLagocuNku4dvzTWO3aWxfFVS6jYze96XCT5lL/97Wmi3x45xT1/p7mLFRQx323
        e+HH40/vFm+zqJpToTu7U+Dup09fF7ncFlrtETNzRc6lvdvOLrdVk35cqCoeyzG7bdWNiHIO
        ndNRJQfPix5Xtgm2eT3j1lkhjwW2SizFGYmGWsxFxYkAvDgd4icEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnG7Cq9xkg5lPjSwezNvGZvHy51U2
        i4MPO1kspn34yWwx41Qbq8WiG9uYLC7vmsNm0X19B5vF8uP/mBw4PS5f8faYsOgAo8f39R1s
        Hh+f3mLx6NuyitHj8yY5j/YD3UwB7FFcNimpOZllqUX6dglcGU3TLrAXTOKs6LwZ3MB4lL2L
        kZNDQsBEYv7kdWxdjFwcQgI7GCVeH5zODJGQkti9/zxQggPIFpY4fLgYouYTo8S5adPZQeJs
        AloSt495g8RFBC4wSvTuPM8I0sssoCFxctYTsAXCAj4Sf9tegcVZBFQl3m15CTafV8BKouPd
        FSaIXfISf+73QMUFJU7OfMICMUdeonnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHMhaWjsY96z6oHeIkYmD8RCjBAezkggvt0Z2shBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M2iz+sgKvZzMl8Nxk8piYkCmY
        Ghr4uVNa7/4+IYmI4OPSHVu7DpSfkLN8m1Fa7BQqfrN3R9vGy1d7J3y2ndpY+uTGSd6c2mPM
        jNmqq8UWlfbdne8a+qP4+f1vJ3X5uOYUa2f9fNZn0vxxR/RWPce1EULGx+pmiF3YsEc4Veul
        UWRYqE6Bcs6jHE7B1clpp7a5XBJettVW8Ibq5qRHTL6rtwSEhxxZHi9rflQ1f1bWGaWpcSev
        eTNabgt35PtenGRVknT11IwSNy/75l2H7r+Qcy6T8Vp3Vzfp7HUNezX9hpi81WIzt16x2Kf1
        YLshj+LvxIbmR/zOPNFd9tfMSoN48/kOXo3LEmX6eGqarRJLcUaioRZzUXEiABaA9cnTAgAA
X-CMS-MailID: 20221111062328epcas1p2c2d1f52fed1068579a1dad7fb4e60f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111062328epcas1p2c2d1f52fed1068579a1dad7fb4e60f52
References: <CGME20221111062328epcas1p2c2d1f52fed1068579a1dad7fb4e60f52@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

For early return, bitmap_len operation is not required.
Modified to reduce unnecessary operations.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/core/ufshpb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index 148017b2dfeb..994f4ac9df5a 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -233,11 +233,6 @@ static bool ufshpb_test_ppn_dirty(struct ufshpb_lu *hpb, int rgn_idx,
 	rgn = hpb->rgn_tbl + rgn_idx;
 	srgn = rgn->srgn_tbl + srgn_idx;
 
-	if (likely(!srgn->is_last))
-		bitmap_len = hpb->entries_per_srgn;
-	else
-		bitmap_len = hpb->last_srgn_entries;
-
 	if (!ufshpb_is_valid_srgn(rgn, srgn))
 		return true;
 
@@ -253,6 +248,11 @@ static bool ufshpb_test_ppn_dirty(struct ufshpb_lu *hpb, int rgn_idx,
 		return true;
 	}
 
+	if (likely(!srgn->is_last))
+		bitmap_len = hpb->entries_per_srgn;
+	else
+		bitmap_len = hpb->last_srgn_entries;
+
 	if ((srgn_offset + cnt) > bitmap_len)
 		bit_len = bitmap_len - srgn_offset;
 	else
-- 
2.29.0

