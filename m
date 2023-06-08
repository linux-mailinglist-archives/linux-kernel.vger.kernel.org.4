Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96B728438
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjFHPwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjFHPwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:52:03 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A52D7B;
        Thu,  8 Jun 2023 08:51:40 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686239498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KipQ904kAoqGtS96BrNjtOhgVzKh/rdRo+o3pLuVLgA=;
        b=maFxXu50qWEyI66ivk9kQ1/bxq+RSHUWsYwUSJ8Sv9P/A1Al6Wetw8FWqdcQMlVo8WJcB9
        IJWGdcDgIv/Upj9cFAIOGWF0N2fENd+b3GJ/q6V42LJ22WNHwVkiAD3PJCyTjqUOiK50Dc
        vDDpUj9ZTtmOoISX2GfdDBQANOo3d+Cm9upLkC4QG0kVYcENsjjzfRlGkC5O4PeLmoXeGe
        jvarR/acOQJoMEdO00ynKx0kw/Kkw/LTpN1rUZ/fhmMSHCdlscUCc9gBivWar3W6Se9jf7
        becxnjJ+FA1HTJvNXrw1d2b6ECpuI2H3uOTLXvudXHF4IOciFB0YMZwasJ53IA==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F4206000D;
        Thu,  8 Jun 2023 15:51:36 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Horatiu.Vultur@microchip.com,
        Allan.Nielsen@microchip.com, UNGLinuxDriver@microchip.com,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net 0/2] fixes for Q-USGMII speeds and autoneg 
Date:   Thu,  8 Jun 2023 18:34:12 +0200
Message-Id: <20230608163415.511762-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported here [1], there are some inconsistencies for the Q-USGMII
mode speeds and configuration. The first patch in this fixup series
makes so that we correctly report the max speed of 1Gbps for this mode.

The second patch uses a dedicated helper to decode the control word.
This is necessary as although USGMII control words are close to USXGMII,
they don't support the same speeds.

Thanks,

Maxime

[1] : https://lore.kernel.org/netdev/ZHnd+6FUO77XFJvQ@shell.armlinux.org.uk/

Maxime Chevallier (2):
  net: phylink: report correct max speed for QUSGMII
  net: phylink: use a dedicated helper to parse usgmii control word

 drivers/net/phy/phylink.c | 41 +++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/mdio.h |  3 +++
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.40.1

