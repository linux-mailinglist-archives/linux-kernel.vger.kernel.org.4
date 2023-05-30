Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3BA7155EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjE3G7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjE3G7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4EBF0;
        Mon, 29 May 2023 23:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634A762ABF;
        Tue, 30 May 2023 06:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C57AC433EF;
        Tue, 30 May 2023 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685429971;
        bh=U77OJ8fJKSyaH0FzfLIhkbSEu3xCuzLCd877xbOniB8=;
        h=From:To:Cc:Subject:Date:From;
        b=o9xq2oz6vEhIM1Out6TzkYRnLr9vAbDibtwAIow6Tqz9YCpzpYNX+bMQRIXeHdbZ+
         bl+8qLeYe2G5mTZydvlInQg572wQC/aApWK3p+EgWqwnhG2PVWf5D7+U7pVIn13PbO
         /hHQ0+5Lp6hRyN9U7otGztcLg+C8eBFqUW9soGuaurKpJlGUCgJOl+wa7rwpYiDkV8
         HCdChvBkNFgTjUrrnZKg2CooMj9PoFXKvXkrkIk5ynbZyMOk518FL93KtHOvzEBLVV
         kusYo05TrPgJk0Q3riUqEQcsfRn+7vha8feCstdwn0h6RMOTCIJBEzdfAH4XUBDONy
         n1Y7beX6KSIZg==
From:   Roger Quadros <rogerq@kernel.org>
To:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc:     r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] usb: typec: tps6598x: Fix broken polling mode after system suspend/resume
Date:   Tue, 30 May 2023 09:59:26 +0300
Message-Id: <20230530065926.6161-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system resume we need to resume the polling workqueue
if client->irq is not set else polling will no longer work.

Fixes: 0d6a119cecd7 ("usb: typec: tps6598x: Add support for polling interrupts status")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 438cc40660a1..603dbd44deba 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -920,7 +920,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		enable_irq(client->irq);
 	}
 
-	if (client->irq)
+	if (!client->irq)
 		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
 				   msecs_to_jiffies(POLL_INTERVAL));
 
-- 
2.34.1

