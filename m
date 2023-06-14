Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4772F839
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbjFNIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjFNIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:47:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8961BF8;
        Wed, 14 Jun 2023 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zU7vTHGNGOkFDGHT4utTtg1onpxsh5x6oq5BFtksvGo=; b=O0pXasE2Kn5wmYU9m1T6l6fMbG
        at0qHfdy6UyepxXSgdmc1iFnPI/I4JVNrRgFni2pfrE/a7UB1xczcKCixSbQT/xVNE+z3NXpctRqZ
        H3gC9deJspth+OusfcDLWCrRQ+8ZOpnswLxjpOQCNXV7x9Mmks926o6PidaW+m8VouJmS03FUQ6FB
        /jf6nI581bwIIyZkgn0dO6SHZJZjhZt7Hv8qu3Dj/89vO5zYJ6cuNtUQa5t4e/SUBiwbZ0ZpGPyxU
        9Qu/OqNVoXuo7LLRIRrr2dpLrjE6gjx6YGZyhgJqnBAyvQ0U6uiEtF3jR5WWn16N3wH5eePpLKQ+h
        pHdhXRMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9MAB-005zdY-RS; Wed, 14 Jun 2023 08:47:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 137F73002F1;
        Wed, 14 Jun 2023 10:47:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2337327F86A50; Wed, 14 Jun 2023 10:47:34 +0200 (CEST)
Date:   Wed, 14 Jun 2023 10:47:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Saket Dumbre <saket.dumbre@intel.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: Re: [PATCH v1] ACPI: sleep: Avoid breaking S3 wakeup due to
 might_sleep()
Message-ID: <20230614084734.GD1639749@hirez.programming.kicks-ass.net>
References: <12237421.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12237421.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:25:07PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The addition of might_sleep() to down_timeout() caused the latter to
> enable interrupts unconditionally in some cases, which in turn broke
> the ACPI S3 wakeup path in acpi_suspend_enter(), where down_timeout()
> is called by acpi_disable_all_gpes() via acpi_ut_acquire_mutex().
> 
> Namely, if CONFIG_DEBUG_ATOMIC_SLEEP is set, might_sleep() causes
> might_resched() to be used and if CONFIG_PREEMPT_VOLUNTARY is set,
> this triggers __cond_resched() which may call preempt_schedule_common(),
> so __schedule() gets invoked and it ends up with enabled interrupts (in
> the prev == next case).

Urgh, so that code was relying on the lack of contention to not trigger
the schedule path -- with the added might_sleep() it triggers a
preemption point.

> Now, enabling interrupts early in the S3 wakeup path causes the kernel
> to crash.
> 
> Address this by modifying acpi_suspend_enter() to disable GPEs without
> attempting to acquire the sleeping lock which is not needed in that code
> path anyway.
> 
> Fixes: 99409b935c9a locking/semaphore: Add might_sleep() to down_*() family

$ git show -s --pretty='format:%h ("%s")' 99409b935c9a
99409b935c9a ("locking/semaphore: Add might_sleep() to down_*() family")

> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  drivers/acpi/acpica/achware.h |    2 --
>  drivers/acpi/sleep.c          |   16 ++++++++++++----
>  include/acpi/acpixf.h         |    1 +
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/achware.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/achware.h
> +++ linux-pm/drivers/acpi/acpica/achware.h
> @@ -101,8 +101,6 @@ acpi_status
>  acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
>  		       acpi_event_status *event_status);
>  
> -acpi_status acpi_hw_disable_all_gpes(void);
> -
>  acpi_status acpi_hw_enable_all_runtime_gpes(void);
>  
>  acpi_status acpi_hw_enable_all_wakeup_gpes(void);
> Index: linux-pm/include/acpi/acpixf.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpixf.h
> +++ linux-pm/include/acpi/acpixf.h
> @@ -761,6 +761,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
>  						     acpi_event_status
>  						     *event_status))
>  ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
> +ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -636,11 +636,19 @@ static int acpi_suspend_enter(suspend_st
>  	}
>  
>  	/*
> -	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
> -	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
> -	 * acpi_leave_sleep_state will reenable specific GPEs later
> +	 * Disable all GPE and clear their status bits before interrupts are
> +	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
> +	 * prevent them from producing spurious interrups.
> +	 *
> +	 * acpi_leave_sleep_state() will reenable specific GPEs later.
> +	 *
> +	 * Because this code runs on one CPU with disabled interrupts (all of
> +	 * the other CPUs are offline at that time), it need not acquire any
> +	 * sleeping locks which maybe harmful due to instrumentation even if
> +	 * those locks are not contended, so avoid doing that by using a low-
> +	 * level library routine here.

I'm not sure I'd call the implicit preemption point 'instrumentation'
but yeah, fair enough I suppose.

>  	 */
> -	acpi_disable_all_gpes();
> +	acpi_hw_disable_all_gpes();
>  	/* Allow EC transactions to happen. */
>  	acpi_ec_unblock_transactions();
>  
> 
> 
> 
