Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729125B9EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiIOPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIOPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:20:44 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECDF7FF95;
        Thu, 15 Sep 2022 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=rtmvdMNM1tIKTKTQ4X5UMPpH4NaSm76HjovqLB0QykE=; b=NfPcGucCbwdJT5fmosDrNL6bvP
        Kus2Ef7Lkkd+ewc/l/HMeOxqAzSLH4mhEk8JllOwXwHEL0Gacq53by8GBEm/LOeq1CkgjBUE4citj
        0Q4YX/opu6q2vVm8GZyeFK5aXmCMDDsi4EQfS13vZ0ta0+n/1m1i+4b24CyhKvN4VXdiFCXUMIw0q
        57cEScy+ksf21bInUh9SySdhARep7B+fX7bvAzOYx+zSlppFso/oy/TDmNKiDlhbFQbaQ0xdKrNf1
        TB575RnLLh1fXwiSQC6tR1US1mKzC2A/lG+Q4YWkQcPO8iZM3MwBEM/oGvANF3tVSqY+449FTB9Mp
        nYA1sM7A==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oYqa4-002TWX-CQ; Thu, 15 Sep 2022 09:15:09 -0600
Message-ID: <67168c64-25f2-6efd-c743-9bc459ff87d2@deltatee.com>
Date:   Thu, 15 Sep 2022 09:15:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220908161516.4361-1-logang@deltatee.com>
 <20220908161516.4361-4-logang@deltatee.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220908161516.4361-4-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 3/3] md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Song,

On 2022-09-08 10:15, Logan Gunthorpe wrote:
> A complicated deadlock exists when using the journal and an elevated
> group_thrtead_cnt. It was found with loop devices, but its not clear
> whether it can be seen with real disks. The deadlock can occur simply
> by writing data with an fio script.
> 
> When the deadlock occurs, multiple threads will hang in different ways:
> 
>  1) The group threads will hang in the blk-wbt code with bios waiting to
>     be submitted to the block layer:
> 
>         io_schedule+0x70/0xb0
>         rq_qos_wait+0x153/0x210
>         wbt_wait+0x115/0x1b0
>         io_schedule+0x70/0xb0
>         rq_qos_wait+0x153/0x210
>         wbt_wait+0x115/0x1b0
>         __rq_qos_throttle+0x38/0x60
>         blk_mq_submit_bio+0x589/0xcd0
>         wbt_wait+0x115/0x1b0
>         __rq_qos_throttle+0x38/0x60
>         blk_mq_submit_bio+0x589/0xcd0
>         __submit_bio+0xe6/0x100
>         submit_bio_noacct_nocheck+0x42e/0x470
>         submit_bio_noacct+0x4c2/0xbb0
>         ops_run_io+0x46b/0x1a30
>         handle_stripe+0xcd3/0x36b0
>         handle_active_stripes.constprop.0+0x6f6/0xa60
>         raid5_do_work+0x177/0x330
> 
>     Or:
>         io_schedule+0x70/0xb0
>         rq_qos_wait+0x153/0x210
>         wbt_wait+0x115/0x1b0
>         __rq_qos_throttle+0x38/0x60
>         blk_mq_submit_bio+0x589/0xcd0
>         __submit_bio+0xe6/0x100
>         submit_bio_noacct_nocheck+0x42e/0x470
>         submit_bio_noacct+0x4c2/0xbb0
>         flush_deferred_bios+0x136/0x170
>         raid5_do_work+0x262/0x330
> 
>  2) The r5l_reclaim thread will hang in the same way, submitting a
>     bio to the block layer:
> 
>         io_schedule+0x70/0xb0
>         rq_qos_wait+0x153/0x210
>         wbt_wait+0x115/0x1b0
>         __rq_qos_throttle+0x38/0x60
>         blk_mq_submit_bio+0x589/0xcd0
>         __submit_bio+0xe6/0x100
>         submit_bio_noacct_nocheck+0x42e/0x470
>         submit_bio_noacct+0x4c2/0xbb0
>         submit_bio+0x3f/0xf0
>         md_super_write+0x12f/0x1b0
>         md_update_sb.part.0+0x7c6/0xff0
>         md_update_sb+0x30/0x60
>         r5l_do_reclaim+0x4f9/0x5e0
>         r5l_reclaim_thread+0x69/0x30b
> 
>     However, before hanging, the MD_SB_CHANGE_PENDING flag will be
>     set for sb_flags in r5l_write_super_and_discard_space(). This
>     flag will never be cleared because the submit_bio() call never
>     returns.
> 
>  3) Due to the MD_SB_CHANGE_PENDING flag being set, handle_stripe()
>     will do no processing on any pending stripes and re-set
>     STRIPE_HANDLE. This will cause the raid5d thread to enter an
>     infinite loop, constantly trying to handle the same stripes
>     stuck in the queue.
> 
>     The raid5d thread has a blk_plug that holds a number of bios
>     that are also stuck waiting seeing the thread is in a loop
>     that never schedules. These bios have been accounted for by
>     blk-wbt thus preventing the other threads above from
>     continuing when they try to submit bios. --Deadlock.
> 
> To fix this, add the same wait_event() that is used in raid5_do_work()
> to raid5d() such that if MD_SB_CHANGE_PENDING is set, the thread will
> schedule and wait until the flag is cleared. The schedule action will
> flush the plug which will allow the r5l_reclaim thread to continue,
> thus preventing the deadlock.
> 
> It's not clear when the deadlock was introduced, but the similar
> wait_event() call in raid5_do_work() was added in 2017 by this
> commit:
> 
>     16d997b78b15 ("md/raid5: simplfy delaying of writes while metadata
>                    is updated.")
> 
> Link: https://lore.kernel.org/r/7f3b87b6-b52a-f737-51d7-a4eec5c44112@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Seems this patch of mine that is in md-next is causing an 1 in ~30
failure on the mdadm test 13imsm-r0_r5_3d-grow-r0_r5_4d.

I'm looking into it and will try to send an updated patch when I have a fix.

Logan
