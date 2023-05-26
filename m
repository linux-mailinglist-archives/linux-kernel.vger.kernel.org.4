Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4E712154
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbjEZHmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbjEZHmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:42:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC2819D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:42:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6cbdf16d2so2728445e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685086957; x=1687678957;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NkTkGDMVJA48vFPtaSjIeYrGpqqTSqfQ3e0MrBnwrbs=;
        b=xz3haS1KXQLY2AyRechw8Fk0OwpajCfzX8pzwP7F7lcIurYVEfVUSTIJ/6dMylYFSp
         CF17Dhd+xW3AREahs3Gy7lsQEL/b6/XDEO4WZq+AFKAGxzrChCSf3bKWND9ZWwwVuVUr
         MQrH7gWys3cygr092RBrAl7lGEFXv8ElesV248sw6PjhUqk0uge2kO+B0inreW6vdWmW
         zqKNz3Vjm7ZkvcpUne4eZ9EMUANjjiKdQIE5jARMRa3G6Ot/Co51BhtRzrQ6KnNCQiae
         FmjBGKDkJX1VwObvtvOW9Z/Xfz92iIxw/hdQMVczkgU0rUegLwDyVP8COWgqqVx1y9E4
         442Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685086957; x=1687678957;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkTkGDMVJA48vFPtaSjIeYrGpqqTSqfQ3e0MrBnwrbs=;
        b=DEGGcXzt3g2iq9b5/yMujbRg1lpCfMloVP4CfdjxnaHq/s/anBN3N9F9/fQUBSa7HO
         s/4kPO0TZKoMOu3jvxXVuRyWZxIPxe7c/VxKvu27EZD+fuahrneMTbcxplz8AVWuj+0P
         veUUio6xQbx9K2LlVTbOwMn5lmJM4FaK3k0flxBXXQBDgU22z39kp2raTaXjPbr0jf+F
         VwXHssLUhFV4THysRLI2ilCCBgZaIOOH4RDzg6pvG5udDque8vd5SZchEuLzybYmfPcT
         Favsh/POu4C3G6OGy6iTuAXBCZjgyDmxxHB4tENdgfdrk67hkoQjOqzrYnKLoMZj0nc7
         OuoA==
X-Gm-Message-State: AC+VfDyo5O/a7d8q3zTA0wdoBdev18qRKTiAyOL259/Lo2pubHktF3vo
        hK5dk682u5544vjONk/Ug7+VCw==
X-Google-Smtp-Source: ACHHUZ78glX9owiGGfj2LcnoXd+JjAb5MfcnsGRZKu/lCr6am4/SgX/kuL7OXyh5yod59igD+QEHkA==
X-Received: by 2002:a1c:7c19:0:b0:3f4:f4d1:5c28 with SMTP id x25-20020a1c7c19000000b003f4f4d15c28mr620538wmc.24.1685086957200;
        Fri, 26 May 2023 00:42:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0? ([2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c7413000000b003f60e143d38sm4305405wmc.11.2023.05.26.00.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 00:42:34 -0700 (PDT)
Message-ID: <1c5dd13f-8221-09e6-5b7d-a06135ce97f7@linaro.org>
Date:   Fri, 26 May 2023 09:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Visionox R66451
 AMOLED DSI panel bindings
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230516-b4-r66451-panel-driver-v1-0-4210bcbb1649@quicinc.com>
 <20230516-b4-r66451-panel-driver-v1-1-4210bcbb1649@quicinc.com>
 <dzekdzubv6y5evn4j62hnntjdexcdi5ar2wj6hcm3dffx5jei4@h32wgmfalzvl>
 <0d436948-b0b7-0727-0852-51f64aefa43f@linaro.org>
 <sf4fsrvuvgn42ucrwgqlrgprlr3sofq4wqeeuxryzeubxqs4kz@r4dmwzproti4>
Organization: Linaro Developer Services
In-Reply-To: <sf4fsrvuvgn42ucrwgqlrgprlr3sofq4wqeeuxryzeubxqs4kz@r4dmwzproti4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 16:51, Marijn Suijten wrote:
> On 2023-05-22 11:05:38, Neil Armstrong wrote:
>> On 21/05/2023 12:30, Marijn Suijten wrote:
>>> On 2023-05-16 13:20:30, Jessica Zhang wrote:
>>>> Document the 1080x2340 Visionox R66451 AMOLED DSI panel bindings
>>>>
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>    .../bindings/display/panel/visionox,r66451.yaml    | 59 ++++++++++++++++++++++
>>>>    1 file changed, 59 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
>>>> new file mode 100644
>>>> index 000000000000..6ba323683921
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
>>>> @@ -0,0 +1,59 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/display/panel/visionox,r66451.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Visionox R66451 AMOLED DSI Panel
>>>> +
>>>> +maintainers:
>>>> +  - Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: panel-common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: visionox,r66451
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description: DSI virtual channel
>>>> +
>>>> +  vddio-supply: true
>>>> +  vdd-supply: true
>>>> +  port: true
>>>> +  reset-gpios: true
>>>
>>> Normally for cmd-mode panels there is also a `disp-te` pin which is
>>> optionally registered in dsi_host.c as GPIOD_IN, but on **ALL** my Sony
>>> phones this breaks vsync (as in: mdp5 stops receiving the interrupt, but
>>> we can see disp-te in /proc/interrupts then).
>>
>> Describing it as a gpio is wrong, it should be described as a pinctrl state instead.
> 
> We defined both in our DTS, what weirdness does it cause when then
> requested using GPIOD_IN?  It'd still be beneficial to see the vsync
> interrupt raise in /proc/interrupts (but it's just a waste of CPU cycles
> OTOH, this is all handled in the MDP hardware after all, so it's not
> something I'd like to enable by default).

Sure, but it's a sw hack, the pin has a TE function which directly goes to
the DSI logic, claiming it as a GPIO will set it as GPIO function.

On some platforms, PINMUX is only on output and input is always directed
to all HW blocks, seems it's not the case here !

> 
> Anyway, this is what we ended up doing to "fix" the bug (only bias the
> pin via pinctrl, omit the disp-te DTS property).  Thanks for confirming!
> 
> - Marijn
> 
>>
>> Neil
> 
> <snip>

