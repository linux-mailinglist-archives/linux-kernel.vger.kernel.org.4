Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8023366D9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjAQJYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjAQJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:23:45 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACECB252AC;
        Tue, 17 Jan 2023 01:20:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlYarJ7Kb1kSfMQ8ZhfhtASUVvbwHyCA03gb4ucWZK6+iyETJADOa8geCyOv/OEgtKa4uvub9SlrgMCS2+DprJKvB7GrNqCLq0jE2ZxoR8gn9CAFKuotegw2gQUIjnKejg7rapdqGbrMQORpvPhV1dvXjk0IKhLvZYYcVuJ4Bdq0YBu+owUKhNCBhvoFaw2ADIBv9sMCZiaTZJvE0Zj4HH/K2uEIHQIwjNjtPmsE44S9avgo/OCeOkv21brEf6Yxk396ePfPuHFe8Rs6i5iP3V2ykaht1NjXYjql6hXkcj0r/sTD5FQFBpILIJdNf4JmFjI4iS0kGF1YFbfGVhePjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjT5Ym02m0BNo8cGHsuRvsam9lqjVJ732nJnBR+Juyc=;
 b=G4CO0kNWqfWBbPVCrxHXt1rMorQ06pb1QJfkPywsJkgHtBOMa36aWwxVQTj7L9vXmfCXH2d6PyXhNep2yBhDPCO/ltMrVQ9fVWA6QzAErwqCtubxYRwNtSyvMyuDRMXqJO3sQE3Gl1EME9xRwximPtXkg31xAiqcu+8DZNoATlMTe7QpbfQyP3lQ16hpAr0ddjz+uHueFAkWcOknW9fY38y3O7M3MmkwU7QPVEFC+pHZDmrvePem+HZs80/dmn3R6vm/lp+7M7cgXP7qruJGMk+o/QZXruV0AZARkE596afY7nbazG/eXvm1RPDnI73UhyP0arKT6Vxas1Zq51mdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjT5Ym02m0BNo8cGHsuRvsam9lqjVJ732nJnBR+Juyc=;
 b=SqXk6Haj+zQ2TzYN3EDD8aPEk1zv0dlIRoZpsuj7ecDuaspyyboBSdiG4edaun2jgDLP6uTjfpC8WeI7cbYXQhkvG5nC5uBJA+ekGap5FELlYpvqleaQ5mY8vSER1mg7ivmp9gXhoY1vyTWxoJYq2UacxS+cMlXHkFSJTwYjdLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 09:20:24 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 09:20:24 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal/drivers/imx_sc_thermal: add iMX8QM sensors
