Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D006A84B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjCBO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCBO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:56:04 -0500
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 06:55:32 PST
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710C247410
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:55:32 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl [83.9.32.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AFBE83F8F4;
        Thu,  2 Mar 2023 15:46:29 +0100 (CET)
Message-ID: <7da47edd-60ba-d8fc-9d30-4dc0e5969bb2@somainline.org>
Date:   Thu, 2 Mar 2023 15:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] cpuidle: psci: Iterate backwards over list in
 psci_pd_remove()
Content-Language: en-US
To:     Shawn Guo <shawn.guo@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220308082931.3385902-1-shawn.guo@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220308082931.3385902-1-shawn.guo@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2022 09:29, Shawn Guo wrote:
> In case that psci_pd_init_topology() fails for some reason,
> psci_pd_remove() will be responsible for deleting provider and removing
> genpd from psci_pd_providers list.  There will be a failure when removing
> the cluster PD, because the cpu (child) PDs haven't been removed.
> 
> [    0.050232] CPUidle PSCI: init PM domain cpu0
> [    0.050278] CPUidle PSCI: init PM domain cpu1
> [    0.050329] CPUidle PSCI: init PM domain cpu2
> [    0.050370] CPUidle PSCI: init PM domain cpu3
> [    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
> [    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
> [    0.051412] PM: genpd_remove: removed cpu3
> [    0.051449] PM: genpd_remove: removed cpu2
> [    0.051499] PM: genpd_remove: removed cpu1
> [    0.051546] PM: genpd_remove: removed cpu0
> 
> Fix the problem by iterating the provider list reversely, so that parent
> PD gets removed after child's PDs like below.
> 
> [    0.029052] CPUidle PSCI: init PM domain cpu0
> [    0.029076] CPUidle PSCI: init PM domain cpu1
> [    0.029103] CPUidle PSCI: init PM domain cpu2
> [    0.029124] CPUidle PSCI: init PM domain cpu3
> [    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
> [    0.029647] PM: genpd_remove: removed cpu0
> [    0.029666] PM: genpd_remove: removed cpu1
> [    0.029690] PM: genpd_remove: removed cpu2
> [    0.029714] PM: genpd_remove: removed cpu3
> [    0.029738] PM: genpd_remove: removed cpu-cluster0
> 
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
Looks like this was never picked up or followed up on?

Konrad
> Changes since v1:
> - Fix commit log
> - Pick up Reviewed-by tag from Sudeep and Ulf (Thanks!)
> - Add Fixes tag as suggested by Ulf
> 
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index ff2c3f8e4668..ce5c415fb04d 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -182,7 +182,8 @@ static void psci_pd_remove(void)
>  	struct psci_pd_provider *pd_provider, *it;
>  	struct generic_pm_domain *genpd;
>  
> -	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
> +	list_for_each_entry_safe_reverse(pd_provider, it,
> +					 &psci_pd_providers, link) {
>  		of_genpd_del_provider(pd_provider->node);
>  
>  		genpd = of_genpd_remove_last(pd_provider->node);
> 
