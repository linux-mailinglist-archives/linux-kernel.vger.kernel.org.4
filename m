Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436166AFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 08:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjAOHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 02:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAOHSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 02:18:25 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770A0C14A
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 23:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673767061; bh=k7u5aS66zy2fmuck3/VN5zNUw4xK14B+PFhiVV5QSGQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=VQOO7un7PPsAFbAr7KLG2+tIkjqC7C0QcZmQbjuHusQ18C1pFFrQHmd+RKrWKh4NP
         javzOLx2ZdrFw/pEEx9HxL7fj4GGE7To2jNQxQlDX3Z1kEbEMnlLSzq/he5g09DJpZ
         eqaHh0L3aPZisPBRejM6T4OxJQzFQ4PHneoXf/Sk=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 08:17:41 +0100 (CET)
X-EA-Auth: gJML6+RJH0TCGtjLi2DcR+NBXo7OT6FysMxuzOTd0N300DEI59IhkImS0QOaE82bWbmULJnwFnOdmU0aCdOgs6ZHYd2Kcspi
Date:   Sun, 15 Jan 2023 12:47:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH 3/3] drm/amd/pm/powerplay/smumgr/ci: use bitwise or for
 bitmasks addition
Message-ID: <6be220cf26f5416dc7e3dbd13ad42f6e7353d960.1673766696.git.drv@mailo.com>
References: <cover.1673766696.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673766696.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bit mask addition, it is recommended to use or operator "|" instead
of numerical addition as the former is quicker and cleaner. Change
suggested by orplus.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 5ca3c422f7d4..a164d12b88ad 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2203,7 +2203,7 @@ static int ci_program_mem_timing_parameters(struct pp_hwmgr *hwmgr)
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
 	if (data->need_update_smu7_dpm_table &
-			(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_OD_UPDATE_MCLK))
+			(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_OD_UPDATE_MCLK))
 		return ci_program_memory_timing_parameters(hwmgr);
 
 	return 0;
-- 
2.34.1



