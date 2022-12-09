Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC4648995
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLIUgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLIUf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:35:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3DBA0F8C;
        Fri,  9 Dec 2022 12:35:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77C2BB82910;
        Fri,  9 Dec 2022 20:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43800C433EF;
        Fri,  9 Dec 2022 20:35:54 +0000 (UTC)
Date:   Fri, 9 Dec 2022 15:35:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/3] tracing/osnoise: Add preempt and/or irq disabled
 options
Message-ID: <20221209153552.4c7099cd@gandalf.local.home>
In-Reply-To: <ded51c4490cf0cdce4e73e448c77bef9c35d257b.1669832184.git.bristot@kernel.org>
References: <cover.1669832184.git.bristot@kernel.org>
        <ded51c4490cf0cdce4e73e448c77bef9c35d257b.1669832184.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 19:19:10 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:


Hi Daniel,

As I was adding this series, I noticed an issue that needs to be fixed.

>  static int run_osnoise(void)
>  {
> +	bool irq_disable = test_bit(OSN_IRQ_DISABLE, &osnoise_options);
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
>  	u64 start, sample, last_sample;
>  	u64 last_int_count, int_count;
> @@ -1315,11 +1323,18 @@ static int run_osnoise(void)
>  	s64 total, last_total = 0;
>  	struct osnoise_sample s;
>  	unsigned int threshold;
> +	bool preempt_disable;

Let's use a different name for the above variable.

>  	u64 runtime, stop_in;
>  	u64 sum_noise = 0;
>  	int hw_count = 0;
>  	int ret = -1;
>  
> +	/*
> +	 * Disabling preemption is only required if IRQs are enabled,
> +	 * and the options is set on.
> +	 */
> +	preempt_disable = !irq_disable && test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);
> +
>  	/*
>  	 * Considers the current thread as the workload.
>  	 */
> @@ -1335,6 +1350,15 @@ static int run_osnoise(void)
>  	 */
>  	threshold = tracing_thresh ? : 5000;
>  
> +	/*
> +	 * Apply PREEMPT and IRQ disabled options.
> +	 */
> +	if (irq_disable)
> +		local_irq_disable();
> +
> +	if (preempt_disable)
> +		preempt_disable();
> +

The only reason the above works is because preempt_disable() is a macro.
If it was a function, then it would likely fail to build (as you are
overriding the name with a bool variable).

-- Steve
