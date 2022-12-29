Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E977C658FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiL2Rn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2Rn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:43:26 -0500
X-Greylist: delayed 2252 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Dec 2022 09:43:24 PST
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B4CE01
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:43:24 -0800 (PST)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1pAwLi-0030r7-1l;
        Thu, 29 Dec 2022 17:05:46 +0000
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] riscv: uaccess: fix type of 0 variable on error in get_user()
Date:   Thu, 29 Dec 2022 17:05:45 +0000
Message-Id: <20221229170545.718264-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,PDS_RDNS_DYNAMIC_FP,RCVD_IN_SORBS_DUL,
        RDNS_DYNAMIC,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the get_user(x, ptr) has x as a pointer, then the setting
of (x) = 0 is going to produce the following sparse warning,
so fix this by forcing the type of 'x' when access_ok() fails.

fs/aio.c:2073:21: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/riscv/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 855450bed9f5..ec0cab9fbddd 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -165,7 +165,7 @@ do {								\
 	might_fault();						\
 	access_ok(__p, sizeof(*__p)) ?		\
 		__get_user((x), __p) :				\
-		((x) = 0, -EFAULT);				\
+		((x) = (__force __typeof__(x))0, -EFAULT);	\
 })
 
 #define __put_user_asm(insn, x, ptr, err)			\
-- 
2.39.0

