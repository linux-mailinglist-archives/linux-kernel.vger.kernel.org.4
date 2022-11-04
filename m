Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83D2618ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKDDTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKDDSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:18:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018B26133;
        Thu,  3 Nov 2022 20:17:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so7052205pjk.2;
        Thu, 03 Nov 2022 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6PAgha9awLqLasM2SZBLhBWQgufb9o8aM2Y2mLLZh0=;
        b=Yc66T/C43UfEpUcqxFl5/KtvvWxdKjjseUpHDw3Zky+25MC+fBsWw2ozPEZuES4kvK
         HKE67+vkfo9MYjWn+7/ot3l9RHt6HWq1g7/9WytwbtBrriBjNEViAnnsvPwvnyQgrP/N
         KF9Ob5cfsOPDPIsbZdBcjxjKdFE1q5m1hx1Va8lO9Am8eqiLwFDmIXE6upHp94Bcl9TJ
         gjrtAeuLLuAXpjO/5XengO2wiWYdw4kMLpOTWdEOoNIxUgAy+y8VRp9cioPjm/5A96oS
         Sir2Y38f9lQg6EjePLvvUIGCq6iF/dPvghZWbisu+x0NDR0CZe2gB1mIjjYxowyYTbOe
         DSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6PAgha9awLqLasM2SZBLhBWQgufb9o8aM2Y2mLLZh0=;
        b=4HWBcsXBCOTfqmpFLLVTmSPM1DU5fTC0yUOljRHlSJ/CpLN0QZxZm4lGv7QWTzSG1A
         VxRZexK2Mm/0O/q4WqfAaY5uV3GtsKrjuMUwygpcUiGKlJmBMdQpzJyim6le64pREz+i
         V04DvPkfcqLhf7XhAtECm11uog1uKxDhGLTa4j4U7HGSwQ5KC9hyraWVKIueqUSsFVIu
         Jk9HGjYUDwHPCi/+B+Rq1LGhIMN55d00mJyLTYgcv4EBT2njFcwiSmoZdIrV9tWMRDaf
         OZcTEX9jBoQfgaWxEJrjPfPgPZ/NcKGcR1KkOBP4r4Nm3NbwvzehOyh5n5ced3qQLCs9
         omBA==
X-Gm-Message-State: ACrzQf2a4veNfdFWpf9gxKv9ekRHyXlqM81sXagEoJGGPWZtwqmNQO5R
        wWftkIDqwEnJHuuViUzYM6w=
X-Google-Smtp-Source: AMsMyM64tXvt/mZih/5xOGONanOKPX+R66cULAJlCmjnRjUYkHYQrQu4rLsZLjxE/l1ilhdz95A/NA==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr52794390pjb.164.1667531830375;
        Thu, 03 Nov 2022 20:17:10 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:17:09 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 13/13] omapfb: panel-sharp-ls037v7dw01: fix included headers
Date:   Thu,  3 Nov 2022 20:16:42 -0700
Message-Id: <20221103-omapfb-gpiod-v1-13-cba1fae5a77c@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
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
b4 0.11.0-dev-28747
