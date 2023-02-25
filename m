Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E86A2B26
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBYRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FD61B5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677346832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t2xDexvbEpstvAGccLQfRgpoKZ24pDQp0rCGKgyksKU=;
        b=R3UM+yNWcSuxLGVCqFJ48w3LitpXnlIZ1y1VDaxRPz/7n93ozNeGp7yeTnUbMI7CTvuqiY
        XxwlsPOCwbyil9s/2mHsLquZcNLQHUBFjx+gMgjvnrA0dfa7yOjit/VuR/N4uhQzr+OuEs
        hqOQQL/kg/StO0GCiAS/ncEQZs6Dp6g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-xSMlBxtjPEG4eEVBsyoqSA-1; Sat, 25 Feb 2023 12:40:30 -0500
X-MC-Unique: xSMlBxtjPEG4eEVBsyoqSA-1
Received: by mail-qt1-f198.google.com with SMTP id k13-20020ac8074d000000b003bfd04a3cbcso140608qth.16
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2xDexvbEpstvAGccLQfRgpoKZ24pDQp0rCGKgyksKU=;
        b=PXu5j/eNBne7v9cALdCJYiX+Kk9ZzfI8jSbWNt66OL2BdfIJisWth1yZieJex2n/Ee
         YQ1lo3m0DQKxwkZ/IX0cSfCziCQ7M4mxcBdggdYjx748JoN1TPp+xZ+etVGTh8xTrg01
         SZgv79SatJQc964q8geKrRpR+fP5JgVrwlmoQzKsL6PL5ZiNPWQWGpT5IgQhfqRKfzHb
         288pL5ySb5ceXokt3iTxn4go3sNfn0a3gwGKMa5fxo8cf4nNTL2g0REhVvRood5Ak95r
         qr1OgHLI8nVU30jbsA3Zqi1yfsSz25k6z2vPU8axfArZ9OaM/kxOo/JGlSfUjamJ7oTs
         JCRg==
X-Gm-Message-State: AO0yUKU9vOdWGyx23liVLHBH41vnrn1PH7lM4Tvg6bhjM85aEbwatS3/
        MQELcPUmOXm5pgLWjLJX4Yy0ugi8FoxDCsNo8LlX9/+QwoYK2D6H5gragKs0iwLU0V1FQKpxnX3
        ugt8VgqET0rQNwsStcd3Z/iy1
X-Received: by 2002:ac8:5a8f:0:b0:3bb:995c:424c with SMTP id c15-20020ac85a8f000000b003bb995c424cmr7145949qtc.22.1677346830400;
        Sat, 25 Feb 2023 09:40:30 -0800 (PST)
X-Google-Smtp-Source: AK7set99TWS0BHK2q2+GJnqx9jqjSJfve8LytoFQraRhQF8xc5Ljq51BJkPB3eUBld1DDUhQPe4DZA==
X-Received: by 2002:ac8:5a8f:0:b0:3bb:995c:424c with SMTP id c15-20020ac85a8f000000b003bb995c424cmr7145922qtc.22.1677346830167;
        Sat, 25 Feb 2023 09:40:30 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z2-20020ac86b82000000b003bfbf16ad08sm1590282qts.74.2023.02.25.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 09:40:29 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for SERIAL_FSL_LPUART_CONSOLE
Date:   Sat, 25 Feb 2023 12:39:49 -0500
Message-Id: <20230225173949.651311-1-trix@redhat.com>
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

A rand config causes this link error
ld: drivers/tty/serial/earlycon.o: in function `parse_options':
drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'

The rand config has
CONFIG_SERIAL_CORE=m
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

SERIAL_FSL_LPUART should have been selected instead of depends on-ed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 625358f44419..b24d74d389fc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
 
 config SERIAL_FSL_LPUART_CONSOLE
 	bool "Console on Freescale lpuart serial port"
-	depends on SERIAL_FSL_LPUART
+	select SERIAL_FSL_LPUART
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.27.0

