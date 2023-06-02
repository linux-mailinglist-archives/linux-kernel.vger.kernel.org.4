Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6271FCE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjFBJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjFBJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:00:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FE78133;
        Fri,  2 Jun 2023 02:00:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B46E1063;
        Fri,  2 Jun 2023 02:01:05 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD903F663;
        Fri,  2 Jun 2023 02:00:17 -0700 (PDT)
Message-ID: <e82d7387-a299-20e5-3176-dce20966a10b@arm.com>
Date:   Fri, 2 Jun 2023 10:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 07/11] coresight-tpdm: Add nodes for dsb edge control
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
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
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-8-git-send-email-quic_taozha@quicinc.com>
 <606b8a25-0468-c310-ccff-1477e2b238b2@arm.com>
 <c5c28ab8-7d6a-f8e7-ad34-8716ac77d2dc@quicinc.com>
 <a2bd3bbf-5512-971a-95a1-3220f31814a2@arm.com>
In-Reply-To: <a2bd3bbf-5512-971a-95a1-3220f31814a2@arm.com>
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

On 02/06/2023 09:45, Suzuki K Poulose wrote:
> On 02/06/2023 09:21, Tao Zhang wrote:
>>
>> On 6/1/2023 8:14 PM, Suzuki K Poulose wrote:
>>> On 27/04/2023 10:00, Tao Zhang wrote:
>>>> Add the nodes to set value for DSB edge control and DSB edge
>>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>>> resgisters to configure edge control. DSB edge detection control
>>>> 00: Rising edge detection
>>>> 01: Falling edge detection
>>>> 10: Rising and falling edge detection (toggle detection)
>>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>>>> configure mask. Eight 32 bit registers providing DSB interface
>>>> edge detection mask control.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 135 
>>>> ++++++++++++++++++++-
>>>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  21 ++++
>>>>   3 files changed, 187 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> index 348e167..a57f000 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> @@ -60,3 +60,35 @@ Description:
>>>>           Bit[3] : Set to 0 for low performance mode.
>>>>                    Set to 1 for high performance mode.
>>>>           Bit[4:8] : Select byte lane for high performance mode.
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
>>>> +Date:        March 2023
>>>> +KernelVersion    6.3
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        Read/Write a set of the edge control registers of the DSB
>>>> +        in TPDM.
>>>> +
>>>> +        Expected format is the following:
>>>> +        <integer1> <integer2> <integer3>
>>>> +
>>>> +        Where:
>>>> +        <integer1> : Start EDCR register number
>>>> +        <integer2> : End EDCR register number
>>>> +        <integer3> : The value need to be written
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
>>>> +Date:        March 2023
>>>> +KernelVersion    6.3
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        Read/Write a set of the edge control mask registers of the
>>>> +        DSB in TPDM.
>>>> +
>>>> +        Expected format is the following:
>>>> +        <integer1> <integer2> <integer3>
>>>> +
>>>> +        Where:
>>>> +        <integer1> : Start EDCMR register number
>>>> +        <integer2> : End EDCMR register number
>>>> +        <integer3> : The value need to be written
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> index 1bacaa5..a40e458 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> @@ -80,7 +80,14 @@ static void set_trigger_type(struct tpdm_drvdata 
>>>> *drvdata, u32 *val)
>>>>     static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>>>   {
>>>> -    u32 val;
>>>> +    u32 val, i;
>>>> +
>>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
>>>> +        writel_relaxed(drvdata->dsb->edge_ctrl[i],
>>>> +               drvdata->base + TPDM_DSB_EDCR(i));
>>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>>>> +        writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>>>> +               drvdata->base + TPDM_DSB_EDCMR(i));
>>>
>>> Do all TPDM DSBs have MAX_EDCR registers ? Or some have less than that ?
>>> If it is latter, do we need special care to avoid writing to inexistent
>>> registers ?
>>>
>> You are right, not all DSB TPDMs have MAX_EDCR registers. In our 
>> design, the inexistent register addresses
>>
>> are not occupied and safe for accessing.

Does the TRM for the component say so ? Or is it by luck ? If the spec
says it is RAZ/WriteIgnore, then we could keep the code as it is,
with a comment. Otherwise, we could add a DT property. So please get
this clarified with the H/W designers.

Suzuki
