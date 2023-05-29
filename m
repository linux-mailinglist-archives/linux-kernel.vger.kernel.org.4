Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445007145C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjE2Hxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjE2Hxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:53:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DBAC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:53:29 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3Xh0qNNQ6bOsk3Xh0qatrx; Mon, 29 May 2023 09:53:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685346807;
        bh=H3ch+1sM2uCmnqikyZRtBFR3E4UWkyikm5gSoo9tMEw=;
        h=From:To:Cc:Subject:Date;
        b=Ca+i/7Xd8fUTtOSPS5ZtF6/eN31g6TQw804cqrMM2lMjXpHJ9myreRtfPe0MwTz5H
         gOwZ0qhXNQFMi8Vmb5TWrAlplx3j48gdpLdhvaoNgvx4QZj1bJrsQuOfcAmcMSTHXv
         4fwrBXcJfSDMGMKkFVuLJzWhbBezJYol8FyxkAUxa8LxbHoTFUqVlf1yYjx7EBj795
         OkfOXDBRObkLgAFMEWca4kMrXTi1z+xSV+9UmN2s85MhhnnrsGlgHIEztesd7bQuGo
         0pzUzFUKdEEotX+ilQzPdO5Jw++pQ91CrHAy8IX6e64C6Ynx62yzVqV4LcmLQS/qQQ
         YdnIjkd3bMDMw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 09:53:27 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: xilinx: Fix a memory leak in zynqmp_pm_remove()
Date:   Mon, 29 May 2023 09:53:24 +0200
Message-Id: <93ef923496b6c45a0baa59458099aed3a20b771a.1685346792.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rx_chan' is known to be NULL here.
Reverse the logic to free the mbox if it has been allocated.

Fixes: ffdbae28d9d1 ("drivers: soc: xilinx: Use mailbox IPI callback")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
'rx_chan' may be NULL, but mbox_free_channel() handles it.
Maybe it is more informative to keep a (useless) "if (rx_chan)" to tell
that it may not be allocated.


On my machine, compilation fails with gcc (Ubuntu 12.1.0-2ubuntu1~22.04):

  CC      drivers/soc/xilinx/zynqmp_power.o
drivers/soc/xilinx/zynqmp_power.c: In function ‘zynqmp_pm_probe’:
drivers/soc/xilinx/zynqmp_power.c:193:12: error: ‘pm_api_version’ is used uninitialized [-Werror=uninitialized]
  193 |         if (pm_api_version < ZYNQMP_PM_VERSION)
      |            ^
drivers/soc/xilinx/zynqmp_power.c:187:13: note: ‘pm_api_version’ was declared here
  187 |         u32 pm_api_version;
      |             ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors

I think that this warning is bogus and gcc is wrong.

But I don't know what to do with it :/
Anyway, it is un-realated to this patch.
---
 drivers/soc/xilinx/zynqmp_power.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 641dcc958911..62a7f6af9544 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -280,8 +280,7 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
 	if (event_registered)
 		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback, NULL);
 
-	if (!rx_chan)
-		mbox_free_channel(rx_chan);
+	mbox_free_channel(rx_chan);
 
 	return 0;
 }
-- 
2.34.1

