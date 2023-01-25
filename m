Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F567AD39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjAYJDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjAYJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:03:15 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937645229;
        Wed, 25 Jan 2023 01:03:08 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id g15so836698ild.3;
        Wed, 25 Jan 2023 01:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23O3377BiRv60iyqj8AYTr/Gqz5BiVCca8OcTaruWfI=;
        b=dswDnYOnYLJkiIvUf5tQQ4OA9mTnaRdMQIIs9XfS93TpiwUCVP3YMEejlt5RnqYYRE
         4yM5O0jEwyuDkJUx4Mw4lQ1qWIzq2UECZib0Qs2dn/MQQSfmQReqz1OJ8vgw/joTvB6o
         oxpADsDr19n1kG8616sf3f1HSQjEWJdA8dMjEP4bsMh2xWTWdtWGt6d6EbgNxPnNXMqF
         1AupQQT+C8/jlp+2XpVFMLn+CWik0OYs5C9AxKV5kp9NV1rWCIriplHFmbw02xVYLzp9
         LWqEc1JA2+/OAjiwLekeUKWItvb0AWOJ5nzNY3XWJcpkR0SAhbWGorbn77FbPzxukDiV
         td8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23O3377BiRv60iyqj8AYTr/Gqz5BiVCca8OcTaruWfI=;
        b=awOBOUFf2lBz09dwx8bagTAaYgn6VAooqq7UBkE5o7G+v4IQcoHvx7SLYk4YGN9H+2
         iVF3J/YMBFXnqTVyDArFm8J7OUgaANyEARmL2H+qJky0axixhw5NTyjk6dy33IBBAJY+
         qAbYprgnwbupe7hUdN2tLPMt3bm8W1D+E1kAxHkksPlwI7UbfK5O8C5GuuRyFA1cY87K
         3HrHi12zR9hkYEhSOW/c+Zho9nyhoWU+KGIN1Vw3aM4P2k/SgPwxmfh+TOwwlBGh4INb
         aM6eVF5KXeLyyUq9HruB4tNzCScipzsrzZNA+soxjl/kESveD9D4mxqofGvGMJbLLCXH
         GXrQ==
X-Gm-Message-State: AFqh2kqb+1SFkgxSR96+n6f65wtLiSIvf8o/B1Tq6qgdEjIjM0NmNgb7
        EBQvO9Iw3zC/hO0Z3Bf/duc5VfXx/7GgxPcR
X-Google-Smtp-Source: AMrXdXuyKpg6E4oQwOgjQZjd5dGDmjHiEtp5ZwORNbr/uUIp1Lzv24yhIkwnn4V/tjT3t6T6Zw0ycg==
X-Received: by 2002:a05:6e02:1a6c:b0:30f:40fc:7a2b with SMTP id w12-20020a056e021a6c00b0030f40fc7a2bmr21864229ilv.32.1674637387371;
        Wed, 25 Jan 2023 01:03:07 -0800 (PST)
Received: from [172.25.56.57] ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id c2-20020a02a602000000b003a4894d46e0sm1446405jam.176.2023.01.25.01.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:03:06 -0800 (PST)
Message-ID: <959cce55-29f5-9470-afcb-ebfe73654b6f@gmail.com>
Date:   Wed, 25 Jan 2023 12:03:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] pinctrl: single: fix potential NULL dereference
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, Tony Lindgren <tony@atomide.com>
References: <20221118104332.943-1-korotkov.maxim.s@gmail.com>
 <Y3eAIb7x6de9Bigy@atomide.com>
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
In-Reply-To: <Y3eAIb7x6de9Bigy@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,
Will this patch be applied or rejected?
best regards, Max

On 18.11.2022 15:52, Tony Lindgren wrote:
> * Maxim Korotkov <korotkov.maxim.s@gmail.com> [221118 10:33]:
>> Added checking of pointer "function" in pcs_set_mux().
>> pinmux_generic_get_function() can return NULL and the pointer
>> "function" was dereferenced without checking against NULL.
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
