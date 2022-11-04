Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A18618ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKDDSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKDDRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:17:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF125EBE;
        Thu,  3 Nov 2022 20:17:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so6684444pjh.1;
        Thu, 03 Nov 2022 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22K6PkYhm2RTgFl8J7eI0rFuhmRuZ1tgOi7SiCNakIU=;
        b=eCUOSzJCGIv89jR1mrjL7outaakI25Tfv5DG+xELHqaVFDajR9BBxrQLXp9RBSmKXy
         Ixw/o+mGYF+ZInI6aCXyDRge9uu33VVsSqvs8H0RBfFM/jUAq9ih9eX4B5Z+smJI9O78
         k3c/H1slom/nShXbnwzM1FbPx4c7mNrYL6cNobaeNe/ZkeZLThr+oqiiG9FyB9tNKsFF
         GZfQD7OASvy1erHQLfIYNewZMaBuFwYzoSuvOSD1ulpfmvmaQR9FcqPhtzjjNUs2ICWX
         vE+jqIVVe5+dp+lJqwfkruannQ/ulK8THJw6XMtscb7zyi8dRFyw0iSihoqu1F1FBvRy
         Ubxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22K6PkYhm2RTgFl8J7eI0rFuhmRuZ1tgOi7SiCNakIU=;
        b=eSnqOMo0hl/IYnp0vnuO528mQseL7L7XDtU02kXI9M1McfRD3O+m+OBhLkUVnl+7AK
         X4SHP+HnjQh9F1I9o+1sh8LSg82PJaC31zj70y7scafAWDDGmeQOwrDImlS/sUbmybtg
         6tgf4Af1quftK/czK2AmkBV/wmYdt/imx3ILyP+IxIYQDiqIGsERsVN2rPh1lkiUf98f
         A0qjkWCF9mtZCXFsiHyTNMJwSVAgwA6YFwSiWSYoHsQauq9vK1M59ubLA3bPjoHrqD1j
         mISvORVhTcETR/PWQMUPL+wprMLdz2olEFHI70hhzlOMLgRUI/6Ebhf90FYTimutdmQA
         g+AQ==
X-Gm-Message-State: ACrzQf2AuYqEVUagGsqQpGY31Zy+zJsL4zx5pQ2AMkW53IQ6kpxQE96W
        lqRRNA6uTDFm0kNM9gLIbaM=
X-Google-Smtp-Source: AMsMyM4BKDnmdDnVIBnM5t1dlqUEKtvhnqWawAxs0BxXUqP/I9bG/L8n6ywXzspcW7BulLUaxFHoBA==
X-Received: by 2002:a17:902:e9cc:b0:186:8816:88d4 with SMTP id 12-20020a170902e9cc00b00186881688d4mr33455050plk.59.1667531824632;
        Thu, 03 Nov 2022 20:17:04 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:17:04 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 10/13] omapfb: encoder-opa362: fix included headers
Date:   Thu,  3 Nov 2022 20:16:39 -0700
Message-Id: <20221103-omapfb-gpiod-v1-10-cba1fae5a77c@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
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

The driver has been switched to gpiod API, so it should include
gpio/consumer.h instead of gpio.h and of_gpio.h.

With of_gpio.h no longer included we need mod_devicetable.h for
of_device_id definition.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
index ba7ed4039f8a..dd29dc5c77ec 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
@@ -11,11 +11,11 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/of_gpio.h>
 
 #include <video/omapfb_dss.h>
 

-- 
b4 0.11.0-dev-28747
