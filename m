Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365315BAC18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIPLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIPLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:11:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0551ADB4;
        Fri, 16 Sep 2022 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663326639; x=1694862639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SnWPVDDU5fPkkq7tvF6vhr6efjC0YP4JjkFLIvmH380=;
  b=bntOSzRbJVIdOA5eS/yDssZhMyPVqeccB2sjZv6QGihMfWkbHykNfmG5
   MwXKWWFbBeHJnqpoIrMD+9Un0pNq++wlRS5J6WrT2kKdp+WDn3DEx0dqf
   y7nz4tmBD35EsYi2G9DDegaYvLbmIjsRGT2Jkf7BLYWNmUrwSUl6JvwAz
   Ay2yHu8EB9cDULeoqJrz/YwvJxXwUbOFbZJUid0Dfofn+tLaj6YjgYMOw
   ZvZ98GgBvA9sp8aI5/VDS8GGdgueimIlDgzVYIHillR87eXPujn6aYIIo
   8Z3XevkJkerjQUuoAsUQyWBUMehqQWfP6PdFdA8/Yea9YOUIuC4UjxIdA
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="26224742"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Sep 2022 13:10:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 16 Sep 2022 13:10:36 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 16 Sep 2022 13:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663326636; x=1694862636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SnWPVDDU5fPkkq7tvF6vhr6efjC0YP4JjkFLIvmH380=;
  b=GB3CNAUUx7lb34U0GUWIOquIpUSZq3grnVZkc9LbM2leVdLbEvkeHGEA
   MQBfuErLNEUS6s3brslUlpxYXmA9JfKS8m7oczo4hcz5It+USvE2DbqcI
   BbhmfUY32tSL4qoGh1lhOn/ctH47ZPQHFMY4Z+6KDlc2n6/P0sYiQ4BoF
   xvnT6EdFbn1H3KOV4OYoOOu5sSZfKTpghRRrQt24nGjlbfnk9aMIU88GT
   QVvVy7kLO9C3NrYmVO6SbNVdd9nyd0/xLoA1KNK592UHhVFTC8xLodVRl
   UPvBs3aNvCsXzXIepwXT5VyunQOQVE7Ud4kKrNJX+8BsgaijfHinER/Ie
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="26224741"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Sep 2022 13:10:36 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id DC7BA280056;
        Fri, 16 Sep 2022 13:10:35 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] serial: 8250: omap: Use serial8250_em485_supported
Date:   Fri, 16 Sep 2022 13:09:55 +0200
Message-Id: <20220916110955.161099-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_omap uses em485, fill in rs485_supported accordingly. This makes
RS485 work with 8250_omap again, which was broken with the introduction
of the RS485 config sanitization.

Fixes: be2e2cb1d2819 ("serial: Sanitize rs485_struct")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/tty/serial/8250/8250_omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ff51ff91b9237..38ee3e42251af 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1337,6 +1337,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
 	up.port.rs485_config = serial8250_em485_config;
+	up.port.rs485_supported = serial8250_em485_supported;
 	up.rs485_start_tx = serial8250_em485_start_tx;
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
-- 
2.25.1

