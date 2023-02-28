Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BE46A5409
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjB1IBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjB1IAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:00:35 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513A1C7E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:00:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rne3tlaezUHrHiZazvVTYPBkWKHU9TvM4nmhpMx1D54JDWcGg9GHN4Acy40SINiBBgzht3wLo5zalg7lnMixC1Ys3dHhIASekpd8z1McfExu126FtL+Mtpt3/mpBGLd02fWU2akQKhW7MALbwjjTPZ+0ZH9Jcd8lz5JhYqXwxni0uuKHcjR+KkBJw6hBzE4grKrqlomiU6siaLnCSsodV7UcPr0hHbRO4q5ZNEbJo9rT69eKuBryNyAXkxdFzUK2RdB/blN1fv4wjNGTBqYaj+uaa7OqzD+BmYQzbwnFOtN6qaQGfdVAVRhYafGb+BRqHu5bPhjvzBUh/x9N/C24AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RHdEP9kAXjQwZnAPLnh49PGos9wCxvwHIQk/PqbFys=;
 b=N1icxa1DaMZtcK3rmm+oXbaFOMd+hD9yu11Vw7RXiPrOa4S5jeIKCqz+QG1cd24nnkhCrdffWQs46KJO7WusL2ZOI/wosMpec2XskodqzwRAw+kmDus7uBvm1uVYdWqtSyCpkCDpmdhweUvYJ4NyPQZ8+tM+Fm9KIcIl1tOKEmkdwDkJZd7q3HsTCTOeqpqargnKUfkhG6gvI8nqKh7JZy0iiwsWVu9kMl6FefPq9atGlK/sFM9gj7eaVoAYsymz3BHU5FadiDgWYN9rfkPAkLkypSP0R7JEWEqWuNiZjKNRzSGVkVvTYBW3P7UB1mf+HS4hLtEYxpwP+uQXbgJCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RHdEP9kAXjQwZnAPLnh49PGos9wCxvwHIQk/PqbFys=;
 b=jIeURNS4DkOCxsiLR7Kgmhp8+OsCNW/heVL7UR5DT5kcGyE+Ca8bLl9LrCfnxUtIJoRTfZSbutfm5dvGpfs+C/dEFWDwSq0we6/ecEdF6pWPZKmUi7vE59te7lQ8j6IgRz6frn9nv/Q8CO6E6sCOLl5EhC6/Dk6rQeM1iTA5D30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 08:00:07 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 08:00:07 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH 6/6] soc: imx8m: Support building imx8m soc driver as module
