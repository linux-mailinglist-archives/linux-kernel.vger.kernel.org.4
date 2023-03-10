Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219ED6B4774
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjCJOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjCJOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:43 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F37D122CE8;
        Fri, 10 Mar 2023 06:47:52 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176eae36feaso6062884fac.6;
        Fri, 10 Mar 2023 06:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID/16gZQInzWcaBs1M1mfptd9VSUgb+tugMOzAC8KsU=;
        b=yA215OAr9JScxnYfAtKOJCua1JPt2pJuizhBrjA13+U2oMZhf1I+MahPBN2Fs9Iy3I
         Jp+H7MfAxa29xrvvHN5LYCM4KHV9yPfSxnrSzyWoi//kna6zqIOssZLqgISICl869gir
         z/fxcFn8ILg4zhTn/gNLGx1WvJCcLXZujxWvpywQ+o0aY6zA4RfsqdFVw95dXcbdBSH7
         WhvBCkzBvVbWIeWwfuew2bppTk9G5qGCKsYCyud3gfLXFBoJq3z6i/fu0fWybNkB5aY8
         dEpupDbo72G9krJ+p8CNLXuD4D+91xeH9vDfpdYR/zb0kspUpbR79u5DkotLHXYJelXU
         j3fw==
X-Gm-Message-State: AO0yUKWa2y4241AqvNa5DXYzXsZXpznz3VTW0dRLO64rUjzm65Yx5iY2
        a0Fy/Hrmp9oxzftwItkthw==
X-Google-Smtp-Source: AK7set8iMdxoxX6e9GXoSjEAewkax5Eq5eSgzgKfIZDW+mCXcojVeKDYzqPeei2DVVH2V2SRVlMzRw==
X-Received: by 2002:a05:6870:e0c6:b0:176:8f34:2609 with SMTP id a6-20020a056870e0c600b001768f342609mr13990149oab.58.1678459666806;
        Fri, 10 Mar 2023 06:47:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p10-20020a4ae14a000000b00500c1100651sm823158oot.45.2023.03.10.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:46 -0800 (PST)
Received: (nullmailer pid 1542482 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:06 -0600
Message-Id: <20230310144706.1542434-1-robh@kernel.org>
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
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/ibmpowernv.c | 4 ++--
 drivers/hwmon/pwm-fan.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 8e3724728cce..594254d6a72d 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -456,9 +456,9 @@ static int populate_attr_groups(struct platform_device *pdev)
 		 */
 		if (!of_property_read_string(np, "label", &label))
 			sensor_groups[type].attr_count++;
-		if (of_find_property(np, "sensor-data-min", NULL))
+		if (of_property_present(np, "sensor-data-min"))
 			sensor_groups[type].attr_count++;
-		if (of_find_property(np, "sensor-data-max", NULL))
+		if (of_property_present(np, "sensor-data-max"))
 			sensor_groups[type].attr_count++;
 	}
 
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 83a347ca35da..57928d270015 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -427,7 +427,7 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	struct device_node *np = dev->of_node;
 	int num, i, ret;
 
-	if (!of_find_property(np, "cooling-levels", NULL))
+	if (!of_property_present(np, "cooling-levels"))
 		return 0;
 
 	ret = of_property_count_u32_elems(np, "cooling-levels");
-- 
2.39.2

