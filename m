Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B33661A3E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjAHV5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjAHV5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8877677
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l26so4989946wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQpX0128CCnGU+qDUpUU498cMch/d898rzRC4KudPfQ=;
        b=PIIvrKELxWqdkL8YTQTCAmMKZlufIQIy90RYM0Fadeh7r5M5U6Vggmr9RqD2ZMSJAd
         daQEfhW+p8U4SxDxaAOys5lorDDbNvvDtYke1ae3fxSqj3OqLs1y/KA2hmsZ33Zo948N
         JzUA3GJDETwenqI4uix3TGMwo6Cmwji9TCGZunCQFGzI60+uQT5nAJ90ttL1bs8ksoxx
         TCXRyuuICQGl6yo1CM+psMJc7vQ8nzVjynbilBuLcZGnpIgYGIqWyrteYUypDpTSXfTL
         66KpSKt170HsCPMXGKpxfxSwt3aqX2CDF4126UPW1RAPe8YNsfAES90miOlJsXi30VMm
         igBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQpX0128CCnGU+qDUpUU498cMch/d898rzRC4KudPfQ=;
        b=xwPka45U/zr0aTxO2r/LgfYO3puP7ibc5ZFYf99dBzv1oTS8x+ydWO3tmESb94viSz
         NNVg9nO6U4jB8J8j8v8PQ1a27XiUbNnGEMhlN+snIXUzvYHqSprxWVXkj3pLGlWkfeb1
         HTZ0bEAQ8ymBgASzytn+fsm/EyeKE31n/DQXj49tRRXdripGfc9+lkENndI/axCzWbeu
         NaSsW6l9kHpNVa9D1QeYDUpUM0vRjF+jZAIBCG9omKeby/TDfTf5mCbdoIPGUSvP1Wbv
         hwNVbgneZZLqArVgKpMhe4tt0WCzNmyVMFcE/Aq0wSWKpvU6cRlgO7HOZEl4m15nsQ7p
         lqXA==
X-Gm-Message-State: AFqh2kq7brwA1A14xofZoGd67lDQnjDP/sABFvOLQLiD7eaSWkLXwNpn
        evJlmuv9fFKwzJCuD3q57qE=
X-Google-Smtp-Source: AMrXdXu+icj/lDXOsWDGIAp46Eqa2F49Po0MHSY4gC2kjqhlZ48nHOdUrnU3iNsToSIkMQviPntB1A==
X-Received: by 2002:a05:600c:254:b0:3d2:2c86:d2b2 with SMTP id 20-20020a05600c025400b003d22c86d2b2mr55039647wmj.24.1673215027907;
        Sun, 08 Jan 2023 13:57:07 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:07 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/7] parport_pc: Add a mode mask field for PCI devices
Date:   Sun,  8 Jan 2023 21:56:53 +0000
Message-Id: <20230108215656.6433-4-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
References: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
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

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

Add a mode mask field for PCI devices and use `__parport_pc_probe_port'
in place of `parport_pc_probe_port' to apply it.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index ad49fd356c7b..2928f36e05ff 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2659,6 +2659,9 @@ static struct parport_pc_pci {
 		/* -1 if not there, >6 for offset-method (max BAR is 6) */
 	} addr[4];
 
+	/* Bit field of parport modes to exclude. */
+	unsigned int mode_mask;
+
 	/* If set, this is called immediately after pci_enable_device.
 	 * If it returns non-zero, no probing will take place and the
 	 * ports will not be used. */
@@ -2862,9 +2865,10 @@ static int parport_pc_pci_probe(struct pci_dev *dev,
 			       id->vendor, id->device, io_lo, io_hi, irq);
 		}
 		data->ports[count] =
-			parport_pc_probe_port(io_lo, io_hi, irq,
-					       PARPORT_DMA_NONE, &dev->dev,
-					       IRQF_SHARED);
+			__parport_pc_probe_port(io_lo, io_hi, irq,
+						PARPORT_DMA_NONE, &dev->dev,
+						IRQF_SHARED,
+						cards[i].mode_mask, 0);
 		if (data->ports[count])
 			count++;
 	}
-- 
2.30.2

