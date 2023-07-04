Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1474693B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGDFzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:55:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F6130;
        Mon,  3 Jul 2023 22:55:07 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QwBlj2CLHzLnWh;
        Tue,  4 Jul 2023 13:52:49 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 13:55:00 +0800
Subject: Re: [PATCH] scsi: hisi_sas: Fix potential deadlock on &hisi_hba->lock
To:     Chengfeng Ye <dg573847474@gmail.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
References: <20230628153010.57705-1-dg573847474@gmail.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <eb9476ed-8dc3-a7b6-7478-b7fba3d8e33b@hisilicon.com>
Date:   Tue, 4 Jul 2023 13:54:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20230628153010.57705-1-dg573847474@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


在 2023/6/28 星期三 23:30, Chengfeng Ye 写道:
> As &hisi_hba->lock is acquired by hard irq int_abnormal_v1_hw(),
> other acquisition of the same lock under process context should
> disable irq, otherwise deadlock could happen if the
> irq preempt the execution while the lock is held in process context
> on the same CPU.
>
> [Interrupt]: int_abnormal_v1_hw()
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1447
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:2050
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1079
>      -->spin_lock_irqsave(&hisi_hba->lock, flags);
>
> [Process Context]: hisi_sas_clear_nexus_ha()
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1932
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1135
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1116
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:1105
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:166
>      -->spin_lock(&hisi_hba->lock);
>
> [Process Context]: hisi_sas_dev_found()
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:665
>      -->spin_lock(&hisi_hba->lock);
>
> [Process Context]: hisi_sas_queue_command()
>      -->/root/linux/drivers/scsi/hisi_sas/hisi_sas_main.c:188
>      -->spin_lock(&hisi_hba->lock);
>
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock, which reported the above
> warning when analyzing the linux kernel 6.4-rc7 release.
>
> The tentative patch fix the potential deadlock by spin_lock_irqsave().

Thank you for reporting it.
But we consider about removing  hisi_hba->lock in function 
hisi_sas_port_notify_formed()
which is called by int_abnormal_v1_hw(), as we think it is not necessary 
to add hisi_hba->lock in this function.
So please ignore it and still thank you for pointing out the issue.

Thanks,
Shawn

>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 412431c901a7..47c5062a732e 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -161,11 +161,12 @@ static void hisi_sas_slot_index_clear(struct hisi_hba *hisi_hba, int slot_idx)
>   
>   static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
>   {
> +	unsigned long flags;
>   	if (hisi_hba->hw->slot_index_alloc ||
>   	    slot_idx < HISI_SAS_RESERVED_IPTT) {
> -		spin_lock(&hisi_hba->lock);
> +		spin_lock_irqsave(&hisi_hba->lock, flags);
>   		hisi_sas_slot_index_clear(hisi_hba, slot_idx);
> -		spin_unlock(&hisi_hba->lock);
> +		spin_unlock_irqrestore(&hisi_hba->lock, flags);
>   	}
>   }
>   
> @@ -181,11 +182,12 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>   {
>   	int index;
>   	void *bitmap = hisi_hba->slot_index_tags;
> +	unsigned long flags;
>   
>   	if (rq)
>   		return rq->tag + HISI_SAS_RESERVED_IPTT;
>   
> -	spin_lock(&hisi_hba->lock);
> +	spin_lock_irqsave(&hisi_hba->lock, flags);
>   	index = find_next_zero_bit(bitmap, HISI_SAS_RESERVED_IPTT,
>   				   hisi_hba->last_slot_index + 1);
>   	if (index >= HISI_SAS_RESERVED_IPTT) {
> @@ -193,13 +195,13 @@ static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>   				HISI_SAS_RESERVED_IPTT,
>   				0);
>   		if (index >= HISI_SAS_RESERVED_IPTT) {
> -			spin_unlock(&hisi_hba->lock);
> +			spin_unlock_irqrestore(&hisi_hba->lock, flags);
>   			return -SAS_QUEUE_FULL;
>   		}
>   	}
>   	hisi_sas_slot_index_set(hisi_hba, index);
>   	hisi_hba->last_slot_index = index;
> -	spin_unlock(&hisi_hba->lock);
> +	spin_unlock_irqrestore(&hisi_hba->lock, flags);
>   
>   	return index;
>   }
> @@ -658,11 +660,12 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
>   {
>   	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
>   	struct hisi_sas_device *sas_dev = NULL;
> +	unsigned long flags;
>   	int last = hisi_hba->last_dev_id;
>   	int first = (hisi_hba->last_dev_id + 1) % HISI_SAS_MAX_DEVICES;
>   	int i;
>   
> -	spin_lock(&hisi_hba->lock);
> +	spin_lock_irqsave(&hisi_hba->lock, flags);
>   	for (i = first; i != last; i %= HISI_SAS_MAX_DEVICES) {
>   		if (hisi_hba->devices[i].dev_type == SAS_PHY_UNUSED) {
>   			int queue = i % hisi_hba->queue_count;
> @@ -682,7 +685,7 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
>   		i++;
>   	}
>   	hisi_hba->last_dev_id = i;
> -	spin_unlock(&hisi_hba->lock);
> +	spin_unlock_irqrestore(&hisi_hba->lock, flags);
>   
>   	return sas_dev;
>   }

