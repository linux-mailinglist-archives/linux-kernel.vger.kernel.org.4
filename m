Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3981E6C961F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjCZPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE67284;
        Sun, 26 Mar 2023 08:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A150E60EF9;
        Sun, 26 Mar 2023 15:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B10C433EF;
        Sun, 26 Mar 2023 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844169;
        bh=jPU/1PkEjmLpuG/yzDwbE8MsDf1jHD5VOMCtE/4q5oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l+6tQbymSzTr6IS5BMRpGd5XX4HuYNdB8yFSqDlx1qkM8+ajHIhyB11NSAoyEi3X1
         zsMtVyf/RD87g3xLIEcjT8Rw8oK7sksjCyLOWb4bnSyaFgi/4yJhQSD/DUqgLfYedC
         z7l43Imtg49EboK8X4ff1pDkxeKlccKwPIlE0f1uiPBIBTY2inebpqTus/toO2LFbw
         zt3SCtxf6O4usZlE2+E+C10tZBZNr8BQbOVL79tf1hj0APyBIMRluLfWD+KK/efO9I
         /3KmVvu1IQ9gaPZ98NCq83j+HnBbxc0rk7/a30FRo2xO0UpstqtDjo/s5Cpmy/4Uiu
         ZnBhbIpEKrhFQ==
Date:   Sun, 26 Mar 2023 23:22:42 +0800
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 11/11] tracing/user_events: Limit global user_event
 count
Message-Id: <20230326232242.adb5ad253b3810aaf9686d2f@kernel.org>
In-Reply-To: <20230324130659.587ecfd2@gandalf.local.home>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
        <20230221211143.574-12-beaub@linux.microsoft.com>
        <20230324081824.b917c2944da217e5239e1223@kernel.org>
        <d6c83572-17e1-93d4-65a0-d480989e54fb@suse.cz>
        <20230324164353.GA1790@kbox>
        <20230324130659.587ecfd2@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 13:06:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Mar 2023 09:43:53 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > > It was actually merged in 5.8. So sysctl should be sufficient with that.
> > > But maybe it's weird to start adding sysctls, when the rest of tracing
> > > tunables is AFAIK under /sys/kernel/tracing/ ?
> > >   
> > 
> > During the TraceFS meetings Steven runs I was asked to add a boot
> > parameter and sysctl for user_events to limit the max.
> > 
> > To me, it seems when user_events moves toward namespace awareness
> > sysctl might be easier to use from within a namespace to turn knobs.
> > 
> > Happy to change to whatever, but I want to see Steven and Masami agree
> > on the approach before doing so.
> > 
> > Steven, do you agree with Masami to move to just sysctl?
> 
> We do have some tracing related sysctls already:
> 
> # cd /proc/sys/kernel
> # ls *trace*
> ftrace_dump_on_oops  oops_all_cpu_backtrace  traceoff_on_warning
> ftrace_enabled       stack_tracer_enabled    tracepoint_printk
> 
> Although I would love to deprecated ftrace_enable as that now has a
> control in tracefs, but it's not unprecedented to have tracing tunables as
> sysctl.
> 
> And if we get cmdline boot parameters for free from sysctls then all the
> better.

Yeah, I confirmed that sysctl can be set via kernel parameter. So it is OK
for me to add a sysctl.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
