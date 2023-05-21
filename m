Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6B70ADF6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjEULuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjEUKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E821A1;
        Sun, 21 May 2023 03:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759A960EF8;
        Sun, 21 May 2023 10:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2D0C433D2;
        Sun, 21 May 2023 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684663754;
        bh=YiYXte2Ov4q718ZuslBI02BeUfZ/XQCo7cBMxKqJ824=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mw9Q3VHP/cRbht7elt1Q233Yql9KvZxMyXfDt1dD+6cvrhNc5lTYS3OfVB0K8R60a
         Xcc+J5kO0F+PwLqOAd8PUXF2VGC4oQ7wi9loy0w87My9nrYDicgJjSSq4KX/gddgb4
         WfW/JRp7Ced9irmKomN/XnWrVjC57qgQApmT5m3av1cPpWjLLpQq8JEiCrlak2imze
         C1hd+kD9GUgNM1bKru4dcv6f680I8r9BgSeXoZUMPt2EtD8FWs1Ks4RzsiFHni8mvK
         dso6QAPza3HG+m391BBBpAlHQd+PQaVqkvtWCELH+gzaDCHpZen9+bKbQOpDjl0rwb
         Xm+THbVEhlM2w==
Date:   Sun, 21 May 2023 19:09:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ze Gao <zegao2021@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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
Message-Id: <20230521190907.e4104a653583dfac785e379a@kernel.org>
In-Reply-To: <ZGnRjkjxWrK8HzNm@krava>
References: <20220515203653.4039075-1-jolsa@kernel.org>
        <20230520094722.5393-1-zegao@tencent.com>
        <ZGnRjkjxWrK8HzNm@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2023 10:08:46 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Sat, May 20, 2023 at 05:47:24PM +0800, Ze Gao wrote:
> > 
> > Hi Jiri,
> > 
> > Would you like to consider to add rcu_is_watching check in
> > to solve this from the viewpoint of kprobe_multi_link_prog_run
> 
> I think this was discussed in here:
>   https://lore.kernel.org/bpf/20230321020103.13494-1-laoar.shao@gmail.com/
> 
> and was considered a bug, there's fix mentioned later in the thread
> 
> there's also this recent patchset:
>   https://lore.kernel.org/bpf/20230517034510.15639-3-zegao@tencent.com/
> 
> that solves related problems

I think this rcu_is_watching() is a bit different issue. This rcu_is_watching()
check is required if the kprobe_multi_link_prog_run() uses any RCU API.
E.g. rethook_try_get() is also checks rcu_is_watching() because it uses
call_rcu().

Thank you,

> 
> > itself? And accounting of missed runs can be added as well
> > to imporve observability.
> 
> right, we count fprobe->nmissed but it's not exposed, we should allow
> to get 'missed' stats from both fprobe and kprobe_multi later, which
> is missing now, will check
> 
> thanks,
> jirka
> 
> > 
> > Regards,
> > Ze
> > 
> > 
> > -----------------
> > From 29fd3cd713e65461325c2703cf5246a6fae5d4fe Mon Sep 17 00:00:00 2001
> > From: Ze Gao <zegao@tencent.com>
> > Date: Sat, 20 May 2023 17:32:05 +0800
> > Subject: [PATCH] bpf: kprobe_multi runs bpf progs only when rcu_is_watching
> > 
> > From the perspective of kprobe_multi_link_prog_run, any traceable
> > functions can be attached while bpf progs need specical care and
> > ought to be under rcu protection. To solve the likely rcu lockdep
> > warns once for good, when (future) functions in idle path were
> > attached accidentally, we better paying some cost to check at least
> > in kernel-side, and return when rcu is not watching, which helps
> > to avoid any unpredictable results.
> > 
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  kernel/trace/bpf_trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9a050e36dc6c..3e6ea7274765 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2622,7 +2622,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> >  	struct bpf_run_ctx *old_run_ctx;
> >  	int err;
> >  
> > -	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1 || !rcu_is_watching())) {
> >  		err = 0;
> >  		goto out;
> >  	}
> > -- 
> > 2.40.1
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
