Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADC6BAE98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCOLHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCOLGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:06:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613784F74
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso899113wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678878387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFEvCUdnRPRdEAvOdxaVu4SNhrWUtZmDw6TEQufRunU=;
        b=KS43ZTNYzVEwCNAosKlEcPLE7wlEorxUCPylz22zHpjrLp2O32kxKqoGop9phNxZhx
         H7kEJk8Oud8dLYHl8cmHdBD8cahGDK4igm0HgpjevqcdWrJ3HwLCG4YFvpOSzQtn9oTA
         YzJUxM4Xz3vbBzwqs7rset/Xb7HCPzvjPy6p0uKGvOStRzh1jxJN/hO6mj9sM39FzOj3
         XhbGN0NZd8xzZpD1W+wmS9PZplcjZyZGqorTuTyQP//waoX53JVOfPuWp7lkMzgqr5SL
         qVSRXIchxT/l9e/aNeJ/S1K/UTr9gARXQ1r1spczeP6JHW8HAnY/BOFDOy+TUb4H3G3W
         UZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFEvCUdnRPRdEAvOdxaVu4SNhrWUtZmDw6TEQufRunU=;
        b=GYI+e97yE4p0slwUkT0s7Ucm5pnZdM8Hmwnbi8RezkjFFx0g4YMWCOzelu3JdZm+nH
         m4nkZsgOJ6SN4hA8P1TPIKlLaH8EwyqEtcmt0IBCDqS1fWibQ/KW+TF8fNGxtpY/lL10
         AO12auTmdvISF7BbVwuGXGYZy0jglOOcHXdQUlJP1sAXBQXQPgZaxWYtns1rp69iQHtu
         sgkF2eJjGMQclf6lZ22QFwrxce6quHwGtfFDcxF9svidFY1wXI2znY2HCwVtNeZK92k4
         1fhJEsVuqVmV4s2DPq1pa1OE8vhjb/AiAZeGRbZ8xsK682i1N2XXIp4+HUerf3GU92w9
         e9Lw==
X-Gm-Message-State: AO0yUKVMoKf/ydHFFjQh56f+NWaJt83pS7aHUEBi47q92s4mXJ8JGpbG
        KNSpnJuGFyRBPvGu13kwmqC+EQ==
X-Google-Smtp-Source: AK7set/ll9xYlulvlQn3zoOMj/iB3nItXl26a0W0rqBqfwysSjDKqZ4TXo2TG4X9i5+ZRc89+6ogoQ==
X-Received: by 2002:a05:600c:1c0a:b0:3ed:22b3:6263 with SMTP id j10-20020a05600c1c0a00b003ed22b36263mr11335233wms.12.1678878387621;
        Wed, 15 Mar 2023 04:06:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003eafc47eb09sm1460563wmi.43.2023.03.15.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:06:27 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 03/16] can: m_can: Remove double interrupt enable
Date:   Wed, 15 Mar 2023 12:05:33 +0100
Message-Id: <20230315110546.2518305-4-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315110546.2518305-1-msp@baylibre.com>
References: <20230315110546.2518305-1-msp@baylibre.com>
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
index 8eb327ae3bdf..5274d9642566 100644
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
2.39.2

