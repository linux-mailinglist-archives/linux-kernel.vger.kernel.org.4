Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D7671B32
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjARLsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjARLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:44:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C74336B3F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:06:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 475D720C28;
        Wed, 18 Jan 2023 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674040010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gffaBbcofeeFiBhNAZzQqlyqYLYP0+7p/4lHz0R8tfc=;
        b=flKzyq0g6ztoMc7rANkxAYuT0tb4jrl51aFnX3C+UXTBi0yrEOhANriYnZ55Pp4IDxwgir
        4fd6uLbXKGIp1LP9aT/Ax6r4atEEqjEJRCRm/RvclMlzQ4seeVe4HuV15gTEoPCOe+teuX
        yfMy7DcgE5G4fNvDQVQwZmXMi/SlnoA=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C27032C142;
        Wed, 18 Jan 2023 11:06:49 +0000 (UTC)
Date:   Wed, 18 Jan 2023 12:06:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     =?utf-8?B?5byg5YWD54Ca?= Tio Zhang <tiozhang@didiglobal.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yuanhan Zhang <zyhtheonly@gmail.com>,
        "zwp10758@gmail.com" <zwp10758@gmail.com>,
        "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y8fSyVvnmoNnxiiD@alley>
References: <Y8UYKzBJeejHCpgO@chenyu5-mobl1>
 <37FFCAF0-B0BA-48BD-B688-B1C5E7A10A1A@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37FFCAF0-B0BA-48BD-B688-B1C5E7A10A1A@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-17 08:33:56, 张元瀚 Tio Zhang wrote:
> Hi Chen,
> Thanks for your reply! I implement this according to Petr's suggestion here:
> 
> > A solution would be to move the parent value to another line.
> > It would even better solve the situation when the task
> > is not alive and we could not get information about the parent:
> >
> >        if (pid_alive(p)) {
> >                struct parent = rcu_dereference(p->real_parent);
> >
> >                pr_info("parent:%-15.15s ppid:%-6d\n",
> >                        parent->comm, task_pid_nr(parent));
> >        }
> 
> It seems do break the original format, but I guess printing 0 as ppid when the task is not alive
> would also confuse people sometimes.

Well, a task with pid 0 does not exist so it is not that bad.
But I agree that we could do better.

> For example, when people (and also most system monitor software) see ppid, they read the value in /proc/PID/status. According to task_tgid_nr_ns(), when the task is in a container with its parent outside the
> namespace, we will also see that ppid is 0 inside the container. And in our sched_show_task() here, we are calling task_pid_nr(), so the inconsistency maybe would confuse people under this scenario.
> 
> So maybe this new line style would be a better choice? Or we just keep the original format and
> move the parent's info (and should we print the parent's pid again here) to a new line.   

What about printing something like:

		pr_info("parent:unknown\n");

or

		pr_info("parent:unknown         ppid:<NULL>;

or

		pr_info("parent:???\n");

or

		pr_info("parent:unknown (task is exiting)\n");


I slightly prefer the 2nd variant. The <NULL> string makes it rather
clear that the information is not accessible. And pid_alive() actually
does:

	return p->thread_pid != NULL;

Best Regards,
Petr
