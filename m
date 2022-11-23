Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05729635F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiKWNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiKWNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724997EDB;
        Wed, 23 Nov 2022 05:05:16 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d8so12285757qki.13;
        Wed, 23 Nov 2022 05:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0pSt1+sCUSY6i1VSOZXSpAW8agas2OEhVBqCQWzkeE=;
        b=i2QdbtAZ9LbCFHYeYbRIso5E5EOnoY1faYGA4L3aq/Pvv/VFbEZSQa2MQaGqUiWFYX
         JzaOAvY6Z4VUBJsFQzQbwrJe6ZkfKnNXiha3SD97q3yOTjkOYDwnAgViD4pOv3ZbMY8y
         jnKl3Mb9ZesSQa3PpAPnOGKX1Jfhzjl4iJllcz0TJxfv4BdrKhJ7LN5KGy02WYmEnxw3
         nSCGntHxiBgtv5q7kssQq1fGPcDNPjq92S/ZUMemWrJqVcpEpAj6LihIqAR0DQRUqftf
         4hNeTInSkRV2UFCZPHe3TCKcVqs0UifcYhGmHE3FY6jv119150YUE+Yk7NK6G7TNqJXQ
         QLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0pSt1+sCUSY6i1VSOZXSpAW8agas2OEhVBqCQWzkeE=;
        b=BdzH9qUCS0K0I2zAx9QP1iozZ0mzvEeYX45hziC5qSpTKvXl6BCnspHQa0UlTdi6XC
         8KS2wAC7IN4OElC6O8NqNR5PxY89XT4mK3FWJgWDuLKu8do1jrlTkRpH1b8DlkLTdzxG
         KlDZebY7iNKwLudF33qO3Gyax5B8d6BrFFQ0Ut3foPGvWC0u6Hsyl5it7TPRYvEfk2Oc
         MUsFzjARYrbL9JteJkn2Z2PkcpyV20575hh/0FD617e77aKRWQ3fUzCttJfLDvow+ZBP
         pCM5PQr7nH8uR3Yxbq6fh6JY1QC2kj0w63EH3Fp03wWt5lKZej8K5U2uh2vwXsKvKglo
         LYqw==
X-Gm-Message-State: ANoB5pmjv4NQAJwTr8cYcsygdzzfJLyY5n/JeL5kpOljmEn4XSa5I8uh
        6vBZc/MJM2rPo5U6p16R4Xnzy50T9CQwkA==
X-Google-Smtp-Source: AA0mqf4UDArZTgPrgQN2V6SCtxvP8t1r07ayWl5MPGXD0Tvc8yhAtRhB9wB2UQ3Cgo7wIWg7mK5mag==
X-Received: by 2002:ae9:eb54:0:b0:6fa:1e59:4b67 with SMTP id b81-20020ae9eb54000000b006fa1e594b67mr24262875qkg.255.1669208715557;
        Wed, 23 Nov 2022 05:05:15 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:15 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 07/14] serial: liteuart: rx loop should only ack rx events
Date:   Wed, 23 Nov 2022 08:04:53 -0500
Message-Id: <20221123130500.1030189-8-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
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

