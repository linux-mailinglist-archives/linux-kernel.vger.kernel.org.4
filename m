Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375D7736720
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjFTJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFTJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:11:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332810F2;
        Tue, 20 Jun 2023 02:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUAJ6twUGRc8mxXtCf+0Md4NbT9j0yBklLz8ig4cluOmVqfOMf3vkB4pwmAwyHKhxoZZ4fiZoexHvvAaxSQ6QJvWEY0aWw7viL/8TzE33kzKDBj9G5uSL0BTRXjrh+Ota/z5NnYDY914sPQLRHXXbX+M1h0ev8JoeRHsrXDJ8HICqLUqzhnCAjLgyP8MoUx7d/d3yuvOCa1ofxeeDIPcZRYsZdDGNpIH/snMQnIeJyPU8zrJTafzc/NrzYqgM4OCkU+QRmreYc+IMcvUtcDuLUp52oklXPm2wT6v2B5Sbv3cWcO4z1qA+ppM2p2LdLUvphD8ZPOE2vTMz5rdqsg4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkrV/GZews1ITpCp8W2z5cotGqZ1j004kgvtOEkzznk=;
 b=adABhuubF00Dnf6+lVTCLUBjdkPzof5gVr8lI2i1dZO3Ct6l1GDSmb/TgFHsNjrN9PQBEGjgnl3MkpQFMgbKC2iw9PvienCo1krOBRTfOIsAXhK6o5XUK2f6Con5o+6xTlg1YLUEuDH7saMMyfoIS3xJqt1T/Kdufnf08O9WFTqEBmvyuVn/bAdI6X8zRrvCkkUJWVoVXoJgkPMVOXNEhnvilo1Z8cK/CU+HGL5d18ZjUcJuF2ZyVIxW3aV/rycp1pC4skhrDwcwvIRK3fZm4ndvoPweZIhLsJZf9k9lPYwr0pDUeJzurKTz6dWaorNthVTj6oXo9NTLW8cmiRYg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkrV/GZews1ITpCp8W2z5cotGqZ1j004kgvtOEkzznk=;
 b=JzECmzRRaSHT4CKe/YJHtYnaY5qCmrzeomMNQRAVu6aWyBdG3jwtjai9e855UH+9uN5qlU1JA5axRWtuzO1AMxrf1klXi1EhZnTIJOw7NlR4bGpwkDsy1PRWnKeNUqjbv5JmvgHw9m+oGFYhcKfTRt88uquP5RDPr7BbNATgrHngghpv6NObLpuuvgzuWblrWVr7kozVmYt91+Um8C1FAp7sd4ufY/VmKvlFs1zSg6oABEsgL6sDLWJxiITs5xtN3D3+lSbxQFWijUWxe9xVFno1HxibNgmEn9t784eBx4bUPYGHDhLUK8Q9dfb9ovCwvMfmUZadWiiI6exlil34gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:04 +0000
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
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, f.fainelli@gmail.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 02/11] thermal/drivers/sun8i: remove redundant msg in sun8i_ths_register()
Date:   Tue, 20 Jun 2023 17:07:23 +0800
Message-Id: <20230620090732.50025-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230620090732.50025-1-frank.li@vivo.com>
References: <20230620090732.50025-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d6fdfb-dfbb-4582-3490-08db716e461f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFyrgU99xnLwFEfMo3LJHBa7aTu3ZWug1Ol9/vyKrglw8z5EPy8EdHL4I2/PcjvQmAggwK8dcnc2DvTqcb5bwjxQtwbNoGBUQaroy+F30+8ubEM0RkhXzpamssqCLq7oEGyyc456m0ZIY5Vb7Gr7/9hBnMvceYqsukqTZgavsQpkv8CKtLcUpbD7jB8X4yaJr8o39l2AUkhVCIiSzTiSflbZKFM2GTK+FqBO6x0sGNjMyT4EUgIqSyVkA/kai4jPekbN4KFXtL17B0xAqTkcaT7cVDC3DfZyFD0ZbIIqlltXGo1lV/18LzwUjH7DXdoR+FmForlfGUuP/CY5+LEXWkixdFx+VrsQUz8vxdxlO55Cg9D2hyueH0YzW44fNAs+r+PDMweFgdMMcBRtQ1FgHHy6/puAUqq103SYwdDit0KmNBNMX6rpvdYJR8W6WsrnMK+vqeRxFNrbpssRYAwsuB0+JI4cJz542xQ5lDTqPvi4cNETwz5d560wLiXcEqPW7ubSrNm5VFx6+mpoIEdwCDstGf1wBR7yZzPZz7zlPlzFYBGdfy9qwRs40cR5DoLXqSZHJbT+jcVEIhXAkOvS9vBuOSTZHcRseXC0aU46L9hSBDraYjEpooLn5azNdUAZRckfHjT2x9vkyjp05TZahw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(4744005)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVyTiEcQzKWD362o8iouGD9aeC08xXEOJ1g5upk3nxLZZdm9tinPfioQvlb5?=
 =?us-ascii?Q?51s/E1/3C7Z6wxYw/aFaJtspc4siz9N7ZsKRc7ysq+3yyZX9lyCxX6N03fx0?=
 =?us-ascii?Q?27AmMtNhcSOAsmsZZfp1RMAqHNzaPSTbitEL6lzq2PlHZcAXbVcgDn8NdopW?=
 =?us-ascii?Q?lfpURJJUf9s9nm4BytrBkxLTwuKwcSgHGX9LJGnlibUWbUQ+XcoT7EkZXm5P?=
 =?us-ascii?Q?owcOvbbhmcglh/4gTuo0aVJH1doo+nX7QdwOXy9O6np/TkELJxnWaG9tdCtQ?=
 =?us-ascii?Q?3ExHoF9b6kB2StHg+ghNuc4hNq+V+xUB8xnZ+H/jN02PGcNhO1DBDo3EmLIP?=
 =?us-ascii?Q?OtVuWcbka9Y6RSpO5nJqdQt+OWCMJMfhhNcsRe/eFQZ2t/8oMomRExKEGt3f?=
 =?us-ascii?Q?qQJjqS7xJVY8owdzQG8JJm48ZHs4bxKHUFhzEUHq+6dQf+Knmuz2A/K9yf9R?=
 =?us-ascii?Q?ZYxzH3r/ng/ipa/Bnf4aKhWHFmAth4u99lDvIctAQLhxNpKKsT5dJpCTO7nJ?=
 =?us-ascii?Q?R2vF4AbAuKdMiu0ZMNPkxtjHPL4znG9f0n/xZuvolUGVLXBi0HnjNhAcyFPj?=
 =?us-ascii?Q?mRFfWVW0rBXrWOVI7dHUSYIxLS64YOmZhIpBfBcQi1e3pCft1HP16lzOnIKB?=
 =?us-ascii?Q?7gfVXDw3ltaiMFRVV5MHh3kTiL2ULoocF5BDBTKcajbh2n4jTXtBH55Rmqj+?=
 =?us-ascii?Q?FYboY1ZSMVXFAHqbZcYMpZ7bBLkcaEcV5MD6Fkpc2uQrp2h7r5WdB8/bOhvz?=
 =?us-ascii?Q?ExU8KbVLp9Qv2rGPFKfUQPYpqSjqnU6aGA0Fh9jjDM4/0OVhWzTqrDSP1C+m?=
 =?us-ascii?Q?btFMKGnDQBK9bpiQyrb7ryZbQnfzbcqoV1yILDjQfKywFcnxdWtfekAk2b2M?=
 =?us-ascii?Q?4Gezn7lr9OrdyUdyTzlbkO4XwQVV5Xvuk21zXKOuoWgNJ7OIGI4F59MkcEM1?=
 =?us-ascii?Q?ipc7ZgbBW1U1eIZ/P3Lv7RWvb8SP0JhKPAbNqypQF2dsGNJjQLNvkZxIjo6p?=
 =?us-ascii?Q?rGLAymT4c6LW31ZGWJIGIZINJl1wVexbxeuMdxEnvd8BQ4kY2sUnyLGHUFHB?=
 =?us-ascii?Q?GojEa821krbaOEax3VlxIEFRpLsKhNJIRqbdJeMHAlv4hadgueNqph/LLQvO?=
 =?us-ascii?Q?I126q+iOjWzLF+ZfAsSGWNsWM1ib1hdCDhtQcTuDZRERKBIEbLOE/KtkVD80?=
 =?us-ascii?Q?FECav9dVVJ3QMcTMN503jCfQpKiFV3EW5DJCuY5YJmW1N2EPl67GFRj/prg/?=
 =?us-ascii?Q?t0T1jHWLjAm6Dj61zrsK++MfF8DfMmOhO+qLpiWtHgjjqHwKbPpDslz5xkf8?=
 =?us-ascii?Q?YMf5qGacz2VM3OPSZUOGksgJIZC/1AHowMZ6J4LhHYl4FYx7lUJGY/EnLmI7?=
 =?us-ascii?Q?4CQ+YAQW493EWIzoT9eQrdoOhI0Wnk9oswFHLNwvM5YwkUTKxveD1evT3op0?=
 =?us-ascii?Q?eniJW2iFTVc2KjYkqlSCm4Mus4vcO0zNOhELlHSgoLj08BpMfCrpSsXgmcOS?=
 =?us-ascii?Q?HaSAEJnp8gssFLAq1+07637iXVnwfJk90KoX/REKveEUMAJ1CULibeIK8HUt?=
 =?us-ascii?Q?QFzj0G+cnIXyT/3Y6xI+hhmYo84xKsNEk9frvPL3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d6fdfb-dfbb-4582-3490-08db716e461f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:04.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ01vsO6hhSwImm/QjrWZ/32e9jvtadxQjpV2tZqbDduASs9xyuD/blJ7nFE9UJJ0ii37gzxqhDLHbNZQ/7H4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..066f9fed9b86 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -475,9 +475,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-		if (devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd))
-			dev_warn(tmdev->dev,
-				 "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}
 
 	return 0;
-- 
2.39.0

