Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3F70D821
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjEWI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjEWI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:59:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5A132;
        Tue, 23 May 2023 01:59:13 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 2D8A01C000E;
        Tue, 23 May 2023 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684832352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hB0jH5VbqniXpY2XCqtCh3H0TPVZDlgFAeoWdY16lSQ=;
        b=Mw816vN8TcnBrfqTuNPEggUvaZItZxQ1MeLicdYfseZoMBoorR4ORd/ARlEOpS1cgZp1hw
        0sG3pZC4coWfmm8liekXRLcMPfdvp2TMA/Px2we9hfRSHDr1bghzhC/tn9NjJgE60PAy11
        XMAh/2o5xVgsfDw5ZcTC0FbCxKiDoUKktLDfwLDr4x9e6XXUasE4dwVbtWz2lPF/TF9zPE
        v9NcBijXdx7na0lNRCsioVYyRD7MOF2zbK8ZKe9m0dm8Vj3A7/jfMU0puanLfbCB8TcGDp
        LjDauu5pX317pW/k6pO8A4dFBfq7Yi5004JBbTjdlXsWSvQ5wihHsNrzJIvv+Q==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] serial: cpm_uart: Fix a COMPILE_TEST dependency
Date:   Tue, 23 May 2023 10:59:02 +0200
Message-Id: <20230523085902.75837-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523085902.75837-1-herve.codina@bootlin.com>
References: <20230523085902.75837-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a COMPILE_TEST configuration, the cpm_uart driver uses symbols from
the cpm_uart_cpm2.c file. This file is compiled only when CONFIG_CPM2 is
set.

Without this dependency, the linker fails with some missing symbols for
COMPILE_TEST configuration that needs SERIAL_CPM without enabling CPM2.

This lead to:
  depends on CPM2 || CPM1 || (PPC32 && CPM2 && COMPILE_TEST)

This dependency does not make sense anymore and can be simplified
removing all the COMPILE_TEST part.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
Fixes: e3e7b13bffae ("serial: allow COMPILE_TEST for some drivers")
---
 drivers/tty/serial/Kconfig             | 2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 625358f44419..de092bc1289e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
 
 config SERIAL_CPM
 	tristate "CPM SCC/SMC serial port support"
-	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
+	depends on CPM2 || CPM1
 	select SERIAL_CORE
 	help
 	  This driver supports the SCC and SMC serial ports on Motorola 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 0577618e78c0..46c03ed71c31 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -19,8 +19,6 @@ struct gpio_desc;
 #include "cpm_uart_cpm2.h"
 #elif defined(CONFIG_CPM1)
 #include "cpm_uart_cpm1.h"
-#elif defined(CONFIG_COMPILE_TEST)
-#include "cpm_uart_cpm2.h"
 #endif
 
 #define SERIAL_CPM_MAJOR	204
-- 
2.40.1

