Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0E675EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjATULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjATULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:11:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A75BC8A3;
        Fri, 20 Jan 2023 12:11:29 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.251.226.6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E0C23104C;
        Fri, 20 Jan 2023 21:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674245487;
        bh=Zngsaz8GwwntFvLzEgh5Y8P+7IVbo+ADRxKcwraGzEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/8dn6xJI/Mzj+iQlZxdBMqv4b3EKDKQ1Y1zkq6G00D0eDkmyAZy9LaTX8wHhPLA6
         DZ188CMIyxxRKruhcSHQplKjYu11VHSquypetOGeNQVXbyAfAaqowfS/93AJ27RH6N
         nwUUQhrxeypcnK4EROcEBvLdrYKNNJ/UfBCJEdCA=
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
Subject: [PATCH v6 2/6] staging: vc04_services: bcm2835-audio: Drop include Makefile directive
Date:   Sat, 21 Jan 2023 01:41:00 +0530
Message-Id: <20230120201104.606876-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120201104.606876-1-umang.jain@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
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

Drop the include directive. They can break the build, when one only
wants to build a subdirectory. Replace with "../" for the includes,
in the bcm2835.h instead.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/bcm2835-audio/Makefile  | 2 --
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
index fc7ac6112a3e..01ceebdf88e7 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
+++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
@@ -1,5 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
 snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
-
-ccflags-y += -I $(srctree)/$(src)/../include
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 38b7451d77b2..0a81383c475a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -6,11 +6,12 @@
 
 #include <linux/device.h>
 #include <linux/wait.h>
-#include <linux/raspberrypi/vchiq.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
+#include "../include/linux/raspberrypi/vchiq.h"
+
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
 
-- 
2.39.0

