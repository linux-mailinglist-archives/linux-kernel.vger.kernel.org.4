Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4D697313
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBOBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBOBFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:05:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8531E2C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:04:57 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676423095;
        bh=hz5rOKe4VQZ+XqCbUIp+iT5/yaFWTSJ1mdEhNn7uads=;
        h=From:Date:Subject:To:Cc:From;
        b=j6e7xz8esZrFyyqzp3YqfrorvfVq8/wTJDFHOUD0Suq0QHI4osk4+DahvrTf8p/Z8
         W07PTnwHAqI8x41QPYN2jfhbHpY88B28S2uvT/Z5sAJac4AvRY+kMLMqBJFc5yjaT7
         fx1mIWrIUaJx1Tz2b/qqf701zgU77z7htmo8lMFI=
Date:   Wed, 15 Feb 2023 01:04:53 +0000
Subject: [PATCH] drm/nouveau/led: explicitly include linux/leds.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230215-power_supply-leds-nouveau-v1-1-ea93bfa0ba7e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALQv7GMC/x2NUQqDMBAFryL73YUYlZJepRRJdFMDIQlZYivi3
 bv0cx7MmxOYaiCGR3dCpT1wyEmgv3WwbDa9CcMqDFrpQel+wpI/VGdupcQDI62MKbedbEPvR2M
 mZ9XdjCC+s0zoqk3LJg+pxShjqeTD9x98vq7rB/pdBq+AAAAA
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676423093; l=915;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hz5rOKe4VQZ+XqCbUIp+iT5/yaFWTSJ1mdEhNn7uads=;
 b=9FEUcn2LW1P/EFojrrV42QmouWuH9qjp5h4UOsPwsruYNHccXUQxgp1tOxCvKWLMsfmArNRdC
 tKbpEdcdZLmDgi5Dxk5sefW/gNBb0Ed3jLUArnwxhx91ZreOyDHwbc6
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

Instead of relying on an accidental, transitive inclusion of linux/leds.h
use it directly.

Also drop the forware definition of struct led_classdev that is now
provided by linux/leds.h.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/nouveau/nouveau_led.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_led.h b/drivers/gpu/drm/nouveau/nouveau_led.h
index 21a5775028cc..bc9bc7208da3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_led.h
+++ b/drivers/gpu/drm/nouveau/nouveau_led.h
@@ -27,7 +27,7 @@
 
 #include "nouveau_drv.h"
 
-struct led_classdev;
+#include <linux/leds.h>
 
 struct nouveau_led {
 	struct drm_device *dev;

---
base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
change-id: 20230215-power_supply-leds-nouveau-ff4995ba0794

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

