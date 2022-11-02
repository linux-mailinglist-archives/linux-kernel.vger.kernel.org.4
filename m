Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB226162CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKBMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:39:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D30C24952;
        Wed,  2 Nov 2022 05:39:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp15so27943613lfb.13;
        Wed, 02 Nov 2022 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXZZm1OWNoD+MlyMwXmBwTMSYbGBMYKx08W+mXfVVsk=;
        b=DjotE9Jfn1pVJuY6tm+mmxAabBRwlZKt4B6/k4D0lLtIf0Pm5q6PhhEmew02EDFyyj
         o6EpBdM6y/aapaIzADtdXu2/EWHaUUkmxMVxDKHNXEph5AbAKxYFMuF/UszrtxSw4e+U
         WKbjZ9QxEsbydtGsGlxftFtTf6nPcjtEfuL3T7MlscIe3NoFkvCNTKLq6sIsMzfOXM+U
         yZMaGKSGBWL9IrVxaEhXZSdgMyMvUCBiTDMPiqqRrVz/lXcQHSASiWgxBF4ITlByVBB9
         qpNh1+OgWSb6YqEYSOLX8BZ7+j2gRfF5Ckg1M45VCk+q9qUUh+Za8qeLKyg79YW4+WfG
         KxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXZZm1OWNoD+MlyMwXmBwTMSYbGBMYKx08W+mXfVVsk=;
        b=j3OHRoDjhCRLSrQ4K1stsPj92QlXY31PjEdj/8NMNWexRJZHkqlDx+LTHM0qOjzkhz
         MKeRPYcp8x+Uvw1eNMUTaFmIrwx/TgJN3GU8y4A950A8pnWlDSaYI7sXkSE1AcL3L0iW
         akSpFhFybAAFoCPXydfTP6UcGlmRJmM7XENs7x78hP2f8JC0JJZQADYN4yMSjsgSZj2T
         BoJIv6pjDnronT0JnTdXZiFfP0EHTZYIJMsooaK6kZCCxg9lnykLVcTS/Wjr3hmgHd4o
         8ghHimDkflyc9xjY6+r+6zLeNR6mfPRsPIScPK+946yzXaNPvDkLqlXGPrsv8qMvVnvd
         ujKw==
X-Gm-Message-State: ACrzQf1QQ8caEbil8kW5BrHJn4SWrkkQUGgUfE2yo7209Foe9B6x3JlP
        knnMXPPdCwTpnGn3RvHDiFo=
X-Google-Smtp-Source: AMsMyM5SR4F08Pw/CdCEjT0l/mCMXmKZ/G7l5yiQYFqSeCe2UGmvrXswP+kRbx8zOX/qT6hlIKfvEg==
X-Received: by 2002:a05:6512:1596:b0:4a2:5de8:410a with SMTP id bp22-20020a056512159600b004a25de8410amr8433101lfb.627.1667392676312;
        Wed, 02 Nov 2022 05:37:56 -0700 (PDT)
Received: from pc636 (host-90-235-23-76.mobileonline.telia.com. [90.235.23.76])
        by smtp.gmail.com with ESMTPSA id v18-20020a2ea452000000b002771888fda1sm2159288ljn.84.2022.11.02.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:37:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 2 Nov 2022 13:37:53 +0100
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, urezki@gmail.com
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2JkoVV3jaVS4y0Q@pc636>
References: <20221029132856.3752018-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029132856.3752018-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> On ChromeOS, I am (almost) always seeing the optimization trigger.
> Tested boot up and trace_printk'ing how often it triggers.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 591187b6352e..3e4c50b9fd33 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
>  
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
>   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	raw_spinlock_t lock;
>  	struct delayed_work monitor_work;
> +	struct rcu_data *rdp;
> +	unsigned long last_gp_seq;
>  	bool initialized;
>  	int count;
>  
> @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
>  		return;
>  	}
> +	krcp->last_gp_seq = krcp->rdp->gp_seq;
>  	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
>  }
>  
> @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			//
> +			// NOTE about gp_seq wrap: In case of gp_seq overflow,
> +			// it is possible for rdp->gp_seq to be less than
> +			// krcp->last_gp_seq even though a GP might be over. In
> +			// this rare case, we would just have one extra GP.
> +			if (krcp->last_gp_seq &&
>
This check can be eliminated i think. A kfree_rcu_cpu is defined as
static so by default the last_gp_set is set to zero.

>  
> @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> +		krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> +		krcp->last_gp_seq = 0;
>
Yep. This one can be just dropped.

But all the rest looks good :) I will give it a try from test point of
view. It is interested from the memory footprint point of view.

--
Uladzislau Rezki
