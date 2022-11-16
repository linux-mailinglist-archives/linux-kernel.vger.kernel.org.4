Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7A62C165
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiKPOuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiKPOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:32 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2675F391C2;
        Wed, 16 Nov 2022 06:49:27 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x21so11769008qkj.0;
        Wed, 16 Nov 2022 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7E1AL+Zmws98336Eqgx5BGd+1bmMfsNL2UgCg2pcHE=;
        b=ZKwMXYAsBcmAgWdCUpSDxHcOrSAXlYOV7PAff/y6tTwJgXKL2kko/HH+3zquX9d+Sw
         FaHlyQZJgCf41nMo5DShHj+ZzRrxgnmlwpaCfxRqos7D8hyJRt7P9zmZb85iwTa6+6ja
         6+4ofDmcoy8y6nBB+AFYXGTmnF8tqgbYlGPGKQhT2iqEHqvvT++4xBdSPe0xvGfWUra5
         +y0mwVPtBQ5efqDQHPeTf+IU8/m+5bNruvn0r/1xmn0ZvRDvShe2mZT0H5by3tHOcjzw
         jMIKUH3jj9CrJ7IH+aqQUuCdKABzCp97neG+Hq/FQk7KEZkHUVek3a1yfDsMwcGvnJli
         a6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7E1AL+Zmws98336Eqgx5BGd+1bmMfsNL2UgCg2pcHE=;
        b=kHTK6MLSurpldSe2I4UKe7DzZMLB5qTb37Yzw1Z+RO825tgcYCnbNl93U8dOBrCIkx
         4AckTxQ9aFQYNaLo5EnlZPK8mtAcQad9mM8bvfX3YBlYd/ptfs3C81HEn3nG3BBe6O0+
         JHNoAE4BiZrL/bOZOphi57ZdZlwOCbNrxIKN1yipFcq0cUAf/2U0uYkIjAWgWqkgE3xo
         0OZy4xevvoLthIqVMD9msBQ6nD6wlRaRLDs6/NZLpOApDLWGzHgHWzkhXe90hDWkBxis
         Tl3N9Ocj29Do2lnTRi739FV1j4NJ0Owf6EbMw3Vk0kK9ZqSyPYdjYrk5cHHwcqvQKZ5u
         ZVzQ==
X-Gm-Message-State: ANoB5pl5M6oBth7bkySlJP8GjEhcCzGqZcd6GF2ziaIOAmDz97MNK19P
        8n3xUU+tlKGVNde84N4CqqECd4yES8Ds0Q==
X-Google-Smtp-Source: AA0mqf6yroafD6MBCF8u1LTokPl+RPZSCcP5FyT6dyv/clcgiTUFHWjC1bhLTHuM003S3RCkLzaboQ==
X-Received: by 2002:a37:63d0:0:b0:6cf:5fa1:15f8 with SMTP id x199-20020a3763d0000000b006cf5fa115f8mr19666482qkb.748.1668610166484;
        Wed, 16 Nov 2022 06:49:26 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:26 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 10/14] serial: liteuart: separate rx loop from poll timer
Date:   Wed, 16 Nov 2022 09:49:04 -0500
Message-Id: <20221116144908.234154-11-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

Convert the rx loop into its own dedicated function, and (for now)
call it from the poll timer. This is in preparation for adding irq
support to the receive path.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 42ac9aee050a..76f8a09b82cd 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -68,10 +68,8 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_timer(struct timer_list *t)
+static void liteuart_rx_chars(struct uart_port *port)
 {
-	struct liteuart_port *uart = from_timer(uart, t, timer);
-	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
 	unsigned int status, ch;
 
@@ -88,6 +86,14 @@ static void liteuart_timer(struct timer_list *t)
 	}
 
 	tty_flip_buffer_push(&port->state->port);
+}
+
+static void liteuart_timer(struct timer_list *t)
+{
+	struct liteuart_port *uart = from_timer(uart, t, timer);
+	struct uart_port *port = &uart->port;
+
+	liteuart_rx_chars(port);
 
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
-- 
2.38.1

