Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596056EA7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjDUKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjDUKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:04:43 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A4B755;
        Fri, 21 Apr 2023 03:04:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33LA4WaS065937;
        Fri, 21 Apr 2023 05:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682071472;
        bh=rDJjkLEWgWQKOCBzrTnDZV9WdVOoQEU3x29VW9Nmsbs=;
        h=From:To:CC:Subject:Date;
        b=D8sVJla+D03D+rTjFYdJYGK6Z413A/fMQrNXYE8Rq3HcriAblgInpKYu6fALLqEkM
         WlnEciMGm9BM2Rv/oYjm4upl4GbZ/hU7ww2M6PGuoWZOXftxIoLB8/bYMHOMmgW2Jf
         95eEPm//P58AIuSi8L0wGqwyiTwNmAmAVobrPOds=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33LA4WKv115829
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Apr 2023 05:04:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 21
 Apr 2023 05:04:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 21 Apr 2023 05:04:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33LA4UIF005944;
        Fri, 21 Apr 2023 05:04:31 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <mchehab@kernel.org>, <sakari.ailus@linux.intel.com>,
        <laurent.pinchart@ideasonboard.com>, <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] media: v4l2-mc: Drop subdev check in v4l2_create_fwnode_links_to_pad()
Date:   Fri, 21 Apr 2023 15:34:30 +0530
Message-ID: <20230421100430.28962-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While updating v4l2_create_fwnode_links_to_pad() to accept non-subdev
sinks, the check is_media_entity_v4l2_subdev() was not removed which
prevented the function from being used with non-subdev sinks, Drop the
unnecessary check.

Fixes: bd5a03bc5be8 ("media: Accept non-subdev sinks in v4l2_create_fwnode_links_to_pad()")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/media/v4l2-core/v4l2-mc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mc.c b/drivers/media/v4l2-core/v4l2-mc.c
index bf0c18100664..22fe08fce0a9 100644
--- a/drivers/media/v4l2-core/v4l2-mc.c
+++ b/drivers/media/v4l2-core/v4l2-mc.c
@@ -314,8 +314,7 @@ int v4l2_create_fwnode_links_to_pad(struct v4l2_subdev *src_sd,
 {
 	struct fwnode_handle *endpoint;
 
-	if (!(sink->flags & MEDIA_PAD_FL_SINK) ||
-	    !is_media_entity_v4l2_subdev(sink->entity))
+	if (!(sink->flags & MEDIA_PAD_FL_SINK))
 		return -EINVAL;
 
 	fwnode_graph_for_each_endpoint(dev_fwnode(src_sd->dev), endpoint) {
-- 
2.17.1

