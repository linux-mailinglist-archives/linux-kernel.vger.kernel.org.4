Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED06831A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjAaPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjAaPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:37:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215779EDE;
        Tue, 31 Jan 2023 07:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 731E561565;
        Tue, 31 Jan 2023 15:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2238C433EF;
        Tue, 31 Jan 2023 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675179476;
        bh=qVm5ApfnManH1Eoamx0qsmCbirxrEbIbD52NXuiTZHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pdjzxqPg3W+VVRwONLLbzQtXJZnJdppTmgO2vPLUJcpeFVlQeJ6s3bCQOgBPFB3Ek
         Z0dFhTyFVjYs8+0QXvWlmh/meDW9V+ELiDXVl6UGIjzlTucvBfyq9mQliBLkS1YD7j
         CXeZJshU5hKenH5x2Y1xP+Wr602k7lPvBWWwqOwJK9gH+r9lQb0N4eX8q42YbftwB6
         HXjM59iBkOi/rQszYD15bfrNT4+9me/oVRDO8vRGD1Am5OMUA3FWAdVR/CeaTA7X0q
         XG7w8Z1FvchlYN0rlTmm0/DzsI8NxEpKFCkDAfWTHflXvkmjeiP83qaxnHKL2uN1Cb
         AChlpkTno+abA==
Date:   Wed, 1 Feb 2023 00:37:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Anton Gusev <aagusev@ispras.ru>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix wrong return in kprobe_event_gen_test.c
Message-Id: <20230201003753.d844d26d902169ee64b979d4@kernel.org>
In-Reply-To: <20230131075818.5322-1-aagusev@ispras.ru>
References: <20230131075818.5322-1-aagusev@ispras.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 10:58:18 +0300
Anton Gusev <aagusev@ispras.ru> wrote:

> Overwriting the error code with the deletion result may cause the
> function to return 0 despite encountering an error. Commit b111545d26c0
> ("tracing: Remove the useless value assignment in
> test_create_synth_event()") solves a similar issue by
> returning the original error code, so this patch does the same.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anton Gusev <aagusev@ispras.ru>

Oops, thanks for the fix!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  kernel/trace/kprobe_event_gen_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index c736487fc0e4..e0c420eb0b2b 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -146,7 +146,7 @@ static int __init test_gen_kprobe_cmd(void)
>  	if (trace_event_file_is_valid(gen_kprobe_test))
>  		gen_kprobe_test = NULL;
>  	/* We got an error after creating the event, delete it */
> -	ret = kprobe_event_delete("gen_kprobe_test");
> +	kprobe_event_delete("gen_kprobe_test");
>  	goto out;
>  }
>  
> @@ -211,7 +211,7 @@ static int __init test_gen_kretprobe_cmd(void)
>  	if (trace_event_file_is_valid(gen_kretprobe_test))
>  		gen_kretprobe_test = NULL;
>  	/* We got an error after creating the event, delete it */
> -	ret = kprobe_event_delete("gen_kretprobe_test");
> +	kprobe_event_delete("gen_kretprobe_test");
>  	goto out;
>  }
>  
> -- 
> 2.39.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
