Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73AE649AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiLLJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiLLJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:18:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E91082;
        Mon, 12 Dec 2022 01:17:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5E75B80BD9;
        Mon, 12 Dec 2022 09:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6215C433D2;
        Mon, 12 Dec 2022 09:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670836670;
        bh=1J+2d5+KvpjVI5MmaRd9+WDqn+ERDvdaS29aqYsYa/Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tB0jPT22rUA0Zv5wTTTjEgcYyrnXRIHk5CWAT3kHJaDGTcpzkRsJ5H/cY80k+sk95
         kLMJHHg2NwjoeYdQYG0ia+kx3dDvJUAhsdEGLKkDHE1PuhW1ULtmL8rDYMsIP9cF5p
         BYK8zgOj3iPuoHt+5cNWwKQUYfWsfvfypQD8WOika4mVQDE/x7gT+RxB7eJDEIhh04
         6odPC/RP2+1+oNUwUUljXc0+Fff9h0eSW3GOEiYLKjVmOw70666kL0JZGBe6c/riC/
         OJiQovjdKXOvKc90Tk379+kLC+5segGoy52cuhWmJyDMCmI/lyEAwtWtHo6aY9S0YL
         4NbSGlqYE8+vw==
Message-ID: <7d73a0a4-c5e2-74bb-4ef9-9bc2dadd6272@kernel.org>
Date:   Mon, 12 Dec 2022 11:17:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH v11 3/6] remoteproc: pru: Add APIs to get
 and put the PRU cores
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221207110411.441692-1-danishanwar@ti.com>
 <20221207110411.441692-4-danishanwar@ti.com>
 <77d79939-53bb-bc27-a8f8-ea5bf509a15f@kernel.org>
 <a8b8ba60-0413-5568-ae9a-57c25840dca7@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <a8b8ba60-0413-5568-ae9a-57c25840dca7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Danish,

