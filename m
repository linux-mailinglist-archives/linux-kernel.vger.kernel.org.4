Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2643E62DA79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiKQMOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiKQMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:14:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BCF697FD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9037B81FF8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14469C433C1;
        Thu, 17 Nov 2022 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668687279;
        bh=5AGlEfjAH4p4s75U9CBP7W+SmAqweBoH1A780nJMhiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pf5T+HAXKsKKGjiCy+wijhg8pKq29AzH6VeFTaKNiTLDNelim0u8qwV8eS/hO3VQO
         lEQKblHAipIX8Z6LOjOFyftzm0VmJwCnz0MvFHrmPLqTG4QrdTeLwRRExQtW7oMtrN
         1oJuscIz810ePrSbKwH08Vxr9bBbQpYQKRfdP7h+c/GDoV5LGnBA7tw6YtAhLGMshJ
         sIbTfGs05lVTsQHNsfVLIDoT3Uyt5aDi91ZvhxTenq9YRtHblGPJdynySXQqWcaKYK
         x/SilLKxnYT7G1JudnmGNaDljSQut4rXVbb1+E4y5VXqfs+K9aBM8TU639s+nDT/X3
         Jb3zHJeNBNCeg==
Date:   Thu, 17 Nov 2022 13:14:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Zhou, Yun" <Yun.Zhou@windriver.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers: fix LVL_START macro
Message-ID: <20221117121436.GB839309@lothringen>
References: <20221115025614.79537-1-yun.zhou@windriver.com>
 <20221115120239.GA721394@lothringen>
 <SN6PR11MB300812CA336B497C40E93CA19F049@SN6PR11MB3008.namprd11.prod.outlook.com>
 <20221115224042.GA722789@lothringen>
 <877czuo40a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877czuo40a.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:48:05AM +0100, Thomas Gleixner wrote:
> On Tue, Nov 15 2022 at 23:40, Frederic Weisbecker wrote:
> > On Tue, Nov 15, 2022 at 01:15:11PM +0000, Zhou, Yun wrote:
> >> Hi Frederic,
> >> 
> >> The issue now is that a timer may be thrown into the upper level bucket. For example, expires 4090 and 1000 HZ, it should be in level 2, but now it will be placed in the level 3. Is this expected?
> >> 
> >>  * HZ 1000 steps
> >>  * Level Offset  Granularity            Range
> >>  *  0      0         1 ms                0 ms -         63 ms
> >>  *  1     64         8 ms               64 ms -        511 ms
> >>  *  2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
> >>  *  3    192       512 ms             4096 ms -      32767 ms (~4s - ~32s)
> >>  *  4    256      4096 ms (~4s)      32768 ms -     262143 ms (~32s - ~4m)
> >
> > The rule is that a timer is not allowed to expire too early. But it can expire
> > a bit late. Hence why it is always rounded up. So in the case of 4090, we have
> > the choice between:
> >
> > 1) expiring at bucket 2 after 4096 - 64 = 4032 ms
> > 2) expiring at bucket 3 after 4096 ms
> >
> > The 1) rounds down and expires too early. The 2) rounds up and expires a bit
> > late. So the second solution is preferred.
> 
> It's not only preferred, it's required simply because the timer wheel
> has only one guarantee: Not to expire early.
> 
> Timer wheel based timers are fundamentaly not precise unless the timeout
> is short and hits the first level.
> 
> But even hrtimers which are designed to be precise have only one real
> guarantee: Not to expire early.
> 
> hrtimers do not have the side effect of batching on long timeouts like
> timer wheel based timer have, but that's it.
> 
> Timers in the kernel come with a choice:
> 
>   -  Imprecise and inexpensive to arm and cancel (timer_list)
>   -  Precise and expensive to arm and cancel (hrtimer)
> 
> You can't have both. That's well documented.

Actually I'm pretty sure we can manage imprecise and expensive to arm and
cancel. It's a matter of willpower!

Anyway, thanks for confirming what I thought about timers guarantees.

Thanks.

> 
> Thanks,
> 
>         tglx
