Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794E62C152
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiKPOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiKPOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:19 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7FB1839A;
        Wed, 16 Nov 2022 06:49:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so10778389qta.9;
        Wed, 16 Nov 2022 06:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsrpgSLIetjSSjQsdPnxAm+guc7zGDde8lk1A/5OW7U=;
        b=a8l5Of2Om1feIWNCKzQH67SgP3fBhHzdklPrgX75i7Id2LsWRr78OydLo5MG2dNerv
         aFlGof0i7l0Sv0tPuEDe3VdkvN1qzI87+mz+yfuhotVsQApuJHz1cHTSorBnUVeGy74p
         lDJOj5v1kzjejl9JsWAN/kBPQEBXvDA4Jigf7hAha+W1laHl2nsDkUwHta4Qphg6qswi
         KZ6dpaXZjXjPkG9jXwrCQDnnPVeJRpuVosrom6NN9Q3QjNpgChjpMtMPCapbm1pEOcAM
         gw5ns7q9mZwHzMljLuXY7jL3ryU9Hg/hAIgCcDJVRcS3/lFMU+8/wPzSxCWtcyW+axaw
         EXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsrpgSLIetjSSjQsdPnxAm+guc7zGDde8lk1A/5OW7U=;
        b=e3VZjnIonbe88pBizd9vLriqaq5Wubq4mC8l26O6rQc1NQdgpVpbzXq9JydNGLShJN
         VXdx8FW5zyKi1MVZTTZyCCysXByJnjQrovAcRwnsvKgGN5zdZcCKsFM/PVAirEeZYIyI
         IbkmJIFLe8TV8lyAyhVeqzt/IIwTUeCseTqCeMgcUDaa1kzDv0RXfAVffZZWi0cv9cWB
         /93TmB1qIz/YxqxVjJ72o0G8nSOQP3vitrE8dtIYP7N/yXZvjV6ej4unpb68X0AqHrjI
         oQUCCOyBZH0LJ8FlHHgwqyH0mQ5VyAp9DfSgtcSUgt/kXl788jftge76upZ+06t9IHxO
         kr4Q==
X-Gm-Message-State: ANoB5pnMpk/AQQDtgs70utxsTGhlkaFFMMPCKX81UqCuZpV2oRyntpjW
        RpBg5ZzN6EBRoUm5Wy6URpodtA9hEJP5HA==
X-Google-Smtp-Source: AA0mqf53ZeXKburKgJDbQhMWEaXf6mHr24jCuB1k7jYMyRgPjxyWbupdeB4Tj46w5baZaj0lTc8TFg==
X-Received: by 2002:ac8:6b12:0:b0:39c:c865:2f79 with SMTP id w18-20020ac86b12000000b0039cc8652f79mr21165191qts.360.1668610157026;
        Wed, 16 Nov 2022 06:49:17 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:16 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 01/14] serial: liteuart: use KBUILD_MODNAME as driver name
Date:   Wed, 16 Nov 2022 09:48:55 -0500
Message-Id: <20221116144908.234154-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

Replace hard-coded instances of "liteuart" with KBUILD_MODNAME.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 062812fe1b09..db898751ffe3 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -57,7 +57,7 @@ static struct console liteuart_console;
 
 static struct uart_driver liteuart_driver = {
 	.owner = THIS_MODULE,
-	.driver_name = "liteuart",
+	.driver_name = KBUILD_MODNAME,
 	.dev_name = "ttyLXU",
 	.major = 0,
 	.minor = 0,
@@ -321,7 +321,7 @@ static struct platform_driver liteuart_platform_driver = {
 	.probe = liteuart_probe,
 	.remove = liteuart_remove,
 	.driver = {
-		.name = "liteuart",
+		.name = KBUILD_MODNAME,
 		.of_match_table = liteuart_of_match,
 	},
 };
@@ -367,7 +367,7 @@ static int liteuart_console_setup(struct console *co, char *options)
 }
 
 static struct console liteuart_console = {
-	.name = "liteuart",
+	.name = KBUILD_MODNAME,
 	.write = liteuart_console_write,
 	.device = uart_console_device,
 	.setup = liteuart_console_setup,
-- 
2.38.1

