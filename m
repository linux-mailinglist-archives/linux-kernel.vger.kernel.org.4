Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC5706742
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjEQL4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjEQL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:56:07 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 04:56:05 PDT
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32103A81;
        Wed, 17 May 2023 04:56:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 378EF55706;
        Wed, 17 May 2023 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1684323464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=nZdcMDZM53ILRxlH9g59ieKwhVNPywvAfYb6Qja4wac=;
        b=DwlMOFGPGqaVRFP97Pvxw+TihOVYHCxLgopEWyALgUQ2pe0bSLNW1KVGBYza6rEo5I4aI9
        nvGmxNzn8NsnuozBDiTeN4qhNZa87VkxcuhzegzKNzJG2gDsgOSNQ4uDDIyuv+SMs+VsPT
        E+OcXyZ79qlqYcHqWNVk+RqC6p5jE+uFx73qFtyuJoP916Zg74GSSmOOKaprBoCqP+fOUu
        H5ns5segL9BFppgvQ25yV6ojCEP/SFQB0qD/hatLQMf23LyAKwhnLtXytlrtgAp3SZZP57
        FXmjjAM+hYjcKOqcD9wP/k8VM86aY4ugixmYsT25mLcx48x19h/e0Q056sLoDg==
Message-ID: <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in>
Date:   Wed, 17 May 2023 14:37:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        andy.shevchenko@gmail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
Content-Language: en-US, ru, ru-RU
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin,

On 16.05.2023 22:08, Martin Blumenstingl wrote:
> Hi George,
> 
> thank you for this patch!
> 
> On Mon, May 15, 2023 at 11:06 PM George Stark <gnstark@sberdevices.ru> wrote:
>>
>> From: George Stark <GNStark@sberdevices.ru>
>>
>> According to datasheets of supported meson SOCs
>> length of ADC_CLK_DIV field is 6 bits long
> I have a question about this sentence which doesn't affect this patch
> - it's only about managing expectations:
> Which SoC are you referring to?

I checked the 905x, 905x3, a113x datasheets - there is the same register 
with 6 bits for  ADC_CLK_DIV

> This divider is only relevant on older SoCs that predate GXBB (S905).
> To my knowledge all SoCs from GXBB onwards place the divider in the
> main or AO clock controller, so this bitmask is irrelevant there.
> 
>> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
>> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> Since my question above doesn't affect this patch:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Vyacheslav Bocharov
