Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906B68BB39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBFLUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFLUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:20:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086012857
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:20:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so6993926wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNtLw1Z1rXiQWn3Ln315Y/4zP8AlqV3WIrfHlJDWq5s=;
        b=ZFoHVKkKiQyszzqHFVrtzadeH9Atq2JOeW8tL9fxlcGm/dD32/ibF3G28+JIOFqgfn
         9l6la56wQ2jsx13fFOTbil96R2wA/wyLXKu+/PX6kyfB4kjjDBMLoJosdjYiAJiJtEoY
         zuJ8khhAxFl72nqXJSpZkRyeq68pvu3dpNQJyLIl9SDejfqlo7aMn12jg592kCQS+7Pd
         Xnv8zrrG+K/9bST/O8G1gsZrS2WAXNXTFvfjc1i/3aIgSGWPukiLn61rRh4eVhztNf0+
         TkhTdaAqGQAlu9DdJtbYsjam5fWrChScvd7htaKQbO+qXBsrMpbjKn11gmyIYd8RjXGY
         XnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNtLw1Z1rXiQWn3Ln315Y/4zP8AlqV3WIrfHlJDWq5s=;
        b=5NXx5rA6lyG2BquXmrV+ww58h1u5RhKHypb5JV60/xnZlNXq7iwgPESlsztG36Cu8p
         f/hsGrkl4in2NXV21uGQ9/v+lqLVv+ftiO19frF8CsSUjXv36u3BwtSFN/Zkcj0BvdLN
         jOcz6P/vpOU6IDlt+XzOZ3EuTi+AcpR+ZOdsb/NC/YcSXh4xg2c8k4jV5JEPQDhW2Y98
         +JvdzoIa4avXCHOpXxuUcH+mYz063EJ7PijebNWv5r8Uj9oVmm7+Yx409kNBKKj6lRuC
         IKG4ZJDtC+O+CfObmTbM8bV0ZEeikgHuT1p0zfPQgeTxon+I5JKqJFM1haUUdAqE50mZ
         D6Gw==
X-Gm-Message-State: AO0yUKVV0gcFMWRgkiWC5CMSdSTyL+ovd7KSuCQ3dgoXVhVtpaqK4jyq
        WZyqSfy2eR13pWnDHS3qJrlrNQ==
X-Google-Smtp-Source: AK7set8Y9qDVz69JfJLVkhu9HPMJO1VqBMLvJeXTB7FftVgXh0YG54h8B+KZ9MxwF7fPp7tiVAenyw==
X-Received: by 2002:a05:600c:5389:b0:3dc:557f:6126 with SMTP id hg9-20020a05600c538900b003dc557f6126mr548834wmb.4.1675682423707;
        Mon, 06 Feb 2023 03:20:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003dd8feea827sm15514587wmc.4.2023.02.06.03.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:20:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: (subset) [PATCH 3/5] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: correct GPIO name pattern
Date:   Mon,  6 Feb 2023 12:20:17 +0100
Message-Id: <167568224369.84151.16792417656176338982.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203164854.390080-3-krzysztof.kozlowski@linaro.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org> <20230203164854.390080-3-krzysztof.kozlowski@linaro.org>
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

On Fri, 3 Feb 2023 17:48:52 +0100, Krzysztof Kozlowski wrote:
> The SM8450 LPASS pin controller has GPIOs 0-22, so narrow the pattern of
> possible GPIO names.
> 
> 

Applied, thanks!

[3/5] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: correct GPIO name pattern
      https://git.kernel.org/krzk/linux-dt/c/315dffb843f75cec4458714f4d151d5775e797de

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
