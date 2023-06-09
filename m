Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B635C728C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjFIAdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFIAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:33:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922DE30C8;
        Thu,  8 Jun 2023 17:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=07+hV5uSDDJLUm8XLuemkRmQ1/NA1t2O44DKghOBv+g=; b=IMvII713AqfhBro+1bWtv24I/j
        +na2Q4M5jPhrGex1+xBgwJL0Ky/SKldSBfpsGtbFPiBBFnb9l9+AsqffLboMQR8d0K5iDdoWwDseN
        gbqCEQytGNAcbJHkCh1mxMQ1cD+5qAOTVF09eFFTAZqj2Fg1MbsYZpd2VNEo//BquYL8hnIf9/2zB
        b49wKBH8ee/SdPPRUIUSHNUJBkdqBrL7SNx78waCio4SJeHUJ+kol/yEIl8/Pa9UvjlbMmxaFU2Tx
        mcMdMjwbFnejubjsdY34HDFghHtqnVZ+bfB9ME/YuyMr+QuPwJq9J+oiBdAXcD/ASdhluTmjTHidJ
        nIgwzJ1Q==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Q4I-00B4uV-2L;
        Fri, 09 Jun 2023 00:33:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/legacy_serial: check CONFIG_SERIAL_8250_CONSOLE
Date:   Thu,  8 Jun 2023 17:33:28 -0700
Message-Id: <20230609003328.15008-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SERIAL_8250_CONSOLE is not set but PPC_UDBG_16550=y,
the legacy_serial code references fsl8250_handle_irq, which is
only built when SERIAL_8250_CONSOLE is set.

Be consistent in referencing the used CONFIG_SERIAL_8250*
symbols so that the build errors do not happen.

Prevents these build errors:

powerpc-linux-ld: arch/powerpc/kernel/legacy_serial.o: in function `serial_dev_init':
legacy_serial.c:(.init.text+0x2aa): undefined reference to `fsl8250_handle_irq'
powerpc-linux-ld: legacy_serial.c:(.init.text+0x2b2): undefined reference to `fsl8250_handle_irq'

Fixes: 66eff0ef528b ("powerpc/legacy_serial: Warn about 8250 devices operated without active FSL workarounds")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/legacy_serial.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -508,9 +508,9 @@ static void __init fixup_port_irq(int in
 
 	port->irq = virq;
 
-	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
+	if (IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE) &&
 	    of_device_is_compatible(np, "fsl,ns16550")) {
-		if (IS_REACHABLE(CONFIG_SERIAL_8250)) {
+		if (IS_REACHABLE(CONFIG_SERIAL_8250_CONSOLE)) {
 			port->handle_irq = fsl8250_handle_irq;
 			port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 		} else {
