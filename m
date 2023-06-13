Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB072E206
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjFMLtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjFMLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:49:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC081E4A;
        Tue, 13 Jun 2023 04:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzKZOoLXbsvmkynOQ+ivJe0j/oPTef8CtPslzBt/HYEpyNCy+TQQtpkJrbX+VpxMV9HpzUDbSpI/bCqOsJVkRIH4GgWk0fF3WYhBfVl2NTFUxtd9S7W+tlV+wuF/8oDQBBADhOeX4qaTnZEqhhdIbmWjxMM9QKTBUpjlb+sffGWUBz2IZ2NA7GCQkBcuq48g/3G/vOU2TnmmO7sB8FckDDH1StLD9S+OnPyOSN4N1r68k4nW1hEffrg/BMlL4zaO2cixbEyYlWRMyZalR4gO5g5OTLj4jg+vlaL1ZH170EYvtXmz8rloDmBdE2T/n8uTiZekN3NttiUVauYxaMCY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xll6dkaotIJib1dizrzisPzHCkyQLaUn0rr/oFaGt4=;
 b=WtSTCJylNKdOheFReKs+7IknrVSaEWvvMar98mr7Qtq1AYKl9av1XGhdV9HhATwa9UjyXwpEuUY5LFUFJBqQdCfMvMe/ADVToR+cgR3YcDxks1Xy2RHTzy3slAfq/5/JGjCK+8ADUVu5K8ozNgaVPQFmUtM1qTqH1YDDskTN6v14aBGPriXfAZm62tKKUawgM+x6oIakwqqfDPYA3yjBjVBqRGOGY4tkXz7xN4U4Z9Pzw520JgadTJ87D3RnRfMeGNFJK/LXKNj8Ln4J2D+PFde1rMjzskqmB0nEurG/8Q4co9kOQGYXmiuASbcPsQlffuNl3eLwSx8fFGnuu0tH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xll6dkaotIJib1dizrzisPzHCkyQLaUn0rr/oFaGt4=;
 b=CSmgihR2we7WIpanRL1cI9xp728SiCK91xDZux+1WD9M19VQyfyaCqYKtE5od5nkzA0roFuZpEp+ZKsQgJDinkG/mhJtfMUnJ660OGzHxtV57QQad4n5tWhhM/aMdtPW9VAFWDDnlxYei+nIABrFVw8bSWmd/l7KcOAHPMKwhGC4k3aqt4wk8SX6tXyeUf3fjEK6QuhMfIsiaj24JutsnD6nj/WdGh1cP4BcCNQp1l5defvWvmd4QQxhKMgYq1XCApEOafeDJ/gpbbR2L1k8uJSKbIn2Z2wzyVBq2JNuAQKuxY/C/syN2Km9ux4o88BNJKww0nZuqEal6l/jupTN+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:20 +0000
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
Subject: [PATCH v3 01/12] thermal/hwmon: Add error information printing for devm_thermal_add_hwmon_sysfs()
Date:   Tue, 13 Jun 2023 19:48:53 +0800
Message-Id: <20230613114904.15749-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc97a70-4063-44a2-f4b5-08db6c04396d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij0O+cN+uGtcmbLMwgRKUARSnX2qcpAArxKp6nEqK4fo7qz21vRKyCyt8HRENzV2yIb0KcmfTGhQdCuN3/D8/AO5JAP42jEEj7aaJMM7hPi4gUL6uCcwIsJ0FbhjiCenXhz0zqn48wWrEQ29gufBGt4ttgnaW/cG2johVVoQ3TexCcY8PKwbRX9kYPW7a5AK3DnX/xvtdQDdAdwKO+mX1kxfOzc/arH9136Fzfit7NxfH++OXPRjCrm1jc9E0j/FXg83zZjP/VbMIyEWpxdvrXkOua5KG/jgG51n4LJp3KNhztoBIoBHdzArXRCUCup25Ikx/vYcprWe3WWwvIN3hPFZET0AtpmVvtUeCim/bRtQw5BUFAGMSD7eLtgmtDWwaHMmAQ01OqVRxIwn+ksOZnoFAsucOojm3t1EVfbBH0D6F9AD6Qafoka9my4e17fYzGNflaVjhF9tmQClaIEh06iYYtxqTUNAHKJFgtzVN8uh8c0SX+uRzUr6XKhtAsgAmWejenh7HiTNwyBRJGSfnbz1iaGuF4BeIJWCLF++8L5PyEB7TcvAbB8oZFx+e79ftGS2RhHMw72fWLTNphuJHvuXtWG4Z9c5MDK0JKRpwLnSiDJqaJOvDtnWfScyJ2dfvB4DFpCSJOVWowo/o1Avtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KheE1p7wc23dVwyjNGQi86QOGLBHK3bDnYVYTMXNHuZBYeQFJ5tJMmqh9grO?=
 =?us-ascii?Q?01EJe3ACiKZM57VksagYo8+X1ADK/hGkQ6kbOiT6triXmN/2Kr5+KiiVe5YF?=
 =?us-ascii?Q?734CVr8emYbtDqmvuiUL3utcvjOdgV99ihWe+i/oCSPzOHHuDsWoYpYfTdrG?=
 =?us-ascii?Q?qJbNTT5MkHR85XqlFg1yNcpUv3U00gIkconCGur3oAxLN4/v+1CqKA4xT3d5?=
 =?us-ascii?Q?eMZr5Md7Cf4KBPOQqmuNJn27xxQnqawJ8BrcA3B53d0PHbZBBHMOSdY13YWv?=
 =?us-ascii?Q?6QJobMKr4wRh2SnRDELQbYTaUNqx4hLZyJKEKD1Zp3Kgk77kGm9/FmFdK6BK?=
 =?us-ascii?Q?pEjX1MfwwU7jGGFijHYlOmnBqw0x6FEw1u5W2BW594LMAIFpxFW4sZ+6PbyH?=
 =?us-ascii?Q?RcFV6x1VFqSLCmb1XM+8YvcotHxkR0t1lm1SH36YM/WSNQMpGJi0T8+iGHZK?=
 =?us-ascii?Q?Dn6IRwWAAL66UeuQtxSrNF3595fFWJ+JYl+rf03E5gB8wtA9r/JYlAnQfHhf?=
 =?us-ascii?Q?6Zt7vC7H+KsTY+JCzTfquC5l2OsuyTb/5zsbt0DRu0Y6L86JmEO34eVE+kkw?=
 =?us-ascii?Q?UjABaxE/g62Vu1Y+slt3C3iZqsj/lrlfH+i/zT73KhbinYPkQpjUOtTWZYqR?=
 =?us-ascii?Q?4Ij78Ke+wn81vzLDw1XSg/SlRYphcG7wCghIJtp3f0Q+e8n0/UeDAQJdU+V+?=
 =?us-ascii?Q?UH5wLxhX4kax32NiUCjnLCdLgYpTX2/qhiPovXL14S9rLbNxgNwTXKt64F5g?=
 =?us-ascii?Q?LSmEcKgE0FtzR3Tq0kaJT/R8/a0oqmCE0YgbCYlNW0J8NP6I32xaalXReHgh?=
 =?us-ascii?Q?ecmVlyHaTlA8vWlNQR9Hqmhbcl3ZsmMoA4gbkeQtrCwdrKgPHdgIhihamNJY?=
 =?us-ascii?Q?tl9ApQ8WY3beKvN1ElZ+ZjOhPCJ9d769fYjGIUnmdUukr36riO70OR7vNbGp?=
 =?us-ascii?Q?/zDkG5NhaZd6RiWyrBhrpifLpElzD6iFiq4qiWqhFFdvr0YIBJqoIGjPIxrC?=
 =?us-ascii?Q?QyWqC7N3MJe2HBmnY1ZPpGTYF0U+IUEKwEIotMcTX0k0Up27JQAvWgRALVTa?=
 =?us-ascii?Q?FLlNWw/Klje82XfogyWByoNyxBrSbBP6WPuw9kyznY2adgWiK5g9EnxghN26?=
 =?us-ascii?Q?hDsY1X54DI/NePgTqVks6n8RRx/mqkyG/pLFNQLHl+m6vl4FocuWrffBQfn5?=
 =?us-ascii?Q?LgxD8MrYvtAycJAC1pMmAttPEwfO1r/tcHcVJTvr2qDqiHg9gs0NtrRgk2D5?=
 =?us-ascii?Q?NbAt5Y683USut336cRsWzu/kgEj5UX/1A1Uk2CR1IaMlJB3prxtaR3hv+1tB?=
 =?us-ascii?Q?+hV2XxT7RejJbFAmd0zpsSpr6HmjQ7T0uQv9YShiQYP3VkO0mjRq+42XOfdN?=
 =?us-ascii?Q?2jym6O3OYv8Vysl4s0PiaErvv8t+Tcc0JjH0veiFOSTME9QLpB1Lfzym3HBF?=
 =?us-ascii?Q?zGyGGwtETSugSIo9fYB41JC8pNiqyYXG0t7/KHk3hwZFWZ2rCfmW8bT9PRHQ?=
 =?us-ascii?Q?gdsR/ztMdHccNYwpxPPT909LWbfqtkK1ou2DkvEnt+SibUx7mZDRrNvwRBFc?=
 =?us-ascii?Q?I3mOMDDzF8BlNhNZFaN6dp3+aJP4nXrohIoQwJ4f?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc97a70-4063-44a2-f4b5-08db6c04396d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:20.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UreJ3tJMPRqREwRqMDS1wPpdLbJ2TVvmeByTnFUgPM3rrvOuU/I0bEzsXaIDDtEhC5E58bfAfEzE2eake+nKMw==
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

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-cleanup lvts_thermal
v2:
-convert to dev_warn
 drivers/thermal/thermal_hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index fbe55509e307..c3ae44659b81 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -271,11 +271,14 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_warn(dev, "Failed to allocate device resource data\n");
 		return -ENOMEM;
+	}
 
 	ret = thermal_add_hwmon_sysfs(tz);
 	if (ret) {
+		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 		devres_free(ptr);
 		return ret;
 	}
-- 
2.39.0

