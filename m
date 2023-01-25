Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20A067BB16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjAYTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjAYTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:51:12 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D38F45236
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:51:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mg12so50607039ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0FrFNu+fbId+cNGgF92T8X+IGYNGZVy8euZggQ4zwE=;
        b=DaZ+wzH+2Q3D+0BuJOX48IXhzvKiRQR1S83MMuxEZvJ4b7dw9tTD4fC96gpNbj3ihi
         btCoEOgY+LXjwaGffue1LP6BmeM7yMMNpolZ+1rPnmaJU09AjLxfSy/1uZsavutP/2GO
         8FfFX5JIoKW1uN26KIrUOWloMB+KjElisT4eqkSHGXL+LYnGVvNcQpSQQDGJqsuKjnII
         rWMMUSAccNeWGtdK6MkDrVWQZS84dmeZLHImUH1Yzde0Q7fPYxcnSDNnl7eFgGNEJBYg
         VTWEounuOr9d0Bk7HpcFWcCODFf5GhGe7/ILoknpLkW64/pEvYOMHFlI0MIfnMtWzK6L
         4Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0FrFNu+fbId+cNGgF92T8X+IGYNGZVy8euZggQ4zwE=;
        b=39nQ7bV98XdA7MkZVQbirKq+UxNMfiaY/jxRgN/hpTH/Xt2cs0xvF4WX8jdFSmOj17
         mtSlmx2ycJJH5xfGvIIMlJjH5folZCH4kzy980EmC4hMH7lDvTfPIfxk40ZSG3tZTdpk
         ZaMLqO5vUONVVWRGW9PUxakkLTKxQ/0SwGJkys97xMJlyfbxnbSNM9tVcQtYEb/UxrUv
         eXyVyb17xH3VWxZ2FF2Q0/AO2hZw8skd7TESOu4aXe7stXpXDOO1X2xbgugfQPUITqvW
         hv7+IlBKf4hXkA/55wkZcKL0mMrCgaHJEH02FzMdybN5VnvgrRGU4oIRY/lgR9PEngJc
         +MEQ==
X-Gm-Message-State: AFqh2krJ47gH4bwVWZhPywvG+DsUj32rloBGiQvVn7/EC0Ps1aynqukb
        ymf390fSiKrDAnU6hWuwTvZcuA==
X-Google-Smtp-Source: AMrXdXuCoiOoQssQCdlBDqBVW8pGFeb8MnT5kMUsB6EJVjnplPh+QYEcayQyf+RarPdevAXLyfpa4Q==
X-Received: by 2002:a17:907:6746:b0:84d:1c67:97d7 with SMTP id qm6-20020a170907674600b0084d1c6797d7mr41138473ejc.30.1674676269778;
        Wed, 25 Jan 2023 11:51:09 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:09 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 06/18] can: m_can: Disable unused interrupts
Date:   Wed, 25 Jan 2023 20:50:47 +0100
Message-Id: <20230125195059.630377-7-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125195059.630377-1-msp@baylibre.com>
References: <20230125195059.630377-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of interrupts that are not used by the driver at the
moment. Disable all of these.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a668a5836cf8..ef5ca5d37b0d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1262,6 +1262,7 @@ static int m_can_chip_config(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 cccr, test;
+	u32 interrupts = IR_ALL_INT;
 	int err;
 
 	err = m_can_init_ram(cdev);
@@ -1270,6 +1271,11 @@ static int m_can_chip_config(struct net_device *dev)
 		return err;
 	}
 
+	/* Disable unused interrupts */
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
+			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
+			IR_RF0F | IR_RF0W);
+
 	m_can_config_endisable(cdev, true);
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
@@ -1364,15 +1370,13 @@ static int m_can_chip_config(struct net_device *dev)
 	m_can_write(cdev, M_CAN_TEST, test);
 
 	/* Enable interrupts */
-	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
 		if (cdev->version == 30)
-			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-				    ~(IR_ERR_LEC_30X));
+			interrupts &= ~(IR_ERR_LEC_30X);
 		else
-			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-				    ~(IR_ERR_LEC_31X));
-	else
-		m_can_write(cdev, M_CAN_IE, IR_ALL_INT);
+			interrupts &= ~(IR_ERR_LEC_31X);
+	}
+	m_can_write(cdev, M_CAN_IE, interrupts);
 
 	/* route all interrupts to INT0 */
 	m_can_write(cdev, M_CAN_ILS, ILS_ALL_INT0);
-- 
2.39.0

