Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC77108A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjEYJSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbjEYJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:18:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED5E52;
        Thu, 25 May 2023 02:17:53 -0700 (PDT)
Date:   Thu, 25 May 2023 09:17:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685006270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQDHdMweLp26JWI66gNfSmSOqaEQMETapWdZ/4lFbxc=;
        b=gjEQjDT6rfSYn9QE45B8dEYTwTcqa6X1cdLbSvS/inpt7kXDMH3TJScdhol0P1L2Z6AHEG
        jXlNGp9Gsn1jh4Oz0DH5NxX2c6LljjsKe5bvn3BQkfERi8nMKHZoL1klux5uaqllDR56jF
        QhmRDCLYM/mZuY2jfDY6VdiXAE4azmJPBDp4GoUqU+v0lIhMxy9YtCVHZSvqjE/4DagyH/
        QBBls5ji/XEdlqKSV8r71+h6rzcRzRH9uBPdB7SE/ubYDTvHLN3tIt0bN9GBO5jrrjm3Bq
        SFj7KZclhWlK7iNvpSK3gnJnYgWdACal/1CG9zjKmZrTPEIperUcCO0k7/mqzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685006270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQDHdMweLp26JWI66gNfSmSOqaEQMETapWdZ/4lFbxc=;
        b=sRSbVuAD9GfgAYesDUMakDbjTz8Sa6kcUwrNmBE+s4eB7VP+1DqwUu9fQZpQoAJxRzFqso
        MQsL/DjCE1/VE/Aw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/uncore: Correct the number of CHAs on SPR
Cc:     Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230508140206.283708-1-kan.liang@linux.intel.com>
References: <20230508140206.283708-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168500626995.404.15734964484046172688.tip-bot2@tip-bot2>
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

Commit-ID:     38776cc45eb7603df4735a0410f42cffff8e71a1
Gitweb:        https://git.kernel.org/tip/38776cc45eb7603df4735a0410f42cffff8e71a1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 08 May 2023 07:02:06 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 24 May 2023 22:19:41 +02:00

perf/x86/uncore: Correct the number of CHAs on SPR

The number of CHAs from the discovery table on some SPR variants is
incorrect, because of a firmware issue. An accurate number can be read
from the MSR UNC_CBO_CONFIG.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230508140206.283708-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fa9b209..d49e90d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6150,6 +6150,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
 };
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
 #define UNCORE_SPR_UPI				8
@@ -6460,12 +6461,22 @@ static int uncore_type_max_boxes(struct intel_uncore_type **types,
 	return max + 1;
 }
 
+#define SPR_MSR_UNC_CBO_CONFIG		0x2FFE
+
 void spr_uncore_cpu_init(void)
 {
+	struct intel_uncore_type *type;
+	u64 num_cbo;
+
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
 						spr_msr_uncores);
 
+	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
+	if (type) {
+		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
+		type->num_boxes = num_cbo;
+	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
 
