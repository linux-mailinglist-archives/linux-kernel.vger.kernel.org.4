Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F786EA65E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDUI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDUI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:56:33 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A3586A4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:56:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VgcKNzt_1682067374;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VgcKNzt_1682067374)
          by smtp.aliyun-inc.com;
          Fri, 21 Apr 2023 16:56:15 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     abrodkin@synopsys.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/arc: Use devm_platform_ioremap_resource()
Date:   Fri, 21 Apr 2023 16:56:14 +0800
Message-Id: <20230421085614.54169-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource(), as this is exactly what this
function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index e5b10e41554a..3a5e66d909a4 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -251,7 +251,6 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
-	struct resource *res;
 	int ret;
 
 	arcpgu->clk = devm_clk_get(drm->dev, "pxlclk");
@@ -268,8 +267,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	drm->mode_config.max_height = 1080;
 	drm->mode_config.funcs = &arcpgu_drm_modecfg_funcs;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	arcpgu->regs = devm_ioremap_resource(&pdev->dev, res);
+	arcpgu->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(arcpgu->regs))
 		return PTR_ERR(arcpgu->regs);
 
-- 
2.20.1.7.g153144c

