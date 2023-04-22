Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807626EB7EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDVHur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 03:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C11BDD;
        Sat, 22 Apr 2023 00:50:44 -0700 (PDT)
Date:   Sat, 22 Apr 2023 07:50:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682149842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp72LK9WaclJ5pxZEmvQTdkDkgnKqBFZ36Ua+p4S1L4=;
        b=kbh0TBfYYaPSjZtNZmsi0AjbPVypLTkkoIknelpgBOR0fusNkaE6UZg9ZacaiiPqVEpllc
        q/IHTRsPMEk6mjYEFez1SnfZcj9axqeUyl0CDuEIPRB4Ki79NqAULiiSL7t/8biKRo5uwQ
        b1yxKV81blMPQx1Tk3w40scVbJOKTANyrb8dze6WmvBHc8htDtEwTiO1zVUaLY8kA6mK4J
        7oQklLrR9sph0QsbF9hDTVZm4gkpvZdnNiNWzkRGhaMboQfS5TKeAHl7x85toOu5akcbMD
        4LvHtx0LRVJO9D+FcI8dGjS55OhGAyAhDT5RLad5iha8FFgghBBUYzKFl/qEWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682149842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp72LK9WaclJ5pxZEmvQTdkDkgnKqBFZ36Ua+p4S1L4=;
        b=XJacbsippoNtco/F8fnx7kKWI05HXVglmzIO3utWeK9sMtPV7SfH1aWgEVIsd7/KEywZgk
        SBdL2dPyGqPNA+Cw==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add events for Intel SPR IMC PMU
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230419214241.2310385-1-eranian@google.com>
References: <20230419214241.2310385-1-eranian@google.com>
MIME-Version: 1.0
Message-ID: <168214984206.404.825013264888504546.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     743767d6f6b8f28228be181fe369657f7ecd1eb2
Gitweb:        https://git.kernel.org/tip/743767d6f6b8f28228be181fe369657f7ecd1eb2
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 19 Apr 2023 14:42:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Apr 2023 13:24:23 +02:00

perf/x86/intel/uncore: Add events for Intel SPR IMC PMU

Add missing clockticks and cas_count_* events for Intel SapphireRapids IMC
PMU. These events are useful to measure memory bandwidth.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230419214241.2310385-1-eranian@google.com
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7d11995..fa9b209 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6068,6 +6068,17 @@ static struct intel_uncore_ops spr_uncore_mmio_ops = {
 	.read_counter		= uncore_mmio_read_counter,
 };
 
+static struct uncore_event_desc spr_uncore_imc_events[] = {
+	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=0x01,umask=0x00"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read,  "event=0x05,umask=0xcf"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_read.unit, "MiB"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write, "event=0x05,umask=0xf0"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write.scale, "6.103515625e-5"),
+	INTEL_UNCORE_EVENT_DESC(cas_count_write.unit, "MiB"),
+	{ /* end: all zeroes */ },
+};
+
 static struct intel_uncore_type spr_uncore_imc = {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			= "imc",
@@ -6075,6 +6086,7 @@ static struct intel_uncore_type spr_uncore_imc = {
 	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
 	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
 	.ops			= &spr_uncore_mmio_ops,
+	.event_descs		= spr_uncore_imc_events,
 };
 
 static void spr_uncore_pci_enable_event(struct intel_uncore_box *box,
