Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACFA72E21B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbjFMLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbjFMLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:49:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF410FA;
        Tue, 13 Jun 2023 04:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHMRbu9spN4M+2E/DpGWNuuQLfrbdN0NMSR5bT/a+QGjzki7PlqVgURCcY3H9N3Z1NpplNJwcK1A/phErj69nANAvN1biBorsldb8ft7dLf3PK4/tFrfaFJE7a+MPiKPoRh1d3rluQ1VXi9jucxL8e1JMqMoNBTejGGFbO5PqVM+LHCvOB9C6VnkYJwufF+PfsSGCgn9JD/SNCYZlsE4jqocpqVqqAbC+azXRVk+wZYjZnBoHgB1UI7GsULuY2IHXrr77EcrCJDx2UGmU5DMIUUwi+YTBlLMJ1NQH9gg3aAjq/LQaFd62m2FgkMthN4Wmvu7F840TaZQ63leNK6XTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=dGMnftUHueEvJkWoag3E+Gn3m7wg1lePqjPK8bsrEvHAKthxiCkR7tilVvY5q3qgtIy0wcePUmPOQWyPG/CH3U5SSs0XfB677SOFTR3O7q1h4sruzDv0AW/wUNS9QzFNHWzdipikY69WAtmGS+f26kxaOvxhbzeG9xhA4K3y4VElwdcqwza9cBOEn8ovxITuyXGuRpxyNIvbnfIQ52zJgbqMAt0ADX/QoSJm/yMzIIqeZRs1YIk0C6Xqrw2RlxY8mPli4Uo2IuZoQG5UHftXYeFAmEide5jF3RYWpSzZJrfrI5JaUyuH/+1tCeUk+4VhNUD7cuJ63AXXoZ+itToWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=dEJUo4PFu+DTdb+Fzx4EDBBcyuhsiZyCxEiOzHiTrLEi+CKmfLZhM49XpQUNApBsqFchVwLGLOuDOz9ed01g3PhR19sJEfcg9n5t3I+vS7sRRGngEV4zIf9l0tQCL08wMOKBYsFOkTJt9JlNc7OjuW2BhlKsbvfUmwtIwV9riGmgTjPD4AiBPwOsnZv7vwdt2ft0U4/ETznXf+m1sN/gFPeFTRKSCdWuxOef6eblNaVEMthtD9M3T/EN69twxHopDAI/GM2eo85c1I65BSlxoVR7TnzmCqdsGupGPrWgZG+00UWirhZrsGz01uFdUc/S6IYrzshaz3nH0HYx1wlvVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 05/12] drivers/thermal/k3: remove redundant msg in k3_bandgap_probe()
