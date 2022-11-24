Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6526D63785C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKXMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKXMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A00429AF;
        Thu, 24 Nov 2022 04:02:50 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2aSt7rfgtYYH96lPvOuOtCgk76ld4jgS5BO+XfA3kg=;
        b=eCfQaV/nRj1MDDe8reVCJOGjhHk1yO/CThP8m1WnZzv4gDwORJLLWo4dUWFcezbzjWZhvS
        wN8K2JSVbNyHxZnuIgFWnOzOk8K/U4QCFO/enBdCMcJ22QBCPijmbjZUV3JhYh8CHPSleH
        VC3bGrzdHq0sPbjRfrBh53a8rJUZVBSM9DVdltZN+f8dSTNQv24EQ2sUy95XFOS3r3Nn/X
        I4dOixLWlCvR2M5w4jE5cZd5lnPcSkLkqrdVQzfvLKzBasvZFbTMycK7Jkl1MsckFLKy18
        i/4lPssmdihG2N5RldaAh2C+dwO3wRY/9euSjLiHhmGJ77aytLROWg8SAyUxqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2aSt7rfgtYYH96lPvOuOtCgk76ld4jgS5BO+XfA3kg=;
        b=W/2j0PmYiAO2uwEuyGxXH3k7QzUpCNVaa19rl9NNTcCAaU+Y4yvkMgHPKPsNINVERHnmfe
        FliuHzT61hSyJ3DQ==
From:   "tip-bot2 for Xiongfeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix reference count leak in
 hswep_has_limit_sbox()
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221118063137.121512-3-wangxiongfeng2@huawei.com>
References: <20221118063137.121512-3-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Message-ID: <166929136800.4906.10626350141240755490.tip-bot2@tip-bot2>
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

Commit-ID:     1ff9dd6e7071a561f803135c1d684b13c7a7d01d
Gitweb:        https://git.kernel.org/tip/1ff9dd6e7071a561f803135c1d684b13c7a7d01d
Author:        Xiongfeng Wang <wangxiongfeng2@huawei.com>
AuthorDate:    Fri, 18 Nov 2022 14:31:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:25 +01:00

perf/x86/intel/uncore: Fix reference count leak in hswep_has_limit_sbox()

pci_get_device() will increase the reference count for the returned
'dev'. We need to call pci_dev_put() to decrease the reference count.
Since 'dev' is only used in pci_read_config_dword(), let's add
pci_dev_put() right after it.

Fixes: 9d480158ee86 ("perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221118063137.121512-3-wangxiongfeng2@huawei.com
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b14d591..93b0f1f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -2910,6 +2910,7 @@ static bool hswep_has_limit_sbox(unsigned int device)
 		return false;
 
 	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);
+	pci_dev_put(dev);
 	if (!hswep_get_chop(capid4))
 		return true;
 
