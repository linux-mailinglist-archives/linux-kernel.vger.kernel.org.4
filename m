Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127D6F2C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjEADAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAC7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6F19BA;
        Sun, 30 Apr 2023 19:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC7EE60F9A;
        Mon,  1 May 2023 02:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9131BC4339C;
        Mon,  1 May 2023 02:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909880;
        bh=DWstlYSb6HQkL3J/mt/Oo2KXh8UsNNnwfW+H9bnZiTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljI8FP/S1EPxv0AS0gcR8Mx49zrLpEuIRlejnr0UkolUyQrcGMd3ZQ7Z/Odh/uuge
         UUvjcpMCMFKC5bW6K6P/oGz86JISRRXXc2bb4M8TkQdnqS6kU4EvimysnUkjn43tpF
         ASsuZ8B60K8k2e03oC8iGfk+qHC4vy+U31AXEi7mspqArElFp8EfeZrt4AFjUIQ3Cr
         H6RKVWzROGl9+AtINb1qNTQCK6NY/xudRACB/IdGta1/99o4rZcK01jJJPhgzdbudP
         M1Kq4dwGDFyFbV3Q/PWEkGxtdIJpNeArySbgR3EmlfOa1hGyRhIzaMWn9V/lApiXh8
         lcGx3mFBVc4jA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, maximlevitsky@gmail.com,
        oakad@yahoo.com, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 20/44] memstick: r592: Fix UAF bug in r592_remove due to race condition
Date:   Sun, 30 Apr 2023 22:56:08 -0400
Message-Id: <20230501025632.3253067-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 1d35d147552d4..42bfc46842b82 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -829,7 +829,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-
+	del_timer_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {
-- 
2.39.2

