Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244CA6D9E43
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbjDFRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjDFRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:13:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8676A6B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:13:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680801223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZeWqjwkXqctFtm5vJqndU1KAum2etTHdfAsXlyM8ELw=;
        b=oFb5THzEJEI8+gj6mu22TwoEOBqwAwuc/M4bp7NOfkKqgPfveoYRLdISk8HxDg1Zg9dMie
        Zc82erZ35RYySe+CSujLZxVHibqjfafumZMKWvkQqhlpWzv2mE98i/uhFREF7AazxJtW2+
        sWvzgz6tQmVBPFr5g/G8uvrjKZ2nTL1klqJNzphPb1MXMQOeL1SBXHkm30OHvw9NvnLDpp
        oY99EqXdlWc/9TtU4CI3UVLAVEFzz5HEOWNda07ICz+ptKxDNAvhEMM/3YsxOwlgrJnusy
        lU3Y/VXTl88MGtq54bFUQ46l/WHxvkCnir3yJKoWzY89Ro3uhar6vuxlYqFgMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680801223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZeWqjwkXqctFtm5vJqndU1KAum2etTHdfAsXlyM8ELw=;
        b=uQ7P+ZBWVNw5KCEkupnBEdm95k8ARZqCFHfrkwci84xGR51RM3b98A93TRP+i+Ug7nMRZI
        +notRYmEzUWmBPCg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [RFC] tick_sched_timer() is not properly aligned, fixed by chance
In-Reply-To: <20230406150254.ZrawA2Y-@linutronix.de>
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx> <20230406150254.ZrawA2Y-@linutronix.de>
Date:   Thu, 06 Apr 2023 19:13:41 +0200
Message-ID: <87jzypq6gq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06 2023 at 17:02, Sebastian Andrzej Siewior wrote:
> On 2023-04-06 13:08:29 [+0200], Thomas Gleixner wrote:
> The first one added is hpet. It points to "jiffies" as name and
> jiffies_read() as ->read().
>
> Before the change/ with PeterZ change I get from ktime_get() for
> base/nsec something like:
> |[    0.004000] tick_next_period Name: jiffies jiffies_read+0x0/0x10
> |[    0.004000] tick_next_period base/nsec: -401771248 405771248
> |[    0.004000] tick_next_period hpet 4000000
>
> base/nsec is different on each boot but it always ends up with 4000000.
> With the optimisation, ktime_get() is:
> | [    1.179079] tick_next_period base/nsec: 647439581 518613145
> | [    1.179646] tick_next_period hpet 1166052726
>
> so something is using it during init. And this is
> 	read_persistent_wall_and_boot_offset()

Duh, yes. I remember now. That was done to take the TSC "uptime" into
account, which is sensible.

So making tick_next_period aligned to TICK_NSEC in tick_setup_device()
is the right thing to do in general then.

Thanks,

        tglx
