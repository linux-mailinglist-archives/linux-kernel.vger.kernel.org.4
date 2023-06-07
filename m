Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86700725E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjFGMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbjFGMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678F1BDC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D75A6377D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C4C43446;
        Wed,  7 Jun 2023 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686139742;
        bh=DY6GViYL/HPHEUA0RIEtbKs28uUpDP607FEoNig9h0s=;
        h=From:To:Cc:Subject:Date:From;
        b=uMp7oKY23T94+e2fDBoJtdemaAicrzwm6xKzR5WRma/mC/YIWAEcSuzrBcItSTK9g
         TSDxkRwjdW2qdmgeobGpfwR6POpppYYqCzck8kO+8nOASTtmg80Pw0DXiDCTuXhTlv
         jE4UpwcmnimfXB4htkzNveykv8UsjYIQ2ETQPzuCbZUrgk0JdvqmMgLUtkf6gIqtgJ
         KB75iK2ynaM4peK2jVaf1ujheybcK/2oGt7+pz7LzckkK0Xs8+qaSIMWthJkSe3g1c
         qZf36Z3oDzrAno5DcBQjOSZFFJXbUDSkobxs73w+512SGAWCJ2YDQ/Mh60ZEHLBx3o
         XwhjhK3yIESLQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: fix unused proc_cap_handler() function warning
Date:   Wed,  7 Jun 2023 14:08:54 +0200
Message-Id: <20230607120857.3621364-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Since usermodehelper_table() is marked static now, we get a
warning about it being unused when SYSCTL is disabled:

kernel/umh.c:497:12: error: 'proc_cap_handler' defined but not used [-Werror=unused-function]

Just move it inside of the same #ifdef.

Fixes: e6944e3b75df7 ("sysctl: move umh sysctl registration to its own file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/umh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index d5dc3cc92d5c6..2f9249c2bf6ce 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -494,6 +494,7 @@ int call_usermodehelper(const char *path, char **argv, char **envp, int wait)
 }
 EXPORT_SYMBOL(call_usermodehelper);
 
+#if defined(CONFIG_SYSCTL)
 static int proc_cap_handler(struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -544,7 +545,6 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-#if defined(CONFIG_SYSCTL)
 static struct ctl_table usermodehelper_table[] = {
 	{
 		.procname	= "bset",
-- 
2.39.2

