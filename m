Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91A6669CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjALDtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjALDsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:48:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89C4B4BD4D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:48:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E02FEC;
        Wed, 11 Jan 2023 19:49:34 -0800 (PST)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412C63F67D;
        Wed, 11 Jan 2023 19:48:48 -0800 (PST)
Message-ID: <f2886dd2-c98c-cbe0-0816-0d7926edd2f0@arm.com>
Date:   Thu, 12 Jan 2023 09:18:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and
 TRCSEQSTR
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        shenyang39@huawei.com, prime.zeng@hisilicon.com
References: <20230110125101.10533-1-hejunhao3@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230110125101.10533-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 18:21, Junhao He wrote:
> The TRCSEQRSTEVR and TRCSEQSTR register is not implemented if the

s/register is/registers are/

> TRCIDR5.NUMSEQSTATE == 0. Skip accessing the register in such cases.

s/register/registers/

> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 80fefaba58ee..c7a65d1524fc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -424,8 +424,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
>  	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>  		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
> -	etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> -	etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +	if (drvdata->nrseqstate) {
> +		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> +		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> +	}
>  	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>  	for (i = 0; i < drvdata->nr_cntr; i++) {
>  		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
> @@ -1631,8 +1633,10 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>  		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
>  
> -	state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> -	state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> +	if (drvdata->nrseqstate) {
> +		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> +		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> +	}
>  	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>  
>  	for (i = 0; i < drvdata->nr_cntr; i++) {
> @@ -1760,8 +1764,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>  		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
>  
> -	etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> -	etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> +	if (drvdata->nrseqstate) {
> +		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> +		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> +	}
>  	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>  
>  	for (i = 0; i < drvdata->nr_cntr; i++) {
