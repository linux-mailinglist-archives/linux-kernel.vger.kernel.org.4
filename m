Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79362F88A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiKRO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbiKROzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A508FF87;
        Fri, 18 Nov 2022 06:55:32 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w4so3275473qts.0;
        Fri, 18 Nov 2022 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUJ4wmyHldmie0gv1i5ed1iRJzoHABMpIHKKor6rIMU=;
        b=RVtZ+axm8f/78K4x9m6u9WdDEV/snwwvJz9dYQG56lAmbBWPx8E4OQHsw/xQfItmKZ
         WCdx3EAm1/TT9laCmVqYWGZv5dx7k0lYgww8spab9/GZeVMoiJf0Fn0csTzulhP16PHI
         WSppyPBpE1gAy0xNBzEMkJQ4mHU7tUn0qVfNfkbq3yE0c/uqDJYdLUdScMzNijAG+ttS
         AXaliMknQ+wUHZrtE2ABhkI5zqHhwRdFXUy9sOOpN/4Xv/kQgpFpbTu24xWfzULaMJmY
         J0Xd92IBfQeBdRYW+iLb1C/lpL516CHqqsE9iNLb9RbmoPjPR5yZhAUT7gZoazlgM167
         wC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUJ4wmyHldmie0gv1i5ed1iRJzoHABMpIHKKor6rIMU=;
        b=RpSSbugdosshtImb8DhvbLYyKmcJFgVGn4Iek1LWPiCvpb2FzLUro4npvD/L6o0Hnw
         E5D85VnDbJEs+nV1W/Uw6v7YndP3D04IYWUqgNSQrFKq5HXJieoNfqNDdbkwpSFpdQzr
         WAvjN1A0PXkQhhzW7m/h8HHfOdkpyyyCcG49mxKYJr+7aGONrzw3+Jo9fCufsTgmyqFi
         Oyo6+4x3GodM7PxY0BRuW5e5Z38gx5GtjZqEDBzW8++YTKV986TOEXdgBt1yFPo0GMfv
         bdQVVMob5GF1zA4Z/4mx82Ee79JKLzZVXuJIgvTyj6XwTmWHTYgeTWRsGGv4/rKxDE1h
         Fzww==
X-Gm-Message-State: ANoB5pmxTsj308MWLIFABheZTD7l3+JQC9XlnY5J3W94nSpDT6DJGklV
        y6HN04J2/jFgbrU5gmHvqdnAdyjKK1w9fg==
X-Google-Smtp-Source: AA0mqf4mAxZoaz5XgUyhod9OTeWR6R06A0Irkl4Z4SoxJ4NChv0llsPfqW7ef35GTXcPub1Uqg5pNQ==
X-Received: by 2002:ac8:6701:0:b0:3a5:280a:3c9b with SMTP id e1-20020ac86701000000b003a5280a3c9bmr6922441qtp.8.1668783331173;
        Fri, 18 Nov 2022 06:55:31 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:30 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
Date:   Fri, 18 Nov 2022 09:55:07 -0500
Message-Id: <20221118145512.509950-10-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
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

