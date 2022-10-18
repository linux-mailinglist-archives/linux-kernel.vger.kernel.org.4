Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3860300D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJRPtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJRPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:49:22 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BEDC96DC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:49:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so8893607qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWBtepeH+oj5FPwAiSBqpc8NXsH378UuX8/vDNQH0Tg=;
        b=S7b9vOGl5w/9OpAPOR4BJpBmxU5YdHX9XmVXailFRc08rFQzrmDLu/5RdkYGvq9vP4
         pz4hCAEjRQhsGemhjDeYiLOxnSaRFzKYqWVeP8RRbRjj9jpkMr/AzTPy7wt4/q+NWyoR
         5xQuEadFXNsmeWrYMOdDLQuVqjCo001lwLaSVMAJEWPTy+FX+uun6SvrhglqPNiOsiYl
         4dEprU0RGoWIDicwcLRIcXmzXks/9uMMeSmiv03InF8qRPeuFaL18HHKTdzjdfiBC2NH
         ALCcPTi1N5iTCy2OgXaIta0vPRHcfGJQGNUiI3fHkW1i4ngb98D0SIfiGQCys90nMtKb
         mzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWBtepeH+oj5FPwAiSBqpc8NXsH378UuX8/vDNQH0Tg=;
        b=5puzYA1O/E6RRkYyHXPGefbFv2gDlAbVu8eardt89JG5gkmotESG0nMs/GBnTjUZMF
         gZi2u6PAI2+1uqS6DSmeMq6iHzgCLxiJV/WWEcEgBEZ+Ofdo0b+Dw5W1S8/uEtT3oGJg
         XzOuNt80mbOk2RDHzk+hbymbBQDTs2cluLg8vzekejOfQmQKp7qhJ+iON2fCDLbuyvff
         HKOxTgrXOmaEeLOI1WVR9Kb4nAOphyU9b/XNo+7XGOItqX+oN2Meafea+66Txyau5fFu
         Jn77WtNCulyw3Bk23qp8yH4qVdD2Fr4+92hb7DOwiVd2prRi1cf3POvTZAMT5eRlZ202
         18nA==
X-Gm-Message-State: ACrzQf10pF6jbFt13apWLhHPvuEZwQ91ETqI6CvsQYpaLbf30KOd4Ren
        +ncjoZQmi0QGWnHJw2sbCBa/LA==
X-Google-Smtp-Source: AMsMyM54A7mm2E4/+f1Rld4ZnKXCmWv9TmwHcjfpP9cJBx8M94ZACcbpFl99LYo9KTl0x47XnocCMA==
X-Received: by 2002:a05:620a:440a:b0:6ec:d931:652d with SMTP id v10-20020a05620a440a00b006ecd931652dmr2236099qkp.344.1666108157580;
        Tue, 18 Oct 2022 08:49:17 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id c25-20020ac86619000000b0039543f89109sm2029202qtp.96.2022.10.18.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:49:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v3 12/17] dt-bindings: pinctrl: qcom,sm8250: use common TLMM pin schema
Date:   Tue, 18 Oct 2022 11:49:04 -0400
Message-Id: <166610814671.37912.11544638932887012128.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-13-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org> <20221016172212.49105-13-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:22:07 -0400, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema for pin mux and config
> already brings requirement of function for gpio pins and the definition
> of drive-strength.
> 
> 

Applied, thanks!

[12/17] dt-bindings: pinctrl: qcom,sm8250: use common TLMM pin schema
        https://git.kernel.org/krzk/linux-dt/c/fd69e8befa1cbf29435b0666320d5f8848e8b333

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
