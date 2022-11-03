Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A0618C06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiKCWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiKCWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:48:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26C22BD1;
        Thu,  3 Nov 2022 15:47:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y203so2974017pfb.4;
        Thu, 03 Nov 2022 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8/+/JIqGhRdWPBU5DgQgVG5PddEig7kZCemfbVVSWk=;
        b=KMS2lx6NjqbbtJBHBQlzUb3ZBXATSCTMYfw1Cm4IXyIJmn0q6jTLJGsCSrmg20h9dG
         9RJdp+UokoXct9v4tp4rgJqDwUZF9llphbcpZ4REl9RjG1A8Yo+x4q26QJly44Q0ofmi
         Ky1J/hC/o4SBr6qGI+bmAQr9EQJ0Dl8Q/QAlrCeT9rWFXaAD8mLoYXP84dCS2PFRXBKm
         C8Y19S0GO0xjPlFOJMSraX8/0hcIHSZ9RzFHL3O1DH7/14hnQNC5ssVjpUqS7x+SeJJd
         mDitZDIi4BQ/X1yXv96mKkTEqhbjAtZB2WRFdFqke2Wl/bM1ecOoqUMy1RnV3qqizemU
         /RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8/+/JIqGhRdWPBU5DgQgVG5PddEig7kZCemfbVVSWk=;
        b=5+K9fVmifIAZu6A7U5k0T6/CCTi6j0q0MoMGN8D4FCZXsprcA3IgohRLr5lCVsIbW9
         spnOITc/MhFaVsRRthZl/rJDDr5zTCXIhxt2dFhFTewkNTlHmIbhwurN9gTAxUDdp8lN
         1xOgjhQ/OD6i5mVdNwJKFSrAxapvzKvMo3LsmXwHk2w7JbxNKd4rHqDuTvm/PXg6BO2F
         tmDzWrf20oB0T0NoFOJYyYAmKAJYJ7M/iEplwptWc1eHj1VPrsLfyOUfT1EBNbOXOfcK
         0LElMBogZcHQiupNWCobMT/Qgi1S/Wev69rR1m7z+42PhYk5F2Jtf4tkBqyxJyKxA15Y
         roOA==
X-Gm-Message-State: ACrzQf0yCgiDgTekfhVd1W7KyLDdHoykpL149KouIfR4Y5Y2mvHrB+HL
        d7y2jl9ROL72Quqq4hS/bhc=
X-Google-Smtp-Source: AMsMyM7vRsjfLECFVoY28KW7UAqPNWwOlMPiT3cgcVY1cs86uQTDBkyLIsXU9h6wGlKH7Sk4Z3XLMA==
X-Received: by 2002:a63:6909:0:b0:41c:9f4f:a63c with SMTP id e9-20020a636909000000b0041c9f4fa63cmr29047251pgc.76.1667515666418;
        Thu, 03 Nov 2022 15:47:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>, Helge Deller <deller@gmx.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 13/13] omapfb: panel-sharp-ls037v7dw01: stop i
Date:   Thu,  3 Nov 2022 15:46:57 -0700
Message-Id: <20221103-omapfb-gpiod-v1-13-8f92cc78ecfc@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-8f92cc78ecfc@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-8f92cc78ecfc@gmail.com>
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
