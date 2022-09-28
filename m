Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2055EE479
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiI1SlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiI1Sk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:40:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4A7754C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:40:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349f88710b2so129334357b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=AKTQvHiwvoKSKsVkI66/u6S6G2oPSkqTUWLlsYVxWU0=;
        b=rdtDSC292qeg8KFcuHwoId2wBao8CuTmZj9xs7RX4Q3wj8/glfdhitzz6zvo6B1bmH
         XyWsGaAykVVX5OymAj21IbfDDexT8Elg8Rk76O08sOSSwg+4FgUkHg+DO9kiDQZVJ8yy
         IWmpxW6Mi8rSIndlM1NBxJwr8+3GK13mxJAsufbgQf0uIG9YPPp+URrFCy6/+lQk+Bf5
         zMEpv9eGZKGd4TpXPJ+1dDCcMrlmsP0ym8XAYN/6+Zr1oe1I423zi7GjD1FBkgTgLl/t
         qy5nacDhDUs7nx5eGGMV+8uRzHvnXoNAuY6KBTCMvXvHzOsjP0NZYECMLl2DFta4fHPs
         Y8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=AKTQvHiwvoKSKsVkI66/u6S6G2oPSkqTUWLlsYVxWU0=;
        b=ARxQZr0OZEjNB1fJRi+uio6gR5Z09eNWHBFFTk6LoQdVgJ8A1iNRgc3X3HPwg2kkCR
         TCVijc3V80OWw2PceK5cCjYGvT7c5ug2xIEqrrOtbY69Jk7CmdfVdCwVUPwxJSwOfXHG
         plqyJ+AJ4dGb2+b7S/Oe4875xKISUlMvMrBtLopCYsowj2y3acxK1WrRlpHnmoFL+r96
         2BOCoHffDI2/IDzYCgYAwOhJib1os4BC9ZJOSAxLHZ1yRORsX1/WptXb0U+pZs6PjRss
         zWIYRlJJ97fm20J3ZCAEyJ03OMtJQ8L5nQXZKF9ftHAcyUFbBBr03NMQ6mqVMfcpPuYG
         vz/w==
X-Gm-Message-State: ACrzQf38Kr2kbMDsyvjmDv4gcZMF6olSp+K1KUT/WugEb0lLpNKmsrvI
        JqqYlvdVucsv+t2O74mf1OATKkEtJHaQyfHdU0DeS6D/FrV3A/ET6YhFkhBnFoFenWJk/DkzsUF
        m2GUf//BkMKBcKaJnoyZv2PtbnEqrCjAOU4BvXryqs8fgrNloSt1BKJhb0Fo2qwbJ/ORweatQ
X-Google-Smtp-Source: AMsMyM5Nj3EJMs43dt6DsRGMQWeth5T6Lyo2kGLI+4iqa/b8L0SczxhxH0bfI2CpY24VU1Y7Stl64s03mFsN
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:d508:baac:7b11:f912])
 (user=eranian job=sendgmr) by 2002:a25:3b03:0:b0:696:5b34:39eb with SMTP id
 i3-20020a253b03000000b006965b3439ebmr32511362yba.497.1664390455108; Wed, 28
 Sep 2022 11:40:55 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:40:43 -0700
In-Reply-To: <20220928184043.408364-1-eranian@google.com>
Message-Id: <20220928184043.408364-3-eranian@google.com>
Mime-Version: 1.0
References: <20220928184043.408364-1-eranian@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH 2/2] perf/x86/amd/lbr: adjust LBR regardless of filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, sandipan.das@amd.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of fused compare and taken branch instructions, the AMD LBR points to
the compare instruction instead of the branch. Users of LBR usually expects
the from address to point to a branch instruction. The kernel has code to
adjust the from address via get_branch_type_fused(). However this correction
is only applied when a branch filter is applied. That means that if no
filter is present, the quality of the data is lower.

Fix the problem by applying the adjustment regardless of the filter setting,
bringing the AMD LBR to the same level as other LBR implementations.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/lbr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 2e1c1573efe7..38a75216c12c 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -99,12 +99,13 @@ static void amd_pmu_lbr_filter(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int br_sel = cpuc->br_sel, offset, type, i, j;
 	bool compress = false;
+	bool fused_only = false;
 	u64 from, to;
 
 	/* If sampling all branches, there is nothing to filter */
 	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
-		return;
+		fused_only = true;
 
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
 		from = cpuc->lbr_entries[i].from;
@@ -116,8 +117,11 @@ static void amd_pmu_lbr_filter(void)
 		 * fusion where it points to an instruction preceding the
 		 * actual branch
 		 */
-		if (offset)
+		if (offset) {
 			cpuc->lbr_entries[i].from += offset;
+			if (fused_only)
+				continue;
+		}
 
 		/* If type does not correspond, then discard */
 		if (type == X86_BR_NONE || (br_sel & type) != type) {
-- 
2.37.3.998.g577e59143f-goog

