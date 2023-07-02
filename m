Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB816745086
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGBTjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9810F1;
        Sun,  2 Jul 2023 12:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD4CE60C81;
        Sun,  2 Jul 2023 19:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642C4C433C9;
        Sun,  2 Jul 2023 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326724;
        bh=8rsQ8zSP8q67Qtm7IKw9oJrTWCmQXiYg7MWumz55UdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/gJD/cYA+XjxFoUYG8Ww7iJ8dPeRg+OZFGFZ9co098WFwsEZ8QM/n4KdEf2EbHbC
         5B8FNU/p/DBb79XDjJ+ohq780UQ5lWR8/asv+0NqgjaTU3vrBqLHnzFQOsHx2M/njj
         82p2XKzNZqvyOahSrAlT67UNFSrTDs8CAykeV20Vjres8UDwr4lCOkcFa2LzHQbkWe
         E+pOP7aYdHSHMYBgCu8rmu4m5H28yFObQrnHrWbQW47DuUkjISQNESXlrGMtQ65ASr
         qN47pEidewWsA1ilkuwlX21uBXufjuo/umwNl5uZE03oMYpQ3HpYO2S9oXQ9UNjvzE
         sDghKwm1cm7LA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 10/16] s390/boot: fix physmem_info virtual vs physical address confusion
Date:   Sun,  2 Jul 2023 15:38:09 -0400
Message-Id: <20230702193815.1775684-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit c70505434c8defb111326a143e2dd2be09778593 ]

Fix virtual vs physical address confusion (which currently are the same).

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/physmem_info.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/physmem_info.h b/arch/s390/include/asm/physmem_info.h
index 8e9c582592b3f..9e41a74fce9ac 100644
--- a/arch/s390/include/asm/physmem_info.h
+++ b/arch/s390/include/asm/physmem_info.h
@@ -3,6 +3,7 @@
 #define _ASM_S390_MEM_DETECT_H
 
 #include <linux/types.h>
+#include <asm/page.h>
 
 enum physmem_info_source {
 	MEM_DETECT_NONE = 0,
@@ -133,7 +134,7 @@ static inline const char *get_rr_type_name(enum reserved_range_type t)
 
 #define for_each_physmem_reserved_type_range(t, range, p_start, p_end)				\
 	for (range = &physmem_info.reserved[t], *p_start = range->start, *p_end = range->end;	\
-	     range && range->end; range = range->chain,						\
+	     range && range->end; range = range->chain ? __va(range->chain) : NULL,		\
 	     *p_start = range ? range->start : 0, *p_end = range ? range->end : 0)
 
 static inline struct reserved_range *__physmem_reserved_next(enum reserved_range_type *t,
@@ -145,7 +146,7 @@ static inline struct reserved_range *__physmem_reserved_next(enum reserved_range
 			return range;
 	}
 	if (range->chain)
-		return range->chain;
+		return __va(range->chain);
 	while (++*t < RR_MAX) {
 		range = &physmem_info.reserved[*t];
 		if (range->end)
-- 
2.39.2

