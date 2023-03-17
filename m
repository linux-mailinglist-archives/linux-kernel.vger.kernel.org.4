Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EEC6BF353
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCQU6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCQU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0EF72B12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679086641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ueSLYTbczhpfG9NghbRnTQhmVk9+C96iBsuLv5iJJc=;
        b=ijnoWOtKybNXa8SNUUqwjt51FaxF7fDZVoJmQMGfP8OYF5Jmw2GjQoEoqmH5r5NnPtSCh0
        1wDZNpy00Ddsez70jsxWOffyi8SmH4QBEjcJ96/Vef5Urk+hdPmZFBH/jIx8vG6/s8IMzf
        KF84iYUDOjpP8rWw0lxnuvK3A6HBFyc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XTGP3QooNPmccmwMWQKOtQ-1; Fri, 17 Mar 2023 16:57:20 -0400
X-MC-Unique: XTGP3QooNPmccmwMWQKOtQ-1
Received: by mail-qv1-f70.google.com with SMTP id g6-20020ad45426000000b005a33510e95aso3407257qvt.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ueSLYTbczhpfG9NghbRnTQhmVk9+C96iBsuLv5iJJc=;
        b=tUUNGUxLRCt5LAqO2efLqsJA2feIbRQ97CkrA5AOHW8+6qx90TuS8r6X3OJE07k4v9
         FmfDkKtqHCbVzUE4oveIkz2NVvWTHmOLjLcJ3CFf7jRTno7jL994MvuQwcvqSmghcfV1
         bjXNCNQ9OuTnRM2NgXlb10ca4dPkYA6jaTlKLMjjgnEbJdML5QYekqa3/XfWd06Ex0Fr
         moYPQcnJK85u3zn0iz3eFoEUapAx0202ixWkxVQaQYXiMhsNZeI5384TxJ/vvOyhKhwQ
         OwruSt49V8naUH3Vh4+WYHGp1tXZM2+UYKoXWGjisRCdvyCAOzzBLe92ErACgfqVMw3G
         qmWA==
X-Gm-Message-State: AO0yUKUpsF+nYyFn28kA+zJKErtW2y9ss81kqyvlIX5FccPepush2B99
        KzckAYVx/w7pxks+Fo/PgNnAu47F2LnmlEo8Ai7gY69qBZp4Vkl3cYzY0YEMn17kZaB/6x93yr4
        XM9Qti7VOdH62C3LGZ3zOHuIR
X-Received: by 2002:a05:6214:e88:b0:5b4:2271:b42f with SMTP id hf8-20020a0562140e8800b005b42271b42fmr15359011qvb.47.1679086639847;
        Fri, 17 Mar 2023 13:57:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set+i8S89kFUh6Def3I4RhtkIaIaYkO0oKXURsOnZTacJ2FYR4+jckCSLZDHDDsPzEFtMvK2Vgw==
X-Received: by 2002:a05:6214:e88:b0:5b4:2271:b42f with SMTP id hf8-20020a0562140e8800b005b42271b42fmr15358978qvb.47.1679086639567;
        Fri, 17 Mar 2023 13:57:19 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s20-20020a374514000000b00742bc037f29sm2295574qka.120.2023.03.17.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 13:57:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: imx: remove unused imx_uart_is_imx* functions
Date:   Fri, 17 Mar 2023 16:57:10 -0400
Message-Id: <20230317205710.1672232-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/tty/serial/imx.c:292:19: error:
  unused function 'imx_uart_is_imx21' [-Werror,-Wunused-function]
static inline int imx_uart_is_imx21(struct imx_port *sport)
                  ^
drivers/tty/serial/imx.c:297:19: error:
  unused function 'imx_uart_is_imx53' [-Werror,-Wunused-function]
static inline int imx_uart_is_imx53(struct imx_port *sport)
                  ^
drivers/tty/serial/imx.c:302:19: error:
  unused function 'imx_uart_is_imx6q' [-Werror,-Wunused-function]
static inline int imx_uart_is_imx6q(struct imx_port *sport)
                  ^
These static functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/imx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 84bc0e768726..dbb3af4c1a34 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -289,20 +289,6 @@ static inline int imx_uart_is_imx1(struct imx_port *sport)
 	return sport->devdata->devtype == IMX1_UART;
 }
 
-static inline int imx_uart_is_imx21(struct imx_port *sport)
-{
-	return sport->devdata->devtype == IMX21_UART;
-}
-
-static inline int imx_uart_is_imx53(struct imx_port *sport)
-{
-	return sport->devdata->devtype == IMX53_UART;
-}
-
-static inline int imx_uart_is_imx6q(struct imx_port *sport)
-{
-	return sport->devdata->devtype == IMX6Q_UART;
-}
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
-- 
2.27.0

