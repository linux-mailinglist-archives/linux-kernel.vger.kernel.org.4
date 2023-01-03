Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBF65BF35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjACLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjACLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:45:16 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C35F83;
        Tue,  3 Jan 2023 03:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672746301; bh=hq1Mr8Cwby3ZbX2qb3uIoXDEXzZmuXFc29XcF8N/+r4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=JOv+xNVKD5112S93a8c7aYmoCdX5KoU6wBhdnCWFfbKPJpGhoWZRjuks+zSBEsw75
         SQPqDig8L+0Joav7loNL8qDYPMUh7sgIJsfpHPEyZZveFpTHIJKn7i+T7pkINA6PBZ
         A56vNK7INh6hKl8O63cSAqsmToub/440/EUs+c68=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  3 Jan 2023 12:45:01 +0100 (CET)
X-EA-Auth: FA+GNfPw6PUD7+tjmQeBh7FR6EBoNuE5zSwpXBGXi4UNiowYmso+Xd15a3rfkgucAXYCHE1qTxBD6g3O2bSauSf9YlqOl8BE
Date:   Tue, 3 Jan 2023 17:14:55 +0530
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
Subject: [PATCH] staging: media: imx: remove unnecessary return variable
Message-ID: <Y7QVN0XY+ld2mBk4@qemulion>
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

The function imx_media_fim_set_stream() can directly return 0 instead of
using a ret variable which never changes its value. Issue identified
using the returnvar.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/media/imx/imx-media-fim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
index fb6590dcfc36..e719227d4323 100644
--- a/drivers/staging/media/imx/imx-media-fim.c
+++ b/drivers/staging/media/imx/imx-media-fim.c
@@ -373,7 +373,6 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
 			     bool on)
 {
 	unsigned long flags;
-	int ret = 0;

 	v4l2_ctrl_lock(fim->ctrl[FIM_CL_ENABLE]);

@@ -393,7 +392,7 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
 	fim->stream_on = on;
 out:
 	v4l2_ctrl_unlock(fim->ctrl[FIM_CL_ENABLE]);
-	return ret;
+	return 0;
 }

 int imx_media_fim_add_controls(struct imx_media_fim *fim)
--
2.34.1



