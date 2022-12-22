Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB07D6545CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiLVR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLVR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:57:30 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9D28742
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671731828; bh=NbZXBCQ0zuhpbO8iSD6DAf5s4MnrYqLPWQgkI/6U3r4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=mLkmWdPvr0CzcOgsrMhuOUIv5Xb/fypLes+qg6+S/5UM9sRkkc5LZVQCK5yAUQH9j
         k+ZKPnAJtnsvfM3+483wYq9rKG4AIweCfvINNhBULpDAvVVFe8yrWMQ3fAC9djj9Pk
         RbM5F+UX0b3zxsO+zEfaAAjLWcs2A76G7tu1Qsfw=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 22 Dec 2022 18:57:08 +0100 (CET)
X-EA-Auth: l91B3F18YcPJd6Louve5iAXX9QktyPZPCYEWdx+DnPtWi3EQrZwJHQgTpgTxZxXDkyCKjiYOoE7gaI9WqLUXF1EWbWVsLl2N
Date:   Thu, 22 Dec 2022 23:27:03 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] soc: imx: imx93-src: No need to set device_driver owner
Message-ID: <Y6Sab92tTDTk5Nox@qemulion>
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

There is no need to exclusively set the .owner member of the struct
device_driver when defining the platform_driver struct. The Linux core
takes care of setting the .owner member as part of the call to
module_platform_driver() helper function.

Issue identified using the platform_no_drv_owner.cocci Coccinelle
semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: Proposed change compile tested only using ARM64 defconfig.

 drivers/soc/imx/imx93-src.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/imx/imx93-src.c b/drivers/soc/imx/imx93-src.c
index 4d74921cae0f..f1c2e22d5cbd 100644
--- a/drivers/soc/imx/imx93-src.c
+++ b/drivers/soc/imx/imx93-src.c
@@ -21,7 +21,6 @@ MODULE_DEVICE_TABLE(of, imx93_src_ids);
 static struct platform_driver imx93_src_driver = {
 	.driver = {
 		.name	= "imx93_src",
-		.owner	= THIS_MODULE,
 		.of_match_table = imx93_src_ids,
 	},
 	.probe = imx93_src_probe,
--
2.34.1



