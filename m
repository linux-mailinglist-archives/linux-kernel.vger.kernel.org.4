Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF16E1CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDNHJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNHJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:09:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A5E4B;
        Fri, 14 Apr 2023 00:09:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A4506603219;
        Fri, 14 Apr 2023 08:09:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681456146;
        bh=U5N+jJxH6HE3r7En//JC+y3anV8kUBxIvdmCQ40tbVE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=knC+7Ivdk4BhD7brVOF56moGdveXZXswraELz1DRd92QuFCPmgiZ/JVsB+hgeuLyn
         PqvpTtgUWzfdxTox23jfj3uSVQ0uGUq/oDoGmjP8IvIUOfoCyQjlWtwUCMTg0cdOrh
         2qRictBPzwtx7j0smxP+kXKiLnemdwjmUkTaw6Bl/LvPYrFVk2F2iwFWqNbkx2kBpJ
         mOIZD8ppSp4DP9HRzfMy9d5nJqVVVR6pxEQ9ZG4vTh8zAb5oci48o5ibZa4GlUP1t+
         oi7GSMB/mtT0D4pFvbx3f/UQamQ2hsdiUQXBLnge3pqbp+oMi5tS4uv/Ntp+glMM8y
         x7w0Xa1mivybQ==
Message-ID: <0a297b99-a1f2-eeec-b3da-e2a510e0a714@collabora.com>
Date:   Fri, 14 Apr 2023 09:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and
 MT6332
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, sean.wang@mediatek.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
 <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
 <76c89ad1-a189-c907-590c-35ae6b7edd9e@collabora.com>
 <20230414070748.GB1036697@google.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230414070748.GB1036697@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/23 09:07, Lee Jones ha scritto:
> On Thu, 13 Apr 2023, AngeloGioacchino Del Regno wrote:
> 
>> Il 13/04/23 13:06, Pavel Machek ha scritto:
>>> Hi!
>>>
>>>> Add basic code to turn on and off WLEDs and wire up MT6332 support
>>>> to take advantage of it.
>>>> This is a simple approach due to to the aforementioned PMIC supporting
>>>> only on/off status so, at the time of writing, it is impossible for me
>>>> to validate more advanced functionality due to lack of hardware.
>>>
>>>
>>>> @@ -467,14 +590,24 @@ static int mt6323_led_probe(struct platform_device *pdev)
>>>>    			goto put_child_node;
>>>>    		}
>>>> +		is_wled = of_property_read_bool(child, "mediatek,is-wled");
>>>> +
>>>
>>> This needs documenting in the binding, no?
>>
>> Yes, and I forgot to. Would it be okay if I send a supplementary patch out
>> of this series to document that since the bindings are already acked?
> 
> You can add the support as part of a new patch.
> 
> Please resend this series with it attached.
> 
Perfect - will do!

Thanks,
Angelo
