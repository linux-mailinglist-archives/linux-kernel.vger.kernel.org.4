Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36B6F2DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjEADQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjEADN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E3F44A4;
        Sun, 30 Apr 2023 20:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E9E61765;
        Mon,  1 May 2023 03:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA353C4339E;
        Mon,  1 May 2023 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910296;
        bh=DWstlYSb6HQkL3J/mt/Oo2KXh8UsNNnwfW+H9bnZiTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA2DbDymLwrP41Ja//hKjGs+hXEA5JoowBuIz3++hPZKOSSH7BmtD84CHbXYv+Z/m
         hVCi77EormDKi3XNhrPT3JrOm+jVRDmTEO0BhzDL0rpLvQ8U5VftqwIb6TWzJhDaE+
         eYEYkUkq2S/rsb7wIAriV9epovKBStDdzZ6lRUzzjqeSQCkATC/kg7w9DJrWGyXHCt
         g+NqpCh2o3EIXfEhcb7pGluxYkkV/QlMlOfUJcj2Jp/G+EPlTja23vsA20yQXUPSk5
         cc4h008A3ByDQ4zHm220weHVvKEYhq+9ODeWRKNwA5ydFkOwhC4Jq7b9mZLdLJFwrY
         FiKzk+ukEAnKA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, maximlevitsky@gmail.com,
        oakad@yahoo.com, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/17] memstick: r592: Fix UAF bug in r592_remove due to race condition
Date:   Sun, 30 Apr 2023 23:04:24 -0400
Message-Id: <20230501030435.3254695-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030435.3254695-1-sashal@kernel.org>
References: <20230501030435.3254695-1-sashal@kernel.org>
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

