Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1AD640619
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiLBLvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiLBLvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:51:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E0BA62A;
        Fri,  2 Dec 2022 03:51:02 -0800 (PST)
Date:   Fri, 02 Dec 2022 11:50:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669981861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19W2gYZDzqrY8ioEBgK+LQmk60iz1wRdMIHTc/yIsOw=;
        b=mTV9Xaw1jXsvRSwIfdPmowJnGb3y7VZ/Dn4yhQoqs1jg81SaiB2gCuP2g1BEjI345oESS1
        FHF7L8Lw7Ub+kHGZ3pbbUfaIlDQR9/tYfgzwGugc3ArWcHWfdcYY7F5eU4AOBEpkT/We8U
        crQnfjclMduc7Ca87bhRY7HusBqLFWRJQeBdNRw/uE70YMVNOU5mrfzsGd5esrEcJISo+9
        f2d6UP7fOMCQ59dTcCHRfbfvC2xBUqnctvXQZmUQIonRknoV35YVe2SAkI/3MM4FBKnHKe
        2pRrN8AE9HcymtAQCYDQ3Bvgn4ofvef/CejNhYio3BNnevaNm3FiAZbVkGlaKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669981861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19W2gYZDzqrY8ioEBgK+LQmk60iz1wRdMIHTc/yIsOw=;
        b=GsmC8/NHtLTF1ZRJrpMpvMtU/nNiZPQzrMc/A/FDw8miV2SVIOUdrx4tx9Z8c/LgdDSb0Z
        eU+JfXr/yowRjFDg==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Set cpuhp target for boot cpu
Cc:     Phil Auld <pauld@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117162329.3164999-3-pauld@redhat.com>
References: <20221117162329.3164999-3-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <166998185980.4906.17290345122563836511.tip-bot2@tip-bot2>
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

Commit-ID:     d385febc9a19635d4ef197bfad3e84729002f57c
Gitweb:        https://git.kernel.org/tip/d385febc9a19635d4ef197bfad3e84729002f57c
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 17 Nov 2022 11:23:29 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 12:43:02 +01:00

cpu/hotplug: Set cpuhp target for boot cpu

Since the boot cpu does not go through the hotplug process it ends
up with state == CPUHP_ONLINE but target == CPUHP_OFFLINE.
So set the target to match in boot_cpu_hotplug_init().

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20221117162329.3164999-3-pauld@redhat.com


---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 979de99..3f704a8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2690,6 +2690,7 @@ void __init boot_cpu_hotplug_init(void)
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
+	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
 /*
