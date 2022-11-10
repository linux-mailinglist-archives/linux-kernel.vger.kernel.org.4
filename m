Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF4623853
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKJApM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKJApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:03 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E711A38;
        Wed,  9 Nov 2022 16:45:02 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h21so209507qtu.2;
        Wed, 09 Nov 2022 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9s8/P3zcC35a/7U8wwUtQnHUttoN7Pw9xSfTjSoDyA=;
        b=hbOdGCr/K0H7cTvzahxLz/afXIjxiMYM/7EfCCehv5O3BPGDT+Pfj+2RLo6LdQWP6f
         ORJWdJV6UoxqD/U6Sv/BEXCXhBj4XhOrksXCXxGDeiXmbXsN/lAAHM0d2MtSWhVZ/bxS
         DjYFG5sn/RVkWQ5QWsirOa2PN9Mtsx38qQtPTMaJ4IUd8fJwQeCH8RcpfgPz/Mr5g6Uu
         aaA8NEcrTsqlr6nKr8YTrH8HVnUMCvFZdbtZyqgm68NZ4c/qpli3NUl46PMM8L0a1sGe
         fteOcePpTbsx8DqZqReNv7I+HgIYG6Gz6u3yJ11UGnqTQ0v0gPehmfae251RQztU/Ko3
         gokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9s8/P3zcC35a/7U8wwUtQnHUttoN7Pw9xSfTjSoDyA=;
        b=trFq+DxTV2m+Y+3QPaGDx0rHFzcotDkKwVIKZqmQM50SMgZd87SrWiioH+On07zqXp
         6q4o6g91C8XPBnDnrm/YJAE4EhtBETtJpFLMAwwI24jSS3+/SEU//j2Zaran08DeIZ5e
         hZjsYCfgnZxNLtyGxFsYuFFPfaFyUsLXcxShhWJOs2L1WumGMChFoavsAAZcsqSvHSkG
         8HkUXoTt+u9IgSTtwqUAQyaq0UQWWvUKw3x7S+aXeJTKrszbZ7GppA2QY0pUN8LqOoPg
         J0D532X5UwR6G68WyzsBWDBoYk/UhXvi4ux3UrahpDKrHBz+VHZwc1tmm9QRF4T6O0g3
         5Rgg==
X-Gm-Message-State: ACrzQf1w4Nw7npYd9NkH1ZSEwFgP0ZNpeAguYwu0tZ6m94jnV1ATrtPW
        j76ZCIAyEZDXXTcQmXnP5Gzai7Mf7LA6Ww==
X-Google-Smtp-Source: AMsMyM6gHPLs48WN/5gZ9tskcyoHH0rWJDRGMCxWdUdu9xeiLEX5Qp+y8TFr9YVvvYBP6AaUYbdYsw==
X-Received: by 2002:a05:622a:116:b0:3a5:7422:112 with SMTP id u22-20020a05622a011600b003a574220112mr21434198qtw.429.1668041101489;
        Wed, 09 Nov 2022 16:45:01 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:01 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 2/7] serial: liteuart: use bit number macros
Date:   Wed,  9 Nov 2022 19:44:45 -0500
Message-Id: <20221110004450.772768-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110004450.772768-1-gsomlo@gmail.com>
References: <20221110004450.772768-1-gsomlo@gmail.com>
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
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 32b81bd03d0c..1497d4cdc221 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -38,8 +38,8 @@
 #define OFF_EV_ENABLE	0x14
 
 /* events */
-#define EV_TX		0x1
-#define EV_RX		0x2
+#define EV_TX		BIT(0)
+#define EV_RX		BIT(1)
 
 struct liteuart_port {
 	struct uart_port port;
-- 
2.37.3

