Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C64602A53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJRLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJRLfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:35:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2135.outbound.protection.outlook.com [40.107.105.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44A285AB3;
        Tue, 18 Oct 2022 04:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQf4RWMoHhFsjURPR0iNrZ0oHFwRjXwYqK1mtKXk0Oua17atVfJkBNgd3q5BzniUc/w7i8v7QJU6MoVJ8pE+7VH5mxRAbdUGe+C8XpHG/DC37QBgfI6F6WiQPoFZbC9SlvaQbeIXIVyEi+cSFWovhUxc2aT1hwpbvwQaq+rO0dwp1knzqD7rXA0cF4cJh3eXe6DCCdSfRzBg9on5G/wzew3vcCm0zHPURYVnBEBcs6s5ZZIRAEMkrxyonAUU1nDXPWa8YT8iT4SBrgDaO/eKeG8zDQ6f4Z8Qa1wOeDonYit8xzuoqB08FnWx+6KEGYXQ9Y9MYBOs6skkiYMm9yHssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYf7+7ywWhm8+oqS+1Czes95nmvSVKWaEjfRgqkTfac=;
 b=n0dQhj+EWWn4jtzyTloRJEfl7q7Hm+XfrxCvHnk2rJOkABPKJzoeEnlGIMyvdzAe7tC3RLrMSMVxgALjlz2UQTi99zel0d2uWy8niJH6qR5psWBLQi9dfiwRt3WUyn0GWeasmFgotC/uNpqipZwy78Je3sn6veW8hJ51Z/qPTId1B9Xkm/hDkrS98xV6R+7REePbonz+/AquhMWJ8iX/Q5sEtXmu49tXR3q9+54oyVSryDDXQJtTSia2y/EdLVDFMw2O2y3LhnULfGpkqEmN1cAuA0/AIVvlvIMZGtG5izw4nitHNjZEErRl2OPRALow9/mRAW3DwPlL5dT4vV4/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYf7+7ywWhm8+oqS+1Czes95nmvSVKWaEjfRgqkTfac=;
 b=ZsILeEAAikZtF7bYuXyzUq9FyHKf+3eCwj1PMRaxSK7NCx3Bf4UYBaf0ViR7YGMxSwpouulPCjS/6UFm5zqUNmA5gjvmGZErwrSPV0kygj3BOXVoGTxi3S7t8LoSRAv150165+2sE4EdvvnbcwVUWGB+d1t3izwYoM3liV3D9pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM8P190MB1010.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 11:34:30 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 11:34:29 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2] usb: ehci-orion: Extend DMA mask to 64 bit for AC5 platform
