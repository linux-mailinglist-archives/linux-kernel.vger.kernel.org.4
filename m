Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6746071FBBB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjFBITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjFBITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB318C;
        Fri,  2 Jun 2023 01:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9036C60C84;
        Fri,  2 Jun 2023 08:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE418C433D2;
        Fri,  2 Jun 2023 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685693984;
        bh=8wWxcrhAkWwOt1iifMgfXitGD3MNLRHAUz9oHOPbCaA=;
        h=From:To:Cc:Subject:Date:From;
        b=Gu75y8hkSbm1lcT9LawORB3NzdNOniPJuclU5ljMLxFg3ICuBV77DkoVw+lCFwpYb
         a/o/0ZLnHzwTEQ0XDLZr2LC/wgg9vpufzWEXurlXnxekQuosbgRDPWMpH0AXEBVmWR
         lQRvMUGxllhb3Ya5HHmSuKy7bIKoFP3SSB6gy0vY4hBYiiQ/AiiQfM6yOAzko7LyaS
         RyjxOEmPR/uN3cXMNDEyY4bbceG3GiFXzy/aSUCb5dN8Qu55wnZ47vubY2vhuQoy6W
         o47GnHAv4IpmYjtY2k3PeAM9l+xYVwz2M+MspW+6ichuKHgUll/2HK0AW5r8KlfIf8
         a4iiANTcho/Ug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q500n-0001EU-RF; Fri, 02 Jun 2023 10:19:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] Bluetooth: hci_bcm: do not mark valid bd_addr as invalid
Date:   Fri,  2 Jun 2023 10:19:12 +0200
Message-Id: <20230602081912.4708-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit restored the original (and still documented) semantics
for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
is considered invalid unless an address is provided by firmware.

This specifically means that this flag must only be set for devices with
invalid addresses, but the Broadcom driver has so far been setting this
flag unconditionally.

Fortunately the driver already checks for invalid addresses during setup
and sets the HCI_QUIRK_INVALID_BDADDR flag. Use this flag to indicate
when the address can be overridden by firmware (long term, this should
probably just always be allowed).

Fixes: 6ac517d8cf8b ("Bluetooth: fix use-bdaddr-property quirk")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/lkml/ecef83c8-497f-4011-607b-a63c24764867@samsung.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 83bf5d4330c4..874d23089b39 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -643,7 +643,8 @@ static int bcm_setup(struct hci_uart *hu)
 	 * Allow the bootloader to set a valid address through the
 	 * device tree.
 	 */
-	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
+	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
 
 	if (!bcm_request_irq(bcm))
 		err = bcm_setup_sleep(hu);
-- 
2.39.3

