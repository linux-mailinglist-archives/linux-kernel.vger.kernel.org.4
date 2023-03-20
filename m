Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136D6C2309
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCTUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCTUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:41:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657C1C7C4;
        Mon, 20 Mar 2023 13:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F034B810AD;
        Mon, 20 Mar 2023 20:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0252EC433D2;
        Mon, 20 Mar 2023 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679344872;
        bh=fZCL0doA7yayYO78Wg/lUeTnh50eVpPpkctOO0bSVLE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aZUpF4XCOCcxLONoTV8+XTagJjXMsheTc2++kUeUruIm47ELj3OC9LG56KlKZouBQ
         zTRe1p4dkx50cp73HtfrC+XRM2fsVVXMfzG+u/dEevxcqjA8fpN8MpfqU6gZhJG8zP
         u90rhyabz8Zq6Fs2XCph2DMi04ynNTE4IFNyDYKZyoa1m7KAvAP4pZJ+33vYvgSpAH
         RcuMEMte2BnFnmYkdQfe5dWDwSXQpZNak6yz25nZilOy7IImT4Tj7LxNNSK8oRF97R
         oc7CRM8zmlIQCACkbAQ11wueRwlt8DAgTPxpK8Yg8CpJdr18bC4Oi5hh27CcpNeL/Y
         E0dKw2d/iopbg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 838A91540395; Mon, 20 Mar 2023 13:41:11 -0700 (PDT)
Date:   Mon, 20 Mar 2023 13:41:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <d93c68a1-5c36-4e48-ab41-c424d903d30d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2bbaa13a-bfcc-45b7-acce-8da59a2a0c32@paulmck-laptop>
 <20230317055006.46365-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317055006.46365-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:50:06PM +0800, Qiuxu Zhuo wrote:
