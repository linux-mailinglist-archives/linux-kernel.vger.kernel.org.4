Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56963F5ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLARG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLARGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:06:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9599A555F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:06:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j4so3501005lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvnwqFoda3R81XSsH5X8ckaYHfYXYc7+YOPbr2SI3JY=;
        b=NDrN6eqmcPfDqgehQ9tqv8zIUNhNWoMbw1ReFyE9DuwfC7axElTCeqHYkSC1Ndgx1A
         kKTQS03ICML74BW1vIdWvS1TTM2Vnqgoct2QLYjagWccRuthslzA8Qr+B5D3YKs5WTr6
         Mnla5jqEkvVvjx1vKwZ0tJs/YX0xIjFw6OPlF6yK5dXBylEvQ6rV7NkiZZeP+WW6s/Oc
         UUKDQso00astuSNXSVMh/RdyKV/WPHjsE1W6mrAK5yupJ75dClqdY0evhXSQkqq4Jont
         fpPSGvAmGZW9fy0leyiFLxyhUhcQNpw4fh3RPpFTVbEEgftTwBbUzbesTTnOWuVybwfs
         VHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvnwqFoda3R81XSsH5X8ckaYHfYXYc7+YOPbr2SI3JY=;
        b=Yf64lX9jIKlCCsjvTCU9LWvfp63LXz2vV00VGaqZQdGn85kLu4UCiTTP0k0CrzdYoM
         0+XBrzcb9yBfL87PtAcEvEqKayJZpKatTKwnJSyOAbtKCm9OtaAfJjCx5Kg6mDLGZk92
         fk87myPbhST1tMLcog+9ExRP66QjcNrfz9FLbQLHkoCqMZlrG1+7X6a0WNdIzFGoxvsP
         AMp2x8DexYAFJt/0cMrpZ7zYB5rifAXsyCyrs8Ue8cfxgddnqJQc3s1EV3JqiFo+d/cX
         YSNVTlnVy6GaZ4jzXZ/ybB+hIpXV5bY9ycHrkmzqa8MfdUbuCH9br3TX4/eJpigylo9D
         JqlQ==
X-Gm-Message-State: ANoB5pmoTe67pPHT6IgmKxun5rLDEqi/J+NOFwD6y5u70X2Yjt4U53Rj
        vfElOAsnH79aS7PSAv+r9RL8MQ==
X-Google-Smtp-Source: AA0mqf5b+G9hYnKMFf5FxV5ES5WTINWCBfL1ffRNqTPhAmhe1ML2MbwtBW9ttJYnftFUHuC81JDLCA==
X-Received: by 2002:a19:674a:0:b0:4b1:3931:af with SMTP id e10-20020a19674a000000b004b1393100afmr18949930lfj.394.1669914407257;
        Thu, 01 Dec 2022 09:06:47 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25fc9000000b004b40f5e7336sm703659lfg.199.2022.12.01.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:06:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: omap: align LED node names with dtschema
Date:   Thu,  1 Dec 2022 18:06:41 +0100
Message-Id: <166991439955.130674.13081986511238050689.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127203034.54092-1-krzysztof.kozlowski@linaro.org>
References: <20221127203034.54092-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 21:30:33 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   omap3-beagle-ab4.dtb: leds: 'heartbeat', 'mmc', 'pmu_stat' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/2] ARM: dts: omap: align LED node names with dtschema
      https://git.kernel.org/krzk/linux-dt/c/95a45c667635d50de9beb3c5f5b3046dfa395bff
[2/2] ARM: dts: omap: echo: use preferred enable-gpios for LP5523 LED
      https://git.kernel.org/krzk/linux-dt/c/e920bcac0ec64b3010438d38724cefce361f7c3a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
