Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AE62DC28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiKQNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiKQNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:00:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3D5916D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:00:10 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40ED01056;
        Thu, 17 Nov 2022 14:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668690008;
        bh=L3iuePaXU3I9Th2qNYgsdcfyya4frF4sh5w4xXhH/fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVaArLR5O9TBGGuWPC3CfM1iuFvXyUKFVxxhv+yzpg3QVEQzWVwMpGl70m0102nK1
         LdEaQNAkhfeFlHjsoe9Orw56peP3CKcNLFBuoqnBLNBpTM6HiAr+ie/sFR4ewIN7oK
         qvJsHRQ/ptgyN6FK0dJMrDUDw6nBJqsPslpJNsWI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kieran.bingham@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/2] staging: vc04_services: mmal-vchiq: Do not assign bool to u32
Date:   Thu, 17 Nov 2022 18:29:52 +0530
Message-Id: <20221117125953.88441-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117125953.88441-1-umang.jain@ideasonboard.com>
References: <20221117125953.88441-1-umang.jain@ideasonboard.com>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

struct vchiq_mmal_component.enabled is a u32 type. Do not assign
it a bool.

Fixes: 640e77466e69 ("staging: mmal-vchiq: Avoid use of bool in structures")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index cb921c94996a..17f8ceda87ca 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1773,7 +1773,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
 
 	ret = enable_component(instance, component);
 	if (ret == 0)
-		component->enabled = true;
+		component->enabled = 1;
 
 	mutex_unlock(&instance->vchiq_mutex);
 
-- 
2.38.1

