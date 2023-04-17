Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E94E6E5403
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDQVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDQVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:40:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2F2D60;
        Mon, 17 Apr 2023 14:40:40 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-155.ewe-ip-backbone.de [91.248.191.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E188F6603237;
        Mon, 17 Apr 2023 22:40:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681767639;
        bh=Zy3MICZq0edItGGvNVv7JbY0H31jFDBsewz9BSHcSVU=;
        h=From:To:Cc:Subject:Date:From;
        b=NB2JB7f9EoGT0vbjzPHkeKdLRfrLKL+xjH6lxqHx0XLsCVAWuzoWHDI/V1GLq2dxl
         UkHtfCrhoaPDukP54l3XfTH9uNwk4XZCXceN0ALejXwTLqjzuFQHknaXbbzlQAWQqc
         a60pmg0Fd9/NrTJsPsd4e1cZpAEQKEUgNHLSKJdf37PDEv0yQmJvv6Ie7zUuRQixPG
         2MBLyaFdNSfEjXugs3i0FY4b6Q/WduTJdAbxUgBd7S47i0VkSi07J+CQS6+gwss7ef
         c05DysDbCSnBNT+sy6QS5nt+lnGVgtS/Au5/+s/Jtn4sGiuNjkxbkufci7znyhNgPK
         Fk8cJvcWJwAKg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id F3C634807E2; Mon, 17 Apr 2023 23:40:35 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 0/2] Add Rockchip RK3588 GIC ITS support
Date:   Mon, 17 Apr 2023 23:40:33 +0200
Message-Id: <20230417214035.101190-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
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

Hi,

This adds GIC ITS support to Rockchip RK3588, which is affected
by an integration issue effectively breaking shareability support.
PCIe2 support will follow in its own series.

Changelog:
 * Changes since PATCHv2
  - https://lore.kernel.org/lkml/20230417150038.51698-1-sebastian.reichel@collabora.com/
  - apply changes requested by Marc Zyngier
 * PATCHv1
  - https://lore.kernel.org/lkml/20230227151847.207922-1-lucas.tanure@collabora.com/
  - uses of_dma_is_coherent() instead of providing errata info from kernel
 * RFCv1
  - https://lore.kernel.org/lkml/20230310080518.78054-1-lucas.tanure@collabora.com/
  - uses 0x0201743b IIDR for quirk detection and misses errata #

Greetings,

-- Sebastian

Sebastian Reichel (2):
  irqchip/gic-v3: Add Rockchip 3588001 errata workaround
  arm64: dts: rockchip: rk3588: add GIC ITS support

 Documentation/arm64/silicon-errata.rst    |  3 ++
 arch/arm64/Kconfig                        | 10 +++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 17 +++++++++++
 drivers/irqchip/irq-gic-v3-its.c          | 35 +++++++++++++++++++++++
 4 files changed, 65 insertions(+)

-- 
2.39.2

