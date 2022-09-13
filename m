Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F45B6652
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiIMEAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIMEAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:00:02 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 574D7B1EE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:00:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 598E11E80D80;
        Tue, 13 Sep 2022 11:57:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id urrVywFzYQfb; Tue, 13 Sep 2022 11:57:53 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id ABDCF1E80D74;
        Tue, 13 Sep 2022 11:57:53 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] reset: Remove unnecessary '0' values from ret
Date:   Tue, 13 Sep 2022 11:59:50 +0800
Message-Id: <20220913035950.258430-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ret variable is assigned first, it does not need to be initialized.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 include/linux/reset/bcm63xx_pmb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/reset/bcm63xx_pmb.h b/include/linux/reset/bcm63xx_pmb.h
index c77b6999518a..a6cc6df952f6 100644
--- a/include/linux/reset/bcm63xx_pmb.h
+++ b/include/linux/reset/bcm63xx_pmb.h
@@ -58,7 +58,7 @@ static inline int __bpcm_do_op(void __iomem *master, unsigned int addr,
 static inline int bpcm_rd(void __iomem *master, unsigned int addr,
 			  u32 off, u32 *val)
 {
-	int ret = 0;
+	int ret;
 
 	ret = __bpcm_do_op(master, addr, off >> 2, PMC_PMBM_READ);
 	*val = readl(master + PMB_RD_DATA);
@@ -69,7 +69,7 @@ static inline int bpcm_rd(void __iomem *master, unsigned int addr,
 static inline int bpcm_wr(void __iomem *master, unsigned int addr,
 			  u32 off, u32 val)
 {
-	int ret = 0;
+	int ret;
 
 	writel(val, master + PMB_WR_DATA);
 	ret = __bpcm_do_op(master, addr, off >> 2, PMC_PMBM_WRITE);
-- 
2.18.2

