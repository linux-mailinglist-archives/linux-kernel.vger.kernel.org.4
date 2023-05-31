Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D165A71826B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEaNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbjEaNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077D10FB;
        Wed, 31 May 2023 06:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7A761527;
        Wed, 31 May 2023 13:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8F6C4339B;
        Wed, 31 May 2023 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540483;
        bh=e6FiqSpPzrIqBr4ifo3Fy2T912kqqu+DYRXAE8MmA+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lM5Gf4c3fJiYTFcu/4MvT6RW4g62v9bgno8RmTgrW+4oLsyJBesv7aN3Bwphb1ykH
         VpiRgMJFImfZJ4mhoLCHUDtLUk0fB2Juh+Tjp/sSvqK250B4yVHbm6k0lef8uOyolJ
         CPVW8hFcGY6GdyCc11Sx8h1BARpBkuBmTOKqhaBdjPFuRJs6SaW2rsaceMeky8OJCN
         xXqRS4W06nytudlUAqpyZ83x9b6GrLQMxPjUWC0qi0i2hwvZjRxODqk5Lh59cJ7q3i
         vgXU2067PyJJrRBiSoxMCzSBWK6/9V9ClpfKuXS9Rm3wmrQi6N2IXIac3g2ExwwASI
         9Fldel0C6+TtA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Chao Yu <chao@kernel.org>, Sasha Levin <sashal@kernel.org>,
        xiang@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.3 27/37] erofs: use HIPRI by default if per-cpu kthreads are enabled
Date:   Wed, 31 May 2023 09:40:09 -0400
Message-Id: <20230531134020.3383253-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit cf7f2732b4b83026842832e7e4e04bf862108ac2 ]

As Sandeep shown [1], high priority RT per-cpu kthreads are
typically helpful for Android scenarios to minimize the scheduling
latencies.

Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
EROFS_FS_PCPU_KTHREAD.

Also clean up unneeded sched_set_normal().

[1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Sandeep Dhavale <dhavale@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230522092141.124290-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/Kconfig | 1 +
 fs/erofs/zdata.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 704fb59577e09..f259d92c97207 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
 config EROFS_FS_PCPU_KTHREAD_HIPRI
 	bool "EROFS high priority per-CPU kthread workers"
 	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
+	default y
 	help
 	  This permits EROFS to configure per-CPU kthread workers to run
 	  at higher priority.
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f1708c77a9912..d7add72a09437 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -369,8 +369,6 @@ static struct kthread_worker *erofs_init_percpu_worker(int cpu)
 		return worker;
 	if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
 		sched_set_fifo_low(worker->task);
-	else
-		sched_set_normal(worker->task, 0);
 	return worker;
 }
 
-- 
2.39.2

