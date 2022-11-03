Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302116173FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKCCEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKCCEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C5E12088
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0456D61CE1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7BEC433C1;
        Thu,  3 Nov 2022 02:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667441079;
        bh=ny7eQv3eVpwmynqI/XthZME4ZjAW0UlVsjmymz0UkUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PjBhX6TwEcBGoZdDWzgQUeQs3XFXSU+6RcJX1B/jTTSFqnkm/xdlJ9wxRo3ac08jW
         u+zs6WXEzprkiVe0nYPPnNMzxCTDSKqaeq6rkLxDFhC87hjcKZBfB8j1Ccf3esPReY
         U31tVZtXi4UZlmx0aBSBN7+qOSSd+VWvqSc8Sl+fFo8BWsrUbUFSDIbA7MFWuNcdzl
         Wsc7nLRIFGV54YYOnIMAQxTouGCBvCO3P+Y9Ko+uomOqJ/skofVOychmA+IxOyKUN0
         bfhbgHvSOwNOqRN12xvWwhyBCK1vaBFkDz++hW1a4P/JAEEggnpWx8GMFkel55vOdx
         igXSFEoxHbnyQ==
Date:   Thu, 3 Nov 2022 11:04:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     <rostedt@goodmis.org>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: kprobe: Fix memory leak in
 test_gen_kprobe/kretprobe_cmd()
Message-Id: <20221103110436.79343e3825bcd21c3f7e7c60@kernel.org>
In-Reply-To: <20221102072954.26555-1-shangxiaojing@huawei.com>
References: <20221102072954.26555-1-shangxiaojing@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 15:29:54 +0800
Shang XiaoJing <shangxiaojing@huawei.com> wrote:

> test_gen_kprobe_cmd() only free buf in fail path, hence buf will leak
> when there is no failure. Move kfree(buf) from fail path to common path
> to prevent the memleak. The same reason and solution in
> test_gen_kretprobe_cmd().
> 
> unreferenced object 0xffff888143b14000 (size 2048):
>   comm "insmod", pid 52490, jiffies 4301890980 (age 40.553s)
>   hex dump (first 32 bytes):
>     70 3a 6b 70 72 6f 62 65 73 2f 67 65 6e 5f 6b 70  p:kprobes/gen_kp
>     72 6f 62 65 5f 74 65 73 74 20 64 6f 5f 73 79 73  robe_test do_sys
>   backtrace:
>     [<000000006d7b836b>] kmalloc_trace+0x27/0xa0
>     [<0000000009528b5b>] 0xffffffffa059006f
>     [<000000008408b580>] do_one_initcall+0x87/0x2a0
>     [<00000000c4980a7e>] do_init_module+0xdf/0x320
>     [<00000000d775aad0>] load_module+0x3006/0x3390
>     [<00000000e9a74b80>] __do_sys_finit_module+0x113/0x1b0
>     [<000000003726480d>] do_syscall_64+0x35/0x80
>     [<000000003441e93b>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  kernel/trace/kprobe_event_gen_test.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index 80e04a1e1977..d81f7c51025c 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -100,20 +100,20 @@ static int __init test_gen_kprobe_cmd(void)
>  					 KPROBE_GEN_TEST_FUNC,
>  					 KPROBE_GEN_TEST_ARG0, KPROBE_GEN_TEST_ARG1);
>  	if (ret)
> -		goto free;
> +		goto out;
>  
>  	/* Use kprobe_event_add_fields to add the rest of the fields */
>  
>  	ret = kprobe_event_add_fields(&cmd, KPROBE_GEN_TEST_ARG2, KPROBE_GEN_TEST_ARG3);
>  	if (ret)
> -		goto free;
> +		goto out;
>  
>  	/*
>  	 * This actually creates the event.
>  	 */
>  	ret = kprobe_event_gen_cmd_end(&cmd);
>  	if (ret)
> -		goto free;
> +		goto out;
>  
>  	/*
>  	 * Now get the gen_kprobe_test event file.  We need to prevent
> @@ -136,13 +136,11 @@ static int __init test_gen_kprobe_cmd(void)
>  		goto delete;
>  	}
>   out:
> +	kfree(buf);
>  	return ret;
>   delete:
>  	/* We got an error after creating the event, delete it */
>  	ret = kprobe_event_delete("gen_kprobe_test");
> - free:
> -	kfree(buf);
> -
>  	goto out;
>  }
>  
> @@ -170,14 +168,14 @@ static int __init test_gen_kretprobe_cmd(void)
>  					    KPROBE_GEN_TEST_FUNC,
>  					    "$retval");
>  	if (ret)
> -		goto free;
> +		goto out;
>  
>  	/*
>  	 * This actually creates the event.
>  	 */
>  	ret = kretprobe_event_gen_cmd_end(&cmd);
>  	if (ret)
> -		goto free;
> +		goto out;
>  
>  	/*
>  	 * Now get the gen_kretprobe_test event file.  We need to
> @@ -201,13 +199,11 @@ static int __init test_gen_kretprobe_cmd(void)
>  		goto delete;
>  	}
>   out:
> +	kfree(buf);
>  	return ret;
>   delete:
>  	/* We got an error after creating the event, delete it */
>  	ret = kprobe_event_delete("gen_kretprobe_test");
> - free:
> -	kfree(buf);
> -
>  	goto out;
>  }
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
