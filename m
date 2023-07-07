Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F6574AE4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjGGJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGGJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E5AF;
        Fri,  7 Jul 2023 02:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPcttlvRqlgOatcQS79WmQIQgrhcgdH0ati66GtYZV2JZ92qGACx1oGvuNtAAjSVOS9jcpM9CVqnwYq+d4UMUHesIYD4HTDaz3EZ+QfRaWwF7wS2Rspo8MdAqr2l1Suny98EDQmTnIj+WUwZhipv+sXdfqZPqJ9oMtZnpnVBerpUJqGFYgRvxnWCTrE81NA5Wo2GFiN1C1YfeDF7/deEfkC+2s50/GRmhgPU+PN3DpVLRJTESBiCVKWPaVYw9OcPMUvdxuPx2gTsieE1rVm1fEbuYNjrquM67nyaj4U21FgPhru2enGSQ71e1WH3M4ra6+YzzmGuTQmf2B3hs97l2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsBaBcCLU6Dj27gwHjzD8seU8IaFnv36frgHmn3O0BY=;
 b=GAIblYBRtU5PPGkJLZ5aB8VbfzCge8PQ1T6lkUASjRAoHemxc/gEgfK3vWfTjM+Uok5qAMQ3nXrIGD66hScm2H13C+6fhXAmD9hPDyI3MnwGsUA1iD7hyvAkwJh/+xYtFxl9bkBUncBVVuRHUKBgRnOxN9/igW79c1WqIQlpNAvlaJxd/4oL1/SGVdhUohMXDeOQDRh433EBP3UjQDLjCx8Mwe+J9o1uDBz4HWfghtV1hwnfMXPaanATmzH1Kx11gnlclOfVliSsdXEUe45XE+WWZQnz6g0P7vrsOfp7PGJineA0fDWFuVSpxFigNK6i/y2cSvbvyyOgWbEAdKR3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsBaBcCLU6Dj27gwHjzD8seU8IaFnv36frgHmn3O0BY=;
 b=CuuHLJ5u/8JIdQr4dVUEkSXPjza3J6aNhCebpbCfIPrNmgOZCm7wZu9HZbQkdv7Q+9DVhXBTFTthSTkSYz9eo7IPA1sz/mIZRouL7hKzmZ8k2xRExtOnm6Jkp38LOGY65aoMRlQK9WTqXD+wfQJlFchUPVKtqZym8UZoqelQYQfqtlM4lVLL2EY3jlNWOVdFh+sWhYnSwrrxBd0wknrHqK2DmfttK8uJQWsGKaIWmesrRh2kS0aL9w0tPCg2KPnaJ5B/Vxhbnred2UMNB2Oc/RIu0kLqekHkJcTD0INF0W98YLV/hA7wsNq9O/GC9v0zntbp7FapS97EYhb9E/zo/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] ata: ahci_tegra: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:06 +0800
