Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4F6A607B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjB1Ujo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjB1Ujl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:39:41 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8934C26
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:39:32 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id f1so7774094qvx.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677616772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3N2ywhkR/bMPSeXmwyHCwpyMHSCbDCyuk19SKsi7Rfg=;
        b=agY7M0SISSdJupcls04a1QBQDOpWIBYSAesvX1+dRM5Tf/TKtCupRGPyem+9EZlYnn
         40/a0mJ1MjcqAxbM0a4CYgn87T4aFjwtfCato8dAjIiQygAc7AVMzUzlMsFUd6+f4edD
         NhE/DZIV3iiL7BRk9fi2RH5TsT8AmpR09suxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677616772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N2ywhkR/bMPSeXmwyHCwpyMHSCbDCyuk19SKsi7Rfg=;
        b=zbE0T7Y2wnLIjshAvA7VrwbDwFmAHBTtfvS/n+WySEZWBEJ1e53Swq9nA1s8WXYyzh
         Tjz3/TsFmvkDsliTrdLaSHVNiAr2fU7Ta3rcdAnlgU+soKb1vCBLbJo0NNlX4elcrwrM
         NZyDoozqfiFIyTZNpchRPsG3i0sRWYgf77RmPqZphtLmCpL51Oa/LK5ov4t3JGpj48F6
         qxvLTIYql9v9hJ5f8zmh3PU17KiwUQ66RB9ZcpMEpVG7XmP8E/Zi0rUqRLY1gyTgkGsv
         9jAIz0mRTFeRL+SbiSvFf5ml7M3N3cBNBN6r3pLOG5G0VE0ob7/oPu3av9SpN2HWklUO
         eHfg==
X-Gm-Message-State: AO0yUKV32Fq2WdmMT8EPtpAdtzgqtrTALvm21eI/v25TCXfXBAUupgsV
        KGVtAcgg4X+sKppsv5UClocFPg==
X-Google-Smtp-Source: AK7set/zofXKOT7Or3LOrmfABLDV6LwDDjSbBnAaw0bI6AAd+d8bCXukM4oVLnnSBzOzJB9BaffATA==
X-Received: by 2002:ad4:5aea:0:b0:574:8ef8:89cc with SMTP id c10-20020ad45aea000000b005748ef889ccmr8817048qvh.41.1677616771783;
        Tue, 28 Feb 2023 12:39:31 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id 81-20020a370c54000000b007423ccd892csm7479037qkm.47.2023.02.28.12.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:39:31 -0800 (PST)
Date:   Tue, 28 Feb 2023 20:39:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <Y/5mguXPPqdP3MZF@google.com>
References: <20230228155121.3416-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228155121.3416-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:51:21PM +0100, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg (and related move instruction in
> front of cmpxchg).

In my codegen, I am not seeing mov instruction before the cmp removed, how
can that be? The rax has to be populated with a mov before cmpxchg right?

So try_cmpxchg gives: mov, cmpxchg, cmp, jne
Where as cmpxchg gives: mov, cmpxchg, mov, jne

So yeah you got rid of compare, but I am not seeing reduction in moves.
Either way, I think it is an improvement due to dropping cmp so:

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> No functional change intended.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/rcu/tree_stall.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a..d81c88e66b42 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -760,7 +760,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	jn = jiffies + ULONG_MAX / 2;
>  	if (rcu_gp_in_progress() &&
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> -	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +	    try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>  
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
> @@ -778,7 +778,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  
>  	} else if (rcu_gp_in_progress() &&
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> -		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +		   try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>  
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
> -- 
> 2.39.2
> 
