Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BA6EA8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDULFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDULFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:05:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E39013;
        Fri, 21 Apr 2023 04:05:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LB1R9l016474;
        Fri, 21 Apr 2023 11:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VORdF8L+8h/i+KPNmACF69HETqtwPJvceFFMYDoUfrg=;
 b=Q3dxV9zEVagfVWLSH+hDpcbcAHa7kjxIM2tzBj1LknoLWnAzWmX9mvrKP2qn0AknV07o
 JVGLeYRwMVBW235W4iFbgy07VdP8WZ0ksFilGFd8aitL7FDOGnkWh1edftAnKv1vmloo
 vmIvZIf6Tpuv91chuymwttWIBcPT4sZ4gZDaWpEBozFPDtJCpgyAjapKg3txlC2xwrqR
 LRvnAAmJ5+TMkqtJiacjtAY+EGeL/HQ6/Ner97qKW6yUWJvJEVv4sF2RizJNzi6U1AHd
 YtfAumC0Gz35UctlDkCWapdZYiNsxaNA/NQ8dk1n0heQ7WwQA3bWnAH6L5WWkO8hpCZL Lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3e34sar9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 11:05:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LB5CGX024180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 11:05:12 GMT
Received: from [10.110.31.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 21 Apr
 2023 04:05:07 -0700
Message-ID: <b8c0b908-1947-6b6a-6b01-42289a521e5e@quicinc.com>
Date:   Fri, 21 Apr 2023 19:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] ufs: core: fix &hwq->cq_lock deadlock issue
To:     Alice Chao <alice.chao@mediatek.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <quic_asutoshd@quicinc.com>, <mani@kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <stanley.chu@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <powen.kao@mediatek.com>,
        <naomi.chu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <eddie.huang@mediatek.com>,
        <wsd_upstream@mediatek.com>
References: <20230421075636.24946-1-alice.chao@mediatek.com>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20230421075636.24946-1-alice.chao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4k1ChLXiNHPUbNdOMLEi6aMoZ46W3XH9
X-Proofpoint-GUID: 4k1ChLXiNHPUbNdOMLEi6aMoZ46W3XH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_04,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210095
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2023 3:56 PM, Alice Chao wrote:
> [name:lockdep&]WARNING: inconsistent lock state
> [name:lockdep&]--------------------------------
> [name:lockdep&]inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [name:lockdep&]kworker/u16:4/260 [HC0[0]:SC0[0]:HE1:SE1] takes:
>    ffffff8028444600 (&hwq->cq_lock){?.-.}-{2:2}, at:
> ufshcd_mcq_poll_cqe_lock+0x30/0xe0
> [name:lockdep&]{IN-HARDIRQ-W} state was registered at:
>    lock_acquire+0x17c/0x33c
>    _raw_spin_lock+0x5c/0x7c
>    ufshcd_mcq_poll_cqe_lock+0x30/0xe0
>    ufs_mtk_mcq_intr+0x60/0x1bc [ufs_mediatek_mod]
>    __handle_irq_event_percpu+0x140/0x3ec
>    handle_irq_event+0x50/0xd8
>    handle_fasteoi_irq+0x148/0x2b0
>    generic_handle_domain_irq+0x4c/0x6c
>    gic_handle_irq+0x58/0x134
>    call_on_irq_stack+0x40/0x74
>    do_interrupt_handler+0x84/0xe4
>    el1_interrupt+0x3c/0x78
> <snip>
>
> Possible unsafe locking scenario:
>         CPU0
>         ----
>    lock(&hwq->cq_lock);
>    <Interrupt>
>      lock(&hwq->cq_lock);
>    *** DEADLOCK ***
> 2 locks held by kworker/u16:4/260:
>
> [name:lockdep&]
>   stack backtrace:
> CPU: 7 PID: 260 Comm: kworker/u16:4 Tainted: G S      W  OE
> 6.1.17-mainline-android14-2-g277223301adb #1
> Workqueue: ufs_eh_wq_0 ufshcd_err_handler
>
>   Call trace:
>    dump_backtrace+0x10c/0x160
>    show_stack+0x20/0x30
>    dump_stack_lvl+0x98/0xd8
>    dump_stack+0x20/0x60
>    print_usage_bug+0x584/0x76c
>    mark_lock_irq+0x488/0x510
>    mark_lock+0x1ec/0x25c
>    __lock_acquire+0x4d8/0xffc
>    lock_acquire+0x17c/0x33c
>    _raw_spin_lock+0x5c/0x7c
>    ufshcd_mcq_poll_cqe_lock+0x30/0xe0
>    ufshcd_poll+0x68/0x1b0
>    ufshcd_transfer_req_compl+0x9c/0xc8
>    ufshcd_err_handler+0x3bc/0xea0
>    process_one_work+0x2f4/0x7e8
>    worker_thread+0x234/0x450
>    kthread+0x110/0x134
>    ret_from_fork+0x10/0x20
>
> ufs_mtk_mcq_intr() could refer to
> https://lore.kernel.org/all/20230328103423.10970-3-powen.kao@mediatek.com/
>
> When ufshcd_err_handler() is executed, CQ event interrupt can enter
> waiting for the same lock. It could happened in upstream code path
> ufshcd_handle_mcq_cq_events() and also in ufs_mtk_mcq_intr(). This
> warning message will be generated when &hwq->cq_lock is used in IRQ
> context with IRQ enabled. Use ufshcd_mcq_poll_cqe_lock() with
> spin_lock_irqsave instead of spin_lock to resolve the deadlock issue.
>
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 31df052fbc41..202ff71e1b58 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -299,11 +299,11 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
>   unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
>   				       struct ufs_hw_queue *hwq)
>   {
> -	unsigned long completed_reqs;
> +	unsigned long completed_reqs, flags;
>   
> -	spin_lock(&hwq->cq_lock);
> +	spin_lock_irqsave(&hwq->cq_lock, flags);
>   	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
> -	spin_unlock(&hwq->cq_lock);
> +	spin_unlock_irqrestore(&hwq->cq_lock, flags);
>   
>   	return completed_reqs;
>   }

Reviewed-by: Can Guo <quic_cang@quicinc.com>


Thanks for the fix.


Regards,

Can Guo.

