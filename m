Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA8601907
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiJQULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiJQULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:11:21 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EDA263C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id f14so8096982qvo.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzm+M5ql46bszDpYpsIxOAKsDfJiO6WNCJCvd9/U0/Q=;
        b=cdZlETIVhA37euKh0E3sevOaniHAYMkDTizXxr1/mhO32MUiUFg4826GhPk41Nj4Kw
         V8dVJPBFPCSOMMkVSQ7CMo3cE9I+CuaxmAPRKkf0+XftUN47wbgHit8ReszikP0GfHCl
         KqH82YjHiBdUQZKPIYa4B89xKLqTaj6lvDUkpiiE6BkDbjnGKqlJ7IGuR5s9C+L8ZjM+
         7LSfKHb81sDdDi9hKIgzk7O4XZ+OJPh7i5r2HyS4egxkwDxRcVqAbSiYf7x6ffzNVaGs
         /v2ssl2BYd0S1SEuZrdY4kDuF5fVbPkv5Bc2UBlplBmPUxz+4oseVRMoPUm5kUU0fZno
         VzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzm+M5ql46bszDpYpsIxOAKsDfJiO6WNCJCvd9/U0/Q=;
        b=XiAvT2kQvN0t7DoEgL9g7i/rDZUt3kEyypUM9gjwFK9VkOLwYy+cq33qTgEojVt96h
         7TfGCVXGkEe2OYVKj88AqK0f9Jvx5XPCRfp3dkOQGiSjXLNvncQGyD7qwcpww2ycpr/k
         weXQlQN6j5mAiOfIj5KV1gwbXm6zCD6lbcpz2FiuveeRLj1V9b3fp1B18RHRR/8XbMHP
         cMHaHw2zSOl68JkLR7P9Dsd2QhLaFVuUFQz1Toi9kMZGjjMDSUxn5cmFpb0vCIRmfX8D
         nhBImJxOnJGqrrBin20YH6OEcOmgOwNRetz4+9dDHq5tgNk9hXtII8Vok1Xwt8WLpK6E
         Jpgg==
X-Gm-Message-State: ACrzQf27vuVXmGTb/jsPQUS1+rYhStoKu0AtHvq4I+fkGP1UwI0tMvCp
        3zQv/iOlrc9UFH0xk7kRZiWGcw==
X-Google-Smtp-Source: AMsMyM45O5yNXGm1rcoajle3WznZSfPM14DUXSr2gRl8vgwluPvfYKOkS6qO0fWITLfvKwRSAs7nqw==
X-Received: by 2002:a05:6214:29e9:b0:4b1:8d19:a2e8 with SMTP id jv9-20020a05621429e900b004b18d19a2e8mr9689423qvb.46.1666037366099;
        Mon, 17 Oct 2022 13:09:26 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:24 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v5 28/34] dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
Date:   Mon, 17 Oct 2022 16:08:09 -0400
Message-Id: <166603728602.4991.9934501805858220351.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-29-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-29-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:29 -0400, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.
> 
>   qcom-sdx55-telit-fn980-tlb.dtb: pinctrl@f100000: 'pcie_ep_clkreq_default', 'pcie_ep_perst_default', 'pcie_ep_wake_default' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 
> This method also unifies the bindings with other Qualcomm TLMM and LPASS
> pinctrl bindings.
> 
> [...]

Applied, thanks!

[28/34] dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
        https://git.kernel.org/krzk/linux-dt/c/8cd7d9e14fd861c402ccdf243678439036ef7eeb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
