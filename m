Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166CD661A3B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbjAHV5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjAHV5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596437662
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so7714766wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALqVvJuXLwUSBoF5D6uhACAP/H9LEzc1PAajsRyeUOE=;
        b=WcLwB0Gm3jAmcGo0U6UtO4r2gXLAa6dzHouVDpKHwQyobBm11f9mT73uAWSAZ1nUNZ
         O570BtAiIlYTRDIwy2h4D2rOqu+HdlWkdEtiY0jtRBsujp/hV+4RyRJ2XZDScX7V31kW
         HXCc5sGSzHBYoES/EyUieg+3OPutRdidAguCGbwIAiKD6vmqib2mDwhFygPzbJAJZjXJ
         Yc7fk7w2S1egX2zQtwTvp9bGP7d8zUCApxGKdR8En3D6k/Y/OjUuywKVP3vavxQZcQO8
         ahLdUKl9vgTlBtCIaERH0TFQqGxM7V1p6JwPiBKiT5+iulxBjyLdN5/ABdARjeY67SVY
         LyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALqVvJuXLwUSBoF5D6uhACAP/H9LEzc1PAajsRyeUOE=;
        b=KuBCsew67JIZtwMjTzwgZY6AR+sPvYylErWbtVKsHoX5yxiKsLkNlwj+zUtDAKmguJ
         M//arksD2T+2n6YRTfrSeJA98lSgbr+Vq1gLopMRzMI4BW/Mx6LcHooLk4S+0gCcMxB9
         pcDMYY1y4qcGf7CnEjfAmTB58w+L11VBxYXtUdr1aRj5G1CoS8PpJwP32bY6FAlmho1W
         gH1g8qMTygBgFg13vHJZ1UtQepIwa9+DD/RGEX4CNBAep8+/6rzDrldrlkpw4aeSNNxm
         8sGuDInbPS3+kVVRAK7dQAxQvH8gmviq1ziSnegukaAFQYkoDeFulSE48mR4k/IdMyra
         v86A==
X-Gm-Message-State: AFqh2kpRTT+6/d2CTS0FR1DJVWio49zL/2RM9E+5I4vSQcQxnEcWVzgg
        xAoHtpJiHDqFUEigp+TUUO9RECPkJyc=
X-Google-Smtp-Source: AMrXdXurynbCrZFK8TZTqYGIxoDIVcnc50RoTZX2Uf9UzDFODsayWaLYDfLJbdrrw9i0jXfufrNc4w==
X-Received: by 2002:a05:600c:a10:b0:3d2:2904:dfe9 with SMTP id z16-20020a05600c0a1000b003d22904dfe9mr49001127wmp.21.1673215025704;
        Sun, 08 Jan 2023 13:57:05 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:05 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/7] parport_pc: Remove stale `parport_pc_ecp_read_block_pio' reference
Date:   Sun,  8 Jan 2023 21:56:50 +0000
Message-Id: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

Complement commit 991214386dee ("parport: remove unused dead code from
lowlevel drivers") and remove a stale piece of commented-out code that
refers to a function removed with said commit.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 5784dc20fb38..de7afbea96cd 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2119,8 +2119,6 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 		p->ops->compat_write_data = parport_pc_compat_write_block_pio;
 #ifdef CONFIG_PARPORT_1284
 		p->ops->ecp_write_data = parport_pc_ecp_write_block_pio;
-		/* currently broken, but working on it.. (FB) */
-		/* p->ops->ecp_read_data = parport_pc_ecp_read_block_pio; */
 #endif /* IEEE 1284 support */
 		if (p->dma != PARPORT_DMA_NONE) {
 			pr_cont(", dma %d", p->dma);
-- 
2.30.2

