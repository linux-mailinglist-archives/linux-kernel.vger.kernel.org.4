Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF2601908
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJQUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiJQULX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:11:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FD7C1D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:14 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s3so8451922qtn.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts5naEW0nxKCb253X62AzdvZn3MTxKf8vYvh9+9Oywg=;
        b=nIkqr9LVEJbtTVzb4BIiR33e2YT1k1hvk3kLbppvTET+dJLwAs8AGvxeWKOSVVssiJ
         obe22uvFio/iO/yZCek9e6RcWr2HNkcm7/6/CQGAD/9OdcP9KwOK+HZ0Rkr3FoW73MTJ
         CW7XH/A8C7vJi82cTrdKNu/NexvqIroA1k1c1zgapPj+2kMuU122rRuWaZ/tqbQDsH6C
         ItrEzDf90vhqcbACWxpi12i6rETjxV0fsFGAH7r1+K23ijyL0mPgu1jpiYGBGiqzw6MT
         hwH5fLk/xvWdDIPsxa1+M2yl0/IuVkUGDv6Sggw3RZDptKW4WQo8uUM7mgZsUgJwC0cJ
         6jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts5naEW0nxKCb253X62AzdvZn3MTxKf8vYvh9+9Oywg=;
        b=aZGEQ7Kfb8GcLLI3D7bNip5/8BO00wcFjtDrk20o8KrVuajd4KYjOo7lIo6Lt0bZ79
         5Pkjl/VDt1BnKH0G1kUqeCIebf4K8DdXRcat+sZxOM/f1KM13VMIqRJB5R1u7DD1bXMJ
         3x97qjpny60UOmVegThwaIxncPcE8+WmBhQDCpbMzicXZeDb87mU90Rw471yKl5cDZ1L
         j11zSITBePp/JWS/sf/fcEELMwt2LJJyArOZH1cyqVivGdU2a7rh0pz9C6RLDwQ5tdWw
         cWkUrP6HB3k7bEbDLEIcMHA2/dW9x+FQ6DWynzdz2cO7dt6YA8Jgzh3t0ceZJ2uQRH48
         OJtA==
X-Gm-Message-State: ACrzQf3vKdNmLvjB21Yb5/Envo3cb3PYNjqSA5x4ttTyqoOlA/gQYNc+
        UtfiMFKwMy7qtT/jQ5hkQkEH9g==
X-Google-Smtp-Source: AMsMyM7CQyUh68rHh7qNS1P+na9PQS4kPhnqYaG+BLpTkwCM9/eZqz/LxTUbmlzA8dnGkpVEFy+E2w==
X-Received: by 2002:a05:622a:114:b0:39c:b7ec:345a with SMTP id u20-20020a05622a011400b0039cb7ec345amr10119455qtw.677.1666037362092;
        Mon, 17 Oct 2022 13:09:22 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v5 27/34] dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
Date:   Mon, 17 Oct 2022 16:08:08 -0400
Message-Id: <166603728602.4991.7572093372451008112.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-28-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-28-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:28 -0400, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring common
> properties, other pinctrl schemas and additional checks, like function
> required only for GPIOs.
> 
> 

Applied, thanks!

[27/34] dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
        https://git.kernel.org/krzk/linux-dt/c/7e300b5a1f00e8c8c8c0c62979c43d292a791473

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
