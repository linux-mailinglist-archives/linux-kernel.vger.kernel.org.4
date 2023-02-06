Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7286B68C30D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBFQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBFQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:21:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9E524E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675700460; x=1707236460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cqqjE9Ifq/gNPEFXsZSg0+BoiU8Nz+x/je03zfph70c=;
  b=k2fdX7lsDmBn7b+nwR5ePOJq8FY2z30dlIuLHC+sMn+YCVkV0qUhP/7s
   aG18X59g3GfXNudlURTbKF2oFm7ZiGGqLP39XX7EudBfFde//TajLkFpu
   MPs40AS/uJPcE7EJiQWc6gv0AlRQWJ4TLUCbeyt+0JLWx5n4lJ59sCBpn
   kqZEknOrCzThAv/S18iMYpzuWdeM9DcJ9Ec9O1eqE6Lny2tEV6GwAaFwO
   mj/VMSIQBQnL5/yic8XbT99WUVoU78aLU21uGIvCB3fJgWv+8Kx7U7mNf
   miZyFFFtX+XreWrrKEsu/JggXndTJ5pK0ZpYIK/RVmi8dbNST/uq3Ys9I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356603955"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356603955"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995364354"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995364354"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2023 08:20:59 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/2] perf event: Fix the Retire Latency sample_type check failure
Date:   Mon,  6 Feb 2023 08:20:59 -0800
Message-Id: <20230206162100.3329395-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

perf test -v "x86 sample parsing"
 74: x86 Sample parsing                                              :
--- start ---
test child forked, pid 72526
Samples differ at 'retire_lat'
parsing failed for sample_type 0x1000000
test child finished with -1
---- end ----
x86 Sample parsing: FAILED!

In the arch_perf_synthesize_sample_weight(), the retire_lat is
mistakenly missed.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 37b3feb53e8d..e4288d09f3a0 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -101,6 +101,7 @@ void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
 	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		*array &= 0xffffffff;
 		*array |= ((u64)data->ins_lat << 32);
+		*array |= ((u64)data->retire_lat << 48);
 	}
 }
 
-- 
2.35.1

