Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15387251DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjFGB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjFGB6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:58:13 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57305196;
        Tue,  6 Jun 2023 18:58:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [222.129.46.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A3D7341E1B;
        Wed,  7 Jun 2023 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686103089;
        bh=9jQwoFHBV0DDoVB44LwqGLuFZFu+qgP0qrXPp4Wffu4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qQ/7P+1fG3bdkLmOfMffEJDAFJg1UOD71vAaX0HtvAtd6KnqmSKjcJgagsJOOkFfK
         6f7G0eINeEvzyXgCRAZj2eWFI2ZNj7W6MdOR0WOZP04KqKC5EayxXfd8Bmw4ZPByn7
         hcePI1re75lB4FLgCrLn7vtCG4TaK2qV9o+XknnNdoGOrctWq6Klc7PfB6qrRwKiQV
         RBkjiW1tonKq2vANjoqlnDN0OAwksJNysvzthBYnjJF05oTxgdnlcvRGmFfZY9SUUp
         WFS9KuYV1nQhSD0MZqa/HgRazR5nmPa622ADsNC5hmPttMgiohNrNBY+9nfRuKEvnN
         CBjZmQOp3pGdQ==
From:   Aaron Ma <aaron.ma@canonical.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        Auke Kok <auke-jan.h.kok@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2] igb: fix hang issue of AER error during resume
Date:   Wed,  7 Jun 2023 09:56:46 +0800
Message-Id: <20230607015646.558534-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526163001.67626-1-aaron.ma@canonical.com>
References: <20230526163001.67626-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe AER error_detected caused a race issue with igb_resume.
Protect error_detected when igb is in down state.

Error logs:
kernel: igb 0000:02:00.0: disabling already-disabled device
kernel: WARNING: CPU: 0 PID: 277 at drivers/pci/pci.c:2248 pci_disable_device+0xc4/0xf0
kernel: RIP: 0010:pci_disable_device+0xc4/0xf0
kernel: Call Trace:
kernel:  <TASK>
kernel:  igb_io_error_detected+0x3e/0x60
kernel:  report_error_detected+0xd6/0x1c0
kernel:  ? __pfx_report_normal_detected+0x10/0x10
kernel:  report_normal_detected+0x16/0x30
kernel:  pci_walk_bus+0x74/0xa0
kernel:  pcie_do_recovery+0xb9/0x340
kernel:  ? __pfx_aer_root_reset+0x10/0x10
kernel:  aer_process_err_devices+0x168/0x220
kernel:  aer_isr+0x1b5/0x1e0
kernel:  ? __pfx_irq_thread_fn+0x10/0x10
kernel:  irq_thread_fn+0x21/0x70
kernel:  irq_thread+0xf8/0x1c0
kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
kernel:  ? __pfx_irq_thread+0x10/0x10
kernel:  kthread+0xef/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x29/0x50
kernel:  </TASK>
kernel: ---[ end trace 0000000000000000 ]---

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217446
Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Reviewed-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
V1->V2: Add target tree tag net and Fixes tag.

 drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 58872a4c2540..8333d4ac8169 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9581,14 +9581,21 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
 	if (netif_running(netdev))
 		igb_down(adapter);
 	pci_disable_device(pdev);
+	rtnl_unlock();
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
-- 
2.34.1

