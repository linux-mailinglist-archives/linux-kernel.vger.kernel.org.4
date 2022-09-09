Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FE5B3D68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiIIQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiIIQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:48:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699F0145FFB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:48:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l12-20020a25ad4c000000b006a8e04c284dso2107148ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=EiWKoBzR0iZJ4t5t4o8KKYQS1ZEBQp5DPZAlqfx7Mbw=;
        b=KQwKfUkXf85y1dPVwfQ8Qc7MSxQLT9AYU5ZGZvPs+5ppPcywurh+ZJ4JvmKqp13RJF
         366/1+1wq7kJ4iBC3fym2Y0RRxCoLod6Ygnhy/n2U7mlPpVFOgYn6ZbmoqJZyL7LxQ2Z
         rHwme73ruJzdXxRJGS9cu07qAtNPJtyb3GXOMbmmzZj34WHQtm9fe2v2QkDS8UVbrdQV
         xsCsQzZv7It58MNmjAKZMpfX3nNntS2K4PMw/e9l9MPUijKpR3+3g2+Yw8W99Egy0wdy
         ADLqB6rQ0lkUCci1VU4uKtBM0wLo68D+Vzk/70jgprUpnCJHrVGH4gddrS2YteDyj7q2
         jbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=EiWKoBzR0iZJ4t5t4o8KKYQS1ZEBQp5DPZAlqfx7Mbw=;
        b=nTIYtcqbRuo21rKQaldPFnCjbZkvvVdxnLh7q5IZNQ5QYJpaDnjvYiEmswRWrZlWKz
         8Bip3VCfHF3+Pc06dA/oTqzJOONaO8hAr/vtF5FT57hOObsieT9dYMLa36mv56tZ+cAo
         cayohljemrTmu6IceYJTK+L4T0Cskj0VijSNuhueT7ZXAtsqvSThgSAPAR9HrD2SkFgk
         tzW7GU+WvPNe4eTNOMIQQ5HaLJk0lRduCWsdFcbA32zXYF0ro00tbheI07WH8QbcgAFI
         GQwDkQvpTqRI32GGk7s1rpg4Nqs/M7qD7pHDfX5PnCkvhG+/J7fUB+Cw5vWl7y4kwUXg
         ngCQ==
X-Gm-Message-State: ACgBeo0EzU3GhW82ccJk4AViweOl55jPP0TkbudEtzdU6Nk0KIYiZ2Q9
        i45qdI84ppak2V03I1znVTylAA8=
X-Google-Smtp-Source: AA6agR4kYomPbLNUC/WT0027++lNLZfdZRdSZGZCMqTiWLGwnVmGNNXmOYwbsCb7MKr15OhG6+d4jro=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1143:b0:6ad:a593:2612 with SMTP id
 p3-20020a056902114300b006ada5932612mr11807651ybu.474.1662742088546; Fri, 09
 Sep 2022 09:48:08 -0700 (PDT)
Date:   Fri, 9 Sep 2022 09:48:07 -0700
In-Reply-To: <tencent_6715F3D7DF513D441A835321FAACFFCB0907@qq.com>
Mime-Version: 1.0
References: <tencent_6715F3D7DF513D441A835321FAACFFCB0907@qq.com>
Message-ID: <YxtuR6hWUkGfiWya@google.com>
Subject: Re: [PATCH bpf RESEND] samples/bpf: Replace blk_account_io_done()
 with __blk_account_io_done()
From:   sdf@google.com
To:     Rong Tao <rtoax@foxmail.com>
Cc:     bpf@vger.kernel.org, Rong Tao <rongtao@cestc.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>

> Since commit be6bfe36db17 ("block: inline hot paths of  
> blk_account_io_*()")
> blk_account_io_*() become inline functions.

Thanks for the fix.

Not sure why RESEND. And it should target bpf-next; this doesn't seem like
an important fix to warrant bpf. For future submissions, if you're targeting
bpf, try to also add Fixes: tag.

Not worth another resend though. Assuming it can be pulled in the proper
subtree by the maintainers.

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> Signed-off-by: Rong Tao <rtoax@foxmail.com>
> ---
>   samples/bpf/task_fd_query_kern.c | 2 +-
>   samples/bpf/task_fd_query_user.c | 2 +-
>   samples/bpf/tracex3_kern.c       | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

> diff --git a/samples/bpf/task_fd_query_kern.c  
> b/samples/bpf/task_fd_query_kern.c
> index c821294e1774..186ac0a79c0a 100644
> --- a/samples/bpf/task_fd_query_kern.c
> +++ b/samples/bpf/task_fd_query_kern.c
> @@ -10,7 +10,7 @@ int bpf_prog1(struct pt_regs *ctx)
>   	return 0;
>   }

> -SEC("kretprobe/blk_account_io_done")
> +SEC("kretprobe/__blk_account_io_done")
>   int bpf_prog2(struct pt_regs *ctx)
>   {
>   	return 0;
> diff --git a/samples/bpf/task_fd_query_user.c  
> b/samples/bpf/task_fd_query_user.c
> index 424718c0872c..a33d74bd3a4b 100644
> --- a/samples/bpf/task_fd_query_user.c
> +++ b/samples/bpf/task_fd_query_user.c
> @@ -348,7 +348,7 @@ int main(int argc, char **argv)
>   	/* test two functions in the corresponding *_kern.c file */
>   	CHECK_AND_RET(test_debug_fs_kprobe(0, "blk_mq_start_request",
>   					   BPF_FD_TYPE_KPROBE));
> -	CHECK_AND_RET(test_debug_fs_kprobe(1, "blk_account_io_done",
> +	CHECK_AND_RET(test_debug_fs_kprobe(1, "__blk_account_io_done",
>   					   BPF_FD_TYPE_KRETPROBE));

>   	/* test nondebug fs kprobe */
> diff --git a/samples/bpf/tracex3_kern.c b/samples/bpf/tracex3_kern.c
> index 710a4410b2fb..bde6591cb20c 100644
> --- a/samples/bpf/tracex3_kern.c
> +++ b/samples/bpf/tracex3_kern.c
> @@ -49,7 +49,7 @@ struct {
>   	__uint(max_entries, SLOTS);
>   } lat_map SEC(".maps");

> -SEC("kprobe/blk_account_io_done")
> +SEC("kprobe/__blk_account_io_done")
>   int bpf_prog2(struct pt_regs *ctx)
>   {
>   	long rq = PT_REGS_PARM1(ctx);
> --
> 2.31.1

