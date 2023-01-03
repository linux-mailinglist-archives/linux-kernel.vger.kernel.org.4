Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7294F65C52E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjACRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbjACRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:38:43 -0500
X-Greylist: delayed 20468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 09:38:39 PST
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53931274C;
        Tue,  3 Jan 2023 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672767507; bh=zGphmZiu7gBvnxZkhoRCgj7hOsYAa02g9k+8xEUGwcw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=WXpvchx+pYX7cFVZ/qAfnVS2mrUSK2fuxpxOP4MwYG8ncjPVFu+0GkQgMEmarweMB
         do5fx3QDzUEFza5B34p8axO0ymUJcetw3wdxuypdAM9CenHwWRQMnjKU+OtTB2Ypa/
         +Rpyo2Go3KAQdEMuITetyCHtpIiO25iqiDyz27/M=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  3 Jan 2023 18:38:27 +0100 (CET)
X-EA-Auth: VxAPuyJM929EZlITIfDOtoMc0Vl8+b4lHmH90GCkOLsSXjGZe9dl0ibEqSmXJWF9Rctkw47NEWNIexspR9gqeEqk89EPBNhg
Date:   Tue, 3 Jan 2023 23:08:20 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v2] staging: media: imx: change imx_media_fim_set_stream() to
 return void
Message-ID: <Y7RoDHnyHNnlPV71@qemulion>
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

At present, the function imx_media_fim_set_stream() always returns 0.
So, convert it to be a function returning void instead. Issue identified
using the returnvar.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Convert the function return type from int to void. Suggested by
      Fabio Estevam <festevam@gmail.com>
   2. Update patch subject and log accordingly.


 drivers/staging/media/imx/imx-media-csi.c | 7 ++-----
 drivers/staging/media/imx/imx-media-fim.c | 8 +++-----
 drivers/staging/media/imx/imx-media.h     | 6 +++---
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 5c3cc7de209d..44d87fe30d52 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -779,11 +779,8 @@ static int csi_start(struct csi_priv *priv)
 		goto idmac_stop;

 	/* start the frame interval monitor */
-	if (priv->fim && priv->dest == IPU_CSI_DEST_IDMAC) {
-		ret = imx_media_fim_set_stream(priv->fim, output_fi, true);
-		if (ret)
-			goto idmac_stop;
-	}
+	if (priv->fim && priv->dest == IPU_CSI_DEST_IDMAC)
+		imx_media_fim_set_stream(priv->fim, output_fi, true);

 	ret = ipu_csi_enable(priv->csi);
 	if (ret) {
diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
index fb6590dcfc36..f456751f100a 100644
--- a/drivers/staging/media/imx/imx-media-fim.c
+++ b/drivers/staging/media/imx/imx-media-fim.c
@@ -368,12 +368,11 @@ void imx_media_fim_eof_monitor(struct imx_media_fim *fim, ktime_t timestamp)
 }

 /* Called by the subdev in its s_stream callback */
-int imx_media_fim_set_stream(struct imx_media_fim *fim,
-			     const struct v4l2_fract *fi,
-			     bool on)
+void imx_media_fim_set_stream(struct imx_media_fim *fim,
+			      const struct v4l2_fract *fi,
+			      bool on)
 {
 	unsigned long flags;
-	int ret = 0;

 	v4l2_ctrl_lock(fim->ctrl[FIM_CL_ENABLE]);

@@ -393,7 +392,6 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
 	fim->stream_on = on;
 out:
 	v4l2_ctrl_unlock(fim->ctrl[FIM_CL_ENABLE]);
-	return ret;
 }

 int imx_media_fim_add_controls(struct imx_media_fim *fim)
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index f679249d82e4..6f9a46573edd 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -246,9 +246,9 @@ int imx_media_dev_notifier_register(struct imx_media_dev *imxmd,
 /* imx-media-fim.c */
 struct imx_media_fim;
 void imx_media_fim_eof_monitor(struct imx_media_fim *fim, ktime_t timestamp);
-int imx_media_fim_set_stream(struct imx_media_fim *fim,
-			     const struct v4l2_fract *frame_interval,
-			     bool on);
+void imx_media_fim_set_stream(struct imx_media_fim *fim,
+			      const struct v4l2_fract *frame_interval,
+			      bool on);
 int imx_media_fim_add_controls(struct imx_media_fim *fim);
 struct imx_media_fim *imx_media_fim_init(struct v4l2_subdev *sd);
 void imx_media_fim_free(struct imx_media_fim *fim);
--
2.34.1



