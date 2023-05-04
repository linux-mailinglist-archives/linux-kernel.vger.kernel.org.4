Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7406F7745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjEDUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjEDUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA61317DEA;
        Thu,  4 May 2023 13:34:48 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 499596601F54;
        Thu,  4 May 2023 21:06:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230816;
        bh=5R1AIP1C8/sZhgM+e+W1QCHOVzm+rALCBEYDFotBSzc=;
        h=From:To:Cc:Subject:Date:From;
        b=NubI2CAhpfrk5Vkj5jePnt0O0S0mN8VxWn6NBr0xioj1eMAMVzcuVCH1keYw9Kdit
         DgfX6jyv2OWVTu0Q9HzOJRKklRpFdm4zbsHYccq6npbU3OHYkmzF56SN6fU1DJNO8r
         r1Og3N7ssWzlAQ/4eADOt1sqq9a0dHr42no338IFzux7XTClvaJYlp7LBS2vIl+Jx9
         6rJxnCZzkPN7LjyiwKO+h2HULhbCo28N+S1nUCuD6hbYNyQp2rffM8Fp2lMzhHbpb9
         qP/umiugDzshJsAKzCn9HvMi7UjIBJQuB8/rLsG63HNtcRY7/9WI0cwrkXSMUzBO4X
         m9rfP48C2iSjA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 0/8] Add RK3588 OTP memory support
Date:   Thu,  4 May 2023 23:06:40 +0300
Message-Id: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds OTP memory support for Rockchip RK3588 SoC, 
while also providing a few improvements to the existing rockchip-otp 
driver, in addition to converting the bindings to dt-schema.

Changes in v2:
 - Renamed rockchip-otp.yaml to rockchip,otp.yaml and removed clock's minItems 
   in PATCH 1/8, according to the review from Krzysztof
 - Updated commit message in PATCH 2/8, per Heiko's suggestion
 - Renamed rockchip_data's clocks to clks in PATCH 3/8, per Heiko's review
 - Preserved clocks order/names from older SoC variants in PATCH 2/8, according
   to Krzysztof's review; updated accordingly patches 7/8 and 8/8
 - Added Tested-by tags from Vincent
 - Added Reviewed-by tags from Heiko
 - v1: https://lore.kernel.org/lkml/20230501084401.765169-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (8):
  dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
  dt-bindings: nvmem: rockchip,otp: Add compatible for RK3588
  nvmem: rockchip-otp: Add clks and reg_read to rockchip_data
  nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
  nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
  nvmem: rockchip-otp: Improve probe error handling
  nvmem: rockchip-otp: Add support for RK3588
  arm64: dts: rockchip: Add rk3588 OTP node

 .../bindings/nvmem/rockchip,otp.yaml          | 122 +++++++++++
 .../bindings/nvmem/rockchip-otp.txt           |  25 ---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  54 +++++
 drivers/nvmem/rockchip-otp.c                  | 191 +++++++++++++-----
 4 files changed, 320 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt

-- 
2.40.0

