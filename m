Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785274A927
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGGCvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGGCvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2B19A6;
        Thu,  6 Jul 2023 19:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3EC261324;
        Fri,  7 Jul 2023 02:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B3EC433C8;
        Fri,  7 Jul 2023 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688698292;
        bh=k6N3pkvwbvRc75LVAt9el+dSNdcBZtNYn7RQrMXWaSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k+km+8OxYpXKr57mVi2i0cGUwuVmxWMlXW6bP+AZkDRKz1f6/kenRma25mQ22PMWL
         5Fq5n4ahiWvOv4sQYb8pjxCDSMtJeFM2tRfximiFUGcnrk6N/HdGz8C/5SdtJaZ3kS
         XyyGVMMDaQsGEFguM7qBnc/64yY6sSiIi87vyJMeyP/fgJKJmMFVEz9o3IZnonQFC/
         oCMIxxkeE0cVK1sGJJAr9Sq6pwqDyQZbDQklLJDEDah6L1QciL6kG0Zp8p+bLFE2NQ
         4aTxQZO9HtjluFKzUW2WJjew2jv0qlKgw1vk+HBM0o41p0jzOgGlOtgyw0s6gZUHyF
         on/cNgGSSIRuQ==
Date:   Fri, 7 Jul 2023 11:51:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tracing/probes: Fix return value when "(fault)" is
 injected
Message-Id: <20230707115128.80b6acf06f4bfa996d9d0808@kernel.org>
In-Reply-To: <20230706222020.6e5c8e89@rorschach.local.home>
References: <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
        <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
        <20230705224956.1c5213e6@gandalf.local.home>
        <20230706134036.5c074aa5fc6a55cdb5038660@kernel.org>
        <20230706095039.1cb9c9d1@gandalf.local.home>
        <20230707110210.06e81e182c775454ce86280d@kernel.org>
        <20230706222020.6e5c8e89@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 22:20:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Jul 2023 11:02:10 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > /* Print type function for string type */
> > int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
> > {
> >         int len = *(u32 *)data >> 16;
> > 
> >         if (!len)
> >                 trace_seq_puts(s, "(fault)");
> >         else
> > ----
> > 
> > In this case, what we need is to set data_loc length = 0 if ret < 0.
> > 
> > Do you really need to get '"(fault)"' (with double quotation) or
> > just '(fault)' (no double quotation) is OK?
> 
>  ># echo 'e:myopen syscalls/sys_enter_openat file=+0($filename):ustring' >> /sys/kernel/tracing/dynamic_events
>  ># trace-cmd start -e myopen
>  ># trace-cmd show
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 19/19   #P:4
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>        trace-cmd-4688    [000] ...1. 466968.015784: myopen: (syscalls.sys_enter_openat) file=(fault)
>        trace-cmd-4688    [000] ...1. 466968.015816: myopen: (syscalls.sys_enter_openat) file=(fault)
>        trace-cmd-4688    [000] ...1. 466968.015833: myopen: (syscalls.sys_enter_openat) file=(fault)
>        trace-cmd-4688    [000] ...1. 466968.015849: myopen: (syscalls.sys_enter_openat) file=(fault)
>        trace-cmd-4688    [000] ...1. 466968.015864: myopen: (syscalls.sys_enter_openat) file=(fault)
>        trace-cmd-4688    [000] ...1. 466968.015879: myopen: (syscalls.sys_enter_openat) file=(fault)
> 
> 
> Does that answer your question? ;-)

Ah, I meant that your commit 2e9906f84fc7 ("tracing: Add "(fault)" name injection
 to kernel probes") tries to make it '"(fault)"', So it makes 

       trace-cmd-4688    [000] ...1. 466968.015879: myopen: (syscalls.sys_enter_openat) file="(fault)"

Keeping it current '(fault)' makes easy to identify which one is failed to fetch,
but it may require user to parse both "some string" and (fault). I thought that
was the reason why you added that commit.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
