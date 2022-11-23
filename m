Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78001635F62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbiKWNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiKWNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:27 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F974A82;
        Wed, 23 Nov 2022 05:05:11 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id n12so6018203qvr.11;
        Wed, 23 Nov 2022 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK3JqJNT1I4j3gkX/C8zdj1X4u6J0EiKkU/hbVHbrx0=;
        b=bEquYI4pYdgUZm/tUjpiXKrZMvQdc3GYF3xl4vhVZLv5yLR5iTr8raOMfb89s+vbHq
         7P7uevp6iJYAiCWebyIT6vGh8HawknY6I6O7IOLdv3rDmPpnTdVcEgZgn5eRzfxYfOUo
         eaFUjmZ5Qs0XtnO99CI5I4JHTKdLPSEWtwjoleKpPmZyWqyyJv3hiwU5rIgVzmqpkf9T
         w12AiVNrpltc46c8FPTyba84dWNTrSQQ2bbihzs+kta2teqPghl2l6fJdzts2G75jn45
         Hakq1lHENj4TzBH4iO4/65GMqWjXF8B6boyRxy5yMPvkl8/RwvVWdc5im0OjPjLL3FdD
         auGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK3JqJNT1I4j3gkX/C8zdj1X4u6J0EiKkU/hbVHbrx0=;
        b=xuou+rzRoP78Ch8feNUyVDVGkIHSyZMBvAlZXONyoG9yi0co1q2SiOj+/vGgKn7EGD
         sNFLd5ctYcu+2uT7406yrznoxkSGOOCjZUtDmMEVaaIclSJhb82rxDmgCotA5jK0iipt
         MA2vaXJl8Orv5FhULvi4cxRxZbdddWmzYZ5xMuONsQ/oVxn0kpQeyzQLSzzJV8WbVnvw
         n0BWH5lBpjt7JINWW6qNvVxmIbcBpGVJeV8kt9qE6JyfSWIt594zBqprDiffXI8CSLCv
         ajp6bxsyE1MTzWEJb8uu+K2GCzoO3qI/4jARJFwlHHOoe0IIv5hx5twBpKu7vAIZ0K71
         1MVQ==
X-Gm-Message-State: ANoB5pmDA1B0tyOVUsbXnjwbLnssS4ywT9+cHyvDApOTKAreqQbZkeAN
        ZCToMfC3AkKQ19zsJDFiYmJ3dnQX+0kWKQ==
X-Google-Smtp-Source: AA0mqf6IRO4TgUF8T0Xk+YL/cCQPdh4DF5+3L/BNGdALphrUzwsRNvPnRHYn5GJGFi6jeFLxIgxZ4A==
X-Received: by 2002:a0c:edcf:0:b0:4b3:fe67:349d with SMTP id i15-20020a0cedcf000000b004b3fe67349dmr26126307qvr.60.1669208709841;
        Wed, 23 Nov 2022 05:05:09 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:09 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 02/14] serial: liteuart: use bit number macros
Date:   Wed, 23 Nov 2022 08:04:48 -0500
Message-Id: <20221123130500.1030189-3-gsomlo@gmail.com>
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

Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/liteuart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index db898751ffe3..18c1eb315ee9 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
  */
 
+#include <linux/bits.h>
 #include <linux/console.h>
 #include <linux/litex.h>
 #include <linux/module.h>
@@ -38,8 +39,8 @@
 #define OFF_EV_ENABLE	0x14
 
 /* events */
-#define EV_TX		0x1
-#define EV_RX		0x2
+#define EV_TX		BIT(0)
+#define EV_RX		BIT(1)
 
 struct liteuart_port {
 	struct uart_port port;
-- 
2.38.1

