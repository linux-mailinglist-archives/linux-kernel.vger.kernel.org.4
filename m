Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61EF65D482
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjADNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjADNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:40:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE238A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:40:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0867C3F068;
        Wed,  4 Jan 2023 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672839652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a05lvaNmtUMU+F8+Adl3Kvy4FXL1d+7IfQjFWRQ1ulg=;
        b=lALfakv0KQ6G0zuzJKNDNew4Q9KqAkf2JgFlpyZT8YGG/cV//wVHIslY3AuZHBkm97ODvy
        anx2tqWhE5GPZnbkK48sCbZWTpaFhmgO70oO+leYu7YLr5PcSedAG2ZvNwZRyJYLA///Ry
        mTwJ95lSD7RkqXpEXGYCbJO9z625kMY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D99732C141;
        Wed,  4 Jan 2023 13:40:51 +0000 (UTC)
Date:   Wed, 4 Jan 2023 14:40:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     =?utf-8?B?5byg5YWD54Ca?= <zyhtheonly@gmail.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        zyhtheonly@yeah.net, zwp10758@gmail.com
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y7WB4cgLvPs2gYX4@alley>
References: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
 <Y60WrwuM43HcNVC7@chenyu5-mobl1>
 <CAEQmJ=gcCx1hMf7HicE5OFeUstipdtr=3JkF1JxLuP-CrG++Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEQmJ=gcCx1hMf7HicE5OFeUstipdtr=3JkF1JxLuP-CrG++Pw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-01-04 01:51:30, 张元瀚 wrote:
> Hi Chen,
> Thanks for your advice!
> 
> > Maybe struct task_struct *parent = rcu_dereference(p->real_parent);
> > and use parent directly to get its pid and comm?
> 
> Yes! It is good to write this way.
> 
> > Maybe off-topic, what if the parent is a kernel thread/worker? It might
> have extra
> > name information such as kthread->full_name or worker->desc according to
> proc_task_name().
> 
> I'm not quite sure if it is necessary to fetch that extra information since
> our sched_show_task() prints p->comm ourselves.
> But, assuming we get the parent's name in the same way we get
> proc_task_name(), there are some new issues I'd like to discuss.

I suggest to keep it simple and just print "parent->comm".

Especially, we should avoid taking any lock. shed_show_task() might
be called when there already is a deadlock on the system. I guess
that it even can be called from NMI.

For example, see print_worker_info(). It uses
copy_from_kernel_nofault() to be safe without taking any lock.

Best Regards,
Petr
