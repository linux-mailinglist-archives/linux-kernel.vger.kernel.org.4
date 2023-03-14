Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED62C6B8D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCNIhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCNIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:37:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480CA6C896
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:36:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p20so15750944plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678783009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep4FbqH2ivKVLrPSEdoGqO90JFBOp5Qq0eV9bigyzfQ=;
        b=gpiRvT9ut1uJuy+xY2utEz+E6QTxxgLvyQh/KiodtNZgfIBCPC1R9FKFISqD3YLA3O
         A9nM+vWyzCTGzwJBVddW8t/PsVmcj0mm6ewyYY4z6BWFv8AzijVMyqyOvmH5gosqTWlD
         sSCZxjQx+9M6OcYRiZeE6y8iIvax93P5lc8Nb8iLvkEE8qwknsKjhWEJ2L6caJa+dpkH
         NHAiHzvngCdZWRaJmkIPui4ZhM2+5SdTRwEuxJvN/rA5ZmbKvOAEBB6ofYffNcyraVpH
         rgzulq61ulb++IG/6vl7U4YG4XOrWFVOtkxEqsC1jMVnsw+gxlsgddOsgf35YDK+Krg7
         6+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678783009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ep4FbqH2ivKVLrPSEdoGqO90JFBOp5Qq0eV9bigyzfQ=;
        b=mY6XZq4/suGpUdxtsP4skSSRpRa0iWqEnvIDHit/qnMsVQxhxv2UVX5nw6SN9OUaPJ
         timM+FLEEm1Lldsy6LkG6gyFXR0ZIB5PI4ogCzQEZ2qxvbm8YV3uQZid31R/kvqBdRG3
         Iwz+2k7jwGn+1IRl0+A059Ce8d7wbDtSIhCzNaRMnNOsF8o7p+FTRDXGQloglBYJDRUr
         2vFBWU+7esbvtLdD8rNKgaaZNVfjKWAKmBA+CD1wfn40QLcMdIRl/DOOFzC47breRLt7
         njR81BTmy/dueD8Iu3+oI9rNyQsszxJQsItSf7lvZ/8xAQ2tGc2Vblj5gtzR1qfvX2Pu
         s4rg==
X-Gm-Message-State: AO0yUKWe5Wy6q8Aj0020oBMMt0fossEiNFHHtU+6E+SgGVK1U02L5pok
        3aEr+jYUmFIritY8QG8jhqn5qg==
X-Google-Smtp-Source: AK7set9RhE0UvOCriYS53PUEwOykVkUBNcW5NhAdkJmcMTYWbPTbsd6rc3W9A5cVrgQ3lhYURp9NQQ==
X-Received: by 2002:a05:6a20:1e62:b0:cc:4db0:f2b5 with SMTP id cy34-20020a056a201e6200b000cc4db0f2b5mr32516543pzb.48.1678783008610;
        Tue, 14 Mar 2023 01:36:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id g3-20020a631103000000b00502ecb91940sm1020980pgl.55.2023.03.14.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:36:48 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 0/2] arm64: dts: sm6115: Perform USB node related cleanups
Date:   Tue, 14 Mar 2023 14:06:31 +0530
Message-Id: <20230314083633.1882214-1-bhupesh.sharma@linaro.org>
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

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
- Split the series into two - this patchset proposes only 'fixes'.
  The USB SS qmp phy change will be sent out separately now that we need
  a driver change as well.
- Also fix the recently added sm6115p lenovo dts.

Changes since v2:
-----------------
- v2 can be seen here: https://lore.kernel.org/linux-arm-msm/20221214203124.564537-1-bhupesh.sharma@linaro.org/
- Fixed a blank line issue in [PATCH 3/3]

Changes since v1:
-----------------
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20221213123823.455731-1-bhupesh.sharma@linaro.org/
- Addressed the review comments from Konrad and Krzysztof regarding the
  USB HS and SS Phy usage in sm4250 oneplus board dts ([PATCH 3/3]).
- Collected R-B received from Konrad on v1 patches [1/3] and [2/3].

This series performs some USB related cleanups in sm6115 dtsi.

Note that this series is rebased on linux-next/master.

Bhupesh Sharma (2):
  arm64: dts: qcom: sm6115: Cleanup USB node's label
  arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and
    'dr_mode' properties to dts

 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts |  9 +++++++--
 arch/arm64/boot/dts/qcom/sm6115.dtsi                | 10 ++++------
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts   |  9 +++++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.38.1

