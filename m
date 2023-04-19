Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5926E76A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjDSJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjDSJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:48:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF7559F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:47:59 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419094757epoutp030c9467d636122a92ffdcd42bea2b3347~XTQbQULBn0647806478epoutp03T
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419094757epoutp030c9467d636122a92ffdcd42bea2b3347~XTQbQULBn0647806478epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681897677;
        bh=VFJuBEof/y38eZrTiAe8AhvGQtXPCzTDUesnipszi3w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DTfzV1onWOHBmY3ri5DScGAtMknhlqt3WyeWEbZzbHNiGQpQPCMxYw7xx7OmCfXgV
         arAxxpHPdf6Gekkfbck3bXtt4MMpXAp3SFVIOczOeacDxdd5r+UcK3wLZ4IcDyIaaN
         Rx/HYo9uK172grc9jhONrmlgzVajwkQRD31RBFRI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230419094756epcas2p33b2148ddef3dc030b19019039677c621~XTQaeVgz61652816528epcas2p3F;
        Wed, 19 Apr 2023 09:47:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q1bZ36dZKz4x9Py; Wed, 19 Apr
        2023 09:47:55 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.40.09650.BC8BF346; Wed, 19 Apr 2023 18:47:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad~XTQYmj7t_0901709017epcas2p3x;
        Wed, 19 Apr 2023 09:47:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419094754epsmtrp2d61a439e51d695b92ac277ecdba8adc8~XTQYlYn4f2251822518epsmtrp2s;
        Wed, 19 Apr 2023 09:47:54 +0000 (GMT)
X-AuditID: b6c32a48-dc7ff700000025b2-83-643fb8cba246
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.EA.08609.AC8BF346; Wed, 19 Apr 2023 18:47:54 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419094754epsmtip1c90a028ae5921eda98715c5e5d8c3afd~XTQYWSC8H1590715907epsmtip11;
        Wed, 19 Apr 2023 09:47:54 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: mcq: add 1 to the max Queues value
