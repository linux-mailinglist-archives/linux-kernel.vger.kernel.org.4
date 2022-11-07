Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037C761F628
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiKGOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiKGOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:34:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B075B214;
        Mon,  7 Nov 2022 06:34:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B1EE225AD;
        Mon,  7 Nov 2022 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667831672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4Sg1qZkwEiVSC2iC9dKlGrQBQD0s8J33K2XOu5KL/0=;
        b=N6Bkqf/c7//mK5rtoPzoC8e+qy9BdJHOSb8jcGnaB5CG5HwReYZjRblTPTmnRQxvFnaQIv
        qDV8M41T0T6bHuMPHrfUA3nSKLPjyhKR6cEjb7mKNpSdSWrMhOfCWqP5GN9x0MhE1QmL85
        peuBYiQOCGwswOb6zO2vwvbnISvnkxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667831672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4Sg1qZkwEiVSC2iC9dKlGrQBQD0s8J33K2XOu5KL/0=;
        b=J4uiNATruM+2EzKbD+Jy+1ehg3atdTKIKxl8M5nA1CM6NlOwGjnpqIzTa8zLjwW/q50d5w
        P0F5WEaqk5+VfiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 462D413AC7;
        Mon,  7 Nov 2022 14:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kC/TEHgXaWNCBAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Nov 2022 14:34:32 +0000
Message-ID: <84544a8b-5884-840c-0b69-fe6c4ae18e72@suse.de>
Date:   Mon, 7 Nov 2022 15:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org, hch@lst.de,
        ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
 <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
 <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
 <0e4994f7-f131-39b0-c876-f447b71566cd@opensource.wdc.com>
 <05cf6d61-987b-025d-b694-a58981226b97@oracle.com>
 <ff0c2ab7-8e82-40d9-1adf-78ee12846e1f@opensource.wdc.com>
 <39f9afc5-9aab-6f7c-b67a-e74e694543d4@suse.de>
 <0de1c3fd-4be7-1690-0780-720505c3692b@opensource.wdc.com>
 <75aea0e8-4fa4-593c-0024-3c39ac3882f3@suse.de>
 <cfb89169-77e5-b208-62e7-4cf1c660ac7a@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
In-Reply-To: <cfb89169-77e5-b208-62e7-4cf1c660ac7a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 14:29, Damien Le Moal wrote:
> On 11/7/22 19:12, Hannes Reinecke wrote:
>> On 11/2/22 12:25, Damien Le Moal wrote:
>>> On 11/2/22 20:12, Hannes Reinecke wrote:
>>>> On 11/2/22 11:07, Damien Le Moal wrote:
>>>>> On 11/2/22 18:52, John Garry wrote:
>>>>>> Hi Damien,
>>>>>>
>>>> [ .. ] >> So we only need to find a way of 're-using' that tag, then we won't have
>>>> to set aside a reserved tag and everything would be dandy...
>>>
>>> I tried that. It is very ugly... Problem is that integration with EH in
>>> case a real NCQ error happens when all that read-log-complete dance is
>>> happening is hard. And don't get me started with the need to save/restore
>>> the scsi command context of the command we are reusing the tag from.
>>>
>>> And given that the code is changing to use regular submission path for
>>> internal commands, right now, we need a reserved tag. Or a way to "borrow"
>>> the tag from a request that we need to check. Which means we need some
>>> additional api to not always try to allocate a tag.
>>>
>>>>
>>>> Maybe we can stop processing when we receive an error (should be doing
>>>> that anyway as otherwise the log might be overwritten), then we should
>>>> be having a pretty good chance of getting that tag.
>>>
>>> Hmmm.... that would be no better than using EH which does stop processing
>>> until the internal house keeping is done.
>>>
>>>> Or, precisely, getting _any_ tag as at least one tag is free at that point.
>>>> Hmm?
>>>
>>> See above. Not free, but usable as far as the device is concerned since we
>>> have at least on command we need to check completed at the device level
>>> (but not yet completed from scsi/block layer point of view).
>>>
>> So, having had an entire weekend pondering this issue why don't we
>> allocate an _additional_ set of requests?
>> After all, we had been very generous with allocating queues and requests
>> (what with us doing a full provisioning of the requests for all queues
>> already for the non-shared tag case).
>>
>> Idea would be to keep the single tag bitmap, but add eg a new rq state
>> MQ_RQ_ERROR. Once that flag is set we'll fetch the error request instead
>> of the normal one:
>>
>> @@ -761,6 +763,8 @@ static inline struct request
>> *blk_mq_tag_to_rq(struct blk_mq_tags *tags,
>>    {
>>           if (tag < tags->nr_tags) {
>>                   prefetch(tags->rqs[tag]);
>> +               if (unlikely(blk_mq_request_error(tags->rqs[tag])))
>> +                       return tags->error_rqs[tag];
>>                   return tags->rqs[tag];
>>           }
>>
>> and, of course, we would need to provision the error request first.
>>
>> Rationale here is that this will be primarily for devices with a low
>> number of tags, so doubling the number of request isn't much of an
>> overhead (as we'll be doing it essentially anyway in the error case as
>> we'll have to save the original request _somewhere_), and that it would
>> remove quite some cruft from the subsystem; look at SCSI EH trying to
>> store the original request contents and then after EH restoring them again.
> 
> Interesting idea. I like it. It is essentially a set of reserved requests
> without reserved tags: the tag to use for these requests would be provided
> "manually" by the user. Right ?
> 
Yes. Upon failure one would be calling something like 
'blk_mq_get_error_rq(rq)', which would set the error flag in the 
original request, fetch the matching request from ->static_rqs, and 
return that one.

Just figured, we could simply enlarge 'static_rqs' to have double the 
size; then we can easily get the appropriate request from 'static_rqs' 
by just adding the queue size.
Making things even easier ...

> That should allow simplifying any processing that needs to reuse a tag,
> and currently its request. That is, CDL, but also usb-scsi, scsi EH and
> the few scsi LLDs using scsi_eh_prep_cmnd()+scsi_eh_restore_cmnd().
> Ideally, these 2 functions could go away too.
> 
Which was precisely the idea. We have quite some drivers/infrastructure 
which already require a similar functionality, and basically all of them 
cover devices with a really low tag space (32/31 in the libata NCQ case, 
16 in the SCSI TCQ case, or even _1_ in the SCSI parallel case :-)
So a request duplication wouldn't matter _that_ much here.

Drivers with a higher queue depth typically can do 'real' TMFs, where 
you need to allocate a new tag anyway, and so the whole operation 
doesn't apply here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

