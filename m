Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8574E840
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGKHmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGKHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:42:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCB1A2;
        Tue, 11 Jul 2023 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XtqhhCxrscYtAF+o0y3E3eFRGgnUA7fzd0enBwWepxU=; b=MQgQgqxoay5mhCv5KD37I/giKm
        MWeK1ixJjh5CZPTJHP841zcuEHc00GrF5vNJQK4pNI+WMP33z7lk0uQpXB+DedAwcQBT1CuAnjFUF
        Q/mCkvAMNBM9PdshGsOnToHAnYa7L0OagLT56mhJmmhk1NQbbUvumljxCV2rhWHPdySD8LFcczGxm
        zJaYHUUff3h/73uoamrGoclf36wn0pfv4ea/8/Rv4E0z75LEyOE1LfNjgoXi3mfn1FNmfzjwzDnKa
        L0lMGc+fk5xhPVu17MSotNCoPMNQ9/yd07Gx9I6I6FlAmRzeLKAd+C4BDOSdlSMnGbhXW9uFMv4My
        ahaxyyTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ813-002IBT-0B;
        Tue, 11 Jul 2023 07:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0279B30014A;
        Tue, 11 Jul 2023 09:42:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCB9B240EBDBA; Tue, 11 Jul 2023 09:42:31 +0200 (CEST)
Date:   Tue, 11 Jul 2023 09:42:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kazuki Hashimoto <kazukih0205@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/2] cpuidle: Don't pass any values to
 cpuidle_not_available
Message-ID: <20230711074231.GD3062772@hirez.programming.kicks-ass.net>
References: <20230711-cpuidle-v1-0-f391224b3140@gmail.com>
 <20230711-cpuidle-v1-1-f391224b3140@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711-cpuidle-v1-1-f391224b3140@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:54:21PM +0900, Kazuki Hashimoto wrote:
> There's no reason to pass any values to cpuidle_not_available() as the
> function works standalone. Since we're planning to use the function in
> other places, make it so to avoid code duplication.
> 
> Signed-off-by: Kazuki Hashimoto <kazukih0205@gmail.com>
> ---
>  drivers/cpuidle/cpuidle.c | 6 ++++--
>  include/linux/cpuidle.h   | 6 ++----
>  kernel/sched/idle.c       | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 737a026ef58a..c9ba51e0fa38 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -49,9 +49,11 @@ void disable_cpuidle(void)
>  	off = 1;
>  }
>  
> -bool cpuidle_not_available(struct cpuidle_driver *drv,
> -			   struct cpuidle_device *dev)
> +bool cpuidle_not_available(void)
>  {
> +	struct cpuidle_device *dev = cpuidle_get_device();
> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +
>  	return off || !initialized || !drv || !dev || !dev->enabled;
>  }

It appears to me these are a lot of conditions to check *every* time we
go idle -- especially since they hardly, if ever, change.

Can't cpuidle track all this in a single global variable, preferably as
a static_key ?
