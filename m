Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1412A5EC87B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiI0PtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiI0Pse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:48:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF01564C3;
        Tue, 27 Sep 2022 08:46:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 3so9788498pga.1;
        Tue, 27 Sep 2022 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=K/Y50x8uRW4/ciESXUUosuQ4M90fKpbP4EQ32Q8eIFQ=;
        b=foalrFt/P90pmcsxH33esRxAV/LnpCsbAy4EuCxUiN0BjqV9tAWh3GAZTOojXjrbjf
         jTZVpc4bdSmWL1lclbCjrndWg4enrqIuYuwAjldrdNdWx8JOO1vjz8Gk2hAHurbFMBSH
         hFZ8rsTkYyhXeGWOyxwmfgfj4PFYSwAApuLQrseWgjQZiKXiNVdJHHffed+BD03IczWm
         fjZpJjtJ5QCAiNxeaxubOw9chkzVY+WabvkE1uQ4Oi/lTg2/CIqGMsbeKwpIJgkdoIIA
         lZfFcAB4EkjhH3OUk40Bzc+A1RAFyn1YJqCrqFo+oJS4Ey74cd52zrJg3d/eDUxBjmn/
         nFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K/Y50x8uRW4/ciESXUUosuQ4M90fKpbP4EQ32Q8eIFQ=;
        b=jB8wsVz5UDxUIVJXKfcGUJewUl/3pzmxenyrQTo6/S9sRykzpl41kb066yeUua7QzV
         1uYIQRdfHVAI838JFTIYvWsUYrkMc6w6yNIx34cTHMs0h43kg1Cr9QdlU63YQ1rx8jqB
         ImcQMr5885wkIvJhMHqqMZj2LHpByaKfega4aOEyO4RK4vQ0IRSpJ2MOycUldENJkEkH
         Y3PR8a16VxK76YDzH9vr6aM3KXvlqPDHZSGwRw/BNzGbN8UPb436QoG5hWpq0OmDdfrx
         2qNcaF2M2y5x6Ae6OOY7/ZFLBOrwEjIRJz5uJDenYb4Tk9W9mfUBRAsULNWiqwJ1VNal
         PhzQ==
X-Gm-Message-State: ACrzQf3W8E77FeGxmdJWcSOURVH7/tMfKrCRfD13AAdaVj7G6OGNeVUr
        GNFRNnqS2qpUZLjqsN/6vMw=
X-Google-Smtp-Source: AMsMyM5y/SxA8s24YL8kfePQXQdC3cF1Q3Wv2DwE1lscIZfvfuwaYqH1+XRXkPIr9gtJh5KV3hNMzA==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id d6-20020a056a00244600b005285da90cc7mr30485639pfj.51.1664293576722;
        Tue, 27 Sep 2022 08:46:16 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b0017839e5abfasm1681204plb.263.2022.09.27.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:46:16 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mfd: twl4030-irq: add missing device.h include
Date:   Tue, 27 Sep 2022 08:46:10 -0700
Message-Id: <20220927154611.3330871-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
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

The driver is using "struct device" and therefore needs to include
device.h header. We used to get this definition indirectly via inclusion
of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
from unnecessary includes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: added Andy's reviewed-by

 drivers/mfd/twl4030-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 4f576f0160a9..87496c1cb8bc 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -14,6 +14,7 @@
  * by syed khasim <x0khasim@ti.com>
  */
 
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
2.38.0.rc1.362.ged0d419d3c-goog