Date:   Wed, 19 Apr 2023 18:48:38 +0900
Message-Id: <20230419094838.136349-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmme7pHfYpBmvmGFk8mLeNzeLlz6ts
        FgcfdrJYfF36jNVi2oefzBarFz9gsVh0YxuTxc0tR1ksLu+aw2bRfX0Hm8Xy4/+YLKa+OM5u
        0XX3BqMDr8flK94eExYdYPT4vr6DzePj01ssHhP31Hn0bVnF6PF5k5xH+4FupgCOqGybjNTE
        lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCLlRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGRcfvWEv
        WMRVcatvB2MD426OLkZODgkBE4lNu/eyg9hCAjsYJeYuz+1i5AKyPzFKvJx6hQnC+cwoMWXH
        ZTaYjqMLrjNCJHYxSmzo7GSBcH4wShz/+RtsFpuAhsSaY4fA2kUEVjBJnL97mxUkwSygJvH5
        7jIWEFtYwFFiwsblYGNZBFQlfpx9CGbzClhJPGr8xgqxTl5iUcNvJoi4oMTJmU9YIObISzRv
        nc0MUbOQQ+Li8mgI20Vi25p9TBC2sMSr41vYIWwpic/v9kK9kC3RuGctVLxCYu7myYwQtrHE
        rGftQDYH0HxNifW79EFMCQFliSO3oLbySXQc/ssOEeaV6GgTgmhUkjgz9zZUWELi4OwciLCH
        xLz325gggRsrceHAZNYJjPKzkLwyC8krsxDWLmBkXsUollpQnJueWmxUYAKP0uT83E2M4CSr
        5bGDcfbbD3qHGJk4GA8xSnAwK4nwnnG1ShHiTUmsrEotyo8vKs1JLT7EaAoM3InMUqLJ+cA0
        n1cSb2hiaWBiZmZobmRqYK4kzvuxQzlFSCA9sSQ1OzW1ILUIpo+Jg1Oqgcl/V5nu+Qqmg12a
        szauKeUz3lU9p6nwnug2uaKkXccnHPjJ/YH/x9037/Ucco03KXh+PTx7b8GG683Fm6b9Wcay
        d5KIFkdlQdob/7gQ1uPv21S/5sqtCinTYdpmqak36Z9uw0EhhZorJh1feWS17hwVPtgtnHzO
        RjDFY4/269b0huyVsQve7Lfje3OmpkGsslJ5awwH39GNj+avdDo97W9D15u+yQcWfFoQJ3p3
        5eTTPbc1Vz+S+BQhPnVHzYPGWRrHYnaYPtjgvf2GNBdb9f19apMDy3e+mmX7cWHIykOPPrVw
        6qzg/aSkxf9xyx2N9IvC293zDk+IWPAm+uiJu2x9s1R2zS5eoSag9lhkvdRRJZbijERDLeai
        4kQA73D9YjsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO6pHfYpBt/mKVo8mLeNzeLlz6ts
        FgcfdrJYfF36jNVi2oefzBarFz9gsVh0YxuTxc0tR1ksLu+aw2bRfX0Hm8Xy4/+YLKa+OM5u
        0XX3BqMDr8flK94eExYdYPT4vr6DzePj01ssHhP31Hn0bVnF6PF5k5xH+4FupgCOKC6blNSc
        zLLUIn27BK6Mi4/esBcs4qq41beDsYFxN0cXIyeHhICJxNEF1xm7GLk4hAR2MErcvfeLFSIh
        IfF/cRMThC0scb/lCCtE0TdGiTV3J7CDJNgENCTWHDvEBJIQEdjGJHF/+SKwbmYBNYnPd5ex
        gNjCAo4SEzYuZwOxWQRUJX6cfQhm8wpYSTxq/Aa1TV5iUcNvJoi4oMTJmU+AejmA5qhLrJ8n
        BDFSXqJ562zmCYz8s5BUzUKomoWkagEj8ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxN
        jOBY0dLawbhn1Qe9Q4xMHIyHGCU4mJVEeM+4WqUI8aYkVlalFuXHF5XmpBYfYpTmYFES573Q
        dTJeSCA9sSQ1OzW1ILUIJsvEwSnVwOSbNetrweYPRucW/bbpjSoRsjxxVFfjBrv7jQj5ZZeP
        zV7wWb1xAe9r9ZPfr9Vz5BmwS/Fm3Qx8YfvgkUQe//d0p3+s5YrTnMWWtxdUnvhitvadNJui
        nn3Bg8q6uctXHGd6v+aVlnzNzPmb5KpuZ1wLnj/Txu3kuT/8zBuffSuVazzrdqhkjuJfueva
        a5pXrL3Kz5bAfzfvxw6lFbl/HRXFt/+1kroxTb+V6zTbne+bZ/26t3mH9YKjLDtyvd6lR07b
        u7xiek7Ey5mzz8+2khDn4HcVmNBTpGrAKbiVUeGm/H4OX3NruQbbpQtjTzzo2bf9pvyvGVF3
        2M24f2xbvOmpTo1WT+NhM1PPSw3+rZlKLMUZiYZazEXFiQAtXRRIBAMAAA==
X-CMS-MailID: 20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad
References: <CGME20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad@epcas2p3.samsung.com>
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

If read the MAXQ field value verbatim, can use a value
that is one less than the supported Queue.
So read the MAXQ field value and incremented it by one

below is the specification
Maximum number of Queues (MAXQ):
Maximum number of Queues this controller can support.
In this version of specification, maximum value is 31.

NOTE To support 1:1 topology, the Host HW controller must support
HW resources for MAXQ number of Completion Queues too.
Host SW may use less number of completion queues for N:1 topology..:1 Queue
0: 1 Queue
1: 2 Queues
…
31: 32 Queues
32-255 : reserved

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufs-mcq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 31df052fbc41..a1ee3318c605 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -150,7 +150,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	u32 hba_maxq, rem, tot_queues;
 	struct Scsi_Host *host = hba->host;
 
-	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
+	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
 
 	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
 			rw_queues;
-- 
2.26.0

