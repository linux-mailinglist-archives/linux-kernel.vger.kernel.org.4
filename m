Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C392747D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGEGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGEGyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0C1718;
        Tue,  4 Jul 2023 23:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bvx0dfjtN4m5BxSaQJYVGTnuv3ipGHMo1TBmErXsNoIsXuTuYkhYwhAkIxJMtIsb6reSvbsE+j9xFt27A9mFFkcGGe/V08H7XaMxJP53c7VG6tLEc2RL8I3bvQa6cK63x4b94rz/8bGb/5Tytz8SWW5bdAW84YpRo9TCM2UcC81OzjvcjmzRE1XpFBbqeAkVeP3qbixL7cdkJymrwarGrWXneSiqoxznNckuAZfiYQ3c3an7kWd6gWUUcAMp3vkt/GpoEDzejCK5TE9E225jLFrP+M4pBtj2Oi2Os5JEyRQ26njLXO/7jgXLV9pW+XHPsQ+R6pZZxWvHXKV9B3lexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cyW5FXJNG/iFIhqwS8xH93Qnj1S+dc3x+b8fe8oH70=;
 b=BsG6UbMEhI2cvFNkuSYsmj1IpH2yQqDAwS+RIEq3AdJrgkGyu73RxIj6H1NDo+zHSUkQtSSUfvx06g9JtGZWOYdSVaMA7rFxOh1HdOpybBYbqsgBABPwTMkkoogj2QcMK1mD2GticH4awk8mHzaIKVr2BjjKOsk9fP7LOsGpNn4NojfH1hc/22aCVeCi+dWhTKBIZ0C9XCpcmig5M3h2ZV2k+tTQmvJtI5mx7R1ClTJQ/wHDeFU58mdMj+A3r/FQa1ZAUU4iXRADEDhXrnoSIIKJ5HETzJ7B0K1F20kLxK90lB03e7JiVSySIzxl1gHHz4I/WTsdiPUFWxtK1v9Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cyW5FXJNG/iFIhqwS8xH93Qnj1S+dc3x+b8fe8oH70=;
 b=OiXT49Ahi73nS1tZ+UsG+TtHZyPW6kpSh3uRmbqaXHDWUch9J3joMFUasP0i7WCtd3vOf0zx3TfM8mdSYThBUOWiuBPAnTiIoZvnepcHf6U5i2fqkejBl60yIAGfAPx+BaNF6BjW0Y1v2ukoqJqsiHdboa+wsN/JdoC/F8rHHP7kj20X8UY98lTN5hmru2KAy5UpIDQmOHw813FHKZOcS7SfKQK5cmEdlEAR9ZUa+lNjr1RiKEnaRaKUP2cbS9HBI2KPXdrD2WLjAXWiE4vvQ8ZS9JwKHnqP1ivjIU+tG0sNCaAY/sNn3euC8sE8zP1iG+teh3AzNDD/EOCt5wsF4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] clk: hsdk-pll: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:07 +0800
