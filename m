Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0BD70401F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbjEOV5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbjEOV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602DF172A;
        Mon, 15 May 2023 14:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F04FD63311;
        Mon, 15 May 2023 21:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ED6C433D2;
        Mon, 15 May 2023 21:57:13 +0000 (UTC)
Date:   Mon, 15 May 2023 17:57:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20230515175712.649aa5f6@gandalf.local.home>
In-Reply-To: <20230515192407.GA85@W11-BEAU-MD.localdomain>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
        <20230509130111.62d587f1@rorschach.local.home>
        <20230509163050.127d5123@rorschach.local.home>
        <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
        <20230515192407.GA85@W11-BEAU-MD.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 12:24:07 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > Beau,
> > please provide a detailed explanation of your use case and how bpf helps.
> >   
> 
> There are teams that have existing BPF programs that want to also pull
> in data from user processes in addition to the data they already collect
> from the kernel.
> 
> We are also seeing a trend of teams wanting to drop buffering approaches
> and move into non-buffered analysis of problems. An example is as soon
> as a fault happens in a user-process, they would like the ability to see
> what that thread has done, what the kernel did a bit before the error
> (or other processes that have swapped in, etc).
> 
> We also have needs to aggregate operation duration live, and as soon as
> they deviate, trigger corrective actions. BPF is ideal for us to use for
> aggregating data cheaply, comparing that to other kernel and user
> processes, and then making a decision quickly on how to mitigate or flag
> it. We are working with OpenTelemetry teams to make this work via
> certain exporters in various languages (C#/C++/Rust).

This is turning into a very productive discussion. Thank you Alexei and
Beau for this.

Beau,

Could you possibly also add (in a separate patch), a simple use case of a
BPF program that would be attached to some user event. Could be contrived.
Perhaps supply a patch to ls.c[1] that adds a user event to where it reads a
file type and the bpf program can do something special if the file belongs
to the user. OK, I'm just pulling crazy ideas out of thin air!

[1] https://github.com/coreutils/coreutils/blob/master/src/ls.c

Could copy the ls with the user event to the samples directory for user
events. It is GPL.

-- Steve
