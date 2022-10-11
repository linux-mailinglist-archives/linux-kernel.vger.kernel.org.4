Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2345FBD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJKWEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJKWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:04:11 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813633428;
        Tue, 11 Oct 2022 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665525850; x=1697061850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a37BN1ON5UjiK5YIoCm1CxyvyyATtOfFhqZTLhB5AaI=;
  b=goqjpjjuqzDjZg+6IAhjKC2KjQ7ni5OcLhmm0e9Zh8YgilimqhxKC70W
   ohj+VzrlTlK4JkwRqbLfS5947AnctU4ye/xcm0rXJgnh+xqmZMU/NJ211
   W06eTwNNbqz51z/rFoZe7w8ifnnIIwvwCP4AjyLKJkCIrKKDEAxUk0YBl
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Oct 2022 15:04:09 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:04:09 -0700
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 15:04:09 -0700
Message-ID: <13eee213-f6c2-d998-ba2e-459509ae7ee7@quicinc.com>
Date:   Tue, 11 Oct 2022 15:04:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
 <14d0ff9f-60f3-71cc-ea42-ceee389298ac@quicinc.com>
 <Yz/YBDqqwBUlswgX@kroah.com>
 <615493a8-449d-b105-709e-0642dfb5359b@quicinc.com>
 <Y0R/QbysXa6ebNd8@kroah.com>
 <ca42d89e-9e19-0536-0951-2c123d898892@quicinc.com>
 <Y0ULqlIMKTc6gdeV@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y0ULqlIMKTc6gdeV@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2022 11:22 PM, Greg Kroah-Hartman wrote:
> On Mon, Oct 10, 2022 at 01:58:00PM -0700, Elliot Berman wrote:
>>
>>
>> On 10/10/2022 1:23 PM, Greg Kroah-Hartman wrote:
>>> On Sun, Oct 09, 2022 at 01:59:21PM -0700, Elliot Berman wrote:
>>>>
>>>>>>> On 10/7/2022 12:40 AM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Oct 06, 2022 at 10:59:51PM -0700, Elliot Berman wrote:
>>>>>>
>>>>>> "GH" is the shorthand we've been using for "Gunyah". I didn't find
>>>>>> documentation for dynamically assigned char devices, but if it exists, I can
>>>>>> add entry for ttyGH.
>>>>>
>>>>> Why use a new name at all?  Why not stick with the existing tty names
>>>>> and device numbers?
>>>>>
>>>>
>>>> I can use hvc framework, although driver-level buffering is needed on
>>>> both the get_chars/put_chars paths because:
>>>
>>> I'm not asking about the framework (although that is a good question,
>>> you need to document why this has to be new.)  I'm asking why pick a new
>>> name?  You will not have a name conflict in your system with this device
>>> with any other tty name right?
>>>
>>
>> That's correct, I didn't see any other instances of "ttyGH" in kernel.
> 
> Do you see any instances of ttyS?  Any other existing name?  Why pick a
> new name at all?
> 
> And if you do pick a new name, you need to document it really really
> well, not bury it downn within the tty driver code.
> 

Seems other drivers are adding a comment in Kconfig help text. I can do 
the same.

