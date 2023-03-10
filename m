Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4C6B484A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjCJPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjCJPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:00:50 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C44613595D;
        Fri, 10 Mar 2023 06:54:37 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id e9-20020a056830200900b00694651d19f6so3019519otp.12;
        Fri, 10 Mar 2023 06:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hDeOhL3khuyGbkCHxGQebu7qrt5FEKqtJ9+s/BvlnU=;
        b=qDwi97pYbhCD1YPf3kNBg8tt77Uec/aP99EaGlQ3Rh5S31gM/31lOiyC8jKRo6E5Bi
         Yqzbppm8uyV0CAOXisfOjj4b4Gnv2pOG79XUZsCUPPxSlupMG1Vl2LdPasRXANiyZBTw
         F4NHxV0Yle/aCWI/+vOgUB264XTT2OdD7+D9CFrlrmr+UG3WTRmbf5Vx1ILvcDa3LK3m
         2uKdo92JN2XwQMuUzsI0KMwE716GcmJm/zGWMvQXu9T+RSoiiBkh0f3aBIVfYyryH77D
         yUukTtH5JpZx9xiiYd5/enN0erYHd1P3r5VUV+yTWH6D2PwO05JxnIn3TOtCCcJML5Bz
         xtDA==
X-Gm-Message-State: AO0yUKUlZk7aeGTp4Me7ebegfZ7ugbrgnq3VFctONyvDADKId8+IEU4a
        YHWJjc7qAg+N+nb4Mxlwft6Vh0YRaQ==
X-Google-Smtp-Source: AK7set9Kc8dfWCFSC8jOGyrkoR70quNRTNX3KTXU7X+DOxxLF7LR7Co3suYswTozmSpcg2dggln9yg==
X-Received: by 2002:a9d:6118:0:b0:694:3972:dba8 with SMTP id i24-20020a9d6118000000b006943972dba8mr10239231otj.6.1678459702760;
        Fri, 10 Mar 2023 06:48:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m30-20020a05683026de00b00690eeb8b436sm101859otu.65.2023.03.10.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:22 -0800 (PST)
Received: (nullmailer pid 1544956 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbus: display7seg: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:22 -0600
Message-Id: <20230310144723.1544930-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/sbus/char/display7seg.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index d93595b39afa..8bee31f03126 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -31,8 +31,8 @@ static int sol_compat = 0;		/* Solaris compatibility mode	*/
 
 /* Solaris compatibility flag -
  * The Solaris implementation omits support for several
- * documented driver features (ref Sun doc 806-0180-03).  
- * By default, this module supports the documented driver 
+ * documented driver features (ref Sun doc 806-0180-03).
+ * By default, this module supports the documented driver
  * abilities, rather than the Solaris implementation:
  *
  * 	1) Device ALWAYS reverts to OBP-specified FLIPPED mode
@@ -44,7 +44,7 @@ static int sol_compat = 0;		/* Solaris compatibility mode	*/
  * omitting above features, set this parameter to non-zero.
  */
 module_param(sol_compat, int, 0);
-MODULE_PARM_DESC(sol_compat, 
+MODULE_PARM_DESC(sol_compat,
 		 "Disables documented functionality omitted from Solaris driver");
 
 MODULE_AUTHOR("Eric Brower <ebrower@usa.net>");
@@ -63,7 +63,7 @@ struct d7s *d7s_device;
  * | DP | ALARM | FLIP | 4 | 3 | 2 | 1 | 0 |
  * -----------------------------------------
  *
- * DP 		- Toggles decimal point on/off 
+ * DP 		- Toggles decimal point on/off
  * ALARM	- Toggles "Alarm" LED green/red
  * FLIP		- Inverts display for upside-down mounted board
  * bits 0-4	- 7-segment display contents
@@ -200,9 +200,8 @@ static int d7s_probe(struct platform_device *op)
 	 */
 	regs = readb(p->regs);
 	opts = of_find_node_by_path("/options");
-	if (opts &&
-	    of_get_property(opts, "d7s-flipped?", NULL))
-		p->flipped = true;
+	if (opts)
+	    p->flipped = of_property_read_bool(opts, "d7s-flipped?");
 
 	if (p->flipped)
 		regs |= D7S_FLIP;
-- 
2.39.2

