Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1063785B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKXMDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiKXMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F041DA5B;
        Thu, 24 Nov 2022 04:02:50 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhC6bmc4f+IfIIYmCCearwAZxy7ciSOUUxSt5WzBXeE=;
        b=W+9rkPqhVnYU5wg+2xM71y09bEFNtIfcKTQJ6cQ+2ybJT19IdS8EjNVbOM09jZCLelSTjS
        uZumMlNGd7Kb+3bZMOQPSZyMXTSxIYMCL1SjSjfGI+n3xKgZwMl690gjXe2IwkMzMFkhAx
        bWMEy/VV8pvuluHccxIEK33qyJODzr65Y5Jv01uZYm258MLdquwcQBpB2Xj1eVNgibb4Xz
        ysaRXsEhD0XPJVXlpfbQERlR6Q5HAV/15o1ACf/30KqTHP6i0wxoOYZVrImZS1HPOIa0NH
        p6lj+gqrD2sGWoljANCqUzgx03EcPR3zSddAPevRkLnEX4QJtRe+ePFberfvcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhC6bmc4f+IfIIYmCCearwAZxy7ciSOUUxSt5WzBXeE=;
        b=tOXDDpHUMFYAATNyqm6T11zQXVhpRst4FM/MRryUPh9lTYXZbkWZ/R6mS/R3r43gpyRRdl
        ixmMiTCsxmzrwZDQ==
From:   "tip-bot2 for Xiongfeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix reference count leak in
 snr_uncore_mmio_map()
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221118063137.121512-4-wangxiongfeng2@huawei.com>
References: <20221118063137.121512-4-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Message-ID: <166929136687.4906.12321459785416092407.tip-bot2@tip-bot2>
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

Commit-ID:     8ebd16c11c346751b3944d708e6c181ed4746c39
Gitweb:        https://git.kernel.org/tip/8ebd16c11c346751b3944d708e6c181ed4746c39
Author:        Xiongfeng Wang <wangxiongfeng2@huawei.com>
AuthorDate:    Fri, 18 Nov 2022 14:31:36 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:25 +01:00

perf/x86/intel/uncore: Fix reference count leak in snr_uncore_mmio_map()

pci_get_device() will increase the reference count for the returned
pci_dev, so snr_uncore_get_mc_dev() will return a pci_dev with its
reference count increased. We need to call pci_dev_put() to decrease the
reference count. Let's add the missing pci_dev_put().

Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221118063137.121512-4-wangxiongfeng2@huawei.com
---
 arch/x86/events/intel/uncore_snbep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 93b0f1f..44c2f87 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5111,6 +5111,8 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
 
 	addr += box_ctl;
 
+	pci_dev_put(pdev);
+
 	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
