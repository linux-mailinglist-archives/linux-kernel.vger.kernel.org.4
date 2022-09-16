Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15F5BA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIPG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiIPG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:58:00 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D7A3D2F;
        Thu, 15 Sep 2022 23:57:58 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9821A1A82EF;
        Fri, 16 Sep 2022 08:57:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 62B2A1A82EC;
        Fri, 16 Sep 2022 08:57:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D2951820F5D;
        Fri, 16 Sep 2022 14:57:56 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH] rpmsg: char: Avoid double destroy of default endpoint
Date:   Fri, 16 Sep 2022 14:39:26 +0800
Message-Id: <1663310366-720-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpmsg_dev_remove() in rpmsg_core is the place for releasing
this default endpoint.

So need to avoid destroying the default endpoint in
rpmsg_chrdev_eptdev_destroy(), this should be the same as
rpmsg_eptdev_release(). Otherwise there will be double destroy
issue that ept->refcount report warning:

refcount_t: underflow; use-after-free.

Call trace:
 refcount_warn_saturate+0xf8/0x150
 virtio_rpmsg_destroy_ept+0xd4/0xec
 rpmsg_dev_remove+0x60/0x70

Fixes: bea9b79c2d10 ("rpmsg: char: Add possibility to use default endpoint of the rpmsg device")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/rpmsg/rpmsg_char.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 0850ae34fb88..562d545ac0d3 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -76,7 +76,8 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 
 	mutex_lock(&eptdev->ept_lock);
 	if (eptdev->ept) {
-		rpmsg_destroy_ept(eptdev->ept);
+		if (!eptdev->default_ept)
+			rpmsg_destroy_ept(eptdev->ept);
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
-- 
2.34.1

