Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D26D34CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 00:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDAWRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 18:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 18:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3BAE042;
        Sat,  1 Apr 2023 15:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB15060A47;
        Sat,  1 Apr 2023 22:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6BCC433EF;
        Sat,  1 Apr 2023 22:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680387441;
        bh=aoDdZ34PoBNv5QUtFFFcg/3Z3R3lKI8oojzkBnrAy5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiFoaS/Rg1H+6UGrilF4GMPsbFrWRrcUHt3WvJmKBjGthkOwGXTzhcYTouJEFiIjk
         6wYfCPmxXZ73ddq0dEPbZW/lBAuzvCNKoG1XGi/Sm+nfW1nvO82w8tW0ZGjNhNY84g
         pDoucuW732ESD33YTpF+R8NTFcaBGnW0viIEK6wVXguxIPu0Yxeb3Nj2CaOmd3o+oo
         7297BBaO9ULjQ/dSyFkO3InXYDbif8rmH6+PZ/Ln8+Q+b9SRpYTYOA+HopesyN0qjH
         UBuEBu2DLEmWOrAiiVDNerzzEQmqIagENWX8v3NTzWHwhQw6jsicHjS1QqL12s3Sij
         G9ee0SukSMhRQ==
Date:   Sun, 2 Apr 2023 07:17:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     rostedt@goodmis.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/8] tracing: Add documentation for funcgraph-retval
 and funcgraph-retval-hex
Message-Id: <20230402071713.4f278b65ba9bb67c72ab2fb5@kernel.org>
In-Reply-To: <a3dcdd61b3ac07eefabc1b11fc18e9fae23d8cbe.1680265828.git.pengdonglin@sangfor.com.cn>
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
        <a3dcdd61b3ac07eefabc1b11fc18e9fae23d8cbe.1680265828.git.pengdonglin@sangfor.com.cn>
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

On Fri, 31 Mar 2023 05:47:38 -0700
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> Add documentation for the two newly introduced options for the
> function_graph tracer. The funcgraph-retval option is used to
> control whether or not to display the return value, while the
> funcgraph-retval-hex option is used to control the display
> format of the return value.
> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
> v9:
>  - Update limitation description
> 
> v7:
>  - Rename trace option 'graph_retval_hex' to 'funcgraph-retval-hex'
>  - Update documentation description
> 
> v6:
>  - Modify the limitations for funcgraph-retval
>  - Optimize the English expression
> 
> v5:
>  - Describe the limitations of funcgraph-retval
> ---
>  Documentation/trace/ftrace.rst | 74 ++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b927fb2b94dc..f572ae419219 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1328,6 +1328,19 @@ Options for function_graph tracer:
>  	only a closing curly bracket "}" is displayed for
>  	the return of a function.
>  
> +  funcgraph-retval
> +	When set, the return value of each traced function
> +	will be printed after an equal sign "=". By default
> +	this is off.
> +
> +  funcgraph-retval-hex
> +	When set, the return value will always be printed
> +	in hexadecimal format. If the option is not set and
> +	the return value is an error code, it will be printed
> +	in signed decimal format; otherwise it will also be
> +	printed in hexadecimal format. By default, this option
> +	is off.
> +
>    sleep-time
>  	When running function graph tracer, to include
>  	the time a task schedules out in its function.
> @@ -2673,6 +2686,67 @@ It is default disabled.
>      0)   1.757 us    |        } /* kmem_cache_free() */
>      0)   2.861 us    |      } /* putname() */
>  
> +The return value of each traced function can be displayed after
> +an equal sign "=". When encountering system call failures, it
> +can be verfy helpful to quickly locate the function that first
> +returns an error code.
> +
> +	- hide: echo nofuncgraph-retval > trace_options
> +	- show: echo funcgraph-retval > trace_options
> +
> +  Example with funcgraph-retval::
> +
> +    1)               |    cgroup_migrate() {
> +    1)   0.651 us    |      cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
> +    1)               |      cgroup_migrate_execute() {
> +    1)               |        cpu_cgroup_can_attach() {
> +    1)               |          cgroup_taskset_first() {
> +    1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
> +    1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
> +    1)   0.380 us    |          sched_rt_can_attach(); /* = 0x0 */
> +    1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
> +    1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
> +    1)   7.143 us    |    } /* cgroup_migrate = -22 */
> +
> +The above example shows that the function cpu_cgroup_can_attach
> +returned the error code -22 firstly, then we can read the code
> +of this function to get the root cause.
> +
> +When the option funcgraph-retval-hex is not set, the return value can
> +be displayed in a smart way. Specifically, if it is an error code,
> +it will be printed in signed decimal format, otherwise it will
> +printed in hexadecimal format.
> +
> +	- smart: echo nofuncgraph-retval-hex > trace_options
> +	- hexadecimal always: echo funcgraph-retval-hex > trace_options
> +
> +  Example with funcgraph-retval-hex::
> +
> +    1)               |      cgroup_migrate() {
> +    1)   0.651 us    |        cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
> +    1)               |        cgroup_migrate_execute() {
> +    1)               |          cpu_cgroup_can_attach() {
> +    1)               |            cgroup_taskset_first() {
> +    1)   0.732 us    |              cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
> +    1)   1.232 us    |            } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
> +    1)   0.380 us    |            sched_rt_can_attach(); /* = 0x0 */
> +    1)   2.335 us    |          } /* cpu_cgroup_can_attach = 0xffffffea */
> +    1)   4.369 us    |        } /* cgroup_migrate_execute = 0xffffffea */
> +    1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
> +
> +At present, there are some limitations when using the funcgraph-retval
> +option, and these limitations will be eliminated in the future:
> +
> +- Even if the function return type is void, a return value will still
> +  be printed, and you can just ignore it.
> +
> +- Even if return values are stored in multiple registers, only the
> +  value contained in the first register will be recorded and printed.
> +  To illustrate, in the x86 architecture, eax and edx are used to store
> +  a 64-bit return value, with the lower 32 bits saved in eax and the
> +  upper 32 bits saved in edx. However, only the value stored in eax
> +  will be recorded and printed.
> +
>  You can put some comments on specific functions by using
>  trace_printk() For example, if you want to put a comment inside
>  the __might_sleep() function, you just have to include
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
