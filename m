Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61369C6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjBTIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBTId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:33:27 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93620C153;
        Mon, 20 Feb 2023 00:33:06 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z10so138304pgr.8;
        Mon, 20 Feb 2023 00:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFBa48sXBDbj4YHZ7A6RoYE/J3Q/GJfTSzCGCVG6MtQ=;
        b=QiUcrPfxgKD+5q3ALl/lOuFVzOJcTZC7K5IiCerpvNeEzTHhkLJAtsAGxZCridaoiP
         Dn/f6Op75kYzxMoalBkyelvmuv/sTWPaU51Xba0mSsvQUrAqrKUrxa6bnLJNww7NpGem
         CN15v5dj73LqG4corFZfNaceGSS6OaCbYeW6evESbNYeTvl2gBoKCZa/BNOHztrU+Crd
         hQY8DPpRTbR45YbM9C1fe/CYfeY+2FAcfH3QKIAXFgIu+Hg4MVtzE5u0n6+zxI9rGY4e
         RcGa6WiYqv40CFwC1hKFe1/9Zt77flZ4WEB/dFouUbtkqhEjz6CM66JqrZkmO9jypV9F
         Zqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFBa48sXBDbj4YHZ7A6RoYE/J3Q/GJfTSzCGCVG6MtQ=;
        b=SDbmAUrzhTPhTbnViyueTvuA4PSpcJqfUmdiasCGguXveVwi8ZDra1Y6GIXJmmAf3R
         WvsJ8fARXSm2qOgPsIEH68VkebnrFcLCl6USL3Jr+hsfksRzlc10rtC83i6MU2inXNh8
         LcULPraLEF1G6pymGpG2IC5WVvG+UpfmokIvpy4OZH2bd2Ppv8FzTQZ+6BtlBSu89oHq
         y7ca41VJdHoodKfMZSyQMoSar+QggTXo/0mx2aCRdf1yEyFD1nbAcVpXdSc/KfHGd9Nw
         7hJeYtsshN52LxMTLvvb6pxN+cAGfq2xLih8tLH/QidUrdGPoleo2mjqENXfMu6Ce55F
         lX+w==
X-Gm-Message-State: AO0yUKXCrW74mmebEVPnRHe0A8ss2sZhu77RiiesfryJc7Pc3wE4/Dfv
        kUosKYf0IvtLYT+HVUoyuzE=
X-Google-Smtp-Source: AK7set+YToDYV4Izb/jZxviAHuXroIAJkOz1iTk+abnTni9uRvIEInNq+T7ft/+SmK/2O+fZijj6YQ==
X-Received: by 2002:a05:6a00:1ca7:b0:5a8:bff4:c058 with SMTP id y39-20020a056a001ca700b005a8bff4c058mr620815pfw.3.1676881985615;
        Mon, 20 Feb 2023 00:33:05 -0800 (PST)
Received: from localhost.localdomain ([2407:cdc0:a660:5592:a29:e1e:7240:e225])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b005a817973a81sm7118369pfo.43.2023.02.20.00.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 00:33:05 -0800 (PST)
From:   Stephen Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Stephen Zhang <zhangshida@kylinos.cn>
To:     jejb@linux.ibm.com, artin.petersen@oracle.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        beanhuo@micron.com, bvanassche@acm.org, avri.altman@wdc.com,
        yoshihiro.shimoda.uh@renesas.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: ufs: Add select to CONFIG_PM in Kconfig
Date:   Mon, 20 Feb 2023 16:32:56 +0800
Message-Id: <20230220083256.997470-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

From: Shida Zhang <zhangshida@kylinos.cn>

In a configuration with CONFIG_SCSI_UFS_MEDIATEK set to 'm' and
CONFIG_PM set to 'n', errors occur at compile time:

====
../drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_suspend’:
../drivers/ufs/host/ufs-mediatek.c:1621:8: error: implicit declaration of function ‘ufshcd_runtime_suspend’; did you mean ‘ufs_mtk_runtime_suspend’? [-Werror=implicit-function-declaration]
../drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_resume’:
../drivers/ufs/host/ufs-mediatek.c:1636:9: error: implicit declaration of function ‘ufshcd_runtime_resume’; did you mean ‘ufs_mtk_runtime_resume’? [-Werror=implicit-function-declaration]
====

This patch fixes these by selecting CONFIG_PM from CONFIG_SCSI_UFS_MEDIATEK.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/ufs/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 4cc2dbd79ed0..f9786f085b54 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -71,6 +71,7 @@ config SCSI_UFS_QCOM
 config SCSI_UFS_MEDIATEK
 	tristate "Mediatek specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
+	select PM
 	select PHY_MTK_UFS
 	select RESET_TI_SYSCON
 	help
-- 
2.27.0

