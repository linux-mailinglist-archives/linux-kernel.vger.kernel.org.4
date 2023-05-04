Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4CF6F741A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjEDTsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEDTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E9131B15;
        Thu,  4 May 2023 12:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD1263783;
        Thu,  4 May 2023 19:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2274C4339B;
        Thu,  4 May 2023 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229507;
        bh=jKJQM7Amchlo/TIBhIhoRm4akaWOf6RtKsRisaHbqM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aW9NsZFrp2li9LwQGg/ly98t0tB8W+xdgsN30OUpsZo2UZWdF506Nq/ZS8407+3Hg
         padXbUQ8Vvan2mr143vtAIaOIB6OClI6GlArwqfQLmdtUTXZoPyrJKUVZFQ9AzecJV
         Iwo+a9+ByeTUZmoeg036SqAbkxqak0TeWnD6qNVr4KVJqI5EG1KsSynKrBOSaQf4kb
         kc9Mcf6+zrLReXwA78SbcXLtWdFH+XDbAzKs5hWyKwYF5SMBQYjuKn05oaoTLJkMvG
         KIX8d/vTTwuaIRSwLm01WWzGtnc5KhJ6C+i6hRg8L5xkQlAkNhwWfY4te2R7J3xRBG
         0DfKIrHxn9XNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 18/53] scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition
Date:   Thu,  4 May 2023 15:43:38 -0400
Message-Id: <20230504194413.3806354-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
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

[ Upstream commit f486893288f3e9b171b836f43853a6426515d800 ]

mptlan_probe() calls mpt_register_lan_device() which initializes the
&priv->post_buckets_task workqueue. A call to
mpt_lan_wake_post_buckets_task() will subsequently start the work.

During driver unload in mptlan_remove() the following race may occur:

CPU0                  CPU1

                    |mpt_lan_post_receive_buckets_work()
mptlan_remove()     |
  free_netdev()     |
    kfree(dev);     |
                    |
                    | dev->mtu
                    |   //use

Fix this by finishing the work prior to cleaning up in mptlan_remove().

[mkp: we really should remove mptlan instead of attempting to fix it]

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Link: https://lore.kernel.org/r/20230318081635.796479-1-zyytlz.wz@163.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/message/fusion/mptlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index 142eb5d5d9df6..de2e7bcf47847 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1433,7 +1433,9 @@ mptlan_remove(struct pci_dev *pdev)
 {
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct net_device	*dev = ioc->netdev;
+	struct mpt_lan_priv *priv = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&priv->post_buckets_task);
 	if(dev != NULL) {
 		unregister_netdev(dev);
 		free_netdev(dev);
-- 
2.39.2

