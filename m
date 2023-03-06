Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D886ABB22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCFKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCFKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:09:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD98222E3;
        Mon,  6 Mar 2023 02:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7A52B80D75;
        Mon,  6 Mar 2023 10:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D85C4339B;
        Mon,  6 Mar 2023 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097358;
        bh=bGa3LGEVgDSMBMrHbY9SDca40Ab9EZJo6raY1+G6bnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4K/DO2KNmrupnIfHYchxc2UfYBt+ntb9XeIKxWGY2NvBnr/6pLEOGvemrg5fN2Ng
         TDJDSWJnlYK7NM2bkxFtMOJxLHJVlFpUbr+FiIG8IN3B9mOORHSv7o87F3gv4Tijg/
         suIUfLnherbiHKtKgP5iAsBoXOd+Ao9o2eDq0fT4jqNGh7Q104rOdU5WZRNsMCVY3I
         ZDtHhN4TUeQ68TtJsBTlDoo/iKSMV6YsFHhwOMLvgtPAs8cWXHV7K0ixfLS8piv/F4
         eCUvpOujgpTkX4c0tW1ZCXJxxoQZmhlCgZxOH0/Oo5hVjzAuypSTNG+gv4yV93FL3j
         eGlI8UyK2RmoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ7n5-0007Qb-1F; Mon, 06 Mar 2023 11:09:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 01/10] Revert "drm/msm: Add missing check and destroy for alloc_ordered_workqueue"
Date:   Mon,  6 Mar 2023 11:07:13 +0100
Message-Id: <20230306100722.28485-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306100722.28485-1-johan+linaro@kernel.org>
References: <20230306100722.28485-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 643b7d0869cc7f1f7a5ac7ca6bd25d88f54e31d0.

A recent patch that tried to fix up the msm_drm_init() paths with
respect to the workqueue but only ended up making things worse:

First, the newly added calls to msm_drm_uninit() on early errors would
trigger NULL-pointer dereferences, for example, as the kms pointer would
not have been initialised. (Note that these paths were also modified by
a second broken error handling patch which in effect cancelled out this
part when merged.)

Second, the newly added allocation sanity check would still leak the
previously allocated drm device.

Instead of trying to salvage what was badly broken (and clearly not
tested), let's revert the bad commit so that clean and backportable
fixes can be added in its place.

Fixes: 643b7d0869cc ("drm/msm: Add missing check and destroy for alloc_ordered_workqueue")
Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index aca48c868c14..b7f5a78eadd4 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -420,8 +420,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	priv->dev = ddev;
 
 	priv->wq = alloc_ordered_workqueue("msm", 0);
-	if (!priv->wq)
-		return -ENOMEM;
 
 	INIT_LIST_HEAD(&priv->objects);
 	mutex_init(&priv->obj_lock);
-- 
2.39.2

