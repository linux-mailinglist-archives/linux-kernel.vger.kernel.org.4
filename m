Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B85E5F86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiIVKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiIVKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:12:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309AD62FA;
        Thu, 22 Sep 2022 03:12:45 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BA06B40003;
        Thu, 22 Sep 2022 10:12:41 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, foss+kernel@0leil.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Date:   Thu, 22 Sep 2022 12:12:09 +0200
Message-Id: <20220922101211.3215888-2-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922101211.3215888-1-foss+kernel@0leil.net>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This event code represents the firmware source to use at boot.
Value 0 means using "standard" firmware source, value 1 means using
"alternative" firmware source.

For example, some hardware has the ability to force the BOOTROM to load
the bootloader from a secondary firmware source (say SD card) instead of
trying with the standard first and then the secondary. This event allows
the userspace to know which firmware source was requested *in hardware*.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 include/linux/mod_devicetable.h        | 2 +-
 include/uapi/linux/input-event-codes.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 549590e9c644..009e71376a61 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -326,7 +326,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x10
+#define INPUT_DEVICE_ID_SW_MAX		0x11
 #define INPUT_DEVICE_ID_PROP_MAX	0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index dff8e7f17074..8cd2b58c81d7 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -917,7 +917,8 @@
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
 #define SW_MACHINE_COVER	0x10  /* set = cover closed */
-#define SW_MAX			0x10
+#define SW_BOOT_ALT		0x11  /* set = alternative boot firmware source */
+#define SW_MAX			0x11
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
2.37.3

