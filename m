Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEE72DE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbjFMJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjFMJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:58:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C11BF3;
        Tue, 13 Jun 2023 02:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E694vZwLb9ZCcdTB5FEhq1igtNrvu0wZYc35D1oPEMB+Psg+02qVvwhYcO2GWHaH6zsZ8qm/wvaqyrFA8Q9ptvyFso3WFAIqBGbMM84jQdL/ZnZxo3aGOmC+3H3FSMx7z4rL2pGuKLA3H7ToDUhadZAK6xAX5qyVnp9b5kABbyJJ5HC4Dki9wnSIBYBXq3h4xoWwooMwyA7LBGt8MqptqQreSps7/ltuujwD73wAOngaex4/v93ztjwUZSk53mNvzPaohP2AQODlP2zeFrHmRyDcatMRc0usVDPRC06nYK8hlpdGCGQEWUOXouxghC+qcagDfRs8tIarzuTx3cWCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rD8kg+92/T4iqfi8bXxqd9k54ysUymkpnPOGQgUuiY=;
 b=UzaOUbNIYpLnI/CrGrH09f+W+KEGiF/wXvV0skfX27j/RX1rYJTk1BDekYi1BqONOTG1V0kMdC2Xwm3YIsC6O8hYXyHxPWtZIQAacBF+CRf6prrlGg2iWmuyjAlXfWjF13UNNgVTmm8466JSS6RXE1I59aCgtS0+PD+cjiLSE5TBXHJ9xWJl4/zX8ttQ3QYx7R9umFWSB0H+RCEA14+DLUhTmKkoUjYuQIDtgJJGwaQ4dlIZXC0zzR1SzkGx0q+nqVNy2cRrbjxtT1kq5c3c3miQgFtzm+OoFsrh3+PUXnCZCt97PQKAHQ+7Ivh0LunKfpJiyTe3z6GE9AQoXXm5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rD8kg+92/T4iqfi8bXxqd9k54ysUymkpnPOGQgUuiY=;
 b=nUk60FHS8Jd3w7Os4Fy7usIlo1uA4RHcUSrrffXyp23NfFm3pHAtfuU8V9vLwCVrMZhNxHKt4TLV5/f2a8f96qNYBDdN98IRlEegfV/NCNOLsrL6HdovksAW4E0usxW552Ncc5ZWQVLAw863bxoOScu/67NI2gucx7LEUD5rd4ZpuvYi3QQXzoTMI8YWwHach4808xq/pZUgvfrw4MPJe+I02D60fu2uUq8apP/+L/2R9v5Afneou/BZBThMssd0T5ChO4U6BqA6rDcl3KCkezfvIFXTF30LJokdRCA28ekLUYtwRSbur0/t9ZKFbP6NUWH4O3nWFY9siAPufAVzmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 09:57:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:57:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [RESEND 8/9] thermal/drivers/ti-soc: remove redundant msg in ti_thermal_expose_sensor()
