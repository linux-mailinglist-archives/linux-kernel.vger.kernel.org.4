Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79EC623C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiKJHYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKJHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:24:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461A32079;
        Wed,  9 Nov 2022 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668065055; x=1699601055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NpR3zgsRWqyqRv4WG8Mje9a0YXH5njFAug2x1iSvPYM=;
  b=eFBe8wjzIaYjKj8U1SQr225WeXjvJ/cHOXQzl0lHiSWiGFjn6N0UYeEu
   74QrR1fZ+CsU3TiTuneI/2gnkETV7jmdzw375B/e8xGQmu7M+5tPU/GIr
   /HCbzA8FsPGjQ7GbqUj9ngcmY9ERRyy6O6JlDS9xm1aiNHzBLslFnaysu
   jlVEEm+dwVOmAntmpUkBF4B0ewEIkW33mmCszTri1UdRKVSJI5A867o7H
   4ANZkiPKkS6WCfHDLqFtei03W7WEG3Q/yz3M49ZxEW1PDt2yPnPQwYzba
   Tm4yPxUBy8XvsznQafooEKmirbPSP5QC2JGUzEgI7/M+aZ50wfuCHTYe/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309950674"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="309950674"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 23:24:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="614994605"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="614994605"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 23:24:13 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Release early_srcu resources when no longer in use
Date:   Thu, 10 Nov 2022 15:30:13 +0800
Message-Id: <20221110073013.1302564-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "rcupdate.rcu_self_test = 1" is set in bootargs and CONFIG_SRCU
option is enabled, the early_srcu will be tested, currently, for TREE SRCU,
if "srcutree.convert_to_big = 1" is set, the srcu_node structure will be
allocated at invoke init_srcu_struct_fields() time, after the test is
completed, the early_srcu will not be used.
Therefore, this commit invoke cleanup_srcu_struct() to release srcu_node
structure.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 738842c4886b..a05e23648c6b 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -589,6 +589,7 @@ static int rcu_verify_early_boot_tests(void)
 			early_boot_test_counter++;
 			srcu_barrier(&early_srcu);
 			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
+			cleanup_srcu_struct(&early_srcu);
 		}
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
-- 
2.25.1

