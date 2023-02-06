Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0F68C724
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBFT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBFT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D106144B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675713483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FyUsZK8EVzQm3fCHtXHZb4I8amJ+79/snuHSywdQXIU=;
        b=JjkhiwjSrT/gBRjoFEF+1HlejFCLa11stOFpZVWz66VaFuaLr7SP0mncMlR4l241SAYXTM
        mYb4+d3j2O9KAen21I+9RELx7/zjMsECgu8076UOh9JHKCkQrPZw+DZABqJAn4AC//atnO
        56Jxc5XWncI9FZs3aATES2tSGukCSak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-V6F6vkL8OXu7n5rdpiP4aQ-1; Mon, 06 Feb 2023 14:57:57 -0500
X-MC-Unique: V6F6vkL8OXu7n5rdpiP4aQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8445985D063;
        Mon,  6 Feb 2023 19:57:56 +0000 (UTC)
Received: from [10.22.18.235] (unknown [10.22.18.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2434492C3C;
        Mon,  6 Feb 2023 19:57:55 +0000 (UTC)
Message-ID: <82e4dae9-0aca-a06b-cb0d-5a189998cdc1@redhat.com>
Date:   Mon, 6 Feb 2023 14:57:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PATCH v2 clocksource 8/7] clocksource: Enable TSC watchdog
 checking of HPET and PMTMR only when requested
Content-Language: en-US
To:     paulmck@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230203043658.GA1513624@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230203043658.GA1513624@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 23:36, Paul E. McKenney wrote:
> Unconditionally enabling TSC watchdog checking of the HPET and PMTMR
> clocksources can degrade latency and performance.  Therefore, provide
> a new "watchdog" option to the tsc= boot parameter that opts into such
> checking.  Note that tsc=watchdog is overridden by a tsc=nowatchdog
> regardless of their relative positions in the list of boot parameters.
>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 95f0d104c2322..7b4df6d89d3c3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6373,6 +6373,12 @@
>   			(HPET or PM timer) on systems whose TSC frequency was
>   			obtained from HW or FW using either an MSR or CPUID(0x15).
>   			Warn if the difference is more than 500 ppm.
> +			[x86] watchdog: Use TSC as the watchdog clocksource with
> +			which to check other HW timers (HPET or PM timer), but
> +			only on systems where TSC has been deemed trustworthy.
> +			This will be suppressed by an earlier tsc=nowatchdog and
> +			can be overridden by a later tsc=nowatchdog.  A console
> +			message will flag any such suppression or overriding.
>   
>   	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
>   			value instead. Useful when the early TSC frequency discovery
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index a5371c6d4b64b..306c233c98d84 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -294,6 +294,7 @@ __setup("notsc", notsc_setup);
>   
>   static int no_sched_irq_time;
>   static int no_tsc_watchdog;
> +static int tsc_as_watchdog;
>   
>   static int __init tsc_setup(char *str)
>   {
> @@ -303,10 +304,22 @@ static int __init tsc_setup(char *str)
>   		no_sched_irq_time = 1;
>   	if (!strcmp(str, "unstable"))
>   		mark_tsc_unstable("boot parameter");
> -	if (!strcmp(str, "nowatchdog"))
> +	if (!strcmp(str, "nowatchdog")) {
>   		no_tsc_watchdog = 1;
> +		if (tsc_as_watchdog)
> +			pr_alert("%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
> +				 __func__);
> +		tsc_as_watchdog = 0;
> +	}
>   	if (!strcmp(str, "recalibrate"))
>   		tsc_force_recalibrate = 1;
> +	if (!strcmp(str, "watchdog")) {
> +		if (no_tsc_watchdog)
> +			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
> +				 __func__);
> +		else
> +			tsc_as_watchdog = 1;
> +	}
>   	return 1;
>   }
>   
> @@ -1192,7 +1205,8 @@ static void __init tsc_disable_clocksource_watchdog(void)
>   
>   bool tsc_clocksource_watchdog_disabled(void)
>   {
> -	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
> +	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
> +	       tsc_as_watchdog && !no_tsc_watchdog;
>   }
>   
>   static void __init check_system_tsc_reliable(void)
>
Acked-by: Waiman Long <longman@redhat.com>

