Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7D638F49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKYRpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKYRpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:45:11 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3140E537D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:45:09 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id ycl6oRgotNKuIycl6oW0Qo; Fri, 25 Nov 2022 18:45:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Nov 2022 18:45:07 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vamsi Singamsetty <vamssi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abhinav Asati <asatiabhi@codeaurora.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] misc: fastrpc: Fix an error handling path in fastrpc_rpmsg_probe()
Date:   Fri, 25 Nov 2022 18:45:02 +0100
Message-Id: <b909d2f3273b794ea0f1f78d14bc24affb08ea5f.1669398274.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_platform_populate() fails, some resources need to be freed as already
done in the other error handling paths.

Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
Fixes: 3abe3ab3cdab ("misc: fastrpc: add secure domain support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
First Fixes is when branching to the error handling path should have been
introduced.
Second Fixes is when misc_register() have been added.
---
 drivers/misc/fastrpc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0f467a71b069..22163728bd85 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2127,7 +2127,18 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
 
-	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+	if (err)
+		goto populate_error;
+
+	return 0;
+
+populate_error:
+	if (data->fdevice)
+		misc_deregister(&data->fdevice->miscdev);
+	if (data->secure_fdevice)
+		misc_deregister(&data->secure_fdevice->miscdev);
+
 fdev_error:
 	kfree(data);
 	return err;
-- 
2.34.1

