Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF564270F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLELAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiLEK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:59:58 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2118.outbound.protection.outlook.com [40.107.241.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C44167D7;
        Mon,  5 Dec 2022 02:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT7wv9Zyup5hfRjVzY8V6qNKxfgDXuRS9h+2W8+wxZ3EvieBR3PvYT3LctyjRLxySHrdEA5BKH+WELgodI13Mt+cNOa6PUNT5Mzije3oLfYshdaVmMvDT13zXZZLtX8Rte6zqA3AAaJqVlQ7Kq0QONBZSzc1khkIzsFjX7kNK+Zo1EeDLkDw2AqZFVX5pwoDD6gBX35RvL9eMBOX3jqHLVPnqUNl7H93cglznGrfnK1KKgxlglqnhgKH8bqaBq+2pWIXv70XKcYOEyR9FQWD49hsWuOY1ViuHKoRc3ggrzwvTxMtGfDZAe+DC/nG3fe7jL/B4AiPX0McKbb8zEPHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey09jtabUAQlpFOVjz/ZCGOl8FKQUNzR4azGy+CAeqA=;
 b=hyBQo0mkuhoMlRqKw4y53ipDgZw9dV3qqepzWkInaphuWYKPY52j9hE3XQ+1RLtw+0CRWgM8nfHqQe9GiUoFygdnXN1S+A88F5JFlMPUegiTKqiK/WME/YIRAlRV9+gMsyCVd8ogXhxY/uwYW7TetmSoRdgOiAm2zm10afo5e3H8fxLeI4MktX7ZHcNopBzFH/R5YKPLj4xt1EIcJ13NBzQWzjDBEx6ok894/16NUTVRzkqSXva7O3oPGXgGDda000P+Q2ybggquUPkz9Zlgb0/r3I7bG8l8tEIQ/k6TAJqYkKqIedJKTzWngKIk4n5Dg00uVD9JGkhL+dcXcl5AIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey09jtabUAQlpFOVjz/ZCGOl8FKQUNzR4azGy+CAeqA=;
 b=vG89IqigGe4+HYw33Ep4hSlqXmWNPitF1RTjRHlzmUVL7uEzXIvqCt1QzASqUlLhie2SSW2F01PdDGwCTDgDqowzRNRl4kDNRiU1UtVTfBWcUoeZTKZI6xno9eqw6Gmhn2oXLEjW69MWEit+Q8LpHzBp3FzF9ojv1+Z2RS+gWCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM8P190MB0980.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 10:59:50 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 10:59:49 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v3 2/3] mmc: sdhci: Export sdhci_set_dma_mask to be used by the drivers
