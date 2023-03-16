Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6A6BC4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCPDuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCPDt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C00D12875
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEFD60FDE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD2C433EF;
        Thu, 16 Mar 2023 03:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678938554;
        bh=rG+Uszcbg+9oJV591AEioVKZv2hgUyy8jPQH7Hru3ug=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LeOpaGobVPNzqSlPPnRvYsZp6Pg35eQSz2aKc4C8r6d0OgWPB0f16Q3Tv/2eRIrb7
         7wIIn9VAHY/1piYXPceB2QzwSWoiLsJh0uvuiRZIY6FJ+65WHfGpwTvt4ICQrU+c7g
         6dHmvmuT6Imiu9F6SWAGnBoeSHAE/21M1TyZe8wZxC6nWmtqx7EZAU7GHigOCQvXvg
         w6IlsZYrjzx7PxmfzjpBOXpcZwQTT4dfJA67JRND43LG9cIZsfc/Yby2qUBlDeWq5a
         /5cb8ei22QN7dLI02bhQhLcc0rhvE9tObgSouMunzcteQMIoyJTXcGh0CW3fslffq0
         semVNytl/vauA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 548501540395; Wed, 15 Mar 2023 20:49:14 -0700 (PDT)
Date:   Wed, 15 Mar 2023 20:49:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] checkpatch: Error out if deprecated RCU API used
Message-ID: <2747f36d-1598-4734-81f7-c42d4f354606@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-14-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315181902.4177819-14-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:19:01PM +0000, Joel Fernandes (Google) wrote:
> Single-argument kvfree_rcu() usage is being deprecated [1] [2]. However,
> till all users are converted, we would like to introduce checkpatch
> errors for new patches submitted.
> 
> This patch adds support for the same. Tested with a trial patch.
> 
> For now, we are only considering usages that don't have compound
> nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
> This is sufficient as such usages are unlikely.
> 
> Once all users are converted and we remove the old API, we can also revert this
> checkpatch patch then.
> 
> [1] https://lore.kernel.org/rcu/CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com/
> [2] https://lore.kernel.org/rcu/CAEXW_YSY=q2_uaE2qo4XSGjzs4+C102YMVJ7kWwuT5LGmJGGew@mail.gmail.com/
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

With or without the change suggested below:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  scripts/checkpatch.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd44d12965c9..9da0a3cb1615 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6388,6 +6388,15 @@ sub process {
>  			}
>  		}
>  
> +# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> +		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> +			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> +				ERROR("DEPRECATED_API",
> +				      "Single-argument k[v]free_rcu() API is deprecated, please call the API with an rcu_head object passed, like: k[v]free_rcu(object_ptr, rcu_head_name);  " . $herecurr);

Perhaps also point them at kvfree_rcu_mightsleep()?

							Thanx, Paul

> +			}
> +		}
> +
> +
>  # check for unnecessary "Out of Memory" messages
>  		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
>  		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
