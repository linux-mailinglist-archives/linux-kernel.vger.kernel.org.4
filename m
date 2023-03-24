Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57686C82DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCXRHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCXRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C7A18B2C;
        Fri, 24 Mar 2023 10:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E8E7B822D8;
        Fri, 24 Mar 2023 17:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11E8C433EF;
        Fri, 24 Mar 2023 17:07:01 +0000 (UTC)
Date:   Fri, 24 Mar 2023 13:06:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 11/11] tracing/user_events: Limit global user_event
 count
Message-ID: <20230324130659.587ecfd2@gandalf.local.home>
In-Reply-To: <20230324164353.GA1790@kbox>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
        <20230221211143.574-12-beaub@linux.microsoft.com>
        <20230324081824.b917c2944da217e5239e1223@kernel.org>
        <d6c83572-17e1-93d4-65a0-d480989e54fb@suse.cz>
        <20230324164353.GA1790@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 09:43:53 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > It was actually merged in 5.8. So sysctl should be sufficient with that.
> > But maybe it's weird to start adding sysctls, when the rest of tracing
> > tunables is AFAIK under /sys/kernel/tracing/ ?
> >   
> 
> During the TraceFS meetings Steven runs I was asked to add a boot
> parameter and sysctl for user_events to limit the max.
> 
> To me, it seems when user_events moves toward namespace awareness
> sysctl might be easier to use from within a namespace to turn knobs.
> 
> Happy to change to whatever, but I want to see Steven and Masami agree
> on the approach before doing so.
> 
> Steven, do you agree with Masami to move to just sysctl?

We do have some tracing related sysctls already:

# cd /proc/sys/kernel
# ls *trace*
ftrace_dump_on_oops  oops_all_cpu_backtrace  traceoff_on_warning
ftrace_enabled       stack_tracer_enabled    tracepoint_printk

Although I would love to deprecated ftrace_enable as that now has a
control in tracefs, but it's not unprecedented to have tracing tunables as
sysctl.

And if we get cmdline boot parameters for free from sysctls then all the
better.

-- Steve
