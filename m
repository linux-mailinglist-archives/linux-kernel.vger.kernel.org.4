Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF462905A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKODDb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 22:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbiKODCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:02:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234DF50
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BCF061520
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09166C433C1;
        Tue, 15 Nov 2022 03:01:34 +0000 (UTC)
Date:   Mon, 14 Nov 2022 22:02:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-ID: <20221114220216.05dd0541@gandalf.local.home>
In-Reply-To: <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
References: <20221102160236.11696-1-iecedge@gmail.com>
        <20221114122255.72588f45@gandalf.local.home>
        <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 10:38:34 +0800
Jianlin Lv <iecedge@gmail.com> wrote:

> On Tue, Nov 15, 2022 at 1:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed,  2 Nov 2022 16:02:36 +0000
> > Jianlin Lv <iecedge@gmail.com> wrote:
> >  
> > > In the case of keeping the system running, the preferred method for
> > > tracing the kernel is dynamic tracing (kprobe), but the drawback of
> > > this method is that events are lost, especially when tracing packages
> > > in the network stack.  
> >
> > I'm not against this change, but the above is where I'm a bit confused. How
> > are events more likely to be lost with kprobes over a static event?  
> 
> We have encountered a case of kprobes missing event, detailed
> information can refer to the following link:
> https://github.com/iovisor/bcc/issues/4198
> 
> Replacing kprobe with ’bpf + raw tracepoint‘,  no missing events occur.
> 

Masami,

What's the reason that kprobes are not re-entrant when using ftrace?

-- Steve
