Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2E624149
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiKJLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiKJLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:22:39 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26EC701A4;
        Thu, 10 Nov 2022 03:22:38 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA9FLHi004698;
        Thu, 10 Nov 2022 05:22:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=04hU+ISPUch+ZRCv1Q+3n72ZEEiUP6vT4o1xW8JdjnU=;
 b=SUaY1jm+sVK6BkEOlWU3D3VH0U9/7lNDlbBOvsEYO5LnA1S4mLKhL/rSyRTkv9hNFGOP
 +QGBlmNB1T+B6HeHCuIZhzJuGu/jPRgjStB5KTjfsi3vzjScBZp1AHd+p7eaGRLawSdo
 liMwGW3nDdlal0tsvcVlzfjE8g2gMSFgZzrMx4bubtG50XCK75hjw6M2UkF+iV1LEjBB
 yIE0veU2i8spbFLHlDOZ5dNYCbjIKqfgh3mnzlo5YAQQb4rfLDrWhUGf73Suklhx+p4U
 78+hKeIsRcLxJou07Ct6sykUBhkAESkSQC4yNa+Elzo5H9AfySn6JIn3QZzvQ3b1fLxS fA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pek27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 05:22:28 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Thu, 10 Nov
 2022 05:22:26 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Thu, 10 Nov 2022 05:22:27 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C8C3476;
        Thu, 10 Nov 2022 11:22:27 +0000 (UTC)
Message-ID: <c0c05799-6424-7edf-01b3-e28a10907b2c@opensource.cirrus.com>
Date:   Thu, 10 Nov 2022 11:22:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic
 CS48L31/32/33 codecs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-10-rf@opensource.cirrus.com>
 <87mt8zutib.wl-maz@kernel.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <87mt8zutib.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8S_O80bx2UQ4PY8ndGbnWR4MbPtL4s5G
X-Proofpoint-GUID: 8S_O80bx2UQ4PY8ndGbnWR4MbPtL4s5G
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 08:02, Marc Zyngier wrote:
> On Wed, 09 Nov 2022 16:53:28 +0000,
> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
>>
>> The Cirrus Logic CS48L31/32/33 audio codecs contain a programmable
>> interrupt controller with a variety of interrupt sources, including
>> GPIOs that can be used as interrupt inputs.
>>
>> This driver provides the handling for the interrupt controller. As the
>> codec is accessed via regmap, the generic regmap_irq functionality
>> is used to do most of the work.
>>
> 
> I cannot spot a shred of interrupt controller code in there. This

It is providing support for handling an interrupt controller so that
other drivers can bind to those interrupts. It's just that regmap
provides a lot of generic implementation for SPI-connected interrupt
controllers so we don't need to open-code all that in the
irqchip driver.

> belongs IMO to the MFD code.

We did once put interrupt support in MFD for an older product line but
the MFD maintainer doesn't like the MFD being a dumping-ground for
random other functionality that have their own subsystems.

>  It is also a direct copy of the existing
> irq-madera.c code, duplicated for no obvious reason.

It's not a duplicate. The register map of this device is different
(different addressing, 32-bit registers not 16-bit)

> 
> 	M.
> 
