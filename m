Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32797052A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjEPPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjEPPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9FE8A48;
        Tue, 16 May 2023 08:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3183A634FA;
        Tue, 16 May 2023 15:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CF2C433A0;
        Tue, 16 May 2023 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251987;
        bh=+PXaRTBSn60jQ/X7Rv0TDk12fsmWqv5PZ6FzfOCld7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K23LPUi1cGEmRv5eV1Nv/q8aasoK1fyVpkve5eGfHtw3d/bIG+h+wHe+0CwHSxL4k
         36dMGKcxmRgmRfKSKV20BQknak7j5m2zroRfqznnoNuOdeQN5nWwNOND4omv0084mB
         otqjvUSxNEouxQl6gNzZgIXjU1Q6CyNMEa7VPLZW8G0+VnWgB4Kn3Wmb8hR6kx2NtC
         9GOrPVKyBicSYc14OJABRBn/5ctmu6ro61sOKq+nkN8OFZWT2Rqmq1aaVzu0Fftm/A
         AnMS1nqKi0fOpcQp6ASMbji/5Or0BlQ9Zcwer7L1VwLmD3ttvxFfge0gm+PJeRhPOT
         s0YH+0qJMW7hg==
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
Subject: [PATCH 03/16] ARM: vfp: include asm/neon.h in vfpmodule.c
Date:   Tue, 16 May 2023 17:45:52 +0200
Message-Id: <20230516154605.517690-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two functions defined here need the declaration in a header
to avoid W=1 warnings:

arch/arm/vfp/vfpmodule.c:735:6: error: no previous prototype for 'kernel_neon_begin' [-Werror=missing-prototypes]
arch/arm/vfp/vfpmodule.c:768:6: error: no previous prototype for 'kernel_neon_end' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/vfp/vfpmodule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 349dcb944a93..1ba5078c1025 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -25,6 +25,7 @@
 #include <asm/thread_notify.h>
 #include <asm/traps.h>
 #include <asm/vfp.h>
+#include <asm/neon.h>
 
 #include "vfpinstr.h"
 #include "vfp.h"
-- 
2.39.2

