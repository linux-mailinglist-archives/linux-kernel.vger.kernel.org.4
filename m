Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181065F6E03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiJFTPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiJFTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:15:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB1C14A5;
        Thu,  6 Oct 2022 12:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44E33B82151;
        Thu,  6 Oct 2022 19:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F240FC433D6;
        Thu,  6 Oct 2022 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665083724;
        bh=2Rb22sqCVOue+2CDUKhBoocJ1gJtBZSd+uSjELNizL4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t3WfBRPpw8f67f5/QZqxhXsXCpqWgsm0cffOwxQwhUdfXaHB2heZjvY5RGS7yyiCr
         INjn3hVlLYjJA12yHIsqquoA6ZjQ/CJ+87tAuCc1atwxYyt8c/TpdmdWnXb6P3/NcT
         5cElIAECRkmcrpmQgru984yCsfZhfVqGJp0SLSce1TOEe1LLU0WNL1cXyemvH9ED3B
         sBWFvWf0HeryeR+e/2oAE8QuPTYOV5/iC6rzyyiVpLSQBXpPhcCpK+WDTp2aX43jkV
         33K/bSRAoLsFctB1EIv4xrROEUWv5BLkp41m1nN3JzeIg5YjUW+G8KFIiGJrPlK3Ym
         k+olwcMwz3yEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A1385C0F66; Thu,  6 Oct 2022 12:15:23 -0700 (PDT)
Date:   Thu, 6 Oct 2022 12:15:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 05/11] rcuscale: Add laziness and kfree tests
Message-ID: <20221006191523.GE4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-6-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:51AM +0000, Joel Fernandes (Google) wrote:
> We add 2 tests to rcuscale, first one is a startup test to check whether
> we are not too lazy or too hard working. Two, emulate kfree_rcu() itself
> to use call_rcu() and check memory pressure. In my testing, the new
> call_rcu() does well to keep memory pressure under control, similar
> to kfree_rcu().
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcuscale.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 3ef02d4a8108..027b7c1e7613 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
>  torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> +torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
>  
>  static char *scale_type = "rcu";
>  module_param(scale_type, charp, 0444);
> @@ -659,6 +660,14 @@ struct kfree_obj {
>  	struct rcu_head rh;
>  };
>  
> +/* Used if doing RCU-kfree'ing via call_rcu(). */
> +static void kfree_call_rcu(struct rcu_head *rh)
> +{
> +	struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
> +
> +	kfree(obj);
> +}
> +
>  static int
>  kfree_scale_thread(void *arg)
>  {
> @@ -696,6 +705,11 @@ kfree_scale_thread(void *arg)
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> +			if (kfree_by_call_rcu) {
> +				call_rcu(&(alloc_ptr->rh), kfree_call_rcu);
> +				continue;
> +			}
> +
>  			// By default kfree_rcu_test_single and kfree_rcu_test_double are
>  			// initialized to false. If both have the same value (false or true)
>  			// both are randomly tested, otherwise only the one with value true
> @@ -767,11 +781,58 @@ kfree_scale_shutdown(void *arg)
>  	return -EINVAL;
>  }
>  
> +// Used if doing RCU-kfree'ing via call_rcu().
> +static unsigned long jiffies_at_lazy_cb;
> +static struct rcu_head lazy_test1_rh;
> +static int rcu_lazy_test1_cb_called;
> +static void call_rcu_lazy_test1(struct rcu_head *rh)
> +{
> +	jiffies_at_lazy_cb = jiffies;
> +	WRITE_ONCE(rcu_lazy_test1_cb_called, 1);
> +}
> +
>  static int __init
>  kfree_scale_init(void)
>  {
>  	long i;
>  	int firsterr = 0;
> +	unsigned long orig_jif, jif_start;

Separate lines in alphabetic order, please.

> +
> +	// Also, do a quick self-test to ensure laziness is as much as
> +	// expected.
> +	if (kfree_by_call_rcu && !IS_ENABLED(CONFIG_RCU_LAZY)) {
> +		pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() "
> +			 "for delayed RCU kfree'ing\n");
> +		kfree_by_call_rcu = 0;
> +	}
> +
> +	if (kfree_by_call_rcu) {
> +		/* do a test to check the timeout. */
> +		orig_jif = rcu_lazy_get_jiffies_till_flush();
> +
> +		rcu_lazy_set_jiffies_till_flush(2 * HZ);
> +		rcu_barrier();
> +
> +		jif_start = jiffies;
> +		jiffies_at_lazy_cb = 0;
> +		call_rcu(&lazy_test1_rh, call_rcu_lazy_test1);
> +
> +		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
> +
> +		rcu_lazy_set_jiffies_till_flush(orig_jif);
> +
> +		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
> +			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
> +			WARN_ON_ONCE(1);
> +			return -1;
> +		}
> +
> +		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
> +			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
> +			WARN_ON_ONCE(1);

I am concerned about false positives for this, and especially about false
negatives given other activity in the system.

But let's give it a shot and see how it does.

							Thanx, Paul

> +			return -1;
> +		}
> +	}
>  
>  	kfree_nrealthreads = compute_real(kfree_nthreads);
>  	/* Start up the kthreads. */
> @@ -784,7 +845,9 @@ kfree_scale_init(void)
>  		schedule_timeout_uninterruptible(1);
>  	}
>  
> -	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
> +	pr_alert("kfree object size=%zu, kfree_by_call_rcu=%d\n",
> +			kfree_mult * sizeof(struct kfree_obj),
> +			kfree_by_call_rcu);
>  
>  	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
>  			       GFP_KERNEL);
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
