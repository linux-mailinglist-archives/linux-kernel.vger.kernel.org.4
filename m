Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22CB5F4A40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJDUYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJDUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:24:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775DFF4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4fhL4MHeQGNuuZzihO+dxOhPMmfTEsz6UJyPrtcwEmwo3eZ3xPcSP6CgHXAdoXgltTR4a0eNk6d6ztjrYkhJsA59Tml5tKRNctPP28ei03BJgFd5Hs4YSOhujbarPDA1IimCK/4j+iX3F5jwClwoI/sOU7QEImF0s9nARSews5LcyLQlWfaK7xHulIMK2Eg9DrxGF62e+NHIs/NNvhaE2A2gBSv7QqxdmeIpwllAka3WniTSCtT1cCzt+nvmAD1kTW8EPc88aLgFnaJ5WPLJXri7cumC2D5tJnTu/HI93Hfyljnviq0wiZ+O5ud+9sFbQaEuPN+KSU7VrHNIRJKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=johKxtI52Uo+8kwSV1p34zBR9TZW69y2HCUFQz3ydSc=;
 b=GGwYRPJ6YT0b4eSkfwjtnhAB59ZiZLY81WTG7GwVd2/gu6v91rySZUcBFZ3DnC02rV23QnquEPyKl9vg0QC+8Oe8qPiju9ebCTL+9LzcjIzHjaKJZFPzGNuMnonyzLG72pmwjUs2gPDaGuae+5fcC+M+fzmFZ845tZfHFxFEURcn86f36jWF3uchSRBTaBKmGJ20BKKC52jRJV04zJTwhAYxJq/evGCvorqrNSkFhzrVrYTt9OAtX9kWbCxsOiOruF5HvMYCe0HbwSH11qzwISTbZpWN0rtlnLP2lzCZGBWWel+cfAgTxpxVUxON6nepRVn6Fetq475/Vr0UWk4SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=johKxtI52Uo+8kwSV1p34zBR9TZW69y2HCUFQz3ydSc=;
 b=Yd+KIQ0G1a/KA9rJtH+o6k0tFCIspyixAUIT7ibHCn33E6vJJAkXqXBrimQt+ZaJ0U/GU6rKKD9gYDxO3Aq1aoISahE2zwYZ8AjR+rz2wkqn5M1fGChhSTeXZX4dvob44fNV27dpV4VVagKOjCzBt1IoAoGH0+qKl+Lx11VlK/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 20:24:36 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 20:24:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 1/1] irqchip: irq-imx-mu-msi: fixed wrong register offset for 8ulp
