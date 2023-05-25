Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A527115D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbjEYSqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbjEYSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FEC2694;
        Thu, 25 May 2023 11:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11056493D;
        Thu, 25 May 2023 18:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97298C433EF;
        Thu, 25 May 2023 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039937;
        bh=kZTG3ob6lvK4ed6LIxJODwypGdMd3TUKZh3hvud4Soc=;
        h=From:To:Cc:Subject:Date:From;
        b=CP5QOmVDDZIFhKTjwqKaZqX7iJLCMhmyR9u2f5KS9YqtxBBQQpqCKFYKjhRchPQSH
         TWuKDqR4J+DR6AcyT6HmA13j71BrkPl7BsLvaFA9eo7JHc8qBy8N8wsrv22rmz3CpB
         HGB7GbogbSWoJTdLbr3b2uVfiGC4UCLP5XOA/BjXkL6nNKiF/L15YX9Tu0HR8mIUPa
         T/JtfqrU5ife+Dzg/2mf3EeGf2ZTVsiKcw93kGqunFq2wRTaqbs2RoYvT9tEbpje/k
         FsRPJoHtBwHIvfBD05sZFkBb8wf8hYt7k425xeD8LsFs/lba5aTm3ovTpmno6SgNx7
         D1TmD7giOBIVA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Andrey God <andreygod83@protonmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, kbusch@kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 01/43] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G
Date:   Thu, 25 May 2023 14:38:12 -0400
Message-Id: <20230525183854.1855431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 1616d6c3717bae9041a4240d381ec56ccdaafedc ]

Add a quirk to fix HS-SSD-FUTURE 2048G SSD drives reporting duplicate
nsids.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217384
Reported-by: Andrey God <andreygod83@protonmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c3acef6c32917..bfb9ddec9f887 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3403,6 +3403,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.39.2

