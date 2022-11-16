Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D762B769
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiKPKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiKPKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:14:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB562C124
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:13:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g7so28764437lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caVQe8sb8fBoXN87dmyVLgqXfxe1FLCTw1IH8TSlw4E=;
        b=DmRkH8EyJsNESuTklewZXHDIhTT1Jx6p62G6EgAjaSAE3EljVc7YkcOzNPbH0Gn0cE
         n0sRbjr9qiIw3gFasdrxEjtgcOP4VT/s+lju0jYRpHPA9cOB52KNWXi3hxTnIUvAdGJ/
         zH6ehjrPO+JfLxL9XxRTRcea+M4pqEioiSAu12ROLMBF55AQqsQjOyCmpEF9PDNyaL4E
         AIB8stwKdkSmClKVA3OuBqgRlRe32Elx8xoUITMs0r8TbSOz0OkXJBUITGh3b3449gVF
         YzDhkm8/IlvBwvXdY6Opo75ZlTftALPIwu5Zz19F2nKujyvHC48Sz4pOTGuzW1iVNPjE
         OvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caVQe8sb8fBoXN87dmyVLgqXfxe1FLCTw1IH8TSlw4E=;
        b=NdH2AAkRg6ttqtMPcH0i6Kx2r4vu0YchWppvr3IYRpxfQF4bz1R2WzQRr1E8pHAofl
         RXHX5dJwk3aOvV+kSlxrASYJFjoDRZSIbhUfSwwVZO0Byo9v9FtQ7IojYtxZE38j0szg
         d4CYkvdcR/Xl2qnS/xqYrsg5GUdGD6VBPK5DwAdkVXPwuic518BkhT9+3xHLvQiS0foA
         w1PvuWPNK7G3dSwqb0uFR/uez+Xs24iWZmhUJfTY6PaQAMJKWxFQU8g/LW5MWDIDmuQb
         Ermxd7cPV2VzrqYC6JFSWGZ45uz6I6L/2SvBPU1YZBfH8kZ93mrmJBLAwwQCY+zJPbvl
         PLbg==
X-Gm-Message-State: ANoB5pmgiMOHH3Nbue2dj1Xrk2QTjrymtgaKGlTejXIsFZg1xp/aYFSt
        eBpg5eajqUmNefM9GtKudW+dbw==
X-Google-Smtp-Source: AA0mqf5o6+aSJXLMf+bLzzXhkJ6jTRB4QWfrXkkgAEn5F/5x56+zcmZYD5nUxEomk+v4PLbl/sRZmg==
X-Received: by 2002:ac2:558c:0:b0:4a2:7692:3a0a with SMTP id v12-20020ac2558c000000b004a276923a0amr7301293lfg.71.1668593599094;
        Wed, 16 Nov 2022 02:13:19 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512020a00b004a45f2e49b1sm2514432lfo.273.2022.11.16.02.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:13:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/3] arm64: dts: qcom: sm8450-hdk: add sound support
Date:   Wed, 16 Nov 2022 11:13:11 +0100
Message-Id: <20221116101314.52887-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi,

Changes since v2
================
1. Patch 2: Use lower-case hex.
2. Patch 3: Use ACTIVE_LOW for qcom,wcd9380-codec reset-gpios.
   https://lore.kernel.org/all/20221116053817.2929810-11-dmitry.torokhov@gmail.com
3. Add Rb tags.

Changes since v1
================
1. Patch 2:
   - Whitespace cleanups.
   - Correct include - do not use deprecated one.
2. Patch 3:
   - Sort.
   - Add Rb tag.
   - Correct include - do not use deprecated one and drop q6asm.h (not used).

Description
===========
Initial work (still partially in progress) adding audio to HDK8450 board.

Working/tested:
 - speakers
 - one channel of headset

The DTS patches do not have particular dependencies, however they:
1. Use updated ASoC bindings:
   https://lore.kernel.org/linux-arm-msm/20221111113547.100442-1-krzysztof.kozlowski@linaro.org/T/#t

2. For full operation need changes in Soundwire and Qualcomm ASoC drivers, not
   yet upstreamed:
   https://github.com/krzk/linux/commits/wip/sm8450
   Booting remoteproc without these changes will report errors, but these are
   expected at this stage.

Best regards,
Krzysztof

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Srinivas Kandagatla (3):
  arm64: dts: qcom: sm8450: add GPR node
  arm64: dts: qcom: sm8450: add Soundwire and LPASS
  arm64: dts: qcom: sm8450-hdk: add sound support

 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 160 +++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 335 ++++++++++++++++++++++++
 2 files changed, 495 insertions(+)

-- 
2.34.1

