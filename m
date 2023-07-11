Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293C974EF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGKMpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGKMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:45:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156310A;
        Tue, 11 Jul 2023 05:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR7yal/H/tyik2c7L1SlB7SPFPUw1AeZNO5NR9OoUnuRj5cArK9TozQ8OzfUV/sryeaWmhbcdLlsklh562a2ycw4mfPfy2JPJ4JydEepNrXryHNOi6C4wSkjCMrBLkT9vYKVac7dmKiBlaEXplC9SQdCupyxOwYjn8NR/HRy4hAa7kediygb4nqWgxNLhrCEB4Xi/zCn/HkQweBRk/c0wr8JS1pVblCSUHXGGm77i7OQm5tbvDKZumg0Cy/FAtrxDG9PtEFYJAgVTR57XyEguyTuWi+B4A377a7JwUByiJyyTj4zMGl0pu+BCADtOUGMMcaLTZxyRsv+1ym4diTmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG+zOn3YiN4uVlCNl8VaAKlaD/ghnlwmfM+LLbXpkzc=;
 b=EP7Osvv7hBr6Wsd5ubB+Le+nPa1BUBbP7XRT1OsLRnfimqApsAp9/f5EDnYpAMtZPLDb5VJCxSQwrhEi2ACZz7Gh2IHUwMq93TZAF7lrj4oNjhPyZ8hkKVzE0uLePwf9d/yYSbZyqZZfTjoBJKsb5W8zZtlvvT2I0O2d+0NByOssyQSdO+uANqGMTKX4q03QQEO4alq5fPzGuIbEDkzVvcOclH4X0hDWRhBSmZy+/cclkJbTboEvlwiWR9RWkDYQciarb3WbkIa3XI9uGdKifETncWH3dnW8kBHQGSRNy5EqDv899RQu5DVN10r1byAXUInQV89xFWoSz/jWnYEARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG+zOn3YiN4uVlCNl8VaAKlaD/ghnlwmfM+LLbXpkzc=;
 b=WJBdUqvJe4/WiTeGZ28iI+++sQy+WqWOmpmATyToKyLUFVkYR0hRM0EkKSwi/s0kCbYOZasKJaNFZjYr4WTX0Y+23VAtKXERf6NN6m5+KmCkCKv8FIADo42B3GVuTE6H4liEItCFhEuf+lUJ3hgd6/TTrOESzdihkmnyOoY83D8hJZlUiE+SPYrjcvClnPtS5Bg3McnQ1/BySg1zNXJpnuihXqP56mTGO/s9jNDrVPFgc72GPysWjkbaTcGsN21SxFsykYdHL4RNObvDYb7OwYECuC0NcxYQN2+hZ6suCSy/u75Q119CdqU+APyKZQEwmyBi+PTmjC0QEMXfAeM5Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4314.apcprd06.prod.outlook.com (2603:1096:4:158::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 12:45:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:45:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal/drivers/amlogic: Remove redundant msg in amlogic_thermal_probe()
Date:   Tue, 11 Jul 2023 20:45:12 +0800
Message-Id: <20230711124513.47771-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711124513.47771-1-frank.li@vivo.com>
References: <20230711124513.47771-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: faa72e04-c658-43c7-23d8-08db820cb406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzZqJ31kacHZad/t7ssrc6ooeIWHJ2LZ7Vl/y064VwDLJ50Xb0vKtxUkAZBaGsfJZFyI9oYo0ZuHX0Tp8al2MVCOKzqUoWKYdQEkKPE2QkCs2IdTd1Zjjpd6q8GdtkHUpbEqQLHemgfkbSrfBnmS738xwKOzmlRXT96/7A+FWm/9PjknXQP56tQCAMkhrIEzWKoXDtQdmmum56GoCI+7dc5J3RAtG521ohAEY53QCw3ddiS0vXcFaHCun38JwYmyCa7Ng9liL1pogDCZxAybQKD5kXV55wzC+YvcDWWz3TGbcjWcLT3P8h3oi2IZff8weTVvFrui5XuzFttxQJUPgqVqearlwsQmEqck2/a95qL0wI/adTCrtXqhDvo/Ns3ctAKZXIvwRCUoBwPKh6sNcQIkPRZdL6i2yEQlQm3HTrtRKTe+wKNqPH2GKy+CO+fyUe0uE0izyze6mZXCnInxK0st9c6cvbUaOi/Mz7ku1pWaH6Kr5DPPG4glKQu7r6fmuhYbVqVh31H7E0WNyULLFLzyjbtTOytzVP+2l1/y2eAHwdOX9oobgkjI40P/gTfar/Ge0PdBnlEzsVN4F9mkBL7k1kNMG7Mio3i/ITraz19g2f4S4CCgM29xSEK2WqmP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(38350700002)(86362001)(38100700002)(36756003)(6666004)(6486002)(52116002)(110136005)(6506007)(26005)(186003)(6512007)(1076003)(2616005)(5660300002)(66556008)(2906002)(316002)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(478600001)(4744005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vCZtVDOIwMivv9ZzJ5N8EsE8gWmBvLrps8yimg96MJqeVr1yTQwME/4/pw1r?=
 =?us-ascii?Q?Uhysqtp3ddCCCyIrprzSG7DpO8pySlcpvpLIOci2UICP8c5N8gv3TvJeiNa4?=
 =?us-ascii?Q?/C4Ur2fjmxT9nuAKmuj5WRJWIfEjTWnUPvCTnu+tw1gg3UeB85b78ynsMFfG?=
 =?us-ascii?Q?CV6qG6SsbWgV7Mdtn6INoD0rLC32Hlhf4UijcHgc613N3Cpuaw7SjXE3A0Jt?=
 =?us-ascii?Q?3e9NtNIUbOhsIKzSFnBhLwjkIwSm919Zjhj5FAx7OxUqUD5Q0roypAqIsI5b?=
 =?us-ascii?Q?Pv1MoALzgc0jLsQuO5z1Od5PagriW/fzGlD7GUMFhuY2bCMV7X55SWN9+QC9?=
 =?us-ascii?Q?7kkn9h/aJzSIYEZwZfxwCyYYBj7os440ODlyiuzMXL5lIh3Dbzj4TMS+e+pg?=
 =?us-ascii?Q?bXhnW1uUlFg20kUxfpcCyf3TJ2AmwyTL9rE2egJoisznAk5myo+7d8+Nxy4d?=
 =?us-ascii?Q?yP4/X+WmuAvbPEL6wtLl/UEYJUeFFhmM7VozSdNG1LVRDOzE5mnPNqkf5Rov?=
 =?us-ascii?Q?M8KM86oTT4OgdnQKvA0dSlF6JqnU0zPY5GSyQS9k0X3Bf+s136umV+dR2xHd?=
 =?us-ascii?Q?AwAUvna901um9/AetdBAlpgUj0E1cSRcCKmGTcbt45W41/lvAfKe0/45rzqY?=
 =?us-ascii?Q?oVDdbQgzBTS3BYpBBnGbSpXIwUzZzu+piJcjzgK7kNzPiKgQ5RRUWe17jzE2?=
 =?us-ascii?Q?PkiX2vC3kittuiu4oSRxkPYT0QeNeX5WqBSHmiLoyZW4Ch39KasE+kYsIYCI?=
 =?us-ascii?Q?h5SCvCD1tiBkPI5E7K4WoszjwO02RMBmBMJplXM3ganUgRqA/MuEyS44cqyD?=
 =?us-ascii?Q?BtY9bXFjyDY4cxoAxyTpHRQx3rdOPW0g8LoQUZtGMbc/gEkXwh7wvoPLtPhw?=
 =?us-ascii?Q?gnU1Ezv+BnDIs8ao5Usm+E2y3GlMHBPBa3kIEG8F3N75S2dF3LkaHs8DpA7Y?=
 =?us-ascii?Q?ROu9bNpVb4InH/Esm9ux5MNGOuq9gJ6zG1nvdNCNx3f7uYplJeFNJZ4ebpvx?=
 =?us-ascii?Q?FWWHVuhOJS96J3SYa/oPd1+e14HXeSja+wY7mYRU4Pn3h7VQ1n/OK/1IPvOD?=
 =?us-ascii?Q?eYc512osLDsgbGpIp8W0GyBBpqHf4cE4Hj+owOqZUgepcgYdSixBQTPvac0N?=
 =?us-ascii?Q?C6ly1etwbGl0Bb8gnIY0l3zk1ZU7tske0qR9zKgBKZGsjyQzvFKbOwgLBBS1?=
 =?us-ascii?Q?gki/0u6gVIZpXk5/utg1SR/8TMhli+T+NKXLI3j8ol/pchXzPCdxdwH+y2cq?=
 =?us-ascii?Q?7r66XmMTEn3lFG39+5ZSSQ0hbzC4q1zS/JVZE2syloP1f52ivQOmp5ZAbAap?=
 =?us-ascii?Q?tRdT++TrymGIOKVjlTJTv2/ugTB97kXJGauDMLGHDkUZa3kb169Sk7I2j/m2?=
 =?us-ascii?Q?kvD74C7gMjTNPF5Fr2VdcZgyZGwwx3VlRGMKm1b0JBZGH07jC30VeytCYhBW?=
 =?us-ascii?Q?Oh/sm2/PHeX1N0iaSD2xZaHHSuneeXVZ+w0kcbupTZbWjRxCWaO6vjIWXERr?=
 =?us-ascii?Q?b8ftIC0BxMTq7CAoOaICPzaMYgXzQcgdrfWW8y2DZKNkc78yarZsZNIWy29S?=
 =?us-ascii?Q?zpSflKef6tCiqKVf02qVEl4QOlx7ntER4UZ5rFuZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa72e04-c658-43c7-23d8-08db820cb406
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:45:27.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCU2jiP4SYWdQWEiPDjXwBWVMQWIGGC4jYIyMvLxqbhjE/2+GLM67MeSRKZC2P1zMtPMvbHxZ4NNbGqNApaRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_of_zone_register() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/amlogic_thermal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 756b218880a7..134f5a8d1019 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -276,11 +276,8 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 						   0,
 						   pdata,
 						   &amlogic_thermal_ops);
-	if (IS_ERR(pdata->tzd)) {
-		ret = PTR_ERR(pdata->tzd);
-		dev_err(dev, "Failed to register tsensor: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(pdata->tzd))
+		return PTR_ERR(pdata->tzd);
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
-- 
2.39.0

