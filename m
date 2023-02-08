Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0568F225
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBHPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBHPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:39:06 -0500
Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E614615D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:39:04 -0800 (PST)
Received: from zmtaout01.partage.renater.fr (zmtaout01.partage.renater.fr [194.254.240.30])
        by smtpout10.partage.renater.fr (Postfix) with ESMTP id B004664A14;
        Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from zmtaout01.partage.renater.fr (localhost [127.0.0.1])
        by zmtaout01.partage.renater.fr (Postfix) with ESMTPS id 40CCE1A0139;
        Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaout01.partage.renater.fr (Postfix) with ESMTP id 35B791A013B;
        Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from zmtaout01.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaout01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CWrDa3tUR0XS; Wed,  8 Feb 2023 16:38:55 +0100 (CET)
Received: from zstore-b0-026.partage.renater.fr (zstore-b0-026.partage.renater.fr [10.254.240.112])
        by zmtaout01.partage.renater.fr (Postfix) with ESMTP id EE91B1A0139;
        Wed,  8 Feb 2023 16:38:54 +0100 (CET)
Date:   Wed, 8 Feb 2023 16:38:54 +0100 (CET)
From:   Irvin Cote <irvin.cote@insa-lyon.fr>
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <1517857586.68818728.1675870734911.JavaMail.zimbra@insa-lyon.fr>
Subject: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - GC103 (Linux)/8.8.15_GA_4372)
Thread-Index: fRAkiwxiQyLsYAI+MScOvhD1znFs/A==
Thread-Topic: nvme-pci : rectifying the nvme_probe teardown path
X-Virus-Scanned: clamav-milter 0.103.6 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefkufggtgfgofhtsehtjegttdertdejnecuhfhrohhmpefkrhhvihhnucevohhtvgcuoehirhhvihhnrdgtohhtvgesihhnshgrqdhlhihonhdrfhhrqeenucggtffrrghtthgvrhhnpeeiuddtveeivdekhfekffetfeefieduudejueejteejffetveekhffftdekudehteenucfkphepuddtrddvheegrddvgedtrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvheegrddvgedtrdduuddvpdhhvghlohepiihsthhorhgvqdgstddqtddviedrphgrrhhtrghgvgdrrhgvnhgrthgvrhdrfhhrpdhmrghilhhfrhhomhepkfhrvhhinhcuvehothgvuceoihhrvhhinhdrtghothgvsehinhhsrgdqlhihohhnrdhfrheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigsohgvsehfsgdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehktghhsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ced363dcd3ef076e509bfbb4ce9815ebaff6aee7 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvin.cote@insa-lyon.fr>
Date: Wed, 8 Feb 2023 11:38:39 -0300
Subject: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
The nvme_probe teardown path did not account for
undoing the work of nvme_pci_alloc_dev, which is
what nvme_pci_free_ctrl seemed to be intended for.
Thus I displaced the call to nvme_uninit_ctrl
from nvme_probe to nvme_pci_free_ctrl and added
a call to the latter in the teardown path of nvme_probe.

Fixes: eac3ef262941 ("nvme-pci: split the initial probe from the rest path")
Signed-off-by: Irvin Cote <irvin.cote@insa-lyon.fr>
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..db480bc64c7b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2731,6 +2731,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	struct nvme_dev *dev = to_nvme_dev(ctrl);

 	nvme_free_tagset(dev);
+	nvme_uninit_ctrl(ctrl);
 	put_device(dev->dev);
 	kfree(dev->queues);
 	kfree(dev);
@@ -3036,7 +3037,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)

 	result = nvme_dev_map(dev);
 	if (result)
-		goto out_uninit_ctrl;
+		goto out_unalloc_dev;

 	result = nvme_setup_prp_pools(dev);
 	if (result)
@@ -3118,8 +3119,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
-out_uninit_ctrl:
-	nvme_uninit_ctrl(&dev->ctrl);
+out_unalloc_dev:
+	nvme_pci_free_ctrl(&dev->ctrl);
 	return result;
 }

--
2.37.2
