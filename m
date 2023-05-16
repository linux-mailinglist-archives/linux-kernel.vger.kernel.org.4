Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D156670440F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEPDm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEPDmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:42:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E755AB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:42:22 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230516034220epoutp028809d03c3ba717431bc12a924280c8e7~fgr58Abw01872818728epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:42:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230516034220epoutp028809d03c3ba717431bc12a924280c8e7~fgr58Abw01872818728epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684208540;
        bh=jBa5/sdxCBMiteEvAWqc2iT+55qyMie5/N6VS+ns1Ew=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g/mB2YH1N0U6Yo/rttqNAJWxhbgBeZvoZrwLiNc4vV11JQtSpF48/+dcMek+Gxxhz
         mL63onoPCNjxrJ1/082SE4gQLjOcQMiuoQw6KPlExchS2H84P4nwaHKYs4OBlQpJUq
         toyG5tpCJD1iMSrRwcXq77FUOrHFPMwHpCRmoe74=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230516034219epcas2p35ba5a957d7c9aa58b279f6f56f4c847a~fgr5CZ2vv3041130411epcas2p3v;
        Tue, 16 May 2023 03:42:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QL29k3qZmz4x9Pv; Tue, 16 May
        2023 03:42:18 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.CC.03265.A9BF2646; Tue, 16 May 2023 12:42:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230516034218epcas2p297e9c5a33d370c8c45a40ab58f500ae0~fgr3zOgQb1126811268epcas2p2i;
        Tue, 16 May 2023 03:42:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516034217epsmtrp12df8fe95c51d0d523c4de4b1195e11b7~fgr3yVSRc2458124581epsmtrp1b;
        Tue, 16 May 2023 03:42:17 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-b9-6462fb9a5175
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.9C.28392.99BF2646; Tue, 16 May 2023 12:42:17 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516034217epsmtip19b4eb5e144b5e4667537203e89e44adf~fgr3knSMd0485804858epsmtip1c;
        Tue, 16 May 2023 03:42:17 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2] ufs: poll HCS.UCRDY before issuing a UIC command
