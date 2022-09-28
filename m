Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D25ED88F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiI1JNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiI1JM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:12:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B699AF8F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:12:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i6so7809911pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qM+lTkdECo0J0ZhhLpB7ro4uoQDn3iCVEdOBITAk3Q0=;
        b=PbwktMuA9cnH6kD/2b60Shhox4vCiksy2RgnXF4n0N++WVeqtQP3uKJjbZXmPcWycd
         /oOrdyUzEyfsEbeQXWxqe+8Qcei09CtiKMCcP9eXPz7kIwtNzzyJ92XwOdNA8e7RO/IU
         nO31V7N4yRxU4RDblc7g7j2Vckq6+seN1l8M+CWIveGbZ551OBWVznR6gG8/wKGL4fm6
         Adt2bo9/E+AXUlKIvvKIjquDcHVZVFrq9v4gRU9XY7psNT0JW79uq5LZ308VWMBXdnxY
         GTNP+EgRsUCr1u64Z7YiPD8Rt5VQvg/UrJgLs1Kq6moVWKC8PukCWjHuy0S4bbZoEGJy
         uJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qM+lTkdECo0J0ZhhLpB7ro4uoQDn3iCVEdOBITAk3Q0=;
        b=yWVGvumJLpcc0jCa0P4tg0jn4VQxoztJe7KFb69LID5caUjAnBno+zsRs/UR2ffL2T
         5BQhZrj/P4uFFfytmH3xYj78mL64/aaD/cLqXFpaB4y8cbtxmRrSR9POsb1X8u4r6RJ4
         dZvVWi7ObSlQgqK7HccfknNQ4TQCTkn9BzVRBmJ3QLB0Ymxi5S1XyyeBCxtKNDYpZwmy
         JK96OTLJDNZQfCvAdeogBlLDbPv7qp9AHT4F/fdquNslta07qray+sNBnPQY0EKI0AIL
         xlRW0wVjy8GPcSKANEZcuQ2IfXPIUc5gkgjyC6j3QBNhEqvuWyZBr9XO3V5Dn38avXv5
         /D+Q==
X-Gm-Message-State: ACrzQf0h9JCVYGTR2WqfkY+L70XgVDoS4X1XJ2sl1aDzBOTM9yO/Rgnm
        e5vU87ZUf/DxFWAiU+zNRo2OsQ==
X-Google-Smtp-Source: AMsMyM4PI1Uli3TKdfuQ/NqySpdQGk1FyZCpOIAFT1qcz3BBww3dRiGNvNHyp7fzs2YP9h4+dR8/zA==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr33609781pfi.84.1664356320877;
        Wed, 28 Sep 2022 02:12:00 -0700 (PDT)
Received: from jensen.next ([113.109.77.159])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b00176b84eb29asm3112069pln.301.2022.09.28.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:12:00 -0700 (PDT)
From:   Jensen Huang <jensenhuang@friendlyarm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Vinod Koul <vkoul@kernel.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jensen Huang <jensenhuang@friendlyarm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on nanopi4
Date:   Wed, 28 Sep 2022 17:11:29 +0800
Message-Id: <20220928091129.20597-1-jensenhuang@friendlyarm.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was disabled
by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.

Tested on NanoPC-T4.

Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in dts")
Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 278123b4f911..b6e082f1f6d9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -167,6 +167,7 @@ &cpu_l3 {
 };
 
 &emmc_phy {
+	rockchip,enable-strobe-pulldown;
 	status = "okay";
 };
 
-- 
2.37.0

