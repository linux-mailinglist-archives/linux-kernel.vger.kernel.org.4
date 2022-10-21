Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD051607FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJUUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJUUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:24:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E639B81;
        Fri, 21 Oct 2022 13:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2339B82D23;
        Fri, 21 Oct 2022 20:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799CFC433C1;
        Fri, 21 Oct 2022 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666383878;
        bh=Sold5O9Z0l2jkV+weo40l2ACFBfyKqurUW9j4tWzf9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5F7bpW03JDQ1QfA+ZZPsS9amEAAU8bSadiiM/irqZIYUY+a4dZ2E4wLIiuvqCx0Z
         Th2TCoRdshRRwJTo4gZ5Lco+VMzx7Nu8xZDkA3HbZ8M2SEHVKyypISackNZuugzdBS
         tcc/cPiZHIBG26aGA+mCHGXj+aBr8PiozkePChG2LhqwJrcl2uDxIiZTBm0JXetBNZ
         KcDqUTb4IDYG3f5OFr1uzaLsCNIqHC/lfFSoQ2w9tpzZF8D7DbDUk3hXw6wrN7o/TE
         6Z/MLMIvGJWEjYflr45A2uujM6IErMI/z1UP6c4qzvZ79VteTlvBvJ9hWibgtX6vug
         30nZcPZHpVGJQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] sh: remove unused __BUILD_IOPORT_SINGLE 'pfx' parameter
Date:   Fri, 21 Oct 2022 15:24:22 -0500
Message-Id: <20221021202424.307531-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021202424.307531-1-helgaas@kernel.org>
References: <20221021202424.307531-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

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
2.25.1

