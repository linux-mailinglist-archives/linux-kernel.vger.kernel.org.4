Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53B8713400
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjE0K16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjE0K14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:27:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC7F7;
        Sat, 27 May 2023 03:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9C660AED;
        Sat, 27 May 2023 10:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F2C433EF;
        Sat, 27 May 2023 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183273;
        bh=C+WzGt1q9d0lH05NNK05+tR4vVIYrPDgEpHVAqLkZAc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UABfiHUpb+nRYDT82tFdgWn3aMX4jyrsJFbjdNZp++nQO53C2VDYOfdSmmzOFGX10
         Gh/BhqAouZ92Z/rYXq27XJu7/rgJNF2MkSFSqTbSJat111F0GD+XJxQoq0IHyJKxqR
         FCaamDN9nZlJJrnYyTG00nvRB6FT9LCP97PJpVER8LAj50EuN9UpO0+DcbN7ZI1pVy
         DC3PF50Olhqx0pZY7UB5Qe6yRAbRLScp51QFKGEtCFt0II6XroAms62KcyQCRCmyXW
         VzyRHC05Tn/N5JAAV9EgqTAnRlfP930lTzMP129hjSUI3mIrs1mBFl4wfdc/qsKFqL
         Ae6nCyHaGb7vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5FB7CE0DB0; Sat, 27 May 2023 03:27:50 -0700 (PDT)
Date:   Sat, 27 May 2023 03:27:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] notifier: Initialize new struct srcu_usage field
Message-ID: <b219e888-762a-454f-9a34-d0891f9cfe3a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230526073539.339203-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526073539.339203-1-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:35:37PM +0800, Chen-Yu Tsai wrote:
> In commit 95433f726301 ("srcu: Begin offloading srcu_struct fields to
> srcu_update"), a new struct srcu_usage field was added, but was not
> properly initialized. This led to a "spinlock bad magic" BUG when
> the SRCU notifier was ever used. This was observed in the MediaTek
> CCI devfreq driver on next-20230525. Trimmed stack trace as follows:
> 
>     BUG: spinlock bad magic on CPU#4, swapper/0/1
>      lock: 0xffffff80ff529ac0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>     Call trace:
>      spin_bug+0xa4/0xe8
>      do_raw_spin_lock+0xec/0x120
>      _raw_spin_lock_irqsave+0x78/0xb8
>      synchronize_srcu+0x3c/0x168
>      srcu_notifier_chain_unregister+0x5c/0xa0
>      cpufreq_unregister_notifier+0x94/0xe0
>      devfreq_passive_event_handler+0x7c/0x3e0
>      devfreq_remove_device+0x48/0xe8
> 
> Add __SRCU_USAGE_INIT() to SRCU_NOTIFIER_INIT() so that srcu_usage gets
> initialized properly.
> 
> Fixes: 95433f726301 ("srcu: Begin offloading srcu_struct fields to srcu_update")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Good catch, thank you!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> Also, the original patch subject said "srcu_update", however the data
> structure ended up as "srcu_usage". Maybe that could be updated?
> 
>  include/linux/notifier.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 2aba75145144..86544707236a 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -106,12 +106,22 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>  #define RAW_NOTIFIER_INIT(name)	{				\
>  		.head = NULL }
>  
> +#ifdef CONFIG_TREE_SRCU
>  #define SRCU_NOTIFIER_INIT(name, pcpu)				\
>  	{							\
>  		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
>  		.head = NULL,					\
> +		.srcuu = __SRCU_USAGE_INIT(name.srcuu),		\
>  		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
>  	}
> +#else
> +#define SRCU_NOTIFIER_INIT(name, pcpu)				\
> +	{							\
> +		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
> +		.head = NULL,					\
> +		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
> +	}
> +#endif
>  
>  #define ATOMIC_NOTIFIER_HEAD(name)				\
>  	struct atomic_notifier_head name =			\
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 
