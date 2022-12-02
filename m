Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6264061A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiLBLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:51:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597C1263D;
        Fri,  2 Dec 2022 03:51:04 -0800 (PST)
Date:   Fri, 02 Dec 2022 11:51:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669981862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYx/N7VkLi9cbwQkwAJUfl0UrZSPQe3r5BCoHYTbRH8=;
        b=KpafTXJXaztJBJbDl9tnm1/AT6mTWHf4Fnqu+kjhE4fnt8oNV3EkiUHL7Qf2OwcYrd8A6F
        h4rlldWZFUzLXQs1A1O15WNNQmAYjpMiWYyAbw4pW+DKKvv3W8faqTowC0pGjKMXJFuMV1
        qr9FW/ZuMKl/lVaNbVQOTkVSuyTltAVJyq+HziqHAo+d/ozrjoXMGtW/SkGD6+PtpZLFG+
        yHBrBqzxbPG21ooA4SMKavOztlKmvK2xZ2SWHNyGL3raHcLtewZ1DZAWB+tdtSTzMWPuBf
        j+JUjVIp53XNFmf/j5nwhDVbPq1o0HXeUGxXX85+LhyLwo3VjQgT/jzCsz8EcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669981862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYx/N7VkLi9cbwQkwAJUfl0UrZSPQe3r5BCoHYTbRH8=;
        b=3isjQppUJqNrN9+T3eb93rnSU/gPzhzIy6zjMcxcLoohe2uafWkfMixPJ3hM8ZvzV4tgqT
        5h8jPlCldzupdxBg==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Make target_store() a nop when target == state
Cc:     Phil Auld <pauld@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117162329.3164999-2-pauld@redhat.com>
References: <20221117162329.3164999-2-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <166998186154.4906.2993867265971193970.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     64ea6e44f85b9b75925ebe1ba0e6e8430cc4e06f
Gitweb:        https://git.kernel.org/tip/64ea6e44f85b9b75925ebe1ba0e6e8430cc4e06f
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 17 Nov 2022 11:23:28 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 12:43:02 +01:00

cpu/hotplug: Make target_store() a nop when target == state

Writing the current state back in hotplug/target calls cpu_down()
which will set cpu dying even when it isn't and then nothing will
ever clear it. A stress test that reads values and writes them back
for all cpu device files in sysfs will trigger the BUG() in
select_fallback_rq once all cpus are marked as dying.

kernel/cpu.c::target_store()
	...
        if (st->state < target)
                ret = cpu_up(dev->id, target);
        else
                ret = cpu_down(dev->id, target);

cpu_down() -> cpu_set_state()
	 bool bringup = st->state < target;
	 ...
	 if (cpu_dying(cpu) != !bringup)
		set_cpu_dying(cpu, !bringup);

Fix this by letting state==target fall through in the target_store()
conditional. Also make sure st->target == target in that case.

Fixes: 757c989b9994 ("cpu/hotplug: Make target state writeable")
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20221117162329.3164999-2-pauld@redhat.com


---
 kernel/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e3..979de99 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2326,8 +2326,10 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
 
 	if (st->state < target)
 		ret = cpu_up(dev->id, target);
-	else
+	else if (st->state > target)
 		ret = cpu_down(dev->id, target);
+	else if (WARN_ON(st->target != target))
+		st->target = target;
 out:
 	unlock_device_hotplug();
 	return ret ? ret : count;
