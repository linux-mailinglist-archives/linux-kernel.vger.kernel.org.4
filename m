Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595216434F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiLETxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiLETxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:53:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8125F1;
        Mon,  5 Dec 2022 11:51:22 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5IoBkg011149;
        Mon, 5 Dec 2022 19:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=dtEd6a4+3KYTSgIBDPwj+osyJ6l7S6jVZGWZ/ou+Wjk=;
 b=FrFF1/cu7Jx1Tcidx8I663s6i7UvCrrqYWKW5vkGlUQ6lcHewvvwmlgRLEbNzHX79qSK
 ELBZyghvSGILs5shTvwh7+VdgqQ7tU+vnEIqCkVeKr43vvGMdxlVuLq+CDeYsaQ+hW2G
 pWbVWVhGFLetQ4aSWT5alaZwWJbdxm+Qh1jLJ0qg9NTCWYhA+lMn61fJBDdh0u3cVcTp
 J1ofVaGVTfg/JklQjv23/+u1khiJgB4e+EpglPTb1CCX6XN7qmYPJzicYvaXBaT+Orzx
 mYJw0ofrwSD1er4Irxu6W/kKOChQ6ZxxsM2pMrffbrNoj36jY0GUPIVEjLT3DXhtC6Et lw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7x264ts2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 19:50:58 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5JovAr019641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 19:50:57 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 11:50:56 -0800
Date:   Mon, 5 Dec 2022 11:50:50 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Mason Zhang <mason.zhang@mediatek.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Wang <peter.wang@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: core: fix device management cmd
 timeout flow
Message-ID: <20221205195050.GA15334@asutoshd-linux1.qualcomm.com>
References: <20221205014202.2672-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20221205014202.2672-1-mason.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nJRGdf4UKQ5kPTJyyJ06YFgUbQsM4Q4X
X-Proofpoint-ORIG-GUID: nJRGdf4UKQ5kPTJyyJ06YFgUbQsM4Q4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05 2022 at 17:53 -0800, Mason Zhang wrote:
>From: Mason Zhang <Mason.Zhang@mediatek.com>
>
>In ufs error handler flow, host will send device management cmd(NOP OUT)
>to device for recovery link. If cmd response timeout, and clear doorbell
>fail, ufshcd_wait_for_dev_cmd will do nothing and return,
>hba->dev_cmd.complete struct not set to null.
>
>In this time, if cmd has been responsed by device, then it will
>call complete() in __ufshcd_transfer_req_compl, because of complete
>struct is alloced in stack, then the KE will occur.
>
What is KE?

>Fix the following crash:
>  ipanic_die+0x24/0x38 [mrdump]
>  die+0x344/0x748
>  arm64_notify_die+0x44/0x104
>  do_debug_exception+0x104/0x1e0
>  el1_dbg+0x38/0x54
>  el1_sync_handler+0x40/0x88
>  el1_sync+0x8c/0x140
>  queued_spin_lock_slowpath+0x2e4/0x3c0
>  __ufshcd_transfer_req_compl+0x3b0/0x1164
>  ufshcd_trc_handler+0x15c/0x308
>  ufshcd_host_reset_and_restore+0x54/0x260
>  ufshcd_reset_and_restore+0x28c/0x57c
>  ufshcd_err_handler+0xeb8/0x1b6c
>  process_one_work+0x288/0x964
>  worker_thread+0x4bc/0xc7c
>  kthread+0x15c/0x264
>  ret_from_fork+0x10/0x30
>
>Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
>---
> drivers/ufs/core/ufshcd.c | 46 ++++++++++++++++++---------------------
> 1 file changed, 21 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>index b1f59a5fe632..2b4934a562a6 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -2979,35 +2979,31 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
> 		err = -ETIMEDOUT;
> 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
> 			__func__, lrbp->task_tag);
>-		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
>+		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0)
> 			/* successfully cleared the command, retry if needed */
> 			err = -EAGAIN;
>+		/*
>+		 * Since clearing the command succeeded we also need to
>+		 * clear the task tag bit from the outstanding_reqs
>+		 * variable.
>+		 */
Does this comment still hold true? Perhaps this needs to be updated?
Also, perhaps you missed Bart's comments in v1.
Also, please can you add a section for changes from v1 -> v2?

-asd

>+		spin_lock_irqsave(&hba->outstanding_lock, flags);
>+		pending = test_bit(lrbp->task_tag,
>+				   &hba->outstanding_reqs);
>+		if (pending) {
>+			hba->dev_cmd.complete = NULL;
>+			__clear_bit(lrbp->task_tag,
>+				    &hba->outstanding_reqs);
>+		}
>+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
>+
>+		if (!pending) {
> 			/*
>-			 * Since clearing the command succeeded we also need to
>-			 * clear the task tag bit from the outstanding_reqs
>-			 * variable.
>+			 * The completion handler ran while we tried to
>+			 * clear the command.
> 			 */
>-			spin_lock_irqsave(&hba->outstanding_lock, flags);
>-			pending = test_bit(lrbp->task_tag,
>-					   &hba->outstanding_reqs);
>-			if (pending) {
>-				hba->dev_cmd.complete = NULL;
>-				__clear_bit(lrbp->task_tag,
>-					    &hba->outstanding_reqs);
>-			}
>-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
>-
>-			if (!pending) {
>-				/*
>-				 * The completion handler ran while we tried to
>-				 * clear the command.
>-				 */
>-				time_left = 1;
>-				goto retry;
>-			}
>-		} else {
>-			dev_err(hba->dev, "%s: failed to clear tag %d\n",
>-				__func__, lrbp->task_tag);
>+			time_left = 1;
>+			goto retry;
> 		}
> 	}
>
>-- 
>2.18.0
>