Date:   Tue,  4 Oct 2022 15:24:14 -0500
Message-Id: <20221004202414.216577-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a5bc90-205b-475c-2483-08daa6467495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXCuHQEjpgGATyFOCD0wOMYcWVzRgBcWGRkUZoIIDqaTcVr1aYylLTTUOZOsot6fj8f05rIQPjlaObeaCO5sEs4GZia+U+kcuMrWnhaliYB5mKVtvQECLGwUSODyMldjKgOOFxb8e3kMVqHXuSKL33k2hioZTV4FHUx8E4v6sLiMjtYRdLkWS3nKAHnYr49RxbVThFRRCmZr7cH3VdKir4tpt87Jnv8p/K4qD6RxJUV4NKyplLlVsdNxSYQBhAZu4PD5pYYU2LS8isKheCe/I6q/QT76IC2k5GWUc9jXBey72Ax1SvO6IO+qn4n3hqMvQEu6AqO8Yt/Fp2Rk1/eR0CVpqAn99VmYHHcbeweQlOlknSCVRfGSzRz3XVwQGs8lmmwE+v81gYy5VpFoH5A7rFnX90MnnNwSmUjZCHokCglwPS0wIkfW/x1TJQaGRvbc2x5HcwYvY2JPcgCocwo0vb5RgkuACvr/t3Wvjj59whz7OCZVapi5YaqFk2BHqBGIqpUYbxmakEkk1Z3Kh0TAocawN5RLEaJrnbJgpGHiMoIHfZ8WVsNg0TolMnP7Dpj8WlLUFMjeaNNdXqJFBvgKLbfDn/BXsKkNG5CvCjBboSwM2EgNfY3fT11C5BGelC/5gGqYHCQYI7TFo6ZLCLzl0ktLAON624uWmLCp1HeChu+svjVBeT75rJpicLP7VJssLhUo6xmgWI2PSDkrJCFAVNn76kWFteBK5zflSfI47hcA9SWkJGs0seOU67PKhRuvjf6AVyBd/HvlhithXSALDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(38350700002)(6666004)(1076003)(186003)(921005)(26005)(6506007)(2616005)(6512007)(38100700002)(52116002)(4744005)(478600001)(6486002)(316002)(66946007)(66556008)(110136005)(41300700001)(86362001)(8676002)(8936002)(5660300002)(66476007)(2906002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TG5yBdHV0R9RmWnw/0zjaoTE+BlsAJW3tMuSxieVDTn01c1XqgUH/F0MFfkC?=
 =?us-ascii?Q?alSH4+3L+/RluUtb3IaFlf96gBLf888mH1TOoJqR/jgeQQJvYFXQ9VdNErnj?=
 =?us-ascii?Q?MXkB4cjN/8zsw9ruBC/C50MFLWMukpLlqbYOoZPXRbVM107mPT0AdTg0D24M?=
 =?us-ascii?Q?7z3oJsk8UVNvG4ysMDwck2JmavNRfZcPscCa9jpGNwRbED18Blb/wZld2ZvC?=
 =?us-ascii?Q?zIeo1r3dLlA7Zi6nuM4oKI95FSkKchxQrmOLaykEId6vXA2zNF9pZBIBoong?=
 =?us-ascii?Q?Ul57IDYHbScAYQZ3lZzJE6JZ+vtm6A4yIwr8Gvpkm2WrM+0NNVqSQIDRlv3w?=
 =?us-ascii?Q?eJmgISwI3JCsrKelrBEbfP7KHOYHErWmzpMqTUCClXOMemxt+tsmkgzfi8XU?=
 =?us-ascii?Q?Tw0okJ8DfIiGvf5QzRTNasTmhg9lElX0k/MlaZm4sx6nVsbvzuc7qaD6jrVb?=
 =?us-ascii?Q?p6naanEffKge8znwjtcH3ymKHDEdi45Xm+WnrvH7J/fESb09kI/862ADVdYJ?=
 =?us-ascii?Q?XOHMwaY+ohSMSh4Bl9QcAqf2fn5NoFDMLnga/Huub2o0b7I0gQWZ2UOxe9wS?=
 =?us-ascii?Q?krslQ8wNzrPSzercFJ8dSko7bYtLb2wUgcGI3uMmuSSBxFpzbSgtvStAYvbR?=
 =?us-ascii?Q?5aQeDP4ywIi9Z0oNv7wV+21jEahfH79rnIoO0YCVJaouJirwj11rAFPFIyjN?=
 =?us-ascii?Q?HB2iwqoUrRWVKSPkHsN9eaBmvQL9Zwq2RZAeN/DRNYX3vapwHCQUfworXkLr?=
 =?us-ascii?Q?SJ/8x8sNxGk9cxLw0KriGDrnGpunofpc3Ty2MOPPZWGHMlFwTnOc8u0Okr/z?=
 =?us-ascii?Q?eoygG9IflJPF2z3BgRAN9tR2cjh8aRHsu8ejaEzxp37XLOdT1dSpxlBPq8a1?=
 =?us-ascii?Q?WT2OwI/TOt2z56g54yB209ifLL1xbuYpyqJrdT7Ox/BNwCNYwsD5n3QLzEH4?=
 =?us-ascii?Q?YphEUc5C8Syh8/awbEs1iTkek1rYxH/UL1Xila7oCYNwcWOD5/TVIkfUBwtB?=
 =?us-ascii?Q?0ByZ7wFSY4vnEjSxEWTdGWye2xeATBk7+SDOdsLe6raly5zCrpG39HZlijWn?=
 =?us-ascii?Q?0eyhc5H3FoIOJLV/BBru0Ao7kxmbAkVb8W0hNiSkLZAR7p/0WNssnoAmw/js?=
 =?us-ascii?Q?x68cWLq4MIcPQ9x5F9Ijcamc6vCmspnz8mxGDqVQwrWCueQ/JZLm2ODipGFx?=
 =?us-ascii?Q?QLfPZMgzJH5K/Ea+RWqIOtVcKTi8LSh3RV+GkrUhQnoM3f/4C24VQ4SlvdZ6?=
 =?us-ascii?Q?6scPnWdQfg1wsa2h9CWP6ATZi5IgSbj7SE2ZdKjK2V+8NmiS/ED9zcitQ08H?=
 =?us-ascii?Q?Ty9dqhmITBv0rixmGkasAogHiRpN6vNlGu7sn7MSit1+oVCpxH63RXeuiayq?=
 =?us-ascii?Q?oStpWA3GellWLz/k8ufImyR1SagFDmLUXNfgKeUWKV3PW+IM1QAQPPk7el+R?=
 =?us-ascii?Q?6dvlu45erZJl9a2pqjwXHrOu0umvPm7FPQQzRFifOBQMqCTXbECwqOltX9DM?=
 =?us-ascii?Q?w4iMA7ehwkZN/qA0hg+Gyum265/3TtW+OhXVsZBB6P4mykg2yMrsRkvgerDD?=
 =?us-ascii?Q?9jOK9W46xYX6482zTr8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a5bc90-205b-475c-2483-08daa6467495
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 20:24:36.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l767I1vAmSTO++fAINuOgQNdQjRLhCjGaiwPtNsv4Z6ykpmlMnFr8MP+8uI/lQYBhRtM0s3+PwefTvf1+vqQOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offset 0x124 should be IMX_MU_TSR, not IMX_MU_GSR

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/irqchip/irq-imx-mu-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index b62139dc36e82..229039eda1b1f 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -292,7 +292,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.xSR    = {
 			[IMX_MU_SR]  = 0xC,
 			[IMX_MU_GSR] = 0x118,
-			[IMX_MU_GSR] = 0x124,
+			[IMX_MU_TSR] = 0x124,
 			[IMX_MU_RSR] = 0x12C,
 		  },
 	.xCR    = {
-- 
2.35.1

