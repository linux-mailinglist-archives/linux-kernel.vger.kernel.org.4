Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC46B68ED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCLRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCLRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6113755E;
        Sun, 12 Mar 2023 10:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC0A460F91;
        Sun, 12 Mar 2023 17:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26EC433D2;
        Sun, 12 Mar 2023 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678643120;
        bh=YEdUsPYrGcfGa+1Q3JmQqtfsYE5Mu9KqGWmOkv1vGKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gk98wvfrmLxkM4Ks+krsYRFLGE6WEwv7U2tXorF44jRdMofBAiXmSqqZqI8CTSiN2
         OgYYzaj5Cg7CUn+r2S31ClA460gZ4dkvHFwjpfLEIwb/WVf2kAMpUMAWsi+5Tydj4x
         Nh/TtzDfdK55WHLLxNY+O5tjarroB1CDdJpU1S9WGISW3I9RL333LCPHFgGb29fqHF
         dbWgYQaZBogboZDqgiH/0x+FSQyLXOBV/AlJL26RUht6XZnCGDQTedFM3+BpUqPXG6
         KeYEMLYqX/DYy+62AH9YvN+vLPMlbW3iGngYV2AIXN6lary3MvfQVvBgOvlaVBBLTo
         k3rVFg2kAIvbw==
Date:   Sun, 12 Mar 2023 17:45:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com, andy.shevchenko@gmail.com,
        yannick.brosseau@gmail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: set some stm32-adc.c variables
 storage-class-specifier to static
Message-ID: <20230312174524.75e55ce8@jic23-huawei>
In-Reply-To: <20230312161733.470617-1-trix@redhat.com>
References: <20230312161733.470617-1-trix@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 12:17:33 -0400
Tom Rix <trix@redhat.com> wrote:

> smatch reports several warnings
> drivers/iio/adc/stm32-adc.c:2591:20: warning:
>   symbol 'stm32_adc_min_ts_h7' was not declared. Should it be static?
> drivers/iio/adc/stm32-adc.c:2610:20: warning:
>   symbol 'stm32_adc_min_ts_mp1' was not declared. Should it be static?
> drivers/iio/adc/stm32-adc.c:2630:20: warning:
>   symbol 'stm32_adc_min_ts_mp13' was not declared. Should it be static?
> 
> These variables are only used in stm32-adc.c, so they should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks Tom,

I wonder why these didn't show up in earlier build reports?
Ah well.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 45d4e79f8e55..1aadb2ad2cab 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2588,7 +2588,7 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
>  	.irq_clear = stm32f4_adc_irq_clear,
>  };
>  
> -const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
> +static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32h7_adc_cfg = {
> @@ -2607,7 +2607,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
>  	.ts_int_ch = stm32_adc_min_ts_h7,
>  };
>  
> -const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
> +static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
> @@ -2627,7 +2627,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.ts_int_ch = stm32_adc_min_ts_mp1,
>  };
>  
> -const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
> +static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
>  static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
>  
>  static const struct stm32_adc_cfg stm32mp13_adc_cfg = {

