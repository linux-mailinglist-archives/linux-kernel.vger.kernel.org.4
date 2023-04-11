Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79376DD387
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDKG45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDKG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:56:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705961BCE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:56:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681196208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXIB59EbtVdksLT+wsAse63+38ZSeeP3bCJp0P18k5w=;
        b=cG1NN0R6Zebj3uVriz/N4yE1Yuu9wbdRQxcb0JvzOYGDCl1iMKZLfLV7w8EHWskwBf+4pc
        SIVzOjvEHj0dpD3f3+letQqWkxlNRB+PPIEOgyY5fckTI0wKlcVqnucgQV7rX3zj3MX50K
        gNca5Iq/IrWBLNPkBd9zGepmTp95fHFNKJEACZ2x0nymvYQA8F54VeQg5Zu07sy246MvqL
        kdE6jn4dephOm20CzWieXCQqauJ6yD7tyr/cf/zYqKFfpNdtGBKGimKHpVhj7vQtTFuHzY
        /3lGH05/XTeGj3uyc3JoMWydC6ORwc8/jXN3NY5TTRwCnh/G11LQ+KaP8w9CQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681196208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXIB59EbtVdksLT+wsAse63+38ZSeeP3bCJp0P18k5w=;
        b=qfH70LiJxuNow2J6hVZf9FG47KKDjkCVjGv/McCbLSwvoQvIp+isTn8SNGdZUcID8015c0
        jSfws4+E96iGHJDw==
To:     Ye Bin <yebin@huaweicloud.com>, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com, yebin@huaweicloud.com,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] lib/percpu_counter: fix dying cpu compare race
In-Reply-To: <877cuj1mt1.ffs@tglx>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
 <20230406015629.1804722-3-yebin@huaweicloud.com> <877cuj1mt1.ffs@tglx>
Date:   Tue, 11 Apr 2023 08:56:48 +0200
Message-ID: <874jpm29fz.ffs@tglx>
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

On Mon, Apr 10 2023 at 22:53, Thomas Gleixner wrote:
> On Thu, Apr 06 2023 at 09:56, Ye Bin wrote:
> cpu_dying_mask is a random number generator w/o cpu_hotplug_lock being
> held. And even with that lock held any cpumask operation on it is silly.
> The mask is a core detail:
>
>   commit e40f74c535b8 "cpumask: Introduce DYING mask"
>     
>     Introduce a cpumask that indicates (for each CPU) what direction the
>     CPU hotplug is currently going. Notably, it tracks rollbacks. Eg. when
>     an up fails and we do a roll-back down, it will accurately reflect the
>     direction.
>
> It does not tell anything to a user which is not aware of the actual
> hotplug state machine state.

Even if the mask is most of the time stable, it's a total disaster
performance wise. The bits in cpu_dying_mask are sticky until the next
online operation.

So for a system which has SMT enabled in BIOS, but SMT is disabled on
the kernel command line or later via the sysfs knob, this means that the
loop in __percpu_counter_sum() will iterate over all shutdown SMT
siblings forever. IOW, it will touch nr_of_shutdown_cpus() cachelines
for absolutely zero reason.

The same applies for the proposed counter.

Thanks,

        tglx
