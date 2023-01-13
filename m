Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B526694B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbjAMKwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjAMKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:51:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A37682D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:50:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mp20so4782431ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7suYhJlOs+Ou+7SF4CL1t0WqlgFEmO1O4oH5c55KMM=;
        b=HgHKgHi3bvPMnasBMa4K6x/8CTYGFKs3AksfO+ZG8ngkTY6su5GQ+O1mVxnAqQqZM2
         vq7xnQ92iYE/PmdvnK2TnEuHii2oMR3Km4US+Xxw4lqlnwOBu4HRNWPb8qllyeJ3RITH
         LgNnzqah8n3UN9nSnskE2pmQohiO7S5bSqJrBgMDtCF4Zil4u7n2Jv7yBEMq5e5bNQ63
         7tLyAd5EqzqncEl1k2HNbOHuOLVWe+XEKyGOZdGyMpDQvn6FarO+5paKFiX7qCebKWuD
         yCo7Bmdo8QwMhjZH9f3VihjhPYp4IezYr/Q2djsYh3LeSkEidVqpwZ1+X+rk+nRssrfL
         kBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7suYhJlOs+Ou+7SF4CL1t0WqlgFEmO1O4oH5c55KMM=;
        b=O/YcNlbAvkuOUoqfpQPTl36b4NzojYtE+o/YdFQ7GtZVuFh69vLS9jFVJT9ctn74E9
         956mEr0wfGvxB1RMe5GAgdVIszne1AODGQ8a2yar/YurkX0dxUCGG0dJwMpRYD6gcJtA
         pkOTl6vVSvjcYihKn2GE5zKVKSqqSuU2nuM2+9bKngCiQArppsLAKZdD9O/Kyw34Wr3F
         Z8wZ0TyRYCF9p5VokOs7WzdgkmFCRhEBaa+1Pn7kN3wa8NK8us6n/Q988lMwJeTLyeCy
         rcTtBSpq4T1oSVFLGUELi0Zt6mc92CcZ9uZJTcThqNUjD97GUzl9NcGZHycvJKx0AzFk
         XhoQ==
X-Gm-Message-State: AFqh2kqAcwjdvChMOBgMA5016YPZi9StTQEMAmwB3sjhbuobI1VwLFY5
        o+PvGPD4nHaaI9B81NVk09epGLIjGiD3i1sa
X-Google-Smtp-Source: AMrXdXudHbRmICwdH8+kD4PntCHqlv17xxeMaiWgGYqJu4c5SbZUJPm8Ons+9OV+XCKS/LNp2mPLpA==
X-Received: by 2002:a17:906:a1c5:b0:7c1:2529:b25e with SMTP id bx5-20020a170906a1c500b007c12529b25emr66724485ejb.43.1673607031185;
        Fri, 13 Jan 2023 02:50:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm8348581ejf.210.2023.01.13.02.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:50:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Andy Gross <agross@kernel.org>,
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
Subject: Re: (subset) [PATCH 3/9] dt-bindings: pinctrl: qcom,sm6350-tlmm: add gpio-line-names
Date:   Fri, 13 Jan 2023 11:50:14 +0100
Message-Id: <167360698783.32701.12174171114501759309.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-3-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org> <20221230135645.56401-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Dec 2022 14:56:39 +0100, Krzysztof Kozlowski wrote:
> Allow gpio-line-names property (quite commonly used) and constrain
> gpio-reserved-ranges.
> 
> 

Applied, thanks!

[3/9] dt-bindings: pinctrl: qcom,sm6350-tlmm: add gpio-line-names
      https://git.kernel.org/krzk/linux-dt/c/d3431ec2f7cc0bb77f367d27d68fc79650ece864

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
