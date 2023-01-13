Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC7668840
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjAMANS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjAMALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD625DE51;
        Thu, 12 Jan 2023 16:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D746DCE1FCC;
        Fri, 13 Jan 2023 00:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB2DC43324;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=wRbexw5jnaHrbh9n8mN2FpRr5IUUSVBu5XxkrsWfwno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uogPZF70alJN72ZhI7hM13HuMZa7CZKAKyxOc350SAWSN5kF3wqT8SQhyL0MOrx2T
         CaXAuBQkqmlrbyqVwZqH6kEQiJ6PCzH2bZwaY9Ddk4wKaPsz35mzlNRFdyPDa6Sl4c
         8A53znSetjFXLrgzeuH/XAKYaqA4YYlw6V83jcmGsr+MfuQEzRyHUT3CVnq7HjUfFS
         fXoziNWiQ4lC+UN/uhKV8VGpLxfTb4DDt0qjJgfdcgI1w4cYrSSc3TWsIe+gUvx3eQ
         M/7DIK0ic5j49dZfCICre8Kg9lj7kMswnMCYmEpPy9DNe+TC6mY1GFQG3Kfolp3XcG
         JJRIP0knb2n1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE3985C1C6D; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jan Kara <jack@suse.com>, Jan Kara <jack@suse.cz>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 13/20] fs/quota: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:25 -0800
Message-Id: <20230113001132.3375334-13-paulmck@kernel.org>
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
Cc: Jan Kara <jack@suse.com>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 fs/quota/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index b59cd172b5f97..d5a85a8062d05 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -6,7 +6,6 @@
 config QUOTA
 	bool "Quota support"
 	select QUOTACTL
-	select SRCU
 	help
 	  If you say Y here, you will be able to set per user limits for disk
 	  usage (also called disk quotas). Currently, it works for the
-- 
2.31.1.189.g2e36527f23

