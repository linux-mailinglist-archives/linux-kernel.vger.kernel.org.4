Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258335EB15F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIZTcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIZTcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:32:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137598A7F0;
        Mon, 26 Sep 2022 12:32:20 -0700 (PDT)
Received: from vpenguin.haus.lokal ([91.64.235.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MowX2-1p2Xnp03iA-00qQfu; Mon, 26 Sep 2022 21:31:55 +0200
From:   Jens Glathe <jens.glathe@oldschoolsolutions.biz>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: [PATCH v3] usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96 controller
Date:   Mon, 26 Sep 2022 21:31:40 +0200
Message-Id: <20220926193140.607172-1-jens.glathe@oldschoolsolutions.biz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J80jwyXT2lu/5lcoR+M2j8vXIcPzZL0+rK1Om43jbxyYtXMO7wc
 5N0xboR4crsVTMb14VhLz+U60gWTGNbPDuOEYF+YXiL3UvbLwR6MIvxNrFHJZ/MaOzI/MUF
 bduve+wl9Iq2kCsnC5vVQS+T6Khzexry/E10K+jpWDbGI9MfPhnYhbiP/U+1oXRPxemabry
 1pEYABOKr2Lgvi/9yh7QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lCSmH4A5rhI=:ysUi3rsEsU09LKbleHdcWI
 zvU7AlzpZCZOqxHXpyk+eDVDcl84OARQP5Ovo5Eou7cTivQCj23glvXEQbyROgGgypQM06gqo
 vHSFUtxf7C78QABQU9R+lnwXfmq1mFkpUY7ktPQra5MN895RWEAQPd1ONVY+SXbAz1LlIXdOb
 H44ZZJJiIGc8eOpGJ7SefSDeR/+NFb59IuIOFIsxt593nUEKH5uUwMTRna77k0JD2kRgUp7Np
 bZ7BbIuUQkdj7+hCXhHEVaG3+1CmGDM73Uxlx641Al2WtDqhGwFR2QFioGRRzhymWCoWl46dO
 ndzr0ijUkyCPO8gNlnflCVIbXZGIi2JjnfyHku5VxYXapNvdATzUAeJRmeahAPMGbPCmgdbuL
 3QN3Co0VSXus3scH0pGbNRYkLPTGzWkD+U6blAAU08s2QE4VF9JuGwJW4eD7/pyPKT7SMk0S+
 fdab5kRjuB6BUHoFjCA5FsJKHCBsSge8k+dkRL5gmzbhFfBx2S5cv/ibfK4BDeF+arXgmke39
 h9pG5zgm/FjkFnKfEaD+d7lQLqhcWe4g2Wudlo1NgfPQ11lEz8JxC1L0bCXLy2Xv2BtN1cOud
 dgBAvCo0ES4Te+RZNpqtkD3KzJcB8b9uY1FJzayWEhvSTs8V7kw8AhyWJL03KydvlqEo4lvBk
 C5XH/sQ/0bM0AEc08b4FDleQnOYqlvTX8oL8vz+2dqMIyKYjltxXhrVlNG0idpm/JbFQU+hsS
 IXRkl629/R+hvTUrVrmAswBXS1O5IXDhp4Wz7+e9fjnvy+zXC0mCxV7sG/b1FH60ONm2Drdlu
 m8jlzYFKDe1wwualQGthaeU9Y56zQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to fix the error:
"xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
often) when using a r8152 USB3 ethernet adapter with integrated hub.

ASM1042 reports as a 0.96 controller, but appears to behave more like 1.0

Inspred by this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/host/xhci-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d34..ef2df1b01168 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -306,8 +306,14 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
+		/*
+		 * try to tame the ASMedia 1042 controller which reports 0.96
+		 * but appears to behave more like 1.0
+		 */
+		xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+	}
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
-- 
2.25.1

changes v2->v3

reworked commit text to specify subsystem, hopefully also a better explanation why
removed check for 0x96 controller since the outcome is the same as if xhci->hci_version > 0x96

