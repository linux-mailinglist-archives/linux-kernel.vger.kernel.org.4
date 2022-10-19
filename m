Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C426049D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiJSOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJSOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:52:55 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478A32047
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:44:41 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id s17so9630424qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1Rxcqt5s568yziVlU0XRQaT8u/I+oQQxrkNurWL41M=;
        b=Dwo+B1hGa4ZK2akbMphNNjAy9mGBOXDyvAZaw7+4RPgqmTIyEoAWVu9SWZ5g4kvPir
         SvuWv9RIWISjZt7WmMHhp0/DQUj3BCjrMDzaH7oA4NKdRuBOBX/LRX/49JXw+PK9X10I
         vBH77GjJuN/Goqlr4VXsvGxsyKNsuqAAO2ntM2tkTW+NYLiV1k3yug8i9992nk3CsC3o
         c/QAeFuk8wB9w61miM3LbCR9q9qS40HP4kxC0wRA4/54cKbnQSsLnVJHecv2QbHRBC11
         +PJeJOEW5hgWu9KnUX3H6n1jDCXOIbBLyy8XgO2VNCoRbfxraiaLhHPYID3NuPiiZAXb
         UBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1Rxcqt5s568yziVlU0XRQaT8u/I+oQQxrkNurWL41M=;
        b=U0zt//ftWlGT7osgmaeKpQV7WEEwMsn0VmtsAqSsZNeHUxhpihcGFV3W9tT4xjLyn/
         UrVWgqlK5CmWanpiNkdf7vj5o0+gJX2ruM7Xv4hjEcQIyoO7XeVoo1HP3JAAYJkAk1BT
         RtfLLp9vn3o08VX1YHENA+uCzudMNUXo2lfH6z0nrM+Fz9t0Hw+UyAerNXHoRDP8r39Y
         JdgHXuI5t8x6g7nDw6RfO7/4xX8aDHFV371FE+/TcMsBXqi/LTLl9V6+93BpthuFvv+p
         k1J/uq8+mEmY7RKp+JC6sP3mdfAn+Pv1iUtBIfoMq+nE1zHu8fuGdjsTp7IpXdJUrruC
         oRlw==
X-Gm-Message-State: ACrzQf0mfHIvKe+qGHXqXtOX98veHzZXTGYin073Cqra3fU+djW5PTAn
        hkc1Y9RPrdAfiPTgkhjV5TCZvA==
X-Google-Smtp-Source: AMsMyM6nu23tPUohQfvfP4zOoR0Cof1uhO2GBx8FxTy+573PshzSHcwH8R6il8IRB87RmbwUOTnFig==
X-Received: by 2002:a05:620a:19a2:b0:6ee:b516:d5e with SMTP id bm34-20020a05620a19a200b006eeb5160d5emr5793507qkb.394.1666190679890;
        Wed, 19 Oct 2022 07:44:39 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006ed61f18651sm5211917qko.16.2022.10.19.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:44:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: qcom,sm8150: convert to dtschema
Date:   Wed, 19 Oct 2022 10:44:31 -0400
Message-Id: <166619067067.168589.1250164140790540799.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018160128.51851-1-krzysztof.kozlowski@linaro.org>
References: <20221018160128.51851-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 18 Oct 2022 12:01:28 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm SM8150 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> 

Applied, thanks!

[1/1] dt-bindings: pinctrl: qcom,sm8150: convert to dtschema
      https://git.kernel.org/krzk/linux-dt/c/49b02b604fa6c4f27fd8c31261aa21ff957a8a5f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
