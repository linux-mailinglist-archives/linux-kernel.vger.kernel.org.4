Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6473FA01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjF0KRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjF0KQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:16:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1FBE4C;
        Tue, 27 Jun 2023 03:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0CxXaiJF7On6Nn3KJbg6mM15W6L9gRplwWTX+c/grT8u9IY+mYP3rpqOCQnqnkumR93QLmYOQIpLdJk+RYpQnhhe/7iG8ZtjqRmTzHB+QIDivJefpO9QQJ69gqS39EVG9AJZHBHdt0pG4invjE5w7IXr2NwZ4Fk0VX9dTfrhfgytJtkeZCUHO94lrVX35hYDHEUF3xcm65v/NK6Eu8gZm8WF/0vsrTPN049IW7jkLEDiQpH02WC9vpPAuHiIOx1rS0tucoNsLSOSZ/WXbOT841g53RqCwX+HfX6reQl0sYDZN4RzANdx5jprdx7eiHJ1CjEGdLqbD6l4GH2lzTnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7tSH2tT/Jraih9mu6/sDXeCrQeKUun4r//7X+ozZRA=;
 b=SV/I5kXAjFkVjPKQFJ+o+QBAPwKYlLFVHKdAhuv7Ydwh2GtDp0mHHB02U/55Ym9xOqCZ+HARRXa8CYCVgLU78mJHhbA9qJOJ8rtz7a1xJu7YRYJia9Vi6htaTTMax0Ea+73bGdcH3R7k6u2sQYMbeGzuLVidEwGXIYnj3y4vDf9KHZs+PBVz9ujULLrVgI6KwL64o043kFf45Tc1ioKasNbQ00XwsccWtaj3shfExygOP4wZjvAtchk2sZu0YcalfhGCS49wsxn8bT13y767PDkJxjAIBoQu2soDy15zlwC3APINjCkPXU8vgYQoRUe0+pkbmT+z4krXQ271sGONyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7tSH2tT/Jraih9mu6/sDXeCrQeKUun4r//7X+ozZRA=;
 b=E4mcp7ro6VjQZ6PldP1rQFNmOF3OWF8MUYC0bEkshPuSvLs3VteTNthdW5YGU6NxeYAFQ3Nio2AW2E3UvOWFW0W0ty2JZBa+aLE3k6SAmdTJ4Muw+emp/z/P0lH4H8Vw3O30kaTWf5wnpGZHPtuaOd4FmFBIlN6GKm4aSi0+gnfJURDnmFPGGNsmXIeQsAt5Q2rJPYCIiDnDLECoshV6z6xwosjiFiB71IXuGbLst82euzgl+U33DrbvcB4tNnTEGLqh5spfnh0vIl6RHoAFx+tAcG0JWF3PPWk9a66ygN0xmntdkvAkX08T3GAJ1qVzr1MlA8bESI0YDq8A9f2A4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:14:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:14:00 +0000
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
Subject: [PATCH v2 15/15] thermal/drivers/mediatek/lvts_thermal: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:15 +0800
Message-Id: <20230627101215.58798-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81094a23-312f-44f9-4edd-08db76f73a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NISsRo869Vi/naKNba7EDu0CZiNjJ8uIxdhK7RSA772mSYCNNEismlNYDbAn2/jNOTaCRiCad+j12hSfHgtXpYWS2KXLociAnAeasb63NeMPfEue1t0Izwl1pMP6/T67GUk0rnbx8QZfSk78UQYyJ4adLusLnPHVJuIoCzIM+gZ17mu853QJ5vfGqP6Y9AgrxMYXznd2cFN5v4yB/A8CDwx7MraoHlGt6unbGuZq9v8ADWMQ6gzd46neI1praqqmc7JOgkqhuviBJpPecLf10t7XydLwMOes+AjshGyjWZQv+sKuGJByg/K4wMKJ9y6OZnJBwv1mBAl/hbVNfmjPWRu40c2B6TpgWGnLKOOfHZ8dPgfWZLR+rIbaiCTVhoUytxCWEuczUp8BgUTQqx4+NQ9lJ6FeOrKCDYNloRcom42OxLp+ueI60ozcMzRiSG5Xz3rtk95Qc1hrmxUE4oQssOr/42DW0j095QepHrC8PqGPnaDmWtSgNPLk8J/ouYfkEUaEDHCQ4eqXjmYpCfLw0hau91s7oZuRVOVHtloatmGWHUmiL2IYmBpw7Sy3ZxvrbOEhdqaXKcwncCza9PA72fgpTTsFb8/kK9UKjKSGdv5JFBlBnCXW4JZihKWhQ+Uxk1EOvV7y5+aFwO12aSGqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwDUWecQRY9x822G3hENRcw3G9AFRwgMtJvKdLMUrLSH3SJlv8BYlZyI4HvL?=
 =?us-ascii?Q?sS1f8LnXW+foAjW4yFJkFUeaav8QKmiX9cxllsoCaxPWCiH4q0mG6Zf7HM0I?=
 =?us-ascii?Q?Dd5tfJBQJKQ1qAOx38FqMkh15tP0Xo6ccWbQt4pYPM9RToPIjMW9hJw+irbz?=
 =?us-ascii?Q?fsXQso3I0uQwyFlfH4kjMUzVwuVV0bKXmF47NkEGEZKdjd8YAHci1qbfRNbH?=
 =?us-ascii?Q?coun24NCaJHt42q2DFOy5QznsVSuxIf8S20XFE8MBPlN7y3jg+8Ug6PqJVuq?=
 =?us-ascii?Q?RVMZRW/n/FXFyBbHm+pwz5/GPvMjJCVDE9rmsqP5ThQuGa+2TSqQkyqzNnM8?=
 =?us-ascii?Q?LV04madzgNalSJ12+VmUYPTovIi1+v3PhaTzy2aMuMxYLcEz59x0WGSHUyYX?=
 =?us-ascii?Q?jSbZ7J9zByGdhU54mkY0alG9G97T2fwufUieTbPIWCMmJ/P0FytroWnU9LA5?=
 =?us-ascii?Q?fhviCukJb2RwtaOzImnAQh8ZwztFI7oBNSIP/5ilGTVNpkFmZ9DLxeXESv6v?=
 =?us-ascii?Q?JbDxsSHxYtyy32xlP8fIJ3m7UoAmoYCRc3wnZIZYlNBDXq9DMlAMNrNmqvYE?=
 =?us-ascii?Q?kOLJHST+HEIA2c+duLBuim2xIXShvbeH5lpI5dxXPZ6B9iZq1fkuE1C0HyRy?=
 =?us-ascii?Q?BF6tE+d+BdVCw7UGCwOcx+GUYhITrD8dp3FuSJgqHyVOsiqupOFAzAy+eJMP?=
 =?us-ascii?Q?V7l9ztcxqwsXE7dFvDXlsAUpEhHNF7L2XgaqjSEKYVkJgSKzk3tAjiFlZF4Q?=
 =?us-ascii?Q?HxQaDM1nLY9ulLR9c+44gDnPGu1VhVUorKtjjklboLmlTBsDinVsulIFnGk4?=
 =?us-ascii?Q?quGV1gEatThAisTiT/o/3VxT6vLy1jX9ISXCU3N6JJHHPrExlmwjZBUscorc?=
 =?us-ascii?Q?KJX2kJkG8dy5lkkLEE0Tu4QH5B2SbHC+yN9acDHNvjgM2bP6DgaslfbfgZ6h?=
 =?us-ascii?Q?+hymulGxd4miXRd3/kHVYDmm0IBg7I/XLkTV90gGGSZ4elacGhJrw996yn0y?=
 =?us-ascii?Q?d0dXHWdmAUGEaXn18wb5ejcvHgkPgFaBJuNTdU21MT2dkWDm6Lsm1ubggS6P?=
 =?us-ascii?Q?oKzqXbKWpaisDEy9V3CmOl0d9LP/AJuLL2v+qM543LE/O4ge0kHPndjcNBq5?=
 =?us-ascii?Q?qQiBdXAy7OMof6552IqSvpGsxhHXETUgC5d678EEmmz8yyr3wuNdVtMTyiTB?=
 =?us-ascii?Q?CsZrRcAqiJ7sQXSsvslUmfsFVn2ot68NxbGfIi0HGHIV1LewBVyxV9JIfeR9?=
 =?us-ascii?Q?oZbsy9BMDwE+Scy8z6CEILSPC3xI5hFwoBEvJ/3i77LC0yfb8YNxQWBQoCXk?=
 =?us-ascii?Q?j3qooh3Z++3BKX1fMxiR85pSfmX7f3JHfwN+EFTp/e/mfHZcjWyLolmIftfq?=
 =?us-ascii?Q?cye7hoI8nOZrwi+11RqI+vwmzhU8KOPi3rp6a69rpxOTDrUoaChrLwCY8zo2?=
 =?us-ascii?Q?bWs5P9bkWsDJgpvmVwQKCoG749fKlvz3EBQYKm530iTwqoK4Yqy8fo44yrsU?=
 =?us-ascii?Q?fQVWJlx2gOWRUDQemb56yKYXBIdb91Zc3Cbk6IzqOGbyd4ZZsQKPruMJkDiy?=
 =?us-ascii?Q?pHqdwT7ud8nQmEGkz4KIZRd7yv7umr83tVvsiddo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81094a23-312f-44f9-4edd-08db76f73a0f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:14:00.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6eR32G0woF8Tw6YCAaSX59PwYJXw9tnkdrbbiJnjbY+UD3Tw8qH1AVdn7tOgrsHuoTyB1bjto8Y0zQg7ssGFQ==
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
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d677..bd503fbcba51 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1151,7 +1151,7 @@ static int lvts_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
 					IRQF_ONESHOT, dev_name(dev), lvts_td);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.39.0

