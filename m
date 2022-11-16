Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84262B6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiKPJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiKPJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:40:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9702A26A;
        Wed, 16 Nov 2022 01:40:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso2715518wmb.0;
        Wed, 16 Nov 2022 01:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRVEplC+7j6A14IZcqWB9f97UNzmakJtqB171khWs5c=;
        b=hrtIVynRsFTFAfwFj68ESejr8oNfwyFLMiOUQWmxyZ7gARsphmolR5UEOref/f8sA0
         hD/ikkxUruJf/IkSGsWzmzf7U3uRj23YfiSKt1zzI4u7KN9B6SnyJLyCYz1VU6M35rCy
         CAa3WKWdBlF50kpVZu1fAjSLXMaqA/9of20hrSubL7kbMXwMeQ+XGWLIAkKqIWcC5YzJ
         UDlqOE3XT//98ZqARV0eKNkxHoKkanLQ0VbOdWA31yHkYtJpgzWJiXL3cmctF7PkqMpC
         NbmjZ5FmdSgwsXo+zjpFEow4j8U3TUY3pJJE9K8UZGYr8Ltu0aRhmyawa+ooHXbax/Zd
         92yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRVEplC+7j6A14IZcqWB9f97UNzmakJtqB171khWs5c=;
        b=4UxVk/BUiHoKxF5nZXYe0xVQUG9BvVLvNdZPYCUnePkJT2VSBgZTAfPk5IXY4yVHVc
         c2INSxRJRDnLh1GbTlBkqtj8Liay2LQSENGg+A2ZJD/t9hPrk8mpB2uuq/DYJUomP74A
         kZLlnEgP/Dm8hZ+UkmMGaiQESinyVyL5bvel39uQDT/jm1kXf1jAOUjxxAp1YQB95P6w
         BrT/x2uEKycEkKt+zmcomrKkFx/Rv7w1Ct8p5EbHSMDX3Gbgv+/wfhbuS22ObyAvr5DR
         dx/sHCU1MP1SZUoXGBdaG5Eu3e4ZUk5XdVzDjm1kh/+oV7QajgJDfWs8RfSv7QucWofs
         +tzA==
X-Gm-Message-State: ANoB5plpH2ysAF0nPYw/0d0iE51HP4flnQfF4Srnvq6gjbGDdUsLI7hv
        S4CJVnzG+o3GMk10gfgS0EQ=
X-Google-Smtp-Source: AA0mqf4RcK2BTsxFpnj9xspSpvctbxaD3ERJeZpeXbiOGYQZpl50PSOp6G+zqMd6zdzjw6/ulmZdPQ==
X-Received: by 2002:a05:600c:19d1:b0:3cf:ca1a:332a with SMTP id u17-20020a05600c19d100b003cfca1a332amr1538043wmq.118.1668591625860;
        Wed, 16 Nov 2022 01:40:25 -0800 (PST)
Received: from felia.fritz.box (200116b826c55000c59461cca0b9a159.dip.versatel-1u1.de. [2001:16b8:26c5:5000:c594:61cc:a0b9:a159])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d674d000000b0022e3538d305sm17223547wrw.117.2022.11.16.01.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:40:25 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Shawn Tu <shawnx.tu@intel.com>,
        Jason Chen <jason.z.chen@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] media: i2c: refer to config VIDEO_DEV to make ov08x40 image sensor driver usable
Date:   Wed, 16 Nov 2022 10:40:06 +0100
Message-Id: <20221116094006.16054-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9958d30f38b9 ("media: Kconfig: cleanup VIDEO_DEV dependencies")
removes the config VIDEO_V4L2 as it is merged with config VIDEO_DEV.

Long after this change, commit 38fc5136ac16 ("media: i2c: Add ov08x40 image
sensor driver") introduces and refers to the removed config VIDEO_V4L2,
basically making this driver impossible to build, test and use due to
dependencies that cannot be met.

Refer to config VIDEO_DEV instead to make this driver usable.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/media/i2c/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 49c1c27afdc1..4a4ae9c20119 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -366,7 +366,7 @@ config VIDEO_OV08D10
 
 config VIDEO_OV08X40
 	tristate "OmniVision OV08X40 sensor support"
-	depends on VIDEO_V4L2 && I2C
+	depends on VIDEO_DEV && I2C
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
-- 
2.17.1

