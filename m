Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0C6170A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiKBWXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiKBWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:23:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA94AE42;
        Wed,  2 Nov 2022 15:23:10 -0700 (PDT)
Date:   Wed, 02 Nov 2022 22:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667427788;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJFFxTBTuJKMnzFJ4AteZowL/17syVKOLV0VVt689mc=;
        b=dZl8gbyg6m9LZaZLUioxV64iS2pg0AhIwj+Cq9H6GB5/GOEAHRAFtFYTd7aOOFNuC0ZUB8
        8Jm+R/J18fVa/SLj83otEFSmZvCzZkQmnVquSTK7CUFJSm5hjSR6J4dAD3xYVVAcnaax7E
        uncagbatC4nf+OjYXUG3xgRuX5Gl7p+H2w/FmAfZzkXD+AcgZ7n2MrmALnHZXT9Za3I1um
        fPc6h5pt7Q3Lpv+ANCySEW/SFPPP32+K25N1J83a4PMHzVZDaV/XDOpVOIQkvumlLPuUPl
        sk340MwFK0hxAGkdlI7+C0XLCUSn6WPrWooxJXU6GzB6XiwxWSmxTPN/4in9tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667427788;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJFFxTBTuJKMnzFJ4AteZowL/17syVKOLV0VVt689mc=;
        b=a39BTn9i/EuhgdRVmnmbI9omnklO9E86n9ON8iJPk+Ges1lbdSOEspT3JGzfNTUlFXLZYu
        ssLlbkxJYkoLcABA==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Use standard Energy Unit for SPR
 Dram RAPL domain
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Wang Wendy <wendy.wang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220924054738.12076-3-rui.zhang@intel.com>
References: <20220924054738.12076-3-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <166742778760.6127.12132934184185495445.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     80275ca9e525c198c7efe045c4a6cdb68a2ea763
Gitweb:        https://git.kernel.org/tip/80275ca9e525c198c7efe045c4a6cdb68a2ea763
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Sat, 24 Sep 2022 13:47:37 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Nov 2022 12:22:05 +01:00

perf/x86/rapl: Use standard Energy Unit for SPR Dram RAPL domain

Intel Xeon servers used to use a fixed energy resolution (15.3uj) for
Dram RAPL domain. But on SPR, Dram RAPL domain follows the standard
energy resolution as described in MSR_RAPL_POWER_UNIT.

Remove the SPR Dram energy unit quirk.

Fixes: bcfd218b6679 ("perf/x86/rapl: Add support for Intel SPR platform")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Link: https://lkml.kernel.org/r/20220924054738.12076-3-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index fea544e..a829492 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -619,12 +619,8 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
-	/*
-	 * SPR shares the same DRAM domain energy unit as HSW, plus it
-	 * also has a fixed energy unit for Psys domain.
-	 */
+	/* SPR uses a fixed energy unit for Psys domain. */
 	case RAPL_UNIT_QUIRK_INTEL_SPR:
-		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
 		break;
 	default:
