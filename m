Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4497481C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGEKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGEKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:14:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2113E;
        Wed,  5 Jul 2023 03:14:26 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C619766018CF;
        Wed,  5 Jul 2023 11:14:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688552064;
        bh=2abyu5VJmEt3tb1PbtQ8yXrWLSAXhrHf+oXfvn2ghmo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f3iQDUhuHulywT0n0IOD0av3igx8ZWuBUmB4cPKu+bRKBfbgUEfI+UxwqdPHlGIsK
         y3lnpqYAm1IxJMNS27Z6RIPGLzcIW5LPQiKV/KGo3JX9YTdXVsI68G8IO1pYE8iRBx
         iphGWqpo8+c/JTX5azF65fZtmAeVOHq//b2ueZsxtG8zskHKbFD91Hn1mD3CbKSDNJ
         zoXWMO05yjfR20N+40dAgKxxrPQ5hSnGRvb6ACtlqb7oU5zEPoAr/jrs8loFwjqQi/
         /O8FEOzccvZ2L0bRO/VR4UrUpWhJALAQebtD2WKMcO+KtLnzxW7VPMpNn+1Js9/uTN
         7HpZrpAJEGShg==
Message-ID: <548f2a41-1f37-fe3a-6665-ae786e4c8f77@collabora.com>
Date:   Wed, 5 Jul 2023 12:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, bchihi@baylibre.com, wenst@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
 <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
 <20230703174347.4m6hcmify4jwsozv@pengutronix.de>
 <11052797-b006-11bb-e4eb-987ddd568b24@kernel.org>
 <20805fef-d6aa-91d8-999e-04b1d6b7a37a@vivo.com>
 <20230704141954.fcmol2yswkpbnpaw@pengutronix.de>
 <20230705101537.000059d2@Huawei.com>
 <20230705073000.oxlb7e7sdkdxurps@pengutronix.de>
 <c092b860-33d5-77c0-456c-367d545e8b7f@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c092b860-33d5-77c0-456c-367d545e8b7f@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/07/23 09:43, Yangtao Li ha scritto:
> On 2023/7/5 15:30, Uwe Kleine-König wrote:
> 
>> Hello,
>>
>> On Wed, Jul 05, 2023 at 10:15:37AM +0800, Jonathan Cameron wrote:
>>> On Tue, 4 Jul 2023 16:19:54 +0200
>>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>>
>>>> Hello,
>>>>
>>>> On Tue, Jul 04, 2023 at 05:06:12PM +0800, Yangtao Li wrote:
>>>>> On 2023/7/4 16:48, Krzysztof Kozlowski wrote:
>>>>>> [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms 
>>>>>> /LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>>>>>
>>>>>> On 03/07/2023 19:43, Uwe Kleine-König wrote:
>>>>>>> Hello Krzysztof,
>>>>>>>
>>>>>>> On Mon, Jul 03, 2023 at 02:31:59PM +0200, Krzysztof Kozlowski wrote:
>>>>>>>> On 03/07/2023 11:04, Yangtao Li wrote:
>>>>>>>>> There are more than 700 calls to the devm_request_threaded_irq method.
>>>>>>>>> Most drivers only request one interrupt resource, and these error
>>>>>>>>> messages are basically the same. If error messages are printed
>>>>>>>>> everywhere, more than 1000 lines of code can be saved by removing the
>>>>>>>>> msg in the driver.
>>>>>>>> ...
>>>>>>>>> +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
>>>>>>>>> +                              irq_handler_t handler, irq_handler_t 
>>>>>>>>> thread_fn,
>>>>>>>>> +                              unsigned long irqflags, const char *devname,
>>>>>>>>> +                              void *dev_id, const char *emsg)
>>>>>>>>> +{
>>>>>>>>> +   int rc;
>>>>>>>>> +
>>>>>>>>> +   rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
>>>>>>>>> +                                  devname, dev_id);
>>>>>>>>> +   if (rc && rc != -EPROBE_DEFER) {
>>>>>>>>> +           dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
>>>>>>>>> +                   thread_fn ? "threaded " : "", irq, devname ? : 
>>>>>>>>> dev_name(dev),
>>>>>>>>> +                   emsg ? : "", ERR_PTR(rc));
>>>>>>>> It is open-coding dev_err_probe(). Just use dev_err_probe instead.
>>>>>>> dev_err_probe is supposed to be only called in probe functions, while
>>>>>>> devm_request_threaded_irq might be called in other contexts (e.g. when a
>>>>>>> device is opened). That's why I asked to not use dev_err_probe() in v2
>>>>>> True, but then all the callers of this function will forget to set
>>>>>> deferred probe reason.
>>>> That's another reason for letting the driver issue the error message and
>>>> not the request_irq function.
>>>>> So let's use dev_err_probe?
>>>>>
>>>>> BTW, any suggestions for names here, keep using
>>>>> devm_request_threaded_irq_emsg or change to a new name?
>>>> I would have called it devm_request_threaded_irq_verbose() which I
>>>> consider easier to understand. But maybe  is just my (green)
>>>> bikeshed.
>>> If going to use dev_err_probe() internally maybe can just use
>>> devm_request_threaded_irq_probe() thus reflecting that and making
>>> it different to the devm_request_threaded_irq()?
>> I like devm_request_threaded_irq_probe(), thanks for that suggestion
>> (even though it's red :-)
> 
> 
> devm_request_threaded_irq_probe() also sounds good to me, :-) If there is no 
> objection, I think it's time to start working on switching the api.
> 

+1 on devm_request_threaded_irq_probe() name, makes sense to me, as it'd be
using the same error logic as dev_err_probe() (no prints if -EPROBE_DEFER),
and also.. this is a function that's anyway used in .probe() callbacks at
least in the *vast* majority of the cases.

Cheers,
Angelo

> int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq, 
> irq_handler_t handler, irq_handler_t thread_fn, unsigned long irqflags, const char 
> *devname, void *dev_id, const char *info) { int rc; rc = 
> devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id); if 
> (rc) return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n", 
> thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev), info ? : ""); return 
> 0; } EXPORT_SYMBOL(devm_request_threaded_irq_probe); MBR, Yangtao
> 
> 
>>
>> Best regards
>> Uwe
>>

