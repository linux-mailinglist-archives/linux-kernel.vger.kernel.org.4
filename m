Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E464270E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLELAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiLEK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:59:56 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2105.outbound.protection.outlook.com [40.107.247.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42A1A06E;
        Mon,  5 Dec 2022 02:59:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OurR7BidBrIzCmcsS1VKZCp1tndTrfO+/cIQheXl99rg3M7M8PXxdOfj55kUwqUK+v0Szm44zVysJwpTKWSOmlJW5KuwhVdl+7U1Oc8CVR37NdoYAXVrMrDPYJuK8ItDUs1Qz/uSfbw6IDZSOSTpT3L1T9/b3PyhKDSvJk/nwkmdVKXUnER3TgKaINVMIuLfKAZ37buGaiK7yGM7nfRkv23fTjUUOBGo5mhihcSsxKU7EvXz0IZzLUfxq4wm+xDUoma0l15q6okCZI3hc9lbu6s+RepDZjVVafZlsAitx/JGu4sMTBCIz2tOKuK3GRWCsep6nu44l2qZWROC2qMuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgPlaMldcSXvI9gie8+sIcTOdSFgFUg3uaVANT/npf8=;
 b=UXu/MkOTswd3B6TcugCDoXRdGJ2E52t697l8zHhvIWbzgR8sZJKSPo4eWip0s/05AnXFqe942y3PaOrkcCAjxBQyI+KTL4+IkELXjwegxr5mF4H9y8ClXykKzj3iS8054SW1aAQ6L5Squ9qZWCH7eVH4evFM/2IVshD4xjbVOVmWzqDTGqIGaKCgSGVGOChDNsaLZDTR/cqAhSIiqqrTxnqm6L6/GQP83T9ejPKHPykgTjGo3ZYBmPaoVOGkTNc0i593DOkNhiJknZ1A2VzsoQDeWd5+Ujt217IVLBHRQ+FDTLqJp3xrIAe4YtOShJ4GmaeRapdnN4TBficpRfd0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgPlaMldcSXvI9gie8+sIcTOdSFgFUg3uaVANT/npf8=;
 b=PS599iNt36jW+3xyQbuStf4E/M07NPmVYKWUbVlMcmj0SeqReK3iQO64f/dGZNw23ZreSohS1InsPjoy+F4w3tl7MR+PmKRUUu404aZma7/ic7boUnxWylUQGGP0Qtg00OtkTLAKmAhCfvXpgb9zjkymQvmcbiQrn/yilTlrc5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VE1P190MB1024.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 10:59:46 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 10:59:46 +0000
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
Subject: [PATCH v3 0/3] mmc: xenon: Fix 2G DMA limitation on AC5 SoC
Date:   Mon,  5 Dec 2022 12:59:27 +0200
Message-Id: <20221205105931.410686-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VE1P190MB1024:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e692da-f0de-4592-1a7d-08dad6afd25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMFlrtSkW3/jNWq6JQ+OZtH0lH5yLC2H61iw170tqK/fzkOx5Nt4PsAgNBGQXiz8TIVEKztjn2RfJWYx8vAHNDgAI/fDXomzVNHWAXo8EKEfZLNeDaIQEPqn4HOUiwsRlpYEJBQnkPTbLnX7hIkEFU2WopUBBCIKd+kG/+CGYfqtlEUXsZS4RvoIpJQVOU1eV1RqYlLd+mJTTFVjNPWFQ8jnJ7zK/b1CFaExtu+nvhFWecdzp1QNJofz/X+GG4fFS4r47FSC8HOPXg06O6Kk1iFindGISM7lIqqe8WAKX2HRnyN0Sg6O0NC6QXQCD93XE3H/rrZMRmH+QGBmPrMZIY/EtijP/y52vYDPXEzO9NH7bG66dFeLFtP7YmoIlFVigRrxRzlAsube7OXM7oA7KeNgVygyn29R9GMathDFrMaVAbs0i9bDhntuNkJ88pU+kQgLXrbmerhMOOm6680HAqtj6jeZ2J1ubElg/+LP8STtdh4ALSQ81FslYrk+R9CFwPjCCZQRoeE9MIJy12Y4xp6w6HxF9EYrf+vAMfier5ER8kkiNTt11E+0K6eDUlwH6p8YPEfvB2g6aDBx9ClFsAm4o9XbyaaXkrryQ1S2i34eE1nLeQYV1cPaQcVouIAr0QjZCpk7xxjBBC+cwsgMC1ZRQMY9l5pC9wLogeiEVyQD59g/8iS06yqlpaVoUfnMZ8ZZQpcb+6s1pP5QOYx52Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39830400003)(136003)(376002)(451199015)(36756003)(38100700002)(86362001)(38350700002)(2906002)(41300700001)(8936002)(4326008)(44832011)(4744005)(5660300002)(7416002)(83380400001)(66556008)(478600001)(6486002)(66946007)(66476007)(316002)(54906003)(2616005)(110136005)(8676002)(107886003)(6666004)(1076003)(52116002)(6506007)(186003)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdGQ8g78zgkARxdEIvAR2+VmZgV0jQlYFXfnH+X8p77+ZmReU337AZTJT3c+?=
 =?us-ascii?Q?cFrh9wF/auK3HKixbeLM7b4sSlFuZbI8QNTmappfMvGhAScM479KPvxkKwga?=
 =?us-ascii?Q?tmtH4qWC1LCXjFeMCLtRL0PmMUPDGpm1qWnTyG9U+h5+0BD607Hw2tgGVK/d?=
 =?us-ascii?Q?WcJrisgBXsjwt6HGtP7MsDRZS1aeOmctHEE4jFfl7xQ7nXIAqM8KCYpsexx2?=
 =?us-ascii?Q?Bvh61zVi57A/dOyLmbGeSVrEw33pmMUUy6tMAUkVvAPrn9/5YzXqT+ZSmUYl?=
 =?us-ascii?Q?ny+3mTWP/k2oPrtqeyV0bE4Fzdshy4FIr+mmO0IbFQ4Ux13roNMW/Mlbv5nX?=
 =?us-ascii?Q?AsQ54sKVAsJemhvo6ZgNN/Ur4/0aLzMQUmSsKVcOb8oYFm+pW0+5BbGHz0wv?=
 =?us-ascii?Q?d5dCU7EPZ9KiVqvjnJs6ZskhZZZna+frWqgrlr9OEt9GD2pz3DjDFxm5Lyyf?=
 =?us-ascii?Q?ug7CXkD2TrJNu975H2Eipi+vWJLXZxSTpjbyakwaD3iG/+PVIbvNcI4CosTr?=
 =?us-ascii?Q?fnfkcvEp740itaIHAX1NsGOMZi8+YNOjb6j5pDKUfsMP6bd3dnvaCcTWaYrx?=
 =?us-ascii?Q?d2QjjDFErZJFah7pyBt4n06dCLBCVAux1fgjKwAa1zPAMEV4BzEzQriL/pxc?=
 =?us-ascii?Q?HaZootILfcCrCAE1qWPXxgzzCpPlW8sBlJst3GXbVDhtZownS9Z6IeJeIePX?=
 =?us-ascii?Q?kSWxWdXWrjIwo/BeNsVfAbZ5etPRYQtF3km4/FaJ1P8QPrPHT1BdXVZZM677?=
 =?us-ascii?Q?pLmz/PydiWpi3eItTm2U5mnIGSucYghKYbSCaX4H6fu1N3bYGQSQHJEiIKfO?=
 =?us-ascii?Q?iS6errg5yeieaw86GxZ0DKs/MujZrOgE/gI04jMDbETqBAm8/VPwntUr4pjH?=
 =?us-ascii?Q?KY/vLgUn0Bn5AGlDjrD2LrQ+QNYRjvKHOI235gN4qD5BaDDskMumiJI3r3L8?=
 =?us-ascii?Q?eXNRyYbVP3cmc73w+woKW2gCAvzCKX2LTfpeHeqej+hxQVaurt/7K646Z9Iz?=
 =?us-ascii?Q?xpvI/EVw4/z+DaA4N1TPA9t9GM+eXE18X59iJuJzmx49F7rH+nOSf0hTRMMw?=
 =?us-ascii?Q?90YaRMUObzhv/UtAQ+y+O6NAhh71i2QtRT86ZSaEhxC2fWT0/3dGACYw94DO?=
 =?us-ascii?Q?+1w1TvTXCczyLaWrqE5PlVyqH2AG+EyV4v/aoB0WBslIj8mx58HxsniOark0?=
 =?us-ascii?Q?BJnqoLgNUzwZNDilcxZYZM7zyy5le5tN17QJbJAU3isWXcxsv37PV/bUU8uJ?=
 =?us-ascii?Q?pYXq3CaiAxcoJEInTwTP+mZJTUFchJ07pKE2BScaYwPz98kh4TgtH72K8+UU?=
 =?us-ascii?Q?+JressEhFjbEKK9GXlg3Ouu1AJjP8lM7S9P3GCZEs0SgmMrJt30nEn2HPkqs?=
 =?us-ascii?Q?CgwOayp/qLc1yjvpF5CdvDYCYcUCD+EfFOQ1u8poQikhFycISgU6M2lli0t6?=
 =?us-ascii?Q?yEiLyRyuX8EsWBDsMzxuSBz9gZ34EraIGkvvDaVqXaOR479ZB4QEWTt+rb2D?=
 =?us-ascii?Q?W5ND12oQqDaoNAflSWvbvbCnO2NeBs/e1gZNvjoMpkvhp1cnH3zvbuPcuDmz?=
 =?us-ascii?Q?t8mHutonIiPiEQlKafJkxpVjVXKDxxlWBOFCWLlcJBphmvNrlFqtdWQNSuW6?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e692da-f0de-4592-1a7d-08dad6afd25a
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 10:59:46.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhPgusjSZwDthFJG3fc6yVnHqlQD77/5ofbpZ9UNABlpbDzQ2mScE0a9qPeulUW9h0/EAgtBP/Mi3uj3v7lixiXUnZfpUPV16Hx1z13AWdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB1024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation on AC5 SoC that mmc controller
can't have DMA access over 2G memory, so use SDMA with
a bounce buffer. Swiotlb can't help because on arm64 arch
it reserves memblock's at the end of the memory.

Additionally set mask to 34 bit since on AC5 SoC RAM starts
at 0x2_00000000.

Also add compatible string for AC5 SoC.

v3:
   #1 Fix missing EXPORT_SYMBOL_GPL for sdhci_set_dma_mask

   #2 Put compatible string in alphabetical order in the yaml file

v2:
   #1 Add compatible string for dt-bindings

   #2 Use SDMA with a bounce buffer instead of PIO.

Vadym Kochan (3):
  dt-bindings: mmc: xenon: Add compatible string for AC5 SoC
  mmc: sdhci: Export sdhci_set_dma_mask to be used by the drivers
  mmc: xenon: Fix 2G limitation on AC5 SoC

 .../bindings/mmc/marvell,xenon-sdhci.yaml     |  1 +
 drivers/mmc/host/sdhci-xenon.c                | 38 +++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.h                |  3 +-
 drivers/mmc/host/sdhci.c                      |  3 +-
 drivers/mmc/host/sdhci.h                      |  2 +
 5 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.25.1

