Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA275618C04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKCWso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiKCWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EF220C2;
        Thu,  3 Nov 2022 15:47:45 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k22so2970953pfd.3;
        Thu, 03 Nov 2022 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8/+/JIqGhRdWPBU5DgQgVG5PddEig7kZCemfbVVSWk=;
        b=joKcDIo53uF/X/ri0TVqrbYd46qxLzHt1sPTdQ6F4of7rlMLUz2kVuQGx4lj/zZZN7
         MX1ZLFL1Y74ZoPB2U2fdocD/TOdGb4cbMLDmpjGAXiIOBUbsoAjMFPl5/LIT4H+dq2UB
         ft28wtBmK1+aBeXAwo5OwWwAfu9/8Pi10JBxoVgYMCYKQEpJa3Fx0sr2LA9nAMaIsR1H
         TqDwvyOGyqqm52IGJdXbp40JEGl3LEjOwgg4cFTHhfXDipKjbOu21p0xCEDN2CcxW0Bu
         e+oV//qLZBEUlkRyrTc69/4tj69Bh1Cv6hJyWfEHDH8esasjWyhX0e6Yu0QypHSb2FgC
         65pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8/+/JIqGhRdWPBU5DgQgVG5PddEig7kZCemfbVVSWk=;
        b=fEh/uEe9Al73OJMLvkRRLUiCWbOQ3xJYE/CWVFTQ/b5/aiz2F/Fh+5V1PU+VA3vEJ6
         9hOWhLC7Bt3FpasZDnrALjDyIlS4HFHxKJNe88iQDiOb3W0FP5YDQcNOwW2Vx4fdbw5Z
         ZASH32eeNuptBQB3F54OxmdMiLYRkUmkl0kH/eUGvXxMUVEk9UI4bnvp2IYd4v+hUDG3
         K0tbUzkGKpsxLAOM7l+j3HSJi/Vtu9+jgzwnQcqd3A3MtMLGq0WGg0KVWacRcbibKRfx
         Gs08meG5V9Xe2q6r/p9Khf7HbYNo/wV9UVyEURDhRW3u77iR4qYIznjsZ3ieB2eDPldu
         SzRA==
X-Gm-Message-State: ACrzQf1Y+MWELo+bY/9BR/tB0XAbMA0ZMc0DQhQ+xt2068kGcm91g7Bs
        QGGF4ctwSrJa1bDi+3EGMkY=
X-Google-Smtp-Source: AMsMyM5xc8N/TFyejcgTPKHGTjifStmuqApnl4vzp4mPXdiI3ti0O1q8N0M7Fig9UrInNnvQ5tT5vQ==
X-Received: by 2002:a65:6b81:0:b0:461:4049:7df7 with SMTP id d1-20020a656b81000000b0046140497df7mr28159542pgw.593.1667515664355;
        Thu, 03 Nov 2022 15:47:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:43 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/13] omapfb: panel-sharp-ls037v7dw01: fix included headers
Date:   Thu,  3 Nov 2022 15:46:56 -0700
Message-Id: <20221103-omapfb-gpiod-v1-13-c3d53ca7988f@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is using gpiod API so it should include gpio/consumer.h and
not gpio.gh or of_gpio.h.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
index f1072c319de8..cc30758300e2 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
@@ -7,10 +7,9 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>

-- 
b4 0.11.0-dev-5166b
