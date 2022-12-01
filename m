Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1863EFB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLALli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiLALl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:41:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380429582D;
        Thu,  1 Dec 2022 03:41:27 -0800 (PST)
Date:   Thu, 01 Dec 2022 11:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669894885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZMu+Ww/tIWv7+5nct9Y8zaEczZTGJtowfe2b2w4XBM=;
        b=cl33zYaBw6+x2HTKq3LZVbuQ9BL+d3PIERTDStFib0yXCudGYX/8vUNEiXX18IWLl+SrmN
        xoflbDH2hujPJ5Ld0nQKoUreVJqlChZMdnPMq/JEp4UbrXEJt2ZhZtMjDHAygMSkINdpgk
        36HRG0Zzil2VSCMa7RMRR54qRuOhERpIj+aFa+0hcArmz8z2+KXAn7nXJ7uE3yD8zQEJaR
        KcWwtKYMW8w01gv/Fs/NQ7e70grmvYpCm40dF9c33Aat0aFHcAwbkGeuZHu1uu5rVw463H
        B8w7Y1WlmNQpi/t7niTtcIKkhY5IfsOdcCrUJ5ILH8MBPggVwG0kg5sHe0N2RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669894885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZMu+Ww/tIWv7+5nct9Y8zaEczZTGJtowfe2b2w4XBM=;
        b=bb982MO/MHk4b6IlgtjlobBPYW8hV7N3JziIi3RwB7Mu4lWXF7CjxSkLWxR+QJxHnDuvyV
        g8l9F/fd1mZNeZDg==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpuhp: Make target_store() a nop when target == state
Cc:     Phil Auld <pauld@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117162329.3164999-2-pauld@redhat.com>
References: <20221117162329.3164999-2-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <166989488463.4906.8715334204096231628.tip-bot2@tip-bot2>
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

Commit-ID:     0fa5abb6b7d85bf5688b2e11113f50317fb0121c
Gitweb:        https://git.kernel.org/tip/0fa5abb6b7d85bf5688b2e11113f50317fb0121c
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 17 Nov 2022 11:23:28 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Dec 2022 12:35:08 +01:00

cpuhp: Make target_store() a nop when target == state

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
