Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062BC6F2E27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjEADVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjEADRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAF6A71;
        Sun, 30 Apr 2023 20:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D8F618A2;
        Mon,  1 May 2023 03:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B6DC43446;
        Mon,  1 May 2023 03:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910416;
        bh=/csMtu44to+WoMyscVxjXAwFU/W1ZJc/YakW1b+HFcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRNyjEZwqTPOmHOidsprSHJ0cWsnFn8TGLYRLASq2sUYbz6CXu4vtU+VIY9DEUY/0
         rXfFMe9ei+sZbEDXF64IWqMg28jEYYn2TyNCnKUNLMNYZMcL+aVYnpR1GHvNPAXiAS
         H5m1UEca/EXDKwZRYHpF5ssgjzf45u74olLe3/27mDkeTb8/19LpgriJeritIIUlWo
         wOg3rD9ahLBWf1oA9G//J34g2Zj5gHM2BvdhEHrbGxwFhQdBfx6CL7lgyIhxzNZkSx
         9X4KlqGkMeEQ+Rog1Q1lL8PGUOzPHmVKYW4EUes4Rbu3Zkd7KJiEnspnAGjfbv+sKb
         AqTYo69NYkaeA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, maximlevitsky@gmail.com,
        oakad@yahoo.com, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/6] memstick: r592: Fix UAF bug in r592_remove due to race condition
Date:   Sun, 30 Apr 2023 23:06:48 -0400
Message-Id: <20230501030653.3255321-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030653.3255321-1-sashal@kernel.org>
References: <20230501030653.3255321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 63264422785021704c39b38f65a78ab9e4a186d7 ]

In r592_probe, dev->detect_timer was bound with r592_detect_timer.
In r592_irq function, the timer function will be invoked by mod_timer.

If we remove the module which will call hantro_release to make cleanup,
there may be a unfinished work. The possible sequence is as follows,
which will cause a typical UAF bug.

Fix it by canceling the work before cleanup in r592_remove.

CPU0                  CPU1

                    |r592_detect_timer
r592_remove         |
  memstick_free_host|
  put_device;       |
  kfree(host);      |
                    |
                    | queue_work
                    |   &host->media_checker //use

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Link: https://lore.kernel.org/r/20230307164338.1246287-1-zyytlz.wz@163.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/host/r592.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 256634ec58b63..d52c89b2a1d58 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -832,7 +832,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-
+	del_timer_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {
-- 
2.39.2

