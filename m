Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA53702147
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjEOBwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjEOBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:52:51 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFC10E9;
        Sun, 14 May 2023 18:52:49 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6436e075166so9027331b3a.0;
        Sun, 14 May 2023 18:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684115569; x=1686707569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0suyFxCmAkOw6AgMCfdjO1B28V30GfAoapR+6WV58I=;
        b=OWhOypm8sxtjsZm9jbpMnB4BlqvtXCDdVUKO7z03JZjsn6PZHqqSZ28JlPYfN24uSF
         7c35jCI329y+7IRkje29eoQ7kQQuT0w//v69zvZG5+6hE6/Buwf655X9JrmsljcRnUZt
         U9Jnu76Vtu3k6foGNgxyVkMfAfXEohoytF0j4HhP482aSm6cEMjQjSvlp/30OHtJYkam
         KxO2PxILVeduTuPOa5MDDvn9oYYkq10PCndhc3Fv4FGvHlShnxdD/OYVHL+SwcYPRgqc
         WPb9hNB6MDEjkFSXjskRpKRREC2U9HseE3J4cDRMeEuegQCw0gSTrQN6eXCTlh/3GUj+
         cL3A==
X-Gm-Message-State: AC+VfDx0Ipv63mV6Rn7rxWB/dJNX2hreLBML6MFEZVGU1pc+C7e8/9MU
        eNm9luyf1BjXFchkYLgibZYVgE5HT88=
X-Google-Smtp-Source: ACHHUZ77Y7418OU7UeRduhisRYiaujYGLlK5fknTtsdDWxJ1NZMWrG5aO3zQVDFP/bIHFE1Jf1AOGQ==
X-Received: by 2002:a05:6a00:cca:b0:63d:5de3:b3f2 with SMTP id b10-20020a056a000cca00b0063d5de3b3f2mr46671589pfv.18.1684115568733;
        Sun, 14 May 2023 18:52:48 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78e01000000b00622e01989cbsm4274138pfr.176.2023.05.14.18.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 18:52:48 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v2 -next] tty: serial: pl011: set UART011_CR_RXE in pl011_set_termios after port shutdown
Date:   Mon, 15 May 2023 09:52:40 +0800
Message-Id: <20230515015240.38565-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART011_CR_RXE is set in pl011_startup() during normal initialization, and
cleared by pl011_disable_uart() during port shutdown.

You can use a none-console port in poll mode like kgdboc does with
tty_find_polling_driver() after a port shutdown. But pl011_startup() is not
called in tty_find_polling_driver(). So you need to set UART011_CR_RXE to
reenable receive function.

Not sure setting UART011_CR_RXE in pl011_set_termios() is a good idea
though.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v2: fix a typo in commit message and add "tty" in subject

 drivers/tty/serial/amba-pl011.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d8c2f3455eeb..c5c3f4674459 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2166,6 +2166,13 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * ----------^----------^----------^----------^-----
 	 */
 	pl011_write_lcr_h(uap, lcr_h);
+
+	/*
+	 * Receive was disabled by pl011_disable_uart during shutdown.
+	 * Need to reenable receive if you need to use a tty_driver
+	 * returns from tty_find_polling_driver() after a port shutdown.
+	 */
+	old_cr |= UART011_CR_RXE;
 	pl011_write(old_cr, uap, REG_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.34.1

