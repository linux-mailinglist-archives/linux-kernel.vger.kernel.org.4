Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A31166883F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbjAMANL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbjAMALn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C95DE46;
        Thu, 12 Jan 2023 16:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB98FCE1FBA;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78FFC43392;
        Fri, 13 Jan 2023 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=jkXE0W2CNP0e27Ckg1RXZA3NItagopfVWSUudCHUD9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dbj/CuJD9xDxQdyPWfyMl08K0cLhg5VSagcd6Ztf2ZBnWMXB1dlX6QWfECKAk3uyK
         4Cyc+6MK8O2PMAY0rj6JWtCk0BlqurrNsYRn6AAfamIFzvPL2TObRRnQEVo8AJy1Ff
         DjKtqwUTcaEV899A/oRpdKC6AePf/7QowsTVNEo0y6BEbNZFkGsMo1DO7840j4zamF
         e92enptQIJV6WRSlMFXWps5sxR7KFNYvcLsm8KpA2/Hr4uspO9hw/+55SlcCqGRRzU
         fD2WsfoFQzj95/pzmYmZvtLBgGA0NGw+ecVBJjBHcB71P+CaRsl2iT2GAFah4MDgWh
         N+BwOXPiM5MkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 987685C0AF8; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 02/20] drivers/base: Remove CONFIG_SRCU
Date:   Thu, 12 Jan 2023 16:11:14 -0800
Message-Id: <20230113001132.3375334-2-paulmck@kernel.org>
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
no longer any point in conditional compilation based on CONFIG_SRCU.
Therefore, remove the #ifdef and throw away the #else clause.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/base/core.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0cf..bb36aca8d1b7a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -181,7 +181,6 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
 
-#ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
 
@@ -220,47 +219,6 @@ static void device_link_remove_from_lists(struct device_link *link)
 	list_del_rcu(&link->s_node);
 	list_del_rcu(&link->c_node);
 }
-#else /* !CONFIG_SRCU */
-static DECLARE_RWSEM(device_links_lock);
-
-static inline void device_links_write_lock(void)
-{
-	down_write(&device_links_lock);
-}
-
-static inline void device_links_write_unlock(void)
-{
-	up_write(&device_links_lock);
-}
-
-int device_links_read_lock(void)
-{
-	down_read(&device_links_lock);
-	return 0;
-}
-
-void device_links_read_unlock(int not_used)
-{
-	up_read(&device_links_lock);
-}
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-int device_links_read_lock_held(void)
-{
-	return lockdep_is_held(&device_links_lock);
-}
-#endif
-
-static inline void device_link_synchronize_removal(void)
-{
-}
-
-static void device_link_remove_from_lists(struct device_link *link)
-{
-	list_del(&link->s_node);
-	list_del(&link->c_node);
-}
-#endif /* !CONFIG_SRCU */
 
 static bool device_is_ancestor(struct device *dev, struct device *target)
 {
-- 
2.31.1.189.g2e36527f23

