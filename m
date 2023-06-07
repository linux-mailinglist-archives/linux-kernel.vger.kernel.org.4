Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9578972534F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjFGF1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjFGF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:27:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF6198C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:27:18 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230607052714epoutp02d1610079764321ed1e585290cab53f0b~mSTyNAzSQ2408124081epoutp02J
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:27:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230607052714epoutp02d1610079764321ed1e585290cab53f0b~mSTyNAzSQ2408124081epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686115634;
        bh=WtAay7ZH+0zudUhhdKoG6pF43sami9LcwRt3YIZcilQ=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=g6dzppa0IEB3U3vkds8U681JBlqOyNRMzWjQl6kWFBQNNCQvPMZnAob51TBaUiCxt
         B0KaSgCKBpHUfQleOt86C1gbAecg1ebSqhlKK8+oKbxGbBw+tYBgcOa7/4k+3NqE5c
         yOdjgfziPlF9aYEWFVHurLxorIZUDdGcZalbywjQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230607052714epcas2p327b9cc0d386e4905eca855a571713801~mSTxzt3ak0994009940epcas2p3f;
        Wed,  7 Jun 2023 05:27:14 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QbbSd592xz4x9Q1; Wed,  7 Jun
        2023 05:27:13 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-b9-64801530af92
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.67.17293.03510846; Wed,  7 Jun 2023 14:27:12 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] ufs: core: Combine ufshcd_mq_poll_cqe functions
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230601225048.12228-1-stanley.chu@mediatek.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230607052712epcms2p3b765b9be7e67190a3286e5fb2992349e@epcms2p3>
Date:   Wed, 07 Jun 2023 14:27:12 +0900
X-CMS-MailID: 20230607052712epcms2p3b765b9be7e67190a3286e5fb2992349e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmha6haEOKwXdOiwfztrFZvPx5lc1i
        2oefzBYvD2laPLr9jNFi0Y1tTBaXd81hs+i+voPNYvnxf0wWS7feZHTg8rh8xdtjwqIDjB4t
        J/ezeHx8eovFo2/LKkaPz5vkPNoPdDMFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
        KTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM549PApY8ELvorJN2cwNjAe5eli5OSQEDCR6Lnw
        irGLkYtDSGAHo8STw3PYuxg5OHgFBCX+7hAGqREWcJd48q+RHcQWElCS6Fq4lRkibiCxbvoe
        MJtNQE9iyu87YHNEBCYzSxzduogVYgGvxIz2pywQtrTE9uVbGUFsTgE7ieVn77FDxDUkfizr
        ZYawRSVurn7LDmO/PzafEcIWkWi9dxaqRlDiwc/dUHFJidYzW9kg7HqJ1ven2EGOkBCYwCjR
        eOwP1CB9iWsdG8GO4BXwlVg05TpYnEVAVeLLn49QQ10k1lzYBWYzC8hLbH87hxkUEMwCmhLr
        d+mDmBICyhJHbrFAVPBJdBz+yw7zYsPG31jZO+Y9YYKw1SQeLdgCDRIZiYtzzjFPYFSahQjp
        WUj2zkLYu4CReRWjWGpBcW56arFRgRE8cpPzczcxgtOpltsOxilvP+gdYmTiYDzEKMHBrCTC
        m2VfnyLEm5JYWZValB9fVJqTWnyI0RTo44nMUqLJ+cCEnlcSb2hiaWBiZmZobmRqYK4kzitt
        ezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgSkvyWyi73XX57uDE7Wjrn+ZEnyVMzk2X4qhWNjOzyzb
        /GSAXTDjTKNFFw5F3fjKkHdHbMm3V+/Oc0yReK1+fIWs3pqKN0fXr5rVJbnd7nTewfWdAZts
        MhfF2OWdYHEVYLjwLzxiNkOleuXc//pyWZ6u9x5P/vnrTGLwam3L01tjOQ0FzqQ83aP2ZOOV
        uZKh6/In/FVhDmA1aVrMHmiy2PXXAZ5YqX9PRCT6n06eXcZ4cJXd5swHlSfUr3ucjd18ZDKf
        v9HUD/b69deyp04LS7eRfHG6eYv9Su5uw1627jmH14me9Gc63vZg0evKpxd8jIsrcze/1Xrk
        sH99kHVX4a3tG3l3zDXS2NVQorF8YawSS3FGoqEWc1FxIgA4rzn1MAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230601225112epcas2p1469011fa8e11c1c31c1f867daeab106f
References: <20230601225048.12228-1-stanley.chu@mediatek.com>
        <CGME20230601225112epcas2p1469011fa8e11c1c31c1f867daeab106f@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Currently, ufshcd_mcq_poll_cqe_nolock() is only called by
>ufshcd_mcq_poll_cqe_lock() with the addition of a spinlock wrapper
>for ufshcd_mcq_poll_cqe_nolock(). Combining these two functions
>into one would result in cleaner code.
>
>Reviewed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
>---
> drivers/ufs/core/ufs-mcq.c | 17 ++++-------------
> 1 file changed, 4 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
>index 920eb954f594..785fc9762cad 100644
>--- a/drivers/ufs/core/ufs-mcq.c
>+++ b/drivers/ufs/core/ufs-mcq.c
>@@ -307,11 +307,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
> 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
> }
> 
>-static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
>-						struct ufs_hw_queue *hwq)
>+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
>+				       struct ufs_hw_queue *hwq)
> {
> 	unsigned long completed_reqs = 0;
>+	unsigned long flags;
> 
>+	spin_lock_irqsave(&hwq->cq_lock, flags);
> 	ufshcd_mcq_update_cq_tail_slot(hwq);
> 	while (!ufshcd_mcq_is_cq_empty(hwq)) {
> 		ufshcd_mcq_process_cqe(hba, hwq);
>@@ -321,17 +323,6 @@ static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
> 
> 	if (completed_reqs)
> 		ufshcd_mcq_update_cq_head(hwq);
>-
>-	return completed_reqs;
>-}
>-
>-unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
>-				       struct ufs_hw_queue *hwq)
>-{
>-	unsigned long completed_reqs, flags;
>-
>-	spin_lock_irqsave(&hwq->cq_lock, flags);
>-	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
> 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
> 
> 	return completed_reqs;
>-- 
>2.18.0
>

Looks good to me.

Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong
