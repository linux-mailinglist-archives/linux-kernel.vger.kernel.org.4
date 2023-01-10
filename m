Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457E6645C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjAJQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjAJQPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:15:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 394A15AC63
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:15:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D272F4;
        Tue, 10 Jan 2023 08:16:18 -0800 (PST)
Received: from [10.57.89.71] (unknown [10.57.89.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8773F67D;
        Tue, 10 Jan 2023 08:15:35 -0800 (PST)
Message-ID: <4c799bd3-ab24-c0e6-57a4-aa9acc6c46b4@arm.com>
Date:   Tue, 10 Jan 2023 16:15:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and
 TRCSEQSTR
To:     Junhao He <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        shenyang39@huawei.com, prime.zeng@hisilicon.com
References: <20230110125101.10533-1-hejunhao3@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230110125101.10533-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/01/2023 12:51, Junhao He wrote:
> The TRCSEQRSTEVR and TRCSEQSTR register is not implemented if the
> TRCIDR5.NUMSEQSTATE == 0. Skip accessing the register in such cases.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

This must have :

Fixes: 2e1cdfe184b5 ("coresight-etm4x: Adding CoreSight ETM4x driver")

The patch as such looks correct to me.

I will queue this.

Thanks
Suzuki

> ---
>   .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 80fefaba58ee..c7a65d1524fc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -424,8 +424,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
>   	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>   		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
> -	etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> -	etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +	if (drvdata->nrseqstate) {
> +		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> +		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +	}
>   	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
> @@ -1631,8 +1633,10 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>   	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>   		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
>   
> -	state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> -	state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> +	if (drvdata->nrseqstate) {
> +		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> +		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> +	}
>   	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>   
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
> @@ -1760,8 +1764,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>   	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>   		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
>   
> -	etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> -	etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> +	if (drvdata->nrseqstate) {
> +		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> +		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> +	}
>   	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>   
>   	for (i = 0; i < drvdata->nr_cntr; i++) {

