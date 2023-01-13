Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612166883C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbjAMAMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjAMALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620305DE45;
        Thu, 12 Jan 2023 16:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08AE8B82040;
        Fri, 13 Jan 2023 00:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53217C43322;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=72gsX++wxmeErw7ndj3rGwNCVseeQh9C5570FRccUS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+/a1vhY7SZ+TndOVS8pLfR2WIZBPXxo1LJm3s34Aa8HHINjeOCM+WZxDolkgOAT7
         vgHH5nvpoeWkVyPMpixJKe3XfB69O060tRbi4JitrajwqRLsY9cMpLtQAjepa/SiWg
         ojYmgd700WPRrhmxpzyHlZrm11M5rxRwiStAeZWfTq/tcMJ+E7WFBJJHS8+A9+Ti7b
         OOW3a6WWaZ2/9cVfo+A8OIDIs2YNAX8/T3yTMlBrSJ4GWax33l5mqTzuf/PSzEJUCs
         v0TkfiB8xRP+jjSF/XfFbINC+ZqCmymX+zEeIejMNrYzpPmh/1J++xjU4Tdd0Izuvt
         +ogIrvtRX0xeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AABED5C1C63; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        Anup Patel <anup@brainfault.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 11/20] fs/dlm: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:23 -0800
Message-Id: <20230113001132.3375334-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christine Caulfield <ccaulfie@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: <cluster-devel@redhat.com>
Acked-by: Anup Patel <anup@brainfault.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dlm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index 1105ce3c80cbd..b3b86dbdc1878 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -4,7 +4,6 @@ menuconfig DLM
 	depends on INET
 	depends on SYSFS && CONFIGFS_FS && (IPV6 || IPV6=n)
 	select IP_SCTP
-	select SRCU
 	help
 	A general purpose distributed lock manager for kernel or userspace
 	applications.
-- 
2.31.1.189.g2e36527f23

