Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49D6D31AA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjDAO4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDAO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:56:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49C1DFA3;
        Sat,  1 Apr 2023 07:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1A6FB80B84;
        Sat,  1 Apr 2023 14:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15CAC433EF;
        Sat,  1 Apr 2023 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680360985;
        bh=U/D11rdbjd1z2d2bXqVG1pghrbpU9nx+yPmLBmO9W3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j75idZMQW1j3EFoD78LotF+AGbwDP2bd2lvj4hTauwJezzvZe0dVHmrC6pcd3FWvt
         9ZcXPK0SyY6C8yxGTnEJttu7w7cJqn0cmwxnY0rdquSMad1URT3U82+JAPn+QueLuF
         cGj2DVjf1Hn8JS6z0LNi0PnBmk4v2aMP5rntTwgU=
Date:   Sat, 1 Apr 2023 16:56:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
Subject: Re: BUG FIX: [PATCH RFC v3] [TESTED OK] memstick_check() memleak in
 kernel 6.1.0+ introduced pre 4.17
Message-ID: <2023040123-undress-playpen-edee@gregkh>
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com>
 <ZCfQQDkw3D_BXJaZ@kroah.com>
 <2023040127-untrue-obtrusive-1ea4@gregkh>
 <2023040112-immovably-cytoplasm-44ee@gregkh>
 <112c4552-2c32-1be4-89a9-90ea9b45e988@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112c4552-2c32-1be4-89a9-90ea9b45e988@alu.unizg.hr>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 01:25:21PM +0200, Mirsad Goran Todorovac wrote:
> On 01. 04. 2023. 11:23, Greg KH wrote:
> > On Sat, Apr 01, 2023 at 11:18:19AM +0200, Greg KH wrote:
> >> On Sat, Apr 01, 2023 at 08:33:36AM +0200, Greg KH wrote:
> >>> On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
> >>>> On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
> >>>>>> This patch is implying that anyone who calls "dev_set_name()" also has
> >>>>>> to do this hack, which shouldn't be the case at all.
> >>>>>>
> >>>>>> thanks,
> >>>>>>
> >>>>>> greg k-h
> >>>>>
> >>>>> This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
> >>>>> see a more sensible way to patch this up.
> >>>>
> >>>> In sleeping on this, I think this has to move to the driver core.  I
> >>>> don't understand why we haven't seen this before, except maybe no one
> >>>> has really noticed before (i.e. we haven't had good leak detection tools
> >>>> that run with removable devices?)
> >>>>
> >>>> Anyway, let me see if I can come up with something this weekend, give me
> >>>> a chance...
> >>>
> >>> Wait, no, this already should be handled by the kobject core, look at
> >>> kobject_cleanup(), at the bottom.  So your change should be merely
> >>> duplicating the logic there that already runs when the struct device is
> >>> freed, right?
> >>>
> >>> So I don't understand why your change works, odd.  I need more coffee...
> >>
> >> I think you got half of the change correctly.  This init code is a maze
> >> of twisty passages, let me take your patch and tweak it a bit into
> >> something that I think should work.  This looks to be only a memstick
> >> issue, not a driver core issue (which makes me feel better.)
> > 
> > Oops, forgot the patch.  Can you try this change here and let me know if
> > that solves the problem or not?  I have compile-tested it only, so I
> > have no idea if it works.
> > 
> > If this does work, I'll make up a "real" function to replace the
> > horrible dev.kobj.name mess that a driver would have to do here as it
> > shouldn't be required that a driver author knows the internals of the
> > driver core that well...
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > --------------------
> > 
> > 
> > diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> > index bf7667845459..bbfaf6536903 100644
> > --- a/drivers/memstick/core/memstick.c
> > +++ b/drivers/memstick/core/memstick.c
> > @@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
> >  	return card;
> >  err_out:
> >  	host->card = old_card;
> > +	kfree_const(card->dev.kobj.name);
> >  	kfree(card);
> >  	return NULL;
> >  }
> > @@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
> >  				put_device(&card->dev);
> >  				host->card = NULL;
> >  			}
> > -		} else
> > +		} else {
> > +			kfree_const(card->dev.kobj.name);
> >  			kfree(card);
> > +		}
> >  	}
> >  
> >  out_power_off:
> 
> RESULTS:
> 
> w/o patch:
> 
> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# cat !$
> cat /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffa09a93249590 (size 16):
>   comm "kworker/u12:4", pid 371, jiffies 4294896466 (age 52.748s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
>   backtrace:
>     [<ffffffff936fb25c>] slab_post_alloc_hook+0x8c/0x3e0
>     [<ffffffff93702b39>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffff936773b9>] __kmalloc_node_track_caller+0x59/0x180
>     [<ffffffff93666a0a>] kstrdup+0x3a/0x70
>     [<ffffffff93666a7c>] kstrdup_const+0x2c/0x40
>     [<ffffffff93aa99dc>] kvasprintf_const+0x7c/0xb0
>     [<ffffffff9443b427>] kobject_set_name_vargs+0x27/0xa0
>     [<ffffffff93d8ee37>] dev_set_name+0x57/0x80
>     [<ffffffffc0aeff0f>] memstick_check+0x10f/0x3b0 [memstick]
>     [<ffffffff933cb4c0>] process_one_work+0x250/0x530
>     [<ffffffff933cb7f8>] worker_thread+0x48/0x3a0
>     [<ffffffff933d6dff>] kthread+0x10f/0x140
>     [<ffffffff93202fa9>] ret_from_fork+0x29/0x50
> unreferenced object 0xffffa09a97205990 (size 16):
>   comm "kworker/u12:4", pid 371, jiffies 4294896471 (age 52.728s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
>   backtrace:
>     [<ffffffff936fb25c>] slab_post_alloc_hook+0x8c/0x3e0
>     [<ffffffff93702b39>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffff936773b9>] __kmalloc_node_track_caller+0x59/0x180
>     [<ffffffff93666a0a>] kstrdup+0x3a/0x70
>     [<ffffffff93666a7c>] kstrdup_const+0x2c/0x40
>     [<ffffffff93aa99dc>] kvasprintf_const+0x7c/0xb0
>     [<ffffffff9443b427>] kobject_set_name_vargs+0x27/0xa0
>     [<ffffffff93d8ee37>] dev_set_name+0x57/0x80
>     [<ffffffffc0aeff0f>] memstick_check+0x10f/0x3b0 [memstick]
>     [<ffffffff933cb4c0>] process_one_work+0x250/0x530
>     [<ffffffff933cb7f8>] worker_thread+0x48/0x3a0
>     [<ffffffff933d6dff>] kthread+0x10f/0x140
>     [<ffffffff93202fa9>] ret_from_fork+0x29/0x50
> [root@pc-mtodorov marvin]# uname -rms
> Linux 6.3.0-rc4-mt-20230401-00199-g7b50567bdcad-dirty x86_64
> [root@pc-mtodorov marvin]# 
> 
> After the patch:
> 
> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> 
> So, congratulations, this did it!

Great, thanks for testing!  And for working to narrow this down, that's
the hard part here.

> This bug I detected on 2022-11-04, but it took me four months to find the leak,
> before I was "blessed by the Source". You have asked me whether I would
> help the memstick developers find a solution, and I like to keep promises. :-)
> 
> At your convenience, you might add in the patch:
> 
> Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> It's been an honour serving with the memstick community with you and it was a real
> brainstorming session for me.

Thanks, as you did way over half the work here, I think a co-developed
tag would be better.  I'll send it out with that and you can provide a
signed-off-by on it that would be great.

thanks,

greg k-h
