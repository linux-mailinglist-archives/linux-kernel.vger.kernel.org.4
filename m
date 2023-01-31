Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC66829FB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjAaKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjAaKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:09:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530476A63;
        Tue, 31 Jan 2023 02:09:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFF1D1713;
        Tue, 31 Jan 2023 02:10:13 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C210A3F64C;
        Tue, 31 Jan 2023 02:09:30 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:09:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tom Rix <trix@redhat.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: ftrace: make some global variables static
Message-ID: <Y9jo1SJpsBRTb2M5@FVFF77S0Q05N>
References: <20230130193708.1378108-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130193708.1378108-1-trix@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:37:08AM -0800, Tom Rix wrote:
> smatch reports this representative issue
> samples/ftrace/ftrace-ops.c:15:14: warning: symbol 'nr_function_calls' was not declared. Should it be static?
> 
> The nr_functions_calls and several other global variables are only
> used in ftrace-ops.c, so they should be static.

This makes sense to me.

> Remove the instances of initializing static int to 0.

I appreciate that static variables get implicitly zero initialized, but
dropping the initialization is inconsistent with the other control variables,
and IMO it's quite confusing, so I'd prefer to keep that for clarity. I note
you've also dropped the initialization of a bool to false, whereas the above
just mentions int.

I'd prefer to keep the initialization, but I'll defre to Steve if he thinks
differently. :)

> Signed-off-by: Tom Rix <trix@redhat.com>

With the above taken into account:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  samples/ftrace/ftrace-ops.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
> index 24deb51c7261..5e891a995dd3 100644
> --- a/samples/ftrace/ftrace-ops.c
> +++ b/samples/ftrace/ftrace-ops.c
> @@ -12,7 +12,7 @@
>   * Arbitrary large value chosen to be sufficiently large to minimize noise but
>   * sufficiently small to complete quickly.
>   */
> -unsigned int nr_function_calls = 100000;
> +static unsigned int nr_function_calls = 100000;
>  module_param(nr_function_calls, uint, 0);
>  MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee");
>  
> @@ -21,7 +21,7 @@ MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee"
>   * be called directly or whether it's necessary to go via the list func, which
>   * can be significantly more expensive.
>   */
> -unsigned int nr_ops_relevant = 1;
> +static unsigned int nr_ops_relevant = 1;
>  module_param(nr_ops_relevant, uint, 0);
>  MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the relevant tracee");
>  
> @@ -30,7 +30,7 @@ MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the rel
>   * tracers enabled for distinct functions can force the use of the list func
>   * and incur overhead for all call sites.
>   */
> -unsigned int nr_ops_irrelevant = 0;
> +static unsigned int nr_ops_irrelevant;
>  module_param(nr_ops_irrelevant, uint, 0);
>  MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the irrelevant tracee");
>  
> @@ -38,15 +38,15 @@ MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the i
>   * On architectures with DYNAMIC_FTRACE_WITH_REGS, saving the full pt_regs can
>   * be more expensive than only saving the minimal necessary regs.
>   */
> -bool save_regs = false;
> +static bool save_regs;
>  module_param(save_regs, bool, 0);
>  MODULE_PARM_DESC(save_regs, "Register ops with FTRACE_OPS_FL_SAVE_REGS (save all registers in the trampoline)");
>  
> -bool assist_recursion = false;
> +static bool assist_recursion;
>  module_param(assist_recursion, bool, 0);
>  MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RECURSION");
>  
> -bool assist_rcu = false;
> +static bool assist_rcu;
>  module_param(assist_rcu, bool, 0);
>  MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
>  
> @@ -55,7 +55,7 @@ MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
>   * overhead. Sometimes a consistency check using a more expensive tracer is
>   * desireable.
>   */
> -bool check_count = false;
> +static bool check_count;
>  module_param(check_count, bool, 0);
>  MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number of times\n");
>  
> @@ -64,7 +64,7 @@ MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number
>   * runs, but sometimes it can be useful to leave them registered so that they
>   * can be inspected through the tracefs 'enabled_functions' file.
>   */
> -bool persist = false;
> +static bool persist;
>  module_param(persist, bool, 0);
>  MODULE_PARM_DESC(persist, "Successfully load module and leave ftrace ops registered after test completes\n");
>  
> @@ -114,8 +114,8 @@ static void ops_func_count(unsigned long ip, unsigned long parent_ip,
>  	self->count++;
>  }
>  
> -struct sample_ops *ops_relevant;
> -struct sample_ops *ops_irrelevant;
> +static struct sample_ops *ops_relevant;
> +static struct sample_ops *ops_irrelevant;
>  
>  static struct sample_ops *ops_alloc_init(void *tracee, ftrace_func_t func,
>  					 unsigned long flags, int nr)
> @@ -163,8 +163,8 @@ static void ops_check(struct sample_ops *ops, int nr,
>  	}
>  }
>  
> -ftrace_func_t tracer_relevant = ops_func_nop;
> -ftrace_func_t tracer_irrelevant = ops_func_nop;
> +static ftrace_func_t tracer_relevant = ops_func_nop;
> +static ftrace_func_t tracer_irrelevant = ops_func_nop;
>  
>  static int __init ftrace_ops_sample_init(void)
>  {
> -- 
> 2.26.3
> 
