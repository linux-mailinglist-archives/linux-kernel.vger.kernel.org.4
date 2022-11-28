Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98863ABFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiK1PMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiK1PMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:12:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF420986
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669648319; x=1701184319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J+Fn1V8u+xfFT+HVefM0RIhStNlFdoqHt4kN6/HhAIk=;
  b=RlxDEEwWxV9T33SKmz1VmjLushgAhmAGVN+ybKH8gWp+qqw3SY1BVPcy
   1G7+27dew2LSsk9Vid/mSt/CPudJWFhtVEHHQgsQCKlhrGYZOItJtfQfW
   91WB+TBKiSDaqm9zGPpJFdy3H1qfioHHJ5TstMQCmaFGGGagdYMCJOYzM
   R7BLikkwOg4hm3+u5msly8MoTqPvrEqGWx57DDFi2Cvl1MUFhWvdsQm9g
   7ZK+ze8p2+daSTY8BQl10f2DOsvnJfmXfD8THHX/TLnxvf++k9Rkvd54F
   +BBa3UKefBY0TKJlUNuviW/nixmY7kin9uD4F/Jl7kv0B7UZLV6kIQH0q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316688000"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316688000"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645526864"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="645526864"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2022 07:11:58 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH] perf/x86/intel/uncore: Fix uninitialized variable in skx_upi_topology_cb()
Date:   Mon, 28 Nov 2022 15:11:34 +0000
Message-Id: <20221128151134.3370671-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Fix the following warning in recently merged patch:

> config: x86_64-randconfig-m001
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>
> smatch warnings:
> arch/x86/events/intel/uncore_snbep.c:4345 skx_upi_topology_cb() error: uninitialized symbol 'ret'.

Fixes: c1c1942b49ea ("perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 44c2f879f708..db6586e12bcb 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4340,7 +4340,7 @@ static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *
 static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
 				int die, u64 cpu_bus_msr)
 {
-	int idx, ret;
+	int idx, ret = -ENODEV;
 	struct intel_uncore_topology *upi;
 	unsigned int devfn;
 	struct pci_dev *dev = NULL;

base-commit: 415db869ef56751c4ab72f0f58cd7224213bb357
-- 
2.25.1

