Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84A729232
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjFIIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbjFIIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:05:03 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A243C0F;
        Fri,  9 Jun 2023 01:03:48 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686297789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V1fjQgvADNeoYs1XNE6CaL9g0vQm/7IWTKb+iOiyp9U=;
        b=pCaH0AEfra0t+2HyuCPvIO5uveL7uMFWIGejcXukSlwSKDBKIP2vjoikFe7Uj6fKw+5EGf
        5x6zxGvHH9S+SDcFol5H8sGkT7gpOztJIpm20XgP/Qt1WNOjiPCp8Nmfisu3rkPh+D69qv
        SG5F3fmQX4HfI3d8oLc9Zcn8CNGt+7kVZpnxQhv6LebT1QubIeLc5oQmOZC9NHoOJiJy+s
        ojdmbd0xR98KDunDkXDSfKxvCpio6Gb+VjRuxodZpCLnZflETss1jM60/Mz+/5CuLE+SyR
        yVhVNbtMEC8QkTL6LapK61qssSclqBba/0qUoZMU+2BnangOsZluKlJTLMyfAg==
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
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C19A4C0011;
        Fri,  9 Jun 2023 08:03:07 +0000 (UTC)
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
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net v2 0/2] fixes for Q-USGMII speeds and autoneg
Date:   Fri,  9 Jun 2023 10:03:03 +0200
Message-Id: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of a small changeset for QUSGMII support,
fixing inconsistencies in reported max speed and control word parsing.

As reported here [1], there are some inconsistencies for the Q-USGMII
mode speeds and configuration. The first patch in this fixup series
makes so that we correctly report the max speed of 1Gbps for this mode.

The second patch uses a dedicated helper to decode the control word.
This is necessary as although USGMII control words are close to USXGMII,
they don't support the same speeds.

Thanks,

Maxime

[1] : https://lore.kernel.org/netdev/ZHnd+6FUO77XFJvQ@shell.armlinux.org.uk/

V1->V2: Fix decoding logic for usgmii control word, as per Russell's review

Maxime Chevallier (2):
  net: phylink: report correct max speed for QUSGMII
  net: phylink: use a dedicated helper to parse usgmii control word

 drivers/net/phy/phylink.c | 41 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

-- 
2.40.1

