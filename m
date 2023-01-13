Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09B668841
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjAMANX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbjAMALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854B1BD;
        Thu, 12 Jan 2023 16:11:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B834B82046;
        Fri, 13 Jan 2023 00:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A3CC43339;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=0JjRZ97KOFPDAmYeRjByYudJlUdg5gu25llTIyJbPjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8kOG2btaQ2VkXvOsbYSlW/ZOCrAtvFmC1cjoy/McM2aZNhkOIlABtQfccjAuloBN
         dRHJtxWNPzTp7j7VQeBHyLj3+wlBzOELAXc23IbvsePITOdPhlPIrG7xzDA0M/nLP5
         fQA1DAt+g10PqG7d9jh40Vvq+yeUyIAiqe6vzGipUE+IsNpcdxuYxOO0GB2hANNv0F
         T98sevEBWZKkcIpA5T42nFi3GXXvi94DzrRml6JqOrorzskoro2QtO6iILWmT9lYsr
         vLSJQ2TkLgCvWGvMVB7/IlS5cTenhdzT5sjh2Bqw213WFO4putr0PKL/ZpxLO87+Rk
         mAo3mbhd2dxZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B427C5C1C85; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 16/20] kernel/power: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:28 -0800
Message-Id: <20230113001132.3375334-16-paulmck@kernel.org>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <linux-pm@vger.kernel.org>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/power/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 60a1d3051cc79..4b31629c5be4b 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -118,7 +118,6 @@ config PM_SLEEP
 	def_bool y
 	depends on SUSPEND || HIBERNATE_CALLBACKS
 	select PM
-	select SRCU
 
 config PM_SLEEP_SMP
 	def_bool y
-- 
2.31.1.189.g2e36527f23

