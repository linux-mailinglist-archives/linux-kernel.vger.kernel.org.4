Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AF625277
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiKKEZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiKKEZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E769DEF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140719; x=1699676719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vn9VwOhttQiEitLM6pjgFhOu+byBGsPJxmJqGvKBlLY=;
  b=Sn4ERf9vM9UNzV7Yupybut8sKI9prFUnbLxDeqMxM3a+70OfReJLfeAf
   i1uhwmlm4cCrz64RVPzZQ/9vOEv0+D072RqlCCp9vEtEMmjHBwxM4CniR
   tO2yRJoRnG3RQ1q07sizp20nr84WNzCfWWP8073p6TM9kBprTsJyJhs6E
   fd0XA5f4TyBFEfNT0glPKgpGrKNjCLvzRfnlcUvMd0Gp8nLkdH3l3pWfJ
   /FWcLGaHAdiwFJMaSAvGtlgyFdPT14OpM7tzFNYYk8B5QlKe5fDQy14dr
   ShOkaBhAco0MS6HR1zOScHCmHTNlOCsWxW1qujM+bR1RWKnZRjLLnh3r6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816314"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440773"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440773"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:16 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 6/8] soundwire: intel_init: remove sdw_intel_enable_irq()
Date:   Fri, 11 Nov 2022 12:26:51 +0800
Message-Id: <20221111042653.45520-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The functionality is implemented with per-chip callbacks, there are no
users of this symbol, remove the code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c      | 24 ------------------------
 include/linux/soundwire/sdw_intel.h |  2 --
 2 files changed, 26 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 8bd95c9cbcaf..0df3cdd85793 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -125,30 +125,6 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 	return 0;
 }
 
-#define HDA_DSP_REG_ADSPIC2             (0x10)
-#define HDA_DSP_REG_ADSPIS2             (0x14)
-#define HDA_DSP_REG_ADSPIC2_SNDW        BIT(5)
-
-/**
- * sdw_intel_enable_irq() - enable/disable Intel SoundWire IRQ
- * @mmio_base: The mmio base of the control register
- * @enable: true if enable
- */
-void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
-{
-	u32 val;
-
-	val = readl(mmio_base + HDA_DSP_REG_ADSPIC2);
-
-	if (enable)
-		val |= HDA_DSP_REG_ADSPIC2_SNDW;
-	else
-		val &= ~HDA_DSP_REG_ADSPIC2_SNDW;
-
-	writel(val, mmio_base + HDA_DSP_REG_ADSPIC2);
-}
-EXPORT_SYMBOL_NS(sdw_intel_enable_irq, SOUNDWIRE_INTEL_INIT);
-
 irqreturn_t sdw_intel_thread(int irq, void *dev_id)
 {
 	struct sdw_intel_ctx *ctx = dev_id;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 2e9fd91572d4..d2f581feed67 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -286,8 +286,6 @@ int sdw_intel_startup(struct sdw_intel_ctx *ctx);
 
 void sdw_intel_exit(struct sdw_intel_ctx *ctx);
 
-void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable);
-
 irqreturn_t sdw_intel_thread(int irq, void *dev_id);
 
 #define SDW_INTEL_QUIRK_MASK_BUS_DISABLE      BIT(1)
-- 
2.25.1

