Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6904F73A092
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFVMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjFVMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:11:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8D171C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:11:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa71db41b6so6368065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687435905; x=1690027905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmbZFMqdkq5fSWnk6fbsr4ZEbC9QPpgyd+WNLIjim98=;
        b=wbi4FRvmlL/7KWLcPqaQ9xZEmLqVkz06JT1JrVwxmpEpQ8xekR7UXPfSrWCUXhZxY9
         OBsMHKR9mlM1N2sgtK1WLVSGWfpGrPZGfEivcS9GzWA4gkz40A70RuBm9sJNFRw7riV6
         Z/DdkVlZFtSZ40fCdQ3S30efodqJzxAZuisBfi5BwrbHxhje7rePXwOKnmFVYaqQ7sJA
         Jw65tswWUhE8LmsShizSRIYGOYf2sghnxNJeqsVPo8sMdCqkltlwELRA1zk2xRKvT37K
         59grYKlPy3Jik2ehMITQ3yfxKyUyXuR2WeF/y/7CKZJ/4sGvrSaXQpEwq3t8h2aHOOUy
         40fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435905; x=1690027905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmbZFMqdkq5fSWnk6fbsr4ZEbC9QPpgyd+WNLIjim98=;
        b=Xi7wm1a1vlNG18P2DbTUSbkBiLxb56Yong4GEN58cGHdqw1OWxDs69o9E247Vrw0QG
         0Kc9XkLgvBX8lRxN8HU6S9rBonkCjBeFhVc2sJZ8cqP/WfR0An0h9fw4PI8FseNjKaEG
         0Iay0z9nMDVA4CgGlPEMt361pvx07lK873E2ahjqXjYy+QvxgXAmYbRSLj00Bws9B2cX
         lw3wuxF5TdIOFKsB7zs/YI5liOFfzETwpu44CaVWLLWNZtMhfUlI71lwnRwg1c0636WX
         0e9rzupAtqEN2vkVT8Z73UbyTLmRokX8kqHtGDT2//IA+9WhocgewUqwNQERnGe2Jphs
         H8Aw==
X-Gm-Message-State: AC+VfDwnbORVb9UDWFQMIwMkCFCHPYCIbMEYEAH+QhCMmrtlR8bcOooJ
        O35IolJSkof82/yEHGaJ+06nOQnApO5bz36RJfM=
X-Google-Smtp-Source: ACHHUZ50XLlMZWO5p3fpPZRRv4eoV4eHGhI6Rv+9vD7Dk61OlM0kMJ4EPFKX2AuJZXhDDuexPx/NRQ==
X-Received: by 2002:a1c:7c11:0:b0:3f9:70f:8b99 with SMTP id x17-20020a1c7c11000000b003f9070f8b99mr10565005wmc.7.1687435904905;
        Thu, 22 Jun 2023 05:11:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d785:af3e:3bf5:7f36])
        by smtp.gmail.com with ESMTPSA id k17-20020a7bc311000000b003f8e4b22bc2sm7542799wmj.44.2023.06.22.05.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:11:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2] arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC
Date:   Thu, 22 Jun 2023 14:11:41 +0200
Message-Id: <20230622121141.218623-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the SGMII/SerDes PHY driver. This module is required to enable
ethernet on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Resending separately as driver updates have now been picked up into the
maintainer tree.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0777bcae9104..63f54d02c994 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1380,6 +1380,7 @@ CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m
 CONFIG_PHY_QCOM_USB_SS=m
+CONFIG_PHY_QCOM_SGMII_ETH=m
 CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.39.2

