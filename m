Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AC745D90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGCNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F3E41;
        Mon,  3 Jul 2023 06:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98F0760F3E;
        Mon,  3 Jul 2023 13:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1778C433C8;
        Mon,  3 Jul 2023 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688391449;
        bh=mdjfMlB9hWcQuuvCh4C/RYuY26QuKk1rnzzxz5iy9LE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HWly50qCniJRfYL/8TVUTx0uAx63NuOfafqUc1CDwazaJHgukKtR4vIsogPXIdRt4
         MZuxFHzroI5/HtF6nbqBB7WZcaqYKjDKioVxgRly8qj8QOWuZM+6f1CuYt0PG5ver9
         Gg1gWu9hPpYIJ4K1ddZ6+62/PiomO8RdxN0Uc/HQlg0sJkVZVnhnIZe/kVhSXYwwlD
         xR1IfGq01iU1KwqfEb46gCbvw/pRB/AnlUk723++yPV+0QDbxQ2fbR4s3PvwxNzCan
         B7J0qrDhqJppnh5DIbq7UBILkuJcS4VKviT0LCGAvIyr9bH2PUt2cinafyLwLn0vNV
         dldZyfRbt6QoQ==
Message-ID: <cce616da-fb1b-ef0b-69de-11a14d4b3e7b@kernel.org>
Date:   Mon, 3 Jul 2023 15:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
 <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
 <930003c4-c90d-0008-a6cf-9298240e7d93@vivo.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <930003c4-c90d-0008-a6cf-9298240e7d93@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 15:24, Yangtao Li wrote:
> 
> On 2023/7/3 20:31, Krzysztof Kozlowski wrote:
>> [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>
>> On 03/07/2023 11:04, Yangtao Li wrote:
>>> There are more than 700 calls to the devm_request_threaded_irq method.
>>> Most drivers only request one interrupt resource, and these error
>>> messages are basically the same. If error messages are printed
>>> everywhere, more than 1000 lines of code can be saved by removing the
>>> msg in the driver.
>>
>> ...
>>
>>> +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
>>> +                                irq_handler_t handler, irq_handler_t thread_fn,
>>> +                                unsigned long irqflags, const char *devname,
>>> +                                void *dev_id, const char *emsg)
>>> +{
>>> +     int rc;
>>> +
>>> +     rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
>>> +                                    devname, dev_id);
>>> +     if (rc && rc != -EPROBE_DEFER) {
>>> +             dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
>>> +                     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
>>> +                     emsg ? : "", ERR_PTR(rc));
>> It is open-coding dev_err_probe(). Just use dev_err_probe instead.
> 
> 
> How about the following? If possible, I would like to start modifying 
> more drivers in the next version.
> 
> 
> int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
>                                     irq_handler_t handler, irq_handler_t 
> thread_fn,
>                                     unsigned long irqflags, const char 
> *devname,
>                                     void *dev_id, const char *emsg)
> {
>          int rc;
> 
>          rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
>                                         devname, dev_id);
>          if (rc) {
>                  dev_err_probe(dev, rc, "Failed to request %sinterrupt 
> %u %s %s\n",
>                                thread_fn ? "threaded " : "", irq, 
> devname ? : dev_name(dev),
>                                emsg ? : "");

That's not the syntax already used - see existing code with `git grep`.
Instead - return dev_err_probe().


Best regards,
Krzysztof

