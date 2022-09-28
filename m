Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451FB5ED904
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiI1JcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiI1Jbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:31:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38EB4EA8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:31:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1186568pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=M3bp3/heYcffHLAjkXbjJ8sI3ZEzvrPkNlCHNlANPn0=;
        b=d4FuVwCupy+evQjyXNFVgqKHpVO/fPVitibQ+sIbQQ7RGRzTBmsYsXfXZXrjzFwXND
         IIFKaJ0Xz2PSctYiM+nrdjlcy4SW8y3YsY2dIxpCbJJOTipgj8nHbc5ShntY0iOiWNM7
         myW55UKPrOhjfGb7d4OPavDgzs3PMKhbGKymNShtJaC7/ttXncfjgpOF2xkpkVuvsddX
         +Mb3u7zrsCk+UyOmiEuhvGJEA4ROy5Ys6baDFLbuJmkFTpP/VorGEMetw+3WYPyRxWdo
         1vlW7z2CTUVBBIMmP6ztmaB8JW8orc37Mm0RefAhZLnJoFefyWagOCbJSnD0chLwbqXA
         9YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=M3bp3/heYcffHLAjkXbjJ8sI3ZEzvrPkNlCHNlANPn0=;
        b=cPdqHUiiL4D7uMwEwwBo6siMVjPsU49oo+bjzvdqoiQsADF7DrIM0kOhO8uBQ+BSsX
         MT2JUZ1DGzIv8SqAo/e1bUbb1oTHTWe0wdAqc5ubv85pw4w0DG3KTq09xfKm8ocnZJOz
         rSxX/BnG97mIaSCKUgdGWwndhVUwaa3ZFPNND4wywXpPA6fB+X7rPMo8mxLD7XRFk71Q
         3ipm9SmuvQcFIyxWhfi3827K3LxZNYNUyR6DAc7zHrii/cBYyfE0WyeBnuV1i1uhtO/c
         XhP7iPsYizc1JYZfpVzoAHfyzoFN9hrbtxjP2LzrlHyAGeX8rVFvAEE0VFrih6T1/uZG
         QwtQ==
X-Gm-Message-State: ACrzQf2Le4QkEunlszy1dKDXGBdXg5Nc4exf574tTM82HEKkP38fN2oQ
        ZUS31ygyJYjKNGRkGPFcxOM=
X-Google-Smtp-Source: AMsMyM5189enVMuN9LzPeIB5eR13RwM5I2P4XwY5RpLgpLl+Ej9vM5JxwQ6iUvQdkoypJ+1756lDaw==
X-Received: by 2002:a17:902:f60b:b0:178:6a49:d4e3 with SMTP id n11-20020a170902f60b00b001786a49d4e3mr32109753plg.75.1664357507219;
        Wed, 28 Sep 2022 02:31:47 -0700 (PDT)
Received: from fedora.. ([103.159.189.146])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090a088b00b001f22647cb56sm1049477pjc.27.2022.09.28.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:31:46 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH] drm/tve200: Use drm_* variants for logging
Date:   Wed, 28 Sep 2022 15:31:03 +0600
Message-Id: <20220928093103.64014-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.3
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

We have routines like drm_info/warn/err for logging. Use them instead
of dev_* variants to get drm-formatted log messages.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 drivers/gpu/drm/tve200/tve200_display.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index 771bad881714..d453581b6b18 100644
--- a/drivers/gpu/drm/tve200/tve200_display.c
+++ b/drivers/gpu/drm/tve200/tve200_display.c
@@ -60,7 +60,7 @@ irqreturn_t tve200_irq(int irq, void *data)
 		}
 		writel(val, priv->regs + TVE200_CTRL);
 	} else
-		dev_err(priv->drm->dev, "stray IRQ %08x\n", stat);
+		drm_err(priv->drm, "stray IRQ %08x\n", stat);
 
 	/* Clear the interrupt once done */
 	writel(stat, priv->regs + TVE200_INT_CLR);
@@ -146,7 +146,7 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
 	}
 	if (retries == 5 &&
 	    readl(priv->regs + TVE200_CTRL_4) & TVE200_CTRL_4_RESET) {
-		dev_err(drm->dev, "can't get hardware out of reset\n");
+		drm_err(drm, "can't get hardware out of reset\n");
 		return;
 	}
 
@@ -171,14 +171,14 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
 	if ((mode->hdisplay == 352 && mode->vdisplay == 240) || /* SIF(525) */
 	    (mode->hdisplay == 352 && mode->vdisplay == 288)) { /* CIF(625) */
 		ctrl1 |= TVE200_CTRL_IPRESOL_CIF;
-		dev_info(drm->dev, "CIF mode\n");
+		drm_info(drm, "CIF mode\n");
 	} else if (mode->hdisplay == 640 && mode->vdisplay == 480) {
 		ctrl1 |= TVE200_CTRL_IPRESOL_VGA;
-		dev_info(drm->dev, "VGA mode\n");
+		drm_info(drm, "VGA mode\n");
 	} else if ((mode->hdisplay == 720 && mode->vdisplay == 480) ||
 		   (mode->hdisplay == 720 && mode->vdisplay == 576)) {
 		ctrl1 |= TVE200_CTRL_IPRESOL_D1;
-		dev_info(drm->dev, "D1 mode\n");
+		drm_info(drm, "D1 mode\n");
 	}
 
 	if (format & DRM_FORMAT_BIG_ENDIAN) {
@@ -226,7 +226,7 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
 		ctrl1 |= TVE200_IPDMOD_YUV420;
 		break;
 	default:
-		dev_err(drm->dev, "Unknown FB format 0x%08x\n",
+		drm_err(drm, "Unknown FB format 0x%08x\n",
 			fb->format->format);
 		break;
 	}
-- 
2.37.3

