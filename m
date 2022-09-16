Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA805BABF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiIPLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiIPLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6508F95E;
        Fri, 16 Sep 2022 03:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0DC62ADE;
        Fri, 16 Sep 2022 10:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB8C433C1;
        Fri, 16 Sep 2022 10:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663325727;
        bh=d7++6KU0EYcQnNvGqmzIiNTKAGfjD93jm1cap1+0pPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXYYnDGwLn70nlBjLtd/c66NwpHeLZEzfwnC3alj08Y2cj6e8xajqmmrhC+MLeIdW
         N4upEfDRxvgJ+HUNadVTM6ctcTY+T4tjg3ZYFVvtcrVAyvGJr6lcROYyaXjoM+z/mn
         F2AACSFZyR37QxvmshO8jmMuDmAn80jjgLmM8RDDF1SICIe7qJw1ldI07VsfVbytfo
         8m3Q6LytrD9wgBt/LChZ1axAZ0AxkiUvKmZHcJ9lKnEIoua6t7govZs6YsxQQod5Hf
         PnRCtYlxatHeuRCtClvvt3sHRpwZwPh+kSaYhJrsSsMinJG9FHxbhcCKpKZkPg9A48
         yENH/1TgT8log==
Date:   Fri, 16 Sep 2022 12:55:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 1/3] rcu/tree: Use READ_ONCE() for lockless read
 of rnp->qsmask
Message-ID: <20220916105523.GA25456@lothringen>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915001419.55617-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 12:14:17AM +0000, Joel Fernandes (Google) wrote:
> The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
> may help avoid load tearing due to concurrent access, KCSAN
> issues, and preserve sanity of people reading the mask in tracing.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0ca21ac0f064..5ec97e3f7468 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
>  
> -	blkd = !!(rnp->qsmask & rdp->grpmask);
> +	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
>  	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
>  			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
>  	return 0;

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
