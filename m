Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232F6DCE00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDJX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:26:46 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58841BC7;
        Mon, 10 Apr 2023 16:26:45 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-184549428acso3704429fac.8;
        Mon, 10 Apr 2023 16:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169205; x=1683761205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/VCg72mZQ/NHm6OpYah9b/VaUR4O+V+V5z1ynzGieo=;
        b=ZDBb9o8VozixuGUO/0aw2qJfTy9oGtzZOZGUi0hSti+AwlQKJS9qGkD1FqPSCKXcas
         bzen0672qTscks3qOiQgKr8IqpNQfclF4WrBCivVGkoY+5RSzzrjA9RkM60GUCm+JYeI
         xQFdXjx9Z3kCYtboL2vheRjxoElrlH4MfIjvxBrjiEy4JAePcaDX1hhb6PVpnpSZ6RZJ
         XF/BZjOxYBLzl18Zd6Z/M9FA3hNxdmlvhN3gmlLjtgNRZbeY3feenKAgqlwv4ROsuVfo
         onDZbAOy+Tb2f9VARM1N4765+3YENur/2b55ZNEY9DTp1EkNDVk0trhK2G8Pxr9KEgEV
         kkWA==
X-Gm-Message-State: AAQBX9cbFGK/fDljSdlyssj0f1TM5cqgEOHhfKCkLoNybMuXriejUJzQ
        wTqYd1a9oliNCxVyBm3t+Q==
X-Google-Smtp-Source: AKy350ZijxNsFnPL5Ij5iaQI01Ek5MJitj3WEyI04D46LQ/K6Wh0QH2ZObqAjn0jf+SuVtadgtdxEg==
X-Received: by 2002:a05:6870:8087:b0:184:3995:4d70 with SMTP id q7-20020a056870808700b0018439954d70mr4161695oab.38.1681169204870;
        Mon, 10 Apr 2023 16:26:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zg22-20020a0568716b1600b0017197629658sm4490790oab.56.2023.04.10.16.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:26:44 -0700 (PDT)
Received: (nullmailer pid 1561249 invoked by uid 1000);
        Mon, 10 Apr 2023 23:26:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] usb: Add explicit of.h of_platform.h include
Date:   Mon, 10 Apr 2023 18:26:38 -0500
Message-Id: <20230410232639.1561152-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several USB drivers use of_platform_* functions which are declared in
of_platform.h. of_platform.h gets implicitly included by of_device.h,
but that is going to be removed soon. Nothing else depends on of_device.h
so it can be dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c           | 2 +-
 drivers/usb/gadget/udc/rzv2m_usb3drd.c | 2 +-
 drivers/usb/mtu3/mtu3_host.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 173cf3579c55..4d674a243784 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -11,7 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
diff --git a/drivers/usb/gadget/udc/rzv2m_usb3drd.c b/drivers/usb/gadget/udc/rzv2m_usb3drd.c
index 3c8bbf843038..8aafd1ddf126 100644
--- a/drivers/usb/gadget/udc/rzv2m_usb3drd.c
+++ b/drivers/usb/gadget/udc/rzv2m_usb3drd.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index f3903367a6a0..177d2caf887c 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -11,7 +11,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/regmap.h>
 
 #include "mtu3.h"
-- 
2.39.2

