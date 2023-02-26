Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912B6A2E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBZFkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBZFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:39:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B8136E9;
        Sat, 25 Feb 2023 21:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cSNByO9fFLUH/bsd79G915kzP5bO5cbyzpjf2Z+gFkk=; b=Wc+ujKzBtm+iV66xOvUoAUGW1r
        emDMt3GkBYnW0zXqvn/HmExzeY6gQDdMGhpcFu4c8lxCp3UQHRmYnYPxdl+RiiEWrmwdVJtoDo8ic
        2AJ2rMwrf3jXoLafx9hsLP7nJOHL5h2VmuUqb2XpeE8cJwkdWo/k3V+LmYLOkDow6LK+ly4VEI3/q
        JMbwUBLaJhg3VGoL+4IAzrZukTKM3QBl2T00aO8Cu5bYdy2744qx2geTxx22LnV3UAjkaUVdk4buX
        TApEbcGYagRdqgIdrXjnnjZAknRduFfiREeJpas6LHqLXhXECpCapPST1GWw0NdCcXTOg7A3zGYMc
        Jps0jjIw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lO-006qYL-6D; Sun, 26 Feb 2023 05:39:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oskar Senft <osk@google.com>, linux-serial@vger.kernel.org
Subject: [PATCH 8/8] serial: 8250: ASPEED_VUART: select REGMAP instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:53 -0800
Message-Id: <20230226053953.4681-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
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

REGMAP is a hidden (not user visible) symbol. Users cannot set it
directly thru "make *config", so drivers should select it instead of
depending on it if they need it.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change the use of "depends on REGMAP" to "select REGMAP".

Fixes: 8d310c9107a2 ("drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity configurable")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oskar Senft <osk@google.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/8250/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -257,8 +257,9 @@ config SERIAL_8250_ASPEED_VUART
 	tristate "Aspeed Virtual UART"
 	depends on SERIAL_8250
 	depends on OF
-	depends on REGMAP && MFD_SYSCON
+	depends on MFD_SYSCON
 	depends on ARCH_ASPEED || COMPILE_TEST
+	select REGMAP
 	help
 	  If you want to use the virtual UART (VUART) device on Aspeed
 	  BMC platforms, enable this option. This enables the 16550A-
