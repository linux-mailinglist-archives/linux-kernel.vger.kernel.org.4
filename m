Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BF6535BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLUSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLUSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:00:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412724BC3;
        Wed, 21 Dec 2022 10:00:00 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671645598;
        bh=DHzQpmWJLFTqwBAVXLFg5D5O5N+Kl9i3nR9nIThPLww=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dYAO+UHzW5wXut+nOIQHrC2wo6lmHyElQIRI3ngQoD1uu7CGf8qlsuU11Z4T3bNDU
         alABiGCHrlwhXIGV24XZjLqysz9C7LwQ0mB2zJzSZ9lEzaw/IiNkJ/QGMg8Om7bF5u
         MzYWEsN+/qotALjcBkMA/v+TsnGD9T4r8+LQ2AtM=
Date:   Wed, 21 Dec 2022 17:59:51 +0000
Subject: [PATCH 3/3] platform/x86: asus-wmi: Don't load fan curves without fan
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221221-asus-fan-v1-3-e07f3949725b@weissschuh.net>
References: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
In-Reply-To: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671645591; l=968;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DHzQpmWJLFTqwBAVXLFg5D5O5N+Kl9i3nR9nIThPLww=;
 b=0lNvk6oQrIRPYyinJtYvmunAkwZDHlhbE8W8EwaIJNnKGwRrg5brZHoLaHbTFN06zZU2Gr/kS68z
 hJdfJkugBqlv/GytiG5L3tHo39rJBGxTFp0+6Zwuxe3AG5+AOJog
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not have a fan it does not make sense to load curves for it.
This removes the following warnings from the kernel log:

asus_wmi: fan_curve_get_factory_default (0x00110024) failed: -19
asus_wmi: fan_curve_get_factory_default (0x00110025) failed: -19

Fixes: a2bdf10ce96e ("platform/x86: asus-wmi: Increase FAN_CURVE_BUF_LEN to 32")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/asus-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4a289ca7e76c..104188d70988 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2438,6 +2438,9 @@ static int fan_curve_check_present(struct asus_wmi *asus, bool *available,
 
 	*available = false;
 
+	if (asus->fan_type == FAN_TYPE_NONE)
+		return 0;
+
 	err = fan_curve_get_factory_default(asus, fan_dev);
 	if (err) {
 		return 0;

-- 
2.39.0
