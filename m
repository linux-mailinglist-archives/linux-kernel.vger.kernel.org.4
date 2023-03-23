Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6A6C61EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCWIhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCWIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:37:07 -0400
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [IPv6:2001:41d0:203:375::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D0FF29
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:35:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679560557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sR3yPTtRDVj1xoPJWPkU1xtU6p71nBTQtzFAzgAXTAM=;
        b=aPn5X1CDLNGicO++xOTkolNf/4Uw7IjGooBgYaR1whX2aspiUAaolHbmudZtyPshdQLFP0
        fJY3I+uyqublkl7FC6ehPI+9HsohOvYbxM+ecTX/IZ19buHUPFHHCR1ZiqHI5Dl8iYRip1
        fJBODkoL2vICZ6cHnXb92wg9orz9H3w=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Oded Gabbay <ogabbay@kernel.org>, Tomer Tayar <ttayar@habana.ai>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 16:35:49 +0800
Message-Id: <20230323083553.16864-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/accel/habanalabs/common/device.c  | 1 -
 drivers/accel/habanalabs/common/pci/pci.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 713005998cbc..2fb1e2ec3a83 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1271,7 +1271,6 @@ int hl_device_resume(struct hl_device *hdev)
 	return 0;
 
 disable_device:
-	pci_clear_master(hdev->pdev);
 	pci_disable_device(hdev->pdev);
 
 	return rc;
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index d1f4c695baf2..191e0e3cf3a5 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -420,7 +420,6 @@ int hl_pci_init(struct hl_device *hdev)
 unmap_pci_bars:
 	hl_pci_bars_unmap(hdev);
 disable_device:
-	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 
 	return rc;
@@ -436,6 +435,5 @@ void hl_pci_fini(struct hl_device *hdev)
 {
 	hl_pci_bars_unmap(hdev);
 
-	pci_clear_master(hdev->pdev);
 	pci_disable_device(hdev->pdev);
 }
-- 
2.34.1

