Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D66A581C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjB1LcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1LcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:32:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 176139B;
        Tue, 28 Feb 2023 03:32:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF13D1688;
        Tue, 28 Feb 2023 03:32:59 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE1A3F881;
        Tue, 28 Feb 2023 03:32:14 -0800 (PST)
Message-ID: <fa09722a-b251-bf60-35af-e6dc45ed9ae4@arm.com>
Date:   Tue, 28 Feb 2023 11:32:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/9] coresight-tpdm: Add nodes to set trigger timestamp
 and type
Content-Language: en-US
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
        linux-arm-msm@vger.kernel.org, Tao Zhang <taozha@qti.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-6-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1674114105-16651-6-git-send-email-quic_taozha@quicinc.com>
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
> The nodes are needed to set or show the trigger timestamp and
> trigger type. This change is to add these nodes to achieve these
> function.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 97 ++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index c29d667d..1dbb6c4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,6 +20,22 @@
>   


> +static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_trig_ts.attr,
> +	&dev_attr_dsb_trig_type.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group tpdm_dsb_attr_grp = {
> +	.attrs = tpdm_dsb_attrs,
> +	.is_visible = tpdm_dsb_is_visible,
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
> +	&tpdm_dsb_attr_grp,
>   	NULL,
>   };
>   


Please also add documentation of the new sysfs handles under :

Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm*

Suzuki

