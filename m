Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC6D601910
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJQUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJQULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:11:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005F7C1C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m6so7398309qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya6LAWLtRvqptDBCQ8DGih3wiij3R/MTT1Zh02VMOsA=;
        b=JyxIybLBqYhYiLzUV1JMmLdM+x55cQn0UDuG1o77mOPkQrxGuc6I3FqKZeSf9X2hs/
         CwlcIQsUdijKpd9TTF07+BSxHcyFVe3PoMCim8qZgVDI2RiQdWpW/7WxS0qeqMX3sXPN
         gFnvFE80TlmvTXC6cviNUST1kjYkvBJz2hgnl/6g/hInv6pk2oApwsUhIWAbhCyu3xag
         87j95GVU7uu/sbJTKvStNfW1nkQ3EMEiRH8qbps2JKKQbp38NhR+WK29LfNaG/wanYvC
         p+Sv49abQYSgc97dPXy9/Kdui+8ELR9eqrofqSSp2sJhbM6gB8L6ZY1qUnuozU9Ct9bu
         bGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya6LAWLtRvqptDBCQ8DGih3wiij3R/MTT1Zh02VMOsA=;
        b=emkHzCGInSU0vsrkgzu49i9by0XiKaKwJcyEUQuzwc5cnEJjun/eL+SFjQwfh7IeN3
         JOIkreKJN4qFmKSbgIOejwEjmvTsACcEo3S9+tSNLpDTxqW9Yi6b0ASDxb1w9y+wXeGX
         JhZKgFO9idKJcjhTl3TC0H/mf8GXcIP/eG8myBs0ypZGywPoEWQfmk48lTB6vns/BXjf
         ZM943zHLRUsB3KIR3tk+hzfdfF7ZMMPuH6lGmCJtGSPmyznBU0x1A6mJHVKPo2ChdZSo
         zU2UgVSdpfOSxydw1wvVRoZbAh7T1p4Yh6YobJ/kdazDMIJ5tpO4slmEzw6sGBFfC7Cn
         mcug==
X-Gm-Message-State: ACrzQf3yRN6hfL9+lWP1OOOtzZ92Tu5lITnWqI0QSJr7ckNvjCECN6CU
        rdwNVyAClfD0yDyMVGvRRI9V5g==
X-Google-Smtp-Source: AMsMyM4VDAEeETLoRqdKOReEFDlCs1xsXromKeNjZxNb82sXSSTfoBNG/FKn8ENwm2OjBkg97YfgRg==
X-Received: by 2002:a05:620a:458e:b0:6ee:cd9a:212c with SMTP id bp14-20020a05620a458e00b006eecd9a212cmr9127798qkb.775.1666037371439;
        Mon, 17 Oct 2022 13:09:31 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
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
Subject: Re: (subset) [PATCH v5 31/34] dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
Date:   Mon, 17 Oct 2022 16:08:12 -0400
Message-Id: <166603728603.4991.3891583761325602602.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-32-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-32-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:32 -0400, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> 

Applied, thanks!

[31/34] dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
        https://git.kernel.org/krzk/linux-dt/c/c535fe66f4a5df69c57faca1fc04a6c1b50240b9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
