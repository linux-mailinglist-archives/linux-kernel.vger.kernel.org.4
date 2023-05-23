Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18570DFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbjEWOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjEWOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:48:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CA7ACD;
        Tue, 23 May 2023 07:48:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5CF139F;
        Tue, 23 May 2023 07:49:39 -0700 (PDT)
Received: from [10.57.73.71] (unknown [10.57.73.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CB453F840;
        Tue, 23 May 2023 07:48:52 -0700 (PDT)
Message-ID: <e2e4b998-e6d8-59e9-fce7-0072954001dd@arm.com>
Date:   Tue, 23 May 2023 15:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/11] coresight-tpda: Add DSB dataset support
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
 <1682586037-25973-3-git-send-email-quic_taozha@quicinc.com>
 <444bc278-a3e3-7d99-6020-7c3337371f66@arm.com>
In-Reply-To: <444bc278-a3e3-7d99-6020-7c3337371f66@arm.com>
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

On 23/05/2023 11:07, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> Read the DSB element size from the device tree. Set the register
>> bit that controls the DSB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c |  1 +
>>   drivers/hwtracing/coresight/coresight-tpda.c | 92 
>> +++++++++++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>   drivers/hwtracing/coresight/coresight-tpdm.c |  2 +-
>>   include/linux/coresight.h                    |  1 +
>>   5 files changed, 90 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 2af416b..f1eacbb 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1092,6 +1092,7 @@ static int coresight_validate_source(struct 
>> coresight_device *csdev,
>>       if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>> +        subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>>           dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>>           return -EINVAL;
> 
> Please see the comment at the bottom.
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 8d2b9d2..af9c72f 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -21,6 +21,56 @@
>>   DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>> +/* Search and read element data size from the TPDM node in
>> + * the devicetree. Each input port of TPDA is connected to
>> + * a TPDM. Different TPDM supports different types of dataset,
>> + * and some may support more than one type of dataset.
>> + * Parameter "inport" is used to pass in the input port number
>> + * of TPDA, and it is set to 0 in the recursize call.
>> + * Parameter "parent" is used to pass in the original call.
>> + */
>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>> +               struct coresight_device *csdev, int inport, bool parent)

The name parent is a bit confusing. It could imply parent device ? That
is kind of inverse ? because, parent = true, indicates the parent device
of tpda, which is not true. Could we simply say

bool match_inport => When true, the dest_port of the connection from the
csdev must match the inport ? And ...

>> +{
>> +    static int nr_inport;
>> +    int i;
>> +    static bool tpdm_found;
>> +    struct coresight_device *in_csdev;
>> +
>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>> +        return -EINVAL;
>> +
>> +    if (parent) {
>> +        nr_inport = inport;
>> +        tpdm_found = false;
>> +    }
>> +
>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>> +        if (!in_csdev)
>> +            break;
>> +
>> +        if (parent)
>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>> +                continue;

The above can become :

	    if (match_inport &&
		csdev->pdata->in_conns[i]->dest_port != inport)
		continue;

Suzuki