Message-Id: <20230705065313.67043-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe479f3-2e29-4721-9265-08db7d248ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQSyH6NoCC1mrVY3bNA3qR5F5jGdktbrv1pbbHCShWE1CBm4dznuwrweh2MGFV2IisISvdfiG6t+WhT6MQogVV1Cgsm2L2BLEKYBVJDo9HxyARkzB/ojwdREjUlUUJWQVdqdYGlNYc/imMjOBdzNw+kBV6ndieJu0YGysCFZpwpV/NCHzRSmMBmZlzb/BwphyKu1ft04cB52CTpP5Cu6sMwmDqiS9WZa98mdcULoOI5c4/arbJ4i91QkOz8TArjAYnGU5hu9V5WYOWBA6N82XaQ7DxXMxci4v+K9Zx+A00EFwb9nK0e8FdyW9wJuE9NvumBYCELqnN/CC8OA4PvvcCGGlvv7Y4rJ+4a1WUbzDKemlq/jfojkIhcd71XCj+EGWIYTtkuqZRlgsmgJ9JPxTxRZ0Wai/vghkXhlXiDvsxCcqIJsPH7hp1VoMU5Ic+lbcu/NnTj2yUqKj/det/clV5BOQK05xlHxZ2HiCZEtSLGUGT1f1PPbhgunXI7LXFifJ/bL6vr1KiTdKuA9d3UZM0j/KLf8OHYklhlfq7kWoTbgVN2gsdKZyxGmHnmjaiuF7QPAfwZfvzmqlFpGWi3MeoUtDUWpKRwMC/UFpKIOkHORIlQmNaXeGUxffylRu3yA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YC4UFYr4MqDgDh712bFnbm5x0LZRqYHjzivg2a7aNdmu6/QvoaHi1M+9ljPL?=
 =?us-ascii?Q?TLfMr3Q52VKirn/lKyUIuJk7n3aJhhtISHakkOWKkX9L42JvjWqyoZnSxeR4?=
 =?us-ascii?Q?xEnGPPT+NOCVP1BuVESNnqdJeOA2WnNQes9DuF7Epr9pD8PkcN+gEyZUwbGN?=
 =?us-ascii?Q?4YNOo7gNbLRLo8oCERVOcLFtzKc8SRN7x9l1VHkbuTFPt2MHI/qD/3p8yAbx?=
 =?us-ascii?Q?ynnMU1/vvpzmbaHAIKZvab+lLJolsOLgnxuRmMhw9qZKngAmV1IV1nSihCl0?=
 =?us-ascii?Q?5m5qPf2StjboYEO4yIwPoN5a2cBtBwqO5tLi+iUDUu2jJay+gXzMcblKp+25?=
 =?us-ascii?Q?/JUQAINE5k0uWX4RmxLx5UZ9WgwpinNRrITjA16Qr/KuHe3CO8/8N2QWr6FX?=
 =?us-ascii?Q?dgI7jNmOTjtEU6Mn2deK2FqUSu+SInZxe+tUpn2xn1WRGk+A3U/mM8tPEadB?=
 =?us-ascii?Q?TLwcxkpOd3ba7RA9E7KWlc+9jvP0tk+C5AGsfCw/1DVNpPpp8ACnkrUrUSG8?=
 =?us-ascii?Q?Zxzvk4aYQ1uPP2ao5vwzMow/hUfgXvHKHqKgsLWY04RvRk7BtF0yOj2orUIg?=
 =?us-ascii?Q?5RGufsuk//+vjq5+jZjhBD/fsWOoWdxLZrAsc5esY9UxRu+7+J5gwc2pohiR?=
 =?us-ascii?Q?z1j5GNKg50ae3sux0O1+lbszQhgq6NhUbBsmUWQKmOJDHqenGZXHTDzf/H2y?=
 =?us-ascii?Q?30X2aJRSIq+M7kBKLCN8nlmzHrLyb5NkwjuNKW0NT5NFNA9uxtEoxsRGpAo9?=
 =?us-ascii?Q?4Lb6KdUbE7DtptFPd2W5exFCmIVSTjGlcIySkddIt+gePCP+i/rlnVSNu1/e?=
 =?us-ascii?Q?/fjLc7wNgHEa+ll9PGBguAJii9pWCQXZb3Pav0SgCTFwtmlObQT1JvExYYXE?=
 =?us-ascii?Q?vKa4iPmmYlJ38Ni+u/A8T3yoALv8H3JTRmYZmsNxVKtozFDxRErq9dlhl3z4?=
 =?us-ascii?Q?j8Cq6PoDAdU504GOr78IDp4A5G73gwDUerIIVEXR8b/4Yd0aDbUhOIg8DTCm?=
 =?us-ascii?Q?/In+eAMzSh5uGDqvvPPxLP2az14uaaeEFLliKPJa2y+Qr6JlnfjieLsv88FM?=
 =?us-ascii?Q?5NKowKhaxcY5hPExIvw1LfkgAAX7++vzRBgpfCKfZtCIAmHHkwLxbjwGknmD?=
 =?us-ascii?Q?CSYHfek/ERFIyz6TbxNnBsSZcc1EB+bYjvZ4Ki6FhQi+QNanU7rylT/nFQQp?=
 =?us-ascii?Q?i9qKUHnqVQEiv/4zH2X3uuK4jpiJos4+EpFrpveK4KhutTvANnJcdyHM62D9?=
 =?us-ascii?Q?J+EBrp2ywjMCQ+xeKxwevDTcm3eIMwdfuTcA1bG8NBFARlPXq93BzxfE15ZD?=
 =?us-ascii?Q?Uz6YSrU+0H3CCpl/Fy/oqmKzH6/SOo8iAI2EWV54pVUUorthuSFJTSbtCd99?=
 =?us-ascii?Q?kEdwhmLl8sI4M28p8gl/5SDHKEsmlz3QTkt6ESqLgEPyvBnU3OqjWZYqDphE?=
 =?us-ascii?Q?UDvGhHApOOF6a4zH9eHB9Qu/dTB3+czj64e2isLVdbcq4yKZ3Uc2fvpqk7mO?=
 =?us-ascii?Q?JB1KrsMGVPiDNENpfw3QfoMlQyBoWTL4VR9tYK2CBkARX4qrxn0RXb4o7fxZ?=
 =?us-ascii?Q?Bo9Tixy9bxHbiqdYLSRKA0lsO0yAw63EDlkZqlBn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe479f3-2e29-4721-9265-08db7d248ef5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:37.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjo9h+NDTEwjOfCKXDiP6MMyAYwPuA/+puc9TM2zzV50GKUn+7UJD5hXvl9Q86QFVxxen8hlOQG2RX5egVlcvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
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
 drivers/clk/clk-hsdk-pll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index 33b48ea5ea3d..860519152e5e 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -304,7 +304,6 @@ static const struct clk_ops hsdk_pll_ops = {
 static int hsdk_pll_clk_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct resource *mem;
 	const char *parent_name;
 	unsigned int num_parents;
 	struct hsdk_pll_clk *pll_clk;
@@ -315,8 +314,7 @@ static int hsdk_pll_clk_probe(struct platform_device *pdev)
 	if (!pll_clk)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pll_clk->regs = devm_ioremap_resource(dev, mem);
+	pll_clk->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pll_clk->regs))
 		return PTR_ERR(pll_clk->regs);
 
-- 
2.39.0

