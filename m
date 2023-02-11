Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8D69300A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBKKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:38:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3641F93A;
        Sat, 11 Feb 2023 02:38:24 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QSrG8FFwfsx4nvntDnzdp1Gs9dEYdlpmf7UcE2p/kGg=;
        b=KmkdO2o7DWqtmTs/CfwvasJJuKEU0N8CLznRDJYnbMnWQq9S8T9dQBe8Ipw0c+PimgSdtX
        SnvGSDT/qqq/3wqmKO6yeDFT6G0f7Bku1gDamPSGJr+NgFUwgbyfZirbNdBZ3UhYrf+jDJ
        211TWJRMamal1WRs/lc3wZ0iB9JL95La8XpC7bD3Lf21VCwGiiDPuBSiAEImAw181P4cA/
        /40SbjcisCTKZXd+mkjRvCX4cEDAPHpkPW+sVh0WfAtvxVim1ya+xpTealflyh+tnFYYZs
        Roh5Q3QD5nq11Oa6Hi0lEAOIZLMFB4+YB41U7GgIoVnQNi4c/JCxZ0JToHRMOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QSrG8FFwfsx4nvntDnzdp1Gs9dEYdlpmf7UcE2p/kGg=;
        b=6HBBZ1g/eJggwOniAeVvuJv6bkIJUdZtq2oaGsdWZ3iF7RtSpI7uvyJ7gN2iC3FC0/7gGH
        yQqNQmfUxoRngGBg==
From:   "tip-bot2 for silviazhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/perf/zhaoxin: Add stepping check for ZXC
Cc:     Arjan <8vvbbqzo567a@nospam.xutrox.com>,
        Kevin Brace <kevinbrace@gmx.com>,
        silviazhao <silviazhao-oc@zhaoxin.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167611190278.4906.4557467380127146450.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fd636b6a9bc6034f2e5bb869658898a2b472c037
Gitweb:        https://git.kernel.org/tip/fd636b6a9bc6034f2e5bb869658898a2b472c037
Author:        silviazhao <silviazhao-oc@zhaoxin.com>
AuthorDate:    Wed, 08 Feb 2023 16:27:22 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:12 +01:00

x86/perf/zhaoxin: Add stepping check for ZXC

Some of Nano series processors will lead GP when accessing
PMC fixed counter. Meanwhile, their hardware support for PMC
has not announced externally. So exclude Nano CPUs from ZXC
by checking stepping information. This is an unambiguous way
to differentiate between ZXC and Nano CPUs.

Following are Nano and ZXC FMS information:
Nano FMS: Family=6, Model=F, Stepping=[0-A][C-D]
ZXC FMS:  Family=6, Model=F, Stepping=E-F OR
          Family=6, Model=0x19, Stepping=0-3

Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")

Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
Reported-by: Kevin Brace <kevinbrace@gmx.com>
Signed-off-by: silviazhao <silviazhao-oc@zhaoxin.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389
---
 arch/x86/events/zhaoxin/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 949d845..3e9acda 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -541,7 +541,13 @@ __init int zhaoxin_pmu_init(void)
 
 	switch (boot_cpu_data.x86) {
 	case 0x06:
-		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
+		/*
+		 * Support Zhaoxin CPU from ZXC series, exclude Nano series through FMS.
+		 * Nano FMS: Family=6, Model=F, Stepping=[0-A][C-D]
+		 * ZXC FMS: Family=6, Model=F, Stepping=E-F OR Family=6, Model=0x19, Stepping=0-3
+		 */
+		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
+			boot_cpu_data.x86_model == 0x19) {
 
 			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
 
