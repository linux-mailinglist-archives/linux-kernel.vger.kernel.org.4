Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD163D0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiK3Ifl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiK3IfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:35:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF36A1FF94
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:33:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046FFD6E;
        Wed, 30 Nov 2022 00:34:06 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.43.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E749C3F73B;
        Wed, 30 Nov 2022 00:33:56 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm_pmu: Drop redundant armpmu->map_event() in armpmu_event_init()
Date:   Wed, 30 Nov 2022 14:03:50 +0530
Message-Id: <20221130083350.264583-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__hw_perf_event_init() already calls armpmu->map_event() callback, and also
returns its error code including -ENOENT, along with a debug callout. Hence
an additional armpmu->map_event() check for -ENOENT is redundant.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc6

 drivers/perf/arm_pmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 6538cec1a601..4be6869005f1 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -529,10 +529,6 @@ static int armpmu_event_init(struct perf_event *event)
 			return -EOPNOTSUPP;
 		}
 	}
-
-	if (armpmu->map_event(event) == -ENOENT)
-		return -ENOENT;
-
 	return __hw_perf_event_init(event);
 }
 
-- 
2.25.1

