Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9960E195
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiJZNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiJZNHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:07:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E84FAA7C;
        Wed, 26 Oct 2022 06:07:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so1439463wme.5;
        Wed, 26 Oct 2022 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxRC9RqaS1c9UqAzgAjR/6HB40jvkl82ja8m7OxvWYI=;
        b=b9CHI4NyN6AJ5o3IRt1rX44jbx9hcjoCG9050hdq7BJLXQTaJmDsPCktJXfbZ1sg6S
         aZMubcJ1MxV9Tl2ebZgpE/ES/ypJp6DGYcWW2rtwvYH8aYfY8TQzd00b/V3OHspGT1r1
         04GNZsdDqwD1rTgDCXEqamnPGENFwD02z0Uwe383xNhfrrhAPLYHfu4zDO88fwkzHuDf
         pWP4nddoqqDuJ+g4ZfIDhWW9jKkIdb7pRgJC0RgNAIgcudRAO3kbOBYvQrx7qQsRU35J
         S5A5VTzeEMYtJ/uAeUst3JUIZWNeCMbWq0loeIwjGHw/TKLOIAT8x1vFJLVpXV5lSpjc
         7tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxRC9RqaS1c9UqAzgAjR/6HB40jvkl82ja8m7OxvWYI=;
        b=4RwFH5cdxLSdsP62kJ2X7f+6dlpOLb9M8mbl/4xrfRmQuGjOpTdwwtt0aNRgIwk1MV
         ve8Mh9My7XeR/57u2msVqeI0iaZ30U+c2WRVXLKapdInesa3Fz7ZeLb40K3xumOz8490
         q+u55qmDHVNSVCNsW07pqeLR8itF2SUiq/hVmGpXYXQE14wwW5ptm5c2ye5G9u0heWar
         j6yNAikdtSofr3cZvODplj+TGF9g+J1CFQPN8fdxnG4nReJXreQyQ3DjXJ7w8PgMyVPY
         nt8nVWO/CTA/pfLLQbbhpDjlPMzAvHlWABynBBnQYopgv7SLFdGW7AkFkoXL0o7H6Vbl
         Hn/g==
X-Gm-Message-State: ACrzQf1PB8HKxq7idpaYXL5ZmXRqAY/4JZHzsz9SPJptZWPc1t2V7U46
        /EZ4n+AKJQ/6KJ+qVkvi0W0=
X-Google-Smtp-Source: AMsMyM4reJ5wMrEmwNg10iO1tCZCR+GX/b7zV+73elxVnOvmcKJhdIg2cgqJLHgdcy53oG7GZKkC8w==
X-Received: by 2002:a05:600c:502c:b0:3ce:794f:d664 with SMTP id n44-20020a05600c502c00b003ce794fd664mr2416031wmr.33.1666789644646;
        Wed, 26 Oct 2022 06:07:24 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc:c67c:46e:319e])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b002366eb01e07sm5245433wrb.114.2022.10.26.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:07:23 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 7/9] media: i2c: ov5645: Drop empty comment
Date:   Wed, 26 Oct 2022 14:06:56 +0100
Message-Id: <20221026130658.45601-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Drop empty multiline comment.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2->v3
* Included RB tag from Laurent.

v1->v2
* No change
---
 drivers/media/i2c/ov5645.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 4438dc91b82a..eea3067ddc8b 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -14,9 +14,6 @@
  *   https://www.mail-archive.com/linux-media%40vger.kernel.org/msg92671.html
  */
 
-/*
- */
-
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.25.1

