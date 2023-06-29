Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5063F742360
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjF2Jlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjF2Jlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29EED;
        Thu, 29 Jun 2023 02:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C43161512;
        Thu, 29 Jun 2023 09:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B45C433C8;
        Thu, 29 Jun 2023 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688031696;
        bh=AG1Vpc2SzvPhFBRnc+TAK3CKQHn7Q9axs5f4We/vIfE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lc9ixxhgeNl3hYgKnK6FKXUTdUYfdDkqB+i3UAObW33TjP2gwMFq4h7jtX0iMb8ji
         +Uw0kPykTmDD28tP1uAr3atW0rU178fCUY01Q/SF0iVFh9P5Wcv9N4egeARXIK25Dx
         9/VewZVecYMJrEDrRwuRmwGC2C3TNkCq5b9yQAo4CBu3ZaApB0ykI5cqkihe/JIrcs
         4gMTh4owGZ4S1DbDea4QsQvqzWl3VfHXR176EZTKF5oYT8h1xFL11wCsvZVc3EvoVW
         cvY4hie7eYIyROOD+/Cz2G55D0ljhCn1i+pqd+byoRVEhSjqwTvTKqHKir9PTaPXyl
         yQfm88q+gZ75Q==
Message-ID: <87a03e67-67f0-5ac7-41c7-5ccd393d0b66@kernel.org>
Date:   Thu, 29 Jun 2023 18:41:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Content-Language: en-US
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
 <be52be54-3178-082c-4bfc-7702308a0012@kernel.org>
 <87ilb6y6j9.fsf@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87ilb6y6j9.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 16:50, Andreas Hindborg (Samsung) wrote:
>>>  UCLINUX (M68KNOMMU AND COLDFIRE)
>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>> index 5b9d4aaebb81..c58dfd035557 100644
>>> --- a/drivers/block/Kconfig
>>> +++ b/drivers/block/Kconfig
>>> @@ -402,6 +402,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>>>  	  suggested to enable N if your application(ublk server) switches to
>>>  	  ioctl command encoding.
>>>  
>>> +config BLK_DEV_UBLK_ZONED
>>> +	def_bool y
>>
>> This can be "bool" only.
> 
> I did it like this because I wanted BLK_DEV_UBLK_ZONED to be set
> automatically to "y" when BLK_DEV_UBLK and BLK_DEV_ZONED are enabled.
> BLK_DEV_UBLK_ZONED has no menu entry. If we change it to "bool" it will
> be default "n" and we would have to make it appear in menuconfig to be
> manually enabled.
> 
> Isn't it more sane if it is just unconditionally enabled when
> BLK_DEV_ZONED and BLK_DEV_UBLK is enabled?

Maybe something like this then:

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..105e1121bf5f 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -370,9 +370,13 @@ config BLK_DEV_RBD

          If unsure, say N.

+config BLK_DEV_UBLK_ZONED
+       bool
+
 config BLK_DEV_UBLK
        tristate "Userspace block driver (Experimental)"
        select IO_URING
+       select BLK_DEV_UBLK_ZONED if BLK_DEV_ZONED
        help
          io_uring based userspace block driver. Together with ublk server, ublk
          has been working well, but interface with userspace or command data
>>> +		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
>>> +}
>>> +
>>> +void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>>> +{
>>> +	const struct ublk_param_zoned *p = &ub->params.zoned;
>>> +
>>> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
>>> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>>> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>>
>> You do not need to check if the max_active_zones and max_open_zones values are
>> sensible ? E.g. what if they are larger than the number of zones ?
> 
> I don't think it will be a problem. I assume you can set them to 0 to
> indicate infinite. If user space sets them to more than the actual
> number of available zones (that user space set up also), user space will
> have to handle that when it gets a zone request for a zone outside the
> logical drive LBA space. I don't think the kernel has to care. Will this
> break anything kernel side?

zonefs and btrfs look at these limits. So I would rather prefer seeing sensible
values. 0 == no limit is fine. But seeing maz or moz > nr_zones for the device
is just too strange and I would prefer an error in that case to let the user
know it is not doing something right. Getting moz > maz is also nonsense that
needs to be checked. There is one case we could silently change: if maz ==
nr_zones or moz == nr_zones, then that essentially means "no limit", so we could
use 0 to let the in-kernel users that they do not need to care about the limits.

> 
>>
>>> +	}
>>> +}
>>> +
>>> +int ublk_revalidate_disk_zones(struct gendisk *disk)
>>> +{
>>> +	return blk_revalidate_disk_zones(disk, NULL);
>>> +}
>>
>> I do not think this helper is needed at all (see below comment on the call site).
> 
> This is required because the prototype for `blk_revalidate_disk_zones()`
> is not defined when BLK_DEV_ZONED is not defined. Without this helper
> for which the prototype is always defined, we will have a compile error
> at the call site.