Date:   Tue, 17 Jan 2023 11:19:56 +0200
Message-Id: <20230117091956.61729-2-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117091956.61729-1-viorel.suman@oss.nxp.com>
References: <20230117091956.61729-1-viorel.suman@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:803:14::35) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 82565ea8-5919-4ab9-5e68-08daf86c1043
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUtKbmfd3W6etPDyi4c9XkXOErBMKzElqIgJECrWfWoRy4NCYwegfrFGsXWW4NsZ0dfl0eMzf3KvxYMHiy4p+tygXXQw4uo2PZQzPxLSXtWb7hvtZEhumQK7Mn4fBZ0qtb+K+TPhQRvnvONdksMbxa6AJTDRMdp7haNFEF8/ir49TVh9kYSKg8xBVi4jnMk2o32kbj+tGkI+ojzp3ta1THZaHornXPgteAlPydKZGo7tz6WPhC0WBAqfTotiYO7UH6p5a0CK0rgGjmhrlSmdTdxE4RcIxmDchtTw/QEvEtMowFt7bNCCaCCuWLxKgqJARHnMYAe9fHFz57JFAhsumqgml1o/dZd4HftR546jsyQz8YPb0NaA54Eu/eWuXqZzOO3OTf6vzP75ex4GLDrad3cnTvhozJ8Y+iW0F4o5qzMazWL+wo5LjDxvXXe/I6zTjFZg4CZVuNLy8w9aMicXoRPkECYBLAXgd+gTKKw+SlY0MRgtwmpEcs9KZp7ntzIx9uoFbrcG4QBPWDQRFPcy8mMfL6N6lU7IXMRu5YN7HeTahmEDxeQt5MTojvTGEZDw5/FUKIh7EoS+Qlhl27M3aJorCPMI0Cby4TSF7kWNJTnnySAfpvTEeDodbumpPXt2sNLXaJtA3b34P90VnSWLicIF7YsmGdEET3ndoCGrdXA/WVrCQUA0aX2ZX42GdrU/v2Fuou5jfT3Wmxtdg8I3Cs3bXxxAFcfFl1JfvAKEZ1W1AOsFA+1lQulUJ+UCkY4d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(38100700002)(7416002)(86362001)(921005)(8936002)(8676002)(66556008)(66946007)(66476007)(2906002)(5660300002)(83380400001)(38350700002)(478600001)(6486002)(52116002)(110136005)(6666004)(316002)(41300700001)(6512007)(1076003)(2616005)(26005)(186003)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3Pa2/iAN2XZRY9WTG/NdWCOna1hs5FOyRSPkGJXqvlH7fJXlwkd5ZBRvvi+?=
 =?us-ascii?Q?mdVKWzalZ6Hd9MzN7Qs/41ek84BSb1d1NzCGk5N71Voo+xJ9iRXmtg6IPuvg?=
 =?us-ascii?Q?/jZ+ki+Id5SxgaRkBR+ZnHU9vv/14NdGcYdwS9lozU1YavPLm0TBfL5KXryS?=
 =?us-ascii?Q?ruPRSj0Eg7Ogl2H/4J/QQ9kAGiJtqUZFpPUyFDDl9WVzYH8zPMa9aUfAL5vO?=
 =?us-ascii?Q?tNgkl32t8pTpSlFQf+qpSOMy+bGpG6+9+8TfrdcGVEfsZKmRbuW6afi1ovP8?=
 =?us-ascii?Q?KVtkeceMn/wn1LEEiflJw7MyCMxup4Sbr44KpJQODTRIMtSawZTCCGTyBw22?=
 =?us-ascii?Q?cocuv/T29VNgOtsTzbYnmgwxXJrTJ1rr8LdkLxpkfpteSvpRO6mo7E7TmYko?=
 =?us-ascii?Q?aKMgJcWscReIHNjW3Y+oHsPcyHMi3m8eAedWWf8v8XLYFmrf64gTU/EaUnHL?=
 =?us-ascii?Q?rQGp6CXqcXWyWcS3TAKbFLutuklifRs6/siirFT0OqElO5JWMQd03jU8vzVj?=
 =?us-ascii?Q?pGh5fLh/mUjHJqnJ5Dp9+PJKrDGWfj9vn8hlzOPzRVmNTwHHJjgJdJRNrIe5?=
 =?us-ascii?Q?SAKg6gpWKSUCZsw0GcM/4vITAnV8yLRxmIFU5qg/FkgWHOQUKWrfXv4zdWmW?=
 =?us-ascii?Q?vNj7lbKDGfpeQvaMrU+39T5V8cx/LXFjJxMsjD6uRabS6DJOeJwzD2Rrd/Np?=
 =?us-ascii?Q?bNPrNzo8DdvokmNEM9edntZonMr/FQNoShzmMga/ELPHPbQs9fB+hWCST5VD?=
 =?us-ascii?Q?SOSY8pcJQ1PzH807Y/xruL3mK9sEu6Wycu4pkLNQuR8wy07ga0cuVTf0edco?=
 =?us-ascii?Q?YJu3dK2LTM/dZAGbJwPwBCF2NEJ6/KGQmZYHxhq6vJr+Kf3cRFnITvAzvEre?=
 =?us-ascii?Q?RJo1AmI5E+NAJw1Yt/CaRmDjkeMaTbJjCNYhj7ZrLi0jMIOSH9z2fYpmJBDB?=
 =?us-ascii?Q?uzfMUUciVqBc+4DMf+Z7IxSAy7AomWAATEgoQAsbBQgolmLdjgUM5erN4QsC?=
 =?us-ascii?Q?KFdFFQXUJq+l5qBZ1eSjqfookPuqr5mVz9OdIS6CXCvnRMC3O6ofuS8yyeP/?=
 =?us-ascii?Q?XL3kUL3eksg4/rs+LwSJRJ6Zx2zI6F+FvEfY+8RwONrSN3m0++JW1S8Ufnw/?=
 =?us-ascii?Q?wtDAriFiB0CsquPKtj0//MKiYP9Fs8dTASMNnkTfHsTh/DgjUke9zBt8S+4+?=
 =?us-ascii?Q?dWxVUTBFeMA57WnIa5PZkYm5VdW2z7RBxVDZfOS+XdMkBDOWzlt+mEK9jMat?=
 =?us-ascii?Q?Q9wyipgeebxujbiIeC0eBd6Cf2BJX8VMAXMOZa7eQLleG4YjsyxDDtT9kg/x?=
 =?us-ascii?Q?vgmnNIcj728uBzogjAz6eHvLfZ/jupYaMaMWfwEmG7iSPpFtDCn+HxRhp+85?=
 =?us-ascii?Q?Pl0ssjQPkRWob5chNdgL+nqyxjE8K83NwW3n4EgJ5SU1F84PKav9v+UlBkzb?=
 =?us-ascii?Q?axOpxni/sYhYCpVAKfBVlLAaG1XJlHfUz/e0EaX+KVobR1YS31I+quYFQVLF?=
 =?us-ascii?Q?9+tbSH3HQBu6BNnA2H4fRcicnVIp4V4van+gOPbbyFi5IkCm5YpNyj7e/ARx?=
 =?us-ascii?Q?LJ6pNRT9ieoEH3tQyhQ5Q5LYGsudt4ffAef3WaXKfa9owfdxmf47/FEMRnnc?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82565ea8-5919-4ab9-5e68-08daf86c1043
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 09:20:24.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIDPp8nGMw9X+jCzNa//WUdeueojQMttyDYKwQ8huWVCetU4qUWDgjSVyMostpegdN6+NAbO3tB19XJpeDCjVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Add iMX8QM sensors. As stated in 31fd4b9db13b ("thermal/drivers/imx_sc:
Rely on the platform data to get the resource id"):

    The thermal OF code returns -ENODEV if the thermal zone registration
    with a specific id fails because the description is not available in
    the DT for such a sensor id. In this case we continue with the other
    ids without bailing out with an error.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/thermal/imx_sc_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index dfadb03580ae..378f574607f7 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -127,7 +127,11 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
+static const int imx_sc_sensors[] = {
+	IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0,
+	IMX_SC_R_AP_0, IMX_SC_R_AP_1,
+	IMX_SC_R_GPU_0_PID0, IMX_SC_R_GPU_1_PID0,
+	IMX_SC_R_DRC_0, -1 };
 
 static const struct of_device_id imx_sc_thermal_table[] = {
 	{ .compatible = "fsl,imx-sc-thermal", .data =  imx_sc_sensors },
-- 
2.38.1

