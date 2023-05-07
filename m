Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740886F965D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjEGAzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjEGAz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7DE24531;
        Sat,  6 May 2023 17:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD696147C;
        Sun,  7 May 2023 00:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D99AC4339C;
        Sun,  7 May 2023 00:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419836;
        bh=6KuvJmkPD9TYCnKKgHInVB9V9KggkAJOgw2McvK8LN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YihGOG8jBnIaObyTwqMkyF0vIJXR6uTPNFRQKfBBAGhgePgAeHiX38Hxd3VKBWiSH
         pgHA6l7hvRf24qXTNEj6cbgPf+C3sm6Uqs7MxZLCWy8QKF5veaP+Mdz47WbsYm9kDK
         Biftohzy1+rKvD/QCMgp1U2yzEwkmFeFDYfsfOEjzSpgp3upjRRIF2e4zm+Ua0/Jzz
         FOM3G4WxxdJezj+QMQA5gzrCsuubb0/pztc++ri0AY4fmhF5Hfm7PD62aKWoe8sDLw
         AOwmIy1SSMqFCAcK8OLjT8yE94P2WKeKJHkJ3lhnRshUP9pVla6ZNktneT4ZB7wmDQ
         lJ7pbhY8YviRA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/8] HID: logitech-hidpp: Reconcile USB and Unifying serials
Date:   Sat,  6 May 2023 20:36:59 -0400
Message-Id: <20230507003704.4081392-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003704.4081392-1-sashal@kernel.org>
References: <20230507003704.4081392-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Bastien Nocera <hadess@hadess.net>

[ Upstream commit 5b3691d15e04b6d5a32c915577b8dbc5cfb56382 ]

Now that USB HID++ devices can gather a serial number that matches the
one that would be gathered when connected through a Unifying receiver,
remove the last difference by dropping the product ID as devices
usually have different product IDs when connected through USB or
Unifying.

For example, on the serials on a G903 wired/wireless mouse:
- Unifying before patch: 4067-e8-ce-cd-45
- USB before patch: c086-e8-ce-cd-45
- Unifying and USB after patch: e8-ce-cd-45

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20230302130117.3975-2-hadess@hadess.net
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e2db4731eb825..1588508b3e7b7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -675,8 +675,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
 
 	name = hidpp_unifying_get_name(hidpp);
@@ -819,8 +818,7 @@ static int hidpp_serial_init(struct hidpp_device *hidpp)
 	if (ret)
 		return ret;
 
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD",
-		 hdev->product, &serial);
+	snprintf(hdev->uniq, sizeof(hdev->uniq), "%4phD", &serial);
 	dbg_hid("HID++ DeviceInformation: Got serial: %s\n", hdev->uniq);
 
 	return 0;
-- 
2.39.2

