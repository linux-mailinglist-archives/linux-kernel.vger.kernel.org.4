Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF85FC37D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJLKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJLKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:10:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DEB2ED4F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:10:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso3410897pjv.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztpCIHgkvhln/OrMKVu883eeDMbFeJxlpE1BzP2dbxs=;
        b=jl+gamxZv+EsDuNLl4KHoUfeaLkYkk+Xyml2594t2CtNGNV4e2jn7OAs4ZDkGAbGIJ
         GrP/0jRwisslxV8fFsVg2BJ0l3eIeY+GgY1DgcVcGaV3qbN1mXxVY4jID3M6yfiR/Fnj
         N9kBV7IirzAFnKoZYyIINnfWMy7kIYpCHtymnbbAlpIXg/TCpw2TtLJjOLlzcWAtdQ/C
         5tue7jy5oKuuuUkx61qACVnhXtvp00544aCQPGZt6FCa+C3ig7ciXNEO1jMo5fQS6RyY
         S+CQQ8Xp/U2dWk91t+hIGesyqrJ0sUY33Xp1RjuOk3WoBP/UrXZnRhTUDpuiW2tI8jVJ
         jtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztpCIHgkvhln/OrMKVu883eeDMbFeJxlpE1BzP2dbxs=;
        b=VH734avYP6d1t4+YSDIo8j1INGhX78YhbiH5tekBKno2YvBSgfo+LN5hwVJf1ZCKM9
         Yg55Q2Lilt3jryofgbmkpIFCmI2CdANBr3Br6NjUyvOMP5DOc2aEiKpK8ps0RYI5lIx1
         +OmTRHyeusu+CjB+AL6U+PZ3ri/t83sQP+ErL/SDokZdWSu081SW0BDBRNza+qVJfs1E
         9Qo2mVc9z/CaQ+0ek+sRMeIHr7M4jNK3tcK2dgC4UWe/TrMQhW+vRKJY9sYQQuxuzAOH
         6nOADrDJTRw3f70yXswhQ6EKde4BFOv86hLF19oAxH3D+GHpf+WH9wfsJYjyCK+pN2iO
         BQrw==
X-Gm-Message-State: ACrzQf2AgMY6og9cCX2PdYC0HGmyZUx7J+tMk6C7f8wFVUmcEhBiVcaU
        3QKrorwYG+ZWXDZ+MB8su4A=
X-Google-Smtp-Source: AMsMyM5/PX45mk4v6Mkgu3840ou07a0089WxUk9GS+6HawffTNoXN1ILJUsDm1WvAoVz/GCSHPafaw==
X-Received: by 2002:a17:902:7481:b0:180:58d7:24e0 with SMTP id h1-20020a170902748100b0018058d724e0mr25145076pll.49.1665569405458;
        Wed, 12 Oct 2022 03:10:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y200-20020a6264d1000000b0055f1db26b3csm10532155pfb.37.2022.10.12.03.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:10:05 -0700 (PDT)
From:   xu.panda668@gmail.com
To:     macro@orcam.me.uk
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] serial: dz: use atomic_inc and atomic_dec instead of atomic_add
Date:   Wed, 12 Oct 2022 10:09:17 +0000
Message-Id: <20221012100916.347942-1-xu.panda668@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

There is a better way for atomic_dec_return and atomic_inc.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/tty/serial/dz.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 829b452daee9..84476cef3278 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -404,14 +404,14 @@ static int dz_startup(struct uart_port *uport)
 	int ret;
 	u16 tmp;
 
-	irq_guard = atomic_add_return(1, &mux->irq_guard);
+	irq_guard = atomic_inc_return(&mux->irq_guard);
 	if (irq_guard != 1)
 		return 0;
 
 	ret = request_irq(dport->port.irq, dz_interrupt,
 			  IRQF_SHARED, "dz", mux);
 	if (ret) {
-		atomic_add(-1, &mux->irq_guard);
+		atomic_dec(&mux->irq_guard);
 		printk(KERN_ERR "dz: Cannot get IRQ %d!\n", dport->port.irq);
 		return ret;
 	}
@@ -448,7 +448,7 @@ static void dz_shutdown(struct uart_port *uport)
 	dz_stop_tx(&dport->port);
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 
-	irq_guard = atomic_add_return(-1, &mux->irq_guard);
+	irq_guard = atomic_dec_return(&mux->irq_guard);
 	if (!irq_guard) {
 		/* Disable interrupts.  */
 		tmp = dz_in(dport, DZ_CSR);
@@ -668,7 +668,7 @@ static void dz_release_port(struct uart_port *uport)
 	iounmap(uport->membase);
 	uport->membase = NULL;
 
-	map_guard = atomic_add_return(-1, &mux->map_guard);
+	map_guard = atomic_dec_return(&mux->map_guard);
 	if (!map_guard)
 		release_mem_region(uport->mapbase, dec_kn_slot_size);
 }
@@ -691,11 +691,11 @@ static int dz_request_port(struct uart_port *uport)
 	int map_guard;
 	int ret;
 
-	map_guard = atomic_add_return(1, &mux->map_guard);
+	map_guard = atomic_inc_return(&mux->map_guard);
 	if (map_guard == 1) {
 		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
 					"dz")) {
-			atomic_add(-1, &mux->map_guard);
+			atomic_dec(&mux->map_guard);
 			printk(KERN_ERR
 			       "dz: Unable to reserve MMIO resource\n");
 			return -EBUSY;
@@ -703,7 +703,7 @@ static int dz_request_port(struct uart_port *uport)
 	}
 	ret = dz_map_port(uport);
 	if (ret) {
-		map_guard = atomic_add_return(-1, &mux->map_guard);
+		map_guard = atomic_dec_return(&mux->map_guard);
 		if (!map_guard)
 			release_mem_region(uport->mapbase, dec_kn_slot_size);
 		return ret;
-- 
2.15.2
