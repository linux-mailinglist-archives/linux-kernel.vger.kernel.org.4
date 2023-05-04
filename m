Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0D6F737D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjEDTnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEDTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03983C9;
        Thu,  4 May 2023 12:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0FC62EB8;
        Thu,  4 May 2023 19:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E1C433D2;
        Thu,  4 May 2023 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229365;
        bh=jKJQM7Amchlo/TIBhIhoRm4akaWOf6RtKsRisaHbqM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRl4QQIPolaCjJH2s2kXK2ImQDR709+tnAhUVXaVSuNcNaCx1wvr1Jr1dQb2RL/Hy
         TXJ5bMguVLCItNXWqjPU8ILXqRdt1CiSMA1EemlxCECVfnxiAdyOMqV+hwM1xr1HUF
         t029i70kqoCG2/xqY1M5hPmG/Lewo7c02mT/4YqsFIQpaUQOOo1ILs+N/ytKa8iPRm
         H+4ujsyv0EkIjCWVqlf1CTAzC6xZJpJNqjbTTxvQXx745lziKSOAtvcupKfo6oMYsC
         liLf4K1JPJnlar4eVrmGYC9MFpxSBynwndjLhlVHNep1u4QGoQUEbWUTU1w/f0hKNv
         ubux6h7KquiKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 21/59] scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition
Date:   Thu,  4 May 2023 15:41:04 -0400
Message-Id: <20230504194142.3805425-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
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

