Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFF6547B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiLVVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLVVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:15:35 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220414D1C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671743721; bh=wdZWXREs23UJurCPJSaRRURkt4bR1UNV3+Qmxgjy/wY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Rq7SDQLqgswGo4+TLDsSsZffMG16TZocNQpPGke+zZ49bjiyRG5MfrHQi4jDy7aKb
         SuCdgsRvG2BBdJK7xhMJmU36KwvlVV1HfwQ/aYBOoINF4LqQjh6XaYBYgeNo2RATs5
         sSj1+or5XUSOya/Di72vgQD8G5rxi6WRJy097jeo=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 22 Dec 2022 22:15:21 +0100 (CET)
X-EA-Auth: x1X1YHVLLgk9fNauahX0z1zlVD+p3LfWBHpwaT7t1dquufMWtxg6rDDVcYt7XJRu1H+sXOFe1ZJX4yXwGMQ0/piD64dKEliL
Date:   Fri, 23 Dec 2022 02:45:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] drm/amdkfd: Use resource_size() helper function
Message-ID: <Y6TI1O9adSP/OrnT@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the resource_size() function instead of a open coded computation
resource size. It makes the code more readable.

Issue identified using resource_size.cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: Proposed change compile tested only.

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 10048ce16aea..de8ce72344fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1027,8 +1027,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 		/* Disable SVM support capability */
 		pgmap->type = 0;
 		if (pgmap->type == MEMORY_DEVICE_PRIVATE)
-			devm_release_mem_region(adev->dev, res->start,
-						res->end - res->start + 1);
+			devm_release_mem_region(adev->dev, res->start, resource_size(res));
 		return PTR_ERR(r);
 	}

--
2.34.1



