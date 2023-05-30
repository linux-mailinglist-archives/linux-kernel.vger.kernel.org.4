Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CB716523
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjE3Owo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3Owi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:52:38 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE99C;
        Tue, 30 May 2023 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685458358;
  x=1716994358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4vUnBXtNja0+OWRdVrOfhc0fbcEoks5geNKas0s+Eg=;
  b=FWynHoZUxm+DE/neDwTE9RYFcSaVcM5rxkeLuBIsYc1NGScRaZo3vwoL
   XoukAwb/0w9cFVlYPu15ih10ypD+e3SMri1HRNc3kUGqvwpnLBnrfeza7
   OFNdWCChCquf4g/mEBCmD0MNil0Qmuo7/TjEmsxG2lQqmwjVAberGxy/0
   HR9CnPofN+Rp50UhpgY9gA58ljk3Xkq6dXDDTirws7BdjE3DQ6hGIzv38
   s+8lv1du1NbyMKvbgghNTGTi/jqft+Y+OWzuOSpJ0txg1ChH3ZbcJa6mR
   2P8yky3SuY4R4E/Lctp1MZz9N2Z5oPRvCJyCJo80Vn4o62+cNzZHaaFHv
   g==;
From:   Andreas Svensson <andreas.svensson@axis.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
CC:     <kernel@axis.com>, Andreas Svensson <andreas.svensson@axis.com>,
        "Baruch Siach" <baruch@tkos.co.il>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: dsa: mv88e6xxx: Increase wait after reset deactivation
Date:   Tue, 30 May 2023 16:52:23 +0200
Message-ID: <20230530145223.1223993-1-andreas.svensson@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A switch held in reset by default needs to wait longer until we can
reliably detect it.

An issue was observed when testing on the Marvell 88E6393X (Link Street).
The driver failed to detect the switch on some upstarts. Increasing the
wait time after reset deactivation solves this issue.

The updated wait time is now also the same as the wait time in the
mv88e6xxx_hardware_reset function.

Fixes: 7b75e49de424 ("net: dsa: mv88e6xxx: wait after reset deactivation")
Signed-off-by: Andreas Svensson <andreas.svensson@axis.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 64a2f2f83735..08a46ffd53af 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7170,7 +7170,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		goto out;
 	}
 	if (chip->reset)
-		usleep_range(1000, 2000);
+		usleep_range(10000, 20000);
 
 	/* Detect if the device is configured in single chip addressing mode,
 	 * otherwise continue with address specific smi init/detection.
-- 
2.30.2

