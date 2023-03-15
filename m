Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEED6BAEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCOLHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCOLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:06:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A884F67
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:06:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m35so2734415wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k88g/tLODmL/T9qHyAnmUHflunm5no0E2q2FXlPGb3k=;
        b=iZKxW14RgsUryqrI2nACouoY4HQvKFciZnX+mzVHzb7eZV3v+LaHyKH6USAN/IZzTa
         5wAVzBLUhv9sOWCHw0z6fwn/24ZvPbn8W/HFQEJZ4UIfjuSR8E+Tim2vIAPXenbZhbiZ
         NF4Jbsy7kQC1hPp04+n2TDP24eYex0b0+D1fX6ah5B/35LvyaYuYu5Dn0ghC+1W/7Sz9
         YSdHSqymvR1SzogEzO3nuIsqe4s2LgO1F3YqJwXND+mollBw38h8Qb6C8X06YaIxzODx
         Ylj30ZPDF9xrTAPLrv5kFEo1jW5DZG5w3Q/gfl0xzG54ZUXC7ZdRTnbN5/GAvPqvXQGb
         kvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k88g/tLODmL/T9qHyAnmUHflunm5no0E2q2FXlPGb3k=;
        b=x/SiM20yDSt+Hc42yn/g4lzQ7vPDYo03jlsgxEnmk6UalALWEuE7pDbXQtltmir6yC
         RMBg+jHgoTiPf+ZRfKp71ItO4qVHDgISnBTl57R9HbY3dBzMvKeYXqgBb81zT3wH2TNU
         wg3FxfNwapo2hQhqlOA8XlZxxmojWXU4npGfOLy5+G7U8ih1grmx+fRMlTqSUZRiLn4T
         laCld7lzXoDQWYVnLR5V0klwZJpMFX4Ff6kNIbypDgoeqeHt6kitNFBddKqUOwp+RGQN
         pDvGAz1GB5U0Au6FmUxVG4srPOX5XM19d6XUG59UTUHhx0nITLQIR9wzSS1hJ9ppcIrV
         96DA==
X-Gm-Message-State: AO0yUKV5Xa8sSPhvEhU8+wLv57N/1KMWbvTtG+Gjbhlj83LPDwBgRJF/
        Sdb/o2PHnt7O8WsKKX86V/k0MA==
X-Google-Smtp-Source: AK7set9OEiPWeCHIekkBRydqATpfDPgRDodkQ7ioPXNwRE2S8Ngk9bzqpWT3kHN0f36l9jRTxpUD0g==
X-Received: by 2002:a05:600c:3107:b0:3dc:55d9:ec8 with SMTP id g7-20020a05600c310700b003dc55d90ec8mr16335974wmo.41.1678878386783;
        Wed, 15 Mar 2023 04:06:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003eafc47eb09sm1460563wmi.43.2023.03.15.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:06:26 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 02/16] can: m_can: Always acknowledge all interrupts
Date:   Wed, 15 Mar 2023 12:05:32 +0100
Message-Id: <20230315110546.2518305-3-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315110546.2518305-1-msp@baylibre.com>
References: <20230315110546.2518305-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code already exits the function on !ir before this condition. No
need to check again if anything is set as IR_ALL_INT is 0xffffffff.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 563625a701fc..8eb327ae3bdf 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1083,8 +1083,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	/* ACK all irqs */
-	if (ir & IR_ALL_INT)
-		m_can_write(cdev, M_CAN_IR, ir);
+	m_can_write(cdev, M_CAN_IR, ir);
 
 	if (cdev->ops->clear_interrupts)
 		cdev->ops->clear_interrupts(cdev);
-- 
2.39.2

