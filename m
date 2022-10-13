Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80C5FD604
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJMINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJMINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:13:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6514BB42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:13:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k9so722466pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ch5+32Tspfl3nAjse8cgjSZNdAMlKaOr5BHFnI6rUJ8=;
        b=hyKizyv5Sz154nkuJUT0CxaLvDggdaQ3RjD3kspBDqOaAmnsXdFdzPt3omWexYc0AF
         4dcUlD36dcjD2yhZK6S8FIkU0Ek/V5zDrkfFgokMesqjtPyR+7w0an0EmS4UbuJZ8Lnc
         8Dh7O6eLTbAVCppouIiRte7+TpgTBVOx18wRgOSndgXLTI1FZlT6N1SoiKuMqf4A1zxV
         5/6SbuOSwHZDlKXtnlKfPyziZiwkgVTcgKjSpZ+op5iuU6chLfKQShoR1l62trXC8qEx
         ce6iQ0eh/3rSRIBrwzbsHwrsjbh+LQImbu+jsxvj1LjP3SZDcwKRSZwfXinkhCHquwKJ
         CCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ch5+32Tspfl3nAjse8cgjSZNdAMlKaOr5BHFnI6rUJ8=;
        b=amQsz/iC5+NmUOghZWmCEadiWT7S3w+suskmN2q12JQrJDmgj190+t0YVe6TqVqWM8
         DdLesa567sFgeFbk1ffHdHqjDvFZY/fB09VDmi2kV1Uj8X5QcRYZhDh6ycXFmwHjb7ou
         7a4eHD1/8INoscbNlQ8//JGDW9at+sMIAVxJY6fOteEtYZh5yIeAnHCAhjYRcN9h1a+T
         pV1Zc3UAQ7vcfnH1LdyZeWpbyzQXF2JAY1I+dG8LUkhGuNG9Ncdpu63pbp4gDpcaZOLP
         +3U3Ts3Igzy2bVcLehTYj9JQfCzsH+SIKLkrh0kXzMCsBKpOeK/tOE63Rc5FWqkGs9Bc
         k2eQ==
X-Gm-Message-State: ACrzQf3C5oXwdXdE7GEIaxbS1F+Piy2aJiEhQAwmokCdEzbysqhVgXFe
        ZT8H04TjvDDFOl3Q7boITzE7fIp74v9YJg==
X-Google-Smtp-Source: AMsMyM4p9Kgd4C//RzIf9XnH8pEIxAn+3fanzQmGvK1Xoyi8/ZuBfWGoNbfWlGvq9QFlHicbb0xRhQ==
X-Received: by 2002:a17:90b:1b4f:b0:20d:363d:7943 with SMTP id nv15-20020a17090b1b4f00b0020d363d7943mr10045814pjb.106.1665648788001;
        Thu, 13 Oct 2022 01:13:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 186-20020a6217c3000000b005613220346asm1246445pfx.205.2022.10.13.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:13:07 -0700 (PDT)
From:   xu.panda668@gmail.com
To:     macro@orcam.me.uk
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next v2] serial: dz: use atomic_inc and atomic_dec instead of atomic_add
Date:   Thu, 13 Oct 2022 08:12:22 +0000
Message-Id: <20221013081220.351415-1-xu.panda668@gmail.com>
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

It's better to use atomic_dec_return() etc. instead of 
atomic_add_return().

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
