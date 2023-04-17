Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E046E4C43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDQPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjDQPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:00:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5FE10E;
        Mon, 17 Apr 2023 08:00:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-155.ewe-ip-backbone.de [91.248.191.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97CE566031F9;
        Mon, 17 Apr 2023 16:00:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681743641;
        bh=LnwQ/90N7oiIQMOpIlGj+WTHvxq19y4J7oSF8At74eY=;
        h=From:To:Cc:Subject:Date:From;
        b=fZXRMKTW1byrUO3FKVHAiPUFO6ZaTTJN1Qsjoz+zKYXm6LfSfvADoM+z+pYNmcjL4
         QC+hwjCMod7vhdr8g+akj8X/Fp2fw0+yPsdP8QegsdiCTbXiysyiyy+giiSwxrdgKb
         YhJvqBs4l3c2YqsX/vIBnmcAwnwNS++KULhLtqG3l7fH3nxrkDuo13/FMjM3a5nayj
         +5ecCtEQTzDZZS2x37nD9SyVrDa62J3RWUKDoaJDhgpGQZPcjSIWH0oMZKXpWtzOJK
         l3kcWLjmUGl+uiztmG4o4TI5tFNKVEJEYt0UFaZ2UxH9Rd9kC01LiRBEAWCQ4+kJQb
         vn5JjI52RzHtg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D7BB04807E2; Mon, 17 Apr 2023 17:00:38 +0200 (CEST)
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
Subject: [PATCH v2 0/2] Add Rockchip RK3588 GIC ITS support
Date:   Mon, 17 Apr 2023 17:00:36 +0200
Message-Id: <20230417150038.51698-1-sebastian.reichel@collabora.com>
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

We got an Errata # from Rockchip for the GIC600 integration issue in
RK3588, so here is another try adding upstream ITS support for that
platform. I noticed
https://lore.kernel.org/lkml/DU0PR04MB9417388F9BDD73080294FA8E88889@DU0PR04MB9417.eurprd04.prod.outlook.com/
so I kept the flag name itself generic.

P.S.: I'm taking over from Lucas Tanure, who no longer works for
Collabora.

List of previous attempts / changelog:
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
  arm64: dts: rockchip: rk3588: add MSI support

 Documentation/arm64/silicon-errata.rst    |  3 +++
 arch/arm64/Kconfig                        | 10 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 17 +++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c          | 25 +++++++++++++++++++++++
 4 files changed, 55 insertions(+)

-- 
2.39.2

