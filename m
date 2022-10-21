Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50506607FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJUUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:24:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB2356D8;
        Fri, 21 Oct 2022 13:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 677CAB82CC6;
        Fri, 21 Oct 2022 20:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07516C433C1;
        Fri, 21 Oct 2022 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666383882;
        bh=+us4sh73zodMSJr2daIIFwpHjFf1Aug9TQOSGrI/oiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQTaDCeZPsfI+kuEDc+ETL9M2MSLlBX0bcHoSmBUDeo0pKPC2w8jo/NW4i4Ne9t4b
         pChKX5VxoOW0bFY/1uC8Jc9KPZ5uoDrxZhlCRgiYDB4D+oFR2kOQDwY2KQc1nQdImH
         0pXW6EmxLKU+tegZwuaxC5iOGN5LiuMmKdcMQiu18zgux/+V6MdeQLUC606zPnKw2J
         +7lfoEITWMHfzrGMmCefRv1Q0kw2W4A1Ij/VHNomJMiHuJH91nkS3FyVH23NZMztA8
         XJ3sBUv3gp6eEQRpqzPK2VnYCEE/nz/nfsLr9n+xMVP6cXdcV7HhBo+OVhXNh/hTQo
         SNN9hTT1Kzlfw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/4] sh: remove unnecessary __BUILD_MEMORY_STRING() 'pfx' parameter
Date:   Fri, 21 Oct 2022 15:24:24 -0500
Message-Id: <20221021202424.307531-5-helgaas@kernel.org>
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

Previously __BUILD_MEMORY_STRING() accepted a "pfx" parameter, to which all
users passed "__raw_".  Simplify this by dropping the parameter and
encoding "__raw_" in the function name explicitly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/include/asm/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index e29e8870dc3b..179420fc4053 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -86,11 +86,11 @@ __BUILD_UNCACHED_IO(w, u16)
 __BUILD_UNCACHED_IO(l, u32)
 __BUILD_UNCACHED_IO(q, u64)
 
-#define __BUILD_MEMORY_STRING(pfx, bwlq, type)				\
+#define __BUILD_MEMORY_STRING(bwlq, type)				\
 									\
 static inline void							\
-pfx##writes##bwlq(volatile void __iomem *mem, const void *addr,		\
-		  unsigned int count)					\
+__raw_writes##bwlq(volatile void __iomem *mem, const void *addr,	\
+		   unsigned int count)					\
 {									\
 	const volatile type *__addr = addr;				\
 									\
@@ -100,8 +100,8 @@ pfx##writes##bwlq(volatile void __iomem *mem, const void *addr,		\
 	}								\
 }									\
 									\
-static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
-				    void *addr, unsigned int count)	\
+static inline void __raw_reads##bwlq(volatile void __iomem *mem,	\
+				     void *addr, unsigned int count)	\
 {									\
 	volatile type *__addr = addr;					\
 									\
@@ -111,13 +111,13 @@ static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
 	}								\
 }
 
-__BUILD_MEMORY_STRING(__raw_, b, u8)
-__BUILD_MEMORY_STRING(__raw_, w, u16)
+__BUILD_MEMORY_STRING(b, u8)
+__BUILD_MEMORY_STRING(w, u16)
 
 void __raw_writesl(void __iomem *addr, const void *data, int longlen);
 void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 
-__BUILD_MEMORY_STRING(__raw_, q, u64)
+__BUILD_MEMORY_STRING(q, u64)
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 
-- 
2.25.1

