Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC915FFB16
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJOPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJOPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:47:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363644E62E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hyrj6Kbo8xaGb6CEwaXSzDHQWpo/ZYbBLKOnw+l7S7Q=; b=LIA+s/5cZydKNFKN2L3E5hO5PZ
        +kMaqXzitTomqcF4lcjlJ4GOmeMp6dJsVn+fbpAjBccQZQ1JkGUyzb0V+y9YuxTjpzTGGlbt2EOT4
        fd6ow6hWQ6hh1VNmsI9xQmnmnd9f75yvsZd0+A3Q9lUI6Hr5tbB9+5n4lSRj/yGsvyuYmOyyzkgxs
        gxWborZEpQR+J5VZhri/8XO/pyQoSkeg+dQKdCvBUSAgu4l2fU8l4bFStimmm384XVKMqe7EX58I5
        ZpJi22Eidk3UhZH/rjZ5tyJPLad3Q7NILDZ7eCh7qC3Z28Dvq97LMtutu2wU7ayIptIuaaF1iTbXK
        HZiz7LIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojjNi-003iZq-R4; Sat, 15 Oct 2022 15:47:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62436300165;
        Sat, 15 Oct 2022 17:47:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B732201FD2EC; Sat, 15 Oct 2022 17:47:22 +0200 (CEST)
Date:   Sat, 15 Oct 2022 17:47:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0rWCvz69XT+Vx/l@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-8-connoro@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:44:57PM +0000, Connor O'Brien wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 532362fcfe31..a341b9755a57 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -922,6 +922,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>  	  machine.
>  
> +config PROXY_EXEC
> +	bool "Proxy Execution"
> +	default n
> +	help
> +	  This option enables proxy execution, a mechanism for mutex owning
> +	  tasks to inherit the scheduling context of higher priority waiters.
> +

I tihnk the way you have it here you should add something like:

	depends on !SCHED_CORE
