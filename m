Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523956C4DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCVOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjCVObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:31:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE662B5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:31:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pezV1-0003Or-At; Wed, 22 Mar 2023 15:31:35 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pezUy-005wWC-G1; Wed, 22 Mar 2023 15:31:32 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1pezUx-0060ZT-1M; Wed, 22 Mar 2023 15:31:31 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 0/6] net: dsa: microchip: ksz8: fixes for stable
Date:   Wed, 22 Mar 2023 15:31:24 +0100
Message-Id: <20230322143130.1432106-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes address issues such as incomplete FDB extraction, incorrect
FID extraction and configuration, incorrect timestamp extraction, and
ghost entry extraction from an empty dynamic MAC table. These updates
ensure proper functioning of the FDB/MDB functionality for the
ksz8863/ksz8873 series of chips.

Oleksij Rempel (6):
  net: dsa: microchip: ksz8: fix ksz8_fdb_dump()
  net: dsa: microchip: ksz8: fix ksz8_fdb_dump() to extract all 1024
    entries
  net: dsa: microchip: ksz8: fix offset for the timestamp filed
  net: dsa: microchip: ksz8: ksz8_fdb_dump: avoid extracting ghost entry
    from empty dynamic MAC table.
  net: dsa: microchip: ksz8863_smi: fix bulk access
  net: dsa: microchip: ksz8: fix MDF configuration with non-zero VID

 drivers/net/dsa/microchip/ksz8795.c     | 11 +++++------
 drivers/net/dsa/microchip/ksz8863_smi.c | 10 +---------
 drivers/net/dsa/microchip/ksz_common.c  | 12 ++++++------
 3 files changed, 12 insertions(+), 21 deletions(-)

-- 
2.30.2

