Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4D5EC552
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiI0OAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiI0OAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:00:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B06DAE4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664287184; x=1695823184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXrmu/PunYDe1xIi4jB5rE+3PR+QFCMY2cJy+0qk9sE=;
  b=Ns8YpL9MPL/E+gzlIW7Nh/yMhxg6NO0UbBhSNWthjH2VxjNmIfgBCJC8
   QQjbBbA401YNO2nFcP3GgsU2Qw3eKqQR7579AlWElU/J2PuHf+dO82aNS
   6jhh7ZfF/hpjq9mBJVyb5NBOg5Oy7E4KwelSOO3dLtFBL6vyM3Uhtec59
   rVxpW/JunVl5TzDGr4nnbYnYT1vv6ABipMieqju2QurRSAHqnuVJmNaz6
   5bcFT+FhOAKKAxdUFAYaSky09b3ww4o0w1HT2slx7CNZT1AP2VAIc/ECr
   xUsANBbSaBVQ9N1RgKqm/KyzlEPdkHUNOH2orGxyvt/rxMwQoICDiXr2v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301299147"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="301299147"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 06:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="683999422"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="683999422"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 06:59:42 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mohan Kumar <mkumard@nvidia.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/hdmi: run eld notify in delay work
Date:   Tue, 27 Sep 2022 21:58:07 +0800
Message-Id: <20220927135807.4097052-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During resolution change, display driver would disable HDMI audio then
enable it in a short time. There is possibility that eld notify for
HDMI audio enable is called when previous runtime suspend is still
running. In this case, the elf nofity just returns and not updating the
status of corresponding HDMI pin/port. Here we move the eld nofity to
a delay work so we don't lose it.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6c209cd26c0c..a4c305ee8ff9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2907,13 +2907,21 @@ static int intel_port2pin(struct hda_codec *codec, int port)
 	return spec->port_map[port];
 }
 
-static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
+struct pin_eld_notify {
+	void *audio_ptr;
+	int port;
+	int pipe;
+	struct delayed_work notify_work;
+};
+
+static void pin_eld_notify_work(struct work_struct *work)
 {
-	struct hda_codec *codec = audio_ptr;
+	struct pin_eld_notify *notify = container_of(work, struct pin_eld_notify, notify_work.work);
+	struct hda_codec *codec = notify->audio_ptr;
 	int pin_nid;
-	int dev_id = pipe;
+	int dev_id = notify->pipe;
 
-	pin_nid = intel_port2pin(codec, port);
+	pin_nid = intel_port2pin(codec, notify->port);
 	if (!pin_nid)
 		return;
 	/* skip notification during system suspend (but not in runtime PM);
@@ -2922,13 +2930,33 @@ static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
 	if (codec->core.dev.power.power_state.event == PM_EVENT_SUSPEND)
 		return;
 	/* ditto during suspend/resume process itself */
-	if (snd_hdac_is_in_pm(&codec->core))
+	if (snd_hdac_is_in_pm(&codec->core)) {
+		schedule_delayed_work(&notify->notify_work, msecs_to_jiffies(10));
 		return;
+	}
 
 	snd_hdac_i915_set_bclk(&codec->bus->core);
 	check_presence_and_report(codec, pin_nid, dev_id);
 }
 
+static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
+{
+	struct hda_codec *codec = audio_ptr;
+	struct device *dev = hda_codec_dev(codec);
+	struct pin_eld_notify *notify;
+
+	notify = devm_kzalloc(dev, sizeof(struct pin_eld_notify), GFP_KERNEL);
+	if (!notify)
+		return;
+
+	notify->audio_ptr = audio_ptr;
+	notify->port = port;
+	notify->pipe = pipe;
+	INIT_DELAYED_WORK(&notify->notify_work, pin_eld_notify_work);
+
+	schedule_delayed_work(&notify->notify_work, 0);
+}
+
 static const struct drm_audio_component_audio_ops intel_audio_ops = {
 	.pin2port = intel_pin2port,
 	.pin_eld_notify = intel_pin_eld_notify,
-- 
2.25.1

