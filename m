Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAF7052B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjEPPsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjEPPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A84A24D;
        Tue, 16 May 2023 08:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB6663B93;
        Tue, 16 May 2023 15:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0070AC433A1;
        Tue, 16 May 2023 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252035;
        bh=bjHzaX1S/XmMHS+pzx/BBsDEPRhhS8ndqsq/8qSoq9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2bOGMmanyE84V2/AE41WTMs80qf9pTZsHsD9F+/Ran0Loq1XnTWD9T1Xe/lEKv2Y
         26KXijopJ1VoF2HSPy2rDYc4XU/QPS+Zund7IVhGRxHNHw9vNTL86eH4s8XWVe+esJ
         GHxnqexAf5xknWy4Yonsml33IdsEstRyKq9sdNqaIejoDb1g5MSmONOYCsanOthNKJ
         D+QslLecnNSqmq1ph9lvme/E4S0LiZmiQg9qzXyrdadHTL+NCJjLLu6zxCWjXyvqVt
         4V5sahVD0mThIJeYsb2Qctrjw2FfeAYZ7OWb+ewqVNJiWbDv2ZF8YlLIH2bOXWAWg3
         rAlpSAzcEWEKg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 16/16] ARM: xip-kernel: add __inflate_kernel_data prototype
Date:   Tue, 16 May 2023 17:46:05 +0200
Message-Id: <20230516154605.517690-17-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The kernel .data decompression is called from assembler, so it does
not need a prototype, but adding one avoids this W=1 warning:

arch/arm/kernel/head-inflate-data.c:35:12: error: no previous prototype for '__inflate_kernel_data' [-Werror=missing-prototypes]

The same file contains a few extern declarations for assembler
symbols, move those into the header as well for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/head-inflate-data.c | 5 +----
 arch/arm/kernel/head.h              | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/kernel/head.h

diff --git a/arch/arm/kernel/head-inflate-data.c b/arch/arm/kernel/head-inflate-data.c
index 89a52104d32a..225c0699a12c 100644
--- a/arch/arm/kernel/head-inflate-data.c
+++ b/arch/arm/kernel/head-inflate-data.c
@@ -8,16 +8,13 @@
 
 #include <linux/init.h>
 #include <linux/zutil.h>
+#include "head.h"
 
 /* for struct inflate_state */
 #include "../../../lib/zlib_inflate/inftrees.h"
 #include "../../../lib/zlib_inflate/inflate.h"
 #include "../../../lib/zlib_inflate/infutil.h"
 
-extern char __data_loc[];
-extern char _edata_loc[];
-extern char _sdata[];
-
 /*
  * This code is called very early during the boot process to decompress
  * the .data segment stored compressed in ROM. Therefore none of the global
diff --git a/arch/arm/kernel/head.h b/arch/arm/kernel/head.h
new file mode 100644
index 000000000000..6eccf98fc2cc
--- /dev/null
+++ b/arch/arm/kernel/head.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+extern char __data_loc[];
+extern char _edata_loc[];
+extern char _sdata[];
+
+int __init __inflate_kernel_data(void);
+
-- 
2.39.2

