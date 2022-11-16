Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654862B488
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiKPIHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiKPIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:07:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D243A6583
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586032; x=1700122032;
  h=from:to:cc:subject:date:message-id;
  bh=3mwv0wPuZe8XW9kvluU9XKECvz486EpvYsA7IYgIBqs=;
  b=d1l8zT6goVnqEeNHhwxn+vpHNxxxmxjNNlPD+grj6kOfwadYXKFuQn2s
   dqXfU+VR2+WRfdh/YxTLWIumKIWO8eXMouAr4t71FWuRePp7HFTL7ESHZ
   gFkaapwJ+nPIBxt7zT3yljUb7SxyZG3rRKKWzUJ1Pyo1WqiHgamY4KPk6
   hoXQXAlcuitpksWb/sctbXyc1vMLAD4rWAEk/IZrhvaD8GnjtCGXGUORX
   jB9Alcun9YuoUcE50U9PEXhzHmP9BEYWiYw+SrZtAOiEHG6gUPjc4WJ9u
   yvQ7xoEz9z8DcWPqf9w6DKREKSB3UsYGP6d3bEydpHwIOI+M3aZ3pYuaE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314295979"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="314295979"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="884299967"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="884299967"
Received: from ubuntu.bj.intel.com ([10.238.154.182])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 00:07:10 -0800
From:   Yunying Sun <yunying.sun@intel.com>
To:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        longman@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     feng.tang@intel.com, yunying.sun@intel.com
Subject: [PATCH] clocksource: Print clocksource name when clocksource is tested unstable
Date:   Wed, 16 Nov 2022 16:22:21 +0800
Message-Id: <20221116082221.25243-1-yunying.sun@intel.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some "TSC fall back to HPET" cases are seen on systems that have more
than 2 numa nodes. When this happens, in kernel log it has:

clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 4296200ns, attempt 4, marking unstable

The "hpet" here is misleading since it prints only the name of watchdog,
where actually it's measuring the delay of 3 reads: wd-clocksource-wd.

Signed-off-by: Yunying Sun <yunying.sun@intel.com>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 8058bec87ace..fac8c0d90e61 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 			goto skip_test;
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
+		smp_processor_id(), cs->name, wd_delay, nretries);
 	return WD_READ_UNSTABLE;
 
 skip_test:
-- 
2.17.0

