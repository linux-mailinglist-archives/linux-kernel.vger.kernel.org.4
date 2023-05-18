Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C267082DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjERNgH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 May 2023 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjERNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57306E0;
        Thu, 18 May 2023 06:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC35364F7E;
        Thu, 18 May 2023 13:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39973C433EF;
        Thu, 18 May 2023 13:36:02 +0000 (UTC)
Date:   Thu, 18 May 2023 09:36:00 -0400
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
        Dave Thaler <dthaler@microsoft.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230518093600.3f119d68@rorschach.local.home>
In-Reply-To: <CAADnVQLtTOjHG=k5uwP_zrM_af4RdS8d5zgmLnVFSmq_=5m0Cg@mail.gmail.com>
References: <20230509130111.62d587f1@rorschach.local.home>
        <20230509163050.127d5123@rorschach.local.home>
        <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
        <20230515192407.GA85@W11-BEAU-MD.localdomain>
        <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
        <20230516212658.2f5cc2c6@gandalf.local.home>
        <20230517165028.GA71@W11-BEAU-MD.localdomain>
        <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
        <20230518001916.GB254@W11-BEAU-MD.localdomain>
        <CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
        <20230518011814.GA294@W11-BEAU-MD.localdomain>
        <20230517220800.3d4cbad2@gandalf.local.home>
        <CAADnVQLtTOjHG=k5uwP_zrM_af4RdS8d5zgmLnVFSmq_=5m0Cg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 20:14:31 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, May 17, 2023 at 7:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> > The delete IOCTL is different than reg/unreg. I don't see a problem with
> > adding a CAP_SYSADMIN check on the delete IOCTL (and other delete paths)
> > to prevent this. It shouldn't affect anything we are doing to add this
> > and it makes it so non-admins cannot delete any events if they are given
> > write access to the user_events_data file.  
> 
> sysadmin for delete is a pointless.
> user_events_ioctl_reg() has the same issue.
> Two different processes using you fancy TRACELOGGING_DEFINE_PROVIDER()
> macro and picking the same name will race.
> 
> TRACELOGGING_DEFINE_PROVIDER( // defines the MyProvider symbol
>     MyProvider, // Name of the provider symbol to define
>     "MyCompany_MyComponent_MyProvider", // Human-readable provider
> name, no ' ' or ':' chars.
>     // {d5b90669-1aad-5db8-16c9-6286a7fcfe33} // Provider guid
> (ignored on Linux)
>     (0xd5b90669,0x1aad,0x5db8,0x16,0xc9,0x62,0x86,0xa7,0xfc,0xfe,0x33));
> 
> I totally get it that Beau is copy pasting these ideas from windows,
> but windows is likely similarly broken if it's registering names
> globally.
> 
> FD should be the isolation boundary.
> fd = open("/sys/kernel/tracing/user_event")
> and make sure all events are bound to that file.
> when file is closed the events _should be auto deleted_.
> 
> That's another issue I just spotted.
> Looks like user_events_release() is leaking memory.
> user_event_refs are just lost.
> 
> tbh the more I look into the code the more I want to suggest to mark it
> depends on BROKEN
> and go back to redesign.

I don't think these changes require a redesign. I do like the idea that
the events live with the fd. That is, when the fd dies, so does the event.

Although, we may keep it around for a bit (no new events, but being
able to parse it. That is, the event itself isn't deleted until the fd
is closed, and so is the tracing files being read are closed.

Beau,

How hard is it to give the event an owner, but not for task or user,
but with the fd. That way you don't need to worry about other tasks
deleting the event. And it also automatically cleans itself up. If we
leave it to the sysadmin to clean up, it's going to cause leaks,
because it's not something the sysadmin will want to do, as they will
need to keep track of what events are created.

-- Steve

PS. I missed my connection due to unseasonal freezing temperatures, and
my little airport didn't have a driver for the deicer, making my flight
2 hours delayed (had to wait for the sun to come up and deice the
plane!). Thus, instead of enjoying myself by the pool, I'm in an
airport lounge without much to do.

