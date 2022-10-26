Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E160DBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiJZHRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiJZHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:17:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35ABBF0C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666768621; x=1698304621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/eH7Gu81CNmTsHwbaGvDjXLn8pW44OxlFiYMaTQxsk=;
  b=Syj4QcVBODkR1P8Wvp8U7KKvUFTlfMF/6quq82PZMcbC3jkU5Yl3ip8T
   p1C+wJLbUoaKQOVYGB1U568JXh9RgzDeMM7QuCT93ASfxdWPo5FSaynmD
   tNWYbTNuQSCmiVAawhAwYKtnd8OUXb0ikrUO8qPug9x+L5wrT9fM53d6u
   WAcbLpnlZXcXhPbRBV9o+cPH9FgK7H5CEjznaReDq99EmyVZ8GwaKoLpR
   wVvasm30e1Di9937a65WESp4ibBrEpJkRgyc30FxtcMgqpGRbrmJfmO5j
   EuyjN+sqWXBxzD1vAz8fG6V+ysVAjjYPpea7L4CiJ0L41GscmYr1cjmnY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309568977"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="309568977"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 00:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="663096914"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="663096914"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2022 00:16:57 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Chao Song <chao.song@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: add helpers to detect SoCs
Date:   Wed, 26 Oct 2022 15:14:08 +0800
Message-Id: <20221026071409.3235144-2-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026071409.3235144-1-brent.lu@intel.com>
References: <20221026071409.3235144-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to detect JSL, TGL, ADL, and ADL-N SoCs.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 include/linux/platform_data/x86/soc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
index da05f425587a..08d08c91d57b 100644
--- a/include/linux/platform_data/x86/soc.h
+++ b/include/linux/platform_data/x86/soc.h
@@ -33,6 +33,10 @@ SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
 SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
 SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
 SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
+SOC_INTEL_IS_CPU(jsl, ATOM_TREMONT_L);
+SOC_INTEL_IS_CPU(tgl, TIGERLAKE_L);
+SOC_INTEL_IS_CPU(adl, ALDERLAKE_L);
+SOC_INTEL_IS_CPU(adl_n, ALDERLAKE_N);
 
 #else /* IS_ENABLED(CONFIG_X86) */
 
@@ -60,6 +64,26 @@ static inline bool soc_intel_is_cml(void)
 {
 	return false;
 }
+
+static inline bool soc_intel_is_jsl(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_tgl(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_adl(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_adl_n(void)
+{
+	return false;
+}
 #endif /* IS_ENABLED(CONFIG_X86) */
 
 #endif /* __PLATFORM_DATA_X86_SOC_H */
-- 
2.25.1

