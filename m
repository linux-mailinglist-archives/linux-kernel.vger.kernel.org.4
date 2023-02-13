Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7164694EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjBMSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:13:54 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026E111D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676311991; bh=SAwHxQ/gSzx3tIPkoaBgffqQPABlaFMW+rxGRpZZdtU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=WOxJY9doUQun7DHJGdNqL2N6NZJXqvNK6kLIo0oOCOiHGxZImLdYGtpTh9c8XIrrr
         n3yBFPgJ/Qu1a2FXUAAlYspClGxVF0c1w9KaTzj0AicJo2B74IVPEw1cSN17aydPR/
         8bTTt6oxQD/oTe6R/4QJoArYmV18fuCN6aCDPnX4=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 13 Feb 2023 19:13:10 +0100 (CET)
X-EA-Auth: mVOtM26hiXOBErT5zUvL2AUpwMZen8W1yzH2o2fU8H6i/YJLJZUYw/Hgyue7COmu2GQyHjdRlMk9Tu+oYwHqJ9yq0UfBQuWD
Date:   Mon, 13 Feb 2023 23:43:03 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] ASoC: imx-pcm-rpmsg: Remove unused variable
Message-ID: <Y+p9r5y9DPSJkPVf@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret is initialed but is never modified or used except for
returning the initial value 0. The value can be directly returned
instead and the variable definition can be dropped.
Issue identified using returnvar.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 2f310994f7ee..6614b3447649 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -140,7 +140,6 @@ static int imx_rpmsg_pcm_hw_params(struct snd_soc_component *component,
 {
 	struct rpmsg_info *info = dev_get_drvdata(component->dev);
 	struct rpmsg_msg *msg;
-	int ret = 0;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		msg = &info->msg[TX_HW_PARAM];
@@ -184,7 +183,7 @@ static int imx_rpmsg_pcm_hw_params(struct snd_soc_component *component,
 
 	info->send_message(msg, info);
 
-	return ret;
+	return 0;
 }
 
 static snd_pcm_uframes_t imx_rpmsg_pcm_pointer(struct snd_soc_component *component,
@@ -282,7 +281,6 @@ static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct rpmsg_info *info = dev_get_drvdata(component->dev);
 	struct rpmsg_msg *msg;
-	int ret = 0;
 
 	/* Flush work in workqueue to make TX_CLOSE is the last message */
 	flush_workqueue(info->rpmsg_wq);
@@ -305,7 +303,7 @@ static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
 		dev_warn(rtd->dev, "Msg is dropped!, number is %d\n",
 			 info->msg_drop_count[substream->stream]);
 
-	return ret;
+	return 0;
 }
 
 static int imx_rpmsg_pcm_prepare(struct snd_soc_component *component,
-- 
2.34.1