Date:   Tue, 13 Jun 2023 17:56:23 +0800
Message-Id: <20230613095624.78789-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613095624.78789-1-frank.li@vivo.com>
References: <20230613095624.78789-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f4db90-d6f3-4863-0bf1-08db6bf49766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL4HtP2FO3dZKAQzurKTEcq/YKD10GiyfrgfcsBfErHEHzApElliHk/67L8Qr+VgrVShFHPZejof0HyzoTUe8VA5mpqVjUwEUckTQhgfeACKdLwFi6BDFyBldRY5L5Shd5AJRfYXDYK6ITfv4o83sZ1+jLibDCF7m7FhXES4MKKrTBlioVNsadp/AXxneR5A16xwqAhxApStrxcUOt95jFYxUaDs8COXlCeVZEZymsOCf1iggN0rDa1fuahki2LUyTUhjhxo+xtD8vETMTMh2bQuDxyc3aMK+PNyg4ujlQXBT6hwUBUqbOqKzLW6u+FTk35wJZ7fuExqNk8W3nwanm0tfr48YKPbwYJ/aDU5Qz8NWaY7ED9vrqPhQMaQrS3E8HL/PSGR5RwxisHoWXaAtSsgR81pZ8mcFt0XHiNEGO0/7aV/ZzxqXRMjfZ22ddiJpGmnKEfvAQKPkQk+kMAdavEY+XDIUJmlRQFwHTr1i5MzBteNZ/oAqx+atu79nnU3lYaak1bzoIV5k+nHllt6F8+ZUiQBAPyzQ4J30SHsGcWhDN6VGaUxb7berD8Ou/DWDT/DewRU0KkTzxwYKbAHZ6lYNUGUu2KQRHBX/3aFznrCDIXVs315wNS42tmvIcofevX+7YprUlACApPRc9aNeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(396003)(346002)(366004)(451199021)(6666004)(478600001)(52116002)(6486002)(6506007)(107886003)(6512007)(26005)(1076003)(36756003)(83380400001)(186003)(38100700002)(38350700002)(86362001)(2616005)(921005)(4326008)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(7416002)(7406005)(5660300002)(4744005)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cMzkVWyFHPGX/nGipmkcheHbSzfBSeSbbHnC5GuiATon+zpje/epsxXfTzbc?=
 =?us-ascii?Q?2GZM840Q38fYaiWlfff0ZxRgtwgBK3l/LcOvAK75cHM5lHHsNfyp3JvUQq6F?=
 =?us-ascii?Q?0fciviF0Y/VJGST33xUaR6IlKGqu/Mrq98u4n1Kyq73xA2fbY2BAIRwOTnk4?=
 =?us-ascii?Q?r7gjywrzts2X3KsDc9qSdZnMVZMjvjX5DA9LECO3vOaD1heqgpyO+BKc/Wll?=
 =?us-ascii?Q?/dbCbsECxAbuGCPpx4MyY/BR/kicDPok/+hYP/szkI7e7es2TxOWX+nHVLOU?=
 =?us-ascii?Q?J+hf2Sbxq871KC/emgXdLnNOXfKVCLrJ/0jG6hiVoKT8wR4VZfADOrNxKt9c?=
 =?us-ascii?Q?myeBithY/URYvLdaCFHjhSzaitaqzfijLcyy6atvUDLBG5TdHgU3qvmQwBAy?=
 =?us-ascii?Q?I+5c21ORnGraEuvo2nSbeLodJjFDCCFMciJ+OepE9vqn0+wLKzTVLPuJeSYH?=
 =?us-ascii?Q?Gxg1m6MXCtSLGALn9hZUD9c9ehsWCsbaOplfF8NmExXp25vkQQpMODzyLtgX?=
 =?us-ascii?Q?HLb+h+HFXVUj2Rh1JcYbuCeT9+wXRTDktm22ZVmRqNGSyfvEnp4datYqjKlr?=
 =?us-ascii?Q?QYKGhIC0kiPvPkLljQ+9bR7TGrvWgv1kTvEpvXJfFu2aktCN2ndB4+1G87OT?=
 =?us-ascii?Q?xurJdjLLVzeD03nix3V/27ESANCn7fKaZs8VKGmeHiJFElIUjJTTnjZt2RML?=
 =?us-ascii?Q?BKvwYgkon66LIAVOLiuccIufnCG+0VLah/Wdep1hojwWYSlK9AbWPWEqU0Ay?=
 =?us-ascii?Q?JTNdWhKVqZ9vIeEbIIe06SsbRuxuXg3l9VVsZTElqIsxs0Nsmd5d69xTDFQW?=
 =?us-ascii?Q?Vp6QVO6JskBnNhIjC0rlK9wvm7xUJptitO5Q+IJP/S+6gqctif2qezQH+DcZ?=
 =?us-ascii?Q?USpGMxDrF8EBeRYbYgRfC+lf76f1fdQXthx9xOiQF5pUzKwbbKdB12XNY9w4?=
 =?us-ascii?Q?y8aL5Rul2hKcA9k71fO7vPmCUAmjRfEdTG/6AEPH9L4yXFcSM6YDCnRKn5hj?=
 =?us-ascii?Q?MrnTOqauOQ0DRZRTGQbdPHuRK9hLqR0zOpfL7CInSC9oAmRbFVCrjtFaVxBJ?=
 =?us-ascii?Q?UIyUSmfWkgTzjD6w7HUS/vyfF8arvSoSzdx5AVz2Mj7tYndMRTk2K4w1mEGz?=
 =?us-ascii?Q?OD790JyykrlCtvNdvKDnPeMnPAMQqBK9Iq1LiCAacPmc2zqMYcxtUFSy0z1i?=
 =?us-ascii?Q?5WQb7FtCzVSBMi/OwW6uJVJhunfUQq3OQAObDmKnEX7F2Dg6MwYIX8+3k7dn?=
 =?us-ascii?Q?MAitBhMUfLArrBKSOCmy6QV/6QIJbRg4lxDaD0Oi2eB477l8C2IvEKu4+2BC?=
 =?us-ascii?Q?jrmyKbpCNPUA5PIdxeZdpIWgWFxjFU/E1pGO4kKpSzKaGp2jXpejToCwsPOe?=
 =?us-ascii?Q?6jvO240XBVg87E/KnCn6/z5HPDCyOFgBMw6iQS97z/ozZVyMdZbqQrYPKMjF?=
 =?us-ascii?Q?/232qfR0CMZM70pwOmCxZi0l/v0VfItBr0qh5A+np6okj0AuzLr18FGxNBgX?=
 =?us-ascii?Q?M8uwvSJNHot/dAKS91EP31LyYgufmbC/MhaBvlHPiuZNr4N1rK5QwBajPrx1?=
 =?us-ascii?Q?W9MqIwiV8auFW4hqa84j2kotdWSYXhK6KoEflm2q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f4db90-d6f3-4863-0bf1-08db6bf49766
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:57:26.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPkPz7ak3gSNF+X2258dv2DOL2lIvTYxabPdmP5RJGVt8bSXWeJYFYsTfZZ05/J04xhnHN8Kkb32/WrqVRVj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 6a5335931f4d..d414a4b7a94a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -182,8 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					 TI_BANDGAP_UPDATE_INTERVAL_MS);
 
-	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
-		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal);
 
 	return 0;
 }
-- 
2.39.0

