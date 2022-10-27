Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7D60F184
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiJ0HvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJ0HvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:51:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20202A287D;
        Thu, 27 Oct 2022 00:51:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9178A1FDFB;
        Thu, 27 Oct 2022 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666857062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KW/ilq8EeIAm/XWevD2VqVdEVtwgp+eQrNdLBxj+VgI=;
        b=OCmdeJxHcSlsxMdZdzBBEXBfyqcZ0GgftjK5FUv6GyZ/az5wshetS/ofhrLLDeTdMiSiIb
        nNlTj/4aJdd+0bGEGAI21TZth7hgaVOn8+8L7OknRj7ovhmB5wns/FfIvxjpxRBSefd1HW
        ugBcA3i40gOjaF2C4JdK2jZ6ClRyVI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666857062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KW/ilq8EeIAm/XWevD2VqVdEVtwgp+eQrNdLBxj+VgI=;
        b=px1TAfPvKNwPje1yeI4HyYEBfMYX9Qb31If2wK3ByrXC9j8Y5c9FlwY/GH/l1zePnVNtmn
        I4iZ0MXJT3wohfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55FB6134CA;
        Thu, 27 Oct 2022 07:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gTgsE2U4WmPdLgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Oct 2022 07:51:01 +0000
Message-ID: <5db88114-559b-970a-0437-9acdacb47f8b@suse.de>
Date:   Thu, 27 Oct 2022 09:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC v3 03/22] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, bvanassche@acm.org, hch@lst.de,
        ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-4-git-send-email-john.garry@huawei.com>
 <cd5df8e0-03d1-8f22-0367-eb7c76bc70e7@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <cd5df8e0-03d1-8f22-0367-eb7c76bc70e7@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 03:18, Damien Le Moal wrote:
> On 10/25/22 19:17, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Quite some drivers are using management commands internally, which
>> typically use the same hardware tag pool (ie they are being allocated
>> from the same hardware resources) as the 'normal' I/O commands.
>> These commands are set aside before allocating the block-mq tag bitmap,
>> so they'll never show up as busy in the tag map.
>> The block-layer, OTOH, already has 'reserved_tags' to handle precisely
>> this situation.
>> So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
>> template to instruct the block layer to set aside a tag space for these
>> management commands by using reserved tags.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> #jpg: Set tag_set->queue_depth = shost->can_queue, and not
>> = shost->can_queue + shost->nr_reserved_cmds;
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/hosts.c     |  3 +++
>>   drivers/scsi/scsi_lib.c  |  2 ++
>>   include/scsi/scsi_host.h | 15 ++++++++++++++-
>>   3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>> index 12346e2297fd..db89afc37bc9 100644
>> --- a/drivers/scsi/hosts.c
>> +++ b/drivers/scsi/hosts.c
>> @@ -489,6 +489,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>>   	if (sht->virt_boundary_mask)
>>   		shost->virt_boundary_mask = sht->virt_boundary_mask;
>>   
>> +	if (sht->nr_reserved_cmds)
>> +		shost->nr_reserved_cmds = sht->nr_reserved_cmds;
>> +
> 
> Nit: the if is not really necessary I think. But it does not hurt.
> 
Yes, we do.
Not all HBAs are able to figure out the number of reserved commands 
upfront; some modify that based on the PCI device used etc.
So I'd keep it for now.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

