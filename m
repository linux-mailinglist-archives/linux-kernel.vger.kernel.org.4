Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA46A26F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBYDc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYDc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:32:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE08E071;
        Fri, 24 Feb 2023 19:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f2AKBKkdBLeIonwV3elXwQM13Y/CSsTgvL07ch5T5U0=; b=WkhCL4ndxa19z6cw1rvCW4JK4Z
        QciAIFmHbC4QV2awHRTgpuy71ryHe0xCvyt35R7FImRNQD9UG4Mf53u8IQUtUD55j09YHS1HUm2pY
        MXGnUWv3qp5DPGgCKY3dIknwjNC9PnGfHplzNG9Hr2xYORRpaCDzlgcMwU25mereIi+0GeGrRPXXk
        nGso1zvKPD1vqeYa58AmakqY40ppIfG3brzW9+whpWizkyOCzvhhN8UgaUpYC7D+vaDzoQMxYGFUb
        kkQAcNp5KOSV5/mTuFRlDhuxB5ARjX3/o6N5KBUW8prB8xyUq2/ig3dqsDhn/w1VTiLnVlDHutLs2
        xiEIdEIg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVlIN-004jma-Ja; Sat, 25 Feb 2023 03:32:23 +0000
Message-ID: <ea03e810-95f0-abd8-2a83-f83174a99dbf@infradead.org>
Date:   Fri, 24 Feb 2023 19:32:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH RFC] rcu: Add a minimum time for marking boot as completed
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
References: <20230225032716.3320124-1-joel@joelfernandes.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230225032716.3320124-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/24/23 19:27, Joel Fernandes (Google) wrote:
> On many systems, a great deal of boot happens after the kernel thinks the boot
> has completed. It is difficult to determine if the system has really booted
> from the kernel side. Some features like lazy-RCU can risk slowing down boot
> time if, say, a callback has been added that the boot synchronously depends on.
> 
> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> stay expedited for as long as the system is still booting.
> 
> For these reasons, this commit adds a config option
> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
> 
> By default, this value is 20s. A system designer can choose to specify a value
> here to keep RCU from marking boot completion.  The boot sequence will not be
> marked ended until at least boot_end_delay milliseconds have passed.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +++
>  kernel/rcu/Kconfig                            | 12 +++++++++
>  kernel/rcu/update.c                           | 25 +++++++++++++++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2429b5e3184b..0943139fdf01 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5085,6 +5085,10 @@
>  	rcutorture.verbose= [KNL]
>  			Enable additional printk() statements.
>  
> +	rcupdate.boot_end_delay= [KNL]

Tell units:

> +			Minimum time that must elapse before the boot

+			Minimum time in milliseconds that must elapse before the boot

> +			sequence can be marked as completed.
> +
>  	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
>  			Dump ftrace buffer after reporting RCU CPU
>  			stall warning.
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 9071182b1284..1033a38bddad 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -217,6 +217,18 @@ config RCU_BOOST_DELAY
>  
>  	  Accept the default if unsure.
>  
> +config RCU_BOOT_END_DELAY
> +	int "Minimum delay before RCU considers boot has completed"
> +	range 0 120000
> +	default 20000
> +	help
> +	  This option specifies the minmum time since boot before which

tpyo:	                            minimum

> +	  RCU believes the system is booted. The actual delay can be
> +	  higher than this if the kernel takes a long time to initialize
> +	  but it will never be smaller than this.

+	  Specified in milliseconds.

> +
> +	  Accept the default if unsure.
> +
>  config RCU_EXP_KTHREAD
>  	bool "Perform RCU expedited work in a real-time kthread"
>  	depends on RCU_BOOST && RCU_EXPERT
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 19bf6fa3ee6a..5b73341d9b89 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -62,6 +62,10 @@ module_param(rcu_normal_after_boot, int, 0444);
>  #endif
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
> +/* Minimum time until RCU considers boot as completed. */
> +static int boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
> +module_param(boot_end_delay, int, 0444);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  /**
>   * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
> @@ -225,12 +229,29 @@ void rcu_unexpedite_gp(void)
>  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
>  
>  static bool rcu_boot_ended __read_mostly;
> -
>  /*
> - * Inform RCU of the end of the in-kernel boot sequence.
> + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
> + * not be marked ended until at least boot_end_delay milliseconds have passed.
>   */
> +void rcu_end_inkernel_boot(void);
> +static void boot_rcu_work_fn(struct work_struct *work)
> +{
> +	rcu_end_inkernel_boot();
> +}
> +static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
> +
>  void rcu_end_inkernel_boot(void)
>  {
> +	if (boot_end_delay) {
> +		u64 boot_ms = ktime_get_boot_fast_ns() / 1000000UL;

Is that division OK on 32-bit?  Might have to use a helper macro. (I dunno.)

> +
> +		if (boot_ms < boot_end_delay) {
> +			schedule_delayed_work(&boot_rcu_work,
> +					boot_end_delay - boot_ms);
> +			return;
> +		}
> +	}
> +
>  	rcu_unexpedite_gp();
>  	rcu_async_relax();
>  	if (rcu_normal_after_boot)

-- 
~Randy
