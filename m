Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC8698A54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBPCG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBPCGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:06:25 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EDD42DE0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:06:23 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 18F761A00A29;
        Thu, 16 Feb 2023 10:06:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D3ysZJGqJFcI; Thu, 16 Feb 2023 10:06:57 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 45A6B1A00856;
        Thu, 16 Feb 2023 10:06:57 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] fortify: Increase pointer assignment check
Date:   Sat, 18 Feb 2023 02:37:40 +0800
Message-Id: <20230217183740.3039-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the check after the src pointer allocates memory. If these two
functions are used, at least increase some robustness.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/misc/lkdtm/fortify.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 015927665678..5c32e4e81d37 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -44,6 +44,9 @@ static void lkdtm_FORTIFY_STR_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (src == NULL)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
@@ -109,6 +112,9 @@ static void lkdtm_FORTIFY_MEM_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (src == NULL)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-- 
2.18.2

