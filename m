Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C466CD2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjC2HXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2HXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:23:18 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99E051BF6;
        Wed, 29 Mar 2023 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k1+81
        /LRc+QPaXuwviz1ZmJdBJ9jC4z0SLIYlLcZv/k=; b=Q3Uk9BKqp9bm4WreWBohS
        3UY8tW52mSI2m0XIzrh4xHhEO7e2msTRdPViif9KUd3UALF07sfOMTOKWIji5gWm
        nR6y/r9LK5UXkOxuX+tlrxUDwX25v2aj5pkAEbWl/+AInzV9sDoaFcBOJPP+0eCJ
        ynQdZfOL9hxWPqfKfifmnk=
Received: from VM-0-27-ubuntu.. (unknown [43.134.191.38])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wA3TzdD5yNk5z4EAA--.1365S2;
        Wed, 29 Mar 2023 15:22:45 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: pci_generic: Add Foxconn T99W510
Date:   Wed, 29 Mar 2023 15:22:39 +0800
Message-Id: <20230329072239.93632-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3TzdD5yNk5z4EAA--.1365S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1UZr1DCw1Duw1DWFWxJFb_yoW8CF1UpF
        savryUta1kJFWYkFsrJrWDXas8JanxCry3KFn7Gw1Y9r4vyayYqrs7Gry29Fy3Kas8Xr43
        tFy8uFWUW3WqyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEgAwnUUUUU=
X-Originating-IP: [43.134.191.38]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiNQlBZGI0cAnPYAABsY
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Foxconn T99W510 device is designed based on Qualcomm
SDX24. Add 3 variants for different potential customer.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 91d02f84ba21..db0a0b062d8e 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -363,6 +363,15 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
 	.event_cfg = mhi_foxconn_sdx55_events,
 };
 
+static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
+	.name = "foxconn-sdx24",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
 static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.name = "foxconn-sdx55",
 	.fw = "qcom/sdx55m/sbl1.mbn",
@@ -587,6 +596,15 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* T99W373 (sdx62) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+	/* T99W510 (sdx24), variant 1 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f0),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
+	/* T99W510 (sdx24), variant 2 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f1),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
+	/* T99W510 (sdx24), variant 3 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f2),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
 	/* MV31-W (Cinterion) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
-- 
2.34.1

