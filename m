Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00326545C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiLVRyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLVRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:53:59 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA125B7CC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671731603; bh=3ETUOeCPDi1oDHbMKQ5C1PSdaUw3QrTKHENp4S5ajiM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=cvYzXywCymULk+YsuPvxpb898nH8RiwyTXIFjPk9zzK3I6a87sxAdOor9VRFQprxv
         l/BpxW03KrRViffdEBJ+oaot4ixzo+LNBtZQ3sORQY9wq4SpHres45kKxV60OGoVx5
         GR1JwIGhQtmBmfqPXwEZMoYq+qhnOz/3S1u+4d2k=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 22 Dec 2022 18:53:23 +0100 (CET)
X-EA-Auth: FGv2lU2fXVqh2P8ZF+Ku/esRLcz4/4p1S8LbuB3SgzgTJnrloxCZsJzlsnwCgWTiSeSxOLC1oZbxRHCOTFtWQtXv9dUeRJF0
Date:   Thu, 22 Dec 2022 23:23:16 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] soc: imx: imx93-pd: No need to set device_driver owner
Message-ID: <Y6SZjDKWve8/T/ld@qemulion>
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

 drivers/soc/imx/imx93-pd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
index 4d235c8c4924..832deeed8fd6 100644
--- a/drivers/soc/imx/imx93-pd.c
+++ b/drivers/soc/imx/imx93-pd.c
@@ -164,7 +164,6 @@ MODULE_DEVICE_TABLE(of, imx93_pd_ids);
 static struct platform_driver imx93_power_domain_driver = {
 	.driver = {
 		.name	= "imx93_power_domain",
-		.owner	= THIS_MODULE,
 		.of_match_table = imx93_pd_ids,
 	},
 	.probe = imx93_pd_probe,
--
2.34.1



