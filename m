Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029D717B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjEaJFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjEaJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E112B;
        Wed, 31 May 2023 02:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B43E563856;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB7BC433D2;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523889;
        bh=u5BHCw7c9M7g8QMKGLXgrokUzyklSa4XXeOrwzPRmkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOTayPMTUC5IapDWCZPn8GTzqMc8BiPGS1mH0c3uaAizcFH/jSo8zqjG5yR3vt8eU
         kFMK7905Hzza74cXMtcBz5hWsFwHFXX2nUOlV1zxKoohrc5BPCfxxDN3NflHFmVxmK
         ZveyIUDOtLGtpP+qCLhePFYSNrN94KG2P5lHeMBFPJmbxgdfsqLO/XDxwbVJvmu7x6
         3A2HrpWjeDe7Ecbkxc3E8/VCFAq8PhW1CabocVvuebbznXeOmIbkqInJLhAEggP15k
         FdXcQke804M75wTN2bQTk0mdKzvt8wVkynGSUIJz0tKjsNege8+nYIWzS8JbJxQe1a
         4zUwGkQNKCrHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q4HlF-0000qV-5L; Wed, 31 May 2023 11:04:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Date:   Wed, 31 May 2023 11:04:24 +0200
Message-Id: <20230531090424.3187-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531090424.3187-1-johan+linaro@kernel.org>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
indicate that the device lacks a valid address but that one may be
specified in the devicetree.

As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
BD_ADDR from fwnode property") that added and documented this quirk and
commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
this flag should be treated as invalid until user space has had a chance
to configure the controller in case the devicetree property is missing.

As it does not make sense to allow controllers with invalid addresses,
restore the original semantics, which also makes sure that the
implementation is consistent (e.g. get_missing_options() indicates that
the address must be set) and matches the documentation (including
comments in the code, such as, "In case any of them is set, the
controller has to start up as unconfigured.").

Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 net/bluetooth/hci_sync.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c2a805ee55cc..ce03038b3460 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4615,16 +4615,14 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * BD_ADDR invalid before creating the HCI device or in
 	 * its setup callback.
 	 */
-	invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-
+	invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
+			 test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 	if (!ret) {
 		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
-		if ((invalid_bdaddr ||
-		     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
-		    bacmp(&hdev->public_addr, BDADDR_ANY) &&
+		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
 			if (!ret)
-- 
2.39.3

