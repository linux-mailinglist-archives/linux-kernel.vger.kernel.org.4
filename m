Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE068F34A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjBHQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjBHQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:37:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A6038EAF;
        Wed,  8 Feb 2023 08:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54EF616EE;
        Wed,  8 Feb 2023 16:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08DEC4339B;
        Wed,  8 Feb 2023 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874249;
        bh=GVlTn/Wb5crb4A7aGUaIl+3iY+ZAaM4+XJM7IlFWlSM=;
        h=From:To:Cc:Subject:Date:From;
        b=Laq+P8YKAoCSl06pO9O+adebVbm49zvt1gGfskm0kL4BmR8GvEdn7Rw5E4xusCqRk
         xvtwdxZ3/xZE2l23+ivWgAwAoINRkM/Hnyub41w1o+9sHh15x3nbwiJ2JNE8G+/gCB
         hwQyzQDLIWixAZ75wUWYZd18F1SezL8jjyoihk6v5DGhtoxb4+Kjt8FmWi+6GuFdHC
         UbyfdsU0lwUqc81Yel3jabcwHl+zK1F6U/NIBIUQF0w0wKWjoyy/V6lOLu2cmm8sDs
         1L7FxPFKPlcttnaOjbLQHzWXkpEkUiotaPP+CF/fM9nHat1BnNFobSAI7oOUzK9CD/
         KFQ2Q0GxHYjtg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] can: bittiming: fix can_calc_bittiming() dummy helper
Date:   Wed,  8 Feb 2023 17:37:12 +0100
Message-Id: <20230208163726.2154311-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The prototype for this function changed, but the alternative
implementation needs the same change:

drivers/net/can/dev/bittiming.c: In function 'can_get_bittiming':
drivers/net/can/dev/bittiming.c:145:24: error: too many arguments to function 'can_calc_bittiming'
  145 |                 return can_calc_bittiming(dev, bt, btc, extack);
      |                        ^~~~~~~~~~~~~~~~~~
In file included from include/linux/can/dev.h:18,
                 from drivers/net/can/dev/bittiming.c:7:
include/linux/can/bittiming.h:126:1: note: declared here
  126 | can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
      | ^~~~~~~~~~~~~~~~~~

Fixes: 286c0e09e8e0 ("can: bittiming: can_changelink() pass extack down callstack")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/can/bittiming.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 6cb2ae308e3f..9b8a9c39614b 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -124,7 +124,7 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
-		   const struct can_bittiming_const *btc)
+		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
 	netdev_err(dev, "bit-timing calculation not available\n");
 	return -EINVAL;
-- 
2.39.1

