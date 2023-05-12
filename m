Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C281700CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjELQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjELQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:25:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F04EFE
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:25:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so91199285a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683908724; x=1686500724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsVPpvkl9SHbw6j0uhgbjYiOesslFOYL/l/KTorV/LM=;
        b=Hpzxp6CeADTsP1lr6v+Vpiq6GrsO/+8GPg55tiUQMklEMCp3Nr4ZxbgL0l46/maHRC
         m6Sj/7934CRGfz4Q1AZyCIcJx5Amni7A1v3sPFD1LQ0AKMTi3h4+zwNxz2eKi6xnqbba
         ZS4tMk60l9fpT/byLq9f/BSsjXu3c+aahU/4kA5xB2epTbtm26oN/rCH+AvKunJHqXDn
         4XHquLhhEIYvvYacmHqcV8RiZqy9GO4TaUEoKiCMOc7oowMYDEO3cQDzwn05ynDLPFVc
         1magCqCqG9+jgXImWtM1hJBfVIHh76ne0/+WOYFOqcz7ODfPG0c9fcY3zgk7A8F7l/v9
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908724; x=1686500724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsVPpvkl9SHbw6j0uhgbjYiOesslFOYL/l/KTorV/LM=;
        b=JwAL8o0Kifqsw8MfA+P2j7eLuld/Rltf6Nm95Fax+AMyNfFmYOFbjKqd0P40WHLPEP
         WxZ6hc3PDuJm+lQ/+JZp8gcUxiBCtkWCybshHTzD3KDaeI4snywdKez180G36rdPTyZb
         8Aqu572885/PHdFHuJfldYA97soZR8AUYO+XjBLsE4NLADP4v4e0HD6praCZrNPHeDdS
         2rO1gXWkKw09iTrQLgOl/hIfxes44+gC/S8MSqeLRLMbkF4sWpyfG/4I7ZIT/Gog1Z/z
         2TNGBymDHFO5q1IVXjo20+w57G+z4qOciujQzB2FTMMXaw3TcKJb8R4t3XH8hjgUypyp
         i15g==
X-Gm-Message-State: AC+VfDxLD2AlAZAhn3mGmWB1SiHyOnTrO/mjLo87DYq5MX53tM7T5Xx9
        RVI0D8xvfdte3lPJrJ9yLpV7Zg==
X-Google-Smtp-Source: ACHHUZ4aIsHlp3QLHKLbVsZYuuWXiERXPitUb8hZdpEnOzuGdmu9qKt5hBFCxICctwTWwnUv4+F43g==
X-Received: by 2002:a05:6402:3587:b0:50c:1603:654 with SMTP id y7-20020a056402358700b0050c16030654mr23038598edc.16.1683908724657;
        Fri, 12 May 2023 09:25:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00506987c5c71sm4144116eds.70.2023.05.12.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:25:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 18/40] dt-bindings: pinctrl: qcom,qcm2290-tlmm: simplify with unevaluatedProperties
Date:   Fri, 12 May 2023 18:25:16 +0200
Message-Id: <168390871588.209400.13150711518665583777.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407184546.161168-18-krzysztof.kozlowski@linaro.org>
References: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org> <20230407184546.161168-18-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 20:45:24 +0200, Krzysztof Kozlowski wrote:
> All Qualcomm SoC Top Level Mode Multiplexer pin controllers have similar
> capabilities regarding pin properties, thus we can just accept entire
> set provided by qcom,tlmm-common.yaml schema.
> 
> 

Applied, thanks!

[18/40] dt-bindings: pinctrl: qcom,qcm2290-tlmm: simplify with unevaluatedProperties
        https://git.kernel.org/krzk/linux-dt/c/f69ba355d32e50a19f37ae6c3a7ee56cfae3e6d8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
