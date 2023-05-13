Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46D370148E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 08:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjEMF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 01:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 01:58:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C81703
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JwvBlXffIR0HVqcitR36C1vwkyoUehqX0Gm5NBSTvZk=; b=I+iRnGYIbH0GzESG0nV955gJUa
        0UPKyS/3Qb6BMiTbeTDcCOdZb6t8rJdRYDvFibJjoDDonE/XO1JsdC8BigzdBGV+1XQMUYDN1ilsi
        2qw908Jr765lQtgmh5i9NvGx2y5UGEEwdrKcPepoeExmP11o8zlVXSnrdSKTayT6U0WY1jh2L3C84
        iq+q935gdVdCRN32X0qWWlqn7dccEOqU7m5spB1uEBTo/W5Ex55QgNHeczWkLIWDJ/dzesIGwJC+e
        MXjwSqBFH7N3PX1PvB7OfzjFl6o0hdZ5MHH8iQ1uwmBd+xoc3IVTY3k3bmtWWX+ipK5kjLC1CrsKl
        tUnFsPRQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxiGc-00DlRD-1n;
        Sat, 13 May 2023 05:58:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [RFC PATCH] powerpc: udbg: export udbg_putc
Date:   Fri, 12 May 2023 22:58:04 -0700
Message-Id: <20230513055804.23775-1-rdunlap@infradead.org>
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

In a randconfig with CONFIG_SERIAL_CPM=m and
CONFIG_PPC_EARLY_DEBUG_CPM=y, there is a build error:
ERROR: modpost: "udbg_putc" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!

The build can be fixed by exporting "udbg_putc" in udbg.c.

OTOH, maybe something like this is more appropriate in
arch/powerpc/Kconfig.debug?

config PPC_EARLY_DEBUG_CPM
	bool "Early serial debugging for Freescale CPM-based serial ports"
-	depends on SERIAL_CPM
+	depends on SERIAL_CPM=y

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Pali Rohár" <pali@kernel.org>
---
 arch/powerpc/kernel/udbg.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -14,6 +14,7 @@
 #include <asm/udbg.h>
 
 void (*udbg_putc)(char c);
+EXPORT_SYMBOL(udbg_putc);
 void (*udbg_flush)(void);
 int (*udbg_getc)(void);
 int (*udbg_getc_poll)(void);