Date:   Tue, 28 Feb 2023 16:06:44 +0800
Message-Id: <20230228080644.412894-2-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230228080644.412894-1-jindong.yue@nxp.com>
References: <20230228080644.412894-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bbdcc9-709c-4ab2-f907-08db1961ce4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZeQEFkAR6cpngHXmTBt308u55b3owzQ06a5+r93NGQyhkBnP5cR3+5oMPn3Mp1TXeY7CoSXZxJuJ08qpEGQqz9vlo52qoELcC0KkS5XmY0v/m/Tva8yhIlDJTowKR++N61/l9670BEH1p0aw9bRjR12nw1m3Atmakw7KyZtiZjuGLCTu6ivUFWG0XvHqeire3lke3hwsTmlTgq5m9fLCRghiagmNAxVngwNwdQJMQO+5OFt9QGvtiJMRvOh0ZF3jNVqdhZTk+DisdO3AZt3DaTRZwDL0f7h7dHk86hxZCGWel3s/dCwnHwNu9AfIPPshbCcPPJnhFmXs9Wb3cLVsy7z361GCjBkkJuIsDcIuHIsQicjVO9FksmTBRoVqnTlskFqnUhX0/AXsrqLT2V6ojivB6Gwy4BII/5lwtGlobgvgXTvYysRW7yl6c4YXrYZ7BsP//IIWJgzVof77cifljzv/bdfAS0FeOAZf5QFYOAl4sUdrRVxukHm9nfuHppr5ltQd31WIXCahidlFArRAz7Vl3DD4iGYtSHk6ZwqTtNy46YgxXsVoddhw/NVl4VErlOw53XXiGpkhHPcu1Z5erUYzLz6wnUzPE0qv4p30SN5LHrZfpv+2EgxC0CNtRScq2nfSk0b95rPOKIImM71LkLGKFmL9zgQJtjjRNAWM3g85WbZpLQRK4Da0cgdboiaeD7RXGZo4VLKg3rgVRbxNdXI83nS9zPLueZJbQt4eAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(2906002)(38100700002)(38350700002)(8936002)(4744005)(41300700001)(44832011)(83380400001)(5660300002)(2616005)(86362001)(52116002)(478600001)(6486002)(6506007)(1076003)(6512007)(6666004)(186003)(8676002)(66556008)(66476007)(66946007)(26005)(316002)(4326008)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0pVbUwbYTMd74WsjsDY46Rd+EaO9K5e9oWubxMHDKkyd5JbWl2yC1SI2uzf?=
 =?us-ascii?Q?v4ZxLGU2k+UhLNIS3sdBAKd6lbF/dJVYWjOQdU7M85FJDSRSDQHuOCfbJsOM?=
 =?us-ascii?Q?yaA59oT7t1DtqCE7EXmRPkJzKu+ZKG1FK5sqL3aHmZStctPJ4qRoC9114O7e?=
 =?us-ascii?Q?Tpm/aLRusrKDFbO468XeZfbO6l+97eNtVNCrOIPfuuHu1k9e1QspPDCdJ/SN?=
 =?us-ascii?Q?Sg3iREPlrZxieBt/DiU3adJuBhUh7kbFth9oMWL46OvPF1N2cr18sugWbxwa?=
 =?us-ascii?Q?A/TuW/xS5CeMsQ4rDj/0lNVmt6vCGShJe+u+IKA7d/gatFgy1l6grQNbM0qp?=
 =?us-ascii?Q?2MycLtjsUdTjxNVNTN6fmqM1lAXcCmMFT5NuynMXeynzWHaXRyxzc3kc1ViA?=
 =?us-ascii?Q?E/Cq4XtmIoC7VLybcgoIzjRJCKL18TEJNQ9D9u8FQoU6PnmPoHmORASl9Hv6?=
 =?us-ascii?Q?RR9NPupGq374I1WBYTKmS/VAWyphbcnDeRdxe1depT4blItmwiKLpBj24TYn?=
 =?us-ascii?Q?xJkLxoiNaTWxguyPfNnHdCsb25YBvKPDExmLk21WOvnrCFdc9kvqyAmSrXKN?=
 =?us-ascii?Q?1lm34gTAt2S58VRUUPbKUUysF2m5LUlsZndACj8oLZ1nbhIfXU1WcD37ljZE?=
 =?us-ascii?Q?qW2zbQPz/kq8D1K1A/gxRO0BJ5lDzB121vyqYOhzsbTjGYEJtPfiz0CFLFUL?=
 =?us-ascii?Q?KvIYC0dnxYLOQwy0BCyF91rM/hGtk3XXA0KDg2DXXOvlZIQweHPDO93tRZ4P?=
 =?us-ascii?Q?sKUnQu3RdcRAQqkIVk8WuVwjgA3PiuSbeSOWvtX0Fle9RKT7Qsv99o5Irtqj?=
 =?us-ascii?Q?Ezxj+27BjhbP1TOvT45k3gptayiz8w59SWAC2W1oAjUPk8H3oLiSPmqkvv/t?=
 =?us-ascii?Q?GIyWWiO0dR/uoN3g7BB79oiZjdyVoCD+dePcDX2prSvARl7zHXGAb3jYnHXo?=
 =?us-ascii?Q?jmz9PDCMQt0T1s7eFl+d4gTM8D1mW6bkdDu0MLTa6COXKVSsF9AxLlCCtws3?=
 =?us-ascii?Q?VSe5I+DL7psR7bERHs6WjgcjjlKIh3rIHUr18L17nSlerUd6BXVBCaV1Lmj4?=
 =?us-ascii?Q?f/iK0YCVVxcLkCTXbdYefucpEt8wY73hdr/5Qhlbm14rMzK5XXlF3AkKrSms?=
 =?us-ascii?Q?VMHV9OuNqDXFJj8l0Cb0cqvky/1qcUk0YV672tgWbOk7C+9x9QT7cVeKLZwj?=
 =?us-ascii?Q?kDld6wycZmCIT+lAMt7Hf04QuZX7QCoObFoNY5YeHa0H76CJAHWlzT30Joys?=
 =?us-ascii?Q?4V3F4F7nTV0Q7P/VPr2t2tJKA1USS8GJla+D2YirxeBg+HTEi7S/urUQvyhb?=
 =?us-ascii?Q?nIUaCUfnBtNaKDSytCBWwtobRTjLdbm8cImPK4dBMOsqxMpi/VKZUarDwH0B?=
 =?us-ascii?Q?zGUKXaSTsdq8X5H7UjAr+eLMn3VSkOH/7j0F0N/lFgfUQFhPH04DNT6h/0hf?=
 =?us-ascii?Q?YZcL1Zd34Eqrfn0t37aGOq6RmRTK+qtDCztTC3ib809OuiIZMFfvu/cCDam4?=
 =?us-ascii?Q?Eq02IKHQOFdkN3I+At10jtNj7JV0LVvPYkELsEF2tttzLkbW3iJ6uqf3rcKP?=
 =?us-ascii?Q?uj4MR3f07/8OXbATpMQroJ1A/66OwgnIKBF2MGhg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bbdcc9-709c-4ab2-f907-08db1961ce4b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 08:00:07.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIf02QJ4grz6c2Z19FL1N/AMglqlw72ktV/5c59grodvw8Yg01jsEAZe5ZU5cmSeEGMWXp5bL7YFTcn1S7v8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the imx8m soc driver as tristate so that it can be built as loadable
module, module names are:
soc-imx8m.ko, imx8m-blk-ctrl.ko and imx8mp-blk-ctrl.ko

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 4b906791d6c7..cdfbefc6b306 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -10,7 +10,7 @@ config IMX_GPCV2_PM_DOMAINS
 	default y if SOC_IMX7D
 
 config SOC_IMX8M
-	bool "i.MX8M SoC family support"
+	tristate "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
 	default ARCH_MXC && ARM64
 	select SOC_BUS
-- 
2.36.0

