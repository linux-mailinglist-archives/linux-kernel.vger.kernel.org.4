Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DD5F8CA7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJIRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJIRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:43:08 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 10:42:54 PDT
Received: from so254-28.mailgun.net (so254-28.mailgun.net [198.61.254.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9565C2AE08
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 10:42:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=abhijittomar.com; q=dns/txt;
 s=mx; t=1665337373; x=1665423773; h=Message-Id: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender;
 bh=T/XZfxK3Gm9Hej56TjYA0VoFLDQruLSp+UIXliyC5Vc=; b=afEakiFMGRw3IgPBn3sVtN61IvywE/tn2i99hiNic93A+EjFiy047Wc7a11e90RDgEDHgr6k
 IO8F1Qqbsc0FkxSTJbrJn6h3txJGYD14snWzrqDbALZX5gsF6lbxv8Jui5RMvpaRshzqYyGI
 7MqDx0OC3cgnBasmylj8FtXT7Wk=
X-Mailgun-Sending-Ip: 198.61.254.28
X-Mailgun-Sid: WyIwY2JhNyIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJkMjZkNDMiXQ==
Received: from
 newwireguard.5yaaqpyeffpexbl0sr2b0h3vtf.rx.internal.cloudapp.net (<unknown>
 [13.71.41.3]) by 8eed7f4a1d57 with SMTP id 634306efcf9de181024bc8c4
 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256); Sun, 09 Oct 2022 17:37:51
 GMT
Sender: abhijit@abhijittomar.com
From:   Abhijit Tomar <abhijit@abhijittomar.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abhijit <abhijit@abhijittomar.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM760
Date:   Sun,  9 Oct 2022 17:37:44 +0000
Message-Id: <20221009173744.12173-1-abhijit@abhijittomar.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijit <abhijit@abhijittomar.com>

Add a quirk to fix Lexar NM760 SSD drives reporting duplicate nsids.

Signed-off-by: Abhijit <abhijit@abhijittomar.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8dd1dddbb..8970edf3f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.17.1

