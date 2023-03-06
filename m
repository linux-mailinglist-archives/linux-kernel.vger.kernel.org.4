Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DF6AB4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCFDHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCFDHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:07:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FF61A64F;
        Sun,  5 Mar 2023 19:07:26 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVNhX0bBWznWHc;
        Mon,  6 Mar 2023 11:04:12 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 11:06:57 +0800
Subject: Re: [PATCH] scsi: hisi_sas: add a check of devm_add_action
To:     void0red <void0red@gmail.com>
References: <20230227031030.893324-1-void0red@gmail.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <4f60e3d9-976d-3e3a-b695-9ecc73818cd1@hisilicon.com>
Date:   Mon, 6 Mar 2023 11:06:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20230227031030.893324-1-void0red@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


ÔÚ 2023/2/27 11:10, void0red Ð´µÀ:
> From: Kang Chen <void0red@gmail.com>
>
> devm_add_action may fails, check it in the caller of
> interrupt_preinit_v3_hw
>
> Signed-off-by: Kang Chen <void0red@gmail.com>

Acked-by: Xiang Chen <chenxiang66@hisilicon.com>
Thanks!

> ---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 0c3fcb807..a63279f55 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -2495,8 +2495,7 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
>   	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
>   	shost->nr_hw_queues = hisi_hba->cq_nvecs;
>   
> -	devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
> -	return 0;
> +	return devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
>   }
>   
>   static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)

