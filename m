Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA71F736D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjFTNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:41:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49E42E7D;
        Tue, 20 Jun 2023 06:41:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AA7B1063;
        Tue, 20 Jun 2023 06:41:56 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EBD63F71E;
        Tue, 20 Jun 2023 06:41:10 -0700 (PDT)
Message-ID: <e82385f1-de55-4c70-5c5c-35b93a5b2488@arm.com>
Date:   Tue, 20 Jun 2023 14:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 09/13] Add nodes for dsb edge control
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-10-git-send-email-quic_taozha@quicinc.com>
 <2023062024-sincere-tripod-95dc@gregkh>
 <3aca4a55-0dc7-b34c-d2c0-111a96c33ec3@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <3aca4a55-0dc7-b34c-d2c0-111a96c33ec3@quicinc.com>
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

On 20/06/2023 09:31, Tao Zhang wrote:
> 
> On 6/20/2023 3:37 PM, Greg Kroah-Hartman wrote:
>> On Tue, Jun 20, 2023 at 03:32:37PM +0800, Tao Zhang wrote:
>>> Add the nodes to set value for DSB edge control and DSB edge
>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>> resgisters to configure edge control. DSB edge detection control
>>> 00: Rising edge detection
>>> 01: Falling edge detection
>>> 10: Rising and falling edge detection (toggle detection)
>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>>> configure mask. Eight 32 bit registers providing DSB interface
>>> edge detection mask control.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 143 
>>> ++++++++++++++++++++-
>>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  22 ++++
>>>   3 files changed, 196 insertions(+), 1 deletion(-)
>>>
>>> diff --git 
>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> index 2a82cd0..34189e4a 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> @@ -60,3 +60,35 @@ Description:
>>>           Bit[3] : Set to 0 for low performance mode.
>>>                    Set to 1 for high performance mode.
>>>           Bit[4:8] : Select byte lane for high performance mode.
>>> +
>>> +What:        /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        Read/Write a set of the edge control registers of the DSB
>>> +        in TPDM.
>>> +
>>> +        Expected format is the following:
>>> +        <integer1> <integer2> <integer3>
>> sysfs is "one value", not 3.  Please never have to parse a sysfs file.
> 
> Do you mean sysfs file can only accept "one value"?
> 
> I see that more than one value are written to the sysfs file 
> "trigout_attach".
> 
>>
>>> +static ssize_t dsb_edge_ctrl_show(struct device *dev,
>>> +                       struct device_attribute *attr,
>>> +                       char *buf)
>>> +{
>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    ssize_t size = 0;
>>> +    unsigned long bytes;
>>> +    int i;
>>> +
>>> +    spin_lock(&drvdata->spinlock);
>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
>>> +        bytes = sysfs_emit_at(buf, size,
>>> +                  "Index:0x%x Val:0x%x\n", i,
>> Again, no, one value, no "string" needed to parse anything.
> 
> I also see other sysfs files can be read more than one value in other 
> drivers.
> 
> Is this "one value" limitation the usage rule of Linux sysfs system?
> 
> Or am I misunderstanding what you mean?

Please fix the other sysfs tunables in the following patches.

Kind regards
Suzuki


