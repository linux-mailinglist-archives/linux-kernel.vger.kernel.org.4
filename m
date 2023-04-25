Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4BA6EDAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjDYDzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13634EC0;
        Mon, 24 Apr 2023 20:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B8FC62269;
        Tue, 25 Apr 2023 03:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB284C433EF;
        Tue, 25 Apr 2023 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682394909;
        bh=uVme7c/++qsefUV47B4cdTguxdMoQe4SjR4FK0ZWBuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bhJgaQg0jONknwAgfyUZsJd86mofpx1fv6cGEYRensyGZ+mdutXYDxFJcXvnEprz/
         5YyfplT28AC/idDSHd2E0GuZ1TDCm64l/nt/0luZ9Dwz3T7tbjj7udX/wOc3dPS6dy
         GbgaTyMSN1YVKyHp9tOYKdro0VPpwjPnsepNwSwabfrDHbYL/2w8kc2HC6r22NMSJl
         h6XfSvQdYVcka76l7JiVyOgkKzR1kEvBTzmmY6ualZL3nDu/wdIeFU0yq/i9i0+9ts
         lX57+vBOZXjP3iewDcAmNOs48zGMobA1Em4xGAzl9iIA58CodQbXhxJ/s0Av06E/iw
         Ok8Q/bY7tRZkQ==
Date:   Tue, 25 Apr 2023 12:55:02 +0900
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
Subject: Re: [PATCH v11 8/8] selftests/ftrace: Add funcgraph-retval test
 case
Message-Id: <20230425125502.074e098a6ecf8fc3a9f19dd0@kernel.org>
In-Reply-To: <9fedbd25e63f012cade5dad13be21225fec2fb5d.1680954589.git.pengdonglin@sangfor.com.cn>
References: <cover.1680954589.git.pengdonglin@sangfor.com.cn>
        <9fedbd25e63f012cade5dad13be21225fec2fb5d.1680954589.git.pengdonglin@sangfor.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Apr 2023 05:42:22 -0700
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> Add a test case for the funcgraph-retval and funcgraph-retval-hex
> trace options.
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> v11:
>  - Fix selftest issues
> 
> v10:
>  - Fix issues in selftest
> 
> v8:
>  - Fix issues in selftest
> ---
>  .../ftrace/test.d/ftrace/fgraph-retval.tc     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
> new file mode 100644
> index 000000000000..e34c0bdef3ed
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - function graph print function return value
> +# requires: options/funcgraph-retval options/funcgraph-retval-hex function_graph:tracer
> +
> +# Make sure that funcgraph-retval works
> +
> +fail() { # msg
> +    echo $1
> +    exit_fail
> +}
> +
> +disable_tracing
> +clear_trace
> +
> +# get self PID, can not use $$, because it is PPID
> +read PID _ < /proc/self/stat
> +
> +[ -f set_ftrace_filter ] && echo proc_reg_write > set_ftrace_filter
> +[ -f set_ftrace_pid ] && echo ${PID} > set_ftrace_pid
> +echo function_graph > current_tracer
> +echo 1 > options/funcgraph-retval
> +
> +set +e
> +enable_tracing
> +echo > /proc/interrupts
> +disable_tracing
> +set -e
> +
> +: "Test printing the error code in signed decimal format"
> +echo 0 > options/funcgraph-retval-hex
> +count=`cat trace | grep 'proc_reg_write' | grep '= -5' | wc -l`
> +if [ $count -eq 0 ]; then
> +    fail "Return value can not be printed in signed decimal format"
> +fi
> +
> +: "Test printing the error code in hexadecimal format"
> +echo 1 > options/funcgraph-retval-hex
> +count=`cat trace | grep 'proc_reg_write' | grep 'fffffffb' | wc -l`
> +if [ $count -eq 0 ]; then
> +    fail "Return value can not be printed in hexadecimal format"
> +fi
> +
> +exit 0
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
