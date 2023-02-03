Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34DC6895C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjBCKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjBCKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:20:06 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B061E9D05E;
        Fri,  3 Feb 2023 02:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675419571; x=1706955571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PL9NTO6s4JhDRpJmi1ZrsmWCRrO+lAGkVyxRVYDDEmo=;
  b=ukNO9xT1ILR25efgMojssOEce1MU5FiwLlqsDWNgnM2dXJTXyNtt+yme
   62qQnBWukUctE00HfRx/zJr3XWUSHAPBJLelIhVG06YW9rgNjWA4CHXHt
   BWmgFc2yFwa1bAwaUrBjOxvvsOwIb0Fz+u8s3kJshHCzA/4+M9Tc69xQr
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2023 02:18:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 02:18:40 -0800
Received: from [10.216.62.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 02:18:36 -0800
Message-ID: <c0642b4b-5a36-8d30-017b-5585a124211a@quicinc.com>
Date:   Fri, 3 Feb 2023 15:48:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] firmware: qcom_scm: modify qcom_scm_set_download_mode()
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1674562755-5378-1-git-send-email-quic_mojha@quicinc.com>
 <0e3b9803-2492-87ec-3ae9-00ac820c87ce@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <0e3b9803-2492-87ec-3ae9-00ac820c87ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2023 4:47 PM, Srinivas Kandagatla wrote:
> 
> 
> On 24/01/2023 12:19, Mukesh Ojha wrote:
>> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>> +static int __qcom_scm_set_dload_mode(struct device *dev, enum 
>> qcom_download_mode mode)
>>   {
>>       struct qcom_scm_desc desc = {
>>           .svc = QCOM_SCM_SVC_BOOT,
>>           .cmd = QCOM_SCM_BOOT_SET_DLOAD_MODE,
>>           .arginfo = QCOM_SCM_ARGS(2),
>> -        .args[0] = QCOM_SCM_BOOT_SET_DLOAD_MODE,
>> +        .args[0] = mode,
> 
> Is this a bug fix? why are we changing arg[0]?

Thanks.

This is legacy scm call and it is deprecated.
Let's not change this.
I will fix this in v2.

-Mukesh
> 
> --srini
>>           .owner = ARM_SMCCC_OWNER_SIP,
>>       };
>> -    desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>> +    desc.args[1] = mode;
>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>   }
