Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9326F767A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjEDUHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjEDUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D918DDF;
        Thu,  4 May 2023 12:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4928A63898;
        Thu,  4 May 2023 19:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B259AC4339B;
        Thu,  4 May 2023 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229948;
        bh=3ZM+S5ZLa6liQWKlVaUeIUBP8rK1Yupb0pYlfSdbCSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyt4ibw8kNz9K169DuIsdqjSIsBekqNwYSB31oDCepxlXolcZzISdrweZThfq0swA
         tNoL4llPBZbvAxsm2WrdPZlPARrN9bwt5mWnFsj3Zxw7b7cHAC1U+t4UHCg9GXidi5
         BOSLu2wIdKkt9aLGteEIioPfRc5OFyjIKKFzOulny8rPV4X1WFpk21OrT+k0KEIuZL
         XpHYZxRLpa2BD9g0CaIkuBYc9fzcnWUj02wI6Mk0WOU1m+ZZvoF+u0Ox03+7Yuik+H
         ifeCITIxnXP41p1HrWH/1dicYub4k6jlTcHr7UiFH3RkrKB1w3BR5EWEuz6SxvksMg
         QzE0KiffriXhQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/13] scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition
Date:   Thu,  4 May 2023 15:51:59 -0400
Message-Id: <20230504195207.3809116-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195207.3809116-1-sashal@kernel.org>
References: <20230504195207.3809116-1-sashal@kernel.org>
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
index 55dd71bbdc2aa..74d0ae00b0827 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1429,7 +1429,9 @@ mptlan_remove(struct pci_dev *pdev)
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

