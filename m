Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F294F635F71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiKWN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiKWNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAFCB7EB0;
        Wed, 23 Nov 2022 05:05:19 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d8so12285861qki.13;
        Wed, 23 Nov 2022 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoMIkJU7RvbZZuqzplaT4bBXFPZMXchGTRlt2jCO+kI=;
        b=I+QzPRYCpOeZh/2+ywxlPc/2XDtmrdlAzbocluylrcg7fu31+yAzdvskXCyfskDn6s
         51QCg8Na8xgIQaw0irNIOto8HoK4LCL0vVx7fwODVDzNByYBS/mWWAy3nks+XLEyJ/62
         2f28zTORjWh4XNJHyBTduP2Zgux2aYnsdjOUOa3wmQHSfaMa+17lFLnVPeAYkN5E0sH/
         met4D8CUHTpttDuZNFaTnFfTL2Mx0o/Fl9mNr2QAUeSBiGWt80cBwLc/PSs22yWd2ycT
         /vAVAgyvuixmABgBob/4vifIWMoDQJ82WfboIfbpmIsLXWr0sOQBHTrMYPDPUbECQLH8
         68Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoMIkJU7RvbZZuqzplaT4bBXFPZMXchGTRlt2jCO+kI=;
        b=oOKUASGeT5gUN0XO+CBH1GcGnyfl3p9F9P+zrG3/6e9irCBmTkRCWKhTb53+kbloOw
         TaftU14KabVtJIZ8oKZhxteQHIpu5K9qkt9JPm5gLttrqI/EhHwNhypkorpBezhiwgBm
         JqYm9GgeMlbWd+EEA470Z7sKeOqfRE3AIHawjKvNTIDNV3UjweLWZKScTCCSq0PHgHiP
         maKOcma2C0XvaWYK2fN6VvGGWh2/TB5sAqPcMULRB1StYtIJ+gLUJWKFVPS2TDK9uL9a
         /KACq6g8G6A03kJcb8Od+aHy2sQbDBc7LKkhDzeym22URQzUSemwaHpGzrDhYadH7rpF
         PvVQ==
X-Gm-Message-State: ANoB5plur2lnPN5Chs/Ta9QMC4z3kz3SkZFS3qhLvWVmmxVUUGjkJAPT
        MIXhefTTkjeFvpEEnxfO7TyuWVeOs3WQvQ==
X-Google-Smtp-Source: AA0mqf5fh0yIyZpUY26kyg+Uqg3h/JxhiRa4TPpaFW6Jqu3Nq3hr7oIqmEB5vehFTr4XiWz8WMvJVA==
X-Received: by 2002:a05:620a:15b7:b0:6fa:3f37:5af with SMTP id f23-20020a05620a15b700b006fa3f3705afmr25311630qkk.572.1669208718684;
        Wed, 23 Nov 2022 05:05:18 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:18 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 10/14] serial: liteuart: separate rx loop from poll timer
Date:   Wed, 23 Nov 2022 08:04:56 -0500
Message-Id: <20221123130500.1030189-11-gsomlo@gmail.com>
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

Convert the rx loop into its own dedicated function, and (for now)
call it from the poll timer. This is in preparation for adding irq
support to the receive path.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 62bfd2ed9051..ab6837f3e40d 100644
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
 	u8 ch;
 
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

