Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855CA6ABE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCFLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCFLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:39:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8519BA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:39:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a25so37440802edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678102755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Azv3qOIDSN05R8VHm1Ql58xd4w4JXBO4sj4yqG9o8CE=;
        b=VrZHHNkx3aCXSPeBIiiLNZ192hhHTr0EX/uNtCUDfpTC9VR2bED7KhWmhZ+yPLi0jl
         Q8GQ3f4Iu3RfllT5gqHEShh0K9/9hCYTYxbHUQps2QGis4Wl/LQzzdp2+OuC/D6tjP2y
         S3qpy8t5SHVkUrxCHURSUfpc0CmyUJwv2ooPaGNGc93c6Qky6sdpFNf5GR+DMOmOoL+Q
         57A2T96FJQ052/U64d797m1NMGnMWijKfRnuVoG5ygIF2YAlzo28Ig/R9h7uzYlTsQKG
         s9e1P1yU7pD69sA7DKeGvXqVTVuF9dWzCcmern8ERuJa9jFqd3lxcDmZyjnO7JA/VzqF
         qgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azv3qOIDSN05R8VHm1Ql58xd4w4JXBO4sj4yqG9o8CE=;
        b=T8yN2QOugG6Q6F3D5kd82ukTyRDCkqvZeZ+4df+gJUviJtrgbL+CIRs0Zbc/srpjLO
         vCBTj6xsAev8mO396MqA0scNnv7ojiW89nNvj68kRIqBJvE4W88GPQn7+l+3ryruqN98
         gLrWYo370/kDDQm96g1hdZQut39WcC8VsWFBCaZmU3wUIu8C96h0NlO2pAPjXpnp7h7T
         wvAs5xMiQJVdASbcdgNr+kHZCweIrrcSjJp3TKiOo3gYkUGYPh8cGjFI22Mk8Y2Ya7xv
         0g19RrteOpvvBMK47tJfTEaCptZ+b0iRGkOcrGQ7UxRzdjFNT/5NbR6Jm2WcW7H1R7np
         Qi9w==
X-Gm-Message-State: AO0yUKU71AJ2rTujEPaWdbAPJXtdKM1y8qG7DdOdGmkftoQ1a4lFFhIB
        1dXPKeLpGaR4JzTASfbVskWD/w==
X-Google-Smtp-Source: AK7set/cOiPi/iANfWLzS0Zcu7y+SQCp7WrKRWZcRKxhG+dIQmkKYLtMY+nmvAIYTMvAupcnMNZvQQ==
X-Received: by 2002:a17:906:d9c8:b0:8e1:cc38:6ab0 with SMTP id qk8-20020a170906d9c800b008e1cc386ab0mr9312257ejb.16.1678102755191;
        Mon, 06 Mar 2023 03:39:15 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id ch10-20020a170906c2ca00b008cf8c6f5c43sm4411936ejb.83.2023.03.06.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:39:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: exynos: align STMPE ADC node name with bindings in P4 Note
Date:   Mon,  6 Mar 2023 12:39:04 +0100
Message-Id: <167810274093.82312.7401325487979471571.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225164050.42522-1-krzysztof.kozlowski@linaro.org>
References: <20230225164050.42522-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 25 Feb 2023 17:40:49 +0100, Krzysztof Kozlowski wrote:
> The node name should be generic thus rename STMPE ADC child to "adc".
> Bindings will expect such name as well.
> 
> 

Applied, thanks!

[1/2] ARM: dts: exynos: align STMPE ADC node name with bindings in P4 Note
      https://git.kernel.org/krzk/linux/c/9aa8727b3b15c4d941353c784f61f49e33513b3e
[2/2] ARM: dts: exynos: drop fake align STMPE properties in P4 Note
      https://git.kernel.org/krzk/linux/c/74cbc0e6b2051a604c9bec8c825d83832def0462

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
