Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96226674998
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjATCxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjATCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:53:08 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D29B132
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674183188; x=1705719188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmpmDQi7bJR8lLmmf/naNO35e+8Lm9tQqbSe2Rv16PQ=;
  b=RDVj8rITLGmUIM2uu63zJEFzJ2vqt659ENiyy4mzx5AiWWe5gYI+RpjJ
   5X52iKdIDPWtJ6niTm5M5Aa+ElFtWgy4xPEySGVAvXEpPllq1eZzWbkXJ
   hH2F8vcOOS/cKPN7kCdkVt1BrQlcAMD9rX8eKNVOMGDB4gYpdL0Ik20zl
   k=;
X-IronPort-AV: E=Sophos;i="5.97,230,1669075200"; 
   d="scan'208";a="173026157"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 02:53:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id 53DE281DF1;
        Fri, 20 Jan 2023 02:53:04 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 20 Jan 2023 02:53:03 +0000
Received: from u9aa42af9e4c55a.ant.amazon.com (10.43.162.56) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Fri, 20 Jan 2023 02:53:03 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <surenb@google.com>
CC:     <ebiggers@kernel.org>, <hannes@cmpxchg.org>, <hdanton@sina.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mengcc@amazon.com>, <kamatam@amazon.com>, <tj@kernel.org>
Subject: Re: another use-after-free in ep_remove_wait_queue()
Date:   Thu, 19 Jan 2023 18:52:53 -0800
Message-ID: <20230120025253.843079-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120024613.840905-1-kamatam@amazon.com>
References: <20230120024613.840905-1-kamatam@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D38UWB001.ant.amazon.com (10.43.161.10) To
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

On Fri, 2023-01-20 02:46:13 +0000, Munehisa Kamata <kamatam@amazon.com> wrote:
>
> On Fri, 2023-01-20 01:37:11 +0000, Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 5:31 PM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On Thu, 19 Jan 2023 13:01:42 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > Hi Folks,
> > > > I spent some more time digging into the details and this is what's
> > > > happening. When we call rmdir to delete the cgroup with the pressure
> > > > file being epoll'ed, roughly the following call chain happens in the
> > > > context of the shell process:
> > > >
> > > > do_rmdir
> > > >   cgroup_rmdir
> > > >     kernfs_drain_open_files
> > > >       cgroup_file_release
> > > >         cgroup_pressure_release
> > > >           psi_trigger_destroy
> > > >
> > > > Later on in the context of our reproducer, the last fput() is called
> > > > causing wait queue removal:
> > > >
> > > > fput
> > > >   ep_eventpoll_release
> > > >     ep_free
> > > >       ep_remove_wait_queue
> > > >         remove_wait_queue
> > > >
> > > > By this time psi_trigger_destroy() already destroyed the trigger's
> > > > waitqueue head and we hit UAF.
> > > > I think the conceptual problem here (or maybe that's by design?) is
> > > > that cgroup_file_release() is not really tied to the file's real
> > > > lifetime (when the last fput() is issued). Otherwise fput() would call
> > > > eventpoll_release() before f_op->release() and the order would be fine
> > > > (we would remove the wait queue first in eventpoll_release() and then
> > > > f_op->release() would cause trigger's destruction).
> > >
> > >   eventpoll_release
> > >     eventpoll_release_file
> > >       ep_remove
> > >         ep_unregister_pollwait
> > >           ep_remove_wait_queue
> > >
> > 
> > Yes but fput() calls eventpoll_release() *before* f_op->release(), so
> > waitqueue_head would be removed before trigger destruction.
>  
> But pwq->whead is still pointing the freed head, then we just hit the same
> issue earlier?
 
Ah nevermind, that was just a hypothetical case if cgroup_file_release()
was tied to file's lifetime and assuming trigger destruction that frees    
the queue and clears pwq->whead would happen later in f_op->release();     
there is no such an implementation today.                                  
                                                                           
Sorry for noise.

> > > Different roads run into the same Roma city.
> > 
> > You butchered the phrase :)
> > 
> > >
> > > > Considering these findings, I think we can use the wake_up_pollfree()
> > > > without contradicting the comment at
> > > > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253
> > > > because indeed, cgroup_file_release() and therefore
> > > > psi_trigger_destroy() are not tied to the file's lifetime.
> > > >
> > > > I'm CC'ing Tejun to check if this makes sense to him and
> > > > cgroup_file_release() is working as expected in this case.
> > > >
> > > > Munehisha, if Tejun confirms this is all valid, could you please post
> > > > a patch replacing wake_up_interruptible() with wake_up_pollfree()? We
> > > > don't need to worry about wake_up_all() because we have a limitation
> > > > of one trigger per file descriptor:
> > > > https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1419,
> > > > so there can be only one waiter.
> > > > Thanks,
> > > > Suren.
> > >
> > 
> > 
> 
> 
