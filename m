Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18BE6287E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiKNSJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiKNSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:09:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A8DF55;
        Mon, 14 Nov 2022 10:09:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5so8054993wmo.1;
        Mon, 14 Nov 2022 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izOCkbsm9IKKzQ3UFw4KGD8+VGBrn84t2S84ESpJtYY=;
        b=IO6lxxcT/1ZMxCQLSut5/xGerOoJDNos6w+RcB8b9iIJ1px/CAUH1YTtayE/0KKviD
         cZqKoJ+9B8XFMIfjbU2So3dJim8ABf2WWxgZBVcRJJuEDcjt9onD6+8ieQxKOiySG974
         p03+dppDU7wmUTJ07ZzoyUTMhFyF7udjYYYD1eGJjZcm3PYFKleaHx5yTtduGIcwLrXg
         wDgeI9WKoM5lEkT/zrz/jOCZ8bbx7m2Aoyjytp+Zn/RLQ2sqalB07zkAx5q/7XE2gYvQ
         wrhzGXPwQfN0K4mAeccsrkZ9UM3p6978xUU/UgexKfE0jQXAG2UBfG0I7vXq5uNYo+1W
         5H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izOCkbsm9IKKzQ3UFw4KGD8+VGBrn84t2S84ESpJtYY=;
        b=kU76GsKgQIveVG4pL8PfbgAVcRjORBkdyxg9M0ssPSGkAZ5I+vTwgKe/t+eAOYPNV8
         vHpNyIl0bsqiJlXYi4WeemzmEMug4tGcLx3EQHWkH7vNxAWggQAovaxXJ0IA0HkZoH7m
         JfNFt3Jc17Y5Y5ayKGEnwwOuKYx/ouESYRna0UtP8Ng2kes8bBxyNmDme82tYvyj5qXi
         kCJzqonqSqJhFBwNvhSwVU56mUminKLv1ABJrEQ21cZbduc0dnPgDVpj/XKRbopPnGPV
         vXyruJ9++BFLskYtG4ei9Z3e83TLhSEF9TNtGvpavUP5jQUWVWS/it9qG4b3H7oETxCN
         VFhw==
X-Gm-Message-State: ANoB5pkbBs+5VoNRPe8qm3VymaJZG3cIa2U8h7xYZggRF/OU50A/c6IF
        nWpE2/eLDWDZyqExJ33BH+s=
X-Google-Smtp-Source: AA0mqf6eNLYPPDk1VLzVi1G2DqC0HaHhFvoJ1CX1fV+TbwWezgsqq2i4NCGCo1ODMJ0TX+g0DScR1w==
X-Received: by 2002:a05:600c:348e:b0:3cf:e0ef:4508 with SMTP id a14-20020a05600c348e00b003cfe0ef4508mr2865356wmq.84.1668449357162;
        Mon, 14 Nov 2022 10:09:17 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ed66:fe24:8268:500])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b003c71358a42dsm24380771wms.18.2022.11.14.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:09:15 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
Date:   Mon, 14 Nov 2022 18:08:43 +0000
Message-Id: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/Five SoC it was observed that setting timeout (to say 1 sec)
wouldn't reset the system. To fix this we make sure we issue a reset
before putting the PM clocks to make sure the registers have been cleared.

While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as
we were calling the same functions here.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note,
- This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
- My initial investigation showed adding the delay after pm_runtime_get_sync()
  also fixed this issue.
- Do I need add the fixes tag ? what should be the operation PUT->RESET/RESET->PUT?
  in case we need the tag is:
  Fixes: 4055ee81009e6 ("watchdog: rzg2l_wdt: Add set_timeout callback")
---
 drivers/watchdog/rzg2l_wdt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 00438ceed17a..d1271cc7750f 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -115,16 +115,14 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	pm_runtime_put(wdev->parent);
 	reset_control_reset(priv->rstc);
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
 
 static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
 {
-	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
-
 	wdev->timeout = timeout;
 
 	/*
@@ -132,8 +130,7 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
 	 * register so that it is updated with new timeout values.
 	 */
 	if (watchdog_active(wdev)) {
-		pm_runtime_put(wdev->parent);
-		reset_control_reset(priv->rstc);
+		rzg2l_wdt_stop(wdev);
 		rzg2l_wdt_start(wdev);
 	}
 
-- 
2.25.1

