Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB985F6083
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJFFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJFFQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:16:11 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E1887098;
        Wed,  5 Oct 2022 22:16:09 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MjfmQ71xgz9srF;
        Thu,  6 Oct 2022 07:16:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2AbJ7q4jLQJr; Thu,  6 Oct 2022 07:16:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MjfmQ5z72z9srD;
        Thu,  6 Oct 2022 07:16:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8C548B765;
        Thu,  6 Oct 2022 07:16:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id raXtSJ_lA2DV; Thu,  6 Oct 2022 07:16:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.234])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 80ED38B763;
        Thu,  6 Oct 2022 07:16:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2965FsiG209799
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 07:15:54 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2965FrbT209785;
        Thu, 6 Oct 2022 07:15:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: Replace NO_IRQ by 0
Date:   Thu,  6 Oct 2022 07:15:44 +0200
Message-Id: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665033343; l=2964; s=20211009; h=from:subject:message-id; bh=uaw6wvWqL3qNP4TM3e5bijnIXPJZRnxRj//xsbB+f0k=; b=4QqaI6kRR3XrACI7AKO/dXaOfVrtdOBEuhVA5NmUboC6/5mCZFsYZhhxUwUF4GBqu7HBLizBbngY 6Ek7K0v/Ae1tUT30iDer1tcRLUPJF0xxQetMJPpKPuI0DeRUWT7p
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_IRQ is used to check the return of irq_of_parse_and_map().

On some architecture NO_IRQ is 0, on other architectures it is -1.

irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.

So use 0 instead of using NO_IRQ.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/usb/host/ehci-grlib.c  | 2 +-
 drivers/usb/host/ehci-ppc-of.c | 2 +-
 drivers/usb/host/fhci-hcd.c    | 2 +-
 drivers/usb/host/ohci-ppc-of.c | 2 +-
 drivers/usb/host/uhci-grlib.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-grlib.c b/drivers/usb/host/ehci-grlib.c
index a2c3b4ec8a8b..0717f2ccf49d 100644
--- a/drivers/usb/host/ehci-grlib.c
+++ b/drivers/usb/host/ehci-grlib.c
@@ -99,7 +99,7 @@ static int ehci_hcd_grlib_probe(struct platform_device *op)
 	hcd->rsrc_len = resource_size(&res);
 
 	irq = irq_of_parse_and_map(dn, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(&op->dev, "%s: irq_of_parse_and_map failed\n",
 			__FILE__);
 		rv = -EBUSY;
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index 28a19693c19f..62a0a193798c 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -119,7 +119,7 @@ static int ehci_hcd_ppc_of_probe(struct platform_device *op)
 	hcd->rsrc_len = resource_size(&res);
 
 	irq = irq_of_parse_and_map(dn, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(&op->dev, "%s: irq_of_parse_and_map failed\n",
 			__FILE__);
 		rv = -EBUSY;
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 2ba09c3fbc2f..6d3215a3ef81 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -693,7 +693,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
 
 	/* USB Host interrupt. */
 	usb_irq = irq_of_parse_and_map(node, 0);
-	if (usb_irq == NO_IRQ) {
+	if (!usb_irq) {
 		dev_err(dev, "could not get usb irq\n");
 		ret = -EINVAL;
 		goto err_usb_irq;
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 591f675cc930..f2f6c832ec98 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -120,7 +120,7 @@ static int ohci_hcd_ppc_of_probe(struct platform_device *op)
 	}
 
 	irq = irq_of_parse_and_map(dn, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(&op->dev, "%s: irq_of_parse_and_map failed\n",
 			__FILE__);
 		rv = -EBUSY;
diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index 3ef6d52839e5..907d5f01edfd 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -116,7 +116,7 @@ static int uhci_hcd_grlib_probe(struct platform_device *op)
 	hcd->rsrc_len = resource_size(&res);
 
 	irq = irq_of_parse_and_map(dn, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_ERR "%s: irq_of_parse_and_map failed\n", __FILE__);
 		rv = -EBUSY;
 		goto err_usb;
-- 
2.37.1

