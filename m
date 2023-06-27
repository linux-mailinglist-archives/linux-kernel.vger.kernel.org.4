Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D573F5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjF0Hbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF0Hb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:31:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FEF1FCD;
        Tue, 27 Jun 2023 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XQpa9c5hGVf8V5MZIB+d15K6Y/YiH5GoQw4fpAih31c=; b=KrtBPNpF+/+Tvnv2Z7JXUi4f/S
        nZb2l3/seqDyn86tl2FfkGPi5EPd2K4TCsiUhgXLfa1O9f+TTU+cLhuR74Muo9mDVrhsXZAWmYx8l
        VyVdZhRJYhA+3dbd4lrfj4lWkGpHr+gPXdQjB/csHH88IEv1EpdjmCizemHKD4PY5MEGQHo/pRjwL
        igyxgnZXRGwnad91S1V0f+pKr+LYehCS9U319UfqfDStSJeIkz1AgvLxUluSzRGzYADOb76MRx3Su
        lyXeV2eaNAyEvYBq8j0X3JkoaPXEIICJRsp+0383NqG35INqi7T6Aoxo6nIXOgq1Zt9p+nsO15H7p
        YbR8by3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qE39r-004ZqJ-2r;
        Tue, 27 Jun 2023 07:30:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33F733002D6;
        Tue, 27 Jun 2023 09:30:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14A37248044D4; Tue, 27 Jun 2023 09:30:35 +0200 (CEST)
Date:   Tue, 27 Jun 2023 09:30:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
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
        Vivek Anand <vivekanand754@gmail.com>,
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
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
Message-ID: <20230627073035.GV4253@hirez.programming.kicks-ass.net>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
 <ZJpJkL3dPXxgw6RK@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZJpJkL3dPXxgw6RK@debian.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:29:36AM +0700, Bagas Sanjaya wrote:
> On Fri, Jun 23, 2023 at 07:58:51AM +0700, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >=20
> > > kernel process "kworker/events_power_efficient" uses a lot of cpu pow=
er (100% on ESXI 6.7, ~30% on ESXI 7.0U3 or later) after upgrading from 5.1=
7.3 to 5.19.17 or later.
> > >=20
> > > dmesg log:
> > > [ 2430.973102]  </TASK>
> > > [ 2430.973131] Sending NMI from CPU 1 to CPUs 0:
> > > [ 2430.973241] NMI backtrace for cpu 0
> > > [ 2430.973247] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted 6.3.3 #1
> > > [ 2430.973254] Hardware name: VMware, Inc. VMware Virtual Platform/44=
0BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > > [ 2430.973258] Workqueue: events_power_efficient htable_gc [xt_hashli=
mit]
> > > [ 2430.973275] RIP: 0010:preempt_count_sub+0x2e/0xa0
> > > [ 2430.973289] Code: 36 01 85 c9 75 1b 65 8b 15 a7 da f8 5e 89 d1 81 =
e1 ff ff ff 7f 39 f9 7c 16 81 ff fe 00 00 00 76 3b f7 df 65 01 3d 8a da f8 =
5e <c3> cc cc cc cc e8 98 aa 25 00 85 c0 74 f2 8b 15 da 71 ed 00 85 d2
> > > [ 2430.973294] RSP: 0018:ffffb15ec00dbe58 EFLAGS: 00000297
> > > [ 2430.973299] RAX: 0000000000000000 RBX: ffffb15ec12ad000 RCX: 00000=
00000000001
> > > [ 2430.973302] RDX: 0000000080000001 RSI: ffffffffa1c3313b RDI: 00000=
000ffffffff
> > > [ 2430.973306] RBP: dead000000000122 R08: 0000000000000010 R09: 00007=
46e65696369
> > > [ 2430.973309] R10: 8080808080808080 R11: 0000000000000018 R12: 00000=
00000000000
> > > [ 2430.973312] R13: 0000000000001e2b R14: ffffb15ec12ad048 R15: ffff9=
1c279c26a05
> > > [ 2430.973316] FS:  0000000000000000(0000) GS:ffff91c279c00000(0000) =
knlGS:0000000000000000
> > > [ 2430.973320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 2430.973324] CR2: 000055fc138890e0 CR3: 000000010810e002 CR4: 00000=
000001706f0
> > > [ 2430.973374] Call Trace:
> > > [ 2430.973388]  <TASK>
> > > [ 2430.973390]  __local_bh_enable_ip+0x32/0x70
> > > [ 2430.973413]  htable_selective_cleanup+0x95/0xc0 [xt_hashlimit]
> > > [ 2430.973428]  htable_gc+0xf/0x30 [xt_hashlimit]
> > > [ 2430.973440]  process_one_work+0x1d4/0x360
> > > [ 2430.973459]  ? process_one_work+0x360/0x360
> > > [ 2430.973467]  worker_thread+0x25/0x3b0
> > > [ 2430.973476]  ? process_one_work+0x360/0x360
> > > [ 2430.973483]  kthread+0xe1/0x110
> > > [ 2430.973499]  ? kthread_complete_and_exit+0x20/0x20
> > > [ 2430.973507]  ret_from_fork+0x1f/0x30
> > > [ 2430.973526]  </TASK>
> >=20
> > See Bugzilla for the full thread and perf output.
> >=20
> > Anyway, I'm tracking it in regzbot so that it doesn't fall through
> > cracks unnoticed:
> >=20
> > #regzbot introduced: v5.17.3..v5.19.17 https://bugzilla.kernel.org/show=
_bug.cgi?id=3D217586
> > #regzbot title: kworker/events_power_efficient utilizes full CPU power =
after kernel upgrade
> >=20
>=20
> The reporter had found the culprit (see Bugzilla for more information), t=
hus
> telling regzbot:
>=20
> #regzbot introduced: 6ad0ad2bf8a67e
> #regzbot title: retbleed reporting causes high cpu utilization due to kwo=
rker/events_power_efficient
> #regzbot link: https://lore.kernel.org/all/PH0PR05MB8448A203A909959FAC754=
B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com/
> #regzbot link: 6ad0ad2bf8a67e

Is there a problem other than that IBRS is slow and slower still on
shitty virt?

Does booting with: "spectre_v2=3Dretpoline retbleed=3Doff" make it go away?

I can't tell from this. Also, please don't use bugzilla.
