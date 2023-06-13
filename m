Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0C72E19D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjFML1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbjFML0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:26:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91992CD;
        Tue, 13 Jun 2023 04:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2AYLO430BMssNJ3nuaO9cR1jw19zTm4ojgpOODaY2W2+yv1IJadZXeTv3m6VjkK8yJuKKXyharjmCqRR0a7jLEWQ9zvWbYSh1GeEQlj2j0tMTXpoo89dVDOvZp3A36OL9Jx+dXk6h59s0gyq55ILROTpqn9UCdQVa7IXmpM9CThR4q3X+KLcfAmRGeNrDkuOxB68zkUMddF0/0dJ9HMpHyK1M3oNw7g7ECOMeyxUSa0h1LDK9kfYwLlsh2PQP1X6DImQt08FLl6gyd+rsMBlCTagAuNkLZY0e0wZXgGbeb+AL1vTQbhlP1DVZaTax/CmOzT/SBMuawpkUHu03yRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFRIpDy9mxKf73VaQXtUPoyL7qnzSdTF1HT8l2XaQcE=;
 b=nwGsW5uXJMvL6zmTDh1Z9i8qbGTzaQeMCJFv+1pwO5CZGejpE0uWMQ9+WEXJBb3v84wjXHW2SfOnO9kv15IoHE6mhTr2nmBGdadzg3V+q03Y0hQPEh7OjSDtPQS6mUBhhRdKEBY9rU1M/+wSDfDv7T5sDN48AKTWbH9VuRX6ohIDS2vAJ15JOMCI5pp8E74nPiFAM+fSKXHVEbuosneFw/Ny8WXWoTeaHRbRIAimylxqNBac5wHuZL+TnQdJwKz0fRSyYZGlRE/ZS7mas3YVzCPmOLz0Agu3PAC7q6cP31Ykb8/kc+ParcEMZS09AT3ZKidlbluBZGzbgfIHyXQXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFRIpDy9mxKf73VaQXtUPoyL7qnzSdTF1HT8l2XaQcE=;
 b=BPAxh6SeqlKnUcXdcWA7etIuJvIdQ5eHF1dL8Brvz+jDRtRq8PKJEygOMJ4ZKG9bEjn6xJF/vBHQL+920muQpPYWGhW5LKQsE96YgCg4ZtdgnvxF7znvQ0QpJ9LK71QgpNir2GXieFfBhHOMGBsX8MbdbFx1mnN3CTbMKdTcQKE6pmN4b6fIGPChr99YT7tVADoQeUEfadKp+QDOFdenaeM91qvToak7VZQzW/OAsZ/HVu/Jgzco2l/YxvDfg0fTKWF+Zd+YKrlnzVLw6Io+0Ch/iJnOFSxhP4MhuXbZLqcskosmRCOoFSorQwfUxVfwRlwykAsueTuuQNZQIW5ayw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 11:26:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:26:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 07/11] thermal/drivers/qoriq: remove redundant msg in qoriq_tmu_register_tmu_zone()
