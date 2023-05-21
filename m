Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74D70ACED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 10:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjEUIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 04:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEUIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 04:08:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D4FE;
        Sun, 21 May 2023 01:08:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so4942550a12.0;
        Sun, 21 May 2023 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684656531; x=1687248531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPjmHku2tRjtFMFQ0VjYD/cqFGXrpt1kb3JxP1rwY4o=;
        b=TaAB2s+rAIf0e7ZEN0HPfsDv183v6EQEAU/OBXmfNmn1OR9LaFAVlVMktEDKn17r4+
         jl0SIHvraXvVGpaf3uLE9+rfQ5P9EcqDB5wNoJAg04fsBeRXa2tN6sopZdu83A2ZZkwT
         nRC0oolJNF75DU6hOOkwc9GMUjGRkbLOc6E+McvJFj/cdeY2edAAzQS3q0D2Jt2Cx9C2
         X3Zkd/ngS/C1/MltWiCnEs8f9qcDjqCZY1LOCFTZtfU5dBe4GsbCeTQVbN6LDueIHw8D
         Abo7IHCansw5Ng793aF1pBM/7dSRR9Y5uVpckZmj9joOXbU5syCkahG868Ph2cRLK/tG
         dMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684656531; x=1687248531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPjmHku2tRjtFMFQ0VjYD/cqFGXrpt1kb3JxP1rwY4o=;
        b=Q/JtxsitwBy7er7t0DlZXLhN9gJOFwUrpps4kw4ivmRP7amCZhxkHv7A4r82GWMWtk
         SlVvOK1iZJCHGHnnqB/y0iTjfSk3vF8ZY9ACznOFYFhE6+29NgMWLtmblv59Nl5qBH56
         wGvhW9sMyDyWQIy2b46dU9v4IjQJnHkZJ54q38tn6blDc/xWJko7chYsx39YiiK7wNcU
         Y4ptuB+/19G6pKVi/+qMCn51qujJCciYjVfEz/tXSKtYAW5CRNXBGJfjzhFXzymKHsb9
         y+B+gtPfyjYytzKMO5CqeJK8rSDapid6d48Cnq7yN74Zkb5ZgKwx9Avbbr41sNIo1aV5
         rX6w==
X-Gm-Message-State: AC+VfDzbfFubRM8jZIr7ym0JPIlWEmzQVryhDCDPoTkXknZ4lwbrkJ7N
        y1VjH2XXlGbUvJzBuW6StqY=
X-Google-Smtp-Source: ACHHUZ7sMC1jICnKE6CiK42E6KdCejLh/wDV4CapwptXihZa6QWWijVRU/9eOMOAdE4aHPGnb1r6Cg==
X-Received: by 2002:a17:907:7f8c:b0:96a:5e38:ba49 with SMTP id qk12-20020a1709077f8c00b0096a5e38ba49mr7916436ejc.2.1684656530364;
        Sun, 21 May 2023 01:08:50 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090640cd00b00965a52d2bf6sm1599244ejk.88.2023.05.21.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 01:08:49 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 21 May 2023 10:08:46 +0200
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kafai@fb.com, kpsingh@chromium.org, netdev@vger.kernel.org,
        paulmck@kernel.org, songliubraving@fb.com,
        Ze Gao <zegao@tencent.com>
Subject: Re:
Message-ID: <ZGnRjkjxWrK8HzNm@krava>
References: <20220515203653.4039075-1-jolsa@kernel.org>
 <20230520094722.5393-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520094722.5393-1-zegao@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 05:47:24PM +0800, Ze Gao wrote:
> 
> Hi Jiri,
> 
> Would you like to consider to add rcu_is_watching check in
> to solve this from the viewpoint of kprobe_multi_link_prog_run

I think this was discussed in here:
  https://lore.kernel.org/bpf/20230321020103.13494-1-laoar.shao@gmail.com/

and was considered a bug, there's fix mentioned later in the thread

there's also this recent patchset:
  https://lore.kernel.org/bpf/20230517034510.15639-3-zegao@tencent.com/

that solves related problems

> itself? And accounting of missed runs can be added as well
> to imporve observability.

right, we count fprobe->nmissed but it's not exposed, we should allow
to get 'missed' stats from both fprobe and kprobe_multi later, which
is missing now, will check

thanks,
jirka

> 
> Regards,
> Ze
> 
> 
> -----------------
> From 29fd3cd713e65461325c2703cf5246a6fae5d4fe Mon Sep 17 00:00:00 2001
> From: Ze Gao <zegao@tencent.com>
> Date: Sat, 20 May 2023 17:32:05 +0800
> Subject: [PATCH] bpf: kprobe_multi runs bpf progs only when rcu_is_watching
> 
> From the perspective of kprobe_multi_link_prog_run, any traceable
> functions can be attached while bpf progs need specical care and
> ought to be under rcu protection. To solve the likely rcu lockdep
> warns once for good, when (future) functions in idle path were
> attached accidentally, we better paying some cost to check at least
> in kernel-side, and return when rcu is not watching, which helps
> to avoid any unpredictable results.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9a050e36dc6c..3e6ea7274765 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2622,7 +2622,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  	struct bpf_run_ctx *old_run_ctx;
>  	int err;
>  
> -	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1 || !rcu_is_watching())) {
>  		err = 0;
>  		goto out;
>  	}
> -- 
> 2.40.1
> 
