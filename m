Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9996C5ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCWFbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCWFat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214A520D04
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549437; x=1711085437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKsOmGgpfRTaoYi/C0Rex9lD4JYFMvLzVqkjtEvqo9k=;
  b=fe/uTfUezvkcNRFqw+G61L1hrEw/ZoGFcKh+V7ldpZPaY3OqqCIoW0js
   +gIruqpJTD2VcVXjNJSjWQ6eak265wLCIwzv7qzKtTlO+bNLrGEsdai5l
   CoDsCrEoJStvCsTNggAajj7Ua/168SjXPrNELTTVHxQrtDNpNDCcEUcje
   r9vtszwD8p6pujz5OccUaydn3CDKbHp/xMK6/ssT0ZK5idIr2NFu4abbL
   S9/NTft7LzIXys3cbfbdj1qatiSmRZnn5juRgGuw8ycA+TmaeEbzYiANA
   HGPBOFNqZUgi1mFtYTxBltuyX6Ore5n/1LTqfco+bCfH/Zf8egUu4QVoJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779351"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779351"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567039"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567039"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:05 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 07/20] soundwire: intel: add eml_lock in the interface for new platforms
Date:   Thu, 23 Mar 2023 13:44:39 +0800
Message-Id: <20230323054452.1543233-8-yung-chuan.liao@linux.intel.com>
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

In existing Intel/SoundWire systems, all the SoundWire configuration
is 'self-contained', with the 'shim_lock' mutex used to protect access
to shared registers in multi-link configurations.

With the move of part of the SoundWire registers to the HDaudio
multi-link structure, we need a unified lock. The hda-mlink
implementation provides an 'eml_lock' that is used to protect shared
registers such as LCTL and LSYNC, we can pass it to the SoundWire
side. There is no issue with possible dangling pointers since the
SoundWire auxiliary devices are children of the PCI device, so the
'eml_lock' cannot be removed while the SoundWire side is in use.

This patch only adds the interface for now.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index c4281aa06e2e..bafc6f2554b0 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -327,6 +327,8 @@ struct sdw_intel_ctx {
  * @alh_base: sdw alh base.
  * @ext: extended HDaudio link support
  * @hbus: hdac_bus pointer, needed for power management
+ * @eml_lock: mutex protecting shared registers in the HDaudio multi-link
+ * space
  */
 struct sdw_intel_res {
 	const struct sdw_intel_hw_ops *hw_ops;
@@ -343,6 +345,7 @@ struct sdw_intel_res {
 	u32 alh_base;
 	bool ext;
 	struct hdac_bus *hbus;
+	struct mutex *eml_lock;
 };
 
 /*
-- 
2.25.1

