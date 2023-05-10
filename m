Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91B86FD97A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEJIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbjEJIcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:32:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C835BBD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so236750565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707510; x=1686299510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfyrxjWL0RhE4oRvJlhRvnpk8Ch6Lm8GjTN9qm5thp4=;
        b=iCgSKjHBVxcI7x3eAUPeDFY5rGbZzu/u1F7udTnPN6UHAXs2a6YyooN/jHQUfDh8WI
         QoTwZxaiU39RKgj9fmeSmhT91Hr1FlsE+BbAWQTY3w22ipQzT49ZWnhdaIbOE974iLe3
         Srq7+zZ0rYi5q5t565Scd4Yjjw5HbQ6zobtnKTWXQXYHdCG0Wump7KDDvFiLySbHwC4Q
         5wgUzQ+yh1AF2bZVI97TpW1v8YVZ+PoJ6AjfFqFB2wfPhlkAXPefdQIsfFbyCP58JGKH
         rV0ZS+BSXBo4PJ8qEg8Ct/LMMoK6dg3T6aTr5HPii8stvsBozOTrBnU0Wqogsh/E3lGG
         aLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707510; x=1686299510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfyrxjWL0RhE4oRvJlhRvnpk8Ch6Lm8GjTN9qm5thp4=;
        b=lq8j96ZosfSiwZWT6BfPgrXwrNJ3rAliRmTvI5gn9ixW2YOghdegHSg/6CnkD5ee+W
         oDPUlM8gr831n1jLtS59ZfnSSvioBZDgwK9Dj24knHLn/sW702uFKCQqTY6ROdIaoqu8
         bkulDQO2lG9HKOqR2GU0Yat0N5e4emGKxnhzC/3sqtOWBpa2dKtNwHgBhTliClpc+6Fx
         EMtg4YKi3gxwnU2irdAmLFc28QJ+d70oe0T5e3nXhdV8Rm48By3iFwWCTgS/NYXu9Ihb
         ai1gwE/B3uMmdoGHmy3tqFSFOQ9S1+04Z4lWmSpSNdkROFbRtHnOpKl4xEWUQbOphf/a
         k4JQ==
X-Gm-Message-State: AC+VfDza6vVVxhn1hYUItwg6KV5bCixSMyzcpQ0xVE+kVX+6eB8169+9
        8VUPlrPCd/EfIkLr4BHMefMz5w==
X-Google-Smtp-Source: ACHHUZ7/9/C1cxdP7hxPukzqRZ48Kx80pCmS5PNZvNNqPnxKg0+avseDJjGJet7mjWeUN5EiPMchdA==
X-Received: by 2002:a7b:ce98:0:b0:3f4:e3ed:98e9 with SMTP id q24-20020a7bce98000000b003f4e3ed98e9mr87203wmj.0.1683707510666;
        Wed, 10 May 2023 01:31:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm22108737wmk.35.2023.05.10.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:31:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 10 May 2023 10:31:43 +0200
Subject: [PATCH v2 5/6] arm64: defconfig: enable FSA4480 driver as module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v2-5-8acbbe1e9d14@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=84LvFKYKj/IK+Yjaw78nGL918SdMvkOjKAF9iiHlf4A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkW1Zwm+zhJ6X7jgvRiwruaRrF/zV2dZic5n1YX8XI
 c1s67GaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFtWcAAKCRB33NvayMhJ0UwAD/
 sG8qu0yDTTYRoH9w+sD2H1i/a2kceM/Wel/DT4iMm7/7g3NOfpI3xDUFlLOQqM77Sn9wdbmONTNLkF
 RKJEejc8gUFEo1Rlq4+BjmV8F92Ix8OR2GzvfqCrHkDoTwZQsREx/0MuKGK23FhRivp+JBCC+f5Qdu
 z6m8oLd/eUhw1gvIdnRIcWmOilNoDD4QE1kkmJTN1GiypJgUtlwDM257cjbKRhMKARb+7D2UodL9rb
 lruWhbFoEayRykOcZRv1g6vZ+Ezh/liTE3yu2ARSpcfOCkNDETy3AfnTNvX+NLpCNkNgNkN5EcLcYD
 3q16nFGI08jaQpXmEYDRITel1o+OKYl8VdAbV0jp7aRFdyYAFHOrN3AbC535Bp159rO8PSYyE7uEN9
 iGYFNT/ZTphPlcxazh8ePRb/3jMaOLE61zUmfmigdsmvlW2KO/v45ktx1AEaJWzAVelLSUdOk8zZZH
 7BAxvStQ2ZyknwA+hBKQjQ3wdo04AVbAT41eZwoEEuo5rg0hgkrwqesHzukQsTZCFt//oHEcmc/Yvt
 P4VOjebNUdY3wGP6I+0Mo55lSHtQ9MhmwRMNpz78fC2n5Qx9EnFVRGbOHJwA6OacPEV4Hg09vn24OB
 8HlL9dPIL08jJGafBSe89GGMDZNqSScHS4ogr++FYPUPQGeTmoYK4pFIvjiA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the FSA4480 driver as module for Qualcomm HDK8350 and HDK8450
platforms to permit USB-C Altmode support.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..e548bb52260e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -992,6 +992,7 @@ CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_TPS6598X=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_UCSI=m
+CONFIG_TYPEC_MUX_FSA4480=m
 CONFIG_UCSI_CCG=m
 CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_MMC=y

-- 
2.34.1

