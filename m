Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8462C15F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiKPOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiKPOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:26 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698372E9DE;
        Wed, 16 Nov 2022 06:49:24 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id ml12so12068039qvb.0;
        Wed, 16 Nov 2022 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0pSt1+sCUSY6i1VSOZXSpAW8agas2OEhVBqCQWzkeE=;
        b=BWmkADy+pa4FoNb6SR2sVqHODzqe/raSSVOBjqVntv9+B75MvCutUtPgQLlxjYQ2tD
         jkHfi2ZdCZQ9bWASl5dg3ea+PNon+WClGeIDWlNAFxwOYn1wU43S508gaIqCDD/4r+sM
         y7DIk/d6ucGoXCm+jHYnfuNOhY7t3BgUs8Ja51saTD6gm7Liez/1LnlX5OkK0D0/TYZb
         a5yJe1DBE1OGniPw7uutN/w4afmjaKlWwDsdn0vk840ODL4AXm+HzL0zTpaYmlEY5UuR
         OIitmDV3E38KjlY40QC/BSGZ3PZK/DZ7I06ML6ZYzZihHueyRYAlnu9VvkD8zzGa/EKq
         SAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0pSt1+sCUSY6i1VSOZXSpAW8agas2OEhVBqCQWzkeE=;
        b=NqDiWDW3RWDQWm8Umm1C9A65363GJ4FybnQcJUEsBFHmn9W8p1ukzc3xZjoEaE+eRY
         fciCj3jubCSP6A61LYgujCSZNctVPzvcivEh4ws+CsmKbqxHqTKGxES79HKLeJpYKv5i
         //O9FMuj2iFyI8NHNwY9P6q4EOpKkRJKhIapa9iTTc2qEVUDeQxfcgIEdJs+myb+M4P9
         K6f8Ya6QyCF9JgG9xCOzb+N6y1t71y4XjST0Xl1XsDHihPEghi1fUZMd3bTc7yRH/GBX
         vz1XGl6bGuADr23g+Ko+Pl46bLCogN9lPSUZwws/eQTITV3LNPdYD7zJlwWoYXTuFawU
         OgUQ==
X-Gm-Message-State: ANoB5pldyZXaUu88ymFPwfX9hg/JVqb27mVLQZT05IIS1XeZT3XqORy1
        VlVBCT0rSpvZ+NxzjS4aCYC6fXvodvyylQ==
X-Google-Smtp-Source: AA0mqf5qOBjFdAixbyShURlAgcZ8nNWfDbCPG7kSqX6TVljbXTfXF43OUmq2gutGHbPfq07eWjtr7A==
X-Received: by 2002:ad4:450d:0:b0:4c6:5a5f:3063 with SMTP id k13-20020ad4450d000000b004c65a5f3063mr6790531qvu.4.1668610163228;
        Wed, 16 Nov 2022 06:49:23 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:22 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 07/14] serial: liteuart: rx loop should only ack rx events
Date:   Wed, 16 Nov 2022 09:49:01 -0500
Message-Id: <20221116144908.234154-8-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

While receiving characters, it is necessary to acknowledge each one
by writing to the EV_PENDING register's EV_RX bit. Ensure we do not
also gratuitously set the EV_TX bit in the process.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 81a86c5eb393..c90ab65fbdcf 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -82,7 +82,7 @@ static void liteuart_timer(struct timer_list *t)
 		port->icount.rx++;
 
 		/* necessary for RXEMPTY to refresh its value */
-		litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
+		litex_write8(membase + OFF_EV_PENDING, EV_RX);
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-- 
2.38.1

