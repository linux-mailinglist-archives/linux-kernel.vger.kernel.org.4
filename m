Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1D5BD4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiISScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE14C2B61F;
        Mon, 19 Sep 2022 11:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68EF161E56;
        Mon, 19 Sep 2022 18:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15D6C4347C;
        Mon, 19 Sep 2022 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663612314;
        bh=eBe7RyizmW840Fd/CyPXa8TJI1DFASq1ukNAO0K6BaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R2gBHS8ycYDs8mO/ImY8UvLecWeft6coOr3mv+ydTfCkvL8ssACd8FBdj2MJM5IAB
         vPuG0fAdsSiaXKo9YqVV4zWcCbR6+IVCBc/Z0H/APldzQknJ4+L3P6+4G0Ml8F7jxp
         iR0YxS8jBNe1r1hZlH8VSO6NAO0WqN3ASpEx1vazXe9hlYUZ9+4Xv12ovJqTEMgSYm
         WnWug+pgfjv5hyMkbAql3MEzAR9oOYeBlF5PpsjB2wR0st4wP3rxP4K1wY9wu6jvrn
         WjYC7m6Z2WJ38wEYyKQJHJ5mIzOblJkLutzW9jnFezYNkpdIWkS6oci+U5CYJErvWW
         7Onrf5j919Jeg==
Received: by mail-ej1-f52.google.com with SMTP id dv25so621438ejb.12;
        Mon, 19 Sep 2022 11:31:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Ucl1kjR71nri+Yttw2mo4HkZ3IrY07QtK0DqxAROCAvVci6Kx
        3ZS58EuN7y7Z6Aibtcxsfi4MZba5JOAiVcUE2Wk=
X-Google-Smtp-Source: AMsMyM4ZN+mc8Iy57stvoah59AhTQSn45EbgjwKTG6R+dNzpGlpB91DhOxgrHZB8y7tOiRDqCySWeTj9InSw8nyNIpI=
X-Received: by 2002:a17:906:6a0f:b0:779:2fc:9a51 with SMTP id
 qw15-20020a1709066a0f00b0077902fc9a51mr14055899ejc.101.1663612312860; Mon, 19
 Sep 2022 11:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220908161516.4361-1-logang@deltatee.com> <20220908161516.4361-4-logang@deltatee.com>
 <67168c64-25f2-6efd-c743-9bc459ff87d2@deltatee.com>
In-Reply-To: <67168c64-25f2-6efd-c743-9bc459ff87d2@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 19 Sep 2022 11:31:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5_BwaxMijM9e1JefRsmwokZ=mdups3TVSyhz-cxHOP8Q@mail.gmail.com>
Message-ID: <CAPhsuW5_BwaxMijM9e1JefRsmwokZ=mdups3TVSyhz-cxHOP8Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 8:15 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> Hi Song,
>
> On 2022-09-08 10:15, Logan Gunthorpe wrote:
> > A complicated deadlock exists when using the journal and an elevated
> > group_thrtead_cnt. It was found with loop devices, but its not clear
> > whether it can be seen with real disks. The deadlock can occur simply
> > by writing data with an fio script.
> >
> > When the deadlock occurs, multiple threads will hang in different ways:
> >
> >  1) The group threads will hang in the blk-wbt code with bios waiting to
> >     be submitted to the block layer:
> >
> >         io_schedule+0x70/0xb0
> >         rq_qos_wait+0x153/0x210
> >         wbt_wait+0x115/0x1b0
> >         io_schedule+0x70/0xb0
> >         rq_qos_wait+0x153/0x210
> >         wbt_wait+0x115/0x1b0
> >         __rq_qos_throttle+0x38/0x60
> >         blk_mq_submit_bio+0x589/0xcd0
> >         wbt_wait+0x115/0x1b0
> >         __rq_qos_throttle+0x38/0x60
> >         blk_mq_submit_bio+0x589/0xcd0
> >         __submit_bio+0xe6/0x100
> >         submit_bio_noacct_nocheck+0x42e/0x470
> >         submit_bio_noacct+0x4c2/0xbb0
> >         ops_run_io+0x46b/0x1a30
> >         handle_stripe+0xcd3/0x36b0
> >         handle_active_stripes.constprop.0+0x6f6/0xa60
> >         raid5_do_work+0x177/0x330
> >
> >     Or:
> >         io_schedule+0x70/0xb0
> >         rq_qos_wait+0x153/0x210
> >         wbt_wait+0x115/0x1b0
> >         __rq_qos_throttle+0x38/0x60
> >         blk_mq_submit_bio+0x589/0xcd0
> >         __submit_bio+0xe6/0x100
> >         submit_bio_noacct_nocheck+0x42e/0x470
> >         submit_bio_noacct+0x4c2/0xbb0
> >         flush_deferred_bios+0x136/0x170
> >         raid5_do_work+0x262/0x330
> >
> >  2) The r5l_reclaim thread will hang in the same way, submitting a
> >     bio to the block layer:
> >
> >         io_schedule+0x70/0xb0
> >         rq_qos_wait+0x153/0x210
> >         wbt_wait+0x115/0x1b0
> >         __rq_qos_throttle+0x38/0x60
> >         blk_mq_submit_bio+0x589/0xcd0
> >         __submit_bio+0xe6/0x100
> >         submit_bio_noacct_nocheck+0x42e/0x470
> >         submit_bio_noacct+0x4c2/0xbb0
> >         submit_bio+0x3f/0xf0
> >         md_super_write+0x12f/0x1b0
> >         md_update_sb.part.0+0x7c6/0xff0
> >         md_update_sb+0x30/0x60
> >         r5l_do_reclaim+0x4f9/0x5e0
> >         r5l_reclaim_thread+0x69/0x30b
> >
> >     However, before hanging, the MD_SB_CHANGE_PENDING flag will be
> >     set for sb_flags in r5l_write_super_and_discard_space(). This
> >     flag will never be cleared because the submit_bio() call never
> >     returns.
> >
> >  3) Due to the MD_SB_CHANGE_PENDING flag being set, handle_stripe()
> >     will do no processing on any pending stripes and re-set
> >     STRIPE_HANDLE. This will cause the raid5d thread to enter an
> >     infinite loop, constantly trying to handle the same stripes
> >     stuck in the queue.
> >
> >     The raid5d thread has a blk_plug that holds a number of bios
> >     that are also stuck waiting seeing the thread is in a loop
> >     that never schedules. These bios have been accounted for by
> >     blk-wbt thus preventing the other threads above from
> >     continuing when they try to submit bios. --Deadlock.
> >
> > To fix this, add the same wait_event() that is used in raid5_do_work()
> > to raid5d() such that if MD_SB_CHANGE_PENDING is set, the thread will
> > schedule and wait until the flag is cleared. The schedule action will
> > flush the plug which will allow the r5l_reclaim thread to continue,
> > thus preventing the deadlock.
> >
> > It's not clear when the deadlock was introduced, but the similar
> > wait_event() call in raid5_do_work() was added in 2017 by this
> > commit:
> >
> >     16d997b78b15 ("md/raid5: simplfy delaying of writes while metadata
> >                    is updated.")
> >
> > Link: https://lore.kernel.org/r/7f3b87b6-b52a-f737-51d7-a4eec5c44112@deltatee.com
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>
> Seems this patch of mine that is in md-next is causing an 1 in ~30
> failure on the mdadm test 13imsm-r0_r5_3d-grow-r0_r5_4d.
>
> I'm looking into it and will try to send an updated patch when I have a fix.

Thanks for the heads-up! I will remove this one from md-next for now.

Song
