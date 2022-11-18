Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDD62F869
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiKROz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbiKROz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:26 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E510D8FE7B;
        Fri, 18 Nov 2022 06:55:25 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id s18so1875993qvo.9;
        Fri, 18 Nov 2022 06:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYR5NsE6sy8TKuNQHq0fl0E+u87DDSloXcW16PVAy78=;
        b=G9tTwOupRAJgQot7o/e3aZbJ2VlrhFzVvSQJqfH5Xr3X3zIYmwia13I6H5GzRQnefQ
         TuSpAuBcT2U8k7sA7YEGEH4w9eGmqkt3imQWrMvxHxjPT3W0zlEFLOnGbYWOy9P6GD9h
         VDsq6xfyShlnmr1YnPvDZQxTSEFTaUYwnkEGoL7qQeEhtKEylRBwvY+MLd1gD1zmxitj
         yKjG0ePTf7T2vvlHl0jiD3tSRGr4ugdqgprzwkTj2n0tdPUHHcKNcNaE63h6+nAKsdLX
         sx31au5oly+kwHDCfPDSKqRTRSth7HtIlgUhlQcyK5IqYTXLPPXotQnWH8xc019aVGqu
         NC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYR5NsE6sy8TKuNQHq0fl0E+u87DDSloXcW16PVAy78=;
        b=36xi7fgtUtLKs86iT55nizMa+K5ULXmEbDaRdkTVS6etRvnikAPF2PWv3lYnms3w7w
         6ZzPQdhf0q9FkQLv7OfEbPFgdRQ2kjU08YA24vd97Y7ntEIcc6ILU4dw39OEJawZqUll
         cKbMxYsTlihGj5Vi1uaAR4QAOO5XjeMTlyd6z5Lpq1CXSNiCi2zzcHO7swRkc3yCVDtA
         Ld6SefbE9RrTjlbTUvhkZ7EpOL3sxId1ow0N0jpDuFB5oJsRXygk9OgHp453UMxwS2Bb
         CbIn0tcTy4RcaikWy25MP9uv/SO27Kt8kLt5lFTM9nEiGnZynjCYRZ8Hae5oGI2HJntg
         5vCw==
X-Gm-Message-State: ANoB5pl0XF1FVxpthUf2U8UIK7+tZRqnm6KZ++kXznTnDCPKIwwS8c7J
        g/jZy+iDhuC47FVF9NJyc6o/VqauV3dp3w==
X-Google-Smtp-Source: AA0mqf6D5aiuwLmpCua5WQg7pPXYim+HcVMJ+HCr/SS7TMCuMhYlJ7mlJVkf5lzEKb9eKCiOZyiJ7A==
X-Received: by 2002:a0c:e70d:0:b0:496:6092:9f0f with SMTP id d13-20020a0ce70d000000b0049660929f0fmr7059215qvn.32.1668783324777;
        Fri, 18 Nov 2022 06:55:24 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:24 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 04/14] serial: liteuart: don't set unused port fields
Date:   Fri, 18 Nov 2022 09:55:02 -0500
Message-Id: <20221118145512.509950-5-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
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

Remove regshift and iobase port fields, since they are unused
by the driver.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 989a4f8d5bd4..c6eb7eba5af8 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -263,9 +263,7 @@ static int liteuart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->ops = &liteuart_ops;
-	port->regshift = 2;
 	port->fifosize = 16;
-	port->iobase = 1;
 	port->type = PORT_UNKNOWN;
 	port->line = dev_id;
 	spin_lock_init(&port->lock);
-- 
2.38.1

