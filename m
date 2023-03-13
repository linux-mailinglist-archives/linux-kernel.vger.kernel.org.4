Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAE6B7DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCMQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCMQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:47:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A56C190
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:47:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f18so16556973lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678726069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/Xng2L0Nis9bfcRngZjnYKolZIpIcLii2KfuUAhG9w=;
        b=SBP3GdlgbK6AYF6nVDhkX7eVTZqx1J2dBpyxxNddA57rFzy4BZmTNYmtmkbnCKotzY
         sdnzZDi/CaElBYvCa84hQJSN0DFLAEI+h9uqplNBHwZy2mkNHkk/w4WYIKusdARaCLzb
         OLNvyJccRhChqef6QVKxFxpoczV0HmNlJpl1XmnRKwheIVB4DZRIfGO4up9AqfA/FLz7
         sZuJTYNeGUzg/20faZe21N5PH9sl+9Hhc9a5s510yphLcte/eJW/A/rfJvN5T2dETBdy
         wxujlUloBkFgNc1eV4esqHUPfIejznbuHmZt7hfMqzVv3cU1ryZ28MRBE/4AFGIS1XGf
         CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/Xng2L0Nis9bfcRngZjnYKolZIpIcLii2KfuUAhG9w=;
        b=DAJXNfKKt8rSjVxb3sEg1JRCLNkf7Pp18R4YOUA2JJeVIU2kTtxHjh4DpRUjmlGkCC
         UCAiH491aEJHgD0fYUvU7xqdUphnpjAom3Rkb+KBRSyWtd7CE6NUYMf7qsdrnzgaYJnW
         61JMWcBhPxvSRNfNT8xVf12cLubDVLbbSKwTtMH+TK1IqbNb2Ne1wEUSnwOiktMQugNg
         XNIwRKooqRN4upvtTV0OPJBK7UkpUxKIoo4R+r8pFlPtn/vpvvnVLQMbCPx9C8psRGKI
         IPW9tJcqm2zgtdxqO6RhAgbUAI5u6O6aYx/v651YNIvMEQb8CtOEjl+oNFcO1go2e5G3
         jO7g==
X-Gm-Message-State: AO0yUKVeqt0j3rw2ARZjle7K/qcxFPxHpK35st4qY4i7pYh2nyz5bDMv
        sWrTvCJpkvxd91RTIOZKO9B7W87+K3ZvE1rqCwA=
X-Google-Smtp-Source: AK7set9iLcaH1qw5uFITqV5UI/uvee9wg1vWLJ3XeokSHZEBSBobWGYbvYXKxKAP85hVOi4pAd6rJw==
X-Received: by 2002:ac2:54a7:0:b0:4b5:70e0:f2e6 with SMTP id w7-20020ac254a7000000b004b570e0f2e6mr3246542lfk.24.1678726069196;
        Mon, 13 Mar 2023 09:47:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004db48ae69cbsm18134lft.206.2023.03.13.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:47:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/6] Clean up Adreno SMMU bindings
Date:   Mon, 13 Mar 2023 17:44:15 +0100
Message-Id: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9SD2QC/x2N0QrDIAwAf6XkeYJTkLJfGaNEm9pAm4qZY1D67
 5M93sFxJyhVJoXHcEKlDysf0sHfBkgrSibDc2dw1nnr7968j8LJ5NIm3fc2RZaZJasJFpdxxBB
 cQuh1RCUTK0paey9t27oslRb+/nfP13X9AHNYa+d+AAAA
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678726067; l=1268;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=f4B1yJzVBbsZqehz8JLbHpySiLGAvrTlDRteS3PGcW0=;
 b=0ksZnyi/nnvCpvu93COpZxIxLAkofAIO0o8CMs9a6YKsMYcpaqt99maJN0Bj97+fqQDOYqcQtkJ6
 HsLVAj2ED/WYQcvwwtZkIiRID9VdiI2IypPjtTHnfkJR+PzOZ6Fn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Pick up acks
- Fix the "arm,smmu-500" typo in bindings (Rob)
- use b4

v2: https://lore.kernel.org/lkml/3aa78b15-8e6c-9657-0d08-0d0452d51fbe@linaro.org/T/#md7074966fdcbbd884baf62153f726bec54b2e819

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: arm-smmu: Use qcom,smmu compatible for MMU500 adreno SMMUs
      dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
      arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8150: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8350: Add qcom,smmu-500 to Adreno SMMU

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 15 +++++++++++++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi                  |  3 ++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                  |  3 ++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi                  |  3 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                  |  3 ++-
 5 files changed, 21 insertions(+), 6 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230313-topic-gpu_smmu_bindings-60af88a662ca

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

