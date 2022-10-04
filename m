Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD785F3C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJDFxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJDFxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:53:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE53385F;
        Mon,  3 Oct 2022 22:53:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB7CE2191A;
        Tue,  4 Oct 2022 05:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664862790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoBsQmn104v9b+t39EgCCEXLFOhL2ba6bp2KnbcdsTs=;
        b=tnCNJgCPXLkfiHFqrjIiZ4/Pj3bE1tHE6ZJbz1299ggL1VihCkUDDdd7hOe+T9OIr79GTw
        WiLfUV5kCCofWePGYoHUtHp25SXz7IJUFkLiQRvUrGTd5lIti3Ib8Jqt89ADgD+dr8PJ6h
        er0W8NSpqBOqikq8DndpnVP7jialBVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664862790;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoBsQmn104v9b+t39EgCCEXLFOhL2ba6bp2KnbcdsTs=;
        b=91o40Yts2uCWXhhnqjML5/8wJPX3D6GTyldVr1FW/f7oihAuylDtmpH15byKcErVXT/gBO
        ZlsDhN4WciwzxFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F08213A8F;
        Tue,  4 Oct 2022 05:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pTrfHUbKO2NPDgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Oct 2022 05:53:10 +0000
Message-ID: <fdbb5c5f-05d9-93fa-83d4-2f0129221641@suse.de>
Date:   Tue, 4 Oct 2022 07:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 4/6] scsi: pm8001: Use sas_task_find_rq() for tagging
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-5-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1664528184-162714-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 10:56, John Garry wrote:
> The request associated with a scsi command coming from the block layer
> has a unique tag, so use that when possible for getting a CCB.
> 
> Unfortunately we don't support reserved commands in the SCSI midlayer yet,
> so in the interim continue to manage those tags internally (along with
> tags for private commands).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/pm8001/pm8001_init.c | 12 ++++--------
>   drivers/scsi/pm8001/pm8001_sas.c  | 16 ++++++++++++----
>   drivers/scsi/pm8001/pm8001_sas.h  | 11 ++++++++---
>   drivers/scsi/pm8001/pm80xx_hwi.c  | 17 +++--------------
>   4 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 0edc9857a8bd..abb884ddcaf9 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -196,7 +196,7 @@ static void pm8001_free(struct pm8001_hba_info *pm8001_ha)
>   	}
>   	PM8001_CHIP_DISP->chip_iounmap(pm8001_ha);
>   	flush_workqueue(pm8001_wq);
> -	bitmap_free(pm8001_ha->tags);
> +	bitmap_free(pm8001_ha->rsvd_tags);
>   	kfree(pm8001_ha);
>   }
>   
> @@ -1208,18 +1208,15 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
>   	struct Scsi_Host *shost = pm8001_ha->shost;
>   	struct device *dev = pm8001_ha->dev;
>   	u32 max_out_io, ccb_count;
> -	u32 can_queue;
>   	int i;
>   
>   	max_out_io = pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io;
>   	ccb_count = min_t(int, PM8001_MAX_CCB, max_out_io);
>   
> -	/* Update to the scsi host*/
> -	can_queue = ccb_count - PM8001_RESERVE_SLOT;
> -	shost->can_queue = can_queue;
> +	shost->can_queue = ccb_count - PM8001_RESERVE_SLOT;
>   
> -	pm8001_ha->tags = bitmap_zalloc(ccb_count, GFP_KERNEL);
> -	if (!pm8001_ha->tags)
> +	pm8001_ha->rsvd_tags = bitmap_zalloc(PM8001_RESERVE_SLOT, GFP_KERNEL);
> +	if (!pm8001_ha->rsvd_tags)
>   		goto err_out;
>   
>   	/* Memory region for ccb_info*/
> @@ -1244,7 +1241,6 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
>   		pm8001_ha->ccb_info[i].task = NULL;
>   		pm8001_ha->ccb_info[i].ccb_tag = PM8001_INVALID_TAG;
>   		pm8001_ha->ccb_info[i].device = NULL;
> -		++pm8001_ha->tags_num;
>   	}
>   
>   	return 0;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 066dfa9f4683..d60bc311a4e9 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -65,9 +65,14 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
>     */
>   void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>   {
> -	void *bitmap = pm8001_ha->tags;
> +	void *bitmap = pm8001_ha->rsvd_tags;
>   	unsigned long flags;
>   
> +	if (tag < pm8001_ha->shost->can_queue)
> +		return;
> +
> +	tag -= pm8001_ha->shost->can_queue;
> +
>   	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
>   	__clear_bit(tag, bitmap);
>   	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
> @@ -80,18 +85,21 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>     */
>   int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
>   {
> -	void *bitmap = pm8001_ha->tags;
> +	void *bitmap = pm8001_ha->rsvd_tags;
>   	unsigned long flags;
>   	unsigned int tag;
>   
>   	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
> -	tag = find_first_zero_bit(bitmap, pm8001_ha->tags_num);
> -	if (tag >= pm8001_ha->tags_num) {
> +	tag = find_first_zero_bit(bitmap, PM8001_RESERVE_SLOT);
> +	if (tag >= PM8001_RESERVE_SLOT) {
>   		spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>   		return -SAS_QUEUE_FULL;
>   	}
>   	__set_bit(tag, bitmap);
>   	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
> +
> +	/* reserved tags are in the upper region of the tagset */
> +	tag += pm8001_ha->shost->can_queue;
>   	*tag_out = tag;
>   	return 0;
>   }
Can you move the reserved tags to the _lower_ region of the tagset?
That way the tag allocation scheme matches with what the block-layer 
does, and the eventual conversion to reserved tags becomes easier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

