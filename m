Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761BB6A321C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBZPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 10:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjBZPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 10:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A006520576
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677423912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oP3oPuchm6C78y0w7FcABuS+2qv7jrRkSYqeHoyGogM=;
        b=EFyqWWn6TboWgX/FvVOJqQTgBljeMvOKtOak7aL4KuqQJmoAZ2gPkdermCNiZajuEURIoW
        N4YrwPI3lK+FjkfOROaS+bB/l8X3i7cODNcLOgG6ZM0829J0V/F0hV1h36QDVQh88D2mP5
        nj3vqdBItxd/gKoMNJDbXnV4dUNLrTo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-siEkVi1SN0y5ELi2tsttoQ-1; Sun, 26 Feb 2023 09:54:47 -0500
X-MC-Unique: siEkVi1SN0y5ELi2tsttoQ-1
Received: by mail-qv1-f70.google.com with SMTP id e9-20020a0cf749000000b00571f1377451so2119575qvo.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP3oPuchm6C78y0w7FcABuS+2qv7jrRkSYqeHoyGogM=;
        b=6hvRrInv+oMFzb6dz1uFTg5pd2ijD07JJNyVLxBswNA5PL13b3YXIcB11YOHTm914E
         99+uxqsM4gRB8Lwz7vhppZNoSxEDmGl5j4DtN/r93uPT0QUHia06C05jKx8CNv8H45u0
         bF7vwO9CFibOf8esj+DNaiVdw1AeDLlRQuDxR1a7ZhOL02Nt/qhL/KKMsVV43e2eJRP+
         m64zoQWP0TAYGO1FHOBaoHHCUK5VWkfj5SY4mno07grP0IqLMeCRbnh42SGnescqlILP
         xfIwY+6//iGXwpi9dpqXOBg0TwBevHAUTzmRbaLfc5DTrzHNgpZY/o/Zt+VUCainueGG
         X1Dw==
X-Gm-Message-State: AO0yUKXGe5ulMcsTEb9698AbkUbNKdacNdZSdNeIScnrEro6U7PYZk0p
        npmvU4b4G0j9N1HGJCU7nUUfI315RehCG27XKz8Pzgd05hjiZiEwr2ID9Q0QZN30bUfnPrgV+FG
        9GgFL3kkD9RsXfctnK8ENSfHC
X-Received: by 2002:ad4:5bae:0:b0:56e:957f:dd5f with SMTP id 14-20020ad45bae000000b0056e957fdd5fmr35934662qvq.50.1677423286584;
        Sun, 26 Feb 2023 06:54:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/Dvnqu/AWuG3VmERieiYOLTpNGZ6BWRhVKDWe6qiHzJf2eI0ns0naoQAZr4A3CqW7FmHsMRA==
X-Received: by 2002:ad4:5bae:0:b0:56e:957f:dd5f with SMTP id 14-20020ad45bae000000b0056e957fdd5fmr35934643qvq.50.1677423286344;
        Sun, 26 Feb 2023 06:54:46 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f64-20020a37d243000000b0073ba46a585asm3127203qkj.64.2023.02.26.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:54:45 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for SERIAL_FSL_LPUART_CONSOLE
Date:   Sun, 26 Feb 2023 09:54:41 -0500
Message-Id: <20230226145441.3150640-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

After applying the configs are
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: Add how the configs changed to commit log
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

