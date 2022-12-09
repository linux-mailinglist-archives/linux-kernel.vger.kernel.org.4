Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7563F64844B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLIO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLIOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:55:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F180A31
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:55:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s5so3377812edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8mQ1DNdko28cUxvjVBwoXrO008ZDGIG0DMI/J1nWT4=;
        b=IUG8ldHfU+Z2W8ssHSjmCqhbct2jByJci7FEf/55pMFshhMS7k+iLD4zTUZM/vN8Vq
         TRnxOna/m/DOf9FkM5W0nfGKVh437qsWJLBuTc1L9bEkkydiEQacgT3gsZcjlU0QvrUW
         ghoZGKHys0XNatcxeqS4WGCrc+i44BYjUktBdRGNt5HDu0QUK2jzN5dxUu9Pae4kYw7h
         BowqGf+a/9DnKfnfzwmGO2yrWIzTzyjRegbyqqcoPtXBIoLHqO/5TnYN+Tq+dbTaDC69
         nCbN+jY+30BuRxWcHwRaAY0XSsCekS76GhnIPJBGTsy2XQy3ak0QU/x27zXWOJnP7sHb
         jgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8mQ1DNdko28cUxvjVBwoXrO008ZDGIG0DMI/J1nWT4=;
        b=T0AVvfwCF7Ro6O6YqwF7ULE8+FaGsJKpLRrjBSkvO6E0D+NoGDk3w7ZTGFOh+Mnwtz
         xk9XFN6jHSEPi9iTTR/OEegwg5NZ+v24uHkXmb9UDRIaAiERNZuWg6seoZn+cXwnWSaJ
         XfS26b7pH95e7lg4DOaA05IvnGrgKpw9tbkliLzleu6GM7r7Cxi0Q4mwZ8Vureopd4mD
         XtKFdn6B6brJCPZCHHIspPNQ+pz74V1ehq4nK2XC+wQU56m3EKRENjapy0dSWltvTexR
         n0K7dLbV3Oq/8lYO4+4iPHfe/Is/2YeKEJtsTTU+mWELIyDN/WZDPj7Zh2LqeNMJ3Q/B
         bn1A==
X-Gm-Message-State: ANoB5pm4AN5NpDebElO7XXic0kUt+r+lQsO9SX751tJKIq2shi5OyjN2
        LdlJLCqp/guUqMacMyZXtS2P8g==
X-Google-Smtp-Source: AA0mqf61kq4qDITMmU/ANSy6fHJpUxypHKu0yrnlzXRMvNtX2P9Ui4uunU9KRDO1fLXg3COosGHBRQ==
X-Received: by 2002:a05:6402:500f:b0:461:bce0:c783 with SMTP id p15-20020a056402500f00b00461bce0c783mr7206023eda.36.1670597707421;
        Fri, 09 Dec 2022 06:55:07 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm716856edq.88.2022.12.09.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:55:07 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 1/3] drbd: split off drbd_buildtag into separate file
Date:   Fri,  9 Dec 2022 15:55:02 +0100
Message-Id: <20221209145504.2273072-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
References: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be more similar to what we do in the out-of-tree module and ease the
upstreaming process.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_main.c     | 18 ------------------
 3 files changed, 23 insertions(+), 19 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index c93e462130ff..67a8b352a1d5 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-drbd-y := drbd_bitmap.o drbd_proc.o
+drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
 drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
new file mode 100644
index 000000000000..956a4d5c339b
--- /dev/null
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/drbd.h>
+#include <linux/module.h>
+
+const char *drbd_buildtag(void)
+{
+	/* DRBD built from external sources has here a reference to the
+	 * git hash of the source code.
+	 */
+
+	static char buildtag[38] = "\0uilt-in";
+
+	if (buildtag[0] == 0) {
+#ifdef MODULE
+		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
+#else
+		buildtag[0] = 'b';
+#endif
+	}
+
+	return buildtag;
+}
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7213ffd69a16..345bfac441da 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3776,24 +3776,6 @@ _drbd_insert_fault(struct drbd_device *device, unsigned int type)
 }
 #endif
 
-const char *drbd_buildtag(void)
-{
-	/* DRBD built from external sources has here a reference to the
-	   git hash of the source code. */
-
-	static char buildtag[38] = "\0uilt-in";
-
-	if (buildtag[0] == 0) {
-#ifdef MODULE
-		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
-#else
-		buildtag[0] = 'b';
-#endif
-	}
-
-	return buildtag;
-}
-
 module_init(drbd_init)
 module_exit(drbd_cleanup)
 
-- 
2.38.1

