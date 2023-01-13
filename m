Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B766882E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbjAMAMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbjAMALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8428A5B16C;
        Thu, 12 Jan 2023 16:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C53E621EB;
        Fri, 13 Jan 2023 00:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4808FC43446;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=LyGbrGRKlgQUG/6dRhmrOxWQZAI+7ZeRlrySnO8o+wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGz2fCFBpFPtDlfqbl722O++VKcLg5CZhk3XeXgsvT10C/Lk0VXQ2IByAiFnnOpSy
         gWUmtwgJqL3dAN8LS0BuxIXt59+wTDaQQdeyV1GBG3ENjo3tXaDCIn5qVz8HFOXqxT
         wH4kyN6ceuuw5zV579pwfsPQMxsu3zUyaJTWU1AD3DnSM9InxH6rmgStmHdokViarP
         +3+2hvcSjhPoGeD4M9gClP/w/MylYUL7F6i+aLgIyrJCWFZ2JsSq1xX90lJeoIpHKp
         xjq40rF/U6aF+RMYUIeYJN5cZr/RQovux3mXIcMUCw0JxX1AKmpFTX8KjTo1EmUtvj
         OJGYcub5PB5ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A0E425C118F; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Song Liu <song@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 06/20] drivers/md: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:18 -0800
Message-Id: <20230113001132.3375334-6-paulmck@kernel.org>
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
Cc: Song Liu <song@kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: <dm-devel@redhat.com>
Cc: <linux-raid@vger.kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/md/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 998a5cfdbc4e9..5f1e2593fad7e 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -6,7 +6,6 @@
 menuconfig MD
 	bool "Multiple devices driver support (RAID and LVM)"
 	depends on BLOCK
-	select SRCU
 	help
 	  Support multiple physical spindles through a single logical device.
 	  Required for RAID and logical volume management.
-- 
2.31.1.189.g2e36527f23

