Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A96C66C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCWLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:37:18 -0400
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [IPv6:2001:41d0:203:375::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE17126EF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:37:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679571435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kZ7HVhRYzHGpfdqvyY+rJRqbLy8aj+vQEUBvMBADCEQ=;
        b=eNKOJfxKmV59e1dfEBvaSpjVcGuskviaA9i1EIttR9DARw1+RW9lKRPhaLg3U8fWHAZhVX
        l8SN3SoLlCUkKRa5WyfSDa88u2qaOQHs76pPbH0sypcfkHS7euc/3Hgim1HP2rDUgsQO+5
        eZTWHLABR2D/2d0Hl2zcYHPBBCgv0Yg=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio/tsi721: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 19:37:09 +0800
Message-Id: <20230323113711.10523-1-cai.huoqing@linux.dev>
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
 drivers/rapidio/devices/tsi721.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 0a42d6a2af24..83323c3d10af 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2924,7 +2924,6 @@ static int tsi721_probe(struct pci_dev *pdev,
 		iounmap(priv->odb_base);
 err_free_res:
 	pci_release_regions(pdev);
-	pci_clear_master(pdev);
 err_disable_pdev:
 	pci_disable_device(pdev);
 err_clean:
@@ -2962,7 +2961,6 @@ static void tsi721_remove(struct pci_dev *pdev)
 		pci_disable_msi(priv->pdev);
 #endif
 	pci_release_regions(pdev);
-	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 	kfree(priv);
@@ -2977,7 +2975,6 @@ static void tsi721_shutdown(struct pci_dev *pdev)
 
 	tsi721_disable_ints(priv);
 	tsi721_dma_stop_all(priv);
-	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.34.1

