Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFA64B075
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiLMHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:36:44 -0500
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2443413D6C;
        Mon, 12 Dec 2022 23:36:43 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7E1CD1E80D80;
        Tue, 13 Dec 2022 15:32:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9xnrt98Y5fCV; Tue, 13 Dec 2022 15:32:00 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id BF5521E80D56;
        Tue, 13 Dec 2022 15:32:00 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] kernel: process: Remove unnecessary (void*) conversions
Date:   Tue, 13 Dec 2022 15:36:33 +0800
Message-Id: <20221213073633.3586-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_ptr is a void * type and does not require a cast.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 arch/alpha/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 65fdae9e48f3..5bc8be1eba11 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -74,7 +74,7 @@ struct halt_info {
 static void
 common_shutdown_1(void *generic_ptr)
 {
-	struct halt_info *how = (struct halt_info *)generic_ptr;
+	struct halt_info *how = generic_ptr;
 	struct percpu_struct *cpup;
 	unsigned long *pflags, flags;
 	int cpuid = smp_processor_id();
-- 
2.18.2

