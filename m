Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8756B472E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjCJOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjCJOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:40 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1BC122385;
        Fri, 10 Mar 2023 06:47:22 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-17683b570b8so6016638fac.13;
        Fri, 10 Mar 2023 06:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6RZUfpxZGz4Dm4R8EA2e5JxSYmG5e3eiizcyHLczFM=;
        b=CppJTa/+bQgIIXgEuLYKa/JcK832itzk2u/LAffcFlwco1VBB6/ose0qlrzv4XZfDY
         rlwaEGl/O7lsvIW88yksXZ81BcMZzu/xQQ3z2ybYgIHpwWBK0RV4hFyu0bgwA7RAZQZ0
         SUq0tKYnJZf6pGuAmbEGCKdwyI8DKi29DoqS3hTJSAj/Gytj6GW30ndhw3B8Hh/OzS9M
         Ah7JWBj6I853QGwTl9LsD3wf1cb9ePGYQ73OEPda5qHC5Qk3lSxsL6M9dl6KsfK7/Kp/
         RfTq9D/XIlaqkIUl6NGHXB0OZAHU4jLG2ABmf2XKaWkV5vDLbpHeIh4sLbmU+C0jf5wN
         zruA==
X-Gm-Message-State: AO0yUKUlr1ohp0qjO456RiELJaXgAXl1/kG6JFbX8bjEGFXmWttEf+ca
        8nAmPzN9NTV5QJbfplq3WA==
X-Google-Smtp-Source: AK7set9YCVdkxr9MJgpTmYiry9TqiDgZRVo3pENff2tUYDhCzxVMgtjfxR1sYIN8Cj4vNzX3/tDsXA==
X-Received: by 2002:a05:6870:c10c:b0:163:51eb:b577 with SMTP id f12-20020a056870c10c00b0016351ebb577mr18020937oad.46.1678459637165;
        Fri, 10 Mar 2023 06:47:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds26-20020a0568705b1a00b0017243edbe5bsm67884oab.58.2023.03.10.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:16 -0800 (PST)
