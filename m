Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFF6CA739
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjC0ORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjC0OQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:16:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865246E97
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so36833751edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISvse2cGQJrRIUvXeCVbpkIoreFOaLucU+fudoPdjVE=;
        b=pKUbWMSsZEgq+l3VXxnAnA8IP/TM/DtW205mSTV3JK1O4qJeXnJuHWdHgIphHK3kkR
         XNW53YqYWxVZInhk/9NIzQgu0SAotKmDO364nWjXScOMVM8nTNS2eCGJTa8ZP3TpqHlM
         Y3YbOTE97fifBo8DFZOw1zbG1SbOvWP+GNij0zIDkbgdoCL36ahWdGNhkEaljkZlzv8b
         meCj+c7U9sLlZje836JRtMjrgT56aYcIXSkk9oXivF758GrhtYnXXLVeG9gfFXcO9tS2
         gbLDweQnMm3sPVtkiUftv28LgrhZHk+Yczoc2YQmgomuXYaoaY+RTXLxTsJLnSHOhsRz
         MsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISvse2cGQJrRIUvXeCVbpkIoreFOaLucU+fudoPdjVE=;
        b=YkyqXb/q+E1jSsRn2TpK3AioqB5/l1WKYueh3O+dPpR2x1unKz27hNyMnL/Dk9RkWp
         nZPTFundVT1wcCk3gVYekYywKVlg+TtkEIV1GmNdBgnuT2KF49SqIwrtyDs50mqfpXhH
         kxHHaNE8jpMer+nWXgQEkDGk0G3oU9fVs/Ta1LqErYL7efbE2YHdFEuxIk7fcfVLiZIV
         liacBJ7s0cA4ML3A4jc1zmPZbBBuXR1t66DsnKmkvKiB3KeGT3TPOcKYwxF0fuL8PrjF
         EugjV3Nu45PGA+dM8ktFULiK+rMQ2K4kcIpqEn7lyPc+UIO57gqBRP1aLH2liJRNi1Sq
         CaJQ==
X-Gm-Message-State: AAQBX9fIrCwXdK3TcnWgOtGIrDOGYmldDosHaIxuxaVF5BPDa2psyX/q
        jPWaSLv5RfS7U6EYQBnalah2Yg==
X-Google-Smtp-Source: AKy350YTNEvYnbJloziJHhVwZM3OMnt7za1N8an1nZ8/GgVRpvaIP7SloLgH5v9vsnfJqlL88OgEWw==
X-Received: by 2002:a17:906:5646:b0:930:7d8f:15a4 with SMTP id v6-20020a170906564600b009307d8f15a4mr12181023ejr.53.1679926467631;
        Mon, 27 Mar 2023 07:14:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm11273339ejb.198.2023.03.27.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:14:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/5] mailbox/arm64: qcom: rework compatibles for fallback
Date:   Mon, 27 Mar 2023 16:07:47 +0200
Message-Id: <20230327140752.163009-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v3
================
1. Narrow the scope of the patches after feedback from Dmitry - only few
   variants are made compatible.

Changes since v2
================
1. Split fixes to separate patchset which is now dependency:
   https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
2. Add Ack
3. No other changes, as discussion with Dmitry did not reach conclusion on incompatibility.

Changes since v1
================
1. Rebase
2. Make msm8994 fallback for several variants, not msm8953, because the latter
   actually might take some clocks.
3. Two new patches for SDX55.
4. Minor corrections in bindings style.
v1: https://lore.kernel.org/all/20230202161856.385825-1-krzysztof.kozlowski@linaro.org/

Description
===========

If entire approach is accepted (and correct), there are no dependencies and
patches can be picked independently.  Although the best in the same cycle, so
there will be no new `dtbs_check` warnings.

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks for few
    variants
  mailbox: qcom-apcs-ipc: do not grow the of_device_id
  arm64: dts: qcom: ipq8074: add compatible fallback to mailbox
  arm64: dts: qcom: sc7180: add compatible fallback to mailbox
  arm64: dts: qcom: sm8150: add compatible fallback to mailbox

 .../mailbox/qcom,apcs-kpss-global.yaml        | 31 ++++++++++---------
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  3 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  3 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       | 11 ++++---
 5 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.34.1

