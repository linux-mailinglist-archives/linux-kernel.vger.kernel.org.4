Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27B7018BB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjEMR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEMR5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA22133;
        Sat, 13 May 2023 10:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B2161BCB;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A783C4339C;
        Sat, 13 May 2023 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=17CypJr+LuSnQyYNvIQktRqRkHT7zYk/k1QXGCJ3q9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5jYsmm9xtSDqVJlFGyQ5KonuJ6Lz3Lc0k1c6mH18rxQgtEdpIhT1t9LsUbj6Pdco
         M5CFD9SKG2lvhd6kINZJ1TsRD1YGGvl3dtB4UO4imTDi/AvghUMX4Kyn/F5Iz7nTFu
         jfDAqXbHai1vbxChXJ63nskR78OxPIET0vJaAhvqq+GD4Pi+SeXaOvuwqOiumyuYki
         JJWWK/c1SaPASUCVBL+zubA227ghwvVWRe0CqRq9UJGAnLtbAWul9ZHFiv4cEK0ANv
         g4iwpjhZk3NQ/BlmpCQNs8Hq0Wqxinok/zqwBxwjYKfTLKOpU9pFdfspf0twKHLEEr
         XTY1pSSEubAxQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001txY-0z;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Duoming Zhou <duoming@zju.edu.cn>, Abylay Ospan <aospan@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Kozlov <serjk@netup.ru>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 03/24] media: netup_unidvb: fix use-after-free bug caused by del_timer()
Date:   Sat, 13 May 2023 18:57:20 +0100
Message-Id: <0d23dfd380ba4466d8e6208dcbf40a250a734099.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duoming Zhou <duoming@zju.edu.cn>

When Universal DVB card is detaching, netup_unidvb_dma_fini()
uses del_timer() to stop dma->timeout timer. But when timer
handler netup_unidvb_dma_timeout() is running, del_timer()
could not stop it. As a result, the use-after-free bug could
happen. The process is shown below:

    (cleanup routine)          |        (timer routine)
                               | mod_timer(&dev->tx_sim_timer, ..)
netup_unidvb_finidev()         | (wait a time)
  netup_unidvb_dma_fini()      | netup_unidvb_dma_timeout()
    del_timer(&dma->timeout);  |
                               |   ndev->pci_dev->dev //USE

Fix by changing del_timer() to del_timer_sync().

Link: https://lore.kernel.org/linux-media/20230308125514.4208-1-duoming@zju.edu.cn
Fixes: 52b1eaf4c59a ("[media] netup_unidvb: NetUP Universal DVB-S/S2/T/T2/C PCI-E card driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 8287851b5ffd..aaa1d2dedebd 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -697,7 +697,7 @@ static void netup_unidvb_dma_fini(struct netup_unidvb_dev *ndev, int num)
 	netup_unidvb_dma_enable(dma, 0);
 	msleep(50);
 	cancel_work_sync(&dma->work);
-	del_timer(&dma->timeout);
+	del_timer_sync(&dma->timeout);
 }
 
 static int netup_unidvb_dma_setup(struct netup_unidvb_dev *ndev)
-- 
2.40.1

