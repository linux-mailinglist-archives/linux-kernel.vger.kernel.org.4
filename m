Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176A2635F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiKWNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbiKWNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:31 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD526D481;
        Wed, 23 Nov 2022 05:05:18 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d18so8546398qvs.6;
        Wed, 23 Nov 2022 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTRRaT6zB1Vc4HlqkEDiGAACW7hoe/56Dvqt+DM/eCE=;
        b=Qbr4KqFhqpjQh7UgEn30bWcQeFohY7x1t+H1qx+KqZLKnkmfCV79AiZuf0pQJBf0lv
         XKRrAFhsSgxtew9uB7TZA1jvP4uGEoDFlY+YpqDFqARtP0aVs9XJA809aa+GmodzbeWD
         Q9AOvMnGc2YDdki76WTzu8lXalUC2UJNesCgCDTALd5C7/1iBE6akOw0Wx9uJJ3NiSeN
         +4XHvQckhHhjvWIlB/pK0Zt5A8qnTFAdjWJWXhk6YMgpYeNJutpw3v2lErkCoO1jFW8R
         cDMi97tUn/tNNvSO4MNTz+0E8ClgYV3mKqtQ/FxZRHQ7jd2tnFzKv8qwiJgpM+Uuc1xi
         nXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTRRaT6zB1Vc4HlqkEDiGAACW7hoe/56Dvqt+DM/eCE=;
        b=SXKOmKsu8Q/d5DjN3ZFoCuDL6zFN2gIwS/5aazEfVQ1Z914N1R9m0apZmUl+Hkw9pQ
         X+ep5PXf+QbIQn55XbWA5xE/+EeyPBgrMoJSvAr5OUM89GJaB3+w6jn62WzpIVoZC/dK
         S0lmOU+CGihyvuylt8z5atNkrczaacDxu8F6qcvBzvGQdPYapY2m2iBvEHaBcWqe0J8z
         y77JLPY01xwFjkZMlPy2hxCEwkWBbCxqr49HMxkgdDtXsH3W7XfCF1Q6wWWTvPoNd/4H
         srwqKrMX7skZayZjSou9JB6tQf7crLzIznqfKm26TQ8qw6TN8ccfilo9FR0hqrVTzECX
         t1HQ==
X-Gm-Message-State: ANoB5plD6MOfbBMafgemk6cXc7SnPG2s8Pmmf3x9bBBGqIWdSz3Q28sD
        cZf5Gu6jziUw8RVpzccEvXl8zr5lUq1bOw==
X-Google-Smtp-Source: AA0mqf7CC8p5ZhDBRHBE4fOXBYzjcIBPmTnBak6/NBv8c0j4Uliy1HuCPkRFTgA0HRB1u3eHSWCuSw==
X-Received: by 2002:ad4:438d:0:b0:4c6:c6c3:9209 with SMTP id s13-20020ad4438d000000b004c6c6c39209mr2503519qvr.87.1669208717641;
        Wed, 23 Nov 2022 05:05:17 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:17 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 09/14] serial: liteuart: clean up rx loop variables
Date:   Wed, 23 Nov 2022 08:04:55 -0500
Message-Id: <20221123130500.1030189-10-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The `status` variable will always be `1` when passed into the call
to `uart_insert_char()`, so it can be eliminated altogether.

Use `u8` as the type for `ch`, as it matches the return type of
the `litex_read8()` call which produces its value.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Changes from v5:
  - removing `status` variable altogether
  - using `u8` for `ch`, matching the type of the call producing it
    rather than that of the calls that consume its value

 drivers/tty/serial/liteuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 81aa7c1da73c..62bfd2ed9051 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -73,10 +73,9 @@ static void liteuart_timer(struct timer_list *t)
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	int ch;
-	unsigned long status;
+	u8 ch;
 
-	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
+	while (!litex_read8(membase + OFF_RXEMPTY)) {
 		ch = litex_read8(membase + OFF_RXTX);
 		port->icount.rx++;
 
@@ -85,7 +84,7 @@ static void liteuart_timer(struct timer_list *t)
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
+			uart_insert_char(port, 1, 0, ch, TTY_NORMAL);
 	}
 
 	tty_flip_buffer_push(&port->state->port);
-- 
2.38.1