Date:   Tue, 13 Jun 2023 19:48:57 +0800
Message-Id: <20230613114904.15749-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613114904.15749-1-frank.li@vivo.com>
References: <20230613114904.15749-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 23839056-c2e6-4103-8904-08db6c0446f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AH+OhgLnQLU2BBtNbPPGLFgB0y4VeY/bk+Prd8bQxB8vmv2M5xSRq3r4B0hKuOFiww6ukeoQY6OBh8DncizAHMbmxO3//OU3LBdo+CvB7qZhTg7Gurl00uJ3lOZ+eeVGRd4eCjWy69iyA6WdH1C2f/xLWHqDuHcQWTpvE+V0CD/0QOhgRrz90wigphPQIbJVgVTP+UoNI6iicXkzRM+6I5HjuAFG3hrbh8jdX2TZ1QGDC4+ZLP/jkbgtmK/iSvmZGNJ6Gn0J6oyRV1WJk82q+eobBnGiON20w2z9GZsj9i3vQvXIXrirWqQJlGi+SlduONIk7xFgb/xH7W1kWnPxwujxcWYv7oZJDiBfcqWSotCkLXReeZLo9FGVkzqnFeGEkAbf/RWPP12BRGbO1IJsxo7u8liL5K8RCU/w7uBFQo+wqWc744YPJtOZDT6BtF3tsiHH0GrE9jUs6Ggh+M4I6h0mOgVTvFRiXH5LARbKUX3ju52Ry9SHg2OpWAs5jFxX3jSZFAlb8V9/m9sDihmlcxNOVqaoqxphoqpy6x3neonIh2/VFp0LoE0iRCyIY7TBWQzGOjiJL7Fjn2qYSibby4SRJCVagRZ2SlCmuGfmA8zT+52C+m9B8QOcty5ixYryGk8VED+VHtQYA1ZGUNG9aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(4744005)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2wWXjO967tlvFacFheQU2BDqrozukrtpArUQCGEzyZMHj3nRLnejmQUVdP0?=
 =?us-ascii?Q?QmLStp4q/aoO9+lpFOs6RjYKQ23sWzNyQaj8Zvi22NN1M9/cQcM3RO5eBlB1?=
 =?us-ascii?Q?KVymICt2s+QTjk87ZrZgJ7EupEaVPWW1dGY4+oKCX+koPR7wYo9c+7++Du5G?=
 =?us-ascii?Q?6tgyVKvneznSo5Xoptedv6AsMav5CnMvusV5CYbEuGne9B7wsPXlx/1XB3mu?=
 =?us-ascii?Q?clo7oRApIe10IsnOhE9t3+ujiPq4CkH+6VjgIA0QvCyS/WPbwAI5r+hxT/uF?=
 =?us-ascii?Q?IA5ew4sLguRRDyBrTR/67on6E3fv2Wkyxbc1HTdhi09ksZUfZ1GeiIqpjp60?=
 =?us-ascii?Q?KA0OTdAXUxmA5V3kKe/ouPXe2MeuDBjdVt9u0traf0lDfW8LpWjykKOi4BaV?=
 =?us-ascii?Q?Zx+qCB9Xx5Up40T2FDmXL/rUU079mgIKaLIlVOQ1VruYev/Uczx7f9LHCZBI?=
 =?us-ascii?Q?GbnsPtL3+qcqZo9/dDEPJ3z1XSt7YrYvA5OUghK4HPOX/simUNVbxJvg5/ug?=
 =?us-ascii?Q?qe6IEXIz0yzaYjfJuX0SUp7q+iD/OEI/ODdmI6g3QerMpoyPqbubLCnuZzxZ?=
 =?us-ascii?Q?ovtCT/OQFitUg1rawJ6GeSA85SUtMt/mXwmU8YEw6w6q3bL1w8tYQHbTTjjW?=
 =?us-ascii?Q?oRkjn6GKvkCcMX/1RDMUhubuYdI1M7ZtOEAkGPEJPej5yghNFDxHsyDCb4Ma?=
 =?us-ascii?Q?DqRwqd5HHJlHjPK0TV4VV2CkaX84EQ3KXrgVlnblSOQyV7Krt3gkfelUpEMS?=
 =?us-ascii?Q?17VGo8qjOtLR6ntXqtQTJBuWXq5IeKqb7Qc+D9UTBgqpzGHMUl7F/zqj1irZ?=
 =?us-ascii?Q?uh63bcMc5a73wmkEztwF0DvNx77vZ0+jBsEUkBogAqOItMKhGnRDpZdNg8ER?=
 =?us-ascii?Q?i8R2U1TiBlPPq3D31oOYjbJLY2BCNa8LsN1IQMHDSh00TaHHM1C+w3TEngPc?=
 =?us-ascii?Q?s0iNejBRjl5wF2l0D2+K3s4y8dNj1COLevYglLeF1COdphex9FQevTCnsXAr?=
 =?us-ascii?Q?kjLw9yA6lLoeSwsH4PY9AsdoR/eIiiddlFenbN2R5fILrqHFHHtnbTCaG2I2?=
 =?us-ascii?Q?zyjvHso/A9Rao9Z02Abc9y4QWTRTrAk6sBiR9c+xs8Z4+Z8/BITC6LXxHEwf?=
 =?us-ascii?Q?B8ShQVEiyZtawqG57BDOex1OlJmg8K6PqBaRtNV9CheIE0gjgJwWskHeBCQU?=
 =?us-ascii?Q?0wJd6t/Q6qIg+Cu+5WSBsSS8Jm7wtL6RzMDpF7jkmdP7lAGrRHyj8NKoyQlr?=
 =?us-ascii?Q?VW1spncA+3a5LnfgUqGQvmOHYDb1s1f/HMf9wWQj/ggKSD+W2cvriXOL1XIe?=
 =?us-ascii?Q?fv25+YBE8NEBsZIGvTuX1tb5WQio7LSWeD3Qwze6bJt7uygDOV3Q3YkFpd7u?=
 =?us-ascii?Q?Fdguo1uPg5zTA20VcXqdimmwGMzGrYzlojWSounbGKlGTiueJoIlkRNrfxMi?=
 =?us-ascii?Q?1RwX0JpWdxoxMw7M/yi71niMTNaCvPP1qDKKnhu9/CpZHEfkHshP4YO51eHy?=
 =?us-ascii?Q?0Sjmt93aDuEZKFsCCJEYhmrUwJImcHeTG4f/4jF931S6sTrn5kL44Fl50jcc?=
 =?us-ascii?Q?gOfQnT08EgriKY4d1ZLtKZ73Cs1472CWRC0Bmx2w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23839056-c2e6-4103-8904-08db6c0446f5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:43.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VOECFi8IjLuabUDPtRF+cePHC904ZLI63rdxVOXjZNtEAAh+yuGvxEpVzl3vtM7mah+bSSj3E4Kx4IaoYZuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
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

