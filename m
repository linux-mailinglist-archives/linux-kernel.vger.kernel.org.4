Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EE6FCC46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjEIRFo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjEIRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E75590;
        Tue,  9 May 2023 10:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F8AE64775;
        Tue,  9 May 2023 17:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817A2C433D2;
        Tue,  9 May 2023 17:01:13 +0000 (UTC)
Date:   Tue, 9 May 2023 13:01:11 -0400
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230509130111.62d587f1@rorschach.local.home>
In-Reply-To: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
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

On Tue, 9 May 2023 08:24:29 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, May 8, 2023 at 9:38 AM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >
> > Programs that utilize user_events today only get the event payloads via
> > perf or ftrace when writing event data. When BPF programs are attached
> > to tracepoints created by user_events the BPF programs do not get run
> > even though the attach succeeds. This causes confusion by the users of
> > the programs, as they expect the data to be available via BPF programs
> > they write. We have several projects that have hit this and requested
> > BPF program support when publishing data via user_events from their
> > user processes in production.
> >
> > Swap out perf_trace_buf_submit() for perf_trace_run_bpf_submit() to
> > ensure BPF programs that are attached are run in addition to writing to
> > perf or ftrace buffers. This requires no changes to the BPF infrastructure
> > and only utilizes the GPL exported function that modules and other
> > components may use for the same purpose. This keeps user_events consistent
> > with how other kernel, modules, and probes expose tracepoint data to allow
> > attachment of a BPF program.  
> 
> Sorry, I have to keep my Nack here.
> 
> I see no practical use case for bpf progs to be connected to user events.

That's not a technical reason. Obviously they have a use case.

This is only connecting to BPF through the API. It makes no changes to
BPF itself, so I'm not sure your NACK has jurisdiction here. Their
alternative is to to do it with an external module as the only
connections to BPF it uses is via an EXPORT_SYMBOL_GPL() function!

Again, what is your technical reason for nacking this? It's like me
nacking a user of ftrace because I don't see a use case for it. That's
not a valid reason to issue a nack.

> 
> There must be a different way to solve your user needs
> and this is not bpf.

Why not use BPF?

-- Steve
