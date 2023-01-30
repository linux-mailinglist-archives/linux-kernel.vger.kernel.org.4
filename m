Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E776809EE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjA3JwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjA3JwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:52:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13271ADC4;
        Mon, 30 Jan 2023 01:51:58 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:51:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675072317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggXzOd89KFIJ6f1Z/pzLBaiL5Q7ZJjEjXvd8xWV2nzU=;
        b=VpWek9Ux8EZCxRl1fPnM/nYNPO8LtDFiW+1qx1+tbuB75IFPhOdou8ttS9e46NW2B9AiOt
        LZooVbcNZb7C3VA/HLYCCyEOEK2cfeXBnV4feP1TyOWazhZANpd3qCHgZ7V5+7nP5KTcJ3
        6L0rwDRmju44/bbDWCZzazhmvNwD86MCEUnlkp21ml1BxCCKcqiIfQjbE+Bez/V6mTCbdd
        TDl+EbS4YOayo7U8w0umHPdlPFZNl+OKjRUhadTI2fZdqrZnDNbSZjxJ0ckl1qG4C1WwWj
        RLoKdEYyTi9jbNf0brhKBTxZgpBl0zTB+uqBy0nr22raqES1HcPwgFxf+15Thg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675072317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggXzOd89KFIJ6f1Z/pzLBaiL5Q7ZJjEjXvd8xWV2nzU=;
        b=QkkwBZL0cnvBXkl91/Am3GwV3LcF27qm7o5EX57ibxgJlxPb1yxZzV9c5CHz7iPHEj8usb
        RWe0HhRUF++4cXBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 3/5] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <Y9eTJVkyp3iiiYpK@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-4-krzysztof.kozlowski@linaro.org>
 <Y7/qZNoXvp/I6h8s@linutronix.de>
 <3d7c3a52-baa4-ce7b-e6d1-06a4d885d445@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d7c3a52-baa4-ce7b-e6d1-06a4d885d445@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-12 12:34:35 [+0100], Krzysztof Kozlowski wrote:
> On 12/01/2023 12:09, Sebastian Andrzej Siewior wrote:
> > On 2022-12-19 16:15:01 [+0100], Krzysztof Kozlowski wrote:
> >> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> >> index 57bc3e3ae391..9d971cc4b12b 100644
> >> --- a/drivers/cpuidle/cpuidle-psci.c
> >> +++ b/drivers/cpuidle/cpuidle-psci.c
> >> @@ -72,7 +72,7 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >>  	ct_irq_enter_irqson();
> >>  	if (s2idle)
> >>  		dev_pm_genpd_suspend(pd_dev);
> >> -	else
> >> +	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >>  		pm_runtime_put_sync_suspend(pd_dev);
> > 
> > So based on the commit description you run into a sleeping lock in
> > pm_runtime_put_sync_suspend() while the CPU is in an IRQ-off region.
> > Why is it okay to skip it on PREEMPT_RT?
> 
> It is okay to skip it everywhere, you just don't get a suspended CPU.
> Why PREEMPT_RT is different here - having suspended CPU is a great way
> to have longer or even unpredictable (as it goes to firmware which is
> out of control of Linux) latencies.

On X86 C1 has a latency of less than 5us and this is exposed by the
firmware. C1E and everything that follows has a much higher entry/ exit
latency which makes not usable.
The entry/exit latency seems not to be exposed by PSCI. My understanding
is that the driver is now enabled but not doing any suspending, right?
If so, why isn't it completely disabled?

> Best regards,
> Krzysztof

Sebastian
