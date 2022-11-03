Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AB618B28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiKCWJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKCWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:09:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C10C20BD1;
        Thu,  3 Nov 2022 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667513368; x=1699049368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0Q4UYJo0r4CAvLo84TRF+qOpG8p4iPvKnthKy/ejt7k=;
  b=qwtuK/tBxQxh2U3gqsPoTJchQYr7OIwpIZ+HladWMYgbVyLH93GYNJNH
   /jFxkQunMlwTB+UjZLrFe4mvA6lcysZj4Yxw0CuNES6IHbe8qj6mKeNOY
   /IrHa0p+aWcbrgTQzcsc9GkD1RfMQMqo+i2HZGvhataVUCl2jxi4qiMN4
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Nov 2022 15:09:27 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 15:09:27 -0700
Received: from [10.110.42.219] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 3 Nov 2022
 15:09:26 -0700
Message-ID: <f33ac509-ecf6-477b-9118-6ed1509a6e2c@quicinc.com>
Date:   Thu, 3 Nov 2022 15:09:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 10/21] gunyah: rsc_mgr: Add resource manager RPC core
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-11-quic_eberman@quicinc.com>
 <Y2FfKCKZ3N8rOqcT@kroah.com>
 <3d2858fe-ea3e-159c-faff-5052cba1e08c@quicinc.com>
 <Y2Hbl4y9Hioybxmq@kroah.com>
 <28eaa4bd-a9ee-c415-57c4-a9a56ffeef18@quicinc.com>
 <Y2MJ43oVYfNgBZsQ@kroah.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2MJ43oVYfNgBZsQ@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 5:22 PM, Greg Kroah-Hartman wrote:
> On Wed, Nov 02, 2022 at 11:04:45AM -0700, Elliot Berman wrote:
>>>>>> +/* Resource Manager Header */
>>>>>> +struct gh_rm_rpc_hdr {
>>>>>> +	u8 version : 4, hdr_words : 4;
>>>>>> +	u8 type : 2, fragments : 6;
>>>>>
>>>>> Ick, that's hard to read.  One variable per line please?
>>>>
>>>> Ack.
>>>>
>>>>> And why the bit packed stuff?  Are you sure this is the way to do this?
>>>>> Why not use a bitmask instead?
>>>>>
>>>>
>>>> I felt bit packed implementation is cleaner and easier to map to
>>>> understanding what the fields are used for.
>>>
>>> Ah, so this isn't what is on the "wire", then don't use a bitfield like
>>> this, use a real variable and that will be faster and simpler to
>>> understand.
>>>
>>
>> This is what's on the "wire". Whether I use bitfield or bit packed would be
>> functionally the same and is just a cosmetic change IMO.
> 
> Ah, that wasn't obvious at all.
> 
> Usually using bitfields like this for "wire" protocols is not a good
> idea (endian issues and all of that.)  Please use a bitmask instead, as
> that way you know exactly what is happening, and the compiler can
> usually generate much better code overall.
> 
> And as this is on the wire, please specify the endian values, _AND_ use
> the proper kernel types for stuff that goes between user/kernel or
> kernel/hardware, as you are not doing that here.

Ack
