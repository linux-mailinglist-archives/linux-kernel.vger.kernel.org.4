Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F45EED5F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiI2FtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiI2FtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:49:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA6212B5D6;
        Wed, 28 Sep 2022 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oS1DZJIlVT/ev0g2S7cdLrJ30qAADkJqbKS7womeC6U=; b=akyI6raJeqUg6o/H/lqQVMFgLO
        lXeCelY2zQXU8bFICZiic4GoHEyKPnON04Z/WVCL95+IDP60pa+CekYloRTdjk0NUcVOpUtSMcsnO
        JMJMGWZ5yHeWnqrRTy23h7o1kl/EZj0wTwCQXJWhFIfVR/+qqWkNx8a/a+B1NmfLxQCe1WX3QssXg
        l+lD6TxbWABwrT13pA5OkvxKML2hL0s/XCZ90qRIHfaSmlBcVjy7/m2xDG2oTcftSIYXyrAznLW5t
        y8QN6T9YfuuL9p+BWixuRMErbi5OiRCNlrSKp0XoKSW7C7u1PpArKhoBiItuq92AyhFLv0Xa6CCoB
        rnwb7HsQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odmPq-00D1Et-Rn; Thu, 29 Sep 2022 05:48:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH -next] tty: serial: atmel: driver depends on COMMON_CLK
Date:   Wed, 28 Sep 2022 22:48:51 -0700
Message-Id: <20220929054851.7723-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since atmel_serial.c uses interfaces that are provided by
the COMMON_CLK Kconfig symbol, the driver should depend on
COMMON_CLK to prevent build errors.

ld: drivers/tty/serial/atmel_serial.o: in function `atmel_serial_pm':
atmel_serial.c:(.text+0x1553): undefined reference to `__clk_is_enabled'
ld: drivers/tty/serial/atmel_serial.o: in function `atmel_set_termios':
atmel_serial.c:(.text+0x1dfe): undefined reference to `__clk_is_enabled'

Fixes: 5e3ce1f26129 ("tty: serial: atmel: Make the driver aware of the existence of GCLK")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sergiu Moga <sergiu.moga@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,6 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on ARCH_AT91 || COMPILE_TEST
+	depends on COMMON_CLK
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