Received: (nullmailer pid 1543724 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: lis3lv02d: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:13 -0600
Message-Id: <20230310144713.1543683-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 64 +++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index efed515d7b50..299d316f1bda 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -965,19 +965,19 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	if (!pdata)
 		return -ENOMEM;
 
-	if (of_get_property(np, "st,click-single-x", NULL))
+	if (of_property_read_bool(np, "st,click-single-x"))
 		pdata->click_flags |= LIS3_CLICK_SINGLE_X;
-	if (of_get_property(np, "st,click-double-x", NULL))
+	if (of_property_read_bool(np, "st,click-double-x"))
 		pdata->click_flags |= LIS3_CLICK_DOUBLE_X;
 
-	if (of_get_property(np, "st,click-single-y", NULL))
+	if (of_property_read_bool(np, "st,click-single-y"))
 		pdata->click_flags |= LIS3_CLICK_SINGLE_Y;
-	if (of_get_property(np, "st,click-double-y", NULL))
+	if (of_property_read_bool(np, "st,click-double-y"))
 		pdata->click_flags |= LIS3_CLICK_DOUBLE_Y;
 
-	if (of_get_property(np, "st,click-single-z", NULL))
+	if (of_property_read_bool(np, "st,click-single-z"))
 		pdata->click_flags |= LIS3_CLICK_SINGLE_Z;
-	if (of_get_property(np, "st,click-double-z", NULL))
+	if (of_property_read_bool(np, "st,click-double-z"))
 		pdata->click_flags |= LIS3_CLICK_DOUBLE_Z;
 
 	if (!of_property_read_u32(np, "st,click-threshold-x", &val))
@@ -994,31 +994,31 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	if (!of_property_read_u32(np, "st,click-window", &val))
 		pdata->click_window = val;
 
-	if (of_get_property(np, "st,irq1-disable", NULL))
+	if (of_property_read_bool(np, "st,irq1-disable"))
 		pdata->irq_cfg |= LIS3_IRQ1_DISABLE;
-	if (of_get_property(np, "st,irq1-ff-wu-1", NULL))
+	if (of_property_read_bool(np, "st,irq1-ff-wu-1"))
 		pdata->irq_cfg |= LIS3_IRQ1_FF_WU_1;
-	if (of_get_property(np, "st,irq1-ff-wu-2", NULL))
+	if (of_property_read_bool(np, "st,irq1-ff-wu-2"))
 		pdata->irq_cfg |= LIS3_IRQ1_FF_WU_2;
-	if (of_get_property(np, "st,irq1-data-ready", NULL))
+	if (of_property_read_bool(np, "st,irq1-data-ready"))
 		pdata->irq_cfg |= LIS3_IRQ1_DATA_READY;
-	if (of_get_property(np, "st,irq1-click", NULL))
+	if (of_property_read_bool(np, "st,irq1-click"))
 		pdata->irq_cfg |= LIS3_IRQ1_CLICK;
 
-	if (of_get_property(np, "st,irq2-disable", NULL))
+	if (of_property_read_bool(np, "st,irq2-disable"))
 		pdata->irq_cfg |= LIS3_IRQ2_DISABLE;
-	if (of_get_property(np, "st,irq2-ff-wu-1", NULL))
+	if (of_property_read_bool(np, "st,irq2-ff-wu-1"))
 		pdata->irq_cfg |= LIS3_IRQ2_FF_WU_1;
-	if (of_get_property(np, "st,irq2-ff-wu-2", NULL))
+	if (of_property_read_bool(np, "st,irq2-ff-wu-2"))
 		pdata->irq_cfg |= LIS3_IRQ2_FF_WU_2;
-	if (of_get_property(np, "st,irq2-data-ready", NULL))
+	if (of_property_read_bool(np, "st,irq2-data-ready"))
 		pdata->irq_cfg |= LIS3_IRQ2_DATA_READY;
-	if (of_get_property(np, "st,irq2-click", NULL))
+	if (of_property_read_bool(np, "st,irq2-click"))
 		pdata->irq_cfg |= LIS3_IRQ2_CLICK;
 
-	if (of_get_property(np, "st,irq-open-drain", NULL))
+	if (of_property_read_bool(np, "st,irq-open-drain"))
 		pdata->irq_cfg |= LIS3_IRQ_OPEN_DRAIN;
-	if (of_get_property(np, "st,irq-active-low", NULL))
+	if (of_property_read_bool(np, "st,irq-active-low"))
 		pdata->irq_cfg |= LIS3_IRQ_ACTIVE_LOW;
 
 	if (!of_property_read_u32(np, "st,wu-duration-1", &val))
@@ -1026,32 +1026,32 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	if (!of_property_read_u32(np, "st,wu-duration-2", &val))
 		pdata->duration2 = val;
 
-	if (of_get_property(np, "st,wakeup-x-lo", NULL))
+	if (of_property_read_bool(np, "st,wakeup-x-lo"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_X_LO;
-	if (of_get_property(np, "st,wakeup-x-hi", NULL))
+	if (of_property_read_bool(np, "st,wakeup-x-hi"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_X_HI;
-	if (of_get_property(np, "st,wakeup-y-lo", NULL))
+	if (of_property_read_bool(np, "st,wakeup-y-lo"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_Y_LO;
-	if (of_get_property(np, "st,wakeup-y-hi", NULL))
+	if (of_property_read_bool(np, "st,wakeup-y-hi"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_Y_HI;
-	if (of_get_property(np, "st,wakeup-z-lo", NULL))
+	if (of_property_read_bool(np, "st,wakeup-z-lo"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_Z_LO;
-	if (of_get_property(np, "st,wakeup-z-hi", NULL))
+	if (of_property_read_bool(np, "st,wakeup-z-hi"))
 		pdata->wakeup_flags |= LIS3_WAKEUP_Z_HI;
 	if (of_get_property(np, "st,wakeup-threshold", &val))
 		pdata->wakeup_thresh = val;
 
-	if (of_get_property(np, "st,wakeup2-x-lo", NULL))
+	if (of_property_read_bool(np, "st,wakeup2-x-lo"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_X_LO;
-	if (of_get_property(np, "st,wakeup2-x-hi", NULL))
+	if (of_property_read_bool(np, "st,wakeup2-x-hi"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_X_HI;
-	if (of_get_property(np, "st,wakeup2-y-lo", NULL))
+	if (of_property_read_bool(np, "st,wakeup2-y-lo"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_Y_LO;
-	if (of_get_property(np, "st,wakeup2-y-hi", NULL))
+	if (of_property_read_bool(np, "st,wakeup2-y-hi"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_Y_HI;
-	if (of_get_property(np, "st,wakeup2-z-lo", NULL))
+	if (of_property_read_bool(np, "st,wakeup2-z-lo"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_Z_LO;
-	if (of_get_property(np, "st,wakeup2-z-hi", NULL))
+	if (of_property_read_bool(np, "st,wakeup2-z-hi"))
 		pdata->wakeup_flags2 |= LIS3_WAKEUP_Z_HI;
 	if (of_get_property(np, "st,wakeup2-threshold", &val))
 		pdata->wakeup_thresh2 = val;
@@ -1073,9 +1073,9 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 		}
 	}
 
-	if (of_get_property(np, "st,hipass1-disable", NULL))
+	if (of_property_read_bool(np, "st,hipass1-disable"))
 		pdata->hipass_ctrl |= LIS3_HIPASS1_DISABLE;
-	if (of_get_property(np, "st,hipass2-disable", NULL))
+	if (of_property_read_bool(np, "st,hipass2-disable"))
 		pdata->hipass_ctrl |= LIS3_HIPASS2_DISABLE;
 
 	if (of_property_read_s32(np, "st,axis-x", &sval) == 0)
-- 
2.39.2

