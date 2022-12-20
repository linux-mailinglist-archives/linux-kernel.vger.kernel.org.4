Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C6652046
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiLTMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:18:17 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF87D6B;
        Tue, 20 Dec 2022 04:18:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so11936696pjm.2;
        Tue, 20 Dec 2022 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FB1Zdl+28Rvbfhz85v8nwh0j606TH3NWa+amiTKsBw0=;
        b=LQRBVAhj/XECJA86A8r7EQUSxK1+jv4UFy8SBVmi/MW3c8AEumsSCG41FE4iKr89JH
         2tMTxXsNUOIcc8KNxmVeMCdP2YB1chwqvLfCO06Y/+fQhueS3gAqPZ97RGCl6Su+cVAv
         lnT4pPGzabmH3noDPYG3gVU2OKCnfkx+4QW7JZYv8PqFNt7AMv5OqmN9hqDOI+Yrl8xp
         JCnZWIF0UXyLtF+Fo3ygvfKGowakom9sr0RP2p1jkkviQhoNHaxbe0NebdAVuoq6jPIe
         0XM1b8LhlFmLShg9mtTiUSYL9Dl30tpf7AguQCHUbpcUKWzikke6u+lG5ct9S1LlOu5z
         7G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FB1Zdl+28Rvbfhz85v8nwh0j606TH3NWa+amiTKsBw0=;
        b=TpBnNonols95vDtgEEjOfJJPs+dSvuVuFn9Pl/Bm7LsGgB27Dx/rz6Y45Zc/q7Xvbi
         yqr7mb2+DmRMslpONt/+hGR/RxwSAUff6tuLeY6nPkNPNv7mzn1s5ZN3gQpP1gt/ZCi6
         2TAauOFT0rpV7pA27PixwFootGTcUHe4IH2lcpNi5SrfWKrKLPB6maIcJawGybPVskBF
         0+PKPdRmQvBv0UncIvXPQ4MDt7pbC4f/KJwcBrAR+AhElbd32v2EhFh8Ll7GIWd+YY2V
         qQLkoA+yZAScwckXzWtS40gIbYrp8p3Oeb6OymGR5o5DxL0jlf1mhLkJ+fse29PVyG0t
         G9WA==
X-Gm-Message-State: ANoB5plPXUifzR2UF0TPz5leGLDfEOQIIiI6Vds6ZlTIpwstDh3mOSDr
        t2uakmBsZClekjDmOqgeItY=
X-Google-Smtp-Source: AA0mqf79aveONIae0usk9/p38KcLeV4SiDbUUfXO/3yoLPrfY3qxxmhi9X5/3EjQTrZIXNAPYvn0Fg==
X-Received: by 2002:a17:902:7042:b0:189:cb96:1dbd with SMTP id h2-20020a170902704200b00189cb961dbdmr46878623plt.7.1671538695799;
        Tue, 20 Dec 2022 04:18:15 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id b18-20020a170902d51200b001869ba04c83sm9172930plg.245.2022.12.20.04.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:18:15 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] leds: led-core: Fix refcount leak in of_led_get
Date:   Tue, 20 Dec 2022 16:18:07 +0400
Message-Id: <20221220121807.1543790-1-linmq006@gmail.com>
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

class_find_device_by_of_node() calls class_find_device(), it will take
the reference, use the put_device() to drop the reference when not need
anymore.

Fixes: 699a8c7c4bd3 ("leds: Add of_led_get() and led_put()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/leds/led-class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 6a8ea94834fa..705b7a89f3d8 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -240,6 +240,7 @@ struct led_classdev *of_led_get(struct device_node *np, int index)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	led_cdev = dev_get_drvdata(led_dev);
+	put_device(led_dev);
 
 	if (!try_module_get(led_cdev->dev->parent->driver->owner))
 		return ERR_PTR(-ENODEV);
-- 
2.25.1

