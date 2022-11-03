Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E9618C01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKCWsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKCWrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43093222B8;
        Thu,  3 Nov 2022 15:47:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v3so2921229pgh.4;
        Thu, 03 Nov 2022 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpJqV269dmxPiy2x5jEutyBsbCSaPK9GSjGKfIXbXdk=;
        b=dlZ/fdF2gWei4tdt6X230opQrrul11vKHrCLup5DzYbbg5GcNw3/lPEjHjhOchKC/0
         bHwxsx8O6qfED5aPAFKzdFj8ovPJEnVwWdj9zZgqgPZKas8sTqKHWAz8Pr+bajJ4jnej
         SctQAQ0C+hSDvrpkk97zUMEiu8tg7UagMtA+bTi+VU8dBH3X4M5ogWReLmOTbd052Bu/
         vvmR8bHfjVNMIcJ0wHiBMsK6y7/cObovwhtcHIFsc71WpV2a6fm0VBloFXrM+rklTtuW
         qPZeifL5e6FtggVnYQXL6ySO0ciWLGhNTimCHL2lOQLfuaXjxVlk8QX0Oxa7QUf6Xb59
         2JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpJqV269dmxPiy2x5jEutyBsbCSaPK9GSjGKfIXbXdk=;
        b=Lutl0v6OqHjJ9wJfZM+wcoF0fkmyY86sbR20t7LThqxaVLFY+8Jn3lk8f4HqQNJOnR
         IGfnds+mV0IWOLT3Gex+clMU7gBIfk+8pPE1nNYg9xcx8HDnQ1k7wbFuY8R3AH8K4tEY
         ph417cVt420Id2Cyj2p1GvKKLVECZ4TjdSw0akHpb4LB07kItNJ/NdrYnyDpi1OeaccX
         yYFurO1NibW1cARU2sMWwW/WkCSu/d8vOP54i/z9PBQy8iaZId0aA0ylaDf1A9yiWN06
         r+H32ftdwdbJFrv1Y+h/Q+wlaqu9DW90XwJMy9whCrjnIRpjt9lXoyivzCkwo+MTDzFC
         A6Bw==
X-Gm-Message-State: ACrzQf2Uz96QILzQCwrszUWXe5lggnTzUnWf56yfh3f9p35+AtmLFAem
        SkRGpc+av6YPTQJltz/8GZY=
X-Google-Smtp-Source: AMsMyM6fTrhxDrKHSq7wbNn6fd7B+7MO6dL15NJwk5BhAWfrbdpJVAwdXTG0v2iOTXgRO9RbqaKVAQ==
X-Received: by 2002:a62:1544:0:b0:56d:6af0:c131 with SMTP id 65-20020a621544000000b0056d6af0c131mr23948193pfv.51.1667515658645;
        Thu, 03 Nov 2022 15:47:38 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 10/13] omapfb: encoder-opa362: fix included headers
Date:   Thu,  3 Nov 2022 15:46:53 -0700
Message-Id: <20221103-omapfb-gpiod-v1-10-c3d53ca7988f@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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
b4 0.11.0-dev-5166b
