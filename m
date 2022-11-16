Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5862C905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiKPTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKPTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:34:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987671EC6B;
        Wed, 16 Nov 2022 11:34:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 590CAB81D6C;
        Wed, 16 Nov 2022 19:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDBEC433B5;
        Wed, 16 Nov 2022 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668627251;
        bh=PY1YWCuGuthzJzRW4kQrX+eJXbcYGVqknk9wcGmeP8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/laLDUGBG2NPNvbDU8UiAdIjL6xbML6f0Zuk4V05XoOHwITkCMbtmKVCQmJOs64J
         3M6myFNNrKh6OyT6fqZpODve0dZBZr9aBWfAjo5DDmcP23NCrl9T2OW3AUK2NN8XPU
         Xq+roVn5Rob7Hies4wqwRU8ybASvRUwUMQBE6qHGs0VkFe1AdPtsVE31zptmc//t9S
         I/3oREsbLWWRiIX6Rnz1kRDB8JmCeD/o0oriaQDvK1CLEg+rrXqHnoV8USOcPFxzUB
         moTnxsDFH4X8fYL/IJExW68OLoxCBZjmBUMEgo83K91JZgYjycsBH/Klh6Sak3l4rK
         4shETiVQOwKmQ==
Date:   Wed, 16 Nov 2022 12:34:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cpufreq: ACPI: Remove unused variables
 'acpi_cpufreq_online' and 'ret'
Message-ID: <Y3U7MWezkc8aizuo@dev-arch.thelio-3990X>
References: <20221108170103.3375832-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108170103.3375832-1-nathan@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Small ping, was there an issue with this change? It seems pretty
straight forward to me and it is wreaking havoc on our build matrix due
to -Werror.

Cheers,
Nathan

On Tue, Nov 08, 2022 at 10:01:03AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>           acpi_cpufreq_online = ret;
>                                 ^~~
>   drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                 ^
>                   = 0
>   1 error generated.
> 
> Both ret and acpi_cpufreq_online are now unused so they can be safely
> removed, clearing up the warning.
> 
> Fixes: 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1757
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c8fdfcf659e6..74ef0e05ff7b 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -953,12 +953,8 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
>  	.attr		= acpi_cpufreq_attr,
>  };
>  
> -static enum cpuhp_state acpi_cpufreq_online;
> -
>  static void __init acpi_cpufreq_boost_init(void)
>  {
> -	int ret;
> -
>  	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
>  		pr_debug("Boost capabilities not present in the processor\n");
>  		return;
> @@ -966,8 +962,6 @@ static void __init acpi_cpufreq_boost_init(void)
>  
>  	acpi_cpufreq_driver.set_boost = set_boost;
>  	acpi_cpufreq_driver.boost_enabled = boost_state(0);
> -
> -	acpi_cpufreq_online = ret;
>  }
>  
>  static int __init acpi_cpufreq_init(void)
> 
> base-commit: 21cdb6c18f85fe538ca8740bc79f11fbe08d0197
> -- 
> 2.38.1
> 
