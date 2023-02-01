Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA3686505
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjBALKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBALKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:10:00 -0500
Received: from smtp.tiscali.it (michael-notr.mail.tiscali.it [213.205.33.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 065554673C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:09:56 -0800 (PST)
Received: from [192.168.178.50] ([79.16.97.72])
        by michael.mail.tiscali.it with 
        id Fn9j2903F1ZhrJf01n9lci; Wed, 01 Feb 2023 11:09:53 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
Message-ID: <d16bba68-f470-62a0-baa9-03be2882047d@tiscali.it>
Date:   Wed, 1 Feb 2023 12:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
To:     Mike Snitzer <snitzer@kernel.org>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-3-sergei.shtepa@veeam.com>
 <Y9mrJJDFnMNWR7Vn@redhat.com>
From:   Fabio Fantoni <fantonifabio@tiscali.it>
In-Reply-To: <Y9mrJJDFnMNWR7Vn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 230131-14, 31/1/2023), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1675249793; bh=LQObqF2Wtm61LjOqnqVe5XmyFxSqQ68OZlRKTllaPUI=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=ByEPtDn7FeFehZ/a+IjdPIeEm0NNxSMQIfzRfrHdtFf7vD+odoEX1suL91kBphP1n
         vmSWJYcI6hcR8BwIdtyONdGlP5VCQWyi6VSSqynXBThU87Y2zQ4RMq96w+IR1JcTVo
         kbQak+3gE0qGXvgLkg4r3fE0wdVFFS+WkEwKasgk=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/02/2023 00:58, Mike Snitzer ha scritto:
> On Fri, Dec 09 2022 at  9:23P -0500,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
>
>> Allows to attach block device filters to the block devices. Kernel
>> modules can use this functionality to extend the capabilities of the
>> block layer.
>>
>> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
>> ---
>>   block/bdev.c              | 70 ++++++++++++++++++++++++++++++++++++++
>>   block/blk-core.c          | 19 +++++++++--
>>   include/linux/blk_types.h |  2 ++
>>   include/linux/blkdev.h    | 71 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 160 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index d699ecdb3260..b820178824b2 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -427,6 +427,7 @@ static void init_once(void *data)
>>   
>>   static void bdev_evict_inode(struct inode *inode)
>>   {
>> +	bdev_filter_detach(I_BDEV(inode));
>>   	truncate_inode_pages_final(&inode->i_data);
>>   	invalidate_inode_buffers(inode); /* is it needed here? */
>>   	clear_inode(inode);
>> @@ -502,6 +503,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>>   		return NULL;
>>   	}
>>   	bdev->bd_disk = disk;
>> +	bdev->bd_filter = NULL;
>>   	return bdev;
>>   }
>>   
>> @@ -1092,3 +1094,71 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>>   
>>   	blkdev_put_no_open(bdev);
>>   }
>> +
>> +/**
>> + * bdev_filter_attach - Attach the filter to the original block device.
>> + * @bdev:
>> + *	Block device.
>> + * @flt:
>> + *	Filter that needs to be attached to the block device.
>> + *
>> + * Before adding a filter, it is necessary to initialize &struct bdev_filter
>> + * using a bdev_filter_init() function.
>> + *
>> + * The bdev_filter_detach() function allows to detach the filter from the block
>> + * device.
>> + *
>> + * Return: 0 if succeeded, or -EALREADY if the filter already exists.
>> + */
>> +int bdev_filter_attach(struct block_device *bdev,
>> +				     struct bdev_filter *flt)
>> +{
>> +	int ret = 0;
>> +
>> +	blk_mq_freeze_queue(bdev->bd_queue);
>> +	blk_mq_quiesce_queue(bdev->bd_queue);
>> +
>> +	if (bdev->bd_filter)
>> +		ret = -EALREADY;
>> +	else
>> +		bdev->bd_filter = flt;
>> +
>> +	blk_mq_unquiesce_queue(bdev->bd_queue);
>> +	blk_mq_unfreeze_queue(bdev->bd_queue);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(bdev_filter_attach);
>> +
>> +/**
>> + * bdev_filter_detach - Detach the filter from the block device.
>> + * @bdev:
>> + *	Block device.
>> + *
>> + * The filter should be added using the bdev_filter_attach() function.
>> + *
>> + * Return: 0 if succeeded, or -ENOENT if the filter was not found.
>> + */
>> +int bdev_filter_detach(struct block_device *bdev)
>> +{
>> +	int ret = 0;
>> +	struct bdev_filter *flt = NULL;
>> +
>> +	blk_mq_freeze_queue(bdev->bd_queue);
>> +	blk_mq_quiesce_queue(bdev->bd_queue);
>> +
>> +	flt = bdev->bd_filter;
>> +	if (flt)
>> +		bdev->bd_filter = NULL;
>> +	else
>> +		ret = -ENOENT;
>> +
>> +	blk_mq_unquiesce_queue(bdev->bd_queue);
>> +	blk_mq_unfreeze_queue(bdev->bd_queue);
>> +
>> +	if (flt)
>> +		bdev_filter_put(flt);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(bdev_filter_detach);
> What about bio-based devices? (DM, MD, etc)
>
> DM uses freeze_bdev() and thaw_bdev(), seems like you're missing some
> work here.
>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 5487912befe8..284b295a7b23 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -678,9 +678,24 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>   	 * to collect a list of requests submited by a ->submit_bio method while
>>   	 * it is active, and then process them after it returned.
>>   	 */
>> -	if (current->bio_list)
>> +	if (current->bio_list) {
>>   		bio_list_add(&current->bio_list[0], bio);
>> -	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
>> +		return;
>> +	}
>> +
>> +	if (bio->bi_bdev->bd_filter && !bio_flagged(bio, BIO_FILTERED)) {
> Shouldn't this be: if (unlikely(...))?
>
> But that obviously assumes a fair amount about the only consumer
> (temporary filter that lasts as long as it takes to do a backup).
>
>> +		bool pass;
>> +
>> +		pass = bio->bi_bdev->bd_filter->fops->submit_bio_cb(bio);
>> +		bio_set_flag(bio, BIO_FILTERED);
>> +		if (!pass) {
>> +			bio->bi_status = BLK_STS_OK;
>> +			bio_endio(bio);
>> +			return;
>> +		}
>> +	}
>> +
>> +	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
>>   		__submit_bio_noacct_mq(bio);
>>   	else
>>   		__submit_bio_noacct(bio);
> And you currently don't allow for blkfilter to be involved if a bio
> recurses (which is how bio splitting works now).  Not sure it
> matters, just mentioning it...
Hi, thanks for review this project that I think is very useful and I 
hope it will be able to reach a very good quality, that will be 
integrated into the kernel and that more backup solutions will use it 
improving backups on linux in several cases.
In the last month Sergei made big changes, applying Christoph Hellwig 
changes and working following the received replies, the new version of 
the patch is not ready yet but the many changes done for now are 
available here: https://github.com/SergeiShtepa/linux/commits/blksnap-master
I suppose that full review now of v2 when many things was already 
changed for next version can risk to waste time. I hope I've helped with 
this, if I haven't, sorry to have bother you.
>
> But taking a step back, in the hopes of stepping out of your way:
>
> Myself and others on the DM team (past and present) have always hoped
> all block devices could have the flexibility of DM. It was that hope
> that caused my frustration when I first saw your blkfilter approach.
>
> But I was too idealistic that a byproduct of your efforts
> (blk-interposer before and blkfilter now) would usher in _all_ block
> devices being able to comprehensively change their identity (and IO
> processing) like DM enjoys.
>
> DM showcases all the extra code needed to achieve its extreme IO
> remapping and stacking flexibilty -- I don't yet see a way to distill
> the essence of what DM achieves without imposing too much on all block
> core.
>
> So I do think blkfilter is a pragmatic way to achieve your goals.
>
> Mike
>
>
