Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8C71085E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjEYJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbjEYJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:10:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 224A5E4B;
        Thu, 25 May 2023 02:09:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC5651042;
        Thu, 25 May 2023 02:10:35 -0700 (PDT)
Received: from [10.57.70.156] (unknown [10.57.70.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA9A3F67D;
        Thu, 25 May 2023 02:09:48 -0700 (PDT)
Message-ID: <320ee3b4-63ed-ec50-03c6-906803e34571@arm.com>
Date:   Thu, 25 May 2023 10:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 03/11] coresight-tpdm: Initialize DSB subunit
 configuration
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-4-git-send-email-quic_taozha@quicinc.com>
 <db575b8f-12e9-dab5-c7f6-b524cbce64d9@arm.com>
 <92b73ba2-00c5-9f18-ed27-a302f4e79bb2@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <92b73ba2-00c5-9f18-ed27-a302f4e79bb2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 09:12, Tao Zhang wrote:
> 
> On 5/23/2023 9:42 PM, Suzuki K Poulose wrote:
>> On 27/04/2023 10:00, Tao Zhang wrote:
>>> DSB is used for monitoring “events”. Events are something that
>>> occurs at some point in time. It could be a state decode, the
>>> act of writing/reading a particular address, a FIFO being empty,
>>> etc. This decoding of the event desired is done outside TPDM.
>>> DSB subunit need to be configured in enablement and disablement.
>>> A struct that specifics associated to dsb dataset is needed. It
>>> saves the configuration and parameters of the dsb datasets. This
>>> change is to add this struct and initialize the configuration of
>>> DSB subunit.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>

...

>>> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
>>> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
>>> + * Bit(DSB). This function will initialize the configuration according
>>> + * to the dataset type supported by the TPDM.
>>> + */
>>>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>>>   {
>>>       CS_UNLOCK(drvdata->base);
>>> @@ -110,15 +144,24 @@ static const struct coresight_ops tpdm_cs_ops = {
>>>       .source_ops    = &tpdm_source_ops,
>>>   };
>>>   -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>>> +static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>>>   {
>>>       u32 pidr;
>>>   -    CS_UNLOCK(drvdata->base);
>>>       /*  Get the datasets present on the TPDM. */
>>>       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>>> -    CS_LOCK(drvdata->base);
>>
>> Why are we removing the CS_{UN,}LOCK here ?
> 
> CS_UNLOCK is used before writing data to Coresight registers. Here this 
> function
> 
> doesn't need to write data to any registers, so I remove the 
> CS_{UN,}LOCK here.

Please make this a separate patch to avoid confusing and keep it at the
beginning of the series.

Suzuki

