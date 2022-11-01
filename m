Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E9615420
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKAVV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKAVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14503201AA;
        Tue,  1 Nov 2022 14:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEAC6173F;
        Tue,  1 Nov 2022 21:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB527C433C1;
        Tue,  1 Nov 2022 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667337504;
        bh=ypM1pAHfECGduMF56bdpvOPKgtbm+0KJ4byxlkAjED4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lckr3AB73KQTI7YjyZrBYbygJ3eZ9LGh3EwcEhxosXKaIIWvKAm2i2YTl+Vfg2sR3
         9TzZoDyrlee21kOmB5BJEpXmYdeyh1FU9/ZLgzXJAp0HZkFgfLENlbQNz7R5ldgGkc
         s+NjWNk5Lyq3CLFobDAJ2kc9hMOYt19CjXGRopqtloXG56gme8h7Q8+FmkoAgy3Mhd
         oLrEG19i2UGO4dibhui2Auz3ZOGaWzjY+qtIID1BCSEOu7+RETQpIiYj2vTatXaffU
         AA1ya5MiK1isRoLWuvSb5bKIUXDJeyEKIwOzvj8uso9KIlvhtI0WIHWWTK0Cx5yQ2w
         j6cqdhPk0ir2w==
Date:   Tue, 1 Nov 2022 15:18:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dmitrii Tcvetkov <me@demsh.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] RAID1 direct IO redirecting sector loop since 6.0
Message-ID: <Y2GNHEtDnoybz+fW@kbusch-mbp>
References: <20221101001558.648ee024@xps.demsh.org>
 <Y2FVzdcro8HCfODK@kbusch-mbp>
 <20221101235144.06a3dbd3@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101235144.06a3dbd3@xps.demsh.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:51:44PM +0300, Dmitrii Tcvetkov wrote:
> It also doesn't reproduce with 4096 sector loop:
> # lsblk -t -a                                                                           
> NAME                 ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE  RA WSAME
> loop0                        0   4096      0    4096    4096    0 none      128 128    0B
> └─md2                        0   4096      0    4096    4096    0           128 128    0B
>   ├─4096lvmraid-zfs          0   4096      0    4096    4096    0           128 128    0B
>   └─4096lvmraid-wrk          0   4096      0    4096    4096    0           128 128    0B
> loop1                        0   4096      0    4096    4096    0 none      128 128    0B
> └─md2                        0   4096      0    4096    4096    0           128 128    0B
>   ├─4096lvmraid-zfs          0   4096      0    4096    4096    0           128 128    0B
>   └─4096lvmraid-wrk          0   4096      0    4096    4096    0           128 128    0B
> 
> where:
> # losetup --sector-size 4096 -f /dev/sdd4
> # losetup --sector-size 4096 -f /dev/sde4
> # mdadm --create --level=1 --metadata=1.2 \
> 	--raid-devices=2 /dev/md2 /dev/loop0 /dev/loop1
> # pvcreate /dev/md2
> # vgcreate 4096lvmraid /dev/md2
> 
> Indeed then something is wrong in LUKS.

Thanks, this helps narrow down where to consider. The offending commit
definitely wasn't supposed to break crypto device mappers, but it seems I may
have missed a case depending on the previous behavior's implicit constraints.
I'll look more into this area.
 
> > For a different experiment, it may be safer to just force all
> > alignment for stacking drivers. Could you try the following and see
> > if that gets it working again? 
> > 
> > ---
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 8bb9eef5310e..5c16fdb00c6f 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -646,6 +646,7 @@ int blk_stack_limits(struct queue_limits *t,
> > struct queue_limits *b, t->misaligned = 1;
> >  		ret = -1;
> >  	}
> > +	blk_queue_dma_alignment(t, t->logical_block_size - 1);
> >  
> >  	t->max_sectors = blk_round_down_sectors(t->max_sectors,
> > t->logical_block_size); t->max_hw_sectors =
> > blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size); --
> 
> This doesn't compile:

Oh shoot, sorry about that! Should have been this:

@@ -703,6 +702,7 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
                pr_notice("%s: Warning: Device %pg is misaligned\n",
                        disk->disk_name, bdev);

+       blk_queue_dma_alignment(t, queue_logical_block_size(t) - 1);
        disk_update_readahead(disk);
 }
 EXPORT_SYMBOL(disk_stack_limits);
