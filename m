Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920FF6C39A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCUTBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCUTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:01:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F3353711
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13so16480959pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679425289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dQb4dJrfcolb5gXo9+/3PYROIvqtcKnbRQtwUdLKHA=;
        b=ZUykKAM4RrXRvi13ekxIlpLajIvF0MH5P1lCBivZtKMv+2UIrqrw/9M1rNfgkLeJZF
         CgsY33veHGznGmmg5bo0zYc7AsZPHQb7QqaGIZ/JwW3CMluwADRnyumyDKZLcffE9IgN
         YpJUsVhG/Xmq3vxfm1lGa9F1IApZ0D5tvS65PW6aFothv8AYduOVUlNbHSdIG5dG2yNT
         8cES+nxNV1bdAt4JXLrIhyOQXCyiJJFd3cHw9Y0ejgA/T7oJOMg6c1XtjAHPrEB4DENK
         /ICLiu6ZyDnhqPAky0LxsLnvRVvDIudyY/hDzEXDfSijFdrHR9Jl7SmYgRfEMfJqY6aT
         yO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dQb4dJrfcolb5gXo9+/3PYROIvqtcKnbRQtwUdLKHA=;
        b=2cLANdQ3Zrq9loESdm9cXZ99XlksTgDCAGZAdnzOvy7RP7cGXHQnHiccT93fVJ6ub4
         Fc7iIgwVxX+RS19TWw8f7SgQ1ckDcnavRlddDC+CmWywcvXYEzPAzsDiRHunQeZ43HRj
         2OjUMlHAynTj46jrself9MhCRwprEz2TotzGOH1+68vRjTq8e9OB1e7Vj+JWN/4b453B
         RKmvJMX6iripW8/595PkIaGIqf3ekEYVnRGQqI9mKmg6w1kVRuXKSVFYrux+Xas6gAlf
         tqdJV89bmg4cc4Hq9KWEtC8gI72TzX8tM1/CpVUZnuS8Mmq0yctuVG2kjPgmQzT0AWr/
         bg+g==
X-Gm-Message-State: AO0yUKWohHwQhLqNpV6pLQ9YCJWu1A9WkjTkWQoqAFGTfeVnadCrwEqB
        6m3ckj+s98gOeyiUtZTkzcfr8w==
X-Google-Smtp-Source: AK7set/03/IWwwhyyap7zmWCXvlW0A2E0FhUl668wRuxDJ3nQIuxSZ3JYTAribWUk89xHY42KSJFyw==
X-Received: by 2002:a17:902:cecb:b0:19e:416e:abf5 with SMTP id d11-20020a170902cecb00b0019e416eabf5mr17661875plg.34.1679425288765;
        Tue, 21 Mar 2023 12:01:28 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709028d8900b001964c8164aasm9043453plo.129.2023.03.21.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:01:28 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org
Subject: [PATCH 0/5]  arm64: dts: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Wed, 22 Mar 2023 00:31:13 +0530
Message-Id: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables Crypto Engine support for Qualcomm SoCs like
SM6115, SM8150, SM8250 and SM8350.

While at it, also fix the compatible string for BAM DMA engine
used in sdm845.dtsi

Note that:
- SM8250 crypto engine patch utilizes the work already done by myself and
  Vladimir.
- SM8350 crypto engine patch utilizes the work already done by Robert.

This patchset depends on the dt-bindings patch which added support for
SM6115 and QCS2290 SoCs:
https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/

Also this patchset is rebased on linux-next/master.

Bhupesh Sharma (5):
  arm64: dts: qcom: sdm845: Fix the BAM DMA engine compatible string
  arm64: dts: qcom: sm6115: Add Crypto Engine support
  arm64: dts: qcom: sm8150: Add Crypto Engine support
  arm64: dts: qcom: sm8250: Add Crypto Engine support
  arm64: dts: qcom: sm8350: Add Crypto Engine support

 arch/arm64/boot/dts/qcom/sdm845.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 1 deletion(-)

-- 
2.38.1

