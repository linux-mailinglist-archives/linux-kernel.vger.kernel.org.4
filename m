Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003E370254F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbjEOGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjEOGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1BFE71
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133426; x=1715669426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZvrzQd70YjHlJlmhsCqEtarCH/SM9v+ndjTDzenB98=;
  b=kpCJI9b9pJBj8t6ZtHkcaJB5mdcYYlhzZg2OkEF/tslXwD5HJOfWkRM1
   RegfLP1Xr2dvUQYEVx/lVGXMwMDuFna58gtrSpMwEtTmLIXBbH+rQ8QNc
   1um6mc36yr/qhfX2GbGO9DpGkcxvgW4fziJdrCrzenhHtCcQGuBP0J8K5
   uof7dwIIyvJxOg5cULqTlo3IElicGJywNHq75UkL2UA7ttAfuKAXCijWv
   QHDYojaypa5C44sCWU49F1F2kD1Nt6OvxUDm1ZZzTfoDbNvT++IimNzeg
   mVUihhis5/QpzbIsG5ILD1fhMAJvVBjzReRCSxwvC1G8lmTvCi1z6f88q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966273"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966273"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908595"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908595"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:23 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 02/26] soundwire: intel: add ACE2.x SHIM definitions
Date:   Mon, 15 May 2023 15:10:18 +0800
Message-Id: <20230515071042.2038-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

With the HDaudio extended link integration, the SHIM and IP registers
are split in blocks

a) SHIM generic registers
b) IP registers (same offsets for Cadence IP as before)
c) SHIM vendor-specific registers

Add offsets and definitions as defined in the hardware specifications.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 75 +++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 207701aeeb47..8e6183e029fa 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -7,6 +7,10 @@
 #include <linux/irqreturn.h>
 #include <linux/soundwire/sdw.h>
 
+/*********************************************************************
+ * cAVS and ACE1.x definitions
+ *********************************************************************/
+
 #define SDW_SHIM_BASE			0x2C000
 #define SDW_ALH_BASE			0x2C800
 #define SDW_SHIM_BASE_ACE		0x38000
@@ -101,6 +105,77 @@
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
 #define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
 
+/*********************************************************************
+ * ACE2.x definitions for SHIM registers - only accessible when the
+ * HDAudio extended link LCTL.SPA/CPA = 1.
+ *********************************************************************/
+/* x variable is link index */
+#define SDW_SHIM2_GENERIC_BASE(x)	(0x00030000 + 0x8000 * (x))
+#define SDW_IP_BASE(x)			(0x00030100 + 0x8000 * (x))
+#define SDW_SHIM2_VS_BASE(x)		(0x00036000 + 0x8000 * (x))
+
+/* SHIM2 Generic Registers */
+/* Read-only capabilities */
+#define SDW_SHIM2_LECAP			0x00
+#define SDW_SHIM2_LECAP_HDS		BIT(0)		/* unset -> Host mode */
+#define SDW_SHIM2_LECAP_MLC		GENMASK(3, 1)	/* Number of Lanes */
+
+/* PCM Stream capabilities */
+#define SDW_SHIM2_PCMSCAP		0x10
+#define SDW_SHIM2_PCMSCAP_ISS		GENMASK(3, 0)	/* Input-only streams */
+#define SDW_SHIM2_PCMSCAP_OSS		GENMASK(7, 4)	/* Output-only streams */
+#define SDW_SHIM2_PCMSCAP_BSS		GENMASK(12, 8)	/* Bidirectional streams */
+
+/* Read-only PCM Stream Channel Count, y variable is stream */
+#define SDW_SHIM2_PCMSYCHC(y)		(0x14 + (0x4 * (y)))
+#define SDW_SHIM2_PCMSYCHC_CS		GENMASK(3, 0)	/* Channels Supported */
+
+/* PCM Stream Channel Map */
+#define SDW_SHIM2_PCMSYCHM(y)		(0x16 + (0x4 * (y)))
+#define SDW_SHIM2_PCMSYCHM_LCHAN	GENMASK(3, 0)	/* Lowest channel used by the FIFO port */
+#define SDW_SHIM2_PCMSYCHM_HCHAN	GENMASK(7, 4)	/* Lowest channel used by the FIFO port */
+#define SDW_SHIM2_PCMSYCHM_STRM		GENMASK(13, 8)	/* HDaudio stream tag */
+#define SDW_SHIM2_PCMSYCHM_DIR		BIT(15)		/* HDaudio stream direction */
+
+/* SHIM2 vendor-specific registers */
+#define SDW_SHIM2_INTEL_VS_LVSCTL	0x04
+#define SDW_SHIM2_INTEL_VS_LVSCTL_FCG	BIT(26)
+#define SDW_SHIM2_INTEL_VS_LVSCTL_MLCS	GENMASK(29, 27)
+#define SDW_SHIM2_INTEL_VS_LVSCTL_DCGD	BIT(30)
+#define SDW_SHIM2_INTEL_VS_LVSCTL_ICGD	BIT(31)
+
+#define SDW_SHIM2_MLCS_XTAL_CLK		0x0
+#define SDW_SHIM2_MLCS_CARDINAL_CLK	0x1
+#define SDW_SHIM2_MLCS_AUDIO_PLL_CLK	0x2
+#define SDW_SHIM2_MLCS_MCLK_INPUT_CLK	0x3
+#define SDW_SHIM2_MLCS_WOV_RING_OSC_CLK 0x4
+
+#define SDW_SHIM2_INTEL_VS_WAKEEN	0x08
+#define SDW_SHIM2_INTEL_VS_WAKEEN_PWE	BIT(0)
+
+#define SDW_SHIM2_INTEL_VS_WAKESTS	0x0A
+#define SDW_SHIM2_INTEL_VS_WAKEEN_PWS	BIT(0)
+
+#define SDW_SHIM2_INTEL_VS_IOCTL	0x0C
+#define SDW_SHIM2_INTEL_VS_IOCTL_MIF	BIT(0)
+#define SDW_SHIM2_INTEL_VS_IOCTL_CO	BIT(1)
+#define SDW_SHIM2_INTEL_VS_IOCTL_COE	BIT(2)
+#define SDW_SHIM2_INTEL_VS_IOCTL_DO	BIT(3)
+#define SDW_SHIM2_INTEL_VS_IOCTL_DOE	BIT(4)
+#define SDW_SHIM2_INTEL_VS_IOCTL_BKE	BIT(5)
+#define SDW_SHIM2_INTEL_VS_IOCTL_WPDD	BIT(6)
+#define SDW_SHIM2_INTEL_VS_IOCTL_ODC	BIT(7)
+#define SDW_SHIM2_INTEL_VS_IOCTL_CIBD	BIT(8)
+#define SDW_SHIM2_INTEL_VS_IOCTL_DIBD	BIT(9)
+#define SDW_SHIM2_INTEL_VS_IOCTL_HAMIFD	BIT(10)
+
+#define SDW_SHIM2_INTEL_VS_ACTMCTL	0x0E
+#define SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE	BIT(0)
+#define SDW_SHIM2_INTEL_VS_ACTMCTL_DODS		BIT(1)
+#define SDW_SHIM2_INTEL_VS_ACTMCTL_DODSE	BIT(2)
+#define SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS	GENMASK(4, 3)
+#define SDW_SHIM2_INTEL_VS_ACTMCTL_DOAISE	BIT(5)
+
 /**
  * struct sdw_intel_stream_params_data: configuration passed during
  * the @params_stream callback, e.g. for interaction with DSP
-- 
2.25.1

