Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913DA720EBF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjFCIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjFCIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 04:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F099
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 01:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E1D611EC
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 08:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F6C433EF;
        Sat,  3 Jun 2023 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685780727;
        bh=lrvIs143i3Pxz9r3Gm1Pr/kZAvhZhs6EQjK8HuL5Hq8=;
        h=From:To:Cc:Subject:Date:From;
        b=Mm+X73c1lFTTQZd0++r5kHtOj2KwE4AlVFnKwX8vmWlsIJzDA5hkKh9Y2ivj4zen/
         PYiwHAHN/62HD51t0JyFvh5KKgHiQlCOrhS5dTqGX6tpJJaCxNbMoaUwwMnffYTPU6
         IVC2rUpvVxmb2tthg3IOKu2j1ge+DnJ8FzDgkeE++DJAoQrQ4c4WpIO60WYkUbOXIa
         0evwKYuBW0+/ohnoKtDOSqI95j/Cou+V6r7QtMtqI+o6ekFlV2BRA1Rtw6W/BSxhbz
         OBJuwMk/CtcwfRJYymwq85wN6gnhPkH9AJLtVcDCLd+zu4fGIqJozhMivtBVIaVXxJ
         2cxDB4phNc2pg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1q5MZg-002WkT-Vv;
        Sat, 03 Jun 2023 09:25:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Reiji Watanabe <reijiw@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] perf/core: Drop __weak attribute from arch_perf_update_userpage() prototype
Date:   Sat,  3 Jun 2023 09:25:19 +0100
Message-Id: <20230603082519.1088285-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, reijiw@google.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reiji reports that the arm64 implementation of arch_perf_update_userpage()
is now ignored and replaced by the dummy stub in core code.
This seems to happen since the PMUv3 driver was moved to driver/perf.

As it turns out, dropping the __weak attribute from the *prototype*
of the function solves the problem. You're right, this doesn't seem
to make much sense. And yet... It appears that both symbols get
flagged as weak, and that the first one to appear in the link order
wins:

$ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
0000000000001db0 W arch_perf_update_userpage

Dropping the attribute from the prototype restores the expected
behaviour, and arm64 is able to enjoy arch_perf_update_userpage()
again.

Reported-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/perf_event.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..c8dcfdbda1f4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1845,9 +1845,9 @@ int perf_event_exit_cpu(unsigned int cpu);
 #define perf_event_exit_cpu	NULL
 #endif
 
-extern void __weak arch_perf_update_userpage(struct perf_event *event,
-					     struct perf_event_mmap_page *userpg,
-					     u64 now);
+extern void arch_perf_update_userpage(struct perf_event *event,
+				      struct perf_event_mmap_page *userpg,
+				      u64 now);
 
 #ifdef CONFIG_MMU
 extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
-- 
2.34.1

