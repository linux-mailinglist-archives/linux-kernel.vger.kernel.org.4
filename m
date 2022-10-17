Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD4601898
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJQUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJQUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:08:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A47960A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d13so7395188qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbIGuGpjHgod5naCHisHPGnVdn1rirkuScIOCJ5aOaw=;
        b=u9bFBNGT4g/HoSvARkMvlVBoVtquQr/DnqYH8LzA4sKbBnWZxELXjcyTAgGMK7PF+k
         Nm4C+ZI9B/vovYTwMUox7jxWdZbTDsfxJZN0CZv8mS0sgVpNMGwrxfXi8JhoBiugsVqq
         Xziu9ma0mGHxFZ0vddKjaxMNWEDjVgpEyJdaluJlo5M3G7l7RYNRxmW61l54VmzEavEM
         U2ZYOYXSUrf1BtxKHTp94UTTE3vJwQWvEwkltR7Ss3qlSjb//YgFtT8KCtymPn5HHTp2
         y1VFg6z8oXE8BSaGZeDvaQEe+AwopMyW6Cgi51GBqiSwhNUuLUlSgvOMxffPrphTtw7j
         WP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbIGuGpjHgod5naCHisHPGnVdn1rirkuScIOCJ5aOaw=;
        b=jVBAWGqzrmt/yjhwu/PoPRqoUt3faRtcS7ooGZmdUEu3322WFGarjw0fkC3r0gBL0m
         5HI8D9YFrqpceCLZ+weh5DrV0yfPm9wafUnOQeopKKjGse+Y0aOETo9p+lASLzp3O25S
         xnEGpQPFWjt8LV6rbEDDueXANggtAVReo0WFs1sXPC18v18Iu4uuef8bozQhiLt6ba8Q
         RIvLqBizmnEnhZQCe3KU+r7oTXDfckewHJvlOCOqvZrSTMoEq0w3X33PongC1nZPmcX0
         8Nw1k/3tbKYucBud8OhLZXa28dYeO6d2vpTUfAGMCHEqzn/TAh5sr3qKY4Dg91M+M5Am
         e2sQ==
X-Gm-Message-State: ACrzQf3BzoGF9gTxatqcNZm4wnpkKpWIeYBu2h7cyuznDYzbg9VjH+hh
        d7onWvWvYndU12l/QYFoTCrSEw==
X-Google-Smtp-Source: AMsMyM4gFw/QUeiGyXYvLNoYZlqqzJkfeMdnHPFrFuR25qBYaAGk7eqgjA20nFqRZuxFggQT6trPyg==
X-Received: by 2002:a05:620a:440e:b0:6ed:ae2d:e52f with SMTP id v14-20020a05620a440e00b006edae2de52fmr8983834qkp.450.1666037303263;
        Mon, 17 Oct 2022 13:08:23 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:08:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 07/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
Date:   Mon, 17 Oct 2022 16:07:42 -0400
Message-Id: <166603728600.4991.5113586038322563358.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927153429.55365-8-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org> <20220927153429.55365-8-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 17:34:24 +0200, Krzysztof Kozlowski wrote:
> The LPASS pin controller follows generic pin-controller bindings, so
> just like TLMM, should have subnodes with '-state' and '-pins'.
> 
> 

Applied, thanks!

[07/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
        https://git.kernel.org/krzk/linux-dt/c/cb70c0d8b50a4051743fb42d2fc730f268864361

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
