Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F966C5ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCWFao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjCWFad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A9821952
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549415; x=1711085415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZvrzQd70YjHlJlmhsCqEtarCH/SM9v+ndjTDzenB98=;
  b=ip5WctNaZ6yniPU5HRt5p+BCkDwq2LlRSXZQGvsbfT90Ge1Pob0dm2w/
   mjUbhjVoH55bQzKLy8kNRg27pRADrDYNyBrZ1pdrxcXwWqoHdAf29+B9I
   sVvY4U0TwrIjw0dc6y2gmbjFEtZ0pnHleFawUQmDups9xim2pxsnjjn9Q
   6PjNQcdDDJ9FARBifShbClMttfIS9RHKRx4wLG22ucDn9sDaYIAUANKY7
   DWDYL5ab9LrOSC9rfQlWfojairJidAbaJ2qKCP21oElkz8Zggypcr97oF
   XgU03U0V+nCGqiFJ5+p07DnesLZzo5bQsZbfs2Oldz2Ob7gkW6nsIEkIj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779287"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779287"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675566989"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675566989"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:53 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 02/20] soundwire: intel: add ACE2.x SHIM definitions
Date:   Thu, 23 Mar 2023 13:44:34 +0800
Message-Id: <20230323054452.1543233-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

