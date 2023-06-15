Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D3732399
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjFOX1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFOX1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:27:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0930FF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9NdKAPprrIydaCwVmhTXKDMdCn5lgff2LHDUgcDCSmoNhu9kwZBh58nBZsCyaqkHLbyD5vB0n9FCeTjer1ld+CA5Qpni+uv+IjXdHVpaIdJfue4OY+ui7grqTaFOfg1wiBkrTODkWl/xRDnsEMlt0k3bVVbt/y/ON+liWSAl+3CVY0lupKVFKrUACMg53SUwuIP9GwdrFKcfPlU2grdK8v87MLZ8Bi+iK0Kbj8e0JapxI59RpUpQhKidsuUK6sb+NffRftcDRQ/kzVSDrPhZi28C4HbTLUrUAxbOLVQO+Z6eLY3ipBnQTbMIW3lndJ2CfaVLIuWsXLhYA5IdmCLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMBJvzHpQMPqCss7+kGjGr4cStiyhCZJOs4f7hi7fFQ=;
 b=gqPPP/awjRVW53ga9ey5Tpgk3zMPVmWXzwPNVMuoidi70+gZ9O9qmw5h4A+9TOn4idHXDZZ4uJejCNDH26eDhWPzj2BRyL0BB5bgJ2gmCx+Rd40cd0Y6E9LWRgPVi2uwrzqP+2byvlzhvDpCmGwMc3UYbWXenfZLhPzLZnylKetX8UmzNSGgI1sO3yeVWy4zu1kx2JRXz3T+Qy6xMa1fznCNIwrTjGEGnH2eeAGoHtIvpJaoEjGqKPrlcoGiR6iNT6kjCj+0wNINRDxXfW+vHRBWHIqPruu0bjx4un3gfrxzaRZJ0k9ifDYVRFExFlN0tWYZJoGIRXJxDCIUgml0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMBJvzHpQMPqCss7+kGjGr4cStiyhCZJOs4f7hi7fFQ=;
 b=aUyzdQBsnQXE3vmNp8nh8qbeXNwughIwQGfTtLBJLb9fhWPnWfb/g3y9paCN96X+FqJcGJgAdbzar0jb0l05qscS/WyVrosLoj51JfZa76XEoOpG7N02Eht956/pnrXzKlaXkrKWh+KM/LW0x1BFzMlKAFoittRllbsx3dKs2Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB7338.prod.exchangelabs.com (2603:10b6:303:155::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25; Thu, 15 Jun 2023 23:27:00 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%6]) with mapi id 15.20.6455.037; Thu, 15 Jun 2023
 23:27:00 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_cspmu: Add missing MODULE_DEVICE_TABLE
