Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC58665039
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjAKAJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjAKAJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:09:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AB311C02
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51984B80F92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC7C433D2;
        Wed, 11 Jan 2023 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673395786;
        bh=HB4XAeRTp61OHmgdavBJ9HANdrwwjdFDvzdf27/ncI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f98Sk2XywpmZWPGw1IkbIboSOQ+FWx69/4SBP3t0uvElFQwY4XOb+bZIBEsJhwgGp
         SK3lGO7IUT6zedtonkiT5kba7XdCBDjG277KeuCLf+wRbs3uGXQ4rCfo5p/F5rdkJx
         J7d/zLBQtvJ50osPgbqKd4jVJ51aqvEtLtiLAXJ8TCVaqpgW/lzgqh4+Ytw/6erJLs
         GaODBbyufi/afVqoQDmYUHuXMJ0iKVMSVUZ9+OhEAnwKwsATz7EmCmcDvkrqhW95x8
         iTddLmAom+SzggiuOxy6btXukmwIjSidUIzUK/YPpmR0Ldj90YUzIP3dSb8U/zWaqF
         nz0n5VI99uH7g==
Date:   Wed, 11 Jan 2023 01:09:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y73+R3RPjlbQJx+U@lothringen>
References: <20230110151901.402-1-hdanton@sina.com>
 <20230110235822.456-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110235822.456-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 07:58:22AM +0800, Hillf Danton wrote:
> On 10 Jan 2023 17:12:22 +0100 Frederic Weisbecker <frederic@kernel.org>
> > On Tue, Jan 10, 2023 at 11:19:01PM +0800, Hillf Danton wrote:
> > > On Tue, 10 Jan 2023 08:50:28 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > > > On Tue, Jan 10, 2023 at 10:43:56AM +0800, Hillf Danton wrote:
> > > > > On 9 Jan 2023 11:12:49 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > > > > > 
> > > > > > Yes, but if you do not return to userspace, then the per-CPU vm
> > > > > > statistics can be dirty indefinitely.
> > > > > 
> > > > > Could you specify the reasons for failing to return to userspace,
> > > > > given it is undesired intereference for the shepherd to queue work
> > > > > on the isolated CPUs.
> > > > 
> > > > Any system call that takes longer than the threshold to sync vmstats.
> > > 
> > > Which ones?
> > > 
> > > If schedule() occurs during syscall because of acquiring mutex for instance
> > > then anything on the isolated runqueue, including workqueue worker shepherd
> > > wakes up, can burn CPU cycles without undesired interference produced.
> > 
> > The above confuses me. How others tasks would help with syscalls that take too long too
> > service?
> 
> Given no scheduling in userspace, no chance for other tasks to interfere
> after returning to userspace, on one hand.
> 
> Upon scheduling during syscall on the other hand, it is the right time
> to sync vmstats for example. But no vmstats can be updated without works
> queued by shepherd.
> 
> In a nutshell, no interference could happen without scheduling, and how
> work is queued does not matter. So the current shepherd behavior is prefered.

I'm still confused... We want to avoid the shepherd because it may queue the
vmstat work while the task wants to run noise-free in userspace.

> > 
> > > > 
> > > > Or a long running kernel thread, for example:
> > > 
> > > It is a buggyyyy example.
> > > > 
> > > > https://stackoverflow.com/questions/65111483/long-running-kthread-and-synchronize-net
> > 
> > I can imagine a CPU spending most of its time processing networking packets
> > through interrupts/softirq within ksoftirqd/NAPI while another CPU process
> > these packets in userspace.
> > 
> > In this case the CPU handling the kernel part can theoretically never go to
> > idle/user. nohz_full isn't optimized toward such job but there is nothing
> > to prevent it from doing such job.
> 
> A simple FIFO task launched by an administrator can get a CPU out of scheduler's
> control for a week, regardless of isolation.

Sure. But, what do you mean by that exactly?

Thanks.
