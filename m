Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCF613D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJaSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJaSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:15:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813EB65C6;
        Mon, 31 Oct 2022 11:15:11 -0700 (PDT)
Date:   Mon, 31 Oct 2022 18:15:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667240109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwgO5XEJCp0Zffmg4gdserNs+oDiJwvtqN0WugL8MiM=;
        b=m8Lf4rvCdtKN7G7frjl9AmkOws+ZjWwUeRtw5JAcUw7bapDcKan/rLGsSlJ3URyfanbg8+
        +VijeDyiphBCtNXdsrkwHkPlH0uxd/KB1bP4yEqukdL1VV9iW/wGdwwYQCU6MRaIa5W0uK
        fYPMarEB3FYknitjhcrnejRMwdJ+IulBTMAKCuizZrl5/M/3BdehadSqCF0eq4E8B5+3iV
        SnHrSlBv5zGBq2HaqilWYQHeaWuT9QBqrTQIRdRg4DeSrbezzQZw6qaugKZ3WQw5wEwTDI
        CXoVOFUvwC7i9wykL7Lrn20qslBT1SV4ZgCNM7a/iLK2Yzb0SdThnNGXdk+Ycg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667240109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwgO5XEJCp0Zffmg4gdserNs+oDiJwvtqN0WugL8MiM=;
        b=1AXIBTck4nhnv6YivWHCyMwKkiU7guMhDHlQPzdMeIJ8YcP/MzLw5D63udjV3G3y0QbwOj
        BhHOn+7USsCPU/AQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] RAS: Fix return value from show_trace()
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221018165900.109029-1-tony.luck@intel.com>
References: <20221018165900.109029-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <166724010782.7716.13211418678900484853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     50865c14f34edbd03f8113147fac069b39f4e390
Gitweb:        https://git.kernel.org/tip/50865c14f34edbd03f8113147fac069b39f4e390
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 18 Oct 2022 09:59:00 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 31 Oct 2022 18:55:18 +01:00

RAS: Fix return value from show_trace()

Documentation/filesystems/seq_file.rst describes the possible return
values from a "show()" function used by single_open().

show_trace() returns the value of "trace_count". This could be
interpreted as "SEQ_SKIP", or just confuse the calling function.

Change to just return "0" to avoid confusing anyone reading this code
and possibly using as a template. Reading "daemon_active" was never
an intended use case.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221018165900.109029-1-tony.luck@intel.com
---
 drivers/ras/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 0d4f985..f0a6391 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -15,7 +15,7 @@ EXPORT_SYMBOL_GPL(ras_userspace_consumers);
 
 static int trace_show(struct seq_file *m, void *v)
 {
-	return atomic_read(&trace_count);
+	return 0;
 }
 
 static int trace_open(struct inode *inode, struct file *file)
