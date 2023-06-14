Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235672F3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbjFNElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbjFNElY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:41:24 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381B1BF0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:41:23 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230614044121epoutp01970652524998e1873307e7df18fd2bff~obMtY5FeR2482124821epoutp01P
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:41:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230614044121epoutp01970652524998e1873307e7df18fd2bff~obMtY5FeR2482124821epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686717681;
        bh=g9zuD5hWV3D8uTkBVam4nTayIg9/mAMH6WeokaMNnoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=Yoepc9TNuV1DNPuj3jaDljfLIfa/9qMhB+I9p5P0XG3jY49Exsk/dYJbNodHulYJl
         OBKc/A05euXR+K5zPh1Sc6PHWXiTbXcjzM6kdoPDTxk3BkRmvpPDy+FHageA/UADpN
         HlrljJGdfYrZCkIeLJLq87Nyhf19FwBiCay4t+4U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230614044120epcas2p46f3eb503ee2f7c681ae7e6f5e99f6419~obMs5RR192937929379epcas2p46;
        Wed, 14 Jun 2023 04:41:20 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Qgt6R5Lgyz4x9Q4; Wed, 14 Jun
        2023 04:41:19 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.E7.44220.FE449846; Wed, 14 Jun 2023 13:41:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230614044119epcas2p19c8bab0dc260312661c7ccedaf7e34fa~obMrvmas13164031640epcas2p1f;
        Wed, 14 Jun 2023 04:41:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230614044119epsmtrp269770045a8ec578a472a621e46ffbee7~obMruZ1lq1509115091epsmtrp2q;
        Wed, 14 Jun 2023 04:41:19 +0000 (GMT)
X-AuditID: b6c32a48-9f1ff7000000acbc-9b-648944eff892
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.77.28392.FE449846; Wed, 14 Jun 2023 13:41:19 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230614044119epsmtip197657764673770e2e16f5be93b3c3ad1~obMrfNalu3161231612epsmtip1d;
        Wed, 14 Jun 2023 04:41:19 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v3 2/2] ufs: poll HCS.UCRDY before issuing a UIC command
Date:   Wed, 14 Jun 2023 13:31:56 +0900
Message-Id: <9c7ccbfb8fe05c29ab3e31d9cd14e6b91065b8b0.1686716811.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686716811.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1686716811.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhe57l84UgyufNSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZ847eYS9Yz1Nx+GQzcwPjXK4uRk4OCQETiXkbTzN1MXJxCAnsYJT4ue8A
        K4TziVFi6535UJnPjBIHvjQyw7SsedAEVbWLUWLiiZOMIAkhgR+MEu8XqIPYbAKaEk9vTgXr
        FhH4wCTxf/k2sCJmAXWJXRNOMIHYwgIeEntf/waaysHBIqAq8blHAyTMKxAt0fNpMxPEMjmJ
        m+c6wRZzClhK7Nu+kg2dLSGwlENiWqcXyBgJAReJy33OEGFhiVfHt7BD2FISn9/tZYMoyZbY
        s1AMIlwhsXjaWxYI21hi1rN2RpASZqDr1+/Sh6hWljhyiwXidD6JjsN/2SHCvBIdbUIQjcoS
        vyZNZoSwJSVm3rwDtdNDomX6CRZIOPUwSpy+eolxAqP8LIQFCxgZVzGKpRYU56anFhsVmMBj
        Ljk/dxMjOKVqeexgnP32g94hRiYOxkOMEhzMSiK8TzXaU4R4UxIrq1KL8uOLSnNSiw8xmgLD
        cCKzlGhyPjCp55XEG5pYGpiYmRmaG5kamCuJ837sUE4REkhPLEnNTk0tSC2C6WPi4JRqYJrt
        6H98ycLPf3/5X1m7oiq0IuNCxi8+3927qg84T2D+8MjZ5ltQRITWnupC/919nNO3Baw0OFOj
        5ljEtaFi/RqmU4u9Fzu0LfkZsP9ey8rc5Tl9tkGH+xj/it/MnbeNRW/z238bXkqfiPLZKSnl
        P63uwiLzU4Jr93Aphhj9lV25RUF87qSqJVrqTxeWVi2+ZbKvj+1IraRhravlk3OO1Xn3JVzn
        /tf9/S/cJj194ayjUz/uV5Kb13uN5ax4cl2KM2Psj+lZCb+4D/C7rlt66XzL6nqnksXrNxve
        v/K0f+d94Yqbp31O76nVzzyifWX9ZrbkmFDWqQc/f+Wa11AS5xx1zHxRlt77aDkf89i1hrJK
        LMUZiYZazEXFiQDQZgArMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO57l84Ug6PbuCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI4oLpuU1JzMstQifbsErox5R++wF6znqTh8spm5gXEuVxcjJ4eEgInEmgdN
        rCC2kMAORolde7Qh4pISJ3Y+Z4SwhSXutxwBquECqvnGKNH19h0zSIJNQFPi6c2pTCAJEYEm
        ZolLs6ezgCSYBdQldk04wQRiCwt4SOx9/RuogYODRUBV4nOPBkiYVyBaoufTZiaIBXISN891
        gs3kFLCU2Ld9JRvEQRYSK45tYsQlPoFRYAEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjODY0NLawbhn1Qe9Q4xMHIyHGCU4mJVEeJ9qtKcI8aYkVlalFuXHF5XmpBYfYpTmYFES
        573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLQtbDJj8U9vta+8cczKOosTftQIHH9Vd4d50cWg
        EhaFdzmmMvJTM3h/PEo8z6vzI4RFd1W889+T15Tv1+9+Gvprv7i/UOacrfsun7F7tXrD7tRV
        p/++69XYdCdebvP+qi18ezc0iqasb2z7J2i3UV/9YdCxs5kVfU6GC/zUXoftDNfvUzxWPPXw
        l+gIcf+OrZxTkv8+TAuvbHRZPG/SfIPO7QJOTF+X345/bWJi+4Xn5Ou5CjllbzU/iK9b2bR2
        0oU/B+8sCV0fu+BzTn5erNyjibyOH3pqZ0aW7O5PV7lkwCnPmCNSsYubu5N75uJ5O5YybLEI
        mCy/VrtYd++F4xUeEhLXtEUvXZ/EWD/9qLYSS3FGoqEWc1FxIgD8MjG6/AIAAA==
X-CMS-MailID: 20230614044119epcas2p19c8bab0dc260312661c7ccedaf7e34fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230614044119epcas2p19c8bab0dc260312661c7ccedaf7e34fa
References: <cover.1686716811.git.kwmad.kim@samsung.com>
        <CGME20230614044119epcas2p19c8bab0dc260312661c7ccedaf7e34fa@epcas2p1.samsung.com>
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
 drivers/ufs/core/ufshcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a89d39a..10ccc85 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
+#include <linux/iopoll.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
@@ -2365,7 +2366,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
-	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
+	u32 val;
+	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
+				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
+				    REG_CONTROLLER_STATUS);
+	return ret == 0 ? true : false;
 }
 
 /**
-- 
2.7.4

