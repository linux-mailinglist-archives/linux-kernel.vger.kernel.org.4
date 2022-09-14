Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75F5B8690
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiINKqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiINKqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:46:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2185361702;
        Wed, 14 Sep 2022 03:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C95B81A0C;
        Wed, 14 Sep 2022 10:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651CDC4314B;
        Wed, 14 Sep 2022 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663152397;
        bh=UTHNNi7hiWzPKsrCRyObV9gT2Co0UbmtzeOVej8lszg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+sWd8KABWEDq88Au62EnUbBgNB6iHHJdJt6y7ujMrwQPf7mP+mIYM5y+KsDw/FZr
         h6EKVa8NYbZyNrEKGBwwdP1pfI/87RcH+O03oxF8drsJvxcXWqvbRHNj1ZAiEwFy0A
         eQpxnjc5nR7ZZF0zBYqikUNdirMsDpTRlAKE/61ILHk0Mg3wSwO/lmn8fyB4W2bAB4
         vInW6xDbx0Ykv1QY0UP8EHLnJQyOSKZGwzuQbOORZJPDuLD55O9ObRjqfG1fP6+Nyg
         hIuVxQl1EtiyIeobMBVye6tuAW7C0FQuxZd8vbkpbUdbGa4s+2ZWEwtYGBoGoTWkn1
         rNtyEq+LrQG6w==
Date:   Wed, 14 Sep 2022 12:46:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220914104634.GC1936@lothringen>
References: <20220913030036.1569-1-thunder.leizhen@huawei.com>
 <20220913030036.1569-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913030036.1569-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:00:36AM +0800, Zhen Lei wrote:
> In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
> CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
> Except that kernels booted without the rcu_nocbs= will not have
> allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
> its need_rcu_nocb_mask and offload_all local variables to track the
> rcu_nocb and nohz_full state.
> 
> But there is a much simpler approach, namely creating a cpumask pointer
> to track the default and then using cpumask_available() to check the
> rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
> and shortening the rcu_init_nohz() function.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Looks good, thanks!
