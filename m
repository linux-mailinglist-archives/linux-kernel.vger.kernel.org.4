Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0F5F3C92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJDFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:55:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5AC1E714;
        Mon,  3 Oct 2022 22:55:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1841F8FB;
        Tue,  4 Oct 2022 05:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664862945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkmFtYmmX+2BenHfW53ftCivWbwKa9jY3LRyOCkro6M=;
        b=hFgPL0dvbQA7HMOXybgNs637sPm1hQS0Hg/RWeEQXIZz/3xmXwvV5Pk4CT1u+8k3CSNcCh
        tzFrKYoqcGpSRDEXaOasofIvdCnez8VHMdI7V6jKj6JxJET33Bqz0b3dM7FJNyL9oRTt4Z
        EI+60XV8joydCmLu7nlyHdDPDDi9d54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664862945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkmFtYmmX+2BenHfW53ftCivWbwKa9jY3LRyOCkro6M=;
        b=obHj3oZnLSAX/BeO9yPzm+SPJFRi6+2D5gNs36P9F6kmrXsSABWs+lcb/Es+q/ark3sW1W
        cMIL4KuMh2BlnQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3CEE139EF;
        Tue,  4 Oct 2022 05:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G8fcLuDKO2NrDwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Oct 2022 05:55:44 +0000
Message-ID: <08d85db7-679b-b099-485b-744b8bb22839@suse.de>
Date:   Tue, 4 Oct 2022 07:55:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 6/6] scsi: mvsas: Use sas_task_find_rq() for tagging
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-7-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1664528184-162714-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 10:56, John Garry wrote:
> The request associated with a scsi command coming from the block layer
> has a unique tag, so use that when possible for getting a slot.
> 
> Unfortunately we don't support reserved commands in the SCSI midlayer yet.
> As such, SMP tasks - as an example - will not have a request associated, so
> in the interim continue to manage those tags for that type of sas_task
> internally.
> 
> We reserve an arbitrary 4 tags for these internal tags. Indeed, we already
> decrement MVS_RSVD_SLOTS by 2 for the shost can_queue when flag
> MVF_FLAG_SOC is set. This change was made in commit 20b09c2992fef
> ("[PATCH] [SCSI] mvsas: add support for 94xx; layout change; bug fixes"),
> but what those 2 slots are used for is not obvious.
> 
> Also make the tag management functions static, where possible.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/mvsas/mv_defs.h |  1 +
>   drivers/scsi/mvsas/mv_init.c |  9 +++++----
>   drivers/scsi/mvsas/mv_sas.c  | 38 ++++++++++++++++++++++++------------
>   drivers/scsi/mvsas/mv_sas.h  |  7 +------
>   4 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
> index 7123a2efbf58..8ef174cd4d37 100644
> --- a/drivers/scsi/mvsas/mv_defs.h
> +++ b/drivers/scsi/mvsas/mv_defs.h
> @@ -40,6 +40,7 @@ enum driver_configuration {
>   	MVS_ATA_CMD_SZ		= 96,	/* SATA command table buffer size */
>   	MVS_OAF_SZ		= 64,	/* Open address frame buffer size */
>   	MVS_QUEUE_SIZE		= 64,	/* Support Queue depth */
> +	MVS_RSVD_SLOTS		= 4,
>   	MVS_SOC_CAN_QUEUE	= MVS_SOC_SLOTS - 2,
>   };
>   
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index c85fb812ad43..cfe84473a515 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -142,7 +142,7 @@ static void mvs_free(struct mvs_info *mvi)
>   		scsi_host_put(mvi->shost);
>   	list_for_each_entry(mwq, &mvi->wq_list, entry)
>   		cancel_delayed_work(&mwq->work_q);
> -	kfree(mvi->tags);
> +	kfree(mvi->rsvd_tags);
>   	kfree(mvi);
>   }
>   
> @@ -284,7 +284,6 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>   			printk(KERN_DEBUG "failed to create dma pool %s.\n", pool_name);
>   			goto err_out;
>   	}
> -	mvi->tags_num = slot_nr;
>   
>   	return 0;
>   err_out:
> @@ -367,8 +366,8 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
>   	mvi->sas = sha;
>   	mvi->shost = shost;
>   
> -	mvi->tags = kzalloc(MVS_CHIP_SLOT_SZ>>3, GFP_KERNEL);
> -	if (!mvi->tags)
> +	mvi->rsvd_tags = bitmap_zalloc(MVS_RSVD_SLOTS, GFP_KERNEL);
> +	if (!mvi->rsvd_tags)
>   		goto err_out;
>   
>   	if (MVS_CHIP_DISP->chip_ioremap(mvi))
> @@ -469,6 +468,8 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
>   	else
>   		can_queue = MVS_CHIP_SLOT_SZ;
>   
> +	can_queue -= MVS_RSVD_SLOTS;
> +
>   	shost->sg_tablesize = min_t(u16, SG_ALL, MVS_MAX_SG);
>   	shost->can_queue = can_queue;
>   	mvi->shost->cmd_per_lun = MVS_QUEUE_SIZE;
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index 0810e6c930e1..00b3a2781d21 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -20,33 +20,39 @@ static int mvs_find_tag(struct mvs_info *mvi, struct sas_task *task, u32 *tag)
>   	return 0;
>   }
>   
> -void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
> +static void mvs_tag_clear(struct mvs_info *mvi, u32 tag)
>   {
> -	void *bitmap = mvi->tags;
> +	void *bitmap = mvi->rsvd_tags;
>   	clear_bit(tag, bitmap);
>   }
>   
> -void mvs_tag_free(struct mvs_info *mvi, u32 tag)
> +static void mvs_tag_free(struct mvs_info *mvi, u32 tag)
>   {
> +	if (tag < mvi->shost->can_queue)
> +		return;
> +
> +	tag -= mvi->shost->can_queue;
> +
>   	mvs_tag_clear(mvi, tag);
>   }
>   
> -void mvs_tag_set(struct mvs_info *mvi, unsigned int tag)
> +static void mvs_tag_set(struct mvs_info *mvi, unsigned int tag)
>   {
> -	void *bitmap = mvi->tags;
> +	void *bitmap = mvi->rsvd_tags;
>   	set_bit(tag, bitmap);
>   }
>   
> -inline int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
> +static int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
>   {
>   	unsigned int index, tag;
> -	void *bitmap = mvi->tags;
> +	void *bitmap = mvi->rsvd_tags;
>   
> -	index = find_first_zero_bit(bitmap, mvi->tags_num);
> +	index = find_first_zero_bit(bitmap, MVS_RSVD_SLOTS);
>   	tag = index;
> -	if (tag >= mvi->tags_num)
> +	if (tag >= MVS_RSVD_SLOTS)
>   		return -SAS_QUEUE_FULL;
>   	mvs_tag_set(mvi, tag);
> +	tag += mvi->shost->can_queue;
>   	*tag_out = tag;
>   	return 0;
>   }

Also here: please move the reserved tags to the front, such that the tag 
allocation scheme matches with the blk-mq tag allocation scheme.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

