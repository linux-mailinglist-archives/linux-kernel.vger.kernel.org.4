Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6E67826E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjAWRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjAWRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:00:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83E37C0;
        Mon, 23 Jan 2023 08:59:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55A3C14;
        Mon, 23 Jan 2023 09:00:40 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9C93F71E;
        Mon, 23 Jan 2023 08:59:58 -0800 (PST)
Date:   Mon, 23 Jan 2023 16:59:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ftrace/scripts: Update the instructions for
 ftrace-bisect.sh
Message-ID: <Y869C8HcHownYfII@FVFF77S0Q05N>
References: <20230123112252.022003dd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123112252.022003dd@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:22:52AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The instructions for the ftrace-bisect.sh script, which is used to find
> what function is being traced that is causing a kernel crash, and possibly
> a triple fault reboot, uses the old method. In 5.1, a new feature was
> added that let the user write in the index into available_filter_functions
> that maps to the function a user wants to set in set_ftrace_filter (or
> set_ftrace_notrace). This takes O(1) to set, as suppose to writing a
> function name, which takes O(n) (where n is the number of functions in
> available_filter_functions).
> 
> The ftrace-bisect.sh requires setting half of the functions in
> available_filter_functions, which is O(n^2) using the name method to enable
> and can take several minutes to complete. The number method is O(n) which
> takes less than a second to complete. Using the number method for any
> kernel 5.1 and after is the proper way to do the bisect.
> 
> Update the usage to reflect the new change, as well as using the
> /sys/kernel/tracing path instead of the obsolete debugfs path.
> 
> Cc: stable@vger.kernel.org
> Fixes: f79b3f338564e ("ftrace: Allow enabling of filters via index of available_filter_functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  scripts/tracing/ftrace-bisect.sh | 33 ++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/tracing/ftrace-bisect.sh b/scripts/tracing/ftrace-bisect.sh
> index 926701162bc8..94ca73930f8a 100755
> --- a/scripts/tracing/ftrace-bisect.sh
> +++ b/scripts/tracing/ftrace-bisect.sh
> @@ -12,7 +12,7 @@
>  #   (note, if this is a problem with function_graph tracing, then simply
>  #    replace "function" with "function_graph" in the following steps).
>  #
> -#  # cd /sys/kernel/debug/tracing
> +#  # cd /sys/kernel/tracing
>  #  # echo schedule > set_ftrace_filter
>  #  # echo function > current_tracer
>  #
> @@ -20,22 +20,39 @@
>  #
>  #  # echo nop > current_tracer
>  #
> -#  # cat available_filter_functions > ~/full-file
> +# Starting with v5.1 this can be done with numbers, making it much faster:
> +#
> +# The old (slow) way, for kernels before v5.1.
> +#
> +# [old-way] # cat available_filter_functions > ~/full-file
> +#
> +# [old-way] *** Note *** this will take several minutes. Setting multiple
> +# [old-way] functions is an O(n^2) operation, and we are dealing with thousands
> +# [old-way] of functions. So go have  coffee, talk with your coworkers, read
> +# [old-way] facebook. And eventually, this operation will end.

Super-trivial nit, but the above step isn't actually that expensive, and it's
the subsequent write to set_ftrace_filter that's going to be slow.

That double spacing in 'go have  coffee' looks odd; is that an old error from
reformatting a line break, and/or a missing 'a' ?

How about:

# [old-way] *** Note *** writing function names to set_ftrace_filter will take
# [old-way] several minutes. Setting multiple functions is an O(n^2) operation,
# [old-way] and we will set thousands of functions. So for subsequent steps,
# [old-way] go have a coffee, talk with your coworkers, read facebook. And
# [old-way] eventually, this operation will end.

... or leave this in place below, and add "If using [old-way] ..." to the start?

Regardless, this looks sensible to me!

Mark.

> +#
> +# The new way (using numbers) is an O(n) operation, and usually takes less than a second.
> +#
> +# seq `wc -l available_filter_functions | cut -d' ' -f1` > ~/full-file
> +#
> +# This will create a sequence of numbers that match the functions in
> +# available_filter_functions, and when echoing in a number into the
> +# set_ftrace_filter file, it will enable the corresponding function in
> +# O(1) time. Making enabling all functions O(n) where n is the number of
> +# functions to enable.
> +#
> +# For either the new or old way, the rest of the operations remain the same.
> +#
>  #  # ftrace-bisect ~/full-file ~/test-file ~/non-test-file
>  #  # cat ~/test-file > set_ftrace_filter
>  #
> -# *** Note *** this will take several minutes. Setting multiple functions is
> -# an O(n^2) operation, and we are dealing with thousands of functions. So go
> -# have  coffee, talk with your coworkers, read facebook. And eventually, this
> -# operation will end.
> -#
>  #  # echo function > current_tracer
>  #
>  # If it crashes, we know that ~/test-file has a bad function.
>  #
>  #   Reboot back to test kernel.
>  #
> -#     # cd /sys/kernel/debug/tracing
> +#     # cd /sys/kernel/tracing
>  #     # mv ~/test-file ~/full-file
>  #
>  # If it didn't crash.
> -- 
> 2.39.0
> 
