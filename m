Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C959D6D1984
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCaIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCaIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:12:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469E211D;
        Fri, 31 Mar 2023 01:12:32 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 728D66603130;
        Fri, 31 Mar 2023 09:12:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680250351;
        bh=cxm+qr2mYnHLE7Z3z7StpylRHZPB7Js49GZnkR3q4CU=;
        h=From:To:Cc:Subject:Date:From;
        b=THomfaYyiZ0IY81u5EgpAo692E3PgYJ0pweR5hLxSoNFZDX9bFQfRasDDxa4wxXMA
         Z7hDKBJjKvg2KVWJRRoryL6zYEP1KjL8pk9LUpDh0tYaco1OGjuL65NKgNC9V3xNWN
         Nfia0pKiECbyTevnWprO+1TokHCytrgkWC4NyIZsByqzu+HQ7nrOCBZtE3o0pYoCxE
         Jtcr8IzGyDLjT4s2wcAwagpHPgT34QjBKvDO55htbfi79k1IwLP++eZk8B741bPlgu
         tHwhG83lkWtH1QvTyEkUzGkJSsK1XZV+4pXIXAmeU0lZ3mqFUZ1N3LX9oC1ZiHguUF
         Xa2T7p4K/D54Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 0/4] Enable I2S support for RK3588/RK3588S SoCs
Date:   Fri, 31 Mar 2023 11:12:22 +0300
Message-Id: <20230331081226.245881-1-cristian.ciocaltea@collabora.com>
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

Changes in v3:
 - Rebased onto next-20230331 and dropped patches v2 01-06/10 already applied by Rob
 - Ensured DT nodes are in alphabetical order in patch v3 4/4
 - v2: https://lore.kernel.org/lkml/20230321215624.78383-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Rebased onto next-20230321 and drop patches 03-08/11 already applied by Mark
 - Replaced patch 01/11 with v2 07/10
 - Reworked patch 02/11 to v2 01-06/10
 - v1: https://lore.kernel.org/lkml/20230315114806.3819515-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (4):
  arm64: dts: rockchip: rk3588s: Move
    assigned-clocks/assigned-clock-rates out of scmi
  arm64: dts: rockchip: rk3588s: Add I2S nodes
  arm64: dts: rockchip: rk3588: Add I2S nodes
  arm64: dts: rockchip: rk3588-rock-5b: Add analog audio

 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  62 +++++++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  68 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 156 +++++++++++++++++-
 3 files changed, 282 insertions(+), 4 deletions(-)

-- 
2.40.0

