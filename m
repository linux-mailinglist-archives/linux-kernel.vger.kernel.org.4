Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F2677825
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjAWKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjAWKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:01:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF194C38
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so8128028wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHS3mk6JbbgyNRTSXjYjsfgnq8MuQkxrNAVrADP3i1U=;
        b=P/omMCAtp3UdIKB3ylqTB3oQwjuTXQemKc/IDVP8XxPixLit1Jy0qeFh3XkJV2IlOP
         xbg7+Vqic6E2CeWGWkshUEQL9E1ih9uFlKOtGC6tbNJ1joKB6Z+1W6GmrOYFuNMQAa/d
         ZVhqzQUQzaYZViyWxrdiXB5kKR1dkc/N/TxuM5Ii+qoAUjcmJpNR3Nx6Rlu/zk9Nu10p
         CY7yDA0lqEGrd6/BdUZMtSYjPWR4QCBV5uq7PXePQIOQ9/fsPRpRe+to+3QCyVBQeW3/
         r4Kb2AizfOcvVJUlEZUQwAkW+y+hvm5j5WSviBoTu9yP+GYyk4qQOY8edIS+Z9eQlF8r
         8c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHS3mk6JbbgyNRTSXjYjsfgnq8MuQkxrNAVrADP3i1U=;
        b=jdvYgZ4gey+hAIYqDusqn0+KKo0QxRnBT6yrnoRBx3C2dyCZjFs113EJU4vggMUUQ4
         /ouijTnRnOSDzj3Tml/i/k6YWLfh4odFjuXR/NNqEL+G5RZVMleoe/90xYi2JIGdHQFi
         7H8FA2JLAoXAu91z/PWzPq+sMfhFXlAkLRT7PEMJZPAYT/XSz48lqGNLN0myHHe9lMbD
         BWOBqbhOotFcewuSWTYR0BUbz5DR22oY3GRsUxoff7KbiQUlQDnGysYRBz1JX64E74A0
         2jR5dXABWwAp2VWo+a4cvxkvLn9+Ng2BKBqCQpjXwAm5xS6U8gpS2+GFBRim2q0wa168
         FYmg==
X-Gm-Message-State: AFqh2kqTFUWpUkBtw1B+l5ZJnPxdFpBAjpCyVp/HP3ljs+6xMd109PN9
        h5AMaUg2NcoIqbf2mJ3i9am1QiQEgQFyQ/2B
X-Google-Smtp-Source: AMrXdXs7CLzUPK0iMH5ZMqK0D2wU1b9LwflBRJR+ra/89bP81xiuxciv8AiVUvDM8We6M14nQgDmiA==
X-Received: by 2002:a05:600c:1604:b0:3c6:e61e:ae74 with SMTP id m4-20020a05600c160400b003c6e61eae74mr24485843wmn.4.1674468108220;
        Mon, 23 Jan 2023 02:01:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm11050831wmq.28.2023.01.23.02.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:01:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: drop unsupported UFS properties in ExynosAutov9 SADK
Date:   Mon, 23 Jan 2023 11:01:39 +0100
Message-Id: <167446806832.57213.6393900313707641145.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120130108.278851-1-krzysztof.kozlowski@linaro.org>
References: <20230120130108.278851-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 Jan 2023 14:01:08 +0100, Krzysztof Kozlowski wrote:
> There is no vcc-fixed-regulator property for UFS nodes:
> 
>   exynosautov9-sadk.dtb: ufs@17e00000: Unevaluated properties are not allowed ('vcc-fixed-regulator' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: drop unsupported UFS properties in ExynosAutov9 SADK
      https://git.kernel.org/krzk/linux/c/a1680415e0a7a1d4a7345637e4e96d89d32e0dd3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
