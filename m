Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C8717B24
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjEaJFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjEaJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249D12E;
        Wed, 31 May 2023 02:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCBD96387D;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB9C4339B;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523889;
        bh=leb2miRjsDRlGjNiyymZl4M2XNI8gihB2Td+2WkayYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CD3K4Aw4orr/W6XMCQQZ+qGzl+BCZTdr63Xdl7m/aMneI/Q2A2UHWw2UeP+K87v9H
         KTNWVZR4ICPiaVDwQRCDlgwVGTVkXyvgrfaiHWeK6tBhKaxXpsR4IxV1YYLBzdL1Q1
         CljJEOyF/JQtZarbO8gaSxxUFqfJDuDcHH7w1x3ugwyMutHdBMtnQp7gPzdzr/lVMg
         X5RSYbAxmb03PqYdH9uJZOzS0Xzp/uRYH96Vo/ME6IKkwyvEA+BY7PLpodLS3iKl1e
         SDTKtlVPEQbaPmboz8y2+0kuKLFsGXgq1atSEvBTslPYiXrIF05ixijLh72rZDXrwN
         8q6purx1CswGg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q4HlF-0000qN-2q; Wed, 31 May 2023 11:04:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND 1/2] Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
Date:   Wed, 31 May 2023 11:04:23 +0200
Message-Id: <20230531090424.3187-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531090424.3187-1-johan+linaro@kernel.org>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
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

Devices that lack persistent storage for the device address can indicate
this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
to be marked as unconfigured until user space has set a valid address.

Once configured, the device address must be set on every setup for
controllers with HCI_QUIRK_NON_PERSISTENT_SETUP to avoid marking the
controller as unconfigured and requiring the address to be set again.

Fixes: 740011cfe948 ("Bluetooth: Add new quirk for non-persistent setup settings")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 net/bluetooth/hci_sync.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0efc2253265e..c2a805ee55cc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4618,23 +4618,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 
 	if (!ret) {
-		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
-			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
-				hci_dev_get_bd_addr_from_property(hdev);
-
-			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
-			    hdev->set_bdaddr) {
-				ret = hdev->set_bdaddr(hdev,
-						       &hdev->public_addr);
-
-				/* If setting of the BD_ADDR from the device
-				 * property succeeds, then treat the address
-				 * as valid even if the invalid BD_ADDR
-				 * quirk indicates otherwise.
-				 */
-				if (!ret)
-					invalid_bdaddr = false;
-			}
+		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_property(hdev);
+
+		if ((invalid_bdaddr ||
+		     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
+		    bacmp(&hdev->public_addr, BDADDR_ANY) &&
+		    hdev->set_bdaddr) {
+			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
+			if (!ret)
+				invalid_bdaddr = false;
 		}
 	}
 
-- 
2.39.3

