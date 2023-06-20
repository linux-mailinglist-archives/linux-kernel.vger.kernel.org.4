Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1650D736730
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjFTJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjFTJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:11:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0CE199B;
        Tue, 20 Jun 2023 02:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGE8CGmDZZrHs2WiBQvjg1OJhLPtqTBEbk4wHVuD0UxZNlQVpZGs3mRqU5hMaikvjn5TFJdR9C/lHMORgrD2nJDAHizOH64Dpw2lPUmBHrje3qUgqhfwYcqAbrPToMFVxCUgCuieO4+U2Ev3MhDsmBKwo9Pztxl6sKIclwiulj2OMfL2HY+iJExlAPb1dE5Pu2kGTiutNzJzqpQtXJyTevrmSTMEfZ/x37HSfdS5+3JKx+q8H2aUJfWwa/dIqRsP3Zce7jS1ueW5jpe19m6I40yFOmUNhsmWRs3lvXXGNFw1FNatNkXwPuq24L9+NXyGobmpRhO9VW16gI+BSr7wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=Ck0ImxuPGYPVKBwp6QRtp3vM2aLLsxr0ik0t5sowYfUTPFU4kin+TpctrYrsbgRZ4kxs4pMqSUT/u4u1tmlBjEfXzWCeggRC2J5AXt88a31TqARPFep9WcSJU/SPoHpavV99Zq9+gfy5dqxx3WD0k5U2K8uA/2W/485Yx2+Hl2KmYy53fqlfQrFj61UgWyL5t+tu1vmJpmb2vSut1xTMf2+dM1oum+eiBPcBd5Wt+3x7E7Rwbsd/PEB7ngjdmvGEMSMyHoDQDboR3XP4KBjMUAdQWKLkPUT/VPgVRO1ZlnHdeRuRJotOQiyDTySSNJvoDhgqs9xQJsmkuc95bua8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=PeNKpLZq6BKRGg/sDUQo1Vemi/c9KAdlOQ+8rCB34RMARn6qfT7FyXW69AT9Rb7K30Dac54n75D8o+msumGCrvg+rlEiHb4BGwclu+GcDaZQE3sArAzsb0klOk8Cvw1M2f34TJD0YiBeQVQ0WdMHj90MwDo0KyWT21d/6IjWVapNU1EFsZIb5j/rfgnXaFvDnMsOchIo43j8yjW6PBxlznuJDB6292ihD/1Q+xAzO/xYC2fSB9k0/VrtuD8EUudJWXdjS7WUKiUfzgdiI0ZrRwLgD3gE0CxfsFsatC7wkmuESL+SkI381t1U5z+2wIvov7Ke3mVBvJVtk3CkYVa6Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:21 +0000
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
Subject: [PATCH v4 05/11] drivers/thermal/k3: remove redundant msg in k3_bandgap_probe()
Date:   Tue, 20 Jun 2023 17:07:26 +0800
Message-Id: <20230620090732.50025-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35cc7afd-bc28-44cb-fa8b-08db716e50ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2lcmgRR/58USIJ7MhhRIBXgherUEYqi3cZuaa6yG5df6142IBGjMfmyKZjqPf/Cy6XaRJdIEjuOYcCBemGtpBJovMqPYm6fRZa0XvB0/hPug8Rjl9FfGOv8asvm43SA6CTDdCGwIYQKKONPAI/X0Xvt6ry6nr13JTWYbx1DxtNFAiD0zumqfSaM5gpMUxvaFHmGp6QKrPuWe+eZ1BIcYkmz8DDe2NfqEb6db44xe8utXrXNi87uKAJIdTXPdDKXHb3LbSwELzqfy69xp0f19tiWGR6xXLQHH5fm1Sul/UUGUOj+3wXIuRvmkxihw2JiGCqWRMxR7BX5tbS3NRn8rEJftfNPfrMxlmarZHYifxU8A5lJFFStZscUnDMj96zJzXrwU6J1Ub9jQhs5YMkKTGpUq7AWST0atGTNSKo5aOFGSLkT5dAMVXsv8+zC7WiMloIpsfBEqTTG1SGwz7CHotAcSK0n1FbXS3VxrK2jqhDdTDpQnzA6zyEB/T6d8YmeqBKkhPaPRswDxFi6vJdbxo7lWAHPNYhN+2YRFHBlRC9ZV/qMheS5of9ooF0yKNv9pF7rAjZmTOeOjZma76M1jnzz04DtL0V0ahApcea4b0EZZ77AXYoHAXcvlPKS4lOB+DJdglNSmMdWzNMFXzRx8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(4744005)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfYmWLP7qxKLjtV5WH5b7W+PYO8YMuBoRx0zlYVfatmlaspo32T5mNAsZhad?=
 =?us-ascii?Q?ugHbeVYEShtEFN4R9GmY36TL9UYYATc1uqg4V9ygQ8qEuS9T0Og7oCD5jsfi?=
 =?us-ascii?Q?c/Kj+/ZaJQn6fCSDOe+EWGjvLdmsjpGfCW9xveUeaRYvf3mn/h6y+tgHvR4M?=
 =?us-ascii?Q?0lK3WAudbL0UAqQiZJ3NoeDoaUV3Gd1QapMjVCD731YP8TOh22v3PJxd1JMC?=
 =?us-ascii?Q?Yc2aoTSDOcQ/Ope4JkGsh2F6DSBr7lPWAIle/UGUZQ7CDry05cHGRoDrbTs3?=
 =?us-ascii?Q?HEkqecZ/bbfC9uK3QvBiHTq7ndGY7v33mA76JgI84YmCrExcnv/ruPQyqCwZ?=
 =?us-ascii?Q?4TKGFfs92sXIZZvrQIJRLu0Urc1vrdw+Tdm5VpYcB3WqsneJwwCO21McoHrj?=
 =?us-ascii?Q?xhQpTdwDwVVLe/3pnVGJJuG2cqOro2bMDE4Y7FiCKAs4u0dYC/MQV+N5kB5R?=
 =?us-ascii?Q?1rOg++2LwLQkTIsCY3m1Y+qoawhLF5OK5R802uFmHOM2X+i0659aD3S6aYb5?=
 =?us-ascii?Q?E0DrCEl9pjgwfkLwgRXx8CfpN5pQMg0yb1hMndOlcqnGbtDAIlxcYNZYaIjH?=
 =?us-ascii?Q?3MpWC1ZAnW0Ecpqrxk70ycerxjEzkrunbj9ywU/mDXCKilfZ+NcjH/5leVQn?=
 =?us-ascii?Q?VVkpYKNFDxVZ1kt/Ak562XcxjHwTiFlB/C7jpsY1P436oX634n9ljuOch3vm?=
 =?us-ascii?Q?RZdZgG+hdY+jlPW/umRyTsZeRouuknm+MkEK7TYKk3ejUNA7VW9oLt4GbSr1?=
 =?us-ascii?Q?OwOZBq2fSDHwupjUh/nhGD73aQ5x16k83NxC51PBEV/pKKuYQ90MhHauXJdk?=
 =?us-ascii?Q?qBXRLk1+OfNfZrkFYVWr1du9ad+fpkyO+cnBNlo3jQdPfQD29wCltlymlsXo?=
 =?us-ascii?Q?RC/nV/hvGGDYVEx2A5i2qYN60MZjma63gF8Ts+ibsZljQkNCm4vOuR1SBXMV?=
 =?us-ascii?Q?bsrGqVEA8XEO/ZsWSmDpamhJL7T2hspk6wspwO1XuZdhhreNonl7tWuJIERt?=
 =?us-ascii?Q?LTPCFW4Sv/sawP75PY5Vuqm5Wqcjfj6agRmD8VcSYEDwaSLnOX0dNMpPLV8X?=
 =?us-ascii?Q?2l3Dv3NBqn3QE9dkEOFDheBHtmP0fq6AGldmiR273x3ybxWo3OF3ylH8b/UF?=
 =?us-ascii?Q?dwNH1CgCyQq8xRIuwgOtenNiP6cWIBn+s7OD38fwSJvw0Y7kJm7qMEFXbmuh?=
 =?us-ascii?Q?LaiPDwOmqYp2I/R5lDe2iNULSAI3EwXA7VWgHXCUWkpFh5iA5yT0mzfeDalU?=
 =?us-ascii?Q?8CmjF1/szjpzMPH8epUSY3GabZ5VRql3H2JPvGq4bJmfnP6aB7xqMECwyFBq?=
 =?us-ascii?Q?DFu7xpieikgD6tWk+lalB+TDzBviJsAr6qmvitwWPkFHtFHxvIo39Ys+VS7J?=
 =?us-ascii?Q?1LkNH/cexizdZluug6aJ/hecSvGTlUMDhLRh05Ua88/pOdwD+Tzb/umMMiDj?=
 =?us-ascii?Q?/AgxX6vX8HZMdWNhwCriZmNhWCs3V7Mjt43CGmfUZJTWpIXG7GgRxQ1p3ui9?=
 =?us-ascii?Q?3o1tefrsQzVvv+/IN8wRkdpLPBnyLqmkv0G9U7cheZk+Pxnk/Bn+wTgq2V7z?=
 =?us-ascii?Q?ABiM7uVxJ3gXfUZHMoZoea/ThUqe8g0CdFHT80zo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cc7afd-bc28-44cb-fa8b-08db716e50ab
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:21.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gko8IvedHLilFyz3Yl170/dEXP32Gg1963rnJikdOlH4XOTCDzRoG/DFlNY1NqrHoy3G2BHXz0m2/iXM+GT1vg==
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
---
 drivers/thermal/k3_bandgap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 791210458606..1c3e590157ec 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -222,8 +222,7 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			goto err_alloc;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, data[id].tzd))
-			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(dev, data[id].tzd);
 	}
 
 	platform_set_drvdata(pdev, bgp);
-- 
2.39.0

