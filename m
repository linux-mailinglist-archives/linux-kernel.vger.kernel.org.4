Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337E62DC29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiKQNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbiKQNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:00:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3E6456D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:00:15 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A522105A;
        Thu, 17 Nov 2022 14:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668690013;
        bh=7I4XZur3XWHa7tenurKlkHinu6BspwE8Zh84rEdNBW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOVzyTbYqueSEsWntTvaBO27iXxe2XQdULeguVvImsXSsUJAoDKgYtDJzaxC7m+0p
         7JSC//J7tMX+ZBhtW5uBcyU13nByQQ/W/6J2OCImq91vJb3ax7RtE3Ym5MYDYZLTfH
         z9lHV0fUeg16Sd1FL0SghuUZDsRviYYLuGlJnzxY=
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
Subject: [PATCH 2/2] staging: vc04_services: mmal-common: Do not use bool in structures
Date:   Thu, 17 Nov 2022 18:29:53 +0530
Message-Id: <20221117125953.88441-3-umang.jain@ideasonboard.com>
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

Do not use bool in structures, it already gets flagged by checkpatch:

"Avoid using bool structure members because of possible alignment issues"

Hence, modify struct mmal_fmt.remove_padding to use u32. No change in
assignments as 0/1 are already being used with mmal_fmt.remove_padding.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
index b33129403a30..fd02440f41b2 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
@@ -32,9 +32,9 @@ struct mmal_fmt {
 	int depth;
 	u32 mmal_component;  /* MMAL component index to be used to encode */
 	u32 ybbp;            /* depth of first Y plane for planar formats */
-	bool remove_padding;   /* Does the GPU have to remove padding,
-				* or can we do hide padding via bytesperline.
-				*/
+	u32 remove_padding;  /* Does the GPU have to remove padding,
+			      * or can we do hide padding via bytesperline.
+			      */
 };
 
 /* buffer for one video frame */
-- 
2.38.1

