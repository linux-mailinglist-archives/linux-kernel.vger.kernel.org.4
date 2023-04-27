Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85C6F004E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbjD0FHQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbjD0FHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:07:12 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247B4489;
        Wed, 26 Apr 2023 22:07:08 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E186C24E12B;
        Thu, 27 Apr 2023 13:06:54 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Apr
 2023 13:06:54 +0800
Received: from [192.168.155.161] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Apr
 2023 13:06:51 +0800
Message-ID: <65fde5d5-6d86-c94e-9985-231e81641386@starfivetech.com>
Date:   Thu, 27 Apr 2023 13:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 2/4] crypto: starfive - Add crypto engine support
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <kernel@esmil.dk>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <robh+dt@kernel.org>
References: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
 <20230426065848.842221-3-jiajie.ho@starfivetech.com>
 <c3faff36-3698-a137-f007-ff8bca6a2e88@wanadoo.fr>
Content-Language: en-US
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <c3faff36-3698-a137-f007-ff8bca6a2e88@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/4/2023 3:56 pm, Christophe JAILLET wrote:
> Le 26/04/2023 à 08:58, Jia Jie Ho a écrit :
>> Adding device probe and DMA init for StarFive cryptographic module.
>>
>> Co-developed-by: Huan Feng <huan.feng-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
>> Signed-off-by: Huan Feng <huan.feng-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
>> Signed-off-by: Jia Jie Ho <jiajie.ho-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
>> ---
>>   MAINTAINERS                           |   7 +
>>   drivers/crypto/Kconfig                |   1 +
>>   drivers/crypto/Makefile               |   1 +
>>   drivers/crypto/starfive/Kconfig       |  17 +++
>>   drivers/crypto/starfive/Makefile      |   4 +
>>   drivers/crypto/starfive/jh7110-cryp.c | 199 ++++++++++++++++++++++++++
>>   drivers/crypto/starfive/jh7110-cryp.h |  63 ++++++++
>>   7 files changed, 292 insertions(+)
>>   create mode 100644 drivers/crypto/starfive/Kconfig
>>   create mode 100644 drivers/crypto/starfive/Makefile
>>   create mode 100644 drivers/crypto/starfive/jh7110-cryp.c
>>   create mode 100644 drivers/crypto/starfive/jh7110-cryp.h
>>

[...]

>> +
>> +static int starfive_dma_init(struct starfive_cryp_dev *cryp)
>> +{
>> +    dma_cap_mask_t mask;
>> +
>> +    cryp->tx = NULL;
>> +    cryp->rx = NULL;
> 
> Harmless, but 'crypt' is kzalloc()'ed, so these fields are already NULL.
>

Hi Christophe,
I'll remove these in the next version.
 
>> +
>> +    dma_cap_zero(mask);
>> +    dma_cap_set(DMA_SLAVE, mask);
>> +
>> +    cryp->tx = dma_request_chan(cryp->dev, "tx");
>> +    if (IS_ERR(cryp->tx))
>> +        return dev_err_probe(cryp->dev, PTR_ERR(cryp->tx),
>> +                     "Error requesting tx dma channel.\n");
>> +
>> +    cryp->rx = dma_request_chan(cryp->dev, "rx");
>> +    if (IS_ERR(cryp->rx)) {
>> +        dma_release_channel(cryp->tx);
>> +        return dev_err_probe(cryp->dev, PTR_ERR(cryp->rx),
>> +                     "Error requesting rx dma channel.\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void starfive_dma_cleanup(struct starfive_cryp_dev *cryp)
>> +{
>> +    dma_release_channel(cryp->tx);
>> +    dma_release_channel(cryp->rx);
>> +}
>> +
>> +static int starfive_cryp_probe(struct platform_device *pdev)
>> +{

[...]

>> +
>> +    ret = crypto_engine_start(cryp->engine);
>> +    if (ret)
>> +        goto err_engine_start;
>> +
>> +    return 0;
>> +
>> +err_engine_start:
>> +    crypto_engine_exit(cryp->engine);
>> +err_engine:
>> +    starfive_dma_cleanup(cryp);
>> +err_dma_init:
>> +    spin_lock(&dev_list.lock);
>> +    list_del(&cryp->list);
>> +    spin_unlock(&dev_list.lock);
> 
> I think that there should be:
>     clk_disable_unprepare(cryp->hclk);
>     clk_disable_unprepare(cryp->ahb);
>     reset_control_assert(cryp->rst);
> 
> as in the remove function.
> 

Will add these in next version.

>> +
>> +    return ret;
>> +}
>> +
>> +static int starfive_cryp_remove(struct platform_device *pdev)
>> +{
>> +    struct starfive_cryp_dev *cryp = platform_get_drvdata(pdev);
>> +
>> +    if (!cryp)
>> +        return -ENODEV;
> 
> I don't think that this can happen.
> 

I'll update this too along with your other comments.
Thanks for taking time reviewing this patch series.

Best regards,
Jia Jie


