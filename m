Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62AA6DCC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDJUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D4AB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681160010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4JQWssSZwpQKK+gUirN9oNcVHbnzbE+PBErzg92h2M=;
        b=DsmfJLSDX9OtUzzTWCfTrRHh+MsLRg+vq/olJ/IGvkeDyllNBjs3n4B6usagSoNFN9xmPC
        6A3b1ronjJ+xfsiVUpWJMB+dNtjlcnBOEmgQeM63YXuN9w8r3cw3SWcwFbycEGZ9FWptiB
        vpWWKXTImh+Z99aAt/E+7Veb9SuRiXVpcYGEOrJca/Udqt1lNDbf3JDLpHS2edd6dcFuOW
        SyebLdfZCqkZUi27/lyG5bHHwihJat9/VS1dP8xAE8VaO4qMx5dxC7AxSsQPiwPUtt4tmj
        zB3riat/ZP+7GdbzMX+OldTTq0iiuXXupZ3aAmXRfUhxP8j8yWcjwFD8w+A4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681160010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4JQWssSZwpQKK+gUirN9oNcVHbnzbE+PBErzg92h2M=;
        b=hEzrXCQ4TUe2yCP6o4OX6MespJKQQ0CY1WRuSZDS2tcHf0RiOXmJgDtiJaW6f1OngO/oTA
        /eU56R48Dk9hjJCw==
To:     Ye Bin <yebin@huaweicloud.com>, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com, yebin@huaweicloud.com,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] lib/percpu_counter: fix dying cpu compare race
In-Reply-To: <20230406015629.1804722-3-yebin@huaweicloud.com>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
 <20230406015629.1804722-3-yebin@huaweicloud.com>
Date:   Mon, 10 Apr 2023 22:53:30 +0200
Message-ID: <877cuj1mt1.ffs@tglx>
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

On Thu, Apr 06 2023 at 09:56, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
> condition between a cpu dying and percpu_counter_sum() iterating online CPUs
> was identified.
> Acctually, there's the same race condition between a cpu dying and
> __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
> But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
> then maybe return incorrect result.
> To solve above issue, also need to add dying CPUs count when do quick judgment
> in __percpu_counter_compare().

This is all bogus including the above commit.

All CPU masks including cpu_online_mask and cpu_dying_mask are only
valid when the context is:

  - A CPU hotplug callback

  - Any other code which holds cpu_hotplug_lock read or write locked.

cpu_online_mask is special in that regard. It is also protected against
modification in any preemption disabled region, but that's a pure
implementation detail.

cpu_dying_mask is a random number generator w/o cpu_hotplug_lock being
held. And even with that lock held any cpumask operation on it is silly.
The mask is a core detail:

  commit e40f74c535b8 "cpumask: Introduce DYING mask"
    
    Introduce a cpumask that indicates (for each CPU) what direction the
    CPU hotplug is currently going. Notably, it tracks rollbacks. Eg. when
    an up fails and we do a roll-back down, it will accurately reflect the
    direction.

It does not tell anything to a user which is not aware of the actual
hotplug state machine state.


The real reason for this percpu counter issue is how percpu counter
hotplug callbacks are implemented: They are asymmetric and at the
completely wrong place.

The above 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") was
done via XFS and without the courtesy of CC'ing the people who care
about the CPU hotplug core. The lenghty analysis of this commit is all
shiny, but fundamentally wrong. See above.

I'm way too tired to come up with a proper fix for this mess, but I'm
going to stare at it tomorrow morning with brain awake.

Thanks,

        tglx
