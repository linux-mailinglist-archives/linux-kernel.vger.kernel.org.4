Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B47B705C65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjEQB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQB1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F751BD3;
        Tue, 16 May 2023 18:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A724063B3E;
        Wed, 17 May 2023 01:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01CDC433EF;
        Wed, 17 May 2023 01:26:59 +0000 (UTC)
Date:   Tue, 16 May 2023 21:26:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230516212658.2f5cc2c6@gandalf.local.home>
In-Reply-To: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
        <20230509130111.62d587f1@rorschach.local.home>
        <20230509163050.127d5123@rorschach.local.home>
        <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
        <20230515192407.GA85@W11-BEAU-MD.localdomain>
        <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 17:36:28 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:


> "
> The user that will generate events must have x access to the tracing directory, e.g. chmod a+x /sys/kernel/tracing
> The user that will generate events must have rw access to the tracing/user_events_data file, e.g. chmod a+rw /sys/kernel/tracing/user_events_data
> "
> So any unpriv user can create and operate user events.
> Including seeing and enabling other user's user_events with 'ls/echo/cat' in tracefs.

It can see user_events_data, but x only gives you access into the directory.
It does not get you the contents of the files within the directory. The
above only gives access to the user_events_data. Which is to create events.

I recommended using groups and not giving access to all tasks.

> 
> Looks like user events were designed with intention to be unprivileged.
> When I looked at kernel/trace/trace_events_user.c I assumed root.
> I doubt other people reviewed it from security perspective.
> 
> Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.
> 
> For example, I think the following is possible:
> fd = open("/sys/kernel/tracing/user_events_data")
> ioclt(fd, DIAG_IOCSDEL)
>   user_events_ioctl_del
>      delete_user_event(info->group, name);
> 
> 'info' is different for every FD, but info->group is the same for all users/processes/fds,
> because only one global init_group is created.
> So one user can unregister other user event by knowing 'name'.
> A security hole, no?
> 
> > and libside [2] will also help here.  
> 
> > [2] https://github.com/compudj/libside  
> 
> That's an interesting project. It doesn't do any user_events access afaict,

I'll let Beau answer the rest.

-- Steve


