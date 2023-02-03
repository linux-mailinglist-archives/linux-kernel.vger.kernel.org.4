Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5366898ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjBCMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjBCMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:35:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55E1D914;
        Fri,  3 Feb 2023 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675427726; x=1706963726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VioCBWb7qXf7WOg8zdrdnZEUEZxWGMvvT3yx59qR6CE=;
  b=FWhi8+1wScoifuM7HIp7ONrKPv5cJ9NRzEd+yJXW7ChTwbfc7IEeB4T7
   CmoigS15AayX+omEJnuGCyPCEvS1gNl3C3G/I5G815JNl5BbK1L5NFsCw
   HojtUuojR5UHLQWPuSrkdVh7VthzAH+F04kjpFmQ22AdSll/yznJcCE9V
   A/hwyWZVXRbSznkZlL+YAaZu6PDt1nPLe8tmtgrjLtJqw0o9N2hwdqSQp
   RNqbJ+qszlSxt2sadVeRNqM9uTXrL2wrbcKnqhoilaxAjGU737Vjqplqx
   djP0L27sW3r/NkmH7XFgBkm5y3TChTH1OIsJbc74YJsyFtQT0eehnJ62f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="330023094"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330023094"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 04:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="643257575"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="643257575"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2023 04:35:22 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] thermal: intel_powerclamp: Add dependency on CPU_IDLE
Date:   Fri,  3 Feb 2023 04:35:16 -0800
Message-Id: <20230203123516.2501755-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Fix error:
   WARNING: unmet direct dependencies detected for IDLE_INJECT
     Depends on [n]: POWERCAP [=y] && CPU_IDLE [=n]
     Selected by [y]:
     - INTEL_POWERCLAMP [=y] && THERMAL [=y] && (X86 [=y] ||
X86_INTEL_QUARK [=n] || COMPILE_TEST [=y]) && X86 [=y] && CPU_SUP_INTEL [=y]

Since IDLE_INJECT depends on CPU_IDLE, add that to INTEL_POWERCLAMP.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This is for kernel
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge

 drivers/thermal/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index b346a646fffb..b5808f92702d 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -3,6 +3,7 @@ config INTEL_POWERCLAMP
 	tristate "Intel PowerClamp idle injection driver"
 	depends on X86
 	depends on CPU_SUP_INTEL
+	depends on CPU_IDLE
 	select POWERCAP
 	select IDLE_INJECT
 	help
-- 
2.39.1

