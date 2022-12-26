Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59C6563C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLZPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiLZPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:17:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0866147
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:17:21 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o6so16285515lfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1to2uzMb5gHsULNbiAWEZW6gYBOiA4Yrmeu1xgxInA4=;
        b=NXBSy1TdU7+NwxlykhvA7FOKbXnsZHfX/j0mGpnkIC4SJWoSmcrUjwMERdBwBw2GbK
         48f8uv/1RWuUdd/+3XisSHcYK3IYNsq5eZjgx4K7XMXqT70i9Jw+NUDBOXFRQjCRDMpX
         yGTUw+Redr5RTiI6HdSuBEvTPP9v5W3N0pBulhH6fUIhzI8NnFyNehinTtpKLHQacgWX
         dlZn5CY2jsqGoXT2Nf+gTLugCrkEN7PqoNyO7yQ5C/ECU/3dVMdRhyPbtbN83XD2MvTw
         Xz7Pv5cNH9CCfCuBmYNRJZL8byRyJqBL2XH8iPio4sQnJuG0JmS2B/mvHKAgra2lEoiQ
         l6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1to2uzMb5gHsULNbiAWEZW6gYBOiA4Yrmeu1xgxInA4=;
        b=ODLIniDSaRczd9tG8wf0LKIUGFeJxdYg3gJNOag8jHGeq2lAMQuVEieFEid+iNbtkk
         KxGgH7ggeDHM6JXFJ/IQ5cnOKWjEVjjPb1GPL8i4x2McUeMHs5jmjoz0fMIUZXQVQc4R
         LFwzVd78XbfN0J/VRCnotJ3Pgg8jDmmoYp6Xp0WlVZKxjZCBWOfBOGCn80XBu7hUa5CN
         uPJL+PnqxD657tmR+bBFKqFxITnW58d0nGZKp5mGBRX/mNrOsNniXhEPWaW7hzpOOSRi
         zeVQRNUKhn+IE2UWc0MNbOCPZGpGer/HpQBYW+bXv9A0wQhUvGCsiRw0ahU0YIWUsyn9
         3/hw==
X-Gm-Message-State: AFqh2kqmKURagPEoAGPUD9KYrVYonwV8krQ/13pkg+7qYQADxkqSQst/
        BqfPL9bMrRhG9WSCV1dWg+B5vlhwvXSPjJiX
X-Google-Smtp-Source: AMrXdXs7tlGeEaGy2jmnzVoJYfmxn+y+eVvTdm0w/Qdq2IMJbQV7aYtK3lNsiaeQVsaa/70GTTvfXQ==
X-Received: by 2002:a05:6512:3589:b0:4b1:feb:a338 with SMTP id m9-20020a056512358900b004b10feba338mr5155597lfr.46.1672067839969;
        Mon, 26 Dec 2022 07:17:19 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b004b4ea0f4e7fsm1821286lfm.299.2022.12.26.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 07:17:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFT 1/3] arm64: dts: exynos: drop pwm-names from MAX77843 haptic in TM2
Date:   Mon, 26 Dec 2022 16:17:13 +0100
Message-Id: <167206781676.20416.12002120244036112733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204113839.151816-1-krzysztof.kozlowski@linaro.org>
References: <20221204113839.151816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 12:38:37 +0100, Krzysztof Kozlowski wrote:
> MAX77843 haptici driver does not take 'pwm-names' property:
> 
>   exynos5433-tm2.dtb: pmic@66: motor-driver: 'pwm-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/3] arm64: dts: exynos: drop pwm-names from MAX77843 haptic in TM2
      https://git.kernel.org/krzk/linux/c/0f2d502c32d9bf3e26a9a8fc865bae945b15ecf2
[2/3] arm64: dts: exynos: drop clock-frequency from CPU nodes in TM2
      https://git.kernel.org/krzk/linux/c/82d865b5da8786237b0b700e31b468a20dbd5c4c
[3/3] arm64: dts: exynos: correct properties of MAX98504 in TM2
      https://git.kernel.org/krzk/linux/c/0d6460bc6f4ced858bf099f198ea5b02ffcff4d7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
