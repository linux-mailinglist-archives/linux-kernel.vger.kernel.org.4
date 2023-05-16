Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8EE704772
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjEPILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEPIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:10:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB03C3E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:10:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96652cb7673so1718781566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684224651; x=1686816651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+u5eqxdXKxpH9G8swDFcXxzS8uBC5aYWUindq5S9iOc=;
        b=ZDg3qBq5ZWDojOZ4C96nJ4ua4/uaITbveiWX3HDxqmWplNmue6rt22UT5Ys1TE28Zg
         QG6PqryZsXDHfrFdZJdKa3VZWWu2aN/CBQTc+w7faitzAYCQpAjwHzFVDsKXCIq7kj4w
         XhY1kRlgFIvgG6vMnKk0RoQt525R6XLApHqfivL3h0BLoEB6PoGOy0PXgJNzgu4ADQBI
         hvuQcJpSmBsmu0OVQ95xMMw5oZ6Oiqi8Kz8jyBS8QzPG2vJH6S7Ccubq/xs/kIvtwM8r
         b7swMLP2paRfDbpRfJ/cbjiB8tW3MzuKgEfAPI2pTqag+2kCUdeapzXHEa7On7tDUpGQ
         Lzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684224651; x=1686816651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u5eqxdXKxpH9G8swDFcXxzS8uBC5aYWUindq5S9iOc=;
        b=AoBCgLxJqOU5ggXB1Zq66FuWRhgRyGAXHhkQt1MKJlaVjs+7CW/7d/bx6hzFE6q2Rw
         pr8EJQMk2zqZj3v0a1tiRXEAFZC48hhYys/LjnqIp1O5DCLFiwiOhCvbUvzKa9uJN7s5
         Hg62FHxpDR8q4Z/mfoVYBOHWYt6Xy+exqLE+vUCikhsFVjHb/t0fXo3fo02iOQptf+ff
         0ceXPw+HQBKVDt4kkcDAXFq7Nx5VGpvJyiDVb7dtb/xFrTbxKApIp1wkXjzu/Ofba0YT
         cC+XdSRr8LALTKz81iFgRXY7Q31mDoMKR2mFsSqN6qHTkM9+O/eF+28VEYnnwfg6urRh
         iGUA==
X-Gm-Message-State: AC+VfDyTljRIx7A97lh7GM5tJjTMufzAXvVLAsZl4L3BQBHAG0vp7xbs
        sTHZ4BCG0rAoN1+pGvNjdcXZ7A==
X-Google-Smtp-Source: ACHHUZ4pjwH1t5yz5UMRpimxEfgzvajgIgNb7ZEsPigonxWf0pKfZvpfggIx9u3pL6B1CF32361xqQ==
X-Received: by 2002:a17:907:7f25:b0:94a:937a:58f1 with SMTP id qf37-20020a1709077f2500b0094a937a58f1mr39845803ejc.1.1684224649616;
        Tue, 16 May 2023 01:10:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709067e4b00b00965f6ad266bsm10535003ejr.119.2023.05.16.01.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:10:49 -0700 (PDT)
Message-ID: <58c8b822-8b47-3269-3b78-334b53c20bff@linaro.org>
Date:   Tue, 16 May 2023 10:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] dt-bindings: touchscreen: add virtual-touchscreen
 and virtual-buttons properties
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v2-2-f68a6bfe7a0f@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v2-2-f68a6bfe7a0f@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 17:00, Javier Carrasco wrote:
> The virtual-touchscreen object defines an area within the touchscreen
> where touch events are reported and their coordinates get converted to
> the virtual origin. This object avoids getting events from areas that
> are physically hidden by overlay frames.
> 
> For touchscreens where overlay buttons on the touchscreen surface are
> provided, the virtual-buttons object contains a node for every button
> and the key event that should be reported when pressed.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

