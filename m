Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D000E668991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjAMC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjAMC0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:26:15 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BC482B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1673576775; x=1705112775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYR8JqIg0s6wUvFwzEIDR1VaWz/29iDKbkdZrP40UZA=;
  b=ZxdXam82jpV4CPSgrHVsmc8F7GI2H+YvoWz3F6z4QgEObSwWTzvhYk8y
   PreFwL7eSzooJ0rukQHkcmm3tl9mvRIL67MIHX5BBk/O7pvoI2r7zCQ0d
   SwLP3XpiOT+GfaR4bGfdPC67gVTO4wxUgUaReOPblRT8j81s5kffBcBPf
   A=;
X-IronPort-AV: E=Sophos;i="5.97,212,1669075200"; 
   d="scan'208";a="287975044"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 02:26:14 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id A2427836FE;
        Fri, 13 Jan 2023 02:26:11 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 13 Jan 2023 02:26:11 +0000
Received: from u9aa42af9e4c55a.ant.amazon.com (10.43.160.120) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Fri, 13 Jan 2023 02:26:10 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <surenb@google.com>
CC:     <ebiggers@kernel.org>, <hannes@cmpxchg.org>, <hdanton@sina.com>,
        <kamatam@amazon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mengcc@amazon.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
Date:   Thu, 12 Jan 2023 18:25:55 -0800
Message-ID: <20230113022555.2467724-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D38UWC004.ant.amazon.com (10.43.162.204) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-12 22:01:24 +0000, Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Jan 9, 2023 at 7:06 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 5:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
> > > >
> > > > On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > > >
> > > > > That patch survived the repro in my original post, however, the waker
> > > > > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > > > > the pressure file got closed. So, if the following modified repro runs
> > > > > with the patch, the waker never returns (unless the sleeper gets killed)
> > > > > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > > > > see with the patch, does it? Even wake_up_all() does not appear to empty
> > > > > the queue, but wake_up_pollfree() does.
> > > >
> > > > Thanks for your testing. And the debugging completes.
> > > >
> > > > Mind sending a patch with wake_up_pollfree() folded?
> > >
> > > I finally had some time to look into this issue. I don't think
> > > delaying destruction in psi_trigger_destroy() because there are still
> > > users of the trigger as Hillf suggested is a good way to go. Before
> > > [1] correct trigger destruction was handled using a
> > > psi_trigger.refcount. For some reason I thought it's not needed
> > > anymore when we placed one-trigger-per-file restriction in that patch,
> > > so I removed it. Obviously that was a wrong move, so I think the
> > > cleanest way would be to bring back the refcounting. That way the last
> > > user of the trigger (either psi_trigger_poll() or psi_fop_release())
> > > will free the trigger.
> > > I'll check once more to make sure I did not miss anything and if there
> > > are no objections, will post a fix.
> >
> > Uh, I recalled now why refcounting was not helpful here. I'm making
> > the same mistake of thinking that poll_wait() blocks until the call to
> > wake_up() which is not the case. Let me think if there is anything
> > better than wake_up_pollfree() for this case.
> 
> Hi Munehisa,
> Sorry for the delay. I was trying to reproduce the issue but even
> after adding a delay before ep_remove_wait_queue() it did not happen.

Hi Suren,

Thank you for your help here.

Just in case, do you have KASAN enabled in your config? If not, this may
just silently corrupt a certain memory location and not immediately
followed by obvious messages or noticeable event like oops.

> One thing about wake_up_pollfree() solution that does not seem right
> to me is this comment at
> https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253:
> 
> `In the very rare cases where a ->poll() implementation uses a
> waitqueue whose lifetime is tied to a task rather than to the 'struct
> file' being polled, this function must be called before the waitqueue
> is freed...`
> 
> In our case we free the waitqueue from cgroup_pressure_release(),
> which is the handler for `release` operation on cgroup psi files. The
> other place calling psi_trigger_destroy() is psi_fop_release(), which
> is also tied to the lifetime to the psi files.  Therefore the lifetime
> of the trigger's waitqueue is tied to the lifetime of the files and
> IIUC, we should not be required to use wake_up_pollfree().
> Could you please post your .config file? I might be missing some
> configuration which prevents the issue from happening on my side.

Sure, here is my config.

 https://gist.github.com/kamatam9/a078bdd9f695e7a0767b061c60e48d50

I confirmed that it's reliably reproducible with v6.2-rc3 as shown below.

 https://gist.github.com/kamatam9/096a79cf59d8ed8785c4267e917b8675


Regards,
Munehisa


> Thanks,
> Suren.
> 
> >
> >
> > >
> > > [1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/
> > >
> > > Thanks,
> > > Suren.
> > >
> > > >
> > > > Hillf
> 
> 
