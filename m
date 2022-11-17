Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB562E0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiKQQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiKQQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:00:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765913D44
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:00:38 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03B7D133C;
        Thu, 17 Nov 2022 17:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668700837;
        bh=JDyW2hzBjXtCPuLRQW6K0nYPrFiaE+Knjz7OMb7YeCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbhODj6iiGEgRSu9rTpEpm8hgEd04o/j8lstv9znuQDIJM2AvFkXQ2CTme/Xs3UDu
         SNdRsGlOAahqsWbNNDdRy8FiQHtm7BmLzgT/z2XrDG5b/i1kS9vFj4i08zGGKeBYG3
         EnJQbychWK4/Bhx/s1njWyVuUdemz9L2kljwIOjI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kieran.bingham@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/3] vc04_services: mmal-vchiq: Use bool for vchiq_mmal_component.in_use
Date:   Thu, 17 Nov 2022 21:30:14 +0530
Message-Id: <20221117160015.344528-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117160015.344528-1-umang.jain@ideasonboard.com>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
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

In commit 7967656ffbfa ("coding-style: Clarify the expectations around
bool") the check to dis-allow bool structure members was removed from
checkpatch.pl. It promotes bool structure members to store boolean
values. This enhances code readability.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 6 +++---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 4abb6178cb9f..294b184d4a49 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1648,7 +1648,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 	for (idx = 0; idx < VCHIQ_MMAL_MAX_COMPONENTS; idx++) {
 		if (!instance->component[idx].in_use) {
 			component = &instance->component[idx];
-			component->in_use = 1;
+			component->in_use = true;
 			break;
 		}
 	}
@@ -1724,7 +1724,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 	destroy_component(instance, component);
 unlock:
 	if (component)
-		component->in_use = 0;
+		component->in_use = false;
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;
@@ -1747,7 +1747,7 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 
 	ret = destroy_component(instance, component);
 
-	component->in_use = 0;
+	component->in_use = false;
 
 	mutex_unlock(&instance->vchiq_mutex);
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 70eda6cac1c6..c5be86b0479d 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -82,7 +82,7 @@ struct vchiq_mmal_port {
 };
 
 struct vchiq_mmal_component {
-	u32 in_use:1;
+	bool in_use:1;
 	bool enabled:1;
 	u32 handle;  /* VideoCore handle for component */
 	u32 inputs;  /* Number of input ports */
-- 
2.38.1

