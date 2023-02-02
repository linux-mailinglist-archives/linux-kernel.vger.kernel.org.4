Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7E6877A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBBIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjBBIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:35:56 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2093.outbound.protection.outlook.com [40.107.6.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70E87156;
        Thu,  2 Feb 2023 00:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ8clwbd2la2aF7Yy+33JVAjBqjE6DpLKWKECaT3kX0lGT1sbfKSipc1jLvdM/XsonGSEpDyO2s2ULgFXZX6vbS0cDCkN6JYblE7vzozIqcfTolxyDiTqKfTefBRuL6VfrnMpAjsE7piWSSASxPdHd+BEUgjaNzPY0QAFFJJv+Gx678/poDlYNnbrrXzIiJ0PVKpcRNvHl5EXD9gakBv1oCmFpe0fZ8Lj48rCEEeanphSfWgAgvV5SgLh4cz+uHCIoKlhomkK49VyZ1DL8OkYTvePG8okPRGhQyclgyBtlWR2mrKVcjODs0X0i1qSyTpSyYXqgfw+q97NeYpXoQv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a2Jf65klGv6Fg6Hkaesf+ZITHdAy5qqiLA+j6y3dGQ=;
 b=FPjtSzmMOFKIct7l5/Z1eyvKVysLnSJK7UX6Y8hcFVhT/MH0SVNZUQt0FvghSE1xEeuRY21XFpjTOIWS+SMylitFFmBbjUnjcgkXdVHmEslmPm/JLB1MdyAZY2I48HpMgb07VPYgPBkRRQ8hKCOayOH3mkc14oY8sznVpL9NpoouK7lY82fTgJg5j0uKmm/6akOTQJWEyYx/8ar4gtQz3eP2NIs9gf/YuAmA/ivv9R+38I9cbO00eDFtLaqjet/KFziXxOFuezNFB/WhmUFn8Anb2y19EAb3O9urOQlwgfsdCq+/n30sGus73R/yhb3RScgWjLdm+teM63SJP3EFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a2Jf65klGv6Fg6Hkaesf+ZITHdAy5qqiLA+j6y3dGQ=;
 b=dgn7xJ/hy6eFEhJPY/M+IHK9pfptbM72hlzjqMKOkZJHS2mUjH1+O2e8brw7sYsgpty45J6cQB5S9joYmckBFoNhh/RLIiaFsHa0/KJ1tVPbb091KvTf5PXC7oJ3bGJZtC8y44qHbThxJFYjh11bMABVrTZPTW4YjFaZntUzBIJBuu7ZE1rxsmJshtCciHdatiKRDZfhWtYy6Z/z/dtex0ZpiPZyRPbT5sBNFj/NgyHIE08CElk1FvBDoWxwOOB8ljxWQf8zxOrnM/InP8uF8CnuX1r7ZJ7a8OM1iiUmtkMR8/YfAUIQ/EgfwN0UL9tbOudo//7wwKlYjFZK7VhqDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com (2603:10a6:102:bc::11)
 by GV1PR03MB8309.eurprd03.prod.outlook.com (2603:10a6:150:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 08:35:39 +0000
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::be04:b005:c96f:feeb]) by PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::be04:b005:c96f:feeb%7]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 08:35:39 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Markus Burri <markus.burri@mt.com>
Subject: [PATCH v2] ARM: dts: imx6qdl-colibri: Refactor ASoC driver name
Date:   Thu,  2 Feb 2023 09:32:26 +0100
Message-Id: <20230202083226.3143748-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201120900.840725-1-markus.burri@mt.com>
References: <20230201120900.840725-1-markus.burri@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To PA4PR03MB7488.eurprd03.prod.outlook.com
 (2603:10a6:102:bc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB7488:EE_|GV1PR03MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 4570d0f4-56b8-4159-710f-08db04f876ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuwPF/Avn0RJiAYZ8uRk2ichLL5PXvJFn8cezMGQmKw0km/eVCqYpJvreICbDIgJP24+r2f5+KEke6+iu+B0ODsICkWz/FsZZhY+dCqdJl6iPU+0zI0nBHSMvx8xpr3UBO91NEpdNXLz6MGD8WSfRKjP2OueaK3qymYaP5qKhwlz2JbXM3LWrgwGZ5Gk1mdtp++G7izI/yov4kknozWKa45yK4A3GE1SNsAV/yXC5MCKM0l6fJ9sFMC7rrveO8biVLGIH/lpLH2bjjTDiiCqhmN+7d7vzT8D9hxk4AjVF4CmTihNTRKIXUXxGJEqHpIZTSbNkDLn0b8LlNISxQEneOpBkyPQebUXhR/VzASfkBUlB3++odF4OAksC2alxBat7NlQKS6RSmMiwSi+QGHgBByr07UF+wOphQoSiSPJyMYzQYB0f/CO57q0X/OJ2G+0hwsbj9C9xEXo+Ky7T1G4hJXzQ7FsFIGD5kW/X33pXEnoxoT2YzVZ+Zmtn2tvMPzXypExZTD6cb+8YxEzovsAjgLmGOpxD4TbvyrIr9d29JagsDQTKQEJGl7Cph19Wi7c7Gwu5hUoFUonpxM4UmbG3+bPrH/M1yHTfFvieeWGYggVihzllquuVDeUxVWJWUHiUUssFwTs0lI/fIXa4LuXX52SeCNTf3XY8QaSzJSo+U+N+BcVfVf9wbbAJ4LsDHwsT6AhLiNBGAFgzVNYo5BI1JLc+6mg85vOkW1HR1/ehoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7488.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199018)(36756003)(478600001)(66946007)(38100700002)(38350700002)(4326008)(83380400001)(8676002)(66556008)(66476007)(6916009)(54906003)(316002)(6506007)(6666004)(26005)(186003)(6512007)(4744005)(44832011)(7416002)(6486002)(5660300002)(1076003)(41300700001)(2616005)(52116002)(8936002)(86362001)(2906002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7wjbRb60cMp1N5JbnSEk1mQiR1vSMxJX1z9KF+YIbxsF4jJAnIyNwsBWK42F?=
 =?us-ascii?Q?oMpKOB1lYO5kEzjZABzk0XMLSZnJQqVyqVrF29HPEsvpen5YPFbVoV05FtX4?=
 =?us-ascii?Q?2OoIGP6GGpsPJNaw3A3SFjxG/+uyjFp+3mw6lWVcNz8D27r+bSLXZWSq7p8r?=
 =?us-ascii?Q?pSh0ZkRZJTJPq9fObSX012XJSLWoS3nZ7b4m2mCM4l9CZBk7Td5wTbT1Eclh?=
 =?us-ascii?Q?Lwbgv+wNxLcxaGs+gTnViE63dvkr0FsGZ3r2mC/yyem8tj7ZTIR8gt1kiyJb?=
 =?us-ascii?Q?nsZ0M723T2yU9GgTwMkBsW7e0FShMiYIlwyCxtg8ku8EmhcWnj/LT8YGS/xT?=
 =?us-ascii?Q?wKenryViYYfLJuNbxljnxgak0DGmJxBMX7tqi0wGNbHP+XF3awgIsI6FHjgV?=
 =?us-ascii?Q?HUsIIQ/GE5VmGBeAeRG9onJ7G0MP+mXP7V9ijdUh05bFCgYai17MenyihKB9?=
 =?us-ascii?Q?TK/HG8mjUdstfFTTDNw+1tr/WGLtgTIuV6dUTu2GIxiBdRXn93sVXd1jeafm?=
 =?us-ascii?Q?5wYEAuKPfUXqvOxJ9JWklTTciLxZZ4T6FACQRCLdjzgX38RnglDphwIUcdaV?=
 =?us-ascii?Q?Qv+gWO2+A6FEYjqNL/ZfDRtldCj3TEWsnIoIC9YwZu8t1sN6U0QV0T8+3V6J?=
 =?us-ascii?Q?cZFXLPt3/MCG2+GclZ8dz5ZhiBElhd0zNl6/LtDOFH9hfUZHE3s6qxEmrNRg?=
 =?us-ascii?Q?Exdj2cwhvD8s653TqFvt2E3G9Gw1vJf5YbsMNPw7MmL1MYG+zl2KODx1zVlr?=
 =?us-ascii?Q?OmnUzPLmpqNO5c+gOEDr4UkCQlCmOUsFh3vRgYI9jr6OvtHXRAaQUVBYYStj?=
 =?us-ascii?Q?RlhUPBOHU6ZS9sQr8LrWAemLfZ/nHw7Gjq0seQtkwK9n2OhEfT78NOeOr7ux?=
 =?us-ascii?Q?wSwLE/GdCGToHfZPt28Z/WnaL6G3NAZMFrY9rgZttxxAadKes2XEABlfUoja?=
 =?us-ascii?Q?0U1v10Bi7YbP8tNA7FecmEtt/wUbeSZOxbVJ5e5UQJ0bEo5IMBoVI0AmeiZL?=
 =?us-ascii?Q?CDftaqp5eNv578hBPby/Fv3YuO7A12r0UxSxOc/QBxxEcoWczxCGCsGZdLO7?=
 =?us-ascii?Q?zPnC806a/95FgX8rrE1fgPBdkReoMZ2Gz9NQXG/uOFU4S6kEWNjYrmkc9TUP?=
 =?us-ascii?Q?aS8JRmJBaoxYCKn7lEZQKL7+sWQc8M6+6IceiWvtp2KVJgmJAouh4D5MD191?=
 =?us-ascii?Q?waAVRA5XlW/Gd50+zbpMzGRZBp0dOvQiROH23GWa+gWtovufCdK8ROAXzHMf?=
 =?us-ascii?Q?MmhBYMG3IiOmpbEvWh3wqW39sZzvNLaRsFaSjdcURwtJ90lBWpnhILDA/YCa?=
 =?us-ascii?Q?+KS2O7VZgvR9KmGguQe6gwXc2fQvH0+Mz2xoOOBZWQ/LmDXxC+h1uK2AJpst?=
 =?us-ascii?Q?drpc/U/LF4pof20c16ShPu/51gg5uOxfGL+DDYUphLvyDTRjuQIEeI4Rf9uM?=
 =?us-ascii?Q?i0Qmcy4QK9JE0osg08iTNsiXWhVWHpDMKcpXWVOgF6IloCGQolNfBqDNWA+A?=
 =?us-ascii?Q?q+UKOBNZS1U9mAsm/smAgkgsMxc4XfS+oDef/0q7qdG1xF6fYc1dCd+x+v9q?=
 =?us-ascii?Q?OSeTNUZjSHVA/hPLjWAdUBjuPN+S+TUaulS8xLRG?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4570d0f4-56b8-4159-710f-08db04f876ea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7488.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 08:35:39.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwuNVEmBKDrBfPvUouIEtCJZPfJAyRlgY+COZMPRVHjAE7PsGP4JceopLy3msoTmvn/MsFS05k12nJh/oTsacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manuel Traut <manuel.traut@mt.com>

ASoC driver names have a 15 character size limit:
[   21.917463] imx-sgtl5000 sound: ASoC: driver name too long 'imx6dl-colibri-sgtl5000' -> 'imx6dl-colibri-'

Use a name that fits.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d8f985f297e4..f50030cf208a 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -129,7 +129,7 @@ sound {
 			"LINE_IN", "Line In Jack",
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias";
-		model = "imx6dl-colibri-sgtl5000";
+		model = "imx-sgtl5000";
 		mux-int-port = <1>;
 		mux-ext-port = <5>;
 		ssi-controller = <&ssi1>;
-- 
2.25.1

