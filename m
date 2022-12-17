Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007F364F81F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLQHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 02:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 02:48:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0032229F;
        Fri, 16 Dec 2022 23:48:10 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so3285531wml.0;
        Fri, 16 Dec 2022 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCuhVA2QnIxJAItrYIuYngYcscicxz+A2JVO1VvMZCU=;
        b=fVaNpm0HO3nfen5vzNgP2ZNXG74nbdiS6u8WUcUf1SJv7ih7u4/NEbBxN4pQ5jB8/N
         GC6PeSLSPyneWpZcKt6kttZVd0X/D1Ak5e7FY20mn0lcDHXjzBxAxyfKs1KYZxahSB28
         hTw++V6jmg/2MU1n1ZFwDGUJIJBmKjX3hTtV0K+R+BL07LBITOWr6DpHsFfs1IHs95AD
         +M3apo1wEBbHsTQdOQvnoRdHmI+6td7ui4tYFuKF+9+8WRey9gasiK7GYP8ULb4KrTDt
         M/LfYaK8lEDVMiWDYCAIdIpMuorr/jM3wFFqNBl5w1iCsNUL6XSP5HNpX7EbT3YtN5fK
         SeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCuhVA2QnIxJAItrYIuYngYcscicxz+A2JVO1VvMZCU=;
        b=NU6vKsRyMR6iFCQhsf6d5u9/HL9X5gjxgywDrLz7E9UoBT1tGZQkqrkrPEbb+UrMgu
         ZsbbvzjIfNDAUiHK3G0Z5cxuNrwC0jCs+PFj+0+ZAXoeT62or/mxnA59W4vAPcTGL2St
         A0Wc8a2+KDxYyBa46Bu+taFhg2WpPACo4Al1V3CUXSWdgl2lSJWi2awPI8A9mh7XNL+U
         NKlgENSbGCvvIZV8iRghV/UV3r6m7+qHrfGua+lJxjgo4bkKV3FWnLKojV7DVDdFKoz4
         3XNUEBWcVqVOaZ7rzWIYApRUaRpQrncTlTp5I+4JCrVyEjOrcWT/6YNqjWy5ibo/0gQL
         ccFA==
X-Gm-Message-State: ANoB5pkOdmjZeGxHsqiDF0raWm+wEoePMfI8eQGRHEJ8UvliIE4IAhJC
        LdiQn5j8P23rPQkiPTunwJIQBZ01ltc=
X-Google-Smtp-Source: AA0mqf4NqcHY0jDhe4xGAhogCnAKfzyMNBPs03tbjCdXeso0tlWjfyuhhZiGMDoHqv0ig9NFBikebA==
X-Received: by 2002:a05:600c:1e8f:b0:3cf:728e:c224 with SMTP id be15-20020a05600c1e8f00b003cf728ec224mr26909481wmb.6.1671263288526;
        Fri, 16 Dec 2022 23:48:08 -0800 (PST)
Received: from localhost.localdomain (188.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.188])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d6541000000b00241f029e672sm4202749wrv.107.2022.12.16.23.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 23:48:07 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: mt7621: avoid to init common ralink reset controller
Date:   Sat, 17 Dec 2022 08:48:06 +0100
Message-Id: <20221217074806.3225150-1-sergio.paracuellos@gmail.com>
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

Commit 38a8553b0a22 ("clk: ralink: make system controller node a reset provider")
make system controller a reset provider for mt7621 ralink SoCs. Ralink init code
also tries to start previous common reset controller which at the end tries to
find device tree node 'ralink,rt2880-reset'. mt7621 device tree file is not
using at all this node anymore. Hence avoid to init this common reset controller
for mt7621 ralink SoCs to avoid 'Failed to find reset controller node' boot
error trace error.

Fixes: 64b2d6ffff86 ("staging: mt7621-dts: align resets with binding documentation")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index ea8072acf8d9..01c132bc33d5 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -21,6 +21,7 @@
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 #include <asm/prom.h>
+#include <asm/mach-ralink/ralink_regs.h>
 
 #include "common.h"
 
@@ -81,7 +82,8 @@ static int __init plat_of_setup(void)
 	__dt_register_buses(soc_info.compatible, "palmbus");
 
 	/* make sure that the reset controller is setup early */
-	ralink_rst_init();
+	if (ralink_soc != MT762X_SOC_MT7621AT)
+		ralink_rst_init();
 
 	return 0;
 }
-- 
2.25.1

