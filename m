Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC72F72B320
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjFKRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 13:20:48 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5ED199E;
        Sun, 11 Jun 2023 10:20:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E73559200C7; Sun, 11 Jun 2023 19:19:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E0F309200C0;
        Sun, 11 Jun 2023 18:19:57 +0100 (BST)
Date:   Sun, 11 Jun 2023 18:19:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/14] PCI: Use `pcie_wait_for_link_status' in
 `pcie_wait_for_link_delay'
In-Reply-To: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306111611170.64925@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a DLLLA status bit polling loop from `pcie_wait_for_link_delay' 
and call almost identical code in `pcie_wait_for_link_status' instead.  
This reduces the lower bound on the polling interval from 10ms to 1ms, 
possibly increasing the CPU load on the system in favour to reducing 
the wait time.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v9.
---
 drivers/pci/pci.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

linux-pcie-wait-for-link-delay-status.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -4889,16 +4889,14 @@ static bool pcie_wait_for_link_status(st
 static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 				     int delay)
 {
-	int timeout = PCIE_LINK_RETRAIN_TIMEOUT_MS;
 	bool ret;
-	u16 lnk_status;
 
 	/*
 	 * Some controllers might not implement link active reporting. In this
 	 * case, we wait for 1000 ms + any delay requested by the caller.
 	 */
 	if (!pdev->link_active_reporting) {
-		msleep(timeout + delay);
+		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
 		return true;
 	}
 
@@ -4913,20 +4911,11 @@ static bool pcie_wait_for_link_delay(str
 	 */
 	if (active)
 		msleep(20);
-	for (;;) {
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-		if (ret == active)
-			break;
-		if (timeout <= 0)
-			break;
-		msleep(10);
-		timeout -= 10;
-	}
+	ret = pcie_wait_for_link_status(pdev, false, active);
 	if (active && ret)
 		msleep(delay);
 
-	return ret == active;
+	return ret;
 }
 
 /**
