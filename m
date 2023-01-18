Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7D67171D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjARJIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjARJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:07:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5171E46165;
        Wed, 18 Jan 2023 00:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F12C6170A;
        Wed, 18 Jan 2023 08:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051CAC433F2;
        Wed, 18 Jan 2023 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674030471;
        bh=WbTFsa9uUp/GVGY/40OGOerWX8P64wmwxJdpH4/nltI=;
        h=From:To:Cc:Subject:Date:From;
        b=V7aUlMB1fk/MekJXOCCs0PVc7h7kscdLWolw8c0WI1wa+OsKN/p6yxqVXnzGJ8JHS
         Uoycpu4Jp3BQQEZKAaEgSK/Q6UY+ktGlvOuFG/Szp1NpTdSQsyX7UCo4e7qfon2KGu
         78vDDd0SXYGxCealFCqVG/uKwJf0pL+FpTSO1tqZQ4m6X3UdHE68ub0TuHWg1/BhIe
         JLdfMCz5kuK9g70CWen7N6kMbwi0mH4D8+U2nH8hvx/MLye9I3kqaBjCd/zAjR1X2i
         7lePDAf9uc90kD3v246r28DG1lKoxbDLWXL4366Xlgwya8yB2y3jL9aiJC1xKsT+GU
         YvfU7u9dsED8A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ohci-omap: avoid unused-variable warning
Date:   Wed, 18 Jan 2023 09:27:34 +0100
Message-Id: <20230118082746.391542-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dead code removal has led to 'need_transceiver' not being
used at all when OTG support is disabled:

drivers/usb/host/ohci-omap.c: In function 'ohci_omap_reset':
drivers/usb/host/ohci-omap.c:99:33: error: unused variable 'need_transceiver' [-Werror=unused-variable]
   99 |         int                     need_transceiver = (config->otg != 0);

Change the #ifdef check into an IS_ENABLED() check to make the
code more readable and let the compiler see where it is used.

Fixes: 8825acd7cc8a ("ARM: omap1: remove dead code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch that caused the issue is in the boardfile-removal branch
of the soc tree. I would just add the patch there.
---
 drivers/usb/host/ohci-omap.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 3d57b9454a27..78088cd46908 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -67,8 +67,6 @@ static void omap_ohci_clock_power(struct ohci_omap_priv *priv, int on)
 	}
 }
 
-#ifdef	CONFIG_USB_OTG
-
 static void start_hnp(struct ohci_hcd *ohci)
 {
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
@@ -87,8 +85,6 @@ static void start_hnp(struct ohci_hcd *ohci)
 	local_irq_restore(flags);
 }
 
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 static int ohci_omap_reset(struct usb_hcd *hcd)
@@ -111,8 +107,7 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 	if (config->ocpi_enable)
 		config->ocpi_enable();
 
-#ifdef	CONFIG_USB_OTG
-	if (need_transceiver) {
+	if (IS_ENABLED(CONFIG_USB_OTG) && need_transceiver) {
 		hcd->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
 		if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
 			int	status = otg_set_host(hcd->usb_phy->otg,
@@ -129,7 +124,6 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 		hcd->skip_phy_initialization = 1;
 		ohci->start_hnp = start_hnp;
 	}
-#endif
 
 	omap_ohci_clock_power(priv, 1);
 
-- 
2.39.0

