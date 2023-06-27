Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0902B73F9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjF0KMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjF0KMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:12:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3196E4;
        Tue, 27 Jun 2023 03:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KktRCOTf+j+V5FCJ/V+qNi1wesVI2JNabp9GhfqF37oMdeG/knusMCqYMEN5uh0/W1klKQ5zp52snzsJg+kkZXosFHm3gK74S9hWRQdaYdOvUPBqHWboWGLDIvZOeiVVYr/+uGNBwI667YDCZvXSInkfQckjYudM2F5t1BFGI4ll64/KhWLDhtaX0D/OezdzfhUEzV7xBnIY23QdEJcJNuOTmI0R61KqQpQDw7OfJgzwX/73PDKMtxFPlbMSLBvCdeq02I6twKEkGTjSz4vnSl47rXj+agQ2Aal8MYG2lSG8RL0R9q1HIW/ZDxmw4Q7MnMy62lp6VVTd3C+ZDGnmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CI88sUpuAB/6rlTeKMdrEWzoYqNN50xy+g+tszUGDc=;
 b=W32h5kqrcbYELh/XUVLEFK4C6GuhTFKvufIabO3wgE4crzUVG5E4OL+xj0kajMxEdtim+X3c9tRxg9wbvMuVVcogpYXbb3TDvBeMsnjLSGRJOvcuvVh9nsKrYye2xfEmu3duIlqq8qx9+cZH1D33d5DKZvObvsXhr8usIV/acO7WN3ua2psUeWNGPLYmcU/1xEYnhFP7MvX0FSMvT1tTFQ8T4NSXrwjZ0vu6MwEv8ptn2nzJNp+7q0VGyVVK6SwHGpM2qAd7HkzNnZFJn+hjAOYA/v22ez9L01erU4cm3j2kPBv0cVIuLzBQyezATBbQanKLs55OYlJ1YrCA2YkJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CI88sUpuAB/6rlTeKMdrEWzoYqNN50xy+g+tszUGDc=;
 b=pY0bU7ILMPYx8cf16z+JXPO3lSzMZlpXlaGZYpql2DB0bnxXsMYJHxLxn6byWEXjzVfED0urPyMPhE7dowWl89Knh+Jy606iz8T6ctswFiyMramZN3CoBFVls2pdiaw+ZvsTQwNJlo8GjxSmCeSM1SslXgVNp93k0fs4Ytt0MI+KeOyl7O7KZ8UcYYpbsL1HdhN5h52Mu/FGkTW0uRnbIihwDaquOTU1juBK/phuC2OQf8fxbxSCT9xBtFmsOGmvVA9fYh0xsCyIJN4eX2nBsmwU3xPJatC+8vXxAoh8BYQvbY7USzSMbEd6klpkl+yQ4SKjEbtW5cV/5UmdPvHhrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:12:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:12:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 02/15] thermal/drivers/armada: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:02 +0800
