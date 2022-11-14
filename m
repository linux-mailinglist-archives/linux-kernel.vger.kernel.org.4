Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03F6283BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiKNPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiKNPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:21:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526781E3D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:21:36 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h12so13616742ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R36aKWfFSpWkQkgORW2/ax5F2qQ9Htzj5JRJWu1dxZc=;
        b=ri7N6/EgyBWRyqZLMYdL0qy+Brbuw3/uyDB0n/nFBc+iJ4R7KDl64esfOso+ABPsXH
         RWDDfi86Cl4edTgLIQed5mfwXfJy9GcqgSV0Ne2m+ZCKpWwpMNoVudDFCuhTBsTcxg5C
         ekizZCZgEtQ8tJDcuxTpgzsd8nLX05coSTHSl/25ga4bEwoKz62cjkmQOR0fPS/AYvLo
         FWlTi2wRaA3qLTdulLnSCDzSZCOSSeBR3oZquwRvkHrr+TMuF9FMOFCKxeXdTTDyM1Bp
         knRyWQJ1NP/i6zI7NT8wtsxb8+ZJoUAaDdgrUd3OePe+HnfhdznYQaPjREsZWLy8FWG1
         VVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R36aKWfFSpWkQkgORW2/ax5F2qQ9Htzj5JRJWu1dxZc=;
        b=D9ovnHfuzugs0QY6TS0SGmkkJWJIm96dgNu1saRtfaUEsXNTKTc//bqLtU8T35jIs9
         6YXI3w8AIyOpctCG+T9ZC6cSpPQ4HXHtfBxZuKccoM0T+2bpn3zW6CUvLjcPxaD5nj3j
         6XEFxNid0ke9z16Df9eXCgFC5zOLK91MNzH6ZPm+2gSdv95CiSt7aL+MdkX52CJ37lC1
         /dULbMjEpNIJdnftLNT9zjhT2ert0bZLAeiumq0zc3olACzX+D0BqlPW3eZTF4FL15E4
         vrBqhP/JAQ7zJrmMil9WfMucrealOkhrIY+kcEyqnKzYQO00+Mmhow17SKdbfuZpCcVR
         lgcQ==
X-Gm-Message-State: ANoB5pnI7lW/4ZeQK9vAVkwcuOeWDZfEt2L8J376fWtxDDegX8dEojUu
        T7fKYkTZxpbB7aBmSqhkHXHMbXWSEf4XvkPs
X-Google-Smtp-Source: AA0mqf5Pw9YuHGFmDGqzQdN1PVmLQYrrfwEoMjlNNVsG3K+0XYnr/DfEiX18EQrme313p1DUHbLvgA==
X-Received: by 2002:a2e:3606:0:b0:277:b84:81b6 with SMTP id d6-20020a2e3606000000b002770b8481b6mr4080877lja.425.1668439294598;
        Mon, 14 Nov 2022 07:21:34 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512388500b00492ea54beeasm1854268lft.306.2022.11.14.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 07:21:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sm8450-hdk: add sound support
Date:   Mon, 14 Nov 2022 16:21:27 +0100
Message-Id: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
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

Srinivas Kandagatla (3):
  arm64: dts: qcom: sm8450: add GPR node
  arm64: dts: qcom: sm8450: add Soundwire and LPASS
  arm64: dts: qcom: sm8450-hdk: add sound support

 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 161 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 335 ++++++++++++++++++++++++
 2 files changed, 496 insertions(+)

-- 
2.34.1

