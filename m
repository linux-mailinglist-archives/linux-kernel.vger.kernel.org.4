Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D4C62D807
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiKQKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKQKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:32:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A060D59841
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668681125; x=1700217125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CpdbmDBh5RulsmM2sjgVaOibIHHXUwZtdOLMVaFIP3s=;
  b=VOX/qhzPKdmAkjNnvjIFY7DCgGuB4QFDBISFaQ3Gaw8/jwSwfFTVjeVV
   CPMOHoRqHesTRDGq4/5FI6SLJoCc9i8r+RoN9fIhIV6lXSNTYjjj6OgJv
   HmeZvWPTpEwIUaCQYVXu0gL/zMiy1IiRi7dCEtAHqjYsrXSUIgjbVHH0d
   neq21ATMkBY85X5dEl8GdK9TFeHl9pwWb9UAXI2klubDKsiyN5AtGgpvw
   yjNzCRWGi1FOs2jnO0EOQiF7ZW1hbVsuGbBHNUfDnrVFdFBOQqRZEWD0w
   ThXQQbsmiWGm4a+MjHaXHFGRdpjTixeUrbf1IwNK8TfM2poRoUc1QX4X4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313965339"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="313965339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 02:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764711982"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="764711982"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2022 02:32:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E866810E; Thu, 17 Nov 2022 12:32:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jyri Sarha <jyri.sarha@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: SOF: probes: Check ops before memory allocation
Date:   Thu, 17 Nov 2022 12:32:23 +0200
Message-Id: <20221117103223.74425-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

We may check ops before spending resources on memory allocation.
While at it, utilize dev_get_platdata() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/sof/sof-client-probes.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index d08395182b1a..fff126808bc0 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -399,23 +399,21 @@ static int sof_probes_client_probe(struct auxiliary_device *auxdev,
 	if (!sof_probes_enabled)
 		return -ENXIO;
 
-	if (!dev->platform_data) {
+	ops = dev_get_platdata(dev);
+	if (!ops) {
 		dev_err(dev, "missing platform data\n");
 		return -ENODEV;
 	}
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	ops = dev->platform_data;
-
 	if (!ops->startup || !ops->shutdown || !ops->set_params || !ops->trigger ||
 	    !ops->pointer) {
 		dev_err(dev, "missing platform callback(s)\n");
 		return -ENODEV;
 	}
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	priv->host_ops = ops;
 
 	switch (sof_client_get_ipc_type(cdev)) {
-- 
2.35.1

