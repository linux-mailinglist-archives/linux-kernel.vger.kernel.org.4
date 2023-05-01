Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3156F2F53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjEAIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDB5E76;
        Mon,  1 May 2023 01:44:05 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34CD16602F6A;
        Mon,  1 May 2023 09:44:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930644;
        bh=WmZbj+7p52spdKhp6FKYvpWDarz0ByKdPc4ZP68owZw=;
        h=From:To:Cc:Subject:Date:From;
        b=DYaGZRtUwGtlnTjQ30D05KiBQXkYdm5wWE14E1kMe3NagxEikuNBVgE5MCK5z+sLx
         hX3sXlrY+H1Xh5JHKYQVmjOAaparQ5GWVFVOCh+vQSNqyuczP5EOqF5DCSBQPY3vx8
         Pd0wKZSppy6OiWbjbJhnhqmpvzGfa/BdUgXexDC+EELUSOUjBVw5R/McXGC1QG2I7t
         n0auLBIUZWAXIUyQfkhDGzL+oopVFH2A0YEMPQiA+qKhjwqs/tUZxOG/XkBJ/njkCn
         F7DsbLcpgKa+xIzXN1ztxOE2yILLRC+udrbBx+1d+b1oElLzz5dYticlYPNKBFr9d9
         Pf0KBChzzvokA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 0/8] Add RK3588 OTP memory support
Date:   Mon,  1 May 2023 11:43:52 +0300
Message-Id: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds OTP memory support for Rockchip RK3588 SoC, 
while also providing a few improvements to the existing rockchip-otp 
driver, in addition to converting the bindings to dt-schema.

Cristian Ciocaltea (8):
  dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
  dt-bindings: nvmem: rockchip-otp: Add compatible for RK3588
  nvmem: rockchip-otp: Add clocks and reg_read to rockchip_data
  nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
  nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
  nvmem: rockchip-otp: Improve probe error handling
  nvmem: rockchip-otp: Add support for RK3588
  arm64: dts: rockchip: Add rk3588 OTP node

 .../bindings/nvmem/rockchip-otp.txt           |  25 ---
 .../bindings/nvmem/rockchip-otp.yaml          | 132 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  54 +++++
 drivers/nvmem/rockchip-otp.c                  | 191 +++++++++++++-----
 4 files changed, 330 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml

-- 
2.40.0