Date:   Tue, 18 Oct 2022 14:34:00 +0300
Message-Id: <20221018113401.32229-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM8P190MB1010:EE_
X-MS-Office365-Filtering-Correlation-Id: 750b35ba-bd96-4c2b-d3d6-08dab0fcb822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEyFGo+Id9BiO3p2lIzlrO5095cthIM0CZUn9xOvVzTqgTO7iFsXRIDmprPtAxhiGuDY5Oina3RUzX5lMfx2zoqLSY8rXHjweVyzELmmFD0wE5+1aeMYYVOp56jGjnSxFx1WDtmwgQjULs632keG4gTylBA/3hMYtUJmxR9sMoY3hf6j2gemfZ5N1l9zuzudZWHwvFIV9seJazM78yjCfIpJoZ03RHMxX8TMWZ6o8NCm8843kbJycfJLbPRy5JzFSaNuQY2tUDAr52X6lY/9aANeCJl4r0iOfxt9nVsOeWTFJGEeU6q5pwy7RWL3BojLhlMYmG6Z6sxIjPQVqjXCiwtQ3U3Hk1pX30nDC/NeC/nOrCFwl9qgp0DVAaI9++wF7AOtzyXq73tILKIem3jCwfw/PkEi1haRTg6Eeud5Da5nIxogtbKDd8hrXvCh0VNu/wxrWyY7apEBs5w6wfcrToo6YXwQSNjjGrpkh8J4HvxHY8ZRUUOJyhctuuLotAGYCPK24NP6VAqnXth8nUsGR0wn5Su8xdUZYxBLixHeB18Dt1v0NV9iUDoe0GmW5V2eT8O2FWgBm/C3oJVe+mCzP3u3gn56a/VY/yYDMEv5/P42uxbbRjgaU7Uwj6Qj+5/YyTKTff1J8XTbS0ij++NrqMuy0ni/LmmyPCvm948llO5sGFNCz3/tOX2USnj7eV8wbs/MUz7amGeDb3EjwUcrTO+TTnEE4HFefHbTQ/ztclA+IqFjKJlKOuD8Un60e7JJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199015)(6486002)(83380400001)(2616005)(1076003)(186003)(41300700001)(86362001)(38350700002)(38100700002)(2906002)(5660300002)(44832011)(4326008)(52116002)(6666004)(41320700001)(8676002)(107886003)(508600001)(6512007)(110136005)(26005)(6506007)(316002)(66556008)(66476007)(66946007)(8936002)(36756003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFtLR2SwSJMpaDfyKLkA2dG/3kFses4w//MeSRFjRBhpOKiNM8uLuwgvOj3b?=
 =?us-ascii?Q?uJWX/WC5szjbaFyfCLAybDKHqIBf21PomtefnjwNl8vmTfzng25u/1iTLfML?=
 =?us-ascii?Q?ejHShQ9Ev9rPZnS51KT6f6F6+zkY2RTLPG+n8EVoYZbBDGi0ScnQG+VrhJZW?=
 =?us-ascii?Q?OzbB9LvJyKMFkHw36p9hx9MHpYlp5IEJWIGFNW95gjQiPWbjqzQ4kHJbW2tL?=
 =?us-ascii?Q?UqOVT5iVQcs5puSxrZW0kmgVZNRRFVlkFV28nFCGjyLrA1xgDp+KcVT3eiWi?=
 =?us-ascii?Q?eMko8pNtVHakvg6HcPjzirkSwePjtr8keQX/xjZZS56iT8a9pr2RVSrbISd6?=
 =?us-ascii?Q?pvW1e1bxbcxCaqrQE17hPV49FCVf7fVG3VOJNrZNvG4pUtuWXQmx3DQjzbDj?=
 =?us-ascii?Q?WYyKZaiDKsHsRRsXjeMNG0Noi3mv+NcZhrA5EPfbdhtwymjjzy1kIdxCe+H/?=
 =?us-ascii?Q?tWheiX5dXwzDf4ODDFr+dEYxi0gv1rhNiSvR15eQ4n9RmA7W26n1tvG/Qqts?=
 =?us-ascii?Q?Q7JYJ9zY7Ni9a43xkBvSXZ6mfNlW0lyLZ7gLOATZIFYkjhpwb6sfZ5b4HCf6?=
 =?us-ascii?Q?fPnTeq5E7svfwgh5jQ/33nnnD1az1mRZtAaoN3BM7zCDNZJFHd1bBRjG/SBW?=
 =?us-ascii?Q?+/vzh7LYxotgyPPPJDxcHxSIcw/LzOCNeX7/QUPHJN+aX0VeH/6n4c0Iww1m?=
 =?us-ascii?Q?tb11UzXgpw7PGSsXe50JwrzDMwkcj/1cquIUQpQIrhMLRirPOALylh0lFf1h?=
 =?us-ascii?Q?z+CMKfGDWfDRdCPv+l6rG1Y/SAwk18F9iniJcNNiftEyPa4cJmzthex5EV/q?=
 =?us-ascii?Q?qLTJ0QDK2fkWAlQlxwOK+WHyND1ME73NIIZ1osAnFsJaU6nlT6Gdi6hp+C2F?=
 =?us-ascii?Q?GwAR7Jq3Y70GyD4OyWZxI0kha8Vcs+TM6nxWkytbASrLlQ9+btiJqsm25DaN?=
 =?us-ascii?Q?zwqnTS/8sDkqIVJpbCr2MPLOp+LgGP4ybgryLSzYncCqPU1EYSOMwSMES4Hd?=
 =?us-ascii?Q?I15P4P7JGbwQ6boQn8SQULgcVrnHthYiZDRo5pS9yI12FxOxCXhMITG7ztVg?=
 =?us-ascii?Q?baBRz53fYyfptfMAXgYirQ5QwjthZEnuQFUH67qHfKZffIeXsbW0JlBxD2W+?=
 =?us-ascii?Q?EcmBCHtrORVZj8rIRIisAHG+Ypla6YuMtOfwmxI8whCXJh7lJrosz9oUtQpT?=
 =?us-ascii?Q?CrIiuUuuaVnH1ocgV2dGmkfxUsDdImSeiw65GjnYfZE6PI/KsMIIQXj+TD46?=
 =?us-ascii?Q?5IIOqsgaMla2bhKG4xdLS7o2gNdCQOu9DAfj2Y84uzJf/OPvR8RzwXZMtwu5?=
 =?us-ascii?Q?sZmMass+fATLY3puhvR6lHgpqEwJxKFqAGYtrCVxPSGh9xWPtu6NQqLWr6QL?=
 =?us-ascii?Q?qZ+plNp8n2dX210OQ2Mveq5NR7nix0Hu5dH6UVSmV5L1XWaa+jgfR4bw/qIT?=
 =?us-ascii?Q?HpgBzG9HXeBk/ZkhKzoU9ZOv7F9krQOCuzQuy7R0udyVurjAhFhWA0pA5h+4?=
 =?us-ascii?Q?QNTqVFs6Ht4FyyJ1W2tyXPjS7f4Hu8Pbfwt6LvYk+12XcnyeuLBS/LZMyl65?=
 =?us-ascii?Q?cUbfcP1VDg/5fbLGW+FqPP1Vr48SUY8Nsd+y0wmJNnDHPesevB3UYWQmL2mp?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b35ba-bd96-4c2b-d3d6-08dab0fcb822
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:34:29.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNDB52TZm/8z5wK11whZcU9iA0XF9zKu0Emd9/KLMdVMHLPmRH+0CknIStlSsfzWJQpHpaoQvjAFAuHApYwnRZnwrBpROPV2bhmaI3hunCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB1010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

AC5 is a 64-bit platform so extend the dma mask accordingly.

Checked this mask on armv7 a38x SoC (which has this
USB controller) platform with simple fs ops on the storage device
but on older 4.14 Linux version.

Signed-off-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   Add missing description.

 drivers/usb/host/ehci-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index a3454a3ea4e0..c6205abebbdf 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -230,7 +230,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	 * set. Since shared usb code relies on it, set it here for
 	 * now. Once we have dma capability bindings this can go away.
 	 */
-	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err)
 		goto err;
 
-- 
2.17.1

