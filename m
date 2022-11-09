Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DE6237B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKIXtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKIXte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:49:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971D642B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668037773; x=1699573773;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c/DQyuJrqj3A3rcH2mu7EKu6GdPoG+wZ+dPrb8sqJoU=;
  b=jaDx7RvJNLpbeYu02K0LaPlHBJtujD2Ybxs47h6/3W0BlpbMfmBJC+yl
   zSmNAx++T/UGtDSCn6jEKeGu5i7jXw0xbz4nC+yl0d/amSr66iebKwQHL
   LZsIkKeq3ycXeJ2nRj1Vj58M2EwC2XvjiK6z3r1/8l5sByPXs2vpgSbxc
   GPaRLSjRVss8Q2el3lol1/LUQa/t4PIV2T6/7aRHZrBP1cY4myMj+LvOV
   NLiIxdRtEVPHYuxZL+0HnBKxQm2CmHoK7hRHmK8zkvJj9C92tDkwXuM3K
   ej4wjFkPy58qcB9/aw6PR7aSgWcrJNHqidDXyNnZkyXdp2clG+Vt4iPkD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309869207"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="309869207"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:49:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700568161"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="700568161"
Received: from junxiaochang.bj.intel.com ([10.238.135.52])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:49:18 -0800
From:   Junxiao Chang <junxiao.chang@intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        kai.vehmanen@linux.intel.com, furong.zhou@intel.com,
        cezary.rojewski@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, junxiao.chang@intel.com
Subject: [PATCH] ASoC: hdac_hda: fix hda pcm buffer overflow issue
Date:   Thu, 10 Nov 2022 07:40:23 +0800
Message-Id: <20221109234023.3111035-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KASAN is enabled, below log might be dumped with Intel EHL hardware:
[   48.583597] ==================================================================
[   48.585921] BUG: KASAN: slab-out-of-bounds in hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.587995] Write of size 4 at addr ffff888103489708 by task pulseaudio/759

[   48.589237] CPU: 2 PID: 759 Comm: pulseaudio Tainted: G     U      E     5.15.71-intel-ese-standard-lts #9
[   48.591272] Hardware name: Intel Corporation Elkhart Lake Embedded Platform/ElkhartLake LPDDR4x T3 CRB, BIOS EHLSFWI1.R00.4251.A01.2206130432 06/13/2022
[   48.593010] Call Trace:
[   48.593648]  <TASK>
[   48.593852]  dump_stack_lvl+0x34/0x48
[   48.594404]  print_address_description.constprop.0+0x1f/0x140
[   48.595174]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.595868]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.596519]  kasan_report.cold+0x7f/0x11b
[   48.597003]  ? hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]
[   48.597885]  hdac_hda_dai_hw_params+0x20a/0x22b [snd_soc_hdac_hda]

HDAC_LAST_DAI_ID is last index id, pcm buffer array size should
be +1 to avoid out of bound access.

Fixes: 608b8c36c371 ("ASoC: hdac_hda: add support for HDMI/DP as a HDA codec")
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Furong Zhou <furong.zhou@intel.com>
---
 sound/soc/codecs/hdac_hda.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index fc19c34ca00e5..b65560981abb2 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -14,7 +14,7 @@ enum {
 	HDAC_HDMI_1_DAI_ID,
 	HDAC_HDMI_2_DAI_ID,
 	HDAC_HDMI_3_DAI_ID,
-	HDAC_LAST_DAI_ID = HDAC_HDMI_3_DAI_ID,
+	HDAC_DAI_ID_NUM
 };
 
 struct hdac_hda_pcm {
@@ -24,7 +24,7 @@ struct hdac_hda_pcm {
 
 struct hdac_hda_priv {
 	struct hda_codec *codec;
-	struct hdac_hda_pcm pcm[HDAC_LAST_DAI_ID];
+	struct hdac_hda_pcm pcm[HDAC_DAI_ID_NUM];
 	bool need_display_power;
 };
 
-- 
2.25.1