Date:   Mon,  5 Dec 2022 12:59:29 +0200
Message-Id: <20221205105931.410686-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205105931.410686-1-vadym.kochan@plvision.eu>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM8P190MB0980:EE_
X-MS-Office365-Filtering-Correlation-Id: 927fa950-e448-4a09-714e-08dad6afd440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HArG96V0NVcGnbgcGjuqcNFgm0kxaCE1pv4QdXODGMEzpkjUFOE3TvW94BAANJiIM5rf72pWpRlUJh0KwCovQAnzGRZF1sOsX1Qx5PhA+ENv96KKSf2qxFesXS+7O0zrD/ycHZQGn3pmyQ94h774gw5YSPWLLoAi7VvgzMM17I7ZaEP9YUh4TN5RRSlyJkjxRASgrG4bSXUCVklswVMMIEFDJgyX2XBIexsRymTIkZ5d3DNwX+j2vHpM2JogidAjDT5ScYU5DALszHAOTCTPmxCgaJaFxmECurL/uLRnVCtjXrfC6wrodAtnzbTz5sHsmy7unopZ/Br8s3UPHC4mXZ9cc1c42RqWS+fQvvMze1qc+CCJtEMONXzesHsuCIM4KWS3voIfwlNXYiyM/dculgoRRJpNUT9CBWNIa05CeGaNaSgvCgSb/izirSUSrBf+PY4RAMPssszOdCN1HtV0G/3pri1PM1avJ/kAb0I9G+Iy989tOWDX3rA2uOjvG7B2da0gbMoSZozH2nKgjYZJhi2Wvu4ChB6HtsXBr640kmDVTK14TvWo7xX64ADNcjYpxxS7vO8EhMdiuobJrdJdDSmda7HQoyNd4CWbVbNZ4qH1ylGNBE9wDn/RLLOtcBH6f14ulAguqqcko7JkJ3qs/CxzeymoaR3si4kYJZdyp6prHc7vnHEcZpy0mKzHF38
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39830400003)(366004)(451199015)(36756003)(38100700002)(86362001)(38350700002)(2906002)(41300700001)(8936002)(4326008)(44832011)(5660300002)(7416002)(83380400001)(66946007)(478600001)(6486002)(66476007)(66556008)(316002)(54906003)(2616005)(110136005)(8676002)(107886003)(1076003)(6666004)(52116002)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDfa7djD9/dkwq+5p+wqkBHPVHd62VMzKkVwJ8l9VbiYSRksT/D16R4zboGi?=
 =?us-ascii?Q?CNjJzSboOPihMYUhwX41xAeXbywUJkD95MdvrFw4zmoRINlNcTdowvZZV1Et?=
 =?us-ascii?Q?ftFWfIWGV/eOQiWc8ZrtUM/aXTW1ERRrny4cygClNEz6xvlJWm9+ejf1ITxw?=
 =?us-ascii?Q?geKOHaLh9u4yH9nR/0m8Iwp7gSzj+x7mfcXGthgIt8JN0XoZDV5uuo8yaauQ?=
 =?us-ascii?Q?3Rb2YuPawlKLwsJDTF0/ISBll64NtbtbrrScQaxXHq8WCXZdEBo9QDuM8J4x?=
 =?us-ascii?Q?TZI1gZezio8pGuAstOYWU6KpP2Kwz8gCfW4ZvJiULoeQe6NYF/VXeJSI/5JO?=
 =?us-ascii?Q?dgOhRylL93Ig/pFo3JGg/lNcs9Htfy7cUs+XjnwyeVHEIhT4u+A5SvVnoFrv?=
 =?us-ascii?Q?8x328AxC6wGkoa6gvlewP0hH81+pzXi4QRzeH5FhRs7hofgeOTJKmgOUeuJt?=
 =?us-ascii?Q?qQl5PKb3pYDhEkBt+gmH3wXEiuLJlB4fqug6RWRB64ngXo/v8MTKdt4zcKB7?=
 =?us-ascii?Q?xAjYpSkBE9fpX9WHJUcV5YNtwhKluUIRUPLQm8sECydEemDpIfw9PY7894oH?=
 =?us-ascii?Q?YuPr86dnPLzAzg2KPG6bgNumQEnP3JQsk7gi0wgoRLGwZB6+zjK6UXrUdOIb?=
 =?us-ascii?Q?OD71W5BaA2ppOMKi/Na3nj+aEAvXnvx/AQ4VNJWXwdoiHEwI5GgZiXGpWv5s?=
 =?us-ascii?Q?xMQJj9Pr/g2Yu9jU3jFKvLPdixMx/wMz4c1BSAllmOqEwWtp7C8D5fzUBq+e?=
 =?us-ascii?Q?JTYjt0qKAFu5VycJBDPti9gsy+Hl/OK2UDSApCuIFQFs4L2tSXnW+Psf1sHS?=
 =?us-ascii?Q?r5gIDih6IQq5cERRzsUOq41PxKvJ2X3B4abA1uYFsKe8NB0XupRGXoe+hFT7?=
 =?us-ascii?Q?g3ZCJ5AcCcvwHhUxtVWMKIJzydkkYisAPRRpqL2reP+2epUgs+IKCDvzbrK2?=
 =?us-ascii?Q?GNDHH3Y6r0XMgbIFbo6+mtulY1VLHgutfr1hatbSSTTyw7xZCUwkdIXKKSx4?=
 =?us-ascii?Q?3uVvhX+b2DTpWOT3NAzU939sHfwyfjef8h8DuSyDDkm1tHpEjMALmdkiBzPN?=
 =?us-ascii?Q?3FNzrEPLjdb6mxS9UeHM0HEkwSLap+AZGAR+SN2EWe1bKsFK2VaxD5HKJH+Q?=
 =?us-ascii?Q?yaeAGxnLmbGelza5MWsXFywusCt8aTFyjOyKdsM4enASk9QeFGjvV8b2dqGl?=
 =?us-ascii?Q?If/dD+ZIyHrHyMuuoBAsotsj8PRo+cFMJ+uugQKvBgFPdGhEjejOXdoXkznI?=
 =?us-ascii?Q?xTRiARl1VSlF4NU7O8hpOM7vB/NBabLe3MPcEkudwrDnL5OAhDuilCSC49x/?=
 =?us-ascii?Q?BX04X7FJvXEveOrDBz0YgDbaO4pSWi1k0eXckHi+/6XBmI0M7RyiYG0si6AU?=
 =?us-ascii?Q?QDqDCkwP+PXJqBtw+srxu7gWOK1L8ZjHCCPH0j8uEKa4spapvLALsJezohUI?=
 =?us-ascii?Q?iAGBLAXQXLsmcWfPyYiWe2/weLjtC781A8bvBVGhZpnCr3gImh7bBSHaQpVr?=
 =?us-ascii?Q?EE8hKR4jQjqpViqPduBAVdQ8TmJYApvc7LUmeb38w1ftO/E1petK+O+ju9RV?=
 =?us-ascii?Q?U8UecHSWxEhKxFjH9fr0yLIrmL5y+AKjRUhpkTt8AErtkCRc2TV0rFdhnGJA?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 927fa950-e448-4a09-714e-08dad6afd440
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 10:59:49.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0knt1Owyw1GkWDIjAKQIbREHQrGOVwOkKnUig5uWAYAXABcdMSqstDK95keaiV0pHHZ6DyhKKh/gq/g5K+hK/h3shkNuLpYezGaoKoA7oxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Particularly it is needed for xenon-sdhci which uses set_dma_mask callback
to fixup the DMA settings for AC5 SoC.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v3:
   #1 Fix missing EXPORT_SYMBOL_GPL for sdhci_set_dma_mask

 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2108e8075609..d3ed0531d985 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4022,7 +4022,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
-static int sdhci_set_dma_mask(struct sdhci_host *host)
+int sdhci_set_dma_mask(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct device *dev = mmc_dev(mmc);
@@ -4051,6 +4051,7 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sdhci_set_dma_mask);
 
 void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 		       const u32 *caps, const u32 *caps1)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 908da47ac5ba..b46d47c19650 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -815,4 +815,6 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+int sdhci_set_dma_mask(struct sdhci_host *host);
+
 #endif /* __SDHCI_HW_H */
-- 
2.25.1

