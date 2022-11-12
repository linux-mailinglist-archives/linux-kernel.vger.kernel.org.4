Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6832B626BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiKLVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiKLVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:41 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B715A1D;
        Sat, 12 Nov 2022 13:21:39 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l15so4874485qtv.4;
        Sat, 12 Nov 2022 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj3jgN94Up18U7wVvpj0Zgp4+ZbcXYE4CuLEGeta7KA=;
        b=hT5YiZaCxVZ1nPy9zMoXb3qQqnPNsZ7o9pju+19OsVVMRh096IvhsGw3wrI3WyLprx
         qdPk33wgAo8ELhrFTjh2rJ6nwlND9hL1trHMue0kGpziwDe/aXDdF5A2OAztsgcbx0KP
         Devs53QoRNOxuZgtr9LpArCBscEp1EFIfWc+Wyv3CtrjVMAZaawDoetYCdxvKkAIXK+p
         9bltTnJY5s/ewqlCSBZchvfwRncppJ3X2Q13ZUWTkSl1J1V1hikyiJ7EuSqzDPfs6J42
         fk4qATFyjlt2NIP+fFBwR1ezjd70Ex5775RmWUNZKvqFjJYSuQJMGm3sO+iqGRD2Oco2
         2lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj3jgN94Up18U7wVvpj0Zgp4+ZbcXYE4CuLEGeta7KA=;
        b=esRuAhsIkXxasbv3VU+/CPPofmVzwoyrT/cBYNwuG1l0SpbpwmrQwVsv5YZwFv8Kw6
         Dx1rD15Y3z4JMOB/7pozgKyzADyOOM8ptoM3ziK93ncBMae2Gg57FgwzkabPVPo+DvMg
         S3v4SzG4nosa8KPjigJKEg10yGTaqGVs2sOVD9aN4hsUMDRDZNGn8z9x7NxFIRgM9o8r
         PsDyChdt2w32tlGISkXUf2Tx7BKSI0vYykpapOmaywcVi22C50jp4Lsn0J58pkomD4VE
         8SeZ5l0VDM28AVPm+4FR4bxNVkkgxdPqN6EXi4uRi+4xUcwekd8Y+RodIwQzqWV5FIae
         8oyQ==
X-Gm-Message-State: ANoB5pnrD9wbFNQv0L+A565zHMdQeLMGTE0WMvhSeuPQYqcjgRnRvxZz
        VyNcmTzY6vLVGV4DgOvyeA9W1LnBTwAYHQ==
X-Google-Smtp-Source: AA0mqf776Ls7iEIplNJANnecNoE8bcN5Xr/bW7Ap/UWRiwTpsId1B0vgXlwLHmLHMKf0ePUo0KQbfg==
X-Received: by 2002:ac8:474b:0:b0:3a5:177d:d9cb with SMTP id k11-20020ac8474b000000b003a5177dd9cbmr6770535qtp.64.1668288098440;
        Sat, 12 Nov 2022 13:21:38 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:38 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 07/14] serial: liteuart: rx loop should only ack rx events
Date:   Sat, 12 Nov 2022 16:21:18 -0500
Message-Id: <20221112212125.448824-8-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221112212125.448824-1-gsomlo@gmail.com>
References: <20221112212125.448824-1-gsomlo@gmail.com>
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
index ff3486860989..b5ab48aa35cf 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -81,7 +81,7 @@ static void liteuart_timer(struct timer_list *t)
 		port->icount.rx++;
 
 		/* necessary for RXEMPTY to refresh its value */
-		litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
+		litex_write8(membase + OFF_EV_PENDING, EV_RX);
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-- 
2.37.3

