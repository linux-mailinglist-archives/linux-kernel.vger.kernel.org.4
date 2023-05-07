Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324336F95CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjEGAiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjEGAhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4722CD17;
        Sat,  6 May 2023 17:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D45A5614FC;
        Sun,  7 May 2023 00:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91597C4339E;
        Sun,  7 May 2023 00:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419704;
        bh=MZJ2JwlXV8zGvhVnxDuxi244EYHKpQcGwxk41dx1clw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWsp88RZIAmUSp9xlzDmZWHI9wssFa7rrfXwQri9c6SXNYrAZyKgjRzmTCCUi37lK
         HK3iu92AB3sZQjEfCWuW7RY2pYkZZ/XCpfdQEgIQYk4wG2zpVlSO2ppuZVtM5vGgf9
         lf2bGroPH0SVPfGtBby5vl0FkIK13RgK7GXk5o8AV6DM9MfC89D1wiHxcmP4U9dT4c
         y3pwW2+tu0giwxmh+UTVRMAJLmNJTPUal7PO+D03rErsagYOlFkFexDK9k/Zm/OteS
         Stk0S11ctyakXChA2E4ukS1zQGrcIwNVPO9RGpJS7lcDpAsn9nJrDXDex0ImgFPNeB
         RCG46f4yNOwFg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/19] HID: apple: Set the tilde quirk flag on the Geyser 3
Date:   Sat,  6 May 2023 20:34:12 -0400
Message-Id: <20230507003417.4077259-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003417.4077259-1-sashal@kernel.org>
References: <20230507003417.4077259-1-sashal@kernel.org>
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

From: Alex Henrie <alexhenrie24@gmail.com>

[ Upstream commit 29e1ecc197d410ee59c8877098d54cf417075f7d ]

I was finally able to obtain a MacBook1,1 to test and I've now confirmed
that it has the tilde key quirk as well:

Product    Model  Year  System      CPU    Shape  Labels     Country  Quirky
============================================================================
05ac:0218  A1181  2006  MacBook1,1  T2500  ISO    British    13       Yes

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Link: https://lore.kernel.org/r/20230404024829.13982-1-alexhenrie24@gmail.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index f21b1c4ca8254..37b2ce9b50fe8 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -854,7 +854,8 @@ static const struct hid_device_id apple_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO),
-		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
+			APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN |
 			APPLE_RDESC_JIS },
-- 
2.39.2