Date:   Tue, 13 Jun 2023 19:24:40 +0800
Message-Id: <20230613112444.48042-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613112444.48042-1-frank.li@vivo.com>
References: <20230613112444.48042-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 0902a9e0-8d4b-4e58-7fda-08db6c00fa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSby5RPHDvIJfSF2bnivoo5bgZgMUmi++7zGmPpr5R7dE/naXIXdgUxStuMvWlHuXEE1vxGOL4FAaKhgT5hZdZ4HAvseK0+wVxCMJzdudOXJakZrSmURknLZUxCNTqjY6pcOitE99XbyRGZ0ZupAicO2pThFiDxPclc0QxDFMZP3fMH0f3hkgdaXTRgbG3mc9JYb6G32ZrRET8lWi+okyINY74+KhbE5/AZFM1Weqik/cgbUd+vgqXSgXgOTVCiKVCAHSD3f1ou+WDh1W4Y8oFjh5kD1vpfBpDZ1ZxvvjW6CaR5IugnyByt1orOHHth0uycJC9DQb1JLrqjDqMttiDiBI4zIDAeWNWKI7PMW7HXwFo6kPJLrNTUIVGbiEcu8/PVbvv33SgJRbcd9XE7hRQD9yaXu5vwvHPIteqbRUK7fNeob1HuYbjUkJyjzCRTQbr/r0PpnXP4EWnl/EdS9shCwURjwMbh74x67ziwUbmJq1Epbii/tCiHYzQLcBh2nR03U7iu8WysM08DrmCe9CyovFYFrZCJuMJZLKUgxkwKMdDhl8/HM8BfH0QZxR4ufHg3yMDjpauyxItiDMcnWn+ieaXJ4CLnx7Us8vN9v/ekIiHmKhfXafybK9iI6jLapvlGNUE1nuJQy5xJtcMrCkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(66476007)(38100700002)(66556008)(66946007)(921005)(2616005)(6512007)(26005)(6486002)(6506007)(478600001)(52116002)(6666004)(36756003)(107886003)(86362001)(316002)(1076003)(4326008)(38350700002)(186003)(5660300002)(8936002)(2906002)(7416002)(7406005)(4744005)(83380400001)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?32NIDVq8xY/IwIl93dDmKku5xEhEmXytNBzBij7Ys+Ze/Nh4aRo8V1j5vj/a?=
 =?us-ascii?Q?NHeP/VIUqRAJBy0i+6XNZCIq1lLqXwUG0njqPMYC13mKdRc7MuY3eZtBOvKW?=
 =?us-ascii?Q?ZmHdR43NccdkoBs9BkJa1/az5s9dU+1AnT3JOjUTz56n6dDYsH2gl2hm/jDE?=
 =?us-ascii?Q?HrE867HaLMXdTLZSHYeO8GfUBlGLQeyLmyrptj6weWpiLXRRSt+q9lMhEYn4?=
 =?us-ascii?Q?FGwtiwoLU8sOvGBmmtvrJuJAaUa1tkBZZ8moB7F3Q91j3bCXQq4pz5e37HO5?=
 =?us-ascii?Q?Uawqx6B/1+fjOOfQtoHn3rsAYyk7ZC2Jjum62FGAuM2kbOj5EWbrg2kDBjdq?=
 =?us-ascii?Q?e4V9l8WzW3xmBLvzU/jyitOewZITmwdgoySHcx0YHNkkSjVxfXZwKbI0x3xN?=
 =?us-ascii?Q?fiiqLqc8mF3o7kHUcYf1Dy628FDkEz9wGD8zf5CpKNVb7g41w22PVBBQJ5Ph?=
 =?us-ascii?Q?9s05ixVEbW5G2qu5ciWzQFu09gpo7/pGbG/8Dk9C3mB5qxi4a9oeeW9MwJK0?=
 =?us-ascii?Q?owxFv3N0AP/+u4TkMJ5V7IhWJkMgt4Rvl57/WTBQ+L4bGYXmnbyvivFit7nJ?=
 =?us-ascii?Q?FjQAqF18lANuLnNM57r77vjo9cxzUYIrwcztVEySpKZsv0PS1gKnCE7FYAGo?=
 =?us-ascii?Q?1Uzlrl6g3C2gZ46Taba3Gt6jUDqEqQbU2dCTK0wfv2E/E9qTqN98+018jqoz?=
 =?us-ascii?Q?aaUh/wvAsUKYsCl1q523JmLBPFKwmcBzGyyJDN57s0DYzvBVGRgoZNbk3T37?=
 =?us-ascii?Q?X658vu3L5bQ7mrGgT7ycGwf/bHZ/NedgMdPJFuOHX6MbAFAWkADQEdvqan33?=
 =?us-ascii?Q?Zv6tO8PbWiU18F8bFBCWmdS+fuuTjLEgB5opiEpB6FPpf2E5QNtWxqAz9Txp?=
 =?us-ascii?Q?RjogjMz1mbUAl3ekqRH9TDv0UnaT+2GXyavWVMlqnfRm6GGUPxKYsDhUSbvM?=
 =?us-ascii?Q?rr5p7k0kbisY5kCSye4FYu0JeSY3gL+KAoE7PKGkM8pE+UqSUfc40Q31AYYu?=
 =?us-ascii?Q?KpaS1+qCqS5AI1fgrpn+M8ebMsp3GjXT8oTCCu2IVPftoUlw4P9golSTGz+X?=
 =?us-ascii?Q?OVXtytJYKp3NKCqVcDR06KsqDxuPa029dhJLJeHBq4gWs8EAYwRnLpMTtqHV?=
 =?us-ascii?Q?TyiBsJ35FTAWg6OcQl3hDrMjluoMFMPPj2ykek2h4VuNatZACUHAM8cgEE+3?=
 =?us-ascii?Q?c5Ij3PrCCEvwqwru96jTAsMsAR3uyum5BZ8pltX5UbCTWTixNeVU7y1PWVO9?=
 =?us-ascii?Q?6NWkfL0mcrR82OXrsiPylpF+zoOh3PE2TUKlsG+o71SZSdCC4fZvsuiuBryX?=
 =?us-ascii?Q?ac1mXLfJMmiKeAycWntXPUnSFo5hpXIhQs35sVdriMptNisxNjkdNALyB+Bl?=
 =?us-ascii?Q?Y+xrZ7DnpyE0yZdlQe+tWM4RA49fohM8DrIY2isW4Q3TTrnCvUjbB3xHsqHJ?=
 =?us-ascii?Q?cyWKV2oTaqRL8GOIoSmQC21doepvztjfKXZUJz5g4cBE2f2Mxwzx+ClEptBN?=
 =?us-ascii?Q?OwF+YRrpzEFcImJVVksTKtPrk7OzpYD/ayZzOO0gqh1CHTPiacCzQCcwOQhq?=
 =?us-ascii?Q?HTbQNO565byqP+39Tr945ysbfHAneLD4BsqcHAWH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0902a9e0-8d4b-4e58-7fda-08db6c00fa66
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:26:06.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIu0hSftb3RRIhetCi5Wm+nIWkyzVqI1yQxeBohVgQOEV++N/Vvh+NrtBLaqYX1mqo4JuiCoToiIo3GudtYn+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/qoriq_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e58756323457..61b68034a82e 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -157,10 +157,7 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
-			dev_warn(dev,
-				 "Failed to add hwmon sysfs attributes\n");
-
+		devm_thermal_add_hwmon_sysfs(dev, tzd);
 	}
 
 	return 0;
-- 
2.39.0

