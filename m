Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5954E735C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjFSQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFSQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:18:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE28E4A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:18:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f906d8fca3so21304565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191489; x=1689783489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo3DBVJVu3xDPlokmKpCsLRzFG8I713/g/AkrSk7nUg=;
        b=zYo+L9wNLsuwA/BAg7csYNRcj5gp4CC6wrmqrzbKR1+BFFq1NO0Be8itgaQu02/LRT
         gRWpqMPt8+jy2XjhKU+XtULeG+bgusWf7K2mx7KpGSJC3rjZlEeG7f+vnrNoUWXpSAbY
         XEsVavf0WN+MjChS/wNi8x3nv664BKs34Yc0YaAGYSq+hsiSzEgfFuLaKXuODKpZEebn
         YJi3CAcDWdL7Yd7DrrYVgChSAQ0hq5TLKbwsV/Hc35GjeEcM65hpBeIlBv+KpJD6frC6
         9I4EAtcDu5p/yRPMEbhf6hQ+y5JSvG5gUobfDQLeXzUrhSBXMe4YPnz/KttRU6TtjEgg
         L+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191489; x=1689783489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo3DBVJVu3xDPlokmKpCsLRzFG8I713/g/AkrSk7nUg=;
        b=CSNJPoY6Sj2y6Ctm7aqU7YrPtff7Ia6VEf0izS08LoGB5Nt+vCiAObk4Ptx6uTBzae
         93l10DepTGAxIIeemOEGHnuYITpIzT3lxwCWSBridJmOLjEJy40401KwMjNyX8NMGIcl
         QtCf8/WIhHxOdSGSbcZYqmdzDtlbC0GY2VY1aDYS7r8PXvQy7lENvZFT6kFvvjiKOHeZ
         93F6ul3tdGAf6AtOq6yHqpIwy09zgZhh+1bz8foN3HmmM+qcGfgYQiPSB+4Uc0OPl+2P
         ijRzgySIQnU9QQpbmhf9A596J9dBOPhBQ7H5eb9PEfX1CaBErHmMu9jiDkSGQkXiXTI2
         1Esg==
X-Gm-Message-State: AC+VfDyHQ8wm4XkUiJUn235uZjZkGcVYjc9O/jmyaF+VfEYvHHWQnVUx
        W8ohB/eJ7sPWisyiD42dnfDJOQ==
X-Google-Smtp-Source: ACHHUZ5+rTZ8Ox45IYYvKqJuPg1frA16DyTE1URxEftheyE0BZuDtXfgk9LggkHajUG88pYEMKS3cQ==
X-Received: by 2002:a05:600c:2190:b0:3f9:be1:507d with SMTP id e16-20020a05600c219000b003f90be1507dmr3357674wme.20.1687191489231;
        Mon, 19 Jun 2023 09:18:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id 24-20020a05600c22d800b003f8c5ceeb77sm126220wmg.21.2023.06.19.09.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 09:18:08 -0700 (PDT)
Message-ID: <6282082a-1e03-0cf2-2f00-31445b9522c8@linaro.org>
Date:   Mon, 19 Jun 2023 18:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: timer: brcm,kona-timer: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230618144635.GA22166@standask-GA-A55M-S2HP>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230618144635.GA22166@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2023 16:46, Stanislav Jakubek wrote:
> Convert Broadcom Kona family timer bindings to DT schema.
> 
> Changes during conversion:
>    - drop deprecated compatible (it's been deprecated for ~10 years)
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

