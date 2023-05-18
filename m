Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3845708B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjERWDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjERWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C82E64;
        Thu, 18 May 2023 15:03:17 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ltQ3L6tadCn4Z6Gz2ASt3C39R1RPyrwN6s8j9Dokk1M=;
        b=LRnYcpPmqRJBkY0jXDrMSb5vt6buokv+P0xfZBaOQNCv0u/CFcsiRApuSjrk6Wn6ba4rZL
        2exRrtQtMYioNUxp2Eho4rhF+xViUVH7bHEF6G802N9xIgOX65bQOxC/Dc+3sJkVTwVTz2
        kLNlslzMn4gr0brSR0IGqqHFTZPlVLSIlsA9HcP7wKzvXMJD/ryYle2+IC1xLrSukXEYcR
        GZJxkN0pMUCI2diCuFJJlwBEKKvE6Z41efEn/bsD438YOWW7MYPaUjFEDGC/sR+kJ9hqF0
        UF8kgzxMKklKcpA6/ddbTm+gDhQMIFAgWWT6ZTy+DynJTc7rcN3bfUVoBcN39Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ltQ3L6tadCn4Z6Gz2ASt3C39R1RPyrwN6s8j9Dokk1M=;
        b=QMgmFnkHyjlePDJS7TkGcWAvkXG+P9wwUrf2TxwWFog6KFErf8cnKabT7JOawmUCkeTfyy
        OhXZMnPVlFt239Cw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Include asm/numa.h for set_highmem_pages_init()
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739432.404.8341294872688326469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b963d12aa66ce02b948cd69a20eea5d1d1e0137e
Gitweb:        https://git.kernel.org/tip/b963d12aa66ce02b948cd69a20eea5d1d1e0137e
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:37 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/mm: Include asm/numa.h for set_highmem_pages_init()

The set_highmem_pages_init() function is declared in asm/numa.h, which
must be included in the file that defines it to avoid a W=1 warning:

arch/x86/mm/highmem_32.c:7:13: error: no previous prototype for 'set_highmem_pages_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-9-arnd%40kernel.org
---
 arch/x86/mm/highmem_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 2c54b76..d9efa35 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -3,6 +3,7 @@
 #include <linux/export.h>
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
+#include <asm/numa.h>
 
 void __init set_highmem_pages_init(void)
 {
