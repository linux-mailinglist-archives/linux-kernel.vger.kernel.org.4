Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41E1602DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiJROEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJROEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:04:14 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED10D03A9;
        Tue, 18 Oct 2022 07:04:12 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B14902139A8;
        Tue, 18 Oct 2022 16:04:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B6B621399A;
        Tue, 18 Oct 2022 16:04:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A671180226C;
        Tue, 18 Oct 2022 22:04:09 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH v3] remoteproc: core: Auto select rproc-virtio device id
Date:   Tue, 18 Oct 2022 21:44:04 +0800
Message-Id: <1666100644-27010-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multiple remoteproc device, there will below error:

sysfs: cannot create duplicate filename '/bus/platform/devices/rproc-virtio.0'

The rvdev_data.index is duplicate, that cause issue, so
need to use the PLATFORM_DEVID_AUTO instead. After fixing
device name it becomes something like:
/bus/platform/devices/rproc-virtio.2.auto

Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Tested-by: Peng Fan <peng.fan@nxp.com>
---
changes in v3:
- add comment in codec

changes in v2:
- update commit message

 drivers/remoteproc/remoteproc_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8768cb64f560..f9187e35b090 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -509,7 +509,13 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	rvdev_data.rsc_offset = offset;
 	rvdev_data.rsc = rsc;
 
-	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
+	/*
+	 * When there is more than one remote processor, rproc->nb_vdev number is
+	 * same for each separate instances of "rproc". If rvdev_data.index is used
+	 * as device id, then we get dupliation in sysfs, so need to use
+	 * PLATFORM_DEVID_AUTO to auto select device id.
+	 */
+	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
 					     sizeof(rvdev_data));
 	if (IS_ERR(pdev)) {
 		dev_err(dev, "failed to create rproc-virtio device\n");
-- 
2.34.1