You have this hunk in ublk_ctrl_start_dev:

disk_set_zoned(disk, BLK_ZONED_HM);
blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
ret = ublk_revalidate_disk_zones(disk);
if (ret)
	goto out_put_disk;

And that is called under "if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)". So I do not see
how you can get compile errors using directly blk_revalidate_disk_zones(). The
entire hunk above should be a helper function I think.

>>> +
>>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>>> +		ublk_set_nr_zones(ub);
>>
>> So if the user is attempting to setup a zoned drive but the kernel does not have
>> CONFIG_BLK_DEV_ZONED=y, the user setup will be silently ignored. Not exactly
>> nice I think, unless I am missing something.
> 
> We have this in `ublk_ctrl_add_dev()`:
> 
> 	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> 		ub->dev_info.flags &= ~UBLK_F_ZONED;
> 
> User space is supposed to check the flags after the call to know the
> kernel capabilities.

And you trust user space to be always correct ? I never do :)
So definitely, check and error if not supported. No silently clearing the device
zoned flag.


>> Also, repeating that "if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))" for all zone
>> related functions is very verbose. Stub the functions in ublk_drv.h. That will
>> make the main C code lighter.
> 
> Not sure what you mean "stub the functions". Like so:
> 
> @@ -216,8 +216,7 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  
>  	set_capacity(ub->ub_disk, p->dev_sectors);
>  
> -	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> -		ublk_set_nr_zones(ub);
> +	ublk_config_nr_zones(ub);
>  }
> 
> And then in the header:
> 
> void ublk_config_nr_zones(struct ublk_device *ub)
> {
> 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> 		ublk_set_nr_zones(ub);
> }
> 
> Or something else?

#ifndef CONFIG_BLK_DEV_ZONED
static inline void ublk_set_nr_zones() {}
#endif

That avoid repeating that if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) all over the
place. The stubbed functions can be called only for "if (ub->dev_info.flags &
UBLK_F_ZONED", which is OK since this flag is never supposed to be accepted and
set for the CONFIG_BLK_DEV_ZONED=n case.

>>> +		disk_set_zoned(disk, BLK_ZONED_HM);
>>> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
>>> +		ret = ublk_revalidate_disk_zones(disk);
>>> +		if (ret)
>>> +			goto out_put_disk;
>>
>> This should be all a helper ublk_set_zoned() or something.
> 
> Ok 👍 Unfortunately this block of code is split up in the zone append
> patch. I will see what I can do, maybe 2 functions.

Beware that I just posted patches that require zone size (chunk_sectors limit)
and max append sectors limit to be set *before* calling
blk_revalidate_disk_zones(). Otherwise, you will get an error.

>>>  	get_device(&ub->cdev_dev);
>>>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
>>>  	ret = add_disk(disk);
>>> @@ -1997,6 +2046,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>>>  	if (ub->dev_info.flags & UBLK_F_USER_COPY)
>>>  		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
>>>  
>>> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>>> +		ub->dev_info.flags &= ~UBLK_F_ZONED;
>>
>> Arg, no. The user should be notified with an error that he/she is attempting to
>> create a zoned device that cannot be supported.
> 
> As I wrote above, this is part of the ublk uapi. This is the way user
> space does kernel capability check. User space will check the flags when
> this call returns. @Ming did I understand this correctly or did I miss something?

OK. So this is like a virtio capability flags thing ? Negotiation between device
and driver ?

>>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>>> index 471b3b983045..436525afffe8 100644
>>> --- a/include/uapi/linux/ublk_cmd.h
>>> +++ b/include/uapi/linux/ublk_cmd.h
>>> @@ -176,6 +176,11 @@
>>>  /* Copy between request and user buffer by pread()/pwrite() */
>>>  #define UBLK_F_USER_COPY	(1UL << 7)
>>>  
>>> +/*
>>> + * Enable zoned device support
>>
>> Isn't this for "Indicate that the device is zoned" ?
> 
> User space sets this flag when setting up the device to enable zoned
> storage support. Kernel may reject it. I think the wording is
> sufficient. Could be updated to:
> 
> "User space sets this flag when setting up the device to request zoned
>  storage support. Kernel may deny the request by clearing the flag
>  during setup."

I really have a big problem with this. If the user driver does not check that
the flag was cleared, the user will assume that the device is zoned, but it is
not. This is not super nice... I would really prefer just failing the devie
creation if zoned was requested but cannot be satisfied, either because the
kernel does not support zoned block devices or when the user specified something
nonsensical.


-- 
Damien Le Moal
Western Digital Research

