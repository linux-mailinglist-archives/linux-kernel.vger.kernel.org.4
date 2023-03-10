Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722036B47ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjCJO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjCJOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:54:56 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821C61223B3;
        Fri, 10 Mar 2023 06:50:28 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj30so4390944oib.6;
        Fri, 10 Mar 2023 06:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5TTyXRi55hhSah2PxX/CKxknwUOEhFUDM0k5zozbMo=;
        b=0Gv+zibgQ90XdkAIAqnl+R8vZDAUSNC7A6YUMTjJRLAKZ7IoHMBvca+FKDKpwv4aAc
         0piOLy5uEVRt/rINWKGeESIKK1Yco+VuWax7ATtOUFRbAYQfULv4VVVZ16VxvcPPrjL7
         5sWBAkvyLoFqu32/r5JZdfLu1UrqzXWRk8bafZAjwdhS4lvHIQmurRqpysrfo7mhHZ6O
         Ah4DWkIyKInpOZITHVXkBILaYSCSPh0mIr3+EfCKhmOOaq7iSO5IYLH2izz0tSWRaOjG
         pmrfbDHicJO9eZNVsMLJSfTeMNTwxjO8i0i/GX+Ec8XJknlG/OhhnIYFvRSaBdlRAvXO
         Ekdg==
X-Gm-Message-State: AO0yUKVBhrQL7yBnKCmRCPSmsCXoh8P2wPn+p2n7FsZv6Hz1a1+pdmPZ
        Afx7aljUQ8ebLElVOtZbwA==
X-Google-Smtp-Source: AK7set/LxJpTzvFNPpQdgvphtTIbAbb1FU0vekYAeviqgfSx1aZMwJPTc5jQS0Pp8Xqpt7e1Rjy/Aw==
X-Received: by 2002:a05:6808:2da:b0:383:f572:2646 with SMTP id a26-20020a05680802da00b00383f5722646mr11335784oid.5.1678459695959;
        Fri, 10 Mar 2023 06:48:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n25-20020a0568080a1900b0037d8dbe4308sm933029oij.48.2023.03.10.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:15 -0800 (PST)
Received: (nullmailer pid 1546914 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: charger-manager: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:35 -0600
Message-Id: <20230310144735.1546888-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 drivers/power/supply/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index c9e8450c646f..5fa6ba7f41e1 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1331,7 +1331,7 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	of_property_read_string(np, "cm-thermal-zone", &desc->thermal_zone);
 
 	of_property_read_u32(np, "cm-battery-cold", &desc->temp_min);
-	if (of_get_property(np, "cm-battery-cold-in-minus", NULL))
+	if (of_property_read_bool(np, "cm-battery-cold-in-minus"))
 		desc->temp_min *= -1;
 	of_property_read_u32(np, "cm-battery-hot", &desc->temp_max);
 	of_property_read_u32(np, "cm-battery-temp-diff", &desc->temp_diff);
-- 
2.39.2

