Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9965FC5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjAFH6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjAFH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:58:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CB78E87;
        Thu,  5 Jan 2023 23:58:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a184so545508pfa.9;
        Thu, 05 Jan 2023 23:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XouvIEMckFD/n/i3TL+KNnzKZMtEfFo4i1p26wV2Wug=;
        b=HxIzGIhS2baO56Zs94wmhwt5tFoq9wj29F1lVQi6rWumWHmsDysbHm4U5DD7UP1wg/
         FiU46dlHPLI/xvdBO2FIHfg8QlIpKLK7heoXRRWJ6sD504Fwd2yE5n+zPN13X9swSK8g
         o1RNDmDgJJktcpSWMlSAgFF4RhyF4MpgZmvDUTQRmmoW/UgUdDdcUMfkRVMvmLDrNGeG
         f+PHW5RNt+ijnKvmVZeIe0hUJIVek4ARAqet6stWBiu1cIogdeXjogsJfBtQfY2RFcZ9
         Aycsf24xU0nZK5NcEe60jtKDdS8J9zmWVS1bVDlgFiM3vlDJaQv6PXfSnHtmGKHHZ1aB
         N7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XouvIEMckFD/n/i3TL+KNnzKZMtEfFo4i1p26wV2Wug=;
        b=2Hg8KPq/HiWlibvJKpQLr/ZnP2OeNIyD19l2zE9xLii2NuWO1HGN/bgn1VcA0EeBfp
         y5MyKy6XZvAvSvuFJSGWC39qNy9WIl380cWQytu6ONc1b2tdAhO0jw8daM37nUjDb7u7
         tOKf8N4Gucm7YqoSkwB2Bhlazd89OgEUyvFevSs3G0lXLS3jNhKW9N0bf4qUHrSq0yyY
         3bQwWFkljicDOOckYWxpXkdERRV69VsXetTzMPn1RmA2a0l5JvnKdumlSTNiBxHpP+1E
         cy9J89XOn29JGCal0ATbRkaphsPA3YRwSi4b+LYdNwrD+/fiDtJxc+SoE2c8bEG4hcWw
         b/Tw==
X-Gm-Message-State: AFqh2krxWSBmLHWXmoHaQUeOYjZsZhI5YKcu1jGHJwAN+oeOTnPAO+4Z
        LgIRXmAwJeK9J3BVpXQt2pQ=
X-Google-Smtp-Source: AMrXdXsUqeGN9iLG7PBrUzR0ek75zRLm2VCDCD6Jppc+fB/f6lg8Snvllo4Hh3lRJnMK1f3zpfgnpg==
X-Received: by 2002:a62:184c:0:b0:581:1e00:beeb with SMTP id 73-20020a62184c000000b005811e00beebmr45473824pfy.15.1672991897814;
        Thu, 05 Jan 2023 23:58:17 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id p7-20020a625b07000000b005825460056asm515765pfb.70.2023.01.05.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:58:17 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] media: platform: Fix refcount leak in probe and remove function
Date:   Fri,  6 Jan 2023 11:58:09 +0400
Message-Id: <20230106075809.966856-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcar_fcp_get() take reference, which should be balanced with
rcar_fcp_put(). Add missing rcar_fcp_put() in fdp1_remove and
the error paths of fdp1_probe() to fix this.

Fixes: 4710b752e029 ("[media] v4l: Add Renesas R-Car FDP1 Driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
I take commit Fixes: 7113469dafc2 ("media: vsp1: Fix an error handling
path in the probe function") for reference.
---
 drivers/media/platform/renesas/rcar_fdp1.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
index 37ecf489d112..ed97bb161743 100644
--- a/drivers/media/platform/renesas/rcar_fdp1.c
+++ b/drivers/media/platform/renesas/rcar_fdp1.c
@@ -2313,8 +2313,10 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Determine our clock rate */
 	clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto put_dev;
+	}
 
 	fdp1->clk_rate = clk_get_rate(clk);
 	clk_put(clk);
@@ -2323,7 +2325,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(&pdev->dev, &fdp1->v4l2_dev);
 	if (ret) {
 		v4l2_err(&fdp1->v4l2_dev, "Failed to register video device\n");
-		return ret;
+		goto put_dev;
 	}
 
 	/* M2M registration */
@@ -2393,6 +2395,8 @@ static int fdp1_probe(struct platform_device *pdev)
 unreg_dev:
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 
+put_dev:
+	rcar_fcp_put(fdp1->fcp);
 	return ret;
 }
 
@@ -2400,6 +2404,7 @@ static int fdp1_remove(struct platform_device *pdev)
 {
 	struct fdp1_dev *fdp1 = platform_get_drvdata(pdev);
 
+	rcar_fcp_put(fdp1->fcp);
 	v4l2_m2m_release(fdp1->m2m_dev);
 	video_unregister_device(&fdp1->vfd);
 	v4l2_device_unregister(&fdp1->v4l2_dev);
-- 
2.25.1

