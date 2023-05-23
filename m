Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FFE70D719
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjEWISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjEWIRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:17:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75BFE;
        Tue, 23 May 2023 01:15:51 -0700 (PDT)
Date:   Tue, 23 May 2023 08:15:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684829747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSC48ejrFN1szNw+99ZFEvTjXIrUUeq57tpcf9Ujqnc=;
        b=FJLmWUMQoaYV6Vt2wS1axS4sZink+fnW1KTOFU8edXwGOCxlilZ/gFCxJjbW1IpQDTnfJT
        AKhWWyB5NfPoI9W0767/Hoqsyre2Y/4jtghqaxaELd+QBil3aI6fhrkEG+xs+7qWuEdE41
        AF8FO9oFAldHMBT80hcMDphaqWYIA6Y48TaXkUZAtnJPMiRNyf0zchJJofQeSBe28MjKHV
        e5OvABbiqZe2Wv9PNTdSvrJnYdXYMT0fNYG1OvTuduo2wquI3loiRQgit2kAtVaFl0RJPX
        g10j/DsasxkZ2CTfM+oVwbcrgYu4rPJeKB7j5q7k9PzDk8SA0RnBp5pi2PN5rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684829747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSC48ejrFN1szNw+99ZFEvTjXIrUUeq57tpcf9Ujqnc=;
        b=0PNorpVbfhzsbmJjRDYluqjwmmcZBkOOMpOzAnJBu/83r0+iRXkRP8mBFCAs3fEuWYEtfy
        IMNiw0DDZTq9gHDA==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Save/restore
 cpuc->active_pebs_data_cfg when using guest PEBS
Cc:     Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230517133808.67885-1-likexu@tencent.com>
References: <20230517133808.67885-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <168482974681.404.11952331540708115887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3c845304d2d723f20d5b91fef5d133ff94825d76
Gitweb:        https://git.kernel.org/tip/3c845304d2d723f20d5b91fef5d133ff94825d76
Author:        Like Xu <likexu@tencent.com>
AuthorDate:    Wed, 17 May 2023 21:38:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 May 2023 10:01:13 +02:00

perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg when using guest PEBS

After commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
PEBS_DATA_CFG"), the cpuc->pebs_data_cfg may save some bits that are not
supported by real hardware, such as PEBS_UPDATE_DS_SW. This would cause
the VMX hardware MSR switching mechanism to save/restore invalid values
for PEBS_DATA_CFG MSR, thus crashing the host when PEBS is used for guest.
Fix it by using the active host value from cpuc->active_pebs_data_cfg.

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230517133808.67885-1-likexu@tencent.com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 070cc4e..89b9c1c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		arr[(*nr)++] = (struct perf_guest_switch_msr){
 			.msr = MSR_PEBS_DATA_CFG,
-			.host = cpuc->pebs_data_cfg,
+			.host = cpuc->active_pebs_data_cfg,
 			.guest = kvm_pmu->pebs_data_cfg,
 		};
 	}
