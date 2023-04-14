Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488D56E256B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjDNORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:17:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E817F2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:17:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so2143038a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681481839; x=1684073839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnW3vWHK2Vo4lGjSS4vQRc6YHi20i9L4078uQvE+7tQ=;
        b=tjSWZvWj5n241DBLfgpKUFOVf9O9Jp2GMB0ZxnAXWyoGFVEckUIuGV2ytVqg9G0bST
         mfX7gLSy6J8hSTMaiwxWRUJ2RtXmTKXYaEav7uQyfwdfSWYBFz785EtNux55X2UmS24p
         DRhlZMaQdAB6uQJ1JIHdS0fYmD4KbbRgDUTXFMkpGIhZkpxHcrDb8HkzMhEexnmaCQn/
         85qwRtxfGAHt0AbfO1nTNLTy5sKXbEmaQt6UUVbdqozhpGMWVm7OTWxxzWoFrLO2RjLJ
         n+CU1q8DddUv2C+E+ZweHgfrJX1HuR9wrP5RVjo5O7chDwruGI/sxh5UudPpnS9vT/MJ
         vNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481839; x=1684073839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnW3vWHK2Vo4lGjSS4vQRc6YHi20i9L4078uQvE+7tQ=;
        b=RP9wvZxGaqYwY5aSKVdD4tJt+u7aGeZrvL8tlBMrxyKDQVcxbiQbupypBbejiGw7TD
         W8qE1seoD6v74EScoCk+nNxEIK6HFjp3nzOni9Fw7HM772SEGYLpa4e6gfUcumiia5Lk
         VlJVguJ4dmy54HbdNLWmBEvZCbWAW8YQsknfDfHDJR/lcYVdwRip8lmarGBeEsKgV1gl
         3HVTHCQbUHe6+fhdBX8MvkHo7EuUVk1ElBrDs7JAJGRDu3vE9TDJaWnZ0yIlcrw+9+z9
         2epvtclEkFdODnXM0mYmFiP3gDogGb5kCXqcikPj+EF+WVYdZVli+CKEFhjRaoeyC+0q
         3bZA==
X-Gm-Message-State: AAQBX9frdqFaNbFJL6g4ea4vrJqaNcahAQcvixU5s/FT5NSwTRcgCIzM
        y50hCS4JvRwA1dyA3H8gKWU4uw==
X-Google-Smtp-Source: AKy350Yqdqe7M38Ry2qdwRjfaOfcGCLGN9zxH9nojZ1uqpEQfYyOBUhYFCXpiwyonr/N/0L/O4uh/A==
X-Received: by 2002:aa7:db89:0:b0:506:8330:cff1 with SMTP id u9-20020aa7db89000000b005068330cff1mr2256283edt.35.1681481839555;
        Fri, 14 Apr 2023 07:17:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b0094efcc4a076sm314603eju.164.2023.04.14.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:17:19 -0700 (PDT)
Message-ID: <dc48d390-9c8b-d3b7-9c5e-6cbddb0e1306@linaro.org>
Date:   Fri, 14 Apr 2023 16:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V1 1/4] dt-bindings: clock: qcom,ipq9574-gcc: Drop the
 Bias PLL ubi clock source
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
References: <20230414134812.16812-1-quic_devipriy@quicinc.com>
 <20230414134812.16812-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414134812.16812-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 15:48, Devi Priya wrote:
> Remove bias_pll_ubi_nc_clk from the binding as it has been removed from
> the Device Tree. Also added Bjorn Andersson to the maintainers list.

Was it really removed? Where?

> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>


Best regards,
Krzysztof

