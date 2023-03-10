Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE56B4798
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjCJOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjCJOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:51:15 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C822C82;
        Fri, 10 Mar 2023 06:48:22 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-176e43eb199so6065283fac.7;
        Fri, 10 Mar 2023 06:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETxKkA0CWLBgbyAgVLy9qpug2yXjisvnXqA0S7RLTqY=;
        b=DJame3m7PqWK8sdB3UPaLWRzGJma/YN6N0VeQFs9Tl3DQijuIuo3+1kU5aVvDeU6H+
         Dsnykr1axowfIPQn6PMV34wg4OyyMcpOQgEnIjUe+Uam+f/xrvwKzhZEr2aAKREmWuvP
         eL7V7mWe2Bzt3U8xOc9+mMWxuxVazIrIUn/mLHRvv2u8I/ov+lPMgxNUq78sDWri+pAm
         54HvuB1GZ7IfRBgXNQrn/Uc6iLYh49DWm/IAu6b/CvyXl3eItjNRdKiwPh37fAzlUcCp
         rY3hXIfnlBdCEFdMbfXYAQc3AZmTw8XhNocHKrkphpM2wulBop8qpMLYGXT/NOPv5oeH
         rbHA==
X-Gm-Message-State: AO0yUKW3nJVMq7oUZecFa84DtS1FpAEvknI5ZtuJGHvEGdfH2QOBy19G
        +G9AQ1EhCop9GXMSfaJLCw==
X-Google-Smtp-Source: AK7set/1ag3y6dD1QRTKVA81xe6JG5qypBhJeLO+p+L0vkyaAbWPH0yMo54nh3CufsknS4wbkcE54A==
X-Received: by 2002:a05:6870:219d:b0:163:b0c5:8730 with SMTP id l29-20020a056870219d00b00163b0c58730mr15337879oae.12.1678459678109;
        Fri, 10 Mar 2023 06:47:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zf30-20020a0568716a9e00b0017299192eb1sm97370oab.25.2023.03.10.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:57 -0800 (PST)
Received: (nullmailer pid 1546216 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: as3711: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:31 -0600
Message-Id: <20230310144731.1546190-1-robh@kernel.org>
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
 drivers/video/backlight/as3711_bl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 3b60019cdc2b..28437c2da0f5 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -286,23 +286,23 @@ static int as3711_backlight_parse_dt(struct device *dev)
 		if (ret < 0)
 			goto err_put_bl;
 
-		if (of_find_property(bl, "su2-feedback-voltage", NULL)) {
+		if (of_property_read_bool(bl, "su2-feedback-voltage")) {
 			pdata->su2_feedback = AS3711_SU2_VOLTAGE;
 			count++;
 		}
-		if (of_find_property(bl, "su2-feedback-curr1", NULL)) {
+		if (of_property_read_bool(bl, "su2-feedback-curr1")) {
 			pdata->su2_feedback = AS3711_SU2_CURR1;
 			count++;
 		}
-		if (of_find_property(bl, "su2-feedback-curr2", NULL)) {
+		if (of_property_read_bool(bl, "su2-feedback-curr2")) {
 			pdata->su2_feedback = AS3711_SU2_CURR2;
 			count++;
 		}
-		if (of_find_property(bl, "su2-feedback-curr3", NULL)) {
+		if (of_property_read_bool(bl, "su2-feedback-curr3")) {
 			pdata->su2_feedback = AS3711_SU2_CURR3;
 			count++;
 		}
-		if (of_find_property(bl, "su2-feedback-curr-auto", NULL)) {
+		if (of_property_read_bool(bl, "su2-feedback-curr-auto")) {
 			pdata->su2_feedback = AS3711_SU2_CURR_AUTO;
 			count++;
 		}
@@ -312,19 +312,19 @@ static int as3711_backlight_parse_dt(struct device *dev)
 		}
 
 		count = 0;
-		if (of_find_property(bl, "su2-fbprot-lx-sd4", NULL)) {
+		if (of_property_read_bool(bl, "su2-fbprot-lx-sd4")) {
 			pdata->su2_fbprot = AS3711_SU2_LX_SD4;
 			count++;
 		}
-		if (of_find_property(bl, "su2-fbprot-gpio2", NULL)) {
+		if (of_property_read_bool(bl, "su2-fbprot-gpio2")) {
 			pdata->su2_fbprot = AS3711_SU2_GPIO2;
 			count++;
 		}
-		if (of_find_property(bl, "su2-fbprot-gpio3", NULL)) {
+		if (of_property_read_bool(bl, "su2-fbprot-gpio3")) {
 			pdata->su2_fbprot = AS3711_SU2_GPIO3;
 			count++;
 		}
-		if (of_find_property(bl, "su2-fbprot-gpio4", NULL)) {
+		if (of_property_read_bool(bl, "su2-fbprot-gpio4")) {
 			pdata->su2_fbprot = AS3711_SU2_GPIO4;
 			count++;
 		}
@@ -334,15 +334,15 @@ static int as3711_backlight_parse_dt(struct device *dev)
 		}
 
 		count = 0;
-		if (of_find_property(bl, "su2-auto-curr1", NULL)) {
+		if (of_property_read_bool(bl, "su2-auto-curr1")) {
 			pdata->su2_auto_curr1 = true;
 			count++;
 		}
-		if (of_find_property(bl, "su2-auto-curr2", NULL)) {
+		if (of_property_read_bool(bl, "su2-auto-curr2")) {
 			pdata->su2_auto_curr2 = true;
 			count++;
 		}
-		if (of_find_property(bl, "su2-auto-curr3", NULL)) {
+		if (of_property_read_bool(bl, "su2-auto-curr3")) {
 			pdata->su2_auto_curr3 = true;
 			count++;
 		}
-- 
2.39.2

