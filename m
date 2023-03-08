Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA236B0564
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCHLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCHLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:05:41 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789C618B;
        Wed,  8 Mar 2023 03:04:57 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D2C9C24E17F;
        Wed,  8 Mar 2023 19:04:55 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 19:04:55 +0800
Received: from [192.168.60.130] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 19:04:55 +0800
Message-ID: <243f92b6-bed7-e1c0-50c6-ab921fa42877@starfivetech.com>
Date:   Wed, 8 Mar 2023 19:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 06/11] media: starfive: add ISP driver files
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-7-jack.zhu@starfivetech.com>
 <1270c1a6-9e12-3f0b-c90b-f1715ea07f80@linaro.org>
 <0a0fbd68-9398-b6ac-3d78-e8765e4c2af9@starfivetech.com>
 <6fd5135f-9cf3-1a18-cd54-1f671b950d8f@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <6fd5135f-9cf3-1a18-cd54-1f671b950d8f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/8 18:34, Krzysztof Kozlowski wrote:
> On 07/03/2023 10:53, Jack Zhu wrote:
>> 
>> 
>> On 2023/3/3 16:45, Krzysztof Kozlowski wrote:
>>> On 02/03/2023 10:19, jack.zhu wrote:
>>>> Add base driver for Starfive Image Signal Processing Unit which
>>>> handles the data streams from the CSI2 receiver.
>>>>
>>>> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
>>>> ---
>>>>  drivers/media/platform/starfive/stf_isp.c     | 1079 ++++++++++++++
>>>>  drivers/media/platform/starfive/stf_isp.h     |  183 +++
>>>>  .../media/platform/starfive/stf_isp_hw_ops.c  | 1286 +++++++++++++++++
>>>>  3 files changed, 2548 insertions(+)
>>>>  create mode 100644 drivers/media/platform/starfive/stf_isp.c
>>>>  create mode 100644 drivers/media/platform/starfive/stf_isp.h
>>>>  create mode 100644 drivers/media/platform/starfive/stf_isp_hw_ops.c
>>>
>>>
>>>> +}
>>>> +
>>>> +static int stf_isp_reg_read(struct stf_isp_dev *isp_dev, void *arg)
>>>> +{
>>>> +	void __iomem *ispbase = stf_isp_get_ispbase(isp_dev);
>>>> +	struct isp_reg_param *reg_param = arg;
>>>
>>>
>>> Didn't you add now code which does not even build and is not bisectable?
>>>
>> 
>> use patch 11 to build all files in the starfive directory.
>> 
> 
> Not related. So let me put it very simple:
> 
> 1. Does this code build or not?
> 2. Do you certify that code is 100% bisectable?

No, Maybe I need to merge the previous patches[6-11] into one patch to submit?

> 
> 
> Best regards,
> Krzysztof
> 
