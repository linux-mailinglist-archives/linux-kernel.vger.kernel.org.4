Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B74607F24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUTh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJUThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:37:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462A2610A1;
        Fri, 21 Oct 2022 12:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBDD2B82D21;
        Fri, 21 Oct 2022 19:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1DC433C1;
        Fri, 21 Oct 2022 19:37:14 +0000 (UTC)
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Oct 2022 14:36:56 -0500
Subject: [PATCH v2 2/4] sh: remove unused __BUILD_IOPORT_SINGLE 'pfx' parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221021-wip-bjorn-22-10-slow-down-io-v2-2-8b3692d12ea7@google.com>
References: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
In-Reply-To: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
To:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666381029; l=2009;
 i=bhelgaas@google.com; s=20221014; h=from:subject:message-id;
 bh=8UKhu6SX8DGey6kmjCz3BO86QD79+K2wUhfKHDjrdCk=;
 b=ijuER2q4Zdn6CQkGbuXFSsYkilANhzlZtWGiSZHUTKE1TmMeEqUomg+ceMjAZT7Sc5mf9BKMctC4
 aUZdfA08BaLRDQGOWXJSTGBENzi3KIelyXOLjviA6uf/KjWjJIVv
X-Developer-Key: i=bhelgaas@google.com; a=ed25519;
 pk=bFjaHnNobtkUv3f7ErkQcm+PpbyCUUBlIfqMtNRJwQs=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously __BUILD_IOPORT_SINGLE() accepted a "pfx" parameter, to which
__BUILD_IOPORT_PFX(), the only user of __BUILD_IOPORT_SINGLE(), passed
along its own "bus" parameter.  But users of __BUILD_IOPORT_PFX() supplied
nothing, so both "bus" and "pfx" are pointless.  Remove them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/include/asm/io.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 8043b7c235ca..193640bd9563 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -140,9 +140,9 @@ static inline void __set_io_port_base(unsigned long pbase)
 extern void __iomem *__ioport_map(unsigned long addr, unsigned int size);
 #endif
 
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p)			\
+#define __BUILD_IOPORT_SINGLE(bwlq, type, p)				\
 									\
-static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
+static inline void out##bwlq##p(type val, unsigned long port)		\
 {									\
 	volatile type *__addr;						\
 									\
@@ -150,7 +150,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 	*__addr = val;							\
 }									\
 									\
-static inline type pfx##in##bwlq##p(unsigned long port)			\
+static inline type in##bwlq##p(unsigned long port)			\
 {									\
 	volatile type *__addr;						\
 	type __val;							\
@@ -161,12 +161,12 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 	return __val;							\
 }
 
-#define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type,)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p)
+#define __BUILD_IOPORT_PFX(bwlq, type)					\
+	__BUILD_IOPORT_SINGLE(bwlq, type,)				\
+	__BUILD_IOPORT_SINGLE(bwlq, type, _p)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
-	__BUILD_IOPORT_PFX(, bwlq, type)
+	__BUILD_IOPORT_PFX(bwlq, type)
 
 BUILDIO_IOPORT(b, u8)
 BUILDIO_IOPORT(w, u16)

-- 
b4 0.10.1
