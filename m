Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74436670BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjALLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjALLQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:16:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EB13FA7;
        Thu, 12 Jan 2023 03:09:28 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:09:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673521767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDCtF1k4ANTCGutHZXIyNVj0A5DsZpaHBXshV6rRwdY=;
        b=ee7t37a9m4MbSl1YM8AB8lsLv44oXc7o450J1A73ZhciksFKMKtprL3YsPL2tdA9QRzsYx
        2g2/SSnYwYhqBgDETKOFI4hk6yeaFPyo8LX4AGTxnaXrXmeF48vWEvfClVY3uFSzJ5c7Bt
        s/fYK0vWKkJgvI77QYrOuVib/5clL0JcAai2U1Gqfs5UscqdWwabPIJVIOs1pXGGLyI+OD
        itvOQW63Ayzvj2MiyxO3BCxjBjTDVFh7tY7Qw/0YK98WeiMcgCDctftExJsx2fCJOz6EGS
        WPnsqAmCYgJ/B+hy/rzqgHajoCOb31cbPNfMs6Y5EpHptxjHQXMn1JYrPk84iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673521767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDCtF1k4ANTCGutHZXIyNVj0A5DsZpaHBXshV6rRwdY=;
        b=WH/bRg/8GIIjrOFnCYPDlqmZlTOc7fuDxEBo9XyYwsOO/edYoEvSUTBjL8ndZGsyx6ecMj
        enypQq+NC61jrjBw==
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
Message-ID: <Y7/qZNoXvp/I6h8s@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219151503.385816-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 16:15:01 [+0100], Krzysztof Kozlowski wrote:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 57bc3e3ae391..9d971cc4b12b 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -72,7 +72,7 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  	ct_irq_enter_irqson();
>  	if (s2idle)
>  		dev_pm_genpd_suspend(pd_dev);
> -	else
> +	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>  		pm_runtime_put_sync_suspend(pd_dev);

So based on the commit description you run into a sleeping lock in
pm_runtime_put_sync_suspend() while the CPU is in an IRQ-off region.
Why is it okay to skip it on PREEMPT_RT?

>  	ct_irq_exit_irqson();
>  

Sebastian