Message-Id: <20230627101215.58798-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: a20169c8-a11a-43a0-4314-08db76f708ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiLxNeDQUH5JfrMf0rviT567BTUDaoV8f+ZNP/69MT3c3anQSIIENjhcInC+ZiVavsD3l7KRwDK7etcWRwwn8wnEs9AZT3ZdC8hQwQvml0uZuqpUFrQTzDgMbfPlr2Irbz4oT9qR1P8VPmUbB1dW3XuaH55lkFcSGZGLlW5i0e30AIwzmngEF1NJ3+lA26nuvl4LdTu1Q9mQExsNHIB7fNX6Iem5EDrSFef/lAEuczbshZ4FsCGyPYNKv4LWOEXH16ylaj4W4RXhO26RMiOIabhMnMbZKmjAxqbZqE2OJwn1onuBsexOoOb1o8zi9giKHGhs/7VGh4NN1o3waP/y7OUZ31GCNE82jxR2ntsBDdMA6l7ot9C39/NDQ6Ztlf3QE9gxZDAUwG/oJZuv99+q84uuLfAp89Y7FdyFoGWMiK4AT1HWun0bKDrfFt2uh7+ZlPs4iaXXg4CILY6a4SKkSlxRmZYQwwMSLN8D+9XCoevbDYhlfFyYYp0NZ/zfICgkoEBf7NFpyx2UAwu2oaP0wYZBWj19ce80TJdJW1yL2gN2VgLtNggxdoRZxH/3VTjoPTIBJQjM/fXW/rHDvd69t3ogJvxJ+4Jv6om3TMXozQFuJpg1Kt/gra3y6E4jAKcn7kmx6LpHKhQejzHzIJPFNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CyPr52FnQ6RK/1tG+hEcPjUTmmxOatE4hFxf+hKGu5b+2dfbBVYBergTiPsW?=
 =?us-ascii?Q?OpSeCXlsisEUudFey/MgSsExzD3PHD4c1n4eNFCzX4E5Kr6GPrJV1pBOIWJJ?=
 =?us-ascii?Q?AODyuqVdUAcPxPDKVPr/G5D9x6laY9E6Ukb0EKN1cwNBmdOxZG+ZHU0PMML9?=
 =?us-ascii?Q?Eup2b0zyfgyiLuSnBZbnzY2F/8rl3ajoR9w48UuoHBmHX1kTcJL7R3Y8258Y?=
 =?us-ascii?Q?QykqOjsrMXl8MVi24KIowWIekgPp4V4HMl4fHqrrZcMUQbvKkfCuZ9/VbuFk?=
 =?us-ascii?Q?nOXnjZYUIReba+KHiizeKwjk9/l8/x39mFWwQRrQWv8t53L3SWyLQg8wNJp9?=
 =?us-ascii?Q?1DNXpOeakdnuaU8q1kZ/0XmeLHIBYLNkxppsWW5Jyo+EVfCYoZDT7u3/kQUW?=
 =?us-ascii?Q?3OZUM9l+NH52C9lYaSWEpi7VI4CQrJzq7Rr77igSIF3uXzcnRyztNH6fiL3n?=
 =?us-ascii?Q?3BpMQup4kQcH0Z8d5e12LEduqdkGrxK+I+/4nPPFk15TiM/ohciSjxffEenw?=
 =?us-ascii?Q?fTB3TK0Cym26kxwE9HFqwS2DpwzOPAMqYFTm+IaU+eFg9bafHSLvDMXpw2Ux?=
 =?us-ascii?Q?J+wFItmNUbSeBCQZWnFgAEUh/pD25+tXUV0qx47VxX3wkaBpHDVj+IKYLWq7?=
 =?us-ascii?Q?Dt6KeKRSlytF64DYifUgPjhUKqCyIfqhEJgmnEOmKn5MVKiJjfBGCev/0g0l?=
 =?us-ascii?Q?USEuMoEo6KFd2csuENCq6gVFldQy3PVrepZY4l0q3i6kPJDzDJZi0aLBCb+0?=
 =?us-ascii?Q?6enIMZzlZgT3SqzHekhAYyHIosnFO2u8tq1MCgU9KdVUpjITYnIQMK00SgJU?=
 =?us-ascii?Q?35FsUUuoph6ZzZNyYsOVzjXJGOVO4cwVBgcx97FkXkEu7jmVRMpyREuefP+L?=
 =?us-ascii?Q?bgo49gYQ5PXPLCnMSrxo+wQVJ0u2AJGo9WkIkS8ZgCJfqb7Uj+o9NKL6W4oE?=
 =?us-ascii?Q?Hu5vPeGGQ8iCHAbEdAu2nRczZ06TrfYlI4zZ3LguXvSErXi41u8sZPZTqOH5?=
 =?us-ascii?Q?EEu8yqNPtPxy5FxoaIZEd0MRZSfk8nWxFcKKYcX0sx0qCTrDkoy9wK53h6J5?=
 =?us-ascii?Q?UYkDTJYfWEadiieJ6dXteoZm1J3aOEk6CDG2QaBTv++FLYG5+Hklq7IyJZVK?=
 =?us-ascii?Q?IdNOCgKcWmpNqkl6AalcZwzf0KOGz/YZ+CTlhARJNcWXnsm8UUiid5RWRZM7?=
 =?us-ascii?Q?wb3DR2DZp+6n9gYMoxY9np76kjbHHehDeVr92T+j1kKrnvzXcfUvRyncREXw?=
 =?us-ascii?Q?NYxSXA14fXFrCAnwnU/+0HDT7q1rTh+jRmEZxk5Bs2mZk6Rw7gQdY8wqNQgc?=
 =?us-ascii?Q?JAPfhHgyQ8MMTaH9J6Ad3AzS5dhHjhXc/LaDZNllO+/4wb9jA9tIrC0oj5em?=
 =?us-ascii?Q?APgx7m2e70sLx0cpfdG0XKBPfcmi/3jBXvoyDTll7V+3j34uNjMcnk7y9Sc+?=
 =?us-ascii?Q?7nFpq21BBjPafryHHuhq2NJ+U61/w5NfAq4xhRQgwuiGdOz5325rjfN/kG7q?=
 =?us-ascii?Q?Mlk5d1r8gdeHIeCl9N64GNToRrlSMmbHUS+UhQ2XaB/vNdwZZY0wON/WG+lp?=
 =?us-ascii?Q?R4H0JSg6Aj3/s8dYEm3OwpIkO79ZRmpb7DlOpEw8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20169c8-a11a-43a0-4314-08db76f708ba
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:12:38.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Of5NzfHhY/gqhmVD4//JxO2ap2c6FPY0I+n+QSNXXFhtSa1JUJsscV+AUa6SLrr55X0p9UTuJVfbcQityPxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/armada_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9f6dc4fc9112..98b04158f06e 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -917,11 +917,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 						armada_overheat_isr,
 						armada_overheat_isr_thread,
 						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.39.0

