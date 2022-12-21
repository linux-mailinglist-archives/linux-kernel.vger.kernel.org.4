Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F57653347
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiLUP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiLUPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:25:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A34958A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:25:48 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m19so22436963edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyl6rPM+iSY41G/DSGtLfPJHWB9hRIbSevUdKHX4ZAA=;
        b=GsSPSftudTd3Pmw3IFMFhTMSnF8KOi3BBUZmMiQYnxSlQWogruWaFF/4GdqBO28s6Z
         r/aP+jJ0UrYqum+LjfwMuDifjePOXiYmIviOA3sR1tIdUA1vURXafALNfNX6GdidHmSk
         St6i/EH0dL1i2lAz/FFCpsVhMORUKtknkX7qQQAawhXF7TrydTPnyEeMpWI6r8nraDsm
         sjbv+XR1grnnfo4t4o9W9dHHhNaZzVuAnmwax8UuOfdY2T/01CubfHp4G3TGXenFfkxQ
         jN+3pZ8rEMxmn8xygos/0qIhRir42BU+L6Stf866nS7ms8uLBV2jDTznsqoxOvPmMyeg
         TupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyl6rPM+iSY41G/DSGtLfPJHWB9hRIbSevUdKHX4ZAA=;
        b=JtKu2nEaG1dJkX2DXelxlVI5SgR910fioqgOkzdqBnQz7PD5Zntqa2JPRYxSxl65PD
         94sj6gkEnb/Ijp1eTQpgB05UfdJRkbA7VD64J1FLdIz38btCwcpb9YLZmg3SBuyWfxhl
         Z41K0qA5MfDB/Cax1JOmYIhNf3jsd5etKjtxFN89doPTVFFpXzf3dW8FbiRv7RlzYgeY
         FU8LCQDCZx9fwlcADDbKj0Sh9mUp9YUQua1c6ldliqAWsCBjqCq+80r1BzPz8yx3oHb+
         EGwJN/Sw0a2UEs9VwZaLYBJVYRVz7NaUixMmi2GyAxvqWGAB2VRxirXkbi8IfKQFHtXv
         DbRw==
X-Gm-Message-State: AFqh2krVT0TWsKTQ3jeg92stF6SCccQHWsc2YYiHvlVOzvow/tJ0Cbxj
        5tE6DA2gmmwAgdJwj/2R7dxAVw==
X-Google-Smtp-Source: AMrXdXvz4rQNKESMXjGYIflwLunOyQlrYQwTxz8agg9hnarLwPfiaCE+YsWECDTZ0CCV8bYA+bri2g==
X-Received: by 2002:a05:6402:1609:b0:467:7775:ba8 with SMTP id f9-20020a056402160900b0046777750ba8mr2038749edv.1.1671636347131;
        Wed, 21 Dec 2022 07:25:47 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c793000000b0045cf4f72b04sm7105428eds.94.2022.12.21.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:25:46 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 07/18] can: m_can: Keep interrupts enabled during peripheral read
Date:   Wed, 21 Dec 2022 16:25:26 +0100
Message-Id: <20221221152537.751564-8-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221152537.751564-1-msp@baylibre.com>
References: <20221221152537.751564-1-msp@baylibre.com>
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

Interrupts currently get disabled if the interrupt status shows new
received data. Non-peripheral chips handle receiving in a worker thread,
but peripheral chips are handling the receive process in the threaded
interrupt routine itself without scheduling it for a different worker.
So there is no need to disable interrupts for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9749a3248517..bcd3bcdc5123 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -962,8 +962,8 @@ static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
 	/* Don't re-enable interrupts if the driver had a fatal error
 	 * (e.g., FIFO read failure).
 	 */
-	if (work_done >= 0)
-		m_can_enable_all_interrupts(cdev);
+	if (work_done < 0)
+		m_can_disable_all_interrupts(cdev);
 
 	return work_done;
 }
@@ -1085,11 +1085,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	 */
 	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
 		cdev->irqstatus = ir;
-		m_can_disable_all_interrupts(cdev);
-		if (!cdev->is_peripheral)
+		if (!cdev->is_peripheral) {
+			m_can_disable_all_interrupts(cdev);
 			napi_schedule(&cdev->napi);
-		else if (m_can_rx_peripheral(dev, ir) < 0)
+		} else if (m_can_rx_peripheral(dev, ir) < 0) {
 			goto out_fail;
+		}
 	}
 
 	if (cdev->version == 30) {
-- 
2.38.1

