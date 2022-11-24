Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311BA637862
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKXMDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiKXMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC0429AF;
        Thu, 24 Nov 2022 04:02:56 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd1LmwmVBOjaFol/GblfD0929B3ZMFGVk5MHkiZ3ohU=;
        b=TbLSLQNVbwfxWN9AvGz5Jdj8+OlVIvUjfdQtPueGEpta/tJSp1BEgJowZfdTosFa10fxe0
        cv9ta3C9Y6e4Wx9dDTfEOirXb8S0O+o9qmU+Lpd4lIf7DFTzNIpKFgM+/ITW7oazR3Pq9i
        yUYvFBc+G9mBMP58rZ6cOLyVxGxz3Lfnkq1xoXrg5V7LQ8DdaTTVgZldBOKTlXzUCpdkXU
        asoWDrE6siDce03Y8XxMApccn2Ob86x3OpCCdRs1y1HboJIoSfT6NN14yDwEgjVneH4nnI
        ikv9JYbEjxk4jiHNMPP8VwTsb+D3jPBV3JaQwSGKflIw6R9Myj5eB1zFe681dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd1LmwmVBOjaFol/GblfD0929B3ZMFGVk5MHkiZ3ohU=;
        b=/MNCgWN9yrKoZlUqKQ66M5+JlCzqS3TIOiREAWpQXQ9rZsvpO8bFi8EjgJCImDLHSVySc7
        4vvx7LH0mG+yNsAQ==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Enable UPI topology discovery
 for Sapphire Rapids
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-10-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-10-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137262.4906.16113917831053227871.tip-bot2@tip-bot2>
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

Commit-ID:     9a3b675cd393a4430d5e6cbf94c5de43414613cd
Gitweb:        https://git.kernel.org/tip/9a3b675cd393a4430d5e6cbf94c5de43414613cd
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:31 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:23 +01:00

perf/x86/intel/uncore: Enable UPI topology discovery for Sapphire Rapids

UPI topology discovery on SPR is same as in ICX but UBOX device has
different Device ID 0x3250.

This patch enables /sys/devices/uncore_upi_*/die* attributes on SPR.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-10-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 43 ++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d45f584..4c2d5b5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -458,6 +458,7 @@
 
 /* SPR */
 #define SPR_RAW_EVENT_MASK_EXT			0xffffff
+#define SPR_UBOX_DID				0x3250
 
 /* SPR CHA */
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
@@ -6112,9 +6113,43 @@ static struct intel_uncore_type spr_uncore_m2m = {
 	.name			= "m2m",
 };
 
+static struct attribute_group spr_upi_mapping_group = {
+	.is_visible	= skx_upi_mapping_visible,
+};
+
+static const struct attribute_group *spr_upi_attr_update[] = {
+	&uncore_alias_group,
+	&spr_upi_mapping_group,
+	NULL
+};
+
+#define SPR_UPI_REGS_ADDR_DEVICE_LINK0	0x01
+
+static int spr_upi_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_upi_set_mapping(type, &spr_upi_mapping_group);
+}
+
+static void spr_upi_cleanup_mapping(struct intel_uncore_type *type)
+{
+	pmu_cleanup_mapping(type, &spr_upi_mapping_group);
+}
+
+static int spr_upi_get_topology(struct intel_uncore_type *type)
+{
+	return discover_upi_topology(type, SPR_UBOX_DID, SPR_UPI_REGS_ADDR_DEVICE_LINK0);
+}
+
 static struct intel_uncore_type spr_uncore_upi = {
-	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.format_group		= &spr_uncore_raw_format_group,
+	.ops			= &spr_uncore_pci_ops,
 	.name			= "upi",
+	.attr_update		= spr_upi_attr_update,
+	.get_topology		= spr_upi_get_topology,
+	.set_mapping		= spr_upi_set_mapping,
+	.cleanup_mapping	= spr_upi_cleanup_mapping,
 };
 
 static struct intel_uncore_type spr_uncore_m3upi = {
@@ -6318,6 +6353,12 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->format_group = from_type->format_group;
 	if (from_type->attr_update)
 		to_type->attr_update = from_type->attr_update;
+	if (from_type->set_mapping)
+		to_type->set_mapping = from_type->set_mapping;
+	if (from_type->get_topology)
+		to_type->get_topology = from_type->get_topology;
+	if (from_type->cleanup_mapping)
+		to_type->cleanup_mapping = from_type->cleanup_mapping;
 }
 
 static struct intel_uncore_type **
