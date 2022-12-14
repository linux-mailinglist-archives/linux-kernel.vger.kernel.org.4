Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650D364CB69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbiLNNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiLNNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:33:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49F25294
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:33:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4465B818BF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F6FC43332;
        Wed, 14 Dec 2022 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671024785;
        bh=pgq56pmJqqIVUdDDmdTZvjimbzCmSvIS6vFQXH1iDe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp95v2iTs3ZfzAJUGHlUUIR5CoSDV1/wazuzI3W1ThIJDliqJJ57EiBpic2y4Pl8H
         7u15iFp4GHluRmVk3LCOFGGLVvTvGVRMriKwtjhoZJ7spggCDrZxtk+xGnrxHG+xTq
         JLY2FPLl7x36mbOOYSIRdw4v8kU+O2ZIc9Z+Wgx18QF/Dl7iWGlk+swxrOnTuQ2q5O
         JhgNoU4ABB6g8uS1RrQYOkexXo4PJnHykNfyB+f7xGY2fW/QGUfQqG1LJmpnWQcQma
         rA8pu/Ek8vYx5bGVeQzUkxWQicQ3aj57oxvsqPZ6nwKXWyEk/Hrgzu/QGCXuMj3V4r
         wrPHmjrmNGXMQ==
Date:   Wed, 14 Dec 2022 14:33:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 3/5] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <20221214133302.GA1931356@lothringen>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.474800121@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206162416.474800121@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:18:29PM -0300, Marcelo Tosatti wrote:
>  static inline void vmstat_mark_dirty(void)
>  {
> +	int cpu = smp_processor_id();
> +
> +	if (tick_nohz_full_cpu(cpu) && !this_cpu_read(vmstat_dirty)) {
> +		struct delayed_work *dw;
> +
> +		dw = &per_cpu(vmstat_work, cpu);
> +		if (!delayed_work_pending(dw)) {
> +			unsigned long delay;
> +
> +			delay = round_jiffies_relative(sysctl_stat_interval);
> +			queue_delayed_work_on(cpu, mm_percpu_wq, dw, delay);

Currently the vmstat_work is flushed on cpu_hotplug (CPUHP_AP_ONLINE_DYN).
vmstat_shepherd makes sure to not rearm it afterward. But now it looks
possible for the above to do that mistake?

> +		}
> +	}
>  	this_cpu_write(vmstat_dirty, true);
>  }
> @@ -2009,6 +2028,10 @@ static void vmstat_shepherd(struct work_
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
>  
> +		/* NOHZ full CPUs manage their own vmstat flushing */
> +		if (tick_nohz_full_cpu(smp_processor_id()))

It should be the remote CPU instead of the current one.

Thanks.

> +			continue;
> +
>  		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
>  
