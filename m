Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78F61617F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKBLNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKBLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F124969;
        Wed,  2 Nov 2022 04:12:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AB1033725;
        Wed,  2 Nov 2022 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667387560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGslLuYGqB44VKqgWWsPNfEWkuclkAOR5dtiKT3iivc=;
        b=u8ae5WzBrpmlJffHlLWFbpv3efj9JyD7G6wjhBbzZuGnGVN4odZTmkpD0/JhmPwX7LbBBe
        61yMzwIvO1FCdc66dGM/Q0qbmS+gt+61Aas1rJfYAuPtNq9WuT/VZGe+gXaD73OidK0DI0
        VwGdZ3wMQ5uHNJTy1tBxa7MLL04Miu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667387560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGslLuYGqB44VKqgWWsPNfEWkuclkAOR5dtiKT3iivc=;
        b=TKLyUci5Ez3KeN45FsP6tRI63ZUX/B/grSuh76qt0yhqdxCw7Gi3swvJ5VUXgKyBNsNxJ1
        3fJ7sK0ZCAO4RjDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39869139D3;
        Wed,  2 Nov 2022 11:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DLLaDahQYmMpagAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Nov 2022 11:12:40 +0000
Message-ID: <39f9afc5-9aab-6f7c-b67a-e74e694543d4@suse.de>
Date:   Wed, 2 Nov 2022 12:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
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
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ff0c2ab7-8e82-40d9-1adf-78ee12846e1f@opensource.wdc.com>
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

On 11/2/22 11:07, Damien Le Moal wrote:
> On 11/2/22 18:52, John Garry wrote:
>> Hi Damien,
>>
[ .. ]
>>>> Or re-use 1 from 32 (and still also have 1 separate internal command)?
>>>
>>> I am not yet 100% sure if we can treat that internal NCQ read log like
>>> any other read/write request... If we can, then the 1-out-of-32
>>> reservation would not be needed. Need to revisit all the cases we need
>>> to take care of (because in the middle of this CDL completion handling,
>>> regular NCQ errors can happen, resulting in a drive reset that could
>>> wreck everything as we lose the sense data for the completed requests).
>>>
>>> In any case, I think that we can deal with that extra reserved command
>>> on top of you current series. No need to worry about it for now I think.
>>>
>>
>> So are you saying that you are basing current CDL support on libata
>> internally managing this extra reserved tag (and so do not need this
>> SCSI midlayer reserved tag support yet)?
> 
> Not really. For now, it is using libata EH, that is, when we need the
> internal command for the read log, we know the device is idle and no
> command is on-going. So we send a non-NCQ command which does not have a tag.
> 
> Ideally, all of this should use a real reserved tag to allow for an NCQ
> read log outside of EH, avoiding the drive queue drain.
> 
But with the current design you'll only get that if you reserve one 
precious tag.

OTOH, we might not need that tag at all, as _if_ we get an error for a 
specific command the tag associated with it is necessarily free after 
completion, right?

So we only need to find a way of 're-using' that tag, then we won't have 
to set aside a reserved tag and everything would be dandy...

Maybe we can stop processing when we receive an error (should be doing 
that anyway as otherwise the log might be overwritten), then we should 
be having a pretty good chance of getting that tag.
Or, precisely, getting _any_ tag as at least one tag is free at that point.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