Message-Id: <20230707095513.64224-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9944c2-cb1a-426b-5fdc-08db7ed04d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2R50rkFAE3vRpkp/Ou88X5B7DJpNcXEma+FtLM5zEWfaBzDtqLYyDmXppn1KzhyRojYLB5QsoamiCNIEOrWeImUn4FU1y3WXRAWqZhCcbLgST753r72S26y4wzoW3GUzH3wqokqlnNEnxOrXx8LFDFJamlnQYwDGkHY9dSf4K9+Sxs3A4ekqhFsLsXTOxcrlebR4MeiRzmDT0nQ2n7tl8GozEJLw8/zM+D/lzmxhOO9vSpng10Ng/p6inV0eoN46vBvItfvjnAYV7ue7Y2anRyZ+G4yDt4goBzgKXQGuOHaPIFptQBA8i2rKcHGu/+8RUpXe7T6fyiP0w4qao4JRw1UH76f8m9SrDQKekTlBbUHbfjaILcGhjX42UWtPkJn9DF6JKRpw2UddBrydndCfrqVRIGqJc1wLO7gu6nnOBj3aQiMgwQAw49kRdj3K5hS++gWMi/hjvoboQp8bZdHrnVRV+cu5bjSv46lyNm3JfjsC+VpQLYhKRiE1p3XWq8Ea1RKuVafbJx86eI/HQRJgS8Izub2p8oEdNfhwXMxKw+tZhqL3kVJWZlbkOqAgKMKjjgPnU6lX0WFGwNOOfQ+NHuEdns9HOha2tl+4t+TXBHwxsJMpkdOn+HNE+mmUCUs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(110136005)(41300700001)(8936002)(8676002)(4744005)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZPvqUQu6tPZcphSuUttVtqcdFBJv/i0zfyoc0yS6o2y/Pe3QXNi9p0iv75m?=
 =?us-ascii?Q?nchkfA4y68crBTzXdNzju6PEzII4Oj4EHkwtrWMmREaCz6xe+b4lZZp13Nfy?=
 =?us-ascii?Q?9AcPbINZOfFMPtp9F3+SBPDB6OXLmoesk7D88VMgvbwfLcyNiwKGJgnLqDSZ?=
 =?us-ascii?Q?cXEgcp9qKnzaF59dfMchxIjHtbY8SKkiOQCVj6FKzqyUnvc4TLOOKF4Ga7h/?=
 =?us-ascii?Q?w3lB5E7CuJAw7ETPlobf/7KO9Y0FLw8lswjCSdDRwlEqSzghuYWFGyQ5xEAY?=
 =?us-ascii?Q?Hn+1PoRW1bWQ58XpqkGKFpr+hoygy0hqETj/nGPqcB6m5wh+WYg7iacVXuz4?=
 =?us-ascii?Q?4H3una00GEYB6RSztOr/vgtikCRZfur4b263KkkjFaTdcPhfqxgn6rIOiomD?=
 =?us-ascii?Q?pH/yqFkIbkr7HS+fIFuoTxUMLgpR6Cy414/4QFZ74R3bYfxLDtRty1WsUqgz?=
 =?us-ascii?Q?QKqE12u9G/6FReDxy9p5egsGoeTUCenBimCQCQaqOxT0yBwL3f5JiYXiHckc?=
 =?us-ascii?Q?I55uDVGlyWvNeYKCG++NyA1+LQVXvOmsYlV2JwAxNHqw+avCEAPLlEKWSlrt?=
 =?us-ascii?Q?GQl1uIm3eXlTGnl58i/P5ok1BxfJwlhwjAjBnJw5aUDCWjUgMgDXzzk5o58D?=
 =?us-ascii?Q?gHBzExI/MJzviPWt8z8Qc98mVaLfiyE1YSua0yiaVB/apR9bxqPEGa3T3bOZ?=
 =?us-ascii?Q?aYn7dn7rlJu2eS1hK4lE5eIIU4ZVRu74TpErAAPL8ClkWfe/gIO2rKycNfZF?=
 =?us-ascii?Q?MClpUHClEVIp3Pi0+AnvwOYrHOGR3CGJJ6bS35/wpWs1NZ/9Mx52P/CGsZtP?=
 =?us-ascii?Q?7uH069MKSTaTAHrXIBaFSz+EP8r0MSEoF8dJuekGNWgxDFgRAzPQ/EifwIzl?=
 =?us-ascii?Q?R5Jt3niB1+7dsGR/Y8oF8XsJ3aCwpRcUrWd5QfF7b+CD/2fKEJKdte3blK1K?=
 =?us-ascii?Q?N8ci1KRWqq5E+F3WRR5xpQsiIQanhninUQczB0rW0DnoEl8tao+HiwDHpXt7?=
 =?us-ascii?Q?3Yo2drxkcL4BM7R1/KoGayevAGpkQdrxycf4frBw9d+E3Cd+HQZPmoxCUjWR?=
 =?us-ascii?Q?ueQ1xxp2DuAYtX0KnXubvP5bnLxCVXMcZ83T5RmkLEceGz4eYRRmlstSR+3W?=
 =?us-ascii?Q?O+0/zB2AfgQPfRAKnh/o+bHOCRksPlDIZrx/5ja4Xmm7cnnH7gDgzSo/onqf?=
 =?us-ascii?Q?Ckf4QFStcEt15EyU02OXzPBixYYgM8zrEqKXk17lyD/5G4J573pmazIsq1zr?=
 =?us-ascii?Q?UBekAbczW3RTj4RxV7HrLoPkakPGTbhZyuxeLPc87Za/c5bMeHav0RqFAcku?=
 =?us-ascii?Q?2H0mIhaZuS704ZH6e7ifbMFHiR+7XxdoHRXPhvMAPpowmsqbD6NZahdbwH6H?=
 =?us-ascii?Q?z/e6HeeO5T+Ojvo7U9oRh39VD9gPeGYh7HZ9q0U3vneYsst3XZx/CH71IPg6?=
 =?us-ascii?Q?5BtxnCnORVbmPoXnudnpvff+AN7LMhHmfCX+wxITfT0DQ3HvPttNhL8UeqDf?=
 =?us-ascii?Q?abgcPvmo6VKp7lowbUNyD63cxYUbA0aRIDvxTIg0EuDRJprN0+Kf0TDOOE8n?=
 =?us-ascii?Q?3/MRivZ1wCj1W2VBUjvZZU4Ha3qOVsjFOVS+s1o2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9944c2-cb1a-426b-5fdc-08db7ed04d9a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:32.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rqMc2q0NfOfFshaMDHpC9CJg+jiT6ikIXbHT/GQLrKOAeJOJUS8dz+enBTi+td47ZuRK2MipRTGgTjCDJZG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 21c20793e517..d1a35da7e824 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -530,8 +530,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	tegra->pdev = pdev;
 	tegra->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
 
-- 
2.39.0

