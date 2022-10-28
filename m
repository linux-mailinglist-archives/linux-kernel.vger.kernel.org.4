Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FFC611202
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJ1M43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJ1M4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:56:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCF1BFBA6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:56:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i9so534165qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc5DBl6fLk5VzpRBus6T5B5WFedWLUlf7giGkmjppAI=;
        b=W3+V21sHGybZcObpWl4eWzRRO5UpXS5CubY6vZWm4wmc/wVNosn8k7o5cfbMRKZsMv
         mceEyAc7gzpUbbmjsMaG708c29v1yO7HJvM2dk9BGYnYlTzUlEuKaDueXXNWcjo6YVxW
         rQrl3fGIckDdeIYPyZ7rhl5WeRWBJr+k9Lbl+CxbT8vZjdgHUMONQjgzVHTxFapgPuq0
         YLepYO1wapwDyhInCDLina8mP/46KRabITlTMRr0i8iRA6CUGg2bLofDcMfjVgpgFPav
         AISuqHvjDgep9YCsWKVdjaosHTOL/tgiXSLdpqBsF3nmmlZJUc6v3P8uy4xUWsVNcS/U
         xeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc5DBl6fLk5VzpRBus6T5B5WFedWLUlf7giGkmjppAI=;
        b=HjnNw8DrfvXZDzyO8oNFVT1sVM4QAUZZa/QCvyDy7lzlf/uthlR6i3V/lZ+v/+yc2S
         pH9XNI3DkMxx6pX/8rk2sLa2+jCu7H0RS8rFSTb+tQSKO5uz86DF4IeVGc0ZIg7QIiW0
         /A/5Gv/s7XyMINNMLUwAe6wMIWfStPTqolA+aSHn7t9KNU7eU5topHip+TA/Wc0FqH3q
         HocazVPrLnW5YkXn0NAo+hmGFMQEYZYEjKb+Q2b+at3AVcKNCpzng8uBB2IuqPQRnmdc
         D5YDVjQmomcbUy7umas5Jym+6tOYaUI1aKSIdvTivdegCwza1Z7LneoFC2JuEc/UepGP
         lXAg==
X-Gm-Message-State: ACrzQf0F2VWRNCELzZwghm/cb2EtXvVtVwaiLZuVoY0jjuRNdxEOp1hb
        8sG6ed/K8Jq9JUp1iYaPXcMBhg==
X-Google-Smtp-Source: AMsMyM5hT4czWckRumb4ArDnLCJlAEAvoUS/pqZEVgHDhwmINPXneYrfuoJapsgExSEDC138xP0piA==
X-Received: by 2002:a05:620a:45ac:b0:6f8:7c0c:20f with SMTP id bp44-20020a05620a45ac00b006f87c0c020fmr11966040qkb.270.1666961783732;
        Fri, 28 Oct 2022 05:56:23 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a240d00b006f0fc145ae5sm2978266qkn.15.2022.10.28.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:56:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: arm,pl353-smc: Extend to support 'arm,pl354' SMC
Date:   Fri, 28 Oct 2022 08:56:20 -0400
Message-Id: <166696177685.15403.8751248944316732738.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021203928.286169-1-robh@kernel.org>
References: <20221021203928.286169-1-robh@kernel.org>
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

On Fri, 21 Oct 2022 15:39:28 -0500, Rob Herring wrote:
> Add support for the Arm PL354 static memory controller to the existing
> Arm PL353 binding. Both are different configurations of the same IP with
> support for different types of memory interfaces.
> 
> The 'arm,pl354' binding has already been in use upstream for a long time
> in Arm development boards. The existing users have only the controller
> without any child devices, so drop the required address properties
> (ranges, #address-cells, #size-cells). The schema for 'ranges' is too
> constrained as the order is not important and the PL354 has 8
> chipselects (And the PL353 actually has up to 8 too).
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: memory-controllers: arm,pl353-smc: Extend to support 'arm,pl354' SMC
      https://git.kernel.org/krzk/linux-mem-ctrl/c/de67fa80c66992b13dd018ec18e8c91156522c18

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
