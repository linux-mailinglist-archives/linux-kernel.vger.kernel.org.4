Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72E462E09D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiKQQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiKQQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:00:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E92D7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:00:33 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C16BA1056;
        Thu, 17 Nov 2022 17:00:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668700832;
        bh=n9ynhpvE53d3DCniGxgFDJ475k0hql5R70rDpcyDJxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSTy3PdldKbcq8IWLceXcm5WjdtdV/nOZ5QfeVQQorJiFWqjP8MVE7WyllL+DJNmP
         wE4UfHnKnB++iPrcSLCj3bDW1G3DtHVqj1iDB/lrM7CC12u14gI6bzk8cb/8O8C2t5
         fI/YHGqVNM5uxbcnVxKRxwjjkqoK9t4t0ToCE8yE=
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
Subject: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in structures"
Date:   Thu, 17 Nov 2022 21:30:13 +0530
Message-Id: <20221117160015.344528-2-umang.jain@ideasonboard.com>
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

This reverts commit 640e77466e69d9c28de227bc76881f5501f532ca.

In commit 7967656ffbfa ("coding-style: Clarify the expectations around
bool") the check to dis-allow bool structure members was removed from
checkpatch.pl. It promotes bool structure members to store boolean
values. This enhances code readability.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c    | 12 ++++++------
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h    |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index cb921c94996a..4abb6178cb9f 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -863,9 +863,9 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
 		goto release_msg;
 
 	if (rmsg->u.port_info_get_reply.port.is_enabled == 0)
-		port->enabled = 0;
+		port->enabled = false;
 	else
-		port->enabled = 1;
+		port->enabled = true;
 
 	/* copy the values out of the message */
 	port->handle = rmsg->u.port_info_get_reply.port_handle;
@@ -1304,7 +1304,7 @@ static int port_disable(struct vchiq_mmal_instance *instance,
 	if (!port->enabled)
 		return 0;
 
-	port->enabled = 0;
+	port->enabled = false;
 
 	ret = port_action_port(instance, port,
 			       MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
@@ -1359,7 +1359,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 	if (ret)
 		goto done;
 
-	port->enabled = 1;
+	port->enabled = true;
 
 	if (port->buffer_cb) {
 		/* send buffer headers to videocore */
@@ -1531,7 +1531,7 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mmal_instance *instance,
 			pr_err("failed disconnecting src port\n");
 			goto release_unlock;
 		}
-		src->connected->enabled = 0;
+		src->connected->enabled = false;
 		src->connected = NULL;
 	}
 
@@ -1799,7 +1799,7 @@ int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
 
 	ret = disable_component(instance, component);
 	if (ret == 0)
-		component->enabled = 0;
+		component->enabled = false;
 
 	mutex_unlock(&instance->vchiq_mutex);
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 6006e29232b3..70eda6cac1c6 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -48,7 +48,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
 		int status, struct mmal_buffer *buffer);
 
 struct vchiq_mmal_port {
-	u32 enabled:1;
+	bool enabled:1;
 	u32 handle;
 	u32 type; /* port type, cached to use on port info set */
 	u32 index; /* port index, cached to use on port info set */
@@ -83,7 +83,7 @@ struct vchiq_mmal_port {
 
 struct vchiq_mmal_component {
 	u32 in_use:1;
-	u32 enabled:1;
+	bool enabled:1;
 	u32 handle;  /* VideoCore handle for component */
 	u32 inputs;  /* Number of input ports */
 	u32 outputs; /* Number of output ports */
-- 
2.38.1

