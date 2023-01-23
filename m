Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD26784F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjAWSbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjAWSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:31:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73CFA12879
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:31:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08CE1C14;
        Mon, 23 Jan 2023 10:31:36 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 850D13F71E;
        Mon, 23 Jan 2023 10:30:53 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: [PATCH] Partially revert "perf/arm-cmn: Optimise DTC counter accesses"
Date:   Mon, 23 Jan 2023 18:30:38 +0000
Message-Id: <b41bb4ed7283c3d8400ce5cf5e6ec94915e6750f.1674498637.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out the optimisation implemented by commit 4f2c3872dde5 is
totally broken, since all the places that consume hw->dtcs_used for
events other than cycle count are still not expecting it to be sparsely
populated, and fail to read all the relevant DTC counters correctly if
so.

If implemented correctly, the optimisation potentially saves up to 3
register reads per event update, which is reasonably significant for
events targeting a single node, but still not worth a massive amount of
additional code complexity overall. Getting it right within the current
design looks a fair bit more involved than it was ever intended to be,
so let's just make a functional revert which restores the old behaviour
while still backporting easily.

Fixes: 4f2c3872dde5 ("perf/arm-cmn: Optimise DTC counter accesses")
Reported-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b80a9b74662b..1deb61b22bc7 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1576,7 +1576,6 @@ static int arm_cmn_event_init(struct perf_event *event)
 			hw->dn++;
 			continue;
 		}
-		hw->dtcs_used |= arm_cmn_node_to_xp(cmn, dn)->dtc;
 		hw->num_dns++;
 		if (bynodeid)
 			break;
@@ -1589,6 +1588,12 @@ static int arm_cmn_event_init(struct perf_event *event)
 			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
 		return -EINVAL;
 	}
+	/*
+	 * Keep assuming non-cycles events count in all DTC domains; turns out
+	 * it's hard to make a worthwhile optimisation around this, short of
+	 * going all-in with domain-local counter allocation as well.
+	 */
+	hw->dtcs_used = (1U << cmn->num_dtcs) - 1;
 
 	return arm_cmn_validate_group(cmn, event);
 }
-- 
2.36.1.dirty

