Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC849635F64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbiKWNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbiKWNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:28 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD4B7396;
        Wed, 23 Nov 2022 05:05:12 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c2so416307qko.1;
        Wed, 23 Nov 2022 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrcGx075bBAUt5Jsu4MjR56u5yyB0ACS0/ryRhT/vi0=;
        b=Sd6WRAlMOF0RMw0SWShDWnZYt/cfx2EmgXW9Fpi/V/mDXL5A6I4LIxQXZYICLEJoXX
         RkcfLs7db/C5oyAVuXS4vhHjJu8nqC2NCAC1CrqSbMnG2BxwfYbAsWBjMD2Y6DqPKdU2
         /9KyDeHQu0fVyjpBkeiiL95WdYmm9F+ufpFmaN7fiYSMbT3ljkNifH7+vUOa6zVYUIAV
         tMWtAVCp5wuSmPrmy2mQaB7JX8H/KOTri1f1FWh5miBM6x18DfyfaZRUv8jSniY0huNE
         IVKlR4RkWyTBISGwleNNal2wOwqAV6MIZPb348tvmOyeOqj6SWc2tp84R4PeaVrZYvL+
         td3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrcGx075bBAUt5Jsu4MjR56u5yyB0ACS0/ryRhT/vi0=;
        b=Q824KUwANIP+fObuP1PXqQBVcyVeGhIbaZ95q3Uqjz++1Z9CJJQ7eOacfSjgBdwV4Y
         3pHcSvoVgX0e+kIRCKgXYkEp3kqTyjg1YZpZrY8FauZZWOkSu1JcyTmP5JzUnI/XMbdV
         ZxU2zRSN6QVnpJkq+blMhbTMF9SB9A84rKudQuQ2UxYyoVtvLfN/JRn8q+LuP1R0aJop
         BWbE+Os43UstJ1nsyHliQYJoODT4TjVQWFxqlh/I+9aWU25l5BaoxdrWAdVgV+tA069q
         xIEa2Y3vjYQopZxQFFLEExSAFT1eKb8VhhOKca65olFWXsatw8DDB+IhVTaGw4gVMWFt
         Jfcg==
X-Gm-Message-State: ANoB5pkISjV+lD8tfY949lhgP74AaQAU9wcTqjm3PGGQFsf9BDgwfS5E
        wC9FZiFs0Q3AEWQ8XDwVg8xZ1pOBpZNELQ==
X-Google-Smtp-Source: AA0mqf5f60U5GEKDKKFMIQNNdpOkbTbrRpBk+DRpnmAtLNq34cql/9PtaDIcdYURl7/qpAoTqdNr0w==
X-Received: by 2002:ae9:e513:0:b0:6fa:7d46:33ad with SMTP id w19-20020ae9e513000000b006fa7d4633admr24792185qkf.278.1669208712178;
        Wed, 23 Nov 2022 05:05:12 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:11 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 04/14] serial: liteuart: don't set unused port fields
Date:   Wed, 23 Nov 2022 08:04:50 -0500
Message-Id: <20221123130500.1030189-5-gsomlo@gmail.com>
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

Remove regshift and iobase port fields, since they are unused
by the driver.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
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

