Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A869BB9E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBRTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBRTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925A12BC1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F2A560B81
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 19:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC6EC433EF;
        Sat, 18 Feb 2023 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676748880;
        bh=J8R7tycmH1fFJwxe7RtFsmH6kS9YO9Df/2j/ET27ZGc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N8QqmAuxa0EVfhSozi4NbGPndGwfmqrimGk7SZZf40hjdYFTMQTSxX/H60w3byJL0
         ULfy0sBAht/6rlLLmhwpJp+H8BNI1g728/b2WAqnOooB8vMe0Fw75QF6Iv7+9PTiuo
         hs/EhavNse/oMSXZulx2Zsh3TKrPAmYtIJ307mQke7c9M8IrT9Zp5O2aaqVccZc0kW
         Pz1k0XUmPKjQubb0Kal7lyKcfRTO8PCRP1vKspz1HE95h1sVbZiuULPpLEpz5oBImY
         c9+eFPZjQC4AEm1oyRst+7npPYVSiTXXzIqG8AcPmXhw5ZG3qwQN2W44zICEyPLgM0
         u1F+sW6HB294Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6F60B5C0ACF; Sat, 18 Feb 2023 11:34:38 -0800 (PST)
Date:   Sat, 18 Feb 2023 11:34:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215061035.1534950-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 02:10:35PM +0800, Zqiang wrote:
> For PREEMPT_RT kernel, the spin_lock, spin_lock_irq will converted
> to sleepable rt_spin_lock and the interrupt related suffix for
> spin_lock/unlock(_irq, irqsave/irqrestore) do not affect CPU's
> interrupt state. this commit therefore add raw_spin_lock torture
> tests, this is a strict spin lock implementation in RT kernels.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

A nice addition!  Is this something you will be testing regularly?
If not, should there be additional locktorture scenarios, perhaps prefixed
by "RT-" to hint that they are not normally available?

Or did you have some other plan for making use of these?

						Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 9425aff08936..521197366f27 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -257,6 +257,61 @@ static struct lock_torture_ops spin_lock_irq_ops = {
>  	.name		= "spin_lock_irq"
>  };
>  
> +#ifdef CONFIG_PREEMPT_RT
> +static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);
> +
> +static int torture_raw_spin_lock_write_lock(int tid __maybe_unused)
> +__acquires(torture_raw_spinlock)
> +{
> +	raw_spin_lock(&torture_raw_spinlock);
> +	return 0;
> +}
> +
> +static void torture_raw_spin_lock_write_unlock(int tid __maybe_unused)
> +__releases(torture_raw_spinlock)
> +{
> +	raw_spin_unlock(&torture_raw_spinlock);
> +}
> +
> +static struct lock_torture_ops raw_spin_lock_ops = {
> +	.writelock	= torture_raw_spin_lock_write_lock,
> +	.write_delay	= torture_spin_lock_write_delay,
> +	.task_boost	= torture_rt_boost,
> +	.writeunlock	= torture_raw_spin_lock_write_unlock,
> +	.readlock	= NULL,
> +	.read_delay	= NULL,
> +	.readunlock	= NULL,
> +	.name		= "raw_spin_lock"
> +};
> +
> +static int torture_raw_spin_lock_write_lock_irq(int tid __maybe_unused)
> +__acquires(torture_raw_spinlock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&torture_raw_spinlock, flags);
> +	cxt.cur_ops->flags = flags;
> +	return 0;
> +}
> +
> +static void torture_raw_spin_lock_write_unlock_irq(int tid __maybe_unused)
> +__releases(torture_raw_spinlock)
> +{
> +	raw_spin_unlock_irqrestore(&torture_raw_spinlock, cxt.cur_ops->flags);
> +}
> +
> +static struct lock_torture_ops raw_spin_lock_irq_ops = {
> +	.writelock	= torture_raw_spin_lock_write_lock_irq,
> +	.write_delay	= torture_spin_lock_write_delay,
> +	.task_boost	= torture_rt_boost,
> +	.writeunlock	= torture_raw_spin_lock_write_unlock_irq,
> +	.readlock	= NULL,
> +	.read_delay	= NULL,
> +	.readunlock	= NULL,
> +	.name		= "raw_spin_lock_irq"
> +};
> +#endif
> +
>  static DEFINE_RWLOCK(torture_rwlock);
>  
>  static int torture_rwlock_write_lock(int tid __maybe_unused)
> @@ -1017,6 +1072,9 @@ static int __init lock_torture_init(void)
>  	static struct lock_torture_ops *torture_ops[] = {
>  		&lock_busted_ops,
>  		&spin_lock_ops, &spin_lock_irq_ops,
> +#ifdef CONFIG_PREEMPT_RT
> +		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
> +#endif
>  		&rw_lock_ops, &rw_lock_irq_ops,
>  		&mutex_lock_ops,
>  		&ww_mutex_lock_ops,
> -- 
> 2.25.1
> 
