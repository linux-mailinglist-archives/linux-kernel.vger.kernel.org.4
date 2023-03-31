Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425316D1F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCaL6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCaL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073091C1D9;
        Fri, 31 Mar 2023 04:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976406284C;
        Fri, 31 Mar 2023 11:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC694C433D2;
        Fri, 31 Mar 2023 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263921;
        bh=n6gp7VEqq1z42XgDqkPrn3j/xK6NXlXyi6C5HXOWE3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQEz+j/AUUdBZH5mLL5wREYzKN6XBew67mxpV3n2DqX7DbTemV4wNb5OWB0dYK5LQ
         f/rDHbXeWnYNC1AoSCsRlCRyccBTL2/st1hr9obLEdDT8Jee9xUzoP3+gpp6rvMPoG
         rSayQCB+OoPBqFNv2meXlqnLwlx8gS4xhHv8G8G52h9uKSI4y6wry4Q6YDxhecyeaD
         FTtxfGRkUgBXVottSe36FnJgBZ1B9s13C4tdnse324Q4vCx4b2vJyth+AGwhKM25aC
         yzW/FCOm/bIVQvmV1FP3NMSkjOB82t6h63AOSiA8xwQ6QZKGL1CbIsdozLdfq5fiix
         f8iCeFGIAM4KA==
Date:   Fri, 31 Mar 2023 13:58:38 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rcu 01/20] rcu-tasks: Fix warning for unused
 tasks_rcu_exit_srcu
Message-ID: <ZCbK7hcVWFEFcPwN@lothringen>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330224726.662344-1-paulmck@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:47:07PM -0700, Paul E. McKenney wrote:
> The tasks_rcu_exit_srcu variable is used only by kernels built
> with CONFIG_TASKS_RCU=y, but is defined for all kernesl with
> CONFIG_TASKS_RCU_GENERIC=y.  Therefore, in kernels built with
> CONFIG_TASKS_RCU_GENERIC=y but CONFIG_TASKS_RCU=n, this gives
> a "defined but not used" warning.
> 
> This commit therefore moves this variable under CONFIG_TASKS_RCU.
> 
> Link: https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tasks.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index bfb5e1549f2b..185358c2f08d 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -136,8 +136,10 @@ static struct rcu_tasks rt_name =							\
>  	.kname = #rt_name,								\
>  }
>  
> +#ifdef CONFIG_TASKS_RCU
>  /* Track exiting tasks in order to allow them to be waited for. */
>  DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> +#endif

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

BTW should  exit_tasks_rcu_start/stop() be defined as static inline stubs
whenever !CONFIG_TASKS_RCU ? Currently:

* if CONFIG_TASKS_RCU_GENERIC=n, the stubs are as usual (static inline)

* if CONFIG_TASKS_RCU_GENERIC=y && CONFIG_TASKS_RCU=n, then the stubs are
  defined as empty linked function (is the compiler smart enough to remove
  the empty call?)
