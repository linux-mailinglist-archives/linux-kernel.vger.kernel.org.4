Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805268F9A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjBHVTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:19:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2862E0F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=twQ3/M8blgEkar5elOEcAwBrpleK/9vDAJ4SgIeTx2E=; b=1Qeax49ufNlULmMtb9czqzZcDW
        ZcfsRPntIpwakpNOP6rQ2c3aWZKNgXVOokUgJVvWnsk5JY9UzqDjlk+g3hk20DmJmw0DJMF2KvKCm
        C6FORM+b7jy+4l4/5WBMMmrGdwbMEw5RLsDgTdjXoTolAKd7GLM4rJdRRWlBKcZHCiNUpK0hzrtFW
        IhNAHe/yyxV1ex0Mv9VyC5KzpJoLH2HvG8LhWNRkFTmst778BnPOYO/vWNOTvtKICkfrZ+LFplDuj
        TmpZ4f4XmpgWQfIWfvy9CZcIij7AtZW5Xue76EsDbGDwXtGFec88OgfBrVb2D6gjt5Ri4/FqK64Gn
        yH5LxlfA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPrqY-00Gyaf-Lx; Wed, 08 Feb 2023 21:19:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] media: i2c: imx290: make suspend/resume functions __maybe_unused
Date:   Wed,  8 Feb 2023 13:19:14 -0800
Message-Id: <20230208211914.7625-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports that these 2 functions are defined but not used, so mark
them as __maybe_unused to pacify the build.

drivers/media/i2c/imx290.c:1090:12: warning: 'imx290_runtime_suspend' defined but not used [-Wunused-function]
 1090 | static int imx290_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/media/i2c/imx290.c:1082:12: warning: 'imx290_runtime_resume' defined but not used [-Wunused-function]
 1082 | static int imx290_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~

Fixes: 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/imx290.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -1079,7 +1079,7 @@ static void imx290_power_off(struct imx2
 	regulator_bulk_disable(ARRAY_SIZE(imx290->supplies), imx290->supplies);
 }
 
-static int imx290_runtime_resume(struct device *dev)
+static int __maybe_unused imx290_runtime_resume(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx290 *imx290 = to_imx290(sd);
@@ -1087,7 +1087,7 @@ static int imx290_runtime_resume(struct
 	return imx290_power_on(imx290);
 }
 
-static int imx290_runtime_suspend(struct device *dev)
+static int __maybe_unused imx290_runtime_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx290 *imx290 = to_imx290(sd);
