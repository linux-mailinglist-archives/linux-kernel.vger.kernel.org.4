Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DAA5F5BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJEVsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJEVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:48:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089480483;
        Wed,  5 Oct 2022 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665006495; x=1696542495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RFIuA9WSXf5bu+kyrwDmO//2cceXbU0tFBEkt867AhY=;
  b=AaPfJRHcEbYbp5b/1vjJz0B7ERv78KVFSG4mPw3BbXya25UVAPxXAtwS
   vBQxUu3YVEq/chPAJATAd+hzBICFFFmeFSHi7lJI/eB1T/2J2T2aLlDj9
   WqyZszXrPNx1fS/NtkXT+ly8fbUFh7EOkVFortSkEh5bL5lcQCmg+xDNW
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Oct 2022 14:48:15 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 14:48:14 -0700
Received: from [10.71.110.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 14:47:53 -0700
Message-ID: <31a4de54-9fbe-8487-903d-28528a1b42d3@quicinc.com>
Date:   Wed, 5 Oct 2022 14:47:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 13/14] gunyah: rsc_mgr: Add auxiliary devices for
 console
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
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
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-14-quic_eberman@quicinc.com>
 <Yzbev2mZodsZhFY3@kroah.com>
 <1db27cda-356e-bae2-3c6a-b7916123a269@quicinc.com>
 <Yz0ig/Dnp4ovHjeN@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Yz0ig/Dnp4ovHjeN@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2022 11:21 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 04, 2022 at 04:49:27PM -0700, Elliot Berman wrote:
>> On 9/30/2022 5:19 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 28, 2022 at 12:56:32PM -0700, Elliot Berman wrote:
>>>> Gunyah resource manager exposes a concrete functionalities which
>>>> complicate a single resource manager driver.
>>>
>>> I am sorry, but I do not understand this sentance.  What is so
>>> complicated about individual devices being created?  Where are they
>>> created?  What bus?
>>
>> There's no complexity here with using individual devices, that's why I
>> wanted to create secondary (auxiliary devices).
>>
>> IOW -- "I have a platform device that does a lot of different things. Split
>> up the different functionalities of that device into sub devices using the
>> auxiliary bus."
> 
> Why not just have multiple platform devices?  You control them, don't
> make it more complex than it should be.
> 
> And why are these platform devices at all?
> 
> As you say:
> 
>> A key requirement for utilizing the auxiliary bus is that there is no
>> dependency on a physical bus, device, register accesses or regmap support.
>> These individual devices split from the core cannot live on the platform bus
>> as they are not physical devices that are controlled by DT/ACPI.
> 
> These are not in the DT.  So just make your own bus for them instead of
> using a platform device.  Don't abuse a platform device please.
> 

I'll avoid creating platform devices. Are there any concerns with 
creating auxiliary device under the platform device? There will only be 
2 auxiliary devices under this Resource Manager device: one for console, 
and one for a VM loader.

> thanks,
> 
> greg k-h
