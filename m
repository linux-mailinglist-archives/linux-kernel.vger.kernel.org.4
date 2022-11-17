Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F28862DDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiKQOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiKQOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:20:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3408E59176;
        Thu, 17 Nov 2022 06:20:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D32E8B8206C;
        Thu, 17 Nov 2022 14:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C67BC433C1;
        Thu, 17 Nov 2022 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668694828;
        bh=9bz8ozLdU5Gqps188cWO1G1463iIY/CYrGproHkRxuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGi+9EhFk57oUyfocvE1BH9Nhdw62cTIMyPneJDuUssbY+smB+DRaap8sQRXvfzkO
         3R8RsmutTLeeJvjiOlDMtd2H4CzqRVE//2NJLOE/s81nW1JOsR3t4sx5wDICXTd8ER
         gazosC8kR4TzZxGcuZCjxz83C/Yr/mW7OkzxEkkWZragvQFZqAosqTMSrEBxjL2BhK
         3WBkrnXVlM3nVFP+OyE7UtTi3lMXnuEFCQCCVgSml2oRNUT1ZvJKFk1BPXW6/o1akx
         WdabsjdF7li0XN/n5MuvCajMwKrjEthafHsS6PbQX86jhGu3mY1deu/7V3zWt7B5L0
         OwR9jYE7Q23JQ==
Date:   Thu, 17 Nov 2022 15:20:25 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Message-ID: <20221117142025.GE839309@lothringen>
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117112050.3942407-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:20:50PM +0800, Zqiang wrote:
> Before SRCU_SIZE_WAIT_CALL srcu_size_state is reached, the srcu
> callback only insert to boot-CPU srcu_data structure's->srcu_cblist
> and other CPU srcu_data structure's->srcu_cblist is always empty. so
> before SRCU_SIZE_WAIT_CALL is reached, need to correctly check boot-CPU
> pend cbs in srcu_might_be_idle().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/srcutree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6af031200580..6d9af9901765 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1098,8 +1098,11 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>  	unsigned long tlast;
>  
>  	check_init_srcu_struct(ssp);
> -	/* If the local srcu_data structure has callbacks, not idle.  */
> -	sdp = raw_cpu_ptr(ssp->sda);
> +	/* If the boot CPU or local srcu_data structure has callbacks, not idle.  */
> +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
> +		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> +	else
> +		sdp = raw_cpu_ptr(ssp->sda);

While at it if someone is interested in documenting/commenting on the meaning of
all these SRCU_SIZE_* things, it would be much appreciated!

Thanks.

>  	spin_lock_irqsave_rcu_node(sdp, flags);
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
>  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> -- 
> 2.25.1
> 
