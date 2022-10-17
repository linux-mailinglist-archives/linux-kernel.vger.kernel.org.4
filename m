Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631B601919
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJQUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJQUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:11:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6097C75A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hh9so8448692qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy2CqhbAs+lw5/HwT2HDKC/bvqHfWj6CLYVAmg5gg2w=;
        b=RB3jVkumYiI0YxuvBZFxKvBld8pKOcnxY+kHN55fw5lSaKlsUbb17FBKZrAFXmvRlM
         L7Af6QEZDGdtPZnuhIrMDm45DpaMV18z3X5C3GJKshXc2Ag74XZK4NeHAtwrkNVBnZzc
         Rl+YYXGePobRHyyobS1ajNatNUyIRJ/BAB0nyc6Nnf1jOfQpiHUkPzol8//2i2D1F8b9
         iBb5RwMui2fp1ufsB1XgTc6SgWs5i0NkntUa7vP+cgdub2mrHKReGK2VJK+5KLBl5h5s
         O3knoEaqu+uRVS4TLNRVArqw7tbHfG/Ftr4PUsCqSmDYAB6bNp0yQESRJ1HdBd5p8e7t
         oOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy2CqhbAs+lw5/HwT2HDKC/bvqHfWj6CLYVAmg5gg2w=;
        b=GF76/38khEbM0xeXi7GCLAbNl6CwwNi3w6r0e0mw7N0PMgg6xgMrh8NbR8o5BPWwlX
         qB2ODS2VLyUag3wuL2v46ycnAbsgGVGcNzfFhrujGMKdRQlJGsF1FDMLW2esgWyTqSxX
         XlMARjz/gkZ0DL8Hba7sDOmEMMj/5tFvbEhemZP2ceWcVbjtN8JYsMDK+/GBvh5uFS6B
         /MduQckRCowkJI8q+IigOq0qUyXWkRUvkftY+Jk0jKGESdMWEC1NwklyZ+SisKukqYtL
         GW3bdMERBVBpYWcb8ACUY6xUcGE3JMm3lojnTIRCP8upacZc3Aqtg8oZFB0m40nIvo2O
         Y0LA==
X-Gm-Message-State: ACrzQf2tVzLGedpUyLDfmZU8r+7R70MW205RYb6UFCXaTXbZluBWcuCh
        5LiuIVzYLpEgjScuRpOHdb3Jxg==
X-Google-Smtp-Source: AMsMyM5Ig0elKD4YWbaJXabso5ujjQjkVcHrqOJWLmltOn2/YjaSD4tApU754nRE12Xx6V4KDqk2HQ==
X-Received: by 2002:a05:622a:18a:b0:39a:ffaf:6c9d with SMTP id s10-20020a05622a018a00b0039affaf6c9dmr10010578qtw.253.1666037373621;
        Mon, 17 Oct 2022 13:09:33 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:32 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v5 32/34] dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
Date:   Mon, 17 Oct 2022 16:08:13 -0400
Message-Id: <166603728603.4991.11238879558058682062.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-33-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-33-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:33 -0400, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring common
> properties, other pinctrl schemas and additional checks, like function
> required only for GPIOs.
> 
> 

Applied, thanks!

[32/34] dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
        https://git.kernel.org/krzk/linux-dt/c/7947f01598418c999be7a5cf0371221bdacd1721

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
