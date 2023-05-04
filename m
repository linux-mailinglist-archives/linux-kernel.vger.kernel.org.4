Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0D6F6D71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjEDODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEDODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:03:03 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBE46BB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:03:02 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 344E1fZO011334-344E1fZR011334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 May 2023 22:01:46 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo.mondi@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@google.com>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: staging: greybus: fix GPF issue in gb_camera_capture
Date:   Thu,  4 May 2023 21:58:41 +0800
Message-Id: <20230504135841.1566958-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gb_camera_capture(), it does not check the value of settings
before dereferencing it. And gb_camera_debugfs_capture calls
gb_camera_capture with the 6th parameter settings as NULL.

Fix this by checking the value of setting at the starting of
gb_camera_capture.

Fixes: 3265edaf0d70 ("greybus: Add driver for the camera class protocol")
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/staging/greybus/camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index cdbb42cd413b..5a4b26e7f645 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -659,7 +659,7 @@ static int gb_camera_capture(struct gb_camera *gcam, u32 request_id,
 	size_t req_size;
 	int ret;
 
-	if (settings_size > GB_CAMERA_MAX_SETTINGS_SIZE)
+	if (settings_size > GB_CAMERA_MAX_SETTINGS_SIZE || !settings)
 		return -EINVAL;
 
 	req_size = sizeof(*req) + settings_size;
-- 
2.39.2

