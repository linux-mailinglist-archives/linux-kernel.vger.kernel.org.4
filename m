Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C070017D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjELH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbjELH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:28:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2003A8C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:27:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965a68abfd4so1813072666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876456; x=1686468456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDWwjFIA/MszR8ggE25Paoq7l2pFw2tSsYJjSiHv/BA=;
        b=fpQFcVK+KDdIrhnFWFD2yduuitfbHiZtRIDJ9p07Z/mOuos2/RSXptRgrohhQxp98f
         LhUETUw7aJBaDxu1J8XCE1Y/u+z1sjazNsT0b9Q8MO/IxakcjTSOTN9gAxEKe27i94wA
         QhzQQZLKvnfuHxkxKbRYwBUjpOVmVwy5FEc8XTE3rv54+7BagKq2mMYvF5hJvhElQy5n
         ZoQK3Pf6Pm74Vb1Vd11kZ/LPz5KYFkZV06RsgqxYNHur+1xUJCj3YcZKmMXHhDTwRJaD
         BVPG//iQtQWkd3uE0eeQRJGO83xrxmAM7Ia0TZ8x9zb/5zHTsIUDZC/NNvp55NA/3w2n
         r8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876456; x=1686468456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDWwjFIA/MszR8ggE25Paoq7l2pFw2tSsYJjSiHv/BA=;
        b=ID6Qhx76acVT2VeLdCTz3M+miknQ6DsKqnY2JCJ3M59H9oS5cpsk1eBsQ2zSRl9SKf
         Y9GTfyFuTFJcR6WyWrWJCIUdsl0/Cr8lmxhiIWb9fRKuwzQJprR3+/D5eXuUHPVpBKII
         JCbFtRl79Tin8QGDxa8k5+W1MG7X7vlZ2i8orRIg9UBxMXaQrH3XP6z3ACjXbe/U0XZF
         nyK7Axaz5kLj7DrqUzIkOnsEuOYl/Itg/yD5CvskZE3sRhvGu4WIYJ304/m56cYzXBqS
         ZjvxC7Vme+IWxlvYxC1JiSr/N4LsIEyEN8ose56V04Cn7lxSfhOaoNIZB2a4KhuYGKo2
         FQzA==
X-Gm-Message-State: AC+VfDx+EcdReKmAfUUSZxHTv5POdS17Q1Ljfo0lks4aYZEjqCgxglgh
        cO6hbEzCt9gz8AF+iXKoxiJEb23jemATqrw1HuU=
X-Google-Smtp-Source: ACHHUZ6btnrs8f4xx+v7a2iLLvImQ3YJRIx70ezRlUua4bb9j8KaRWy0teQpjOznfAJrUpwvkBX5uA==
X-Received: by 2002:a17:906:dac8:b0:969:f54c:dee8 with SMTP id xi8-20020a170906dac800b00969f54cdee8mr10521309ejb.35.1683876455767;
        Fri, 12 May 2023 00:27:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065da500b0096616adc0d5sm5061989ejv.104.2023.05.12.00.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:27:35 -0700 (PDT)
Message-ID: <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
Date:   Fri, 12 May 2023 09:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] w1: Replace usage of found with dedicated list
 iterator variable
Content-Language: en-US
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 00:49, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Changes in v2:
>   - fix checkpatch intentation issues

I don't see the differences and checkpatch still complains. Are you sure
you sent v2?

Best regards,
Krzysztof

