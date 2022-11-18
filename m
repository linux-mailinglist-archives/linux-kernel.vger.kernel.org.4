Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFD62F85D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiKROzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiKROzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:24 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDA240AA;
        Fri, 18 Nov 2022 06:55:23 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h10so3468997qvq.7;
        Fri, 18 Nov 2022 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc4HY0VxnkrPwWL9SQWES+FDxkDFOlvOrzE7fQZCEi0=;
        b=k/WRK8g2SEfJ5O9BGJ55V/tUDmsRuk+S0Tth9ZspZbygnYVlV+bGlt/eujeVr1Wibj
         WprtDDRss0y3sZJb4vvnelUeql8LflbUiV8JjpaLp6j16iC2/Lx3q5AeYo5z6bJfylNN
         a+QtDK5fgo06thjzayOKfUPE7efXXC9Ibk8C0ucY8xzzj4a7B326HhG1fhehDuJKSaPz
         3a0/5g1Xz6ibqVg3y269dVeBrDD1CK9T4Xxs8//u7w3WvNu7Dnu4ftTmvNziA+SeRCzj
         cC+aB2R+shxZ6yCbS2aZP/W6+Al/ApayA2fdGEGUlfZlqJ4PGVBs+2FdwZIpifkM+JDq
         fq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tc4HY0VxnkrPwWL9SQWES+FDxkDFOlvOrzE7fQZCEi0=;
        b=ocfyJTSENHXUwb/kj76tE5J1hkn3M3lfKv9XPCUpYJ+aA9OeDxH5oEdh7x867dvMTj
         a9Odb1AGcBWinjUGAJ1AOXpsPB4/uvD+2XEoUoFN4bKa8f/fP0xIix3xN5FUKbC0kzEf
         dkj+Gp++I0aje+PmX6HfvzY/vSBqW7Z9muCUMOiE6UpQOh72jI4SWZtmEvmN21uTLmif
         lIjDaEHoueejTNgHGb6mere32hA3f5HCRb2I+XwddR9EUKRp5stBRQt6RE0LBvFBnlf+
         qTNh8qDvj3ivgFptXzeGpHqWAbgEC6cxEWfo6NGk2qx0IZ/v6Z5oSL2QQNHFjykLOVaR
         zTLg==
X-Gm-Message-State: ANoB5pltDe2So82EJ2yH6JV9CTAato1jE1BXxpURs2Wq5qCGGBs7oIZG
        +9gI2p7I2yUwKCIk1e0dKWyJX+Ql/yW+FQ==
X-Google-Smtp-Source: AA0mqf78sohrskn4Ln43QRBtHN0nz00ubfu2v/uIFSq/zmCrtpZI0VC/85WY80x+IFmGlaKB5dQSLA==
X-Received: by 2002:a05:6214:328f:b0:4c6:82cd:92d1 with SMTP id mu15-20020a056214328f00b004c682cd92d1mr6940562qvb.82.1668783322306;
        Fri, 18 Nov 2022 06:55:22 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:21 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 02/14] serial: liteuart: use bit number macros
Date:   Fri, 18 Nov 2022 09:55:00 -0500
Message-Id: <20221118145512.509950-3-gsomlo@gmail.com>
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

Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
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

