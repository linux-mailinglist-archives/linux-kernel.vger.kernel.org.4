Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E116653D74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiLVJZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiLVJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:25:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A8B4AA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:25:00 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so1858521lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C4HQky+MAbwpq3mNzHe85KHH16J0vVck7zjgsPmSNJY=;
        b=gQtoaMNYDZ2OAEkxmlNrUa+WiaeJAjymOWgCx3+atx8BL0gbVNMA8luq/2joCuOr/y
         f6DSNda1a6O+YzexC05hU/2G+2FZuLvWLNt8VYH0OyeLw616Fyf++77/ZN/XUOTrXbMS
         W8JpKNMoKIpQbjq2jrzqjQ/BzaHvXrd95qZQFxw2YoKeOZhUUaPKixugfVcfXLOgC0Yq
         W6E6xSvnqgbg9SFa7ijcgrA+/z8btPNYeH4U/7kQYiLzBuwuyK4mmo99o7G5tSVC1QS9
         Tew84CxAgidfTr99+T9NdzSnJm9eiqYHJPsVmtbo5XFVEqoDcQU8995PHi+Gz6v0LaUY
         5b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4HQky+MAbwpq3mNzHe85KHH16J0vVck7zjgsPmSNJY=;
        b=eml5aXzbejDVAi/TWWYA8or61lFw8q6Ppy97MScEp62o2gllWhvLWRinBZN5MmV92Q
         Fx+0zs1eQSG5U1Zash+gD6Q4CzQklrcd3LQpLI/f3ItQs+MhKR1xOVofUZfjKVAPWqE8
         /oRMjr6k1COt8TO4UwpsOyoY6Qh9ju/8L84EqmYT/HrlYtEi3BDo1Dceq58b15fZY/va
         LBxvMbfgkWHAURrQQ38H527qyrzj2DD+hvrrrxQlnJRYjhEEKCKnooXC/3O0U6ZnLQcG
         rgq19KKeup/1JLcuOZ94cj1oHuuQZ18BAqrCeipo3l4yN23UOBFG+8XtJ/KOf67Z6ON0
         U8lA==
X-Gm-Message-State: AFqh2kryLOnG0Mov172XXIcGUhFK9Eeq2wHgN0nD5VHxdyqllFZiUYWZ
        wD7Jj4Ur+SG0r5iYAuASNDW9SQ==
X-Google-Smtp-Source: AMrXdXsEpwXGr9P3cYxseRomjye5e49Oft1TvrRX95TMiBQxBbaPf6EqBJp58t8P8dtfMrRczRnHdw==
X-Received: by 2002:a05:6512:2589:b0:4b5:6569:ab0 with SMTP id bf9-20020a056512258900b004b565690ab0mr1799772lfb.62.1671701098452;
        Thu, 22 Dec 2022 01:24:58 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c18-20020a056512239200b004971a83f839sm10905lfv.39.2022.12.22.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 01:24:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: broadcom: align SMMU node names with DT schema
Date:   Thu, 22 Dec 2022 10:24:56 +0100
Message-Id: <20221222092456.79203-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects certain pattern for IOMMU/SMMU nodes:

  northstar2/ns2-svk.dtb: mmu@64000000: $nodename:0: 'mmu@64000000' does not match '^iommu@[0-9a-f]*'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 2 +-
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 18cdbc20f03f..e1b80e569cdf 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -294,7 +294,7 @@ dma0: dma-controller@61360000 {
 			clock-names = "apb_pclk";
 		};
 
-		smmu: mmu@64000000 {
+		smmu: iommu@64000000 {
 			compatible = "arm,mmu-500";
 			reg = <0x64000000 0x40000>;
 			#global-interrupts = <2>;
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e05901abe957..b8b8c0e78cc6 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -186,7 +186,7 @@ gic_its: gic-its@63c20000 {
 			};
 		};
 
-		smmu: mmu@3000000 {
+		smmu: iommu@3000000 {
 			compatible = "arm,mmu-500";
 			reg = <0x03000000 0x80000>;
 			#global-interrupts = <1>;
-- 
2.34.1

