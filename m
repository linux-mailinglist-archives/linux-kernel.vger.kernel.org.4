Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11416B9C69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCNRAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCNRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:00:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4DA3B45
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678813246; x=1710349246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYdoEF0T5KfS1k21zUnAfoLcc7e+zGI8vdSjppzEaNE=;
  b=c4HO4Mv2aWwyv1BWwAJziL7a6MFgmK/6VRsQmcO7s84z2uA2sHu/AEmT
   PNH8a1MJNR7NVVlnaLVXPlAzLIjZZzplkXfWo2lNKJpesd4mvHmCZP/jR
   k01th1OFcjHeBfFW87sOMyvGmArMLZFAfdeuUni++urvujoRYZPv6B8WD
   URf7SjquKXOYES2mo8s8hz9JuL4r2SqDrAkTyw2Jl27WRKn+auxwCxR1j
   jEeD6btJlsb9AYhg++lkWFjI6pYzO2CRVwLX1zKr5/TYnXNTVkIqWPhyc
   aNQSwiFq6aFizRVg/oRatl3ZdKkPgPBKIPhekiyNpyeWBez+W05kEV9hy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="334971158"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="334971158"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743379730"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="743379730"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 14 Mar 2023 10:00:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf/x86/msr: Add Granite Rapids
Date:   Tue, 14 Mar 2023 10:00:40 -0700
Message-Id: <20230314170041.2967712-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230314170041.2967712-1-kan.liang@linux.intel.com>
References: <20230314170041.2967712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The same as Sapphire Rapids, the SMI_COUNT MSR is also supported on
Granite Rapids. Add Granite Rapids model.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index c65d8906cbcf..0feaaa571303 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -70,6 +70,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
+	case INTEL_FAM6_GRANITERAPIDS_X:
+	case INTEL_FAM6_GRANITERAPIDS_D:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
 	case INTEL_FAM6_ATOM_SILVERMONT_D:
-- 
2.35.1

