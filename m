Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7C70731C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEQUf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEQUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:35:55 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B530DE;
        Wed, 17 May 2023 13:35:52 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6A96440003;
        Wed, 17 May 2023 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684355750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SSGXfEp8iM8O02ghChWjaJmvwfOrma9CfJ6bauKgZKs=;
        b=kkT74lxcnodSczi7YzH5G6aHSnG2xAbswZOFssIa8AKHqbPHU+ZRPXRpIIblqFqOMFo0tU
        NvwhIpOc+FCJfzzLv5ESKvZvLQ5XP6QRJSwnNAw4LTYHfSjAMtg6FZL35oaKPrMdgDOvpg
        TmAHZEXxsd6bKHPsXQkWFPrXMA+r3hVGtV99PHifhxq/eYsCGLZSjhA44Ft7KILiVE5Tnm
        s9S1o3eAN4yM5rJRqsUB6UEUWRoUgt9jEAE9wT1hS2h+wYr+0ft25iHIX0+qc7JTf/XBEl
        7zYYUll7a/OkTdU8A6ei+wFcobWsutxF7YllsaTNkh2AoFM9AmIk6gjBaN7+6A==
From:   alexis.lothore@bootlin.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        paul.arola@telus.com, scott.roberts@telus.com,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add 88E6361 support
Date:   Wed, 17 May 2023 22:34:28 +0200
Message-Id: <20230517203430.448705-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

This series brings initial support for Marvell 88E6361 switch.

MV88E6361 is a 8 ports switch with 5 integrated Gigabit PHYs and 3
2.5Gigabit SerDes interfaces. It is in fact a new variant in the
88E639X/88E6193X/88E6191X family with a subset of existing features (e.g.
reduced ports count, lower maximal speed for MII interfaces).
Since said family is already well supported in mv88e6xxx driver, adding
initial support for this new switch mostly consists in finding the ID
exposed in its identification register, and then add a proper description
in switch description tables in mv88e6xxx driver.

This initial support has been tested with two samples of a custom board
with the following hardware configuration:
- a main CPU connected to MV88E6361 using port 0 as CPU port
- port 9 wired to a SFP cage
- port 10 wired to a G.Hn transceiver

The following setup was used:
PC <-ethernet-> (copper SFP) - Board 1 - (G.hn) <-phone line(RJ11)-> (G.hn) Board 2

The unit 1 has been configured to bridge SFP port and G.hn port together,
which allowed to successfully ping Board 2 from PC.

Alexis Lothoré (2):
  dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility
    list
  net: dsa: mv88e6xxx: enable support for 88E6361 switch

 .../devicetree/bindings/net/dsa/marvell.txt   |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c              | 25 +++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h              |  3 ++-
 drivers/net/dsa/mv88e6xxx/port.h              |  1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.40.1

