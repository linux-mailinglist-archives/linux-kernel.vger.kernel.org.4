Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A46E492E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjDQND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjDQNDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:03:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02210265
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:59:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id gw13so13731828wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681736328; x=1684328328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+MVzf8r/4s+B98TOSVIFBCcQmTeOnxbCDg8qGd1O2g=;
        b=Qw3+fO+DNms8K56wL8s70n889hD+X3HzOhfr2FkVez8KSDwMuAvbZJ6/az6knoCYRO
         WC5/jl0Xicoz9hT7MfXD8h1NXyK2JBbH1gLx6iV0deFFfX0Q2VIvb0mXk2TNHm9Ju3QI
         HsEXwJAtir4qM7DcSsj7iT8Qjyl6VEh35HzCFVrFVOliKWLo2J5aC/FbNG4zhSXFJvVo
         ghWHmHUd1yAbxuYE175hZWDu90XL2C0F/pqXB4Z7Iyo1Xs9FBoqpXt3S1Bun677QLY4h
         RvL6o3kArQ9La2z5BDnKffqx6A6u3gxQXnPqavA34WnVlWAQWTseLP7iuJv6S7yjM1iG
         ixvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736328; x=1684328328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+MVzf8r/4s+B98TOSVIFBCcQmTeOnxbCDg8qGd1O2g=;
        b=LPe4eH+kg2lbu80JKzhaa1CeiVKw+QN+XAkIiu4IerH09ViFaKh5MMNwnE3t3ask45
         z6i3/stRNfi4tW/NdDWjslB8PcKEmtHq3kx0hRKm5P71RZQbErmzeRVk2snba0GAtdDV
         E/aIBa0w7BcomTcOGDuhHWRe0x7a7kTobeaus8WzoiTPB34k/4p3J8xGOTKdMQCtoUr9
         zLbxHpfxTwSzpsJxTSvoPwr9XKUNWybYft/El9q5uZEI1vbg1RL1h/8iINaubrTSVVyt
         heyj7OszErhUrDsun/Fcq3bZq2jd9x5SkBijIEttLLSLUW73b16H7MOs/qCpYUGJf9bt
         B6sA==
X-Gm-Message-State: AAQBX9dX4F2EArcCV9EpJBwhYoPAvsY4B2+plkc9shRdebhDg1FYTwPE
        /uTLKy1XwLpFzphjVIsRkVgokA==
X-Google-Smtp-Source: AKy350Z2eV6AqL+dVKQQg8ekRMO3sImYABpWFD57wB0IsJLBBkAMxrq4zgrfOPdZN4P4MyAL/pMLaw==
X-Received: by 2002:a1c:7304:0:b0:3f1:6f4a:a3ad with SMTP id d4-20020a1c7304000000b003f16f4aa3admr4528202wmb.2.1681736328321;
        Mon, 17 Apr 2023 05:58:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm15557546wmo.10.2023.04.17.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:58:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 0/5] arm64: dts: qcom: sa8775p: add more IOMMUs
Date:   Mon, 17 Apr 2023 14:58:39 +0200
Message-Id: <20230417125844.400782-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
GPU clock controller driver.

NOTE: I didn't pick up Krzysztof's tag for patch 4/5 as the patch changed
significantly.

v3 -> v4:
- fix the adreno smmu compatibles
- drop patches that are already in next

v2 -> v3:
- select QCOM_GDSC in Kconfig for the GPUCC module
- the GPU SMMU is actually an adreno SMMU so describe it as such and
  fix the DT
- fix the mapped memory size for the PCIe SMMU

v1 -> v2:
- remove unused include in the GPUCC driver
- remove unused clock from the GPUCC driver and make it compatible
  with the generic QCom GPUCC bindings
- put the new defconfig option in the right place (as per savedefconfig)
  and make the GPUCC driver a module rather than built-in
- describe the smmu clocks for sa8775p in dt-bindings

Bartosz Golaszewski (5):
  arm64: defconfig: enable the SA8775P GPUCC driver
  arm64: dts: qcom: sa8775p: add the pcie smmu node
  arm64: dts: qcom: sa8775p: add the GPU clock controller node
  dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU
  arm64: dts: qcom: sa8775p: add the GPU IOMMU node

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   6 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 125 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 3 files changed, 130 insertions(+), 2 deletions(-)

-- 
2.37.2

