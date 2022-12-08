Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7A647185
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLHOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLHOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:20:37 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242D84DE5;
        Thu,  8 Dec 2022 06:20:36 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DEEE7C0013;
        Thu,  8 Dec 2022 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670509235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9WP6UuK09ZiFFwZrEctyWpBf9jdRvt9QAuYsYKrf9k=;
        b=YkKbf6dwji/yyJ8JYIQMdoJpGqrErvK8AsQaXO8+OTDO4pvaRgSbJyDk5UmCPSbTzli6jK
        A6DIbIgIYA6SSTySQb2g1O5qlWXcyZ7Oafl7q4tXZMW248qTCCI2hfs0lyhRHHinWaS8z6
        XopCP+xjm+Ia/VeoyH+unlabZk1aM+xgR3LOg/hvCaRekn4DQ/qDDdIZ3EW1Urbsu/bpbk
        tR2syjZGb6+Q8EB78fWbiCJQsx5nmAwrLy74jYEiCLsQ5rI3DlfFtlJsZ4rUTJui5flM9t
        jjGNVWksTlzaK+pgO7a8iVtf9v4JbXwTnYS99DovlM7ipIBIiMFtLalKZqnk0w==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 04/12] media: sun6i-csi: capture: Remove useless ret initialization
Date:   Thu,  8 Dec 2022 15:19:58 +0100
Message-Id: <20221208142006.425809-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
References: <20221208142006.425809-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no particular need to assign ret when declaring it as
it will be assigned before there is any chance to return it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 6d34f5c0768f..cf6aadbc130b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -832,7 +832,7 @@ static int sun6i_csi_capture_open(struct file *file)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	int ret = 0;
+	int ret;
 
 	if (mutex_lock_interruptible(&capture->lock))
 		return -ERESTARTSYS;
-- 
2.38.1

