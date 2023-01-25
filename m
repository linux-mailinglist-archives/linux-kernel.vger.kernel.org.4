Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFC67BB13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjAYTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjAYTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:51:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899D457F6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:51:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mp20so50561539ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EadAaSBIPgk+IhFGEGl7ST9vXs3rcnt68GgP+MjrSEY=;
        b=Rk5M+PVeGH11E491B1aoDw/oKxxuhtw/OFCxkwW809SrHbXB/tOzU5FRR2xZM+QV/w
         0MyCeN4A1JXtDVRtJdh2HDOtEiENmjiSxuSoWftPsy4X3sj4e7XRDNcTGdqpT5ePIvvL
         97GZaqLNIlboRnu7swQMKDnryGNscRfU92ehuz7/tVVNPqlAQc5dNKceeGhd0qiM1BPa
         FFs+UIo7mF4YMnC5Dhx6ELs688A5LNM31fjLxipr7CdvNc3zxMtYjUjgtxMfoYyhhPv7
         Nyz9yjQhPQHCcH5F3VL8sFBWBHW1hZSk6VgtzoSOhqI9SJwfO11reWw0nuOl4RrqmAWt
         /Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EadAaSBIPgk+IhFGEGl7ST9vXs3rcnt68GgP+MjrSEY=;
        b=YgLbkwXP3FOF55/USfaMiuYFHX+ykZXhGcDBbYGTF6nheYzDRfkG6unhGuPxsWruU8
         dNIyXmycKfI4N7I6M6K3rmsPZruWHYwq1OZ4iHeTBWuUJXy5gCDcXiKYXe2QgpA5FF9M
         fdKWJvmYbB3qZnZc5SA1jwz8ue2OaOZJ3iZuwoXcU/f7IZ4jDxf1jeYAza03PSCZSJhI
         uBc0Z7hc/P8dPj6FbM21wDOaUYH6o37giiAomxKqzA8BD/UINWP2sc8JwRuXN4mP7Dyg
         yO2Zsr4XcXltyCBulSpHhF2qPFJMBuWsJFcR9NXaxgQEvrrzZLSm5Xy/TtpqukSMKY/F
         ZqxA==
X-Gm-Message-State: AFqh2kpFr+Lh5FEHLyxokV3WJMEUkrv2Ex9VeJEizkbEuy3T/ud+tpWZ
        /ONl9Fu3IQWqdf3e4ZzWrsO2Jw==
X-Google-Smtp-Source: AMrXdXuaOJXfKYX1K96a1sVEJrFIg+FTI+sLU8LDjXt1W3pCD8pSrvYU7PcTAR25xBblf9jXwYjaUg==
X-Received: by 2002:a17:906:ce23:b0:85a:4230:6743 with SMTP id sd3-20020a170906ce2300b0085a42306743mr33795342ejb.23.1674676268965;
        Wed, 25 Jan 2023 11:51:08 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a247:815f:ef74:e427:628a:752c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b00872c0bccab2sm2778830ejq.35.2023.01.25.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:51:08 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 05/18] can: m_can: Remove double interrupt enable
Date:   Wed, 25 Jan 2023 20:50:46 +0100
Message-Id: <20230125195059.630377-6-msp@baylibre.com>
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

Interrupts are enabled a few lines further down as well. Remove this
second call to enable all interrupts.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2df39dfa309b..a668a5836cf8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1364,7 +1364,6 @@ static int m_can_chip_config(struct net_device *dev)
 	m_can_write(cdev, M_CAN_TEST, test);
 
 	/* Enable interrupts */
-	m_can_write(cdev, M_CAN_IR, IR_ALL_INT);
 	if (!(cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		if (cdev->version == 30)
 			m_can_write(cdev, M_CAN_IE, IR_ALL_INT &
-- 
2.39.0

