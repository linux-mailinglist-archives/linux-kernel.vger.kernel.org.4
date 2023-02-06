Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22C068BB36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBFLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBFLUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:20:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D6113E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:20:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10490105wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgqT+Qh3H+ehnXxQRC0o48wkLUjHWORXJIyFdZ5LR0I=;
        b=jJ2+q49iChg2f303Hmxygc3rGE2ab3YP34u9vAVIxxUI5jW6oZzZK0i6BGpC+/Z6t6
         N/zscPMQHYQ7801W1XGiN4HUagBl7Q9B0BSLChDCRaPpbFE2cIvaX0iIOfTqLOJujDNl
         fgmHtiKvaBjZ01lwUh4HCS7Pp9Z2SdsaEN2rId70WcmTpdzJHBID07mbwySO4aiyDphA
         PFO9u0Nqmg6s27w4S2uD4pAMvlRlas4G9NbL4aJcR2r774w/uaUpMWD24TY3FltjRAtw
         JUD2ojwfeHUIFiaNvNPtKTPbcSdYsCkLFZu3E7NgXfNTEskzPsG9taqnx2LwcfG2CTBX
         zd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgqT+Qh3H+ehnXxQRC0o48wkLUjHWORXJIyFdZ5LR0I=;
        b=y8Ib7t+523vKilKIL2tISQaD7ZWOQwyPWchCzFdsPEQxurmqdS4B84YoKjc1VRxaK2
         75qNaIgyQjXNo6j2LwLiR+uPJEqxTK1sBu/rI6z4Lx2H50uclHYD3QuoV38YcltgRzkS
         pIaENq5n9mScpgZYfXE96GtZYWvovyXunJDyPjPPyVln072x1Gbz2iHVvXESGJfrTW8T
         MIihytNWphqANz3cks3JzXYNsWe5WQpO3bEGGrZbCaFnwlf4y+Z2ZWyUFL10WqJyubvw
         dH6vdzVUGT51oaTcGw8AAoCICiDKGm+tvI0vCufBVFOUqTxR/tbhvFb7oeNbeg2ePQZJ
         E89Q==
X-Gm-Message-State: AO0yUKU+Dgj8K+UtVaD/sXi36tdir8HkuNL/6s3lO42SszC3O6B/WNsu
        /uSTzhC6u2B1S60lsp6TnA3bwA==
X-Google-Smtp-Source: AK7set95TJcNejG/WfrCYOeiWQSaQyUKznpZnFPlYjJk2e/uOklwjrYMl0adxJ4SeysqvV6009c2+g==
X-Received: by 2002:a05:600c:3795:b0:3c6:e61e:ae71 with SMTP id o21-20020a05600c379500b003c6e61eae71mr20928657wmr.1.1675682422531;
        Mon, 06 Feb 2023 03:20:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003dd8feea827sm15514587wmc.4.2023.02.06.03.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:20:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: (subset) [PATCH 2/5] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: correct GPIO name pattern
Date:   Mon,  6 Feb 2023 12:20:16 +0100
Message-Id: <167568224369.84151.15382431118501691389.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203164854.390080-2-krzysztof.kozlowski@linaro.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org> <20230203164854.390080-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 3 Feb 2023 17:48:51 +0100, Krzysztof Kozlowski wrote:
> The SM8250 LPASS pin controller has GPIOs 0-13, so narrow the pattern of
> possible GPIO names.
> 
> 

Applied, thanks!

[2/5] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: correct GPIO name pattern
      https://git.kernel.org/krzk/linux-dt/c/315dffb843f75cec4458714f4d151d5775e797de

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
