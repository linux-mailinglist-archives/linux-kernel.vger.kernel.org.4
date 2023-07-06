Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB374A23D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGFQdJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 12:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA5183;
        Thu,  6 Jul 2023 09:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E07260F16;
        Thu,  6 Jul 2023 16:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4518EC433C7;
        Thu,  6 Jul 2023 16:33:03 +0000 (UTC)
Date:   Thu, 6 Jul 2023 12:33:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vivek Anand <vivekanand754@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "J. Avila" <elavila@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        x86@kernel.org
Subject: Re: High cpu usage caused by kernel process when upgraded to linux
 5.19.17 or later
Message-ID: <20230706123300.55d6450b@gandalf.local.home>
In-Reply-To: <CAJnqnX5dHiXe3smKhj6JT9+6FNdgrAR=5_Hm8BSRpVF3uARYUg@mail.gmail.com>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
        <ZJpJkL3dPXxgw6RK@debian.me>
        <20230627073035.GV4253@hirez.programming.kicks-ass.net>
        <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
        <20230627101939.GZ4253@hirez.programming.kicks-ass.net>
        <CAJnqnX5rYn65zVQ+SLN4m4ZzM_jOa_RjGhazWO=Fh8ZvdOCadg@mail.gmail.com>
        <878rc22vxq.ffs@tglx>
        <CAJnqnX5dHiXe3smKhj6JT9+6FNdgrAR=5_Hm8BSRpVF3uARYUg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 18:23:25 +0530
Vivek Anand <vivekanand754@gmail.com> wrote:

> Hi Thomas,
> 
> Further analyzing, I found that I did set
> "CONFIG_NETFILTER_XT_MATCH_LIMIT=m" in my kernel config earlier which was
> causing high CPU consumption.
> Setting it to "CONFIG_NETFILTER_XT_MATCH_LIMIT=n" resolved the high CPU
> issue.
> 
> Is there any suggestion regarding the use of this config
> "CONFIG_NETFILTER_XT_MATCH_LIMIT" as I'm getting high CPU by setting it to
> "m" ?

That config enables the compiling of: net/netfilter/xt_limit.c

The htable_gc that you reported is defined in: net/netfilter/xt_hashlimit.c

It has:

static void htable_gc(struct work_struct *work)
{
        struct xt_hashlimit_htable *ht;

        ht = container_of(work, struct xt_hashlimit_htable, gc_work.work);

        htable_selective_cleanup(ht, false);

        queue_delayed_work(system_power_efficient_wq,
                           &ht->gc_work, msecs_to_jiffies(ht->cfg.gc_interval));
}

So it queues itself every ht->cfg.gc_interval msecs. That variable seems to
come from some configuration of netfilter, and I think you can see these in:

 find /proc/sys/net -name 'gc_interval'

Perhaps you have it set off to go too much?

-- Steve


> 
> Thanks,
> Vivek
> 
> On Thu, Jun 29, 2023 at 7:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, Jun 29 2023 at 12:05, Vivek Anand wrote:
> > > I've tried booting with "spectre_v2=retpoline retbleed=off".
> > > This change didn't work. Still CPU is 100%
> >
> > This does not make sense.
> >
> > retbleed=off has the same effect as CONFIG_X86_IBRS_ENTRY=n.
> >
> > The only difference is that with CONFIG_X86_IBRS_ENTRY=y and
> > retbleed=off there is one extra jump in the low level entry code
> > (syscall, interrupts, exceptions) and one extra jump on the exit side.
> >
> > But those extra jumps are completely irrelevant for the kworker threads.
> >
> > Can you please provide dmesg and the content of the files in
> >
> >  /sys/devices/system/cpu/vulnerabilities/
> >
> > on a kernel booted with "spectre_v2=retpoline retbleed=off" ?
> >
> > Thanks,
> >
> >         tglx
> >

