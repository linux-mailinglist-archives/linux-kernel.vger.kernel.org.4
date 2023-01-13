Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4B6694B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjAMKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjAMKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:51:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163140844
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:50:27 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so51332537ejm.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjLnRe8go6oR0FL2SzP4LgVTVMBGmgNdTpzoQwElorA=;
        b=ciKjMIoXQO+1uQKdZTCF5BhKQafgKlpPZfdmIVd6tR8E6X/J/he2074PsI9TIruXRo
         /ZJiYgsAxm/Hp6p5NCuMThA4J7dFRoK/AKx0yHu41XANuvCqKQdYE60hsIFrnaC8jUU2
         xAhLi52cD407/ieaPaGS5IG7t9QIe0iLGOiD3+/hrIMrUldg8dLzzwVrolZRuJdwDGQu
         r8oHZU1UZ736HzMWKvVlb/sMmo7YnpWETDvf/vjXk6pjC56DDADbZMdwzkmhaFt1U65p
         yOABf0h4evfkdBlylyoRSJDiQEnjhif1BAZSuAXfNS2v//0Zw9xQVszlIzG0q9UU4YLY
         xhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjLnRe8go6oR0FL2SzP4LgVTVMBGmgNdTpzoQwElorA=;
        b=zBoCzv/DrXkkcF0P3AJQ6Dqe1XM9oh3TzEy0x7IDUo+c1KGB7oQv0Ir8lGrZdZj/rP
         aMhtY09cxMSTouonnwfkPT4JSk59dHcrCoeL8CJI9RPw9UNz9rRFU79BT3Hk66ni8n1t
         WunVT5rClsKglhGjvQ7OQ2dbf2YKFaj//hux29IEYuQsOYHeSXpYLLACRRkNT39hYWcT
         KdfyajtAD7aAWLPAA0RKXbCLHkeK6AwCopcovu6CkDoEkJx2CgxJZ1FQfS2fzzHyevz5
         KyLoi0L/7s/0Uw6ZSZSGRMiX5lt3a0jHkfr0KMgNnc8p8Qv3o/6ZgnVGDSOGiNcHMsm5
         QcNA==
X-Gm-Message-State: AFqh2ko2PyaYHkyF0hzL+rboI5lxZuLTcgy8eeMZ0YSWZWkSrnrV2bN9
        4Hfjne3lfXekyr1PZqv9Se+RWQ==
X-Google-Smtp-Source: AMrXdXtab8jck5KPm87sl92cLo8VaLh+ebYr37T2IzQRVeDqPuXJd9KJYjwDUF4GxKWoG5OKdHXZUA==
X-Received: by 2002:a17:906:8c3:b0:84d:2078:1fd6 with SMTP id o3-20020a17090608c300b0084d20781fd6mr2669839eje.34.1673607026367;
        Fri, 13 Jan 2023 02:50:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm8348581ejf.210.2023.01.13.02.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:50:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 2/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add input-enable and bias-bus-hold
Date:   Fri, 13 Jan 2023 11:50:13 +0100
Message-Id: <167360698783.32701.11668469941394473654.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-2-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org> <20221230135645.56401-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 30 Dec 2022 14:56:38 +0100, Krzysztof Kozlowski wrote:
> Allow bias-bus-hold and input-enable properties (already used in
> SC8280XP LPASS LPI nodes):
> 
>   sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
>     'gpio2' does not match '^gpio([0-1]|1[0-8])$'
> 
> [...]

Corrected error log, as Rob pointed out.

Applied, thanks!

[2/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add input-enable and bias-bus-hold
      https://git.kernel.org/krzk/linux-dt/c/a880fafbbac7e229752fb59bed56f55944dbe0e9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
