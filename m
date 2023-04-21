Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC656EA81A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDUKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDUKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5551FD0;
        Fri, 21 Apr 2023 03:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9655D6191C;
        Fri, 21 Apr 2023 10:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9EEC433EF;
        Fri, 21 Apr 2023 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682072246;
        bh=KWXhoL7+mywikhhUa07/SMiyCk/wDffyd4ObOGkp5xI=;
        h=From:To:Cc:Subject:Date:From;
        b=kJDQlYclMvrAmIaJ4qp4L9+quYvLrXFKr9XoVUHXhDGjJZMN7y1PqnCNPrCO37POr
         aEvKhjwWw3Zj2CdtjgBBWQfnJZtjfG+vjIu3R0CbHQDqFvIcYYVnyQv6MbJ5BQ+kI7
         EIZk7MztCtybDGw7UnM8nMQIbsV7m0QtmAUWUPTbSN759/KlFungWtxBGlFpCnygRp
         hFUdNqLu5hyj5Ui84buQ794JFMxtYXZY7TEp5voi4/GyBfAq1TJLZz8H4gY2t6Bfew
         N9utJ8F2z3WHWPJZRmxmIoTy+SrdaeBdZJa405eF3Jt2xzLbKY4t6sFhLPjlTqUnKP
         8TpumCQU0MSlw==
From:   Roger Quadros <rogerq@kernel.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     srk@ti.com, r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] usb: typec: tps6598x: Fix fault at module removal
Date:   Fri, 21 Apr 2023 13:17:20 +0300
Message-Id: <20230421101720.34318-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to cancel the delayed workqueue if it is being used
else it will cause paging request fault during module removal.

Fixes: 0d6a119cecd7 ("usb: typec: tps6598x: Add support for polling interrupts status")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 8b075ca82ef6..438cc40660a1 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -886,6 +886,9 @@ static void tps6598x_remove(struct i2c_client *client)
 {
 	struct tps6598x *tps = i2c_get_clientdata(client);
 
+	if (!client->irq)
+		cancel_delayed_work_sync(&tps->wq_poll);
+
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
 	usb_role_switch_put(tps->role_sw);
-- 
2.34.1

