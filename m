Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD116FB5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjEHREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjEHREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:04:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BA6E87
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:04:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso9103093a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683565464; x=1686157464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Azq7BTbCzWMhIuUB9Y3axAkLlNLga1qcngxokDgUFg=;
        b=jUzZN9XekwyKk7X5mfaXoB2EomeDWEaOyHV6+eLW2CNwSQ3wVpzHNY2Rsf0t9tpM02
         QhlktMqdiR7GVvwROtOAj/T2s6tNHUSNltDXfBBYQcRGr71qpfptukL9TMQf3TkOylPG
         bJ3/mtZaSsgRyG9lckE4sP41XsbsQz66WfN2rQnVHvS/Typ3D6Cnu3nYbIPm1fDtDg+H
         IEN/ZQlKuAkeldK/Rdse1O2dx4qdC9s1R+HMoe1fbml5Ojmb2fhXXh15XgLT6AFyLUb5
         M5cATtIBBISRJTfz0jOwdE/h0Lwc6bf+uMeF43yJ1H/KmzYJU51jUXYXkzD48iSTM7ya
         1s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565464; x=1686157464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Azq7BTbCzWMhIuUB9Y3axAkLlNLga1qcngxokDgUFg=;
        b=eumSjcJkLAaTPCGBb52m0Vtgq1jlMGUYTzQWw5ksIEKnsPoZZXoVmb4usIx7utLGTS
         mEkRRg72k4zmMIY1VXkSOhoHrNQd0c89iEZWnlGqKyesG+ekyrJh6t5nhKcAUSsPjhBz
         pnzP7w60lfSboRU/jhbBQ/Ne1M7es94++TKZzLy/A/W4t9XWi1BZFIyorfbR30teWap/
         m2t8wL/HwJG5ounQuRik4ft6OvgyVPN1f3u9fzlmwR6gMsw+O4zfm6VdFXmvJKa75B3e
         RorpxqYzRTznuY9irAf3FvmXaLeT4QfpRoeW6B1IoJxdjM/WYKvLqg8x6PhGupzoc5fX
         Y24w==
X-Gm-Message-State: AC+VfDw67DAZUFrkPXAmV2PHOhbxZ2gh4+2omIPWMAN/ol39aqse+t5V
        sncdfej1qsiVjnPOc2NiwzJIHQ==
X-Google-Smtp-Source: ACHHUZ5HokAFGepEoHFVp0yqrFst+OcgQKSYk4tu/BFsbVJiAfG7+Z7SPpuMHlJjwkMUbvWwrp2yQg==
X-Received: by 2002:a17:907:3e05:b0:94e:988d:acc5 with SMTP id hp5-20020a1709073e0500b0094e988dacc5mr9994946ejc.46.1683565464499;
        Mon, 08 May 2023 10:04:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id lh2-20020a170906f8c200b00965b7bf6aa5sm206862ejb.52.2023.05.08.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:04:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 3/7] ARM: dts: exynos: Remove empty camera pinctrl configuration in Odroid X/U3
Date:   Mon,  8 May 2023 19:04:16 +0200
Message-Id: <168356544396.281925.13794945904153112539.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-3-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org> <20230207210020.677007-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 22:00:16 +0100, Krzysztof Kozlowski wrote:
> The camera's pinctrl configuration is simply empty and not effective.
> Remove it to fix dtbs_check warning:
> 
>   arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
> 
> 

Applied, thanks!

[3/7] ARM: dts: exynos: Remove empty camera pinctrl configuration in Odroid X/U3
      https://git.kernel.org/krzk/linux/c/043dc30113758f6b18194227447979e100d3061f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
