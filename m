Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851156D14BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCaBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCaBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:14:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BDCDC1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:14:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b6so1438043ljr.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680225296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMt5o7eVOVyetFxZi6Wtlfos4TgIUANblrdBkQ0mZ+g=;
        b=ovLvv6Z3mM4rfJoKMIhlkqF5ZX9/tY0KVKB5Iksff70ffOL8mKfTOWOHOXEBDogsLy
         zmeeH4c8yT/NCB5HZvz22V4u3k0Ax3JutM7KiKHumlVDFSwGkjA3TpirAR3MXE6nKQ2M
         0X1uWbcsqKdFB9LLh42tYPAsYxCTYRa8G6lqsczqqNCqGRuP3pwlrAKg/4EFz0Ur83v/
         qvoRBbuHeKJ8qvhUi++M0Nihvp2Zrm/1CEwOiZr9eR+SnHTwpOpFqIX2p9QgvghkI7qZ
         SOwhDIhwVFdFRe8P12/JxoMTwrYazUnsQAAtraLr6pEpTDFLKEsxFapccp05p4xCoS8S
         3kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680225296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMt5o7eVOVyetFxZi6Wtlfos4TgIUANblrdBkQ0mZ+g=;
        b=J4OToigyS9VJdL7LEe8bV8fpy1quSwDqUT/nu5+hTyr9UxXSiHZWvh+uMc2DEc2N/m
         6OS0DtppfesZEejImvTgv+WXUS+qJvmgzncDky2J4jBBufz3Vdnmr2x1pWixT255CFq6
         BDR5zRy2SLCdUy9vzWPveDlGVGhwyoYvIyYSd3R1TL7IHTyxeYxVjKn0ngpARCDW6E5G
         5UPbvMQWQZVn5Lpxdm9PpBPQ2nuDK0bTM7ZK+5Bpeh+XF9Q1Y9P6MWRdcXO7VxRRuOX4
         dO16/u4C6PqkINpzJMM6aQ4SXByJ35PMVl0KG/XHUZUAjcE4zVxrX7qaqmn1OhixsFLo
         djzg==
X-Gm-Message-State: AAQBX9cxBl8jBwh1kF0W/4jD4qcfrOx57dATaSG4KrSyfZAHL98zJXU7
        zt8RJbZ9k/pP9/aZ1/Phq79RQw==
X-Google-Smtp-Source: AKy350bB+awwGcgIgXmdkRxLiXinTgLBgl/AzH2xLNTvmCh9sh6FfYlLCnNuLerm3AcQT7uXNulBNg==
X-Received: by 2002:a2e:b614:0:b0:2a0:3f9f:fecd with SMTP id r20-20020a2eb614000000b002a03f9ffecdmr7740015ljn.49.1680225295836;
        Thu, 30 Mar 2023 18:14:55 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n7-20020a2e7207000000b002986854f27dsm134573ljc.23.2023.03.30.18.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:14:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/5] SM8[12]50 GPU speedbin
Date:   Fri, 31 Mar 2023 03:14:48 +0200
Message-Id: <20230331-topic-konahana_speedbin-v3-0-2dede22dd7f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAg0JmQC/x2N0QrCMAxFf2Xk2UBtJ4K/IiJpl7ngSEujIoz9u
 8HHcy6Hu4FxFza4DBt0/ohJVYd0GKAspA9GmZwhhphCSkd81SYFn1XJZ7pbY56yKFLmUM7xNMd
 xBK8zGWPupGXxXt/r6rJ1nuX7v7ve9v0HC8vjcn4AAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680225294; l=1580;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Z4sih2qa0PUG8gStwgxQKZOfyMiBl0L0thVhEIYRgTA=;
 b=dDH9R7V3yQBHD6qeTJlYEPlkejHdOYxSa8xt9FibgBrfIH7UZSZ5KtyijfLN7/4YvNKdhxl1le8W
 5AD4PNGiDVycRXBzI/kobVEyCawYc6HG0/SuS8nTuprHGsz7ivQy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings SM8[12]50 (A6[45]0) speedbin support along with a
touch-up for 8150, allowing Adreno to cooperate with the display hw.

Tested on Xperia 5 II (SM8250 Edo PDX206) and Xperia 5 (SM8150 Kumano
Bahamut).

v2 -> v3:
- Don't swap speedbin 2 (with fuse val 3) and speedbin 3 (with fuse val 2)
  on SM8250 (no functional change, this is all a software construct but
  let's stick with the official mapping) [2/5], [5/5]

I kept all of the tags in good faith.

v1 -> v2:
- Drop bindings patches (Applied by Srini)
- Remove leftover comment about missing speedbin in 8150 DTSI (Marijn)
- Collect tags

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      drm/msm/a6xx: Add support for A640 speed binning
      drm/msm/a6xx: Add support for A650 speed binning
      arm64: dts: qcom: sm8150: Don't start Adreno in headless mode
      arm64: dts: qcom: sm8150: Add GPU speedbin support
      arm64: dts: qcom: sm8250: Add GPU speedbin support

 arch/arm64/boot/dts/qcom/sm8150-hdk.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi    | 31 +++++++++++++++++++++----------
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 31 +++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 11 deletions(-)
---
base-commit: a6d9e3034536ba4b68ac34490c02267e6eec9c05
change-id: 20230331-topic-konahana_speedbin-abe0c725f244

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

