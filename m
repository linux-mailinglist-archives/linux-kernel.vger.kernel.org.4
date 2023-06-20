Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F7737269
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFTRNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFTRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB0C1710;
        Tue, 20 Jun 2023 10:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636D361337;
        Tue, 20 Jun 2023 17:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C431C433C8;
        Tue, 20 Jun 2023 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687281206;
        bh=6P2RYz2pKYvAhsFqeavj7P9pbG1HmamkYK9RGXeKqoM=;
        h=Date:To:Cc:From:Subject:From;
        b=p+AJx4UGMfr0iqh4hxnqMYYnaoS5BxFjPkKFXqOiqtqkFN2MHwcbtCr97mdGQ/xwu
         FQMaMFm+TY7uNhZk4kk/NnOgU9Dq4xwy2omVvEQ4oSfGgJCv+tjOw1ZTNSgc+vpR3/
         NWpKTDQAy++c/NQrkJV+JcqPOsI0PI7I3v6hxKlbuh14Vb/o1vQ9QNF3YohGQTmmXE
         Is0db80Mzmf5B91O/U3rvfQQTe1tx8XbgeFQNw2dN4mJtfBu5fD7oHX2rRY7jehDQL
         d/o8dv2mgK35EBJJui5dJNudX3NVm2bo3LhDO9qbwj5/6jRSS6zZItEwgE6CqQ/MpN
         0ZG+1AULWB6jg==
Message-ID: <d6113bec-6591-2efc-2255-66867e5db899@kernel.org>
Date:   Tue, 20 Jun 2023 19:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hao Jia <jiahao.os@bytedance.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josh Don <joshdon@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Odin Ugedal <odin@uged.al>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peng Wang <rocking@linux.alibaba.com>,
        Phil Auld <pauld@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>, Qian Cai <cai@lca.pw>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhen Ni <nizhen@uniontech.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Ben Segall <bsegall@google.com>,
        John Stultz <jstultz@google.com>,
        David Vernet <void@manifault.com>,
        Vlastimil Babka <vbabka@suse.cz>, Chris Mason <clm@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        John Kacur <jkacur@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
        Kate Carcia <kcarcia@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Min Yu <myu@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Brown <mark.brown@linaro.org>,
        joseph.salisbury@canonical.com,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Guenter Roeck <linux@roeck-us.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        "bristot@kernel.org" <bristot@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [ANNOUNCEMENT] CFP: Real-time and Scheduling MC at LPC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real-time and scheduling micro-conference joins these two
intrinsically connected communities to discuss the next steps together.

Over the past decade, many parts of PREEMPT_RT have been included
in the official Linux codebase. Examples include real-time mutexes,
high-resolution timers, lockdep, ftrace, RCU_PREEMPT, threaded interrupt
handlers, and more. The number of patches that need integration has been
significantly reduced, and the rest is mature enough to make their way
into mainline Linux.

The scheduler is at the core of Linux performance. With different
topologies and workloads, giving the user the best experience possible is
challenging, from low latency to high throughput and from small
power-constrained devices to HPC, where CPU isolation is critical.

The following accomplishments have been made as a result of last
year’s micro-conference:

 - Progress on rtla/osnoise to support any workload [1]
 - Progress on adding tracepoints for IPI [2]
 - Improvements in RCU to reduce noise
 - Progress on the latency-nice patch set [3]

Ideas of topics to be discussed include (but are not limited to):

 - Improve responsiveness for CFS tasks - e.g., latency-nice patch
 - The new EEVDF scheduler proposal [4]
 - Impact of new topology on CFS including hybrid or heterogeneous system
 - Taking into account task profile with IPCC or uclamp
 - Improvements in CPU Isolation
 - The status of PREEMPT_RT
 - Locking improvements - e.g., proxy execution [5]
 - Improvements on SCHED_DEADLINE
 - Tooling for debugging scheduling and real-time

It is fine if you have a new topic that is not on the list.
People are encouraged to submit any topic related to real-time
and scheduling.

Please consider that the goal is to discuss open problems, preferably
with patch set submissions already in discussion on LKML. The
presentations are very short, and the main portion of the time should
be given to the debate - thus, the importance of having an
open and relevant problem, with people in the community engaged
in the solution.

Submissions are made via LPC submission systems, selecting *Track Real-time
and Scheduling MC*

Please, forward this email for people interested on this subject (it not easy to
build the Cc: list for this email without forgetting important people :-))!

[1] https://lore.kernel.org/lkml/f5cfbd37aefd419eefe9243b4d2fc38ed5753fe4.1668692096.git.bristot@kernel.org/
[2] https://lore.kernel.org/lkml/20230307143558.294354-1-vschneid@redhat.com/T/
[3] https://lore.kernel.org/lkml/20230224093454.956298-3-vincent.guittot@linaro.org/
[4] https://lore.kernel.org/lkml/20230328092622.062917921@infradead.org/T/
[5] https://lore.kernel.org/lkml/20230411042511.1606592-1-jstultz@google.com/

Thanks!

-- Organizers:
 - Daniel Bristot de Oliveira
 - Juri Lelli
 - Vincent Guittot
 - Steven Rostedt
