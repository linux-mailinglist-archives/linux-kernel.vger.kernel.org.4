Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8D6D36AF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDBJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDBJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:51:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994D59E8;
        Sun,  2 Apr 2023 02:51:02 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1845E660312B;
        Sun,  2 Apr 2023 10:51:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680429060;
        bh=4iustubS8pupGkjSDCTNaKqKkGplmRTO6ySM0U90GhM=;
        h=From:To:Cc:Subject:Date:From;
        b=IDHWm3lsgbJ0ot9q+IypCQKgXstZqCrWRINs/FrLROd2BGWosnpx5pz2i2SKCFUCV
         a3kEhVjvAe+yVgB5VcWo6comQHUTMSxgeJfzAkT97bbJafLtyIHed42eilHqIDlL2a
         OZDlswYSAhNM2Dw/qvo5UojRgZpLGDOG3jdhda5dTBDETKkiYudrvHrH00+vh7eIB/
         OXxz6bXZQzN7/4iKuQOhCnJ88yeuYeTtN20n2m0fBRLF2/TDJdvjmjIp3FpuG7rQBH
         /aTo8JMsW6q+zQ/n/IO3woqahBR/Dwr4EXX0TupQghppoyXDKaKSN5EVCzXQOa7KTX
         +KL1rA2xXFizQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v4 0/5] Enable I2S support for RK3588/RK3588S SoCs
Date:   Sun,  2 Apr 2023 12:50:49 +0300
Message-Id: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five I2S/PCM/TDM controllers and two I2S/PCM controllers embedded in
the RK3588 and RK3588S SoCs. Furthermore, RK3588 provides four additional
I2S/PCM/TDM controllers.

This patch series adds the required device tree nodes to support all the above.

Additionally, it enables analog audio support for the Rock 5B SBC, which has
been used to test both audio playback and recording.

Also note the first two patches are not particularly related to I2S, they handle
a few clock issues identified while attempting to fix a DT binding warning.

Changes in v4:
 - Updated patch v3 1/4 adding a missing clock assignment and adjusting the SCMI
   assigned clock rates
 - Added patch v4 2/5 to address an issue reported by Sebastian

Changes in v3:
 - Rebased onto next-20230331 and dropped patches v2 01-06/10 already applied by Rob
 - Ensured DT nodes are in alphabetical order in patch v3 4/4
 - v2: https://lore.kernel.org/lkml/20230321215624.78383-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Rebased onto next-20230321 and drop patches 03-08/11 already applied by Mark
 - Replaced patch 01/11 with v2 07/10
 - Reworked patch 02/11 to v2 01-06/10
 - v1: https://lore.kernel.org/lkml/20230315114806.3819515-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (5):
  arm64: dts: rockchip: rk3588s: Fix SCMI assigned clocks
  arm64: dts: rockchip: rk3588s: Assign PLL_PPLL clock rate to 1.1 GHz
  arm64: dts: rockchip: rk3588s: Add I2S nodes
  arm64: dts: rockchip: rk3588: Add I2S nodes
  arm64: dts: rockchip: rk3588-rock-5b: Add analog audio

 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  62 +++++++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  68 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 160 +++++++++++++++++-
 3 files changed, 285 insertions(+), 5 deletions(-)

-- 
2.40.0

