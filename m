Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1836EDA01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjDYBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjDYBp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:45:59 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690103591
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:45:58 -0700 (PDT)
X-UUID: 9f6bb248181d4d54822b9d9891d4fdbf-20230425
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:67799942-4058-436d-8104-f1c19049ea09,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:67799942-4058-436d-8104-f1c19049ea09,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:83d603ec-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230425094553WM112X05,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 9f6bb248181d4d54822b9d9891d4fdbf-20230425
X-User: zhouzongmin@kylinos.cn
Received: from thinkpadx13gen2i.. [(116.128.244.169)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 489722498; Tue, 25 Apr 2023 09:45:50 +0800
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [RESEND PATCH] drm/qxl: prevent memory leak
Date:   Tue, 25 Apr 2023 09:45:43 +0800
Message-Id: <20230425014543.3448839-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322085847.3385930-1-zhouzongmin@kylinos.cn>
References: <20230322085847.3385930-1-zhouzongmin@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocated memory for qdev->dumb_heads should be released
in qxl_destroy_monitors_object before qxl suspend.
otherwise,qxl_create_monitors_object will be called to
reallocate memory for qdev->dumb_heads after qxl resume,
it will cause memory leak.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 6492a70e3c39..404b0483bb7c 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1229,6 +1229,9 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 	if (!qdev->monitors_config_bo)
 		return 0;
 
+	kfree(qdev->dumb_heads);
+	qdev->dumb_heads = NULL;
+
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
-- 
2.34.1

