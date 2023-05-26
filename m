Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC17122F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbjEZJFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbjEZJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:05:12 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006BE194;
        Fri, 26 May 2023 02:05:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9A6C680C4;
        Fri, 26 May 2023 17:05:04 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 26 May
 2023 17:05:04 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 26 May 2023 17:05:03 +0800
From:   Samin Guo <samin.guo@starfivetech.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Samin Guo" <samin.guo@starfivetech.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v3 0/2] Add motorcomm phy pad-driver-strength-cfg support
Date:   Fri, 26 May 2023 17:05:00 +0800
Message-ID: <20230526090502.29835-1-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motorcomm phy (YT8531) supports the ability to adjust the drive
strength of the rx_clk/rx_data, and the default strength may not be
suitable for all boards. So add configurable options to better match
the boards.(e.g. StarFive VisionFive 2)

The first patch adds a description of dt-bingding, and the second patch adds
YT8531's parsing and settings for pad-driver-strength-cfg.

'Magic numbers' are used because we haven't been able to get real units
from motorcomm yet, but similar usage has been found in
Documentation/devicetree/bindings/net/qca,ar803x.yaml.

  qca,clk-out-strength:
    description: Clock output driver strength.
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [0, 1, 2]


Changes since v2:
Patch 2:
- Readjusted the order of YT8531_RGMII_xxx to below YTPHY_PAD_DRIVE_STRENGTH_REG (by Frank Sae)
- Reversed Christmas tree, sort these longest first, shortest last (by Andrew Lunn)
- Rebased on tag v6.4

Changes since v1:
Patch 1:
- Renamed "rx-xxx-driver-strength" to "motorcomm,rx-xxx-driver-strength" (by Frank Sae)
Patch 2:
- Added default values for rxc/rxd driver strength (by Frank Sea/Andrew Lunn)
- Added range checking when val is in DT (by Frank Sea/Andrew Lunn)

Previous versions:
v1 - https://patchwork.kernel.org/project/netdevbpf/cover/20230426063541.15378-1-samin.guo@starfivetech.com
v2 - https://patchwork.kernel.org/project/netdevbpf/cover/20230505090558.2355-1-samin.guo@starfivetech.com

Samin Guo (2):
  dt-bindings: net: motorcomm: Add pad driver strength cfg
  net: phy: motorcomm: Add pad drive strength cfg support

 .../bindings/net/motorcomm,yt8xxx.yaml        | 12 +++++
 drivers/net/phy/motorcomm.c                   | 46 +++++++++++++++++++
 2 files changed, 58 insertions(+)


base-commit: 3201bee3a7171617da7cdbce06c428fb628c9944
--
2.17.1

