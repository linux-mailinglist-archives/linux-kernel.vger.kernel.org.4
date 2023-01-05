Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14565E1D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbjAEAl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjAEAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981D6C3C;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5467C61880;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7572EC433B0;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=+L9zhcB+hUYsHjcRcqemJqoGzF3x7d5CEb6FU4DWqac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WL687Kncqgklk45rSEUmRACcroNljnbgdpcKFptf5DqAPBW78Z/NNWYc82CjT/bfO
         93+pVhh35Tpt42P19/AQy5ZApRuyxi/sI3TyhwCvvbun9E6KuGt5yaCmeNtCGroKoi
         8uasysST/D8M9m3fpl6tLCsIFIW55apBrWDSzGi5lpOXne0QRbUlkKea1xSnMgZ9zo
         LWQkR2MYB7IkIm+9bKOsPE6jO6HAXsmMp2wTx5jxvtaz4cqquAGRVIBNVuyv7BxA4M
         5lQWjMkYF0uwYjaMRGpdjKo/oS2Ly/ox3gef7rEinayWupH6pkvCPGv3MO0B1isom5
         Uskow1uXCa+zQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C96D55C1C77; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev
Subject: [PATCH rcu 11/27] drivers/dax: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:37:57 -0800
Message-Id: <20230105003813.1770367-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
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

