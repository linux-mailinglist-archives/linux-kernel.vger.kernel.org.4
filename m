Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A36E0C73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDML3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDML3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:29:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4289740;
        Thu, 13 Apr 2023 04:29:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5D446603212;
        Thu, 13 Apr 2023 12:29:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681385390;
        bh=bvenpCUXdyjjQEZArC0d3YuEErYsBVLrl7zmm7hLLgU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bm0jDJcBNEQXa1Ue8FRql2CVOwseKGKuXaSAt56oxwcwKKfMJ5mWYSTO+Afclx9Uh
         Cp+YADPst8MAbWzan1Vaz0Zt2LjLK9Yx2/+uQaFfO6DreqPEwBI3MnnzgqFN84TdSz
         Ze5TZBYW6zQ8ALWAA/b9KgqguuGe1kuP1PbGl2V/eWzJrTtrIQJPd489fcC3TlGHOP
         rJ/FY3ljHLAxXd1Z4RVu9hUqkOQcIzKV1v92BPGoiEPWCjZvYlCsx7EI2AEice40RU
         0prTs0NN2AOGbT2R4HVI6mkgqftOrE/W4u+PXzbNChFKLsAyQ7RTo3r+3cslonBtjS
         9Uz5SVc5lJD2Q==
Message-ID: <04d2b53e-4f5e-81ec-3397-e58898b7039e@collabora.com>
Date:   Thu, 13 Apr 2023 13:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and
 MT6332
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
 <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 13:06, Pavel Machek ha scritto:
> Hi!
> 
>> Add basic code to turn on and off WLEDs and wire up MT6332 support
>> to take advantage of it.
>> This is a simple approach due to to the aforementioned PMIC supporting
>> only on/off status so, at the time of writing, it is impossible for me
>> to validate more advanced functionality due to lack of hardware.
> 
> 
>> @@ -467,14 +590,24 @@ static int mt6323_led_probe(struct platform_device *pdev)
>>   			goto put_child_node;
>>   		}
>>   
>> +		is_wled = of_property_read_bool(child, "mediatek,is-wled");
>> +
> 
> This needs documenting in the binding, no?
> 
>> +static const struct mt6323_hwspec mt6332_spec = {
>> +	/* There are no LEDs in MT6332. Only WLEDs are present. */
> 
> "Only WLED is present"?
> 
>> +	.max_leds = 0,
>> +	.max_wleds = 1,
>> +	.max_brightness = 1024,
>> +};
>> +
> 
> Is there chip with both LED and WLEDs? (I'm wondering if this makes
> sense in single driver).
> 

Some PMICs have got both LED(s) and WLED(s), yes - this is only on smartphone
designs though.

Regards,
Angelo

