Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA6701931
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEMS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEMS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:28:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039E1BC2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:28:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so99296870a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684002506; x=1686594506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/skyL1sLWdeVWQOTLH4B/eNUzzrc9hV+v4n2aX70iXk=;
        b=G0WSmFIDrbVpJnxA9vpq/+boMjF9sbPpuRcq/wRTF+rvSiPClVefSbA/Jm14QEe6PX
         BXt+NA2Bbavm3P/r6lUp+m42FltmWO2O2Eo+W9Y2YjVaObvHtfcVQeKMGEkhMIP1EvHr
         RxYaVGxah6XG4y7V8ffKGPej4l7rM/TxK2jSHEWLR6AIplNAhqjjLptXJAfQnbBd6ooD
         dk71FI55LsAlOFey7nU7iP4DPulUDmZiLTi9pfMSkcXAZ4VYcABlBQM1RiXRIfEy0JJN
         snHoVzbzI6sxKlgJO4SlWsiBWaJXpjiaSjNi02viIIhOjY7O9QniU+IXRz7CDIAVh2c1
         n5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684002506; x=1686594506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/skyL1sLWdeVWQOTLH4B/eNUzzrc9hV+v4n2aX70iXk=;
        b=eHjZOvIOP4Y5bAYRFfUu/z4eb9b7UCKGGjbYuD9jjxzmCUY2kJtRDoW0OJfhfh6Xa6
         22PEwTBQVU71WtzSA2wjnuMudKXPFFCLZsrEEAh+K4GjHvKk27JIVeZ9CtKx/epfioLT
         69AzQTc77hg7x01xgyFQ6wsN2S728mNgXknG06Q3q5Q15dh/hATqt42w6+JfTOX7emDO
         E+W4YN4wYRX7V+DKMUVupwCg4PZjl3eodiPEGXmQ8u/aFvWzI0adCwBgsf2zIkpwNxWw
         I4lLv8Eg6fkEyFfz+fN3mphWs1BfQaiXXG+awm8m0j/pUSP0qtiYgZ/8AUQBdMRp5/Cg
         Sz8g==
X-Gm-Message-State: AC+VfDy5oBYKE0SIZXi96cQgGWXToa8CdtSbi2FrF5epiTC0XL+u/e3J
        pkgG6kasYZOwfKfh8syxlG23xw==
X-Google-Smtp-Source: ACHHUZ6BZjAGfoNRaV4SZYpzLVlE5wxvvxIlWnwclnXWyUvW+KjYeL4jTHPXBIuhzNmNzRxBc6Fsmw==
X-Received: by 2002:a17:907:1c8c:b0:965:cac1:53ad with SMTP id nb12-20020a1709071c8c00b00965cac153admr28615039ejc.8.1684002506136;
        Sat, 13 May 2023 11:28:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id de9-20020a1709069bc900b0094e6a9c1d24sm7172177ejc.12.2023.05.13.11.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:28:25 -0700 (PDT)
Message-ID: <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
Date:   Sat, 13 May 2023 20:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL
 and add CTS_ENCL clock ids
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 15:11, Neil Armstrong wrote:
> Expose VCLK2_SEL clock id and add new ids for the CTS_ENCL and CTS_ENCL_SEL
> clocks on G12A compatible SoCs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/g12a.h              | 1 -
>  include/dt-bindings/clock/g12a-clkc.h | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Bindings must be a separate patch from the driver changes. If this
causes bisectability issues, this means entire solution breaks ABI and
is not appropriate anyway...

Best regards,
Krzysztof