Date:   Thu, 15 Jun 2023 16:26:30 -0700
Message-Id: <20230615232630.304870-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:52::23) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: d833ebfc-fa01-4c4d-99c2-08db6df80466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7ymBQyeN6AV92YDUEXcZFwP0/pWmEMOzYC3HQIRHxjsgV5Wn2pGW+Qg5fwLmny5HBX0NiMn8o8Ga14DwovRxOPfV5yoeNS77cZAgV4iyi/yRV4ESN3RCQnwBSxTaXGwBpIFXDBfhjjbv40mukGQRAJx6EqTgSZZ9uGg5pkH8x+6XeTJ2ucmJ+mT0UJ9+08eg3nVKowAsyF0Rwnc365ky97iW0I31OAcv34mFJo2hN7FJeYKFkaMRdZM85GjyM8BZIjQh9Tynj6tEEvpbbNsXNhm1oiR1mjBwLrN3fBCWmKktRg/hnXaWDnd782E1144GDMDWLkYnNDRjQX5o3IZoi78iIDS4jq1n050nlzIiDkbg392HQNqTLk9K7kAdeE6JVLc2Qh2EGLYeQGbyJJgrLz2Tw0+7gx5be4ufjl0KZG665uOf+YaqG1s1Yk2BtHu5RhdGzzc72a/Pw58GifY1w99CZ3Z+sadRt+1AVltQuJOkqMog/qX+ItThAq0RPBr6v30sLG4gDsM8SnByEIJ+HSq7MUB0dwjTixIF9oizwKPOvZz0AEVPlRo+0wIS70OToaxcLeEaF5aau4WX9fx4TkzXHQCmz7NOUnJv6MBbSpQJJYaG1d0jBWbMEnLS9SK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(2906002)(26005)(6512007)(186003)(2616005)(66476007)(66556008)(66946007)(4326008)(52116002)(41300700001)(6486002)(8936002)(8676002)(6666004)(316002)(110136005)(38100700002)(38350700002)(478600001)(86362001)(1076003)(6506007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P4l/c7/26pcZgVvwokSgUsUgUjqk6/Yon1fy3Xnds4cS7gilL4aZyQTs6Enw?=
 =?us-ascii?Q?v+LnTb08Ew3pjcYK8EBq5wtJkvvtIUXRRIf9j9YwV64zo7k2nVE3ZjL4FNJ4?=
 =?us-ascii?Q?mAD+reCEL+Rlv4z4Ki4W4Wa0bwuMZ+bqxBe9j5X5kWymGLmwLFcOcRPZqcaw?=
 =?us-ascii?Q?E8pQpIIbYMOGZ/INA58mLlPe7cTGGhSvY1nOG+ZsX0DqgGj4dk1d4zNgd8rA?=
 =?us-ascii?Q?UmDXrc+Liq3zMaFoegADtVeCzQlbbeDYUj3OxhYA2uTootoVvByMXO5TQUMM?=
 =?us-ascii?Q?OGxiuECvaFBjx5N9vxE7SokjEGHdebazWxAf4PH6bdTVLJzXBAtbj+2XEdW4?=
 =?us-ascii?Q?8qKDbJ5stACR8S8HWDBZdI/Tr2mwdXqqKgYGS36OuTxMSKLO0tWKNlJRp7wm?=
 =?us-ascii?Q?7Sud7f7yyqTt2UvX0BSNYetV0wF7igmiU1x/G8qV3HobLw50YLbw2KE6VpPk?=
 =?us-ascii?Q?2Gqu7YhpdrKhiixTm4Ovd2uxOcbpYGrq6CtdZF3WAUa1V+pcB342O8AI+raO?=
 =?us-ascii?Q?PHnUFNLgkfQTyga5frf2cDUpziw/PTWJZbxQY44wJyr6GKLkCZulCEq+Q/8f?=
 =?us-ascii?Q?SNhqWdtir8mCfVfQNuBGMmhmzfo0OCmWmhYibTjzRSJQRHIfWxfpLjwqz8lW?=
 =?us-ascii?Q?Tbxg3eSGQzcSHkzlP1Rh/9jnIWexW2ux5IzOBrwIwMzq0tTRffLprJnz2og9?=
 =?us-ascii?Q?khJj1thJHec4lLJ4P9X66tG1NsX/yioxRJRI1ni7EI431sSaea/bf2FuNeru?=
 =?us-ascii?Q?EjgAnnGiQa57lNQRKSj1BDdVkeR1HfDBIV9zvsW+jif2EaaNttwXleJzf9Ns?=
 =?us-ascii?Q?usMWb735r+nWVFF7y8oNNYvccqS18YfoPY+FmugjcvFEoqP+IdbD8ssWo6eC?=
 =?us-ascii?Q?sLF224TVFtM7EfRVyTQYdqzj7HVTuXjxc+m0aJKlDO2aZbjYQegT4Bpy+Mio?=
 =?us-ascii?Q?uqLzatQ2afgYCafsmt8Bpl3DjRC7C0pqReFiZscYAKSNOinAwtjSakhnuhdw?=
 =?us-ascii?Q?XIiy8J1TKACjjE4uosvtGYADkapCdMj4pUWpcStqmzHk4/mzcZ958Dsx8Pu/?=
 =?us-ascii?Q?b15aLX5kjL+wflmk45fBk/nfOJskhC3U0MMmf2188MrujJnQIDFm3YcuRdQE?=
 =?us-ascii?Q?qk9nmWeKG7xQ85Li/bykVlZtVgE8oW3ORe7AJJnRGt1HvLbSKTZ8zfzu3WSI?=
 =?us-ascii?Q?3639PFkyeSgzPNpejByVKm2SGZ9LCoNhFoJ7rW18nEUdc1CJXES9YjzJbpCp?=
 =?us-ascii?Q?agFvOBlz1w3A/qITIjmrTG9dobOSKAyFFZ5zPZEQUVjSPbJgGyCZcBlMtuNC?=
 =?us-ascii?Q?UZkld0Xw5RBwT9daIxsdQ6psd1MZStdZP8mlTgiFjGSUhe4PzAh78lsCyYiK?=
 =?us-ascii?Q?c5G7s54qtrXwuuX/m/Zn+DfbEwySJfp6wXlGTivRQ9yruJ9lSt/pO1LKAL2d?=
 =?us-ascii?Q?ahn4kbzv4WpLJdifzCzGgKU4+NfjFV8g+YOmoVq3Y6NjHXrQeHPyAbSFfRqy?=
 =?us-ascii?Q?TlMh2IDx971T+KpWJW66LtytMAswDIJ0EXM3381b12VaAi0UNYw9lZ4/0r66?=
 =?us-ascii?Q?C/gbi935ER5pWpnf7gwVYtRTPOQsJ1taCcIavrp3sHdc0kYNtw9y+oVTzcse?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d833ebfc-fa01-4c4d-99c2-08db6df80466
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 23:26:59.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsmcdwGdEdsEO63NBgjTYpgN4DN5CHRH2/gk8w0QQ1pnOaJh0JA5EuFe/xiVS7/1b5zYuSLZWz1q0UrX2s/Rr1uWllgFWRvFQWLoryHhNQWn1IO/E1BXyDgMeu9CtHH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7338
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_DEVICE_TABLE definition to generate modalias, which
enables module autoloading.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 44a9f7e25fb2..e2b7827c4563 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1213,6 +1213,12 @@ static int arm_cspmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id arm_cspmu_id[] = {
+	{DRVNAME, 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, arm_cspmu_id);
+
 static struct platform_driver arm_cspmu_driver = {
 	.driver = {
 			.name = DRVNAME,
@@ -1220,6 +1226,7 @@ static struct platform_driver arm_cspmu_driver = {
 		},
 	.probe = arm_cspmu_device_probe,
 	.remove = arm_cspmu_device_remove,
+	.id_table = arm_cspmu_id,
 };
 
 static void arm_cspmu_set_active_cpu(int cpu, struct arm_cspmu *cspmu)
-- 
2.40.1