On 09/12/2022 06:55, Md Danish Anwar wrote:
> Hi Roger,
> 
> On 08/12/22 16:05, Roger Quadros wrote:
>> Hi,
>>
>> On 07/12/2022 13:04, MD Danish Anwar wrote:
>>> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
>>> driver to allow client drivers to acquire and release the remoteproc
>>> device associated with a PRU core. The PRU cores are treated as
>>> resources with only one client owning it at a time.
>>>
>>> The pru_rproc_get() function returns the rproc handle corresponding
>>> to a PRU core identified by the device tree "ti,prus" property under
>>> the client node. The pru_rproc_put() is the complementary function
>>> to pru_rproc_get().
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  drivers/remoteproc/pru_rproc.c | 133 ++++++++++++++++++++++++++++++++-
>>>  include/linux/pruss.h          |  29 +++++++
>>>  2 files changed, 160 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>>> index a1a208b31846..7d4ed39b3772 100644
>>> --- a/drivers/remoteproc/pru_rproc.c
>>> +++ b/drivers/remoteproc/pru_rproc.c
>>> @@ -2,12 +2,14 @@
>>>  /*
>>>   * PRU-ICSS remoteproc driver for various TI SoCs
>>>   *
>>> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
>>> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
>>>   *
>>>   * Author(s):
>>>   *	Suman Anna <s-anna@ti.com>
>>>   *	Andrew F. Davis <afd@ti.com>
>>>   *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
>>> + *	Puranjay Mohan <p-mohan@ti.com>
>>> + *	Md Danish Anwar <danishanwar@ti.com>
>>>   */
>>>  
>>>  #include <linux/bitops.h>
>>> @@ -112,6 +114,8 @@ struct pru_private_data {
>>>   * @rproc: remoteproc pointer for this PRU core
>>>   * @data: PRU core specific data
>>>   * @mem_regions: data for each of the PRU memory regions
>>> + * @client_np: client device node
>>> + * @lock: mutex to protect client usage
>>>   * @fw_name: name of firmware image used during loading
>>>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>>>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
>>> @@ -127,6 +131,8 @@ struct pru_rproc {
>>>  	struct rproc *rproc;
>>>  	const struct pru_private_data *data;
>>>  	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
>>> +	struct device_node *client_np;
>>> +	struct mutex lock;
>>>  	const char *fw_name;
>>>  	unsigned int *mapped_irq;
>>>  	struct pru_irq_rsc *pru_interrupt_map;
>>> @@ -147,6 +153,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>>>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>>>  }
>>>  
>>> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>>> +{
>>> +	struct rproc *rproc;
>>> +	phandle rproc_phandle;
>>> +	int ret;
>>> +
>>> +	ret = of_property_read_u32_index(np, "ti,prus", index, &rproc_phandle);
>>> +	if (ret)
>>> +		return ERR_PTR(ret);
>>> +
>>> +	rproc = rproc_get_by_phandle(rproc_phandle);
>>> +	if (!rproc) {
>>> +		ret = -EPROBE_DEFER;
>>> +		goto err_no_rproc_handle;
>>> +	}
>>> +
>>> +	/* make sure it is PRU rproc */
>>> +	if (!is_pru_rproc(rproc->dev.parent)) {
>>> +		rproc_put(rproc);
>>> +		return ERR_PTR(-ENODEV);
>>> +	}
>>> +
>>> +	return rproc;
>>> +
>>> +err_no_rproc_handle:
>>> +	rproc_put(rproc);
>>> +	return ERR_PTR(ret);
>>> +}
>>> +
>>> +/**
>>> + * pru_rproc_get() - get the PRU rproc instance from a device node
>>> + * @np: the user/client device node
>>> + * @index: index to use for the ti,prus property
>>> + * @pru_id: optional pointer to return the PRU remoteproc processor id
>>> + *
>>> + * This function looks through a client device node's "ti,prus" property at
>>> + * index @index and returns the rproc handle for a valid PRU remote processor if
>>> + * found. The function allows only one user to own the PRU rproc resource at a
>>> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
>>> + * required if the function returns a failure.
>>> + *
>>> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
>>> + * returned.
>>> + *
>>> + * Return: rproc handle on success, and an ERR_PTR on failure using one
>>> + * of the following error values
>>> + *    -ENODEV if device is not found
>>> + *    -EBUSY if PRU is already acquired by anyone
>>> + *    -EPROBE_DEFER is PRU device is not probed yet
>>> + */
>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>>> +			    enum pruss_pru_id *pru_id)
>>> +{
>>> +	struct rproc *rproc;
>>> +	struct pru_rproc *pru;
>>> +	struct device *dev;
>>> +	int ret;
>>> +
>>> +	rproc = __pru_rproc_get(np, index);
>>> +	if (IS_ERR(rproc))
>>> +		return rproc;
>>> +
>>> +	pru = rproc->priv;
>>> +	dev = &rproc->dev;
>>> +
>>> +	mutex_lock(&pru->lock);
>>> +
>>> +	if (pru->client_np) {
>>> +		mutex_unlock(&pru->lock);
>>> +		put_device(dev);
>>
>> Is this put_device() to counter balance the get_device() you had earlier?
>> Is it still needed?
>>> Did we do the right thing by getting rid of the additional get_device()?
>> I didn't see a reason for it.
>>
> 
> The previous get_device() in __pru_rproc_get() was additional/not required as
> the same get_device() was called by rproc_get_by_phandle() API before it's
> completion.
> 
> So that get_device() is not needed.
> 
> The put_device() here is to counter the get_device() called by
> rproc_get_by_phandle() in the API __pru_rproc_get().
> 
> So I think, this put_device() is still needed.

But at the end of this function we are calling rproc_put()
which also does a put_device(), right?

> 
>>> +		ret = -EBUSY;
>>> +		goto err_no_rproc_handle;
>>> +	}
>>> +
>>> +	pru->client_np = np;
>>> +
>>> +	mutex_unlock(&pru->lock);
>>> +
>>> +	if (pru_id)
>>> +		*pru_id = pru->id;
>>> +
>>> +	return rproc;
>>> +
>>> +err_no_rproc_handle:
>>> +	rproc_put(rproc);
>>> +	return ERR_PTR(ret);
>>> +}
>>> +EXPORT_SYMBOL_GPL(pru_rproc_get);

<snip>

cheers,
-roger
