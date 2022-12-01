Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9253363EFAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiLALlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiLALl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:41:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1C91350;
        Thu,  1 Dec 2022 03:41:26 -0800 (PST)
Date:   Thu, 01 Dec 2022 11:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669894884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20X/shqnJzX1Oh66/MzMzbYXDxgdoWyJf5iCsUHX9BA=;
        b=xll5Me8f6Pa15DMhgelcZwShDbfvTeXMsaG5CQRBKubev1lCJTMd4goS2y/W+mT4NKeFW4
        jntDEIQv+7rsYTYrx8W2CyqgtEFQ/dRxy+ykZ1h0ultdLCdNaxlGoV3Zi/2dbXtr72yyHv
        r5V74E3Qy2rvDTXqG9otaxEj0LtUMIau+mmbCt/um6QPjTzNc5TMZt6+KYA9AWftjYrkF1
        w9N2TxlLRTfw8Tn7CkIuY6nbsoBaj/WR+SPZXawi86VrJwNNsQuVqhdk8LBt+BoWYt3cgq
        2vqxpm8ZLAOvIX5F2tx3HVc0FPJFer9/o1xY8Q4ccn25zSR9XcCPJ+3iWe4EnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669894884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20X/shqnJzX1Oh66/MzMzbYXDxgdoWyJf5iCsUHX9BA=;
        b=YGUzUwHipFQJlPTfqiGD5ovYyorfAlRDNqxGjqCh5fNBSNGeq12uSYf3+XUiMb+UGzspO2
        L+a0nggy9hKThHDA==
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpuhp: Set cpuhp target for boot cpu
Cc:     Phil Auld <pauld@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117162329.3164999-3-pauld@redhat.com>
References: <20221117162329.3164999-3-pauld@redhat.com>
MIME-Version: 1.0
Message-ID: <166989488342.4906.6001436828613641642.tip-bot2@tip-bot2>
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

Commit-ID:     f4576ee2315f1ad5f147a356c6e5c223462fd599
Gitweb:        https://git.kernel.org/tip/f4576ee2315f1ad5f147a356c6e5c223462fd599
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 17 Nov 2022 11:23:29 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Dec 2022 12:35:08 +01:00

cpuhp: Set cpuhp target for boot cpu

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
