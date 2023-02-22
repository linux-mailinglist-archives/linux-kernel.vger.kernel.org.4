Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631F69F4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBVMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:46:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F8F367DD;
        Wed, 22 Feb 2023 04:46:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 156AB139F;
        Wed, 22 Feb 2023 04:47:04 -0800 (PST)
Received: from [10.57.90.101] (unknown [10.57.90.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5123F703;
        Wed, 22 Feb 2023 04:46:17 -0800 (PST)
Message-ID: <6072a788-74b9-6521-882c-c1637a68ccb2@arm.com>
Date:   Wed, 22 Feb 2023 12:46:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/9] coresight-tpda: Add DSB dataset support
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-3-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 07:41, Tao Zhang wrote:
> Read the DSB element size from the device tree. Set the register
> bit that controls the DSB element size of the corresponding port.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpda.c | 62 ++++++++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> index 5989798..be13e08 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -37,6 +37,15 @@ static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>   	u32 val;
>   
>   	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
> +	/*
> +	 * Configure aggregator port n DSB data set element size
> +	 * Set the bit to 0 if the size is 32
> +	 * Set the bit to 1 if the size is 64
> +	 */
> +	if (drvdata->dsb_esize[port] == 32)
> +		val &= ~TPDA_Pn_CR_DSBSIZE;
> +	else if (drvdata->dsb_esize[port] == 64)
> +		val |= TPDA_Pn_CR_DSBSIZE;

What are the chances of having a value other than 32 or 64 ?
What should we do in that case ? Should the driver at least
give out a warning at least in the unhandled case rather than
silently reusing the existing setting ?

Suzuki

