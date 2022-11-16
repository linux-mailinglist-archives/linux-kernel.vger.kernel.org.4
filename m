Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173F62C164
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiKPOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiKPOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:32 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F52D1C7;
        Wed, 16 Nov 2022 06:49:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id jr19so10777826qtb.7;
        Wed, 16 Nov 2022 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUJ4wmyHldmie0gv1i5ed1iRJzoHABMpIHKKor6rIMU=;
        b=UK+4W/tZnQ3nJx2fg8CxMw5okEpDI1+RbjMzW+k0vTeDQzjRo9kFVFA4+y6qMvjtjk
         ofKKesMCD7H6VOpH0acPm19dlRhPC0R29sj6VmzG/PmKmXnBd2Rl88FJmCVAREDXjhIF
         8NBXQSMpXWWwv867j3rKzigzm655q6iMz626SZR0unzDlRNVqTKqfZKVqEXR2HhJZzls
         UU0EwSg4Hm4GPdyXXhIMwGUM34MAeWowo+usiruyHxW9gIDNENxtFhiwJRhY6RUUif3d
         pZ37m7EtqH4qKSUDDk03ccF7u0899nB7ZucmDbgDonMPOnzFU5cW+REeNSCWfnF3FIpI
         ptpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUJ4wmyHldmie0gv1i5ed1iRJzoHABMpIHKKor6rIMU=;
        b=ZrWBauAjb8NzP/5urQqGrZ9fyj60LVlEdQMcnn+MCBwTRSL25B3YVDumpn5EJx/hRr
         jBGmJsijXpIgb+WPaYC1Ay0IWG2XVGS1enj+BZe0ryP9szRfc6upxTclvGukKNzrCNtH
         n011HY1jXVcMBrfEuqkjK19gdEoPPRI4/iORBYPt1VpopjnWOGW8zma0Caf7kkLXFb+X
         81nms98sWDRwR9Dd3VfbMc30e7xP0/K2tzz7RcG5Vh0eWOdTSZpF0J3dcmlf9JLH4/zC
         oJACveWivyczUK/+05RbrxDvxdXf/3RfxapBzYJdA4Ng9QXVGkb3gbvBAate9JckFd87
         H12A==
X-Gm-Message-State: ANoB5pmnwE24RBI6bcmQBA47ZM0Bk3yg982ZAHBHMPdl32eAoFkiuj2f
        zXhvg7Hde/BPCBQkH+mxt9i/YqHR/ATddA==
X-Google-Smtp-Source: AA0mqf5AWisHXZFcMr7VRZI1b4RNxrtCidTJ3ZlM8685E46b/XAUGpx+nLWoiCjTE5dwq6sS09ai0g==
X-Received: by 2002:a05:622a:a0b:b0:3a5:4fdb:ac40 with SMTP id bv11-20020a05622a0a0b00b003a54fdbac40mr21241113qtb.268.1668610165509;
        Wed, 16 Nov 2022 06:49:25 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:25 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 09/14] serial: liteuart: fix rx loop variable types
Date:   Wed, 16 Nov 2022 09:49:03 -0500
Message-Id: <20221116144908.234154-10-gsomlo@gmail.com>
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

Update variable types to match the signature of uart_insert_char()
which consumes them.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 81aa7c1da73c..42ac9aee050a 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -73,8 +73,7 @@ static void liteuart_timer(struct timer_list *t)
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	int ch;
-	unsigned long status;
+	unsigned int status, ch;
 
 	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
 		ch = litex_read8(membase + OFF_RXTX);
-- 
2.38.1

