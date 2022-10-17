Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D896018FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJQUL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJQUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:10:41 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26927960A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:00 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g11so8471575qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvo28Wc1qMgS7OyjETHgic0qdepe2ml/sCpPc/o89Kg=;
        b=AGR49KrhJgDvMrQuowFqk+U9rHEACUdAftAqf70y7RGt2K1aLKMBaGoZbugnVsSoyl
         cdvo+WexCrXD5YM/CfTwKJ8zQAhQ8OFDwhbVnN0QkJBuYwCOBu50Qy39mLSSWFpi0rIv
         J/6iNOg3dquDpYOj41qRz8V+tLZ8P7IZkFgDXyFHTODdimquDIorESftqWYO00+dDMDU
         DUpmatrnRMu8myVfmWpEU4wwJRp8ymrS6jkp5d/3dw4+Vr+qd4JOmNsCO0M9Xz8bj8+o
         ItquZ7B5EceFMVviffFTfROcbHPU54RvcMBmaR+N2mNq5GkbhvVSJeaUVi0byHBZPwJS
         0Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvo28Wc1qMgS7OyjETHgic0qdepe2ml/sCpPc/o89Kg=;
        b=7OGbVGNdWiNlr4W4Uw9AQEn0EYKT8b5iZitNqJdZSlCfaSjleJYrC5w5EF8/Rk4dyL
         gyPjmoC9XT3aIcpZwwAnNhkBigsEO4OXQmKom4wJJrqW88H+pmdEjH92RoNZDKAu787m
         wsY6zDI0fsOPQ9fW+mfdZViOnYh+etvHojHyjowKpK34pRWzwa0vlfIjVFAl5Egj/HeY
         16f2JYgwHCWlM28CUScoCZsPfcHHMCTegZTfpP9Gx86dojy5ypw7S9DEkeUuoyRddjg4
         fX9RFu7D0h3D82XD9TK3IIKduezUTc7MLYNpzWyojI2xh1/63VCvK7by3q3zjVeR5/yN
         zS4A==
X-Gm-Message-State: ACrzQf0rlxTt81jGdYE043FIT9FWO8wCFgzziIiOTcLlMmpJ1G+Xyagh
        PxZb3m/n+s4Yj92pUeaNvDiXAA==
X-Google-Smtp-Source: AMsMyM7yUfq5LmDlz2IzxG2aEoO5mrqbXm33XIA4owFsw2w/gXrGJxs6Bx2Zwi2Wd/zI2Vq6ggj0EQ==
X-Received: by 2002:a05:622a:118c:b0:39c:32a5:d285 with SMTP id m12-20020a05622a118c00b0039c32a5d285mr10325556qtk.414.1666037358697;
        Mon, 17 Oct 2022 13:09:18 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v5 25/34] dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
Date:   Mon, 17 Oct 2022 16:08:06 -0400
Message-Id: <166603728602.4991.2117945101964115867.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-26-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-26-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:26 -0400, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> 

Applied, thanks!

[25/34] dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
        https://git.kernel.org/krzk/linux-dt/c/9fb8c097b933c42b15c0c67d52c24e26e2fc7c34

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
