Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E55E7C78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiIWODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIWODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5F913D1E7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE304612F3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0609C4347C;
        Fri, 23 Sep 2022 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663941826;
        bh=uNH64xYhRKbSQJzlen7Vjk+u1EvoGE8+anLh59m1sl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tD3ufd43Bo2iK5QOds4TzRAl3PKKZBGP9jMTH0uINTDN/ow6bULydyCEDJnaoHZo7
         37x/YXoADi+gpeNzUALwmy5Y9gTNP/g6CCsEQtO23l0uBTf2lD2xfdd17MvFGI7Wz1
         JwcUrcm6oTusI/0zjnYiPrDJXkWmWRYTsMQi2n8vmwdhqNmKqcdv5M+M1OWSZWxGEx
         6N2kwUVbVhxRnZWQoiC5P4dUVzZ7SlWinLhpa1DyNxJpm2Y6Y6ijbTuU3/SJst1vNc
         xqQoyjiGcgUKntyPhToR5l75pBMrMqwTGKq1jZt3HIwAuog5Y80B6DSdP2EbMh4ZBF
         Xk0VqYbCmBirw==
Date:   Fri, 23 Sep 2022 23:03:40 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <zanussi@kernel.org>,
        <liaochang1@huawei.com>, <chris.zjh@huawei.com>
Subject: Re: [PATCH 1/2] tracing: kprobe: fix kprobe event gen test module
 on exit
Message-Id: <20220923230340.cc2b2c714a4f45624f9f23bf@kernel.org>
In-Reply-To: <20220919125629.238242-2-zouyipeng@huawei.com>
References: <20220919125629.238242-1-zouyipeng@huawei.com>
        <20220919125629.238242-2-zouyipeng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 20:56:28 +0800
Yipeng Zou <zouyipeng@huawei.com> wrote:

> Correct gen_kretprobe_test clr event para on module exit.
> This will make it can't to delete.

Looks good to me. (actually, both tests will use the same root
trace_array, so the test itself will not fail, but this should
be fixed.)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>  kernel/trace/kprobe_event_gen_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index 18b0f1cbb947..e023154be0f8 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -206,7 +206,7 @@ static void __exit kprobe_event_gen_test_exit(void)
>  	WARN_ON(kprobe_event_delete("gen_kprobe_test"));
>  
>  	/* Disable the event or you can't remove it */
> -	WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
> +	WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
>  					  "kprobes",
>  					  "gen_kretprobe_test", false));
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
