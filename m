Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D3570495A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEPJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjEPJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:31:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A610F8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:31:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9659443fb56so2177348366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684229500; x=1686821500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nihm3Do/jYZpk5hTKjhQtOwCyKKzOg7ffIDGvfFkZDY=;
        b=E2OQ4sV77vnvS3oG+lICbJM8PRrM0Is0aTrjTci7hnYWEF03LsA5F3vzNIkclaoSoF
         uDpC1BvLXFrx6JJvnNO/wuUExwsdcxdGyGdwAhfH8KvAkMenO+qGftPHZsbuDM0y0Qmj
         rMMkDbQ+buTOrmNHEraj4COZs1ZOCm30l59N4HAZ+fHC8ymVp5T6a/kQWZZwKFRkqcm/
         +exwEJf+5Zb1lqYVmH5SiP3A5PKeN1lwvxBk+TIZqjeR9hio957ljYRWCZPutYVsK0a1
         SeWa7/PfZnJhqFvSCpg2KfZa992P9QzcD4XqHUQ1/D6w1Jg7L43zuTf21eBYXYgE3f35
         B8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229500; x=1686821500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nihm3Do/jYZpk5hTKjhQtOwCyKKzOg7ffIDGvfFkZDY=;
        b=By5Tr7CivDSOvky3Pu5XQiunfjS18YDxAEdogyWXrHCPudPNjkds5fHxvNDyfuh4to
         uv2V+/xzgj8FcFYfqZGQXV2qssGGGny+GmbIz8ZFSiDpLkG+2hyRuu/71QiyqzNlm/B0
         H/WlpmnSyLpLSOo6Y1usSw+KKMQ6B1XWF3aU7GVQqzH425ACIKstqSgM1We2ncg82atV
         CGLU6fqacYF6+Uj+7fOmrNNX/rS++S5DPLyf7XtXnR3vaQSD72M6cioJr9iuSy5O32Au
         HlLmiqeOdpHy/2AsFnmEbSibToBtP09GBfDJnrXSTPJYtnaosbRRNp4mjVh0D6cI7cCu
         Ii0A==
X-Gm-Message-State: AC+VfDztWnFmvAMnum6KsASxDz+QAvVVU9X+ZAu/hvO65VLfwAeRrGO4
        XkqN5Fmxz4Xm3U8+yN9IG3IRQA==
X-Google-Smtp-Source: ACHHUZ5S7lHC9GBB63RVot5UzBveUyGBIm2S66/kFGOsCzwp9dmxU9oMaB3+0GcTywB8/5fNKb3Bcg==
X-Received: by 2002:a17:907:2d91:b0:969:f3b4:83 with SMTP id gt17-20020a1709072d9100b00969f3b40083mr22191059ejc.71.1684229499757;
        Tue, 16 May 2023 02:31:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00965fdb90801sm10804120ejz.153.2023.05.16.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:31:39 -0700 (PDT)
Message-ID: <0aa96881-73ee-0aa5-efc7-7fa94248789d@linaro.org>
Date:   Tue, 16 May 2023 11:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 RESEND 0/4] Add S4 SoC PLL and Peripheral clock
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230516064736.10270-1-yu.tu@amlogic.com>
 <c4d30304-08d8-6a31-8f91-7840fe2922fb@linaro.org>
 <bfc27a11-9be1-2391-3d26-62aa29fac190@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bfc27a11-9be1-2391-3d26-62aa29fac190@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 11:25, Yu Tu wrote:
> 
> 
> On 2023/5/16 17:20, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 16/05/2023 08:47, Yu Tu wrote:
>>> 1. Add S4 SoC PLL and Peripheral clock controller dt-bindings.
>>> 2. Add PLL and Peripheral clock controller driver for S4 SOC.
>>>
>>> Yu Tu (4):
>>>    dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
>>>    dt-bindings: clock: document Amlogic S4 SoC peripherals clock
>>>      controller
>>>    clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
>>>    clk: meson: s4: add support for Amlogic S4 SoC peripheral clock
>>>      controller
>>>
>>> V7 -> V8:
>>> 1. Change patch 0001/0002 dt-bindings title description, remove "meson".
>>> Suggested by Dmitry, Neil.
>>
>> So you only removed one word from title and description? This does not
>> justify dropping review tag.
> 
> Yes. I just remove one work.
> 
>>
>> You already got a comment for this - add the tag.
> 
> I wonder what I should do next?
> Add the tag and RESEND it again?

I cannot add other people tags, e.g. b4 ignores them.

Best regards,
Krzysztof

