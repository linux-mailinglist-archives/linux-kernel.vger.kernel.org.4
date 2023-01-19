Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63E673791
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjASL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjASL4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:56:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADC469233;
        Thu, 19 Jan 2023 03:55:49 -0800 (PST)
Received: from ideasonboard.com (unknown [IPv6:2401:4900:1c80:b229:a6c1:a673:925f:1ed6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D04FB2B3;
        Thu, 19 Jan 2023 12:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674129348;
        bh=hCxqWie3uzplKZ4e/Tdld6iDDnEY3d1lDlFPtpJvD6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OovRV9GqCGYr5smFORFQnpl3BGbYa4GbbXSJFsB4flPzHxsyWRxYnjkuVjYs17MB6
         xBUfGbgSh8xEKYXWgehHzRZ5//QdkWGAho8G6GbyuO+SZKYFCaE82bCv+r5nD50jQ1
         jPjV1MeJvdle/qVmDtiYgoPCKDOK2i25+azT1Rdo=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v5 4/6] staging: vc04_services: vchiq-mmal: Drop include Makefile directive
Date:   Thu, 19 Jan 2023 17:25:01 +0530
Message-Id: <20230119115503.268693-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119115503.268693-1-umang.jain@ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the include directive they can break the build one only wants to
build a subdirectory. Replace with "../" for the includes, in the
mmal-vchiq.c instead.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/vchiq-mmal/Makefile     | 4 ----
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/staging/vc04_services/vchiq-mmal/Makefile
index c7d3b06e17ce..6937f6534c26 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/Makefile
+++ b/drivers/staging/vc04_services/vchiq-mmal/Makefile
@@ -2,7 +2,3 @@
 bcm2835-mmal-vchiq-objs := mmal-vchiq.o
 
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL) += bcm2835-mmal-vchiq.o
-
-ccflags-y += \
-	-I$(srctree)/$(src)/.. \
-	-I$(srctree)/$(src)/../include
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 6b5879a33780..234e3764db64 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -23,9 +23,9 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
-#include <linux/raspberrypi/vchiq.h>
 #include <media/videobuf2-vmalloc.h>
 
+#include "../include/linux/raspberrypi/vchiq.h"
 #include "mmal-common.h"
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
-- 
2.38.1

