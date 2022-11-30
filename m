Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7963D6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiK3NiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiK3NiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:09 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2124.outbound.protection.outlook.com [40.107.6.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D09A28E0A;
        Wed, 30 Nov 2022 05:38:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIUiJ7FJL+R7HKsHJ2242TNCmeKx0pDrQ5J+wtXb7vgfSuOeskcDurUUHChl68NlSpNI9Rze7cPWMg+CxMXef2E4ACelrKe1yhEXgGWQKwv06ppuZaHyyzRuFq2iuYqaBvRg3Wkphsj0s5BCIWYNHbzjzDmKOHR5eGnwMWcw+q3xu1z/fviwtqj1D6JelJil5yhtyLw5gNb7Ygt3WjZtBNhLHzMHobuAeVCa4iLS35isLIEJtSjW8/7hr8eit2d79MlEzmU18VqKbLuxPZxSkl1E0U7rJz+agJD7XaoGXB/XsXIvwoXREd9YzBioov817yTHWvwPuq9D7I6ZIKQ0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q5pw07O8LLInZ9JVL3ZCnjb7KZ/LT8mqYy9Bnciscg=;
 b=Kp6wvemI6x7HQkNPQxYvWpiXOXxp+LSSN/+qUQnEN3g+wxaUjl1izk+GCR9fcWCNOejIcKqYff5kyhh9G4scYQn2oqpyodTENJbdgs2eTuXE1A6b/fpCmeWAMvCUYznpY2vffKfl2xdh6BVEZU8sbXrQBMPK7p5QJV6KElu1KoNefEivMmlrWt1GTUgmqioQ3pS9HMau6X69PNJtLCDbMbPHg8wQP+Hoip1LQWdgJmMW5qZ8bRdJ1VymRzh2QPUkGDjQMsJOATEQyaH6icPmuQOsttfuC4CkvLuf6+vzBtgHfnZshOO+E5RTjuObjD7HtXrLwa3GO7Fp44mXSdIRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q5pw07O8LLInZ9JVL3ZCnjb7KZ/LT8mqYy9Bnciscg=;
 b=FNjEmkZEPX/UUAjS1tFQKT/EGQgdgAAvY82PKYGlfI5mH2BsKrI/w1UOON384+2RSouSjYMw5VQahGXla6wBNnLo/5aDY27ytrt0q/GlyWIB1I8VCxLzp48KnELL0CowzGkbPpXWCmSZOdOxPp3DFPkQFRdti7q68/zMWzhqUz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PR3P190MB0858.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 13:38:06 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 13:38:06 +0000
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
Subject: [PATCH v2 2/3] mmc: sdhci: Export sdhci_set_dma_mask to be used by the drivers
Date:   Wed, 30 Nov 2022 15:37:46 +0200
Message-Id: <20221130133747.3777340-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
References: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PR3P190MB0858:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a0c50e-d5d1-426c-8284-08dad2d81cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxQH1CjRf32mow+v2Jqs6KNpVtJ4c/CXSXyEcBUiOms9IhJuKcI32/TijB/r2EK1+ImyiVbhhMxNgVsg6rmE+txtRDx/RlYkMSOZNZFIJMT2oDc7fh/cCdX7tbycPyJV+eiOrfjS4gMLDUa5Q+QRWgYTSnJZbqzkkIRwNCHhBBD5AalHuya/L7fgnwTCbKvbDzAln5lgk1VS9WVy8d6rV25HecTBbTSR3/K/96xo6CagkFX7/MWU3Uri4tRUf4AL4FMmn06onN8XDNqloCAM5Uzyxw7Trs2ggqMxMQMR2pqO//nUOLJqyC25RP7AQwBNRzts/OxtZpiwLC8ENpH+jx+B/PJP3XOWYrt3M1bKn43aVrPEhS92Ybmsij8hGCI693YpYNOuOGiRTAxtUsoDPGAC0EJc6weRyYSmOPnFR2DmMMzF2hjFixBmv8i/ZSA8RW3+K9S7u9EJyglafXGS0p/iU5+Y5yyaEQ5v1JH56TwUF17YNQRSbsfJAkESp58wxoXpnC4XxEq2+g2fO+QrTDXbt/SAAVEHCHcaiiCJWcIiMPKwrCLMGAlyA+tIcSysCAJNGXgv2Msu2Wj54LmMwugfEFHNCEnh/0hF5Vxwm33OmqsuXjrMlnM5Rm5DoRi/26lJdjNJwCdOxNwQ0csEssEZxV8Bb93ZJTwXf6P0IhI0u14Gb6wg2K05teOaoVwUhm9SnkcMKKKav+8ryVhL4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39830400003)(376002)(136003)(346002)(451199015)(8936002)(110136005)(5660300002)(54906003)(186003)(36756003)(41300700001)(66476007)(4326008)(66556008)(316002)(8676002)(38100700002)(83380400001)(107886003)(6486002)(2616005)(6512007)(26005)(86362001)(478600001)(7416002)(66946007)(52116002)(6666004)(1076003)(38350700002)(6506007)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vEEtXLSlUeZ65+8Mt3zMBGXoObzsOtr+BF1qixwCx7miXRZypPDwRgO6shjO?=
 =?us-ascii?Q?XIBheMwnRDzrCEpo64NsYckjAcdDrAdVCW3x3TrlIuwMyjoJdvrDUL2u8/40?=
 =?us-ascii?Q?ZQJvQKxaMSry0xcl9XWr0FOiXEiOJjPB4l2pMPC7FRHDGeDGTJQdI20cQ5Zq?=
 =?us-ascii?Q?KTR3bixEDm2B5ZbHV5YoprgPVRjceIhW5y15kipCToal9ZmuB/M7qhodKq1E?=
 =?us-ascii?Q?VQZaHn7++8q4hXlu9acD4Zk4qR76zssBXj7VkqxGDK2JTOHHUp6IlGuZJ1Uv?=
 =?us-ascii?Q?bJiWzpU7HOd6x+08mtDELeeUAJmXTW3bz84zyPuBm7vPu/IBuEvrldQpIIKb?=
 =?us-ascii?Q?ti8FKUxne7OcVSeTmzpGqFx/E0BQL/pU5U2tG4FDKmwWEjtqfCedAQSJd/e5?=
 =?us-ascii?Q?odlIErkwQCf3oZkFP9kKwF5gFQBPeC6uqkjAvv/2+XaOxYKatLFc3vep7NOI?=
 =?us-ascii?Q?2KwPfREO93+DzJoZRGqbH/bArcK83AJVAlYhWV+b8GFZV6pn9YV77mHv7uPC?=
 =?us-ascii?Q?R8ycuYIt7KU14z8DUkF9gNIBxTLdULkAEHWYEXsu5ev6O6en3yVGpx+m0TeY?=
 =?us-ascii?Q?JqvgW11sw11h2PR6ZijE1mcHyUIPdEozCdWkB5wTE05yR+y7aXdoLCEO0bIL?=
 =?us-ascii?Q?FA2WZi0IVUbNAQJIFm9x0tBgyTQ/HzK8inopEiUtqKvcPRbOVq5Z4XkaBA4C?=
 =?us-ascii?Q?I3WHCShOsHQ336lYJfHPSxOS0X1BrNtFRmKPpnMjxeM1cV1DTyZWNrZ0PDgC?=
 =?us-ascii?Q?mv4aEnpPVQR2TQXNX3xw/XnhfKjab7AQygEwkWphaCiifHW6Q/gsfRLi2XB4?=
 =?us-ascii?Q?4aBk5brqgtwBl6MwK4pJT79c744bUO4OgwYH9E3o8BGclwLWePUt/yJlwb84?=
 =?us-ascii?Q?TgD2fdS0YAJO9pKVCe/r1J67Xk+/GrT5XADcpkXzGxe62DjfTnCr3ov47Oo0?=
 =?us-ascii?Q?JU/fdHZsZl7JLF+PI4xNwkWmPvdfXut49EFWBKM8uVpsVmzvJ1FJUd1OoCgr?=
 =?us-ascii?Q?BS47QaRWnQiVam+/apvUB3CfJCo4pk0cgS+cUf2AlBP+VfUJ49aeOGWipUXc?=
 =?us-ascii?Q?gTd/hi85gdWTXwX3guiNoxBX6OxhApFSb55iKoi2Y/cBw44C8qRQotYvv2ty?=
 =?us-ascii?Q?ENuCslitVF6FC02Ge4LpzYkF6jL7fmym4cjJA4yMInADLYJze0yeQVpfnD0y?=
 =?us-ascii?Q?SkaKmAb0Liv4TIX/u2Idi33C3VANbBvxYgkNE4+ya1rRL3bDS84Vnhsg69Ej?=
 =?us-ascii?Q?GTBnyuwrFAef1c4BedRjn02l7ZvFIvEGM15lhDFJiE7rANqF7Dura7q0RYxj?=
 =?us-ascii?Q?7F7O2IYZvbwDylv4Q/YExWb8Wu2jqk4lwvE2IH0GHenBv3sB9m7+cU2t/ehh?=
 =?us-ascii?Q?ZGUmKtPZAd2Xu9Hlj4uRJIEEGmBWppmZtvNTGTRCEhymz4vL/+JsQ7KqFnZQ?=
 =?us-ascii?Q?KZBL2Pf0kIvWqIdz6FqBWymEmmqgNns7W/CGKmhCZtadxXCJBPDzRAejZMCX?=
 =?us-ascii?Q?VLs0hhTpuK2bW0T9Lq1/k2PnSXcFGrxb180bRMNoQVOcziZD/Lydc4Bams0M?=
 =?us-ascii?Q?gkOJj+5Kk9RWdb9ICZsgJY+I9l8B28slcgvWbx8+TOM9MUnnT+K0xCPc4DHZ?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a0c50e-d5d1-426c-8284-08dad2d81cd9
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 13:38:06.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ui6UmHx0o68z6qkkhtRlpy4gVzqlotJTq8c9Rh4bOS+TnVyz8mNinR+aS12Dg9W0Emxv/+DJRz634O3ItzvLj/qVRvP3KtQmbgf+mua2Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0858
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
 drivers/mmc/host/sdhci.c | 2 +-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2108e8075609..e5d9abcc2116 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4022,7 +4022,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
-static int sdhci_set_dma_mask(struct sdhci_host *host)
+int sdhci_set_dma_mask(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct device *dev = mmc_dev(mmc);
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

