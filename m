Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775B46A95E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCCLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:16:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08126CDF2;
        Fri,  3 Mar 2023 03:16:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id cp12so1305882pfb.5;
        Fri, 03 Mar 2023 03:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677842215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIW5JHmF0om+TCxeaTbrZDpuqUvSIulz0YQMWdL3Xc4=;
        b=WkLwExw/vzjnHc9V0+oh1oV4Fa3H9WBXdVFrbEwmnwlrEADZAe1fYPMGx/YfVpGG3O
         vQMgvMV+bLs/RCqSFEweeFKxekCcYJCxgGNttt+zFRah5G5e+jyHVwShrd0/boys4jPn
         Y3I46XyyUDXM3S29VLqAMfYQYZi29cZO+mI9OafHkjO33i/ORkEICU8g8EtoEzl8I/uk
         OYld9WJiFNBxgEZJAfRWE+Z1KOwtpSqmv/X1bRfNouTrjGuXzfZAQHKY4bb4EdGamvd1
         GPp0ACreUxXdMYjVhSKVKcmi+hj5pROyXrAMYwWcK8AHmwGxfFcACaI2Paa4VrCuDifr
         Mv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677842215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIW5JHmF0om+TCxeaTbrZDpuqUvSIulz0YQMWdL3Xc4=;
        b=gkZvKMGnLKlLpizltYDcn6EfLBwt7X6yVFPpdvSdbzQSicO9Ffgsp+dba7Geg5FGS7
         zUbitiaGVx3p2n8QE/UiWp7T4tbF2yCn12SpRTGTfuqhmb8IiGA73hhx11tsS2JEwysi
         PwR8tqV3Qc0OSwdIgwsAUrKh0X6ZiY4ezm4JsKqshS1b00lpZ2sXbYsVAaGtBSlPkVXz
         TomSub7l7/b8yU/zCTV9KZO88KCiGBKXZymRNVXM8BBIMfpG5t3fPM1Q9R+yfaBpegMs
         mGas0Q11ScXYkP4t6UwEJTa/qoE0dE/rK0WdJWczf77/avXuAE9h6qMnVl08X4TXzAGq
         2p1g==
X-Gm-Message-State: AO0yUKWk73sSQE/w7QjiAT2dNo7G88V/A+FAO6FSa/Mamq9m/3xW/1R1
        RHK8d399i5XKh1JZTrrFBvI=
X-Google-Smtp-Source: AK7set9UY6R7t+FyiomUuZcaLLXSbJmG3A3M8RFlICHCetr4bz4cs7f48cqam095MIYSL64NPi0bEw==
X-Received: by 2002:a62:1792:0:b0:5a8:cec9:6ab6 with SMTP id 140-20020a621792000000b005a8cec96ab6mr1661090pfx.31.1677842215451;
        Fri, 03 Mar 2023 03:16:55 -0800 (PST)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b005e00086250asm1349276pfo.125.2023.03.03.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:16:55 -0800 (PST)
From:   harperchen <harperchen1110@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        harperchen <harperchen1110@gmail.com>
Subject: [PATCH] media: platform: via: Handle error for dma_set_mask
Date:   Fri,  3 Mar 2023 11:16:24 +0000
Message-Id: <20230303111624.981568-1-harperchen1110@gmail.com>
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

As the potential failure of the dma_set_mask(), we fix this
bug by checking its return value and performing proper error
handling.

Signed-off-by: harperchen <harperchen1110@gmail.com>
---
 drivers/media/platform/via/via-camera.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/via/via-camera.c b/drivers/media/platform/via/via-camera.c
index 95483c84c3f2..885917cff738 100644
--- a/drivers/media/platform/via/via-camera.c
+++ b/drivers/media/platform/via/via-camera.c
@@ -1208,7 +1208,9 @@ static int viacam_probe(struct platform_device *pdev)
 	 * Convince the system that we can do DMA.
 	 */
 	pdev->dev.dma_mask = &viadev->pdev->dma_mask;
-	dma_set_mask(&pdev->dev, 0xffffffff);
+	ret = dma_set_mask(&pdev->dev, 0xffffffff);
+	if (ret)
+		goto out_ctrl_hdl_free;
 	/*
 	 * Fire up the capture port.  The write to 0x78 looks purely
 	 * OLPCish; any system will need to tweak 0x1e.
-- 
2.25.1

