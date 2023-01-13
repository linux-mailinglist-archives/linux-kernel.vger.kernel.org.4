Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34F66882A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjAMALw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbjAMALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:11:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4A3F440;
        Thu, 12 Jan 2023 16:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAED3621D8;
        Fri, 13 Jan 2023 00:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20B1C433AE;
        Fri, 13 Jan 2023 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673568695;
        bh=zptD60J3Cgt8c0EJaqWm6Hr2VBVz43WogJYOiD1uaCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeLRKlF0bGaJujtGzLQoo5wOqPOWMj2ogv6jHaUpUKDczJJtA0Fs51mBlLovS1yf3
         o7g538PWMJeFU4s/+DJdMZrRGWmhIAWkMDhki0eX+MGoJEBVGeIeXSfoBwSY8vmWyO
         5UbEMMANXT6cZJ5HvAIbIOOh5XCTy5FWWarkaVJCMGzhNe7qXAQMiEmlFKfN1e0ehQ
         aDcVBF6PVIt6c7l+k81P1IKTnbl5yojYnK/xkRzT0gnH6blVw1LmYnP90c43VmmNEZ
         ejdVQ949m1uHjn2ueTMVa6eFuBOky7bNK06wLDFH2cYbM5mcaUyzpP8VhpzCXsLPAY
         /QESHRjpYfxig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CB625C10CA; Thu, 12 Jan 2023 16:11:34 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu v2 04/20] drivers/dax: Remove "select SRCU"
Date:   Thu, 12 Jan 2023 16:11:16 -0800
Message-Id: <20230113001132.3375334-4-paulmck@kernel.org>
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
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: <nvdimm@lists.linux.dev>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/dax/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 5fdf269a822e5..2bf5123e48279 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig DAX
 	tristate "DAX: direct access to differentiated memory"
-	select SRCU
 	default m if NVDIMM_DAX
 
 if DAX
-- 
2.31.1.189.g2e36527f23

