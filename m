Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB16536C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLUTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiLUTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:02:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FC23BD0;
        Wed, 21 Dec 2022 11:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0AFE1CE18A8;
        Wed, 21 Dec 2022 19:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9F6C433F2;
        Wed, 21 Dec 2022 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671649328;
        bh=cu25G7BTb31BQwZzaIVB62X6PGA5eYeXzZytkXRQLyY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=awmydDB8vDyt/uonFAbFahvuaSpCwUro6U0LLi9S2zJNlmFPgIoslWg6monMvIaFb
         b2s3WMr6xNGoqXi0YbReGvjr39vLcMGsu2zoJWQ3s2S2mm65EgS3ORuqTbiMDQpt85
         O6BgVRcjgB/kYWqW97ye6aMgIm6Wiz8r4m53Zmgt/t+zWVV3bA3aOqExtI54uvU2WU
         MOZIvv8cvsX/05v4Cq0w2YXfbWdmV47hBfE1dTEDvtwt3SwzyH3txy4BYvYezkwvUs
         A1v2/fMaAFHK7pin16ikxO+5mW74kLY2ISe7BWEP96UvGR6YjuuGRxscajSPi7asn5
         zGBIIXQ2+atGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C48995C0989; Wed, 21 Dec 2022 11:02:07 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:02:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, linux-crypto@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rcu: print first CPU on expedited stall line
Message-ID: <20221221190207.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221219202910.3063036-1-elliott@hpe.com>
 <20221219202910.3063036-3-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219202910.3063036-3-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:29:09PM -0600, Robert Elliott wrote:
> Include the first CPU number in the first pr_err() call reporting
> an expedited stall warning.
> 
> Printing the CPU numbers with subsequent pr_cont() calls can
> result in the prints being many lines away or being dropped entirely
> in a busy system. This change ensures there is indication of at
> least one of the CPUs with the problem with the original message.
> 
> Before (if prints are interspersed with other prints):
>   rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
>   13-....
>   } 32 jiffies s: 6685 root: 0x1/.
> 
> After:
>   rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {13-....
>   } 32 jiffies s: 6685 root: 0x1/.
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>

A couple of questions below.

> ---
>  kernel/rcu/tree_exp.h | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index ed6c3cce28f2..ade6a18e6c07 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -624,8 +624,6 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (rcu_stall_is_suppressed())
>  			continue;
>  		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> -		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
> -		       rcu_state.name);
>  		ndetected = 0;
>  		rcu_for_each_leaf_node(rnp) {
>  			ndetected += rcu_print_task_exp_stall(rnp);
> @@ -637,11 +635,21 @@ static void synchronize_rcu_expedited_wait(void)
>  					continue;
>  				ndetected++;
>  				rdp = per_cpu_ptr(&rcu_data, cpu);
> -				pr_cont(" %d-%c%c%c%c", cpu,
> -					"O."[!!cpu_online(cpu)],
> -					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
> -					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
> -					"D."[!!(rdp->cpu_no_qs.b.exp)]);
> +				// print the prefix and the first CPU number together
> +				// under heavy load, the pr_cont prints can be far away or dropped
> +				if (ndetected == 1)

Is the purpose here to print the header only on the first detected task?
If so, what if there is more than one task blocking the first rcu_node
structure?  Wouldn't that omit the header entirely?

> +					pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {%d-%c%c%c%c",

We can of course get other console output interspersed at this point.
This might be OK in practice, but the commit log should clearly spell
out the reasons.

> +					       rcu_state.name, cpu,
> +					       "O."[!!cpu_online(cpu)],
> +					       "o."[!!(rdp->grpmask & rnp->expmaskinit)],
> +					       "N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
> +					       "D."[!!(rdp->cpu_no_qs.b.exp)]);
> +				else
> +					pr_cont(" %d-%c%c%c%c", cpu,
> +						"O."[!!cpu_online(cpu)],
> +						"o."[!!(rdp->grpmask & rnp->expmaskinit)],
> +						"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
> +						"D."[!!(rdp->cpu_no_qs.b.exp)]);
>  			}
>  		}
>  		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
> -- 
> 2.38.1
> 
