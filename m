Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7124766882D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjAMAMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjAMALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B49751310;
        Thu, 12 Jan 2023 16:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98195621E2;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8ADC43396;
        Fri, 13 Jan 2023 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=ul1/WKLKiUmVybIxqWnYnRpo2gSfd31L08sVwl6r/bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUorwqkTXTL57R+WQaylGCKaAGTRLrwjN6Pin3ea3ZWmx2Rnli50rF75h/vvQTgNV
         d3rWCunXEFBx4tvmrOQOLL7KCAM/0dTy1c4fwn8Kr06gS6rVnFc4hQdRDQbb6dkeSs
         ENgjp1GfNPG5grwP2Qp4xzK2ezsdJiUeN/7S/rwalieTEBIgzJqkkJ88WYxL1tTy4V
         VL44evRX1laMfys93cdGTHrEKOsYS1oFCm/3m7nU9/MtuDZy1WEvpbLln2BugEuaxF
         9jIQUcOI8zXGUEGcjcAM3t15tTpTbC4is/hzA+56NrQ7P9Y2BJ2ZzhQNPtpCrtIi+w
         U+W2icDqfFHoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9EECF5C1109; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 05/20] drivers/hwtracing/stm: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:17 -0800
Message-Id: <20230113001132.3375334-5-paulmck@kernel.org>
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: <linux-stm32@st-md-mailman.stormreply.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/hwtracing/stm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index aad594fe79cc5..eda6b11d40a1f 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -2,7 +2,6 @@
 config STM
 	tristate "System Trace Module devices"
 	select CONFIGFS_FS
-	select SRCU
 	help
 	  A System Trace Module (STM) is a device exporting data in System
 	  Trace Protocol (STP) format as defined by MIPI STP standards.
-- 
2.31.1.189.g2e36527f23

