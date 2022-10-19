Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85768604C35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJSPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiJSPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D01D1020
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ACDD6193E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC62C433C1;
        Wed, 19 Oct 2022 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194371;
        bh=yMOMW70yGKkXCstq3zynfMtaqXPsMTiXHiAWQ/VUCwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kARVTrajsKLMS4v/qFY3cwqsTixA3sUTYrb+Lw+mzIZdR1AQt6uX3lor3QN2PUoWM
         r5z74A/heeSJBIv7BNJJXY5VCmQJTTaLjw64knRMpmzTNopPeUOw1IXE910u23s3uC
         fCCHnyrgoCStGhdkcEVIvePtkUKfniQWeRw22WEE8fBqI0T/Q/akNMwx2GDU2TCYvF
         gNiE1jamR3qe0E/rmYetRZTnPahDE8+DNfuEU0Bu0i+d4Xwki9mxWBYA4viASQwLH9
         J0K13fS/nIXNndYqePZlGQtg8Snpy+O4sFNQNadC4tssMLghaTUwMc5NAndUy9UK+8
         nyvjPcQGQVJbQ==
Date:   Thu, 20 Oct 2022 00:46:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
Message-Id: <20221020004607.a78c771e12ad0f65c018220b@kernel.org>
In-Reply-To: <1666172148.1jppmgndx2.naveen@linux.ibm.com>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
        <20221017105103.540a87c7@gandalf.local.home>
        <20221019001949.950fb044677f96c6cdd00fdf@kernel.org>
        <20221018112224.372a3484@gandalf.local.home>
        <1666172148.1jppmgndx2.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 15:15:09 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Steven Rostedt wrote:
> > On Wed, 19 Oct 2022 00:19:49 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> >> > You need to make sure that the "pause-on-trace" option is set or tracing_on
> >> > is set to 0 (disabled). Otherwise, if the tracing is still active, then the
> >> > reading of the trace file could potentially never end.  
> >> 
> >> initialize_ftrace() does this setting. So it must be set.
> >> If you run the ftracetest on old kernel, this feature is not there and
> >> it may cause a trouble. Naveen, can you clarify it?
> 
> Yes, the change to not pause on opening the trace file looks to be the 
> problem.
> 
> > 
> > But for old kernels that do not have "pause-on-trace" it should be the
> > default. The "pause-on-trace" was added when the default was changed to not
> > pause the trace while reading it.
> 
> It looks like the kernel patch was picked up, but Masami's patch for the 
> selftest wasn't backported. I have requested a test with that applied.

Good! That should be backported too.
BTW, which kernel version do you test?

> 
> Separately, before I saw your response, I came up with the below patch 
> to update the selftests to disable tracing before reading the trace 
> file. I have also requested this to be tested.

Yeah, OK. This also looks OK to me.

Thanks,

> 
> 
> - Naveen
> 
> ---
>  .../selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc     | 4 +++-
>  tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc | 2 ++
>  .../selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc | 3 ++-
>  .../testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc | 3 ++-
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
> index cf3ea42b12b09f..7e74df1ef928f9 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
> @@ -39,6 +39,7 @@ disable_tracing
>  clear_trace
>  enable_tracing
>  sleep 1
> +disable_tracing
>  
>  count=`cat trace | grep '()' | grep -v schedule | wc -l`
>  
> @@ -54,8 +55,9 @@ fi
>  
>  echo 0 > /proc/sys/kernel/stack_tracer_enabled
>  clear_trace
> +enable_tracing
>  sleep 1
> -
> +disable_tracing
>  
>  count=`cat trace | grep '()' | grep -v schedule | wc -l`
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
> index b3ccdaec2a61ba..7e65a115054127 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
> @@ -24,6 +24,8 @@ fi
>  echo function_graph > current_tracer
>  enable_tracing
>  sleep 1
> +disable_tracing
> +
>  # search for functions (has "()" on the line), and make sure
>  # that only the schedule function was found
>  count=`cat trace | grep '()' | grep -v schedule | wc -l`
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> index 80541964b9270b..9fb0511b5d2eeb 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> @@ -51,6 +51,7 @@ do_test() {
>  
>      enable_tracing
>      yield
> +    disable_tracing
>  
>      count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
>      count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
> @@ -60,7 +61,6 @@ do_test() {
>  	fail "PID filtering not working? traced task = $count_pid; other tasks = $count_other "
>      fi
>  
> -    disable_tracing
>      clear_trace
>  
>      if [ $do_function_fork -eq 0 ]; then
> @@ -77,6 +77,7 @@ do_test() {
>  
>      enable_tracing
>      yield
> +    disable_tracing
>  
>      count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
>      count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> index 2f7211254529ba..c55bcf2fe1966f 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> @@ -51,6 +51,7 @@ do_test() {
>  
>      enable_tracing
>      yield
> +    disable_tracing
>  
>      count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
>      count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
> @@ -60,7 +61,6 @@ do_test() {
>  	fail "PID filtering not working?"
>      fi
>  
> -    disable_tracing
>      clear_trace
>  
>      if [ $do_function_fork -eq 0 ]; then
> @@ -72,6 +72,7 @@ do_test() {
>  
>      enable_tracing
>      yield
> +    disable_tracing
>  
>      count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
>      count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
