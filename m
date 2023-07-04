Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB87468A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGDFC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDFCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:02:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE851B0;
        Mon,  3 Jul 2023 22:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688446972; x=1719982972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MvQSWM3JXLJmmP7PlmgAPhDJ4YePLKBMLemgFv7W6HA=;
  b=iwTFMLngiIm6yBaVEIrKIn7RkbgBilVmXG7KFDC3XQ1q1wWi/eTnoEwT
   u8RHsrpM2zcZwooHEShO+n0hTqcg+BL44qdtnzc64/s37YsZH2kO10rvF
   b1/NErtRg36Na3X/Fcn7aaFfyoSVY+GVhr4WmkjYHWZe7u1jUWnt2R1nE
   5GzO+Zpw9XoON/EMe2dlD8w/uaeRP2CSPPX6G2vsYLE3oSuLc9KYgnE5g
   0bSnXfo6odr5r4/ssJ+6RMZFLAODrZaNG55SWh6svuLPpkqvyzcXIvgrV
   VHR6gtf+Vn0dIc2ZQOkrivN5H/28b1LXG+x+VLq0GFuUlAQnNSaoAcdkc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="360512747"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="360512747"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 22:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="832032966"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="832032966"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.118])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 22:02:50 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
Date:   Tue,  4 Jul 2023 13:02:38 +0800
Message-Id: <20230704050238.712223-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a sparse warning in intel_rapl_tpmi driver.

../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse: warning: incorrect type in initializer (different address spaces)
../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:    expected unsigned long long [usertype] *tpmi_rapl_regs
../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:    got void [noderef] __iomem *

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307031405.dy3druuy-lkp@intel.com/
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 4f4f13ded225..05f664a096ab 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -138,7 +138,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 	enum tpmi_rapl_register reg_index;
 	enum rapl_domain_reg_id reg_id;
 	int tpmi_domain_size, tpmi_domain_flags;
-	u64 *tpmi_rapl_regs = trp->base + offset;
+	u64 *tpmi_rapl_regs = (u64 *)(trp->base + offset);
 	u64 tpmi_domain_header = readq((void __iomem *)tpmi_rapl_regs);
 
 	/* Domain Parent bits are ignored for now */
-- 
2.34.1

