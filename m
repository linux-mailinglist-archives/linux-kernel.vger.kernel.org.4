Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D335E94C8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiIYRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiIYRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:23:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37A2DA83;
        Sun, 25 Sep 2022 10:23:50 -0700 (PDT)
Received: from vpenguin.haus.lokal ([91.64.235.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzhWp-1pP7rt1ePh-00vgdE; Sun, 25 Sep 2022 19:23:44 +0200
From:   Jens Glathe <jens.glathe@oldschoolsolutions.biz>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96 controller
Date:   Sun, 25 Sep 2022 19:22:37 +0200
Message-Id: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ib8aAaNZUx8RMF41/ytzL4yIwOYo+axTAou/YN4YgJ2Fb3x2L7G
 4pZrztwLyTRJnnRPpmEWmVBDZjd0kn7I2jnSiwMiN5oLnxsUS3GB8LI+XJ51b/8uhT75YTz
 56jY25h6WEYrfWI2a65iXWclFWp2WC+5e8KS1Jtl08tF/EDEQXL8MOhXfXmSTdNDP+mTO1R
 cHut++ZtU4LrS5oEvCpFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OLKIUPcAzgM=:JQN1iSiSHQWUjn+drjSvTB
 /HcjKOK2xHql2li/C5+GTPUZKxykAp6WGyaEKk84XbaZAeC1G9pYL548BI73DEaOwRY7dNfCr
 gYxHaY0rOwH2BIch0B7WjWYDhzGJdUGBrwlikG847BuchvI/nBRisRZ1bLXn0rWmWQWNIXEWc
 SrDARoaFOLE+f/M0rxVHKsFvON+0ymemWGjATulB/d3jgxAPI8Q0R2gSW4UuO/GbWxmtzuk5c
 3yqN7eaaxSrtx/yJasblTrOdVDlG31PriVq97K4Xpi52y1swHoUf9a8I9ZHXh1DGWgQIUl74S
 wDH9Bl/CiyjYY3i7nAMHba0NyitiIJ8ene0QRpgPW9XiamJMrkA1hs6EXYj35o0YvC+BZDnqt
 xACCpyEsmQIjhjVdbudn8hMPRjQlweJxiuMtTO3ra85TuQmzZWYdCMhD/2GbtSHL/z+NnVJEc
 HZgo0GdIdal55RGl/bUJ1evv7uLZbLLtHABs7FVGqNphM/V9zqCPpl0+ong0scv1YLVV4peDG
 VJ+47A+T/vYYjYB6eyWIRqGvsT6aSnaVwy1iDifwX0eCeK9a7dpFhqQDu+PHPPS1L9agLDowf
 jY1nIWno2Y2nQ7BKs3mleDnNxrOJnO3aeVQieOEFTw4apS2CKaX0enys/AGUf+0fqCZOwHdV1
 Eql4q34jBkv3W25uFZXcrIrbFeVCzi5v/zNVvocUmO0JcJhuR8WUw9LYkI2kThB25V9wClkB+
 x1NZkbG0QDZ3xgBGlkEG1CRxWKB42ux1vNxKjbx2T2Rua6Vst5iibrIpNccX5TkDhrW5bvzDT
 Bv6bZZFmgAElY2D3W50LC7RxkzUkQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

only if it reports as a V0.96 XHCI controller. Appears to fix the errors
"xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
often) when using a r8152 USB3 ethernet adapter with integrated hub.

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/host/xhci-pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d34..d1b8e7148dd1 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -306,8 +306,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
+		/* try to tame the ASMedia 1042 controller which is 0.96 */
+		if (xhci->hci_version == 0x96)
+			xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
+	}
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
-- 
2.25.1

---
Hi there, a "try again" with git send-email and the corrected patch. Hope this works now.

with best regards

Jens Glathe
