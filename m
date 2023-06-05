Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A8721B74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjFEBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEBZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:25:14 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86721D2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:25:11 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230605012509epoutp0318a40bc6d650c1da4786bb0d0d70053b~lnt2Dpw6B0809508095epoutp03k
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:25:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230605012509epoutp0318a40bc6d650c1da4786bb0d0d70053b~lnt2Dpw6B0809508095epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685928309;
        bh=J6GPQiDtdeh7brTnKih0m6/A+ppMxCkrZRZuPJUdNqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=muebvpNKs1m0nZh0HVee+ZmM6UJ5y20TUpAEzqwNwGO06IWvMWpPL+M4Qt//ye2aO
         QI00dW6Z+uxHS4AgR54yAwecHrlAhBPBat3LI4wqc8dgWipxvu4S+ZPr9e/IBoyi9Y
         BvDwpDwxryi6b3Zw3VK4rkDQL/LnoB90LBlfMWwo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230605012509epcas2p109f9f7dfa824db5359fa6e0cf9c6cf45~lnt1hpcGc2538025380epcas2p1R;
        Mon,  5 Jun 2023 01:25:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QZGBD1QBFz4x9Px; Mon,  5 Jun
        2023 01:25:08 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.25.44220.4793D746; Mon,  5 Jun 2023 10:25:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230605012507epcas2p3ecc0a358b558fe09d74a56b67b6477d2~lnt0FbGEa3273732737epcas2p3J;
        Mon,  5 Jun 2023 01:25:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605012507epsmtrp18beffe8983917dc8edd6be3b61cf23e4~lnt0Er2rd2747127471epsmtrp1I;
        Mon,  5 Jun 2023 01:25:07 +0000 (GMT)
X-AuditID: b6c32a48-c3ff87000000acbc-a9-647d39747a45
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.28.28392.3793D746; Mon,  5 Jun 2023 10:25:07 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605012507epsmtip2c6d793083223c491e1ed92ef5511324a~lntz4m1vv2416324163epsmtip2_;
        Mon,  5 Jun 2023 01:25:07 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2 2/3] ufs: poll HCS.UCRDY before issuing a UIC command
Date:   Mon,  5 Jun 2023 10:15:53 +0900
Message-Id: <40006660eaece22f76b9532c70479d719655b33f.1685927620.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1685927620.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1685927620.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhW6JZW2KQUsrh8XJJ2vYLB7M28Zm
        8fLnVTaLgw87WSymffjJbLF68QMWi0U3tjFZ7PrbzGSx9cZOFoubW46yWFzeNYfNovv6DjaL
        5cf/MVl03b3BaLH031sWB36Py1e8PRbvecnkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWjx+dNch7t
        B7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gI5XUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnvJ11gbXgHXfFvWfNjA2M9zm7GDk5JARMJN5e3sXYxcjFISSwg1FiR+t5RpCEkMAn
        RolPZxMhEp8ZJa7u/MIG09Fz8C8rRGIXo0THm9lMEM4PoKrvu5lAqtgENCWe3pwKZosI3GCS
        eNIvCmIzC6hL7JpwAiwuLOAhcftxOzOIzSKgKnH/yjGw1bwC0RKvjnyD2iYncfNcJ1gNp4Cl
        xNm3f9hR2VxANXM5JJ58WMUK0eAi8XXxE3YIW1ji1fEtULaUxMv+NiCbA8jOltizUAwiXCGx
        eNpbFgjbWGLWs3ZGkBJmoPvX79KHqFaWOHKLBeJ6PomOw3+hhvBKdLQJQTQqS/yaNJkRwpaU
        mHnzDtROD4nHm+4wQ0Knh1Gi/XAX+wRG+VkICxYwMq5iFEstKM5NTy02KjCBx11yfu4mRnAy
        1fLYwTj77Qe9Q4xMHIyHGCU4mJVEeHd5VacI8aYkVlalFuXHF5XmpBYfYjQFBuNEZinR5Hxg
        Os8riTc0sTQwMTMzNDcyNTBXEuf92KGcIiSQnliSmp2aWpBaBNPHxMEp1cDEVFo6p0PhuM7T
        uqs/2nJSl7ka6itZOEas4vuu17ibyfisdBMju+Ik1f8XvK7tOKN+4um3jjlP7jqsebn795aE
        /R9yggtzzn5wYokrZO2TaYwT2u/vVhNw/uvh3bWHu8VX50+95xmu9yvEOcPk027uJ0zqa6aJ
        pgXmZC9IFn+wQDll7kGh5ZeldWNdQwODXrGKnwkwmDbrTHz6WoVdQl9FGHhCbQ27otcZz80T
        XlEQkZuU3VFSk67bMl1VpSnOLrzCcNqM4x9XxEyre73auDxxajfX4aifYecUajXf31T5eOzE
        aX8BSV/hgvaoHQemp4eGL4uZHzfZ4OiV5C6PRMaMZ++4eot9bI6wb4o6p8RSnJFoqMVcVJwI
        AB3siMEvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG6xZW2KwbtuJYuTT9awWTyYt43N
        4uXPq2wWBx92slhM+/CT2WL14gcsFotubGOy2PW3mcli642dLBY3txxlsbi8aw6bRff1HWwW
        y4//Y7LounuD0WLpv7csDvwel694eyze85LJY8KiA4we39d3sHl8fHqLxaNvyypGj8+b5Dza
        D3QzBXBEcdmkpOZklqUW6dslcGW8nXWBteAdd8W9Z82MDYz3ObsYOTkkBEwkeg7+Ze1i5OIQ
        EtjBKPHk0A0WiISkxImdzxkhbGGJ+y1HoIq+MUq8nPiODSTBJqAp8fTmVCaQhIjAKyaJuf9P
        gXUwC6hL7JpwggnEFhbwkLj9uJ0ZxGYRUJW4f+UYWA2vQLTEqyPf2CA2yEncPNcJVsMpYClx
        9u0f9i5GDqBtFhKN+41xCE9gFFjAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4
        IrS0djDuWfVB7xAjEwfjIUYJDmYlEd5dXtUpQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2M
        FxJITyxJzU5NLUgtgskycXBKNTBFzlla6baZ7cCBTPt9DNodp5beOfJPmPG/xXw+VSbLLx8Z
        hPaG5UgLX/rPH2h8ZFa19cMkxbsH7yr//RhWc3OmhwKL567NxnaPGWoeJHTt8KvtO8vmMI9v
        irzlrcpZE5Icejcd/HD5Vd1C/ffTmw7v//vt6SLFtQwh7p9d/zw0OfhO2HfdxJsxqz9vSVgU
        Ihr0Pe72tk2rwhQ+RU95day6JnHL3AMTjxY3smq9XTzDunLVHd7F6vbGh3/Iztgbznrxg1Qs
        607Lw6lP923YpvS/pPj8Ns6nM1kjt5bf/GybbShx7P2Pjq85zxd+jldKt1Pou/+MY7d53Kxr
        Mny+Z10/8gncsElZ0jMvlIeD6eezC0osxRmJhlrMRcWJAHeO/iX3AgAA
X-CMS-MailID: 20230605012507epcas2p3ecc0a358b558fe09d74a56b67b6477d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605012507epcas2p3ecc0a358b558fe09d74a56b67b6477d2
References: <cover.1685927620.git.kwmad.kim@samsung.com>
        <CGME20230605012507epcas2p3ecc0a358b558fe09d74a56b67b6477d2@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index a89d39a..1f58a20 100644
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

