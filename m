Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB816A3340
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBZRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBZRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8937518B08
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677433140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i/hpLCH1J1OZC0aaq8N5qErte4jZaIcaYpEnIIPJejU=;
        b=frfmgJnmSUoLV8ygg0s0d5Sq/mv11O8vZYXCSO8itEleZlSczpk3ni1YLdWMG3fnBsAhBF
        SC5jA8gyV5Y8w7CB/Wa2NOBbs5vAeu8CEKI9ZGLfLVCF+l8K6a23ry2wDe9Ouasga0VWgd
        p0RVVJ1BnzpN8up7gHgeLEg+q4xcmPs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-eL5GCYFpOwKk1teM2tGIeQ-1; Sun, 26 Feb 2023 12:38:59 -0500
X-MC-Unique: eL5GCYFpOwKk1teM2tGIeQ-1
Received: by mail-qk1-f199.google.com with SMTP id e14-20020a05620a208e00b0074270b9960dso2716761qka.22
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 09:38:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/hpLCH1J1OZC0aaq8N5qErte4jZaIcaYpEnIIPJejU=;
        b=G06vj9IsP8teyRtalWULErcVFfBGh5Zs1WnMgU0Noz0ab9K+n0IBGUfZp836yYOx2I
         6XMRMQ8ns7Rw/k+aZ0nIacwYOSrFCdRz6SU9ZcVWI9WD/HSjjvVwxymxv4ap/x917r6Q
         MZ7+gbxTTIMzkmQeiOtbi4LJeatyGHGu15Qj4G2shr+ieWpqJLb+dsLSROuvpO0pyqPQ
         oBpnZQwZ9IVdCWTGqB47Qc2uCkjQ1rh8GICcBSyYdNINdPm4B09fwgURYIqFsFfsHHc9
         JW7hGfhIIpAeJUMSeu0hbU3Dj5+nI/q43J7G+YADoJGxYuk81efGu39V/gwH/K2wZvxl
         0qlw==
X-Gm-Message-State: AO0yUKVrcU/RAimd80bEjxPzPQm8vK1/QiPrqIxeTrt1N+OCJ2irNd56
        74C+QLIiyF9R8lcg25S+CDbID+d+ACv5C/+8wq2ouK+7YIWpP8WbAqdKU6Z0dhB2b10yET+cj7Z
        myLL349nDTF8/BgpSqcYKhyMz6T1qgQ==
X-Received: by 2002:a05:6214:400d:b0:56e:f1fd:f16c with SMTP id kd13-20020a056214400d00b0056ef1fdf16cmr10742453qvb.20.1677433138670;
        Sun, 26 Feb 2023 09:38:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9hvhZVb90JP5bKYcnQSg83aAvp4BYFORSYNpZjoUDZCW3/tH8VrWxub3amijsmOE+4vS8s9g==
X-Received: by 2002:a05:6214:400d:b0:56e:f1fd:f16c with SMTP id kd13-20020a056214400d00b0056ef1fdf16cmr10742440qvb.20.1677433138458;
        Sun, 26 Feb 2023 09:38:58 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r191-20020a37a8c8000000b00729a26e836esm3341343qke.84.2023.02.26.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:38:58 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        sherry.sun@nxp.com, jindong.yue@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Revert "tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency"
Date:   Sun, 26 Feb 2023 12:38:46 -0500
Message-Id: <20230226173846.236691-1-trix@redhat.com>
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

This reverts commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30.

This results in a link error of

ld: drivers/tty/serial/earlycon.o: in function `parse_options':
drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'

When the config is in this state

CONFIG_SERIAL_CORE=m
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

Fixes: 5779a072c248 ("tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 625358f44419..0072892ca7fc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
 
 config SERIAL_FSL_LPUART_CONSOLE
 	bool "Console on Freescale lpuart serial port"
-	depends on SERIAL_FSL_LPUART
+	depends on SERIAL_FSL_LPUART=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.27.0

