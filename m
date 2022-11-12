Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB3626AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiKLQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:55:13 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C3E44
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 08:54:55 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d8so1853403qki.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 08:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hraU6DavAv/OWYW8yya1aO+dvV0RLHvHKMFzF5tyCpI=;
        b=sF14r4gr7Rfsa5jIETwbsJIHmxlLNsTNWfuqzgjtFZ7s7ATC7UZDYDjRaGHTyYJDiR
         bnR02OUYvRftYWJh1z4SihAYjyRuWZXQjMaQ4gKDi6nKTaRyfOLAEM1rtnKewDnA1ajd
         zUswt0Qk2++V9tyAFrJpiUkj3/BI2jp52QmSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hraU6DavAv/OWYW8yya1aO+dvV0RLHvHKMFzF5tyCpI=;
        b=JSTAhDQZuvcE6WpVDgxAKwBVLt1w53A32SKvviB0dYRbT+VWinRuBIf9FqEvyGPl5B
         M5PJYLtR17s/dsBpznestcklmh9DkUgiIXbBV5HHOEnET/e0Gk8BUm/HAsO5cnMmfjoC
         NIdaLYSpkoay22QYSF6PSMZCyqZgcNTZHNBiGtL+ziPonhG3q/9AT3HcDgK6Ue0+P/Lo
         zd21hSY0DDJRMw7MVYwOtFDlPWUX2kJ9jGFN6f3kAMSoqUw3T5Sk+9ckthNHyuacfTsT
         TqXBTBfPY9PRvx9RhMu5edq3zkqMSUgfUBxu0NbLhaIs4qSbN6yJ1zXFfHJKMK1bojws
         XCOQ==
X-Gm-Message-State: ANoB5plyZUhh739oKACiUzjwEwvfMptWSetCfi/w4Yg1iS4UFFytTR/J
        fJ5bm9CVXQAxED4ZeoKKfYHqDQ==
X-Google-Smtp-Source: AA0mqf40CandDrt14rDk7wWwrxjEmzJtU5tLUuJONlbA/5/IlXZfiU6q+yr38eTSOLEICUJDb1LmtA==
X-Received: by 2002:a37:6446:0:b0:6fa:16f2:7f57 with SMTP id y67-20020a376446000000b006fa16f27f57mr5387628qkb.221.1668272094772;
        Sat, 12 Nov 2022 08:54:54 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a441600b006faac3c33b8sm3534120qkp.27.2022.11.12.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:54:54 -0800 (PST)
Date:   Sat, 12 Nov 2022 16:54:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 10/11] torture: support randomized shuffling for
 proxy exec testing
Message-ID: <Y2/P3cMExRt2fUP5@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-11-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-11-connoro@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:45:00PM +0000, Connor O'Brien wrote:
> Quick hack to better surface bugs in proxy execution.
> 
> Shuffling sets the same cpu affinities for all tasks, which makes us
> less likely to hit paths involving migrating blocked tasks onto a cpu
> where they can't run. Add an element of randomness to allow affinities
> of different writer tasks to diverge.
> 
> Signed-off-by: Connor O'Brien <connoro@google.com>
> ---
>  kernel/torture.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 789aeb0e1159..1d0dd88369e3 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -54,6 +54,9 @@ module_param(verbose_sleep_frequency, int, 0444);
>  static int verbose_sleep_duration = 1;
>  module_param(verbose_sleep_duration, int, 0444);
>  
> +static int random_shuffle;
> +module_param(random_shuffle, int, 0444);
> +
>  static char *torture_type;
>  static int verbose;
>  
> @@ -518,6 +521,7 @@ static void torture_shuffle_task_unregister_all(void)
>   */
>  static void torture_shuffle_tasks(void)
>  {
> +	DEFINE_TORTURE_RANDOM(rand);
>  	struct shuffle_task *stp;
>  
>  	cpumask_setall(shuffle_tmp_mask);
> @@ -537,8 +541,10 @@ static void torture_shuffle_tasks(void)
>  		cpumask_clear_cpu(shuffle_idle_cpu, shuffle_tmp_mask);
>  
>  	mutex_lock(&shuffle_task_mutex);
> -	list_for_each_entry(stp, &shuffle_task_list, st_l)
> -		set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
> +	list_for_each_entry(stp, &shuffle_task_list, st_l) {
> +		if (!random_shuffle || torture_random(&rand) & 0x1)
> +			set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
> +	}
>  	mutex_unlock(&shuffle_task_mutex);

Instead of doing it this way, maybe another approach is to randomize the
sleep interval in:

 */
static int torture_shuffle(void *arg)
{
	VERBOSE_TOROUT_STRING("torture_shuffle task started");
	do {
		schedule_timeout_interruptible(shuffle_interval);
		torture_shuffle_tasks();
		...
	} while (...)
	...
}

Right now with this patch you still wakeup the shuffle thread when skipping
the affinity set operation.

thanks,

 - Joel