> When running the 'kfree_rcu_test' test case with commands [1] the call
> trace [2] was thrown. This was because the kfree_scale_thread thread(s)
> still run after unloading rcuscale and torture modules. Fix the call
> trace by invoking kfree_scale_cleanup() from rcu_scale_cleanup() when
> removing the rcuscale module.
> 
> Additionally, current rcuscale.c defines kfree_scale_cleanup() after
> rcu_scale_cleanup(), to avoid the declaration of kfree_scale_cleanup()
> when rcu_scale_cleanup() invoking kfree_scale_cleanup(), move
> rcu_scale_cleanup() after kfree_scale_cleanup().
> 
> [1] modprobe rcuscale kfree_rcu_test=1
>     // After some time
>     rmmod rcuscale
>     rmmod torture
> 
> [2] BUG: unable to handle page fault for address: ffffffffc0601a87
>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page
>     PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
>     Oops: 0010 [#1] PREEMPT SMP NOPTI
>     CPU: 1 PID: 1798 Comm: kfree_scale_thr Not tainted 6.3.0-rc1-rcu+ #1
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>     RIP: 0010:0xffffffffc0601a87
>     Code: Unable to access opcode bytes at 0xffffffffc0601a5d.
>     RSP: 0018:ffffb25bc2e57e18 EFLAGS: 00010297
>     RAX: 0000000000000000 RBX: ffffffffc061f0b6 RCX: 0000000000000000
>     RDX: 0000000000000000 RSI: ffffffff962fd0de RDI: ffffffff962fd0de
>     RBP: ffffb25bc2e57ea8 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
>     R13: 0000000000000000 R14: 000000000000000a R15: 00000000001c1dbe
>     FS:  0000000000000000(0000) GS:ffff921fa2200000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffc0601a5d CR3: 000000011de4c006 CR4: 0000000000370ee0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      ? kvfree_call_rcu+0xf0/0x3a0
>      ? kthread+0xf3/0x120
>      ? kthread_complete_and_exit+0x20/0x20
>      ? ret_from_fork+0x1f/0x30
>      </TASK>
>     Modules linked in: rfkill sunrpc ... [last unloaded: torture]
>     CR2: ffffffffc0601a87
>     ---[ end trace 0000000000000000 ]---
> 
> Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Much better!

Except that someone glancing at this patch would be hard pressed to
see what changed.

So could you please split this into two patches, the first of which
does nothing but move code, and the second of which makes the actual
change?

The commit log for the first patch needs to clearly state that the
it is code-motion-only, with no change in behavior.

							Thanx, Paul

> ---
> v1 -> v2:
> 
>  - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate the
>    declaration of kfree_scale_cleanup().
> 
>  - Remove the unnecessary step "modprobe torture" from the commit message.
> 
>  - Add the description for why move rcu_scale_cleanup() after
>    kfree_scale_cleanup() to the commit message.
> 
> Thanks Paul's comments on eliminating the extra function declaration and
> removing the unnecessary "modprobe torture" from the commit message. 
> 
> Thanks Joel's constructive comments that for long-term maintenance we may
> need to split out the common code within current {ref,rcu}scale.c files.
> 
>  kernel/rcu/rcuscale.c | 201 ++++++++++++++++++++++--------------------
>  1 file changed, 103 insertions(+), 98 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 91fb5905a008..5a000d26f03e 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -522,89 +522,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
>  		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
>  }
>  
> -static void
> -rcu_scale_cleanup(void)
> -{
> -	int i;
> -	int j;
> -	int ngps = 0;
> -	u64 *wdp;
> -	u64 *wdpp;
> -
> -	/*
> -	 * Would like warning at start, but everything is expedited
> -	 * during the mid-boot phase, so have to wait till the end.
> -	 */
> -	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> -		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
> -	if (rcu_gp_is_normal() && gp_exp)
> -		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
> -	if (gp_exp && gp_async)
> -		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
> -
> -	if (torture_cleanup_begin())
> -		return;
> -	if (!cur_ops) {
> -		torture_cleanup_end();
> -		return;
> -	}
> -
> -	if (reader_tasks) {
> -		for (i = 0; i < nrealreaders; i++)
> -			torture_stop_kthread(rcu_scale_reader,
> -					     reader_tasks[i]);
> -		kfree(reader_tasks);
> -	}
> -
> -	if (writer_tasks) {
> -		for (i = 0; i < nrealwriters; i++) {
> -			torture_stop_kthread(rcu_scale_writer,
> -					     writer_tasks[i]);
> -			if (!writer_n_durations)
> -				continue;
> -			j = writer_n_durations[i];
> -			pr_alert("%s%s writer %d gps: %d\n",
> -				 scale_type, SCALE_FLAG, i, j);
> -			ngps += j;
> -		}
> -		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
> -			 scale_type, SCALE_FLAG,
> -			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
> -			 t_rcu_scale_writer_finished -
> -			 t_rcu_scale_writer_started,
> -			 ngps,
> -			 rcuscale_seq_diff(b_rcu_gp_test_finished,
> -					   b_rcu_gp_test_started));
> -		for (i = 0; i < nrealwriters; i++) {
> -			if (!writer_durations)
> -				break;
> -			if (!writer_n_durations)
> -				continue;
> -			wdpp = writer_durations[i];
> -			if (!wdpp)
> -				continue;
> -			for (j = 0; j < writer_n_durations[i]; j++) {
> -				wdp = &wdpp[j];
> -				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
> -					scale_type, SCALE_FLAG,
> -					i, j, *wdp);
> -				if (j % 100 == 0)
> -					schedule_timeout_uninterruptible(1);
> -			}
> -			kfree(writer_durations[i]);
> -		}
> -		kfree(writer_tasks);
> -		kfree(writer_durations);
> -		kfree(writer_n_durations);
> -	}
> -
> -	/* Do torture-type-specific cleanup operations.  */
> -	if (cur_ops->cleanup != NULL)
> -		cur_ops->cleanup();
> -
> -	torture_cleanup_end();
> -}
> -
>  /*
>   * Return the number if non-negative.  If -1, the number of CPUs.
>   * If less than -1, that much less than the number of CPUs, but
> @@ -624,21 +541,6 @@ static int compute_real(int n)
>  	return nr;
>  }
>  
> -/*
> - * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
> - * down system.
> - */
> -static int
> -rcu_scale_shutdown(void *arg)
> -{
> -	wait_event(shutdown_wq,
> -		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
> -	smp_mb(); /* Wake before output. */
> -	rcu_scale_cleanup();
> -	kernel_power_off();
> -	return -EINVAL;
> -}
> -
>  /*
>   * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs for number
>   * of iterations and measure total time and number of GP for all iterations to complete.
> @@ -875,6 +777,109 @@ kfree_scale_init(void)
>  	return firsterr;
>  }
>  
> +static void
> +rcu_scale_cleanup(void)
> +{
> +	int i;
> +	int j;
> +	int ngps = 0;
> +	u64 *wdp;
> +	u64 *wdpp;
> +
> +	/*
> +	 * Would like warning at start, but everything is expedited
> +	 * during the mid-boot phase, so have to wait till the end.
> +	 */
> +	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
> +		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
> +	if (rcu_gp_is_normal() && gp_exp)
> +		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
> +	if (gp_exp && gp_async)
> +		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
> +
> +	if (kfree_rcu_test) {
> +		kfree_scale_cleanup();
> +		return;
> +	}
> +
> +	if (torture_cleanup_begin())
> +		return;
> +	if (!cur_ops) {
> +		torture_cleanup_end();
> +		return;
> +	}
> +
> +	if (reader_tasks) {
> +		for (i = 0; i < nrealreaders; i++)
> +			torture_stop_kthread(rcu_scale_reader,
> +					     reader_tasks[i]);
> +		kfree(reader_tasks);
> +	}
> +
> +	if (writer_tasks) {
> +		for (i = 0; i < nrealwriters; i++) {
> +			torture_stop_kthread(rcu_scale_writer,
> +					     writer_tasks[i]);
> +			if (!writer_n_durations)
> +				continue;
> +			j = writer_n_durations[i];
> +			pr_alert("%s%s writer %d gps: %d\n",
> +				 scale_type, SCALE_FLAG, i, j);
> +			ngps += j;
> +		}
> +		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
> +			 scale_type, SCALE_FLAG,
> +			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
> +			 t_rcu_scale_writer_finished -
> +			 t_rcu_scale_writer_started,
> +			 ngps,
> +			 rcuscale_seq_diff(b_rcu_gp_test_finished,
> +					   b_rcu_gp_test_started));
> +		for (i = 0; i < nrealwriters; i++) {
> +			if (!writer_durations)
> +				break;
> +			if (!writer_n_durations)
> +				continue;
> +			wdpp = writer_durations[i];
> +			if (!wdpp)
> +				continue;
> +			for (j = 0; j < writer_n_durations[i]; j++) {
> +				wdp = &wdpp[j];
> +				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
> +					scale_type, SCALE_FLAG,
> +					i, j, *wdp);
> +				if (j % 100 == 0)
> +					schedule_timeout_uninterruptible(1);
> +			}
> +			kfree(writer_durations[i]);
> +		}
> +		kfree(writer_tasks);
> +		kfree(writer_durations);
> +		kfree(writer_n_durations);
> +	}
> +
> +	/* Do torture-type-specific cleanup operations.  */
> +	if (cur_ops->cleanup != NULL)
> +		cur_ops->cleanup();
> +
> +	torture_cleanup_end();
> +}
> +
> +/*
> + * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
> + * down system.
> + */
> +static int
> +rcu_scale_shutdown(void *arg)
> +{
> +	wait_event(shutdown_wq,
> +		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
> +	smp_mb(); /* Wake before output. */
> +	rcu_scale_cleanup();
> +	kernel_power_off();
> +	return -EINVAL;
> +}
> +
>  static int __init
>  rcu_scale_init(void)
>  {
> -- 
> 2.17.1
> 
