Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391BF6C939E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCZJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCZJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:40:10 -0400
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Mar 2023 02:40:08 PDT
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793461B2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:40:08 -0700 (PDT)
Received: from MTA-07-4.privateemail.com (unknown [198.54.122.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id 19A7E60525
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:30:38 +0000 (UTC)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 74D9A18000A3;
        Sun, 26 Mar 2023 05:30:36 -0400 (EDT)
Received: from tuxedo.fritz.box (dynamic-093-133-164-052.93.133.pool.telefonica.de [93.133.164.52])
        by mta-07.privateemail.com (Postfix) with ESMTPA id B367418000A8;
        Sun, 26 Mar 2023 05:30:28 -0400 (EDT)
From:   Juraj Pecigos <kernel@juraj.dev>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Juraj Pecigos <kernel@juraj.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN
Date:   Sun, 26 Mar 2023 11:29:49 +0200
Message-Id: <20230326092948.147994-1-kernel@juraj.dev>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A system with more than one of these SSDs will only have one usable.
The kernel fails to detect more than one nvme device due to duplicate
cntlids.

before:
[    9.395229] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    9.395262] nvme nvme0: pci function 0000:01:00.0
[    9.395282] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    9.395305] nvme nvme1: pci function 0000:03:00.0
[    9.409873] nvme nvme0: Duplicate cntlid 1 with nvme1, subsys nqn.2022-07.com.siliconmotion:nvm-subsystem-sn-                    , rejecting
[    9.409982] nvme nvme0: Removing after probe failure status: -22
[    9.427487] nvme nvme1: allocated 64 MiB host memory buffer.
[    9.445088] nvme nvme1: 16/0/0 default/read/poll queues
[    9.449898] nvme nvme1: Ignoring bogus Namespace Identifiers

after:
[    1.161890] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.162660] nvme nvme0: pci function 0000:01:00.0
[    1.162684] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    1.162707] nvme nvme1: pci function 0000:03:00.0
[    1.191354] nvme nvme0: allocated 64 MiB host memory buffer.
[    1.193378] nvme nvme1: allocated 64 MiB host memory buffer.
[    1.211044] nvme nvme1: 16/0/0 default/read/poll queues
[    1.211080] nvme nvme0: 16/0/0 default/read/poll queues
[    1.216145] nvme nvme0: Ignoring bogus Namespace Identifiers
[    1.216261] nvme nvme1: Ignoring bogus Namespace Identifiers

Adding the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk to resolves the issue.

Signed-off-by: Juraj Pecigos <kernel@juraj.dev>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b615906263f3..282d808400c5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3441,7 +3441,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.40.0

