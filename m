Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1063785E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKXMDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKXMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9753EC5;
        Thu, 24 Nov 2022 04:02:53 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50RKIHAAxW5+CnOS1oKtRt9//pFKNSA1UbDaxKJhB3w=;
        b=o4Zo01jzGrhftZLn5Fdb3YBBnRi48eGdECwWVB2JNXDFLHGGUI8hqguH/llUniRCFOiJvQ
        +kMr+CcS/UUCSn0Pm0VOD8Zsdiv8XRqfJWl20jvgstJkDfWpWXy6BJgcaSdNUfC71MwyDg
        IbLMfpYFoQkW79AUJlNt3sp/yQkP7C1dk2u7/trWXGg86tTV9VYrdxOeku3pVTHBix0yiu
        2ZEKiMHZ0Kv90CgHpEhl7h/C9TsAXkUEpMxlvY9Lra1cjh7Gcdmwy/aCbQqRnfqvxFJkwE
        HCweiBcCF5JumWv9gnyl4dNbN97sLssiQ9LpHpRxepRDDCZdd8Yd7zk/YYTsQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50RKIHAAxW5+CnOS1oKtRt9//pFKNSA1UbDaxKJhB3w=;
        b=vTgfOPTpEXAWegjM6anggIHV1xEo9MpVwKazShPm32837SDIpbRC1LauI5x5E6cGcBgAZ3
        k/ZcsNIrZI46dlAQ==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Make set_mapping() procedure void
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-12-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-12-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137027.4906.15651683522712919440.tip-bot2@tip-bot2>
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

Commit-ID:     d5b73506b5b1b4a6e675c54b7977ea08e64cba19
Gitweb:        https://git.kernel.org/tip/d5b73506b5b1b4a6e675c54b7977ea08e64cba19
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:33 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:24 +01:00

perf/x86/intel/uncore: Make set_mapping() procedure void

Return value of set_mapping() is not needed to be checked anymore.
So, make this procedure void.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-12-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore.h       |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 41 ++++++++++++---------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index fac3612..e278e2e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -94,7 +94,7 @@ struct intel_uncore_type {
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
 	int (*get_topology)(struct intel_uncore_type *type);
-	int (*set_mapping)(struct intel_uncore_type *type);
+	void (*set_mapping)(struct intel_uncore_type *type);
 	void (*cleanup_mapping)(struct intel_uncore_type *type);
 };
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4c2d5b5..b8f9bd1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3924,7 +3924,7 @@ static void pmu_clear_mapping_attr(const struct attribute_group **groups,
 	}
 }
 
-static int
+static void
 pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 		ssize_t (*show)(struct device*, struct device_attribute*, char*),
 		int topology_type)
@@ -3943,8 +3943,6 @@ pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 	if (ret < 0)
 		goto clear_topology;
 
-	ret = -ENOMEM;
-
 	/* One more for NULL. */
 	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
@@ -3968,7 +3966,7 @@ pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 	}
 	ag->attrs = attrs;
 
-	return 0;
+	return;
 err:
 	for (; die >= 0; die--)
 		kfree(eas[die].attr.attr.name);
@@ -3979,7 +3977,6 @@ clear_topology:
 	pmu_free_topology(type);
 clear_attr_update:
 	pmu_clear_mapping_attr(type->attr_update, ag);
-	return ret;
 }
 
 static void
@@ -3998,15 +3995,15 @@ pmu_cleanup_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 	pmu_free_topology(type);
 }
 
-static int
+static void
 pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
-	return pmu_set_mapping(type, ag, skx_iio_mapping_show, IIO_TOPOLOGY_TYPE);
+	pmu_set_mapping(type, ag, skx_iio_mapping_show, IIO_TOPOLOGY_TYPE);
 }
 
-static int skx_iio_set_mapping(struct intel_uncore_type *type)
+static void skx_iio_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_iio_set_mapping(type, &skx_iio_mapping_group);
+	pmu_iio_set_mapping(type, &skx_iio_mapping_group);
 }
 
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
@@ -4382,15 +4379,15 @@ static const struct attribute_group *skx_upi_attr_update[] = {
 	NULL
 };
 
-static int
+static void
 pmu_upi_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
-	return pmu_set_mapping(type, ag, skx_upi_mapping_show, UPI_TOPOLOGY_TYPE);
+	pmu_set_mapping(type, ag, skx_upi_mapping_show, UPI_TOPOLOGY_TYPE);
 }
 
-static int skx_upi_set_mapping(struct intel_uncore_type *type)
+static void skx_upi_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_upi_set_mapping(type, &skx_upi_mapping_group);
+	pmu_upi_set_mapping(type, &skx_upi_mapping_group);
 }
 
 static void skx_upi_cleanup_mapping(struct intel_uncore_type *type)
@@ -4773,9 +4770,9 @@ static int snr_iio_get_topology(struct intel_uncore_type *type)
 	return sad_cfg_iio_topology(type, snr_sad_pmon_mapping);
 }
 
-static int snr_iio_set_mapping(struct intel_uncore_type *type)
+static void snr_iio_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_iio_set_mapping(type, &snr_iio_mapping_group);
+	pmu_iio_set_mapping(type, &snr_iio_mapping_group);
 }
 
 static void snr_iio_cleanup_mapping(struct intel_uncore_type *type)
@@ -5391,14 +5388,14 @@ static int icx_iio_get_topology(struct intel_uncore_type *type)
 	return sad_cfg_iio_topology(type, icx_sad_pmon_mapping);
 }
 
-static int icx_iio_set_mapping(struct intel_uncore_type *type)
+static void icx_iio_set_mapping(struct intel_uncore_type *type)
 {
 	/* Detect ICX-D system. This case is not supported */
 	if (boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_D) {
 		pmu_clear_mapping_attr(type->attr_update, &icx_iio_mapping_group);
-		return -EPERM;
+		return;
 	}
-	return pmu_iio_set_mapping(type, &icx_iio_mapping_group);
+	pmu_iio_set_mapping(type, &icx_iio_mapping_group);
 }
 
 static void icx_iio_cleanup_mapping(struct intel_uncore_type *type)
@@ -5656,9 +5653,9 @@ static const struct attribute_group *icx_upi_attr_update[] = {
 	NULL
 };
 
-static int icx_upi_set_mapping(struct intel_uncore_type *type)
+static void icx_upi_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_upi_set_mapping(type, &icx_upi_mapping_group);
+	pmu_upi_set_mapping(type, &icx_upi_mapping_group);
 }
 
 static void icx_upi_cleanup_mapping(struct intel_uncore_type *type)
@@ -6125,9 +6122,9 @@ static const struct attribute_group *spr_upi_attr_update[] = {
 
 #define SPR_UPI_REGS_ADDR_DEVICE_LINK0	0x01
 
-static int spr_upi_set_mapping(struct intel_uncore_type *type)
+static void spr_upi_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_upi_set_mapping(type, &spr_upi_mapping_group);
+	pmu_upi_set_mapping(type, &spr_upi_mapping_group);
 }
 
 static void spr_upi_cleanup_mapping(struct intel_uncore_type *type)
