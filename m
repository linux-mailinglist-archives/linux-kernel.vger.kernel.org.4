Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9824B6EDA95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjDYDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjDYDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:17:31 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F70AD2A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:17:27 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230425031723epoutp03ed7b9cfaec521405f20cb6a47a4893f9~ZDzIAVVeP1415114151epoutp03N
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:17:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230425031723epoutp03ed7b9cfaec521405f20cb6a47a4893f9~ZDzIAVVeP1415114151epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682392643;
        bh=LL+GI3W9ZUGQXmaZW3ulzguaUQvF3QNMBbc3SULMfVI=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=Eg8wnN/J2i6wJfoAL0DudQu2GHSpeYwByFrETJoYq08B7ZqOav2IkJQVvZvbUx0tq
         dvJYiCJC5LGttaGIGZrp1XisDv9G/tbOljFn0X0lloy8gedT2xXPqKdZjk2Ubid0Qo
         eTzW1dN2pF91WRlACs/WrXfmR5dIRz9G9RMHle2g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230425031722epcas2p386a22d99c48d6a0d16225bb67b92b73c~ZDzHm6g0g2434324343epcas2p3Z;
        Tue, 25 Apr 2023 03:17:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q56cd73Gtz4x9Px; Tue, 25 Apr
        2023 03:17:21 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-c9-644746417835
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.3A.08199.14647446; Tue, 25 Apr 2023 12:17:21 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: core: Fix IO hang that occurs when BKOPS fails
 in W-LUN suspend
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
Date:   Tue, 25 Apr 2023 12:17:21 +0900
X-CMS-MailID: 20230425031721epcms2p5d4de65616478c967d466626e20c42a3a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmha6jm3uKwbpzFhYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XLQ5oWj24/Y7RYdGMbk8XlXXPYLLqv72CzWH78H5PFwo65LBaT
        rm1gs1i69SajA5/H5SveHov3vGTymLDoAKNHy8n9LB7f13eweXx8eovFY+KeOo++LasYPT5v
        kvNoP9DNFMAVlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg
        65aZA3S/kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK
        0MDAyBSoMCE7Y15bO1vBRc6KyRP2MDYwnmPvYuTkkBAwkdixfglzFyMXh5DADkaJ7ft6GLsY
        OTh4BQQl/u4QBqkRFoiVOHF+DSOILSSgJNG1cCszRNxAYt30PWA2m4CexJTfdxhB5ogIfGGR
        eHzpAyvEAl6JGe1PWSBsaYnty7cyQtgaEj+W9TJD2KISN1e/ZYex3x+bD1UjItF67yxUjaDE
        g5+7oeKSEq1ntrJB2PUSre9PsYMslhCYwCjReOwP1CB9iWsdG8EW8wr4SnQ1QxzBIqAq8fL2
        aWaQJyUEXCTWzkkGCTMLyEtsfzsHLMwsoCmxfpc+RIWyxJFbLBAVfBIdh/+yw3zVsPE3VvaO
        eU+YIGw1iUcLtkBDQUbi4pxzUJ94SLz7/pttAqPiLERAz0JywyyEGxYwMq9iFEstKM5NTy02
        KjCGx21yfu4mRnBK1nLfwTjj7Qe9Q4xMHIyHGCU4mJVEeIWz3FKEeFMSK6tSi/Lji0pzUosP
        MZoCPT+RWUo0OR+YFfJK4g1NLA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBK
        NTCpri62vchwojN40+XOoJd3ruW3bvt2lnXfbd3rXhumHWyYb1HBst/lpsOtbTfjO+3e/t3h
        bJS5NMVoYVtq2STn13o79u3OPjbjw+4Mf7XWlOPvNti9WTGja8WVlJQ7j5KWB19hSNp3fVVR
        q9vCvGNmeyJ6qheK1/xj+plgyTJVdtJ5qSIrf2me1Wrfc6eY6fOcUfWrLWBrqF89eZO7zEH2
        nQtnn7/k94jdUjv7yeMIs18mT9mZf7YfO/dQP/Kj6e53H9dm3NgcVSDjuuhu0NJ2hw2L7hb7
        T+4/NL998dpnypwM09u2cXG3ai39GbtgVZeI+KrHzow2Bx+Vy9+Wu5nUbx3QeWTpxbPrm7sy
        jM6oKbEUZyQaajEXFScCAMfFwUhSBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230425031721epcms2p5d4de65616478c967d466626e20c42a3a
References: <CGME20230425031721epcms2p5d4de65616478c967d466626e20c42a3a@epcms2p5>
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

Even when urgent BKOPS fails, the consumer will get stuck in runtime
suspend status. Like commit 1a5665fc8d7a ("scsi: ufs: core: WLUN suspend
SSU/enter hibern8 fail recovery"), trigger the error handler and return
-EBUSY to break the suspend.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328ba323..24966e9af720 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9457,8 +9457,16 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			 * that performance might be impacted.
 			 */
 			ret = ufshcd_urgent_bkops(hba);
-			if (ret)
+			if (ret) {
+				/*
+				 * If return err in suspend flow, IO will hang.
+				 * Trigger error handler and break suspend for
+				 * error recovery.
+				 */
+				ufshcd_force_error_recovery(hba);
+				ret = -EBUSY;
 				goto enable_scaling;
+			}
 		} else {
 			/* make sure that auto bkops is disabled */
 			ufshcd_disable_auto_bkops(hba);
-- 
2.17.1