Date:   Tue, 16 May 2023 12:33:32 +0900
Message-Id: <1684208012-114324-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmme6s30kpBgvvSlqcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxdYbO1ksbm45ymJxedccNovu6zvYLJYf/8dk
        0XX3BqPF0n9vWRz4PC5f8fZYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrg
        iMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6W0mh
        LDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQ
        nXHx6wv2gnfcFTM3tjM1MN7n7GLk5JAQMJE4/e4aC4gtJLCDUWLzY60uRi4g+xOjxIR/n5kh
        Ep8ZJdr+i8M0HPuznxGiaBejxJPdD9ggnB+MEke3nGAEqWIT0JR4enMqE0hCRGAfk8SSxYvB
        EswC6hK7JpxgArGFBVwkvh7ZB9TNwcEioCoxo7kUJMwr4CbR3HuJCWKbnMTNc53MIHMkBP6y
        Sxx9+pwRIuEi8atlCjOELSzx6vgWdghbSuJlfxs7yEwJgWyJPQvFIMIVEounvWWBsI0lZj1r
        ZwQpYQa6c/0ufYhqZYkjt1ggjuST6Dj8F2oIr0RHmxBEo7LEr0mTofZLSsy8eQdqp4fEvbeP
        WEDKhQRiJTZvT5/AKDsLYfwCRsZVjGKpBcW56anFRgWG8AhKzs/dxAhOhlquOxgnv/2gd4iR
        iYPxEKMEB7OSCG/7zPgUId6UxMqq1KL8+KLSnNTiQ4ymwLCayCwlmpwPTMd5JfGGJpYGJmZm
        huZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqYlLUPH3zGKfZGJOX7U06d5x4amuUB
        s0sPtcqvfLpIOyvK62/Mt0uTujaIF+hoKE1cJbzcQflEpcndw66booSjOGYsq9o5aYrEj5iJ
        c3ofrZj9/pVH9Xq2XQLrfl1bJbHv6JtGyXk3Da5PPXhyxqfjfh7cx7jaU3+HaH3dsCB2T2Hz
        fC7NOKdMH3GWS6mr067Hb3d5xl5weeNai3iO0pPmD7ibZgWeftViLvJWYUeigEnm20m1ioEs
        ciphD4Um7vWKjbq4KW3/W8V3Ozd/nf75+48LUydN43hn9uT6sd6SIL2cnNm+JrxmVgnPU605
        d8xhm5Cssqi1KvbXHJG2pPsZEstfLo174ZawQ7V6mpwJuxJLcUaioRZzUXEiAJ7iZBoPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnO7M30kpBi/3mFmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxdYbO1ksbm45ymJxedccNovu6zvYLJYf/8dk
        0XX3BqPF0n9vWRz4PC5f8fZYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrg
        iOKySUnNySxLLdK3S+DKuPj1BXvBO+6KmRvbmRoY73N2MXJySAiYSBz7s5+xi5GLQ0hgB6PE
        6jPnmCESkhIndj5nhLCFJe63HGGFKPrGKLHydSdYEZuApsTTm1OZQBIiAueYJHonnAfrYBZQ
        l9g14QQTiC0s4CLx9cg+ti5GDg4WAVWJGc2lIGFeATeJ5t5LTBAL5CRunutknsDIs4CRYRWj
        ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnCgamntYNyz6oPeIUYmDsZDjBIczEoivO0z
        41OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYFoyj+8m
        xxe3nJJAJQmvM9POaW7ceULm4+8VHNs9eFfNi5Z7dNotJ7r8S/v0CZXL3SvC655dzwkt33v6
        7IUYhumNp+79X8YhMG3mUrGnf+dqhzevyeo2mNfU8f5tvNTuDc3CksuOf1fZ7rTogdRFr4nL
        DJ6amkVb8aqFXN3j8SSv4pLL8tQjTa9SBZ5rL+JpVLnDuGVOMMO9GYb909QXOjj1X8qR6c8/
        Jrji5PUpetL85if4Cth/7YpX+5bAIlltqFhoLCshLbFe5vaLD3x7FuwWtDOaMz/a+qH6vYbZ
        C475aOgLsPE82a4Vtu3ixc1zd+6yT1j4ZAXnN978sGgBs+sWjmsWdLVU5q3lid52Z58SS3FG
        oqEWc1FxIgAzR3NcwwIAAA==
X-CMS-MailID: 20230516034218epcas2p297e9c5a33d370c8c45a40ab58f500ae0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230516034218epcas2p297e9c5a33d370c8c45a40ab58f500ae0
References: <CGME20230516034218epcas2p297e9c5a33d370c8c45a40ab58f500ae0@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: replace usleep_range with udelay
because it's a sleepable period.

With auto hibern8 enabled, UIC could be working
for a while to process a hibern8 operation and HCI
reports UIC not ready for a short term through HCS.UCRDY.
And UFS driver can't recognize the operation.
UFSHCI spec specifies UCRDY like this:
whether the host controller is ready to process UIC COMMAND

The 'ready' could be seen as many different meanings. If the meaning
includes not processing any request from HCI, processing a hibern8
operation can be 'not ready'. In this situation, the driver needs to
wait until the operations is completed.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..5f6819a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2365,7 +2365,18 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
-	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
+	ktime_t timeout = ktime_add_ms(ktime_get(), UIC_CMD_TIMEOUT);
+	u32 val = 0;
+
+	do {
+		val = ufshcd_readl(hba, REG_CONTROLLER_STATUS) &
+			UIC_COMMAND_READY;
+		if (val)
+			break;
+		udelay(500);
+	} while (ktime_before(ktime_get(), timeout));
+
+	return val ? true : false;
 }
 
 /**
-- 
2.7.4

