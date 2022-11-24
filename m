Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07E637871
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKXMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiKXMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C870D5DBBE;
        Thu, 24 Nov 2022 04:03:02 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:03:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0Csns0uJcI6Lq/y/XzVMD70M11AN2aKFnW+liiXq24=;
        b=yK3YHTJ7RZpthjk/aVQPMazd86AcFzU5mnsAiVBml1Gx2lCtpA7wpUMgZE3Uhtu8H9e1Dk
        Kixbem7AxrpGOYEb+UzQrWbdz3Qonz6WxX99sWbS0yzXXDY/ahvinvzAYfJBWACqRtFYTf
        RrRzkXTxgd6EJMuLTkQ+vstMKN4VIzpgaCpTR19RON9bjIi7OBdq0vvNBaKXYO4I7Q+gGR
        vO7i1wPJVCnSLxcMzFRg1WGuLw/r/MFV7cdwPBJuRkNEy0gFSLy/ouNyR/Sv/bmM2nRgs5
        QOosBoUYeVx7LFe8Tepv9unYQPb2oFVAn7fV/0NI1/yLyEjsS7a0AQoCtMZmQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0Csns0uJcI6Lq/y/XzVMD70M11AN2aKFnW+liiXq24=;
        b=Ranwb3UYxFKVnOrj6pXa+K8FJw4MZnxzxr7SqpfO+GFhbge1G0b7L81T4xebJtI9BaMBKf
        v1siHVL8eillt1Cw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Introduce UPI topology type
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-3-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-3-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929138025.4906.5421690673614116457.tip-bot2@tip-bot2>
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

Commit-ID:     cee4eebd9158d9eb3f8c1708c297b219e8ea861f
Gitweb:        https://git.kernel.org/tip/cee4eebd9158d9eb3f8c1708c297b219e8ea861f
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:24 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:20 +01:00

perf/x86/intel/uncore: Introduce UPI topology type

This patch introduces new 'uncore_upi_topology' topology type to support
UPI topology discovery.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-3-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore.h       | 7 +++++++
 arch/x86/events/intel/uncore_snbep.c | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 917cff1..ef14149 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -183,11 +183,18 @@ struct uncore_iio_topology {
 	int segment;
 };
 
+struct uncore_upi_topology {
+	int die_to;
+	int pmu_idx_to;
+	int enabled;
+};
+
 struct intel_uncore_topology {
 	int pmu_idx;
 	union {
 		void *untyped;
 		struct uncore_iio_topology *iio;
+		struct uncore_upi_topology *upi;
 	};
 };
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 469ff88..d3323f1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3774,11 +3774,13 @@ static int die_to_cpu(int die)
 
 enum {
 	IIO_TOPOLOGY_TYPE,
+	UPI_TOPOLOGY_TYPE,
 	TOPOLOGY_MAX
 };
 
 static const size_t topology_size[TOPOLOGY_MAX] = {
-	sizeof(*((struct intel_uncore_topology *)NULL)->iio)
+	sizeof(*((struct intel_uncore_topology *)NULL)->iio),
+	sizeof(*((struct intel_uncore_topology *)NULL)->upi)
 };
 
 static int pmu_alloc_topology(struct intel_uncore_type *type, int topology_type)
