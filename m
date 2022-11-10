Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69756248C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKJRzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiKJRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:55:31 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C049B76;
        Thu, 10 Nov 2022 09:55:26 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4N7TyM1wSdz9sf0;
        Thu, 10 Nov 2022 18:55:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jXLMYtFygd4q; Thu, 10 Nov 2022 18:55:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4N7TyM17Jrz9sdy;
        Thu, 10 Nov 2022 18:55:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 178428B783;
        Thu, 10 Nov 2022 18:55:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zBGArvrCFKJ5; Thu, 10 Nov 2022 18:55:22 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.195])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC0E18B763;
        Thu, 10 Nov 2022 18:55:22 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2AAHtAZM1214289
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:55:10 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2AAHsno81214183;
        Thu, 10 Nov 2022 18:54:49 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: Check !irq instead of irq == NO_IRQ
Date:   Thu, 10 Nov 2022 18:54:35 +0100
Message-Id: <13feefdf6b240817944e6441e26a8ddc1d81ced1.1668102802.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668102873; l=3474; s=20211009; h=from:subject:message-id; bh=HSINWooMikwRFVroev1T+VEXiZDJXgGlJDwE6td7CO4=; b=BFY+D+aE9KXw68T8bTbQbKyTeD+BxEde04JEUxv2TMpy6Z+n98G9stn/vHtN+kpeN3PJtEWgnkvj KO/dsSJFDU5hhIp5qHP6naQaZzsB4yi0/T3PAMbceDNNcKH0RZ5K
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_IRQ is a relic from the old days. It is not used anymore in core
functions. By the way, function irq_of_parse_and_map() returns value 0
on error.

In some drivers, NO_IRQ is erroneously used to check the return of
irq_of_parse_and_map().

It is not a real bug today because the only architectures using the
drivers being fixed by this patch define NO_IRQ as 0, but there are
architectures which define NO_IRQ as -1. If one day those
architectures start using the non fixed drivers, there will be a
problem.

Long time ago Linus advocated for not using NO_IRQ, see
https://lkml.org/lkml/2005/11/21/221 . He re-iterated the same view
recently in https://lkml.org/lkml/2022/10/12/622

So test !irq instead of tesing irq == NO_IRQ.

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
index 95a44462bed0..64a64140c2fd 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -676,7 +676,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
 
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

