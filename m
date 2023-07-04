Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70C974704D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGDMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA89185
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLDcFx6by+VFhhQOK/0ooZu4ezNj+PuXjOXF8j4w8QM+8x1VhUN71qFTVi+7bD1uYXzYviS6meVmJEl6vE/K2Zmxz+V7YbzHNhd95GgXP5tRBPBoKW7dhB/4D/wbLiPg8bsmF7AY6gfrug2ZmogdD6Y3oyzC1yb7ibdrd9r5geC+QJjfUoITPewVHVgurofVCFf1jwyz0wquJq8s7ir0HhjBkXCZI8LmDpUcDZvwcWr9kB2zBfaQDNoyXzqJCfENCh0P/LigG1SS/FmdCMxy//79yhX22l2VZCO0VLeKJQ/l4yxYD0nz4LoGOEO0WSDy4mvBFFmfQDxpwRzOlSeUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4qH/EEc772Hh1Fa91uEXK3Fyy2YZ1pkJB/En7fGXK0=;
 b=P8/UddceVDRf00hNco1Ug8urBi3e/w3HhuYJ+vFxfQNDq7PZtWN4SKiiA3mYByENc1Q96NU5FrjCimWmw+qwohR+XFc0WKKYnys1/B70F6vZfZr7TlZdSlVifJSatUTLqA/Rkly5BtJft0eJn/WKjfSTkXx+zrEKROKyeSB8l4EVBBICa/gfJTK+n7Quds7MnXG2II5QxpRKkuIW2sqF3lIec6Q91UFZOcdTYQlUmxjmioLdQATRwKVm/2A2PsPiwn2WEz6SmiaXuwkVr+bnjxefxvzrlDUFrqvBFfW5XFf9Vmys67z4MKXRcQdnj1fLOQEkCeU4zKTzQMaeZ7A9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4qH/EEc772Hh1Fa91uEXK3Fyy2YZ1pkJB/En7fGXK0=;
 b=h/zvBnwnsOfS54rwfKR6aLW6KtbluhT1W+j1dGK1+TRg0tlY+Y5agLyvIqVTEvu7OM46O6PElBT4agyOg06C3Bw34D4nYaREe2CxPBFGPPZJO67HppNkBpKOupksgW0lvyXHE0z4aihk9Nblh4gOnTHatHB7gtWHOoyXNrH/JQHwGyP+Rui1PfLfFv1dzlQeO5lycBG8A7NPzIcoI0xzVQKmF9k1/bStnsdlrs5GtM3hXUbep7FbAYrASN3kpKIUwQEoepMJoJsiBLlO8j+sV05L6EIbgVFwPX3496ri5Kk45VH9tb+eDIytb8qoCtvXQ+y2Vodv6YDtPkYfVk9V4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB4999.apcprd06.prod.outlook.com (2603:1096:101:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] reset: brcmstb: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:05 +0800
Message-Id: <20230704120211.38122-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c64e55f-a4eb-447a-7054-08db7c86867e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYGGy/o9kuWkNCWDNO+bEYmpadWG5oNTqhyNimMXDvnuhQRxbdcUbH1sUMZJQVb+dzekXoME0RQaj3JJzE6Xf/JAZpZja3/EtOyi3olYdZ5DEkvGYu3yRLiQxk87s1KAIJaDCLspw2/2JwJnVvUuuPMzGmqtd+pvKdgCZ0+3TzbmP2uuJp4HwvR/P85/hiED3KtSZt4Ew9bqvdn3PUDzU54whflS53iwyvHyVL8eeAxqhPPIf5Ca97ZwjE7zh6bfndyDHROaCTJEO7NS5QtvaGI99L7zuTOwjBXo5s61y9EWgt81FfO684+GeG/OPX5Z3nOGeUHFi398ueTQAOVcvOCcjFafm/umMBYkZSbu52/5U7X31I7M5wrJeYUnMs/U8VWh72nQXAm6j7EwoI8pqBgiVlafk2JYRZ4aKsqrdaXzk6iqovKEuPjEWMrua27dO00aQyePfw3x3oMvBmsWY81Ho3e2uwYaydyReJiKJATkBvOBTy8Keq88LOBQ3FhjfRnkgVCiyr/s5AtRa309PUEQmC9nfBICsKi1LNSeEcXIszleqWAI55bv9+SBKXXo1CLLr1uMCat41MshpsYnEN2/8MPDmL5VCVc5NAyGGk6HeXcOYzBGi7IlbBj4sjTtvgzWZ6pSOkSHTzQ70TrX0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(6666004)(38100700002)(52116002)(38350700002)(2906002)(4744005)(6486002)(8936002)(110136005)(8676002)(36756003)(41300700001)(478600001)(5660300002)(66946007)(66476007)(1076003)(6512007)(186003)(26005)(86362001)(6506007)(66556008)(316002)(4326008)(2616005)(83380400001)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6AcaqFYe++UKEMzY1r23Ch6dVUfgmknH4xdO7MFVv8AbaygdHbvJ8hX+zeGN?=
 =?us-ascii?Q?KDez9uZTMpknsbfmKeDzbYQeyzlQSnc3ZXccjs+XuVrh5zON2ogN7slFfh8c?=
 =?us-ascii?Q?nYPlXhqdPSZG0PUai7ViXAvGsmzsb4kRlGoiK3hjAViCozQ0wVOS+6cPbxON?=
 =?us-ascii?Q?JZLZHRVnRCnbC/RlfmaN+UA+h8/jbcYhrrZQ136wQbaxU4MNvf9B6ki44DOn?=
 =?us-ascii?Q?Lt+D1yAs8jvZIhFFrDQyXx9r96k6XuoWzokR4Hc9EphlCk31+ys4/oy4tSDg?=
 =?us-ascii?Q?sqj7OJIRiOHoHtXxhW6WtlRR68IyxdHJCabZ1q6KHKleckEP7vF3lcG3VdpR?=
 =?us-ascii?Q?zjlVp09GMJ9TuxeY9uHNVVhXMpa5v6FkucyqNIdSC2RacUWP2shmmDvUVl+n?=
 =?us-ascii?Q?uOjYGsXxwfZc2ZpfPoIRka8LXUGDcdnSykCM3wc3ZtDTHcXyH975S7jMQ/sR?=
 =?us-ascii?Q?hIIpdD7KYUwaZMyBOIxfGWbFZSZ2wkVos9MgxOAnAayh22LfL5jWnasHJAQJ?=
 =?us-ascii?Q?opZStAvKs8qsSQ+pTERbPO6MPgjxUyOwFvy4EwIwdJIIuzCgbYFm332KwDIL?=
 =?us-ascii?Q?bxvLZ+j//cluGFNlOeF1RUlYPjdFyOuYETRbmDY5R4rPqsHUiNkU9cdiOQTQ?=
 =?us-ascii?Q?2WDpctmQrGR7AkPTjH/kneFjM6WV2W0FrYUUwaSmbUK9QIG8y1bDJUvFaYU/?=
 =?us-ascii?Q?jtuJpAESmlP8IcdEvpLRe1hkrjYgYb6ZU5vwBnI3RvZx2Qm64PCxD8yKVomh?=
 =?us-ascii?Q?KTFBwW5T3OpY9s+7f2MCVUlGR3Y1/2wftP1CarD54OF9m/Iy56S9G+M5Rcj+?=
 =?us-ascii?Q?uzToBWex3p6brKQoZGFRAmAZLl1WMuBvt4rDNc3AhWKEq78yVspeQwa0xINv?=
 =?us-ascii?Q?UlkfzdaloUc5e2vFqH2TfbzRus48KU92eG1xDuxqZa0OERE2okM+Aa0YDUfb?=
 =?us-ascii?Q?oi5L/vKPffP3+1yeThBo6ROO+lE38YQPnWwxvhGA3ecUzxRSUZV86mNDVV2e?=
 =?us-ascii?Q?R1QdXerY3+K5buSRNT9hBrIuetR8dnYtMg8KSxvRHJBc45xIdfsmjEN9dwMb?=
 =?us-ascii?Q?bnxnv4ShFP03buTbnSj0Fdex0ryOqGD24q7T5SkVy6YxIryE2L7MQklbJUBd?=
 =?us-ascii?Q?TRsSzVOkG9kkuoJsy6bV6uqgWYaaTHel5Yks390nLetxfR2ECBEPDNoC4Pzi?=
 =?us-ascii?Q?SvSMpGTusf2ZZJFvreD98FMtj272meo0xVDV8WCcG30zRCr9pBxNj7++6WgP?=
 =?us-ascii?Q?+0gV1htFhRNR1YiDz3BwQFCSON4EMn9WB2C1KZPCkRyYyoYDA+hL3rLlIQuq?=
 =?us-ascii?Q?aO3AiP2Sg2FJnXtfTlEFHu3tnz/pV6Xiy3eeVTKq1M1JghTczguDlG75qPRb?=
 =?us-ascii?Q?2yxH9jOWDNfgq+5ZpcKR7Pa8QcFeUhzXHHjG6AJaJtfQ28yUArBn6VSEICUX?=
 =?us-ascii?Q?ituqIVI3nWa1fd+NSaqhUialfD5MSnta2nQnyX0m7f6AY9l87dPlpz1fLs9l?=
 =?us-ascii?Q?eZglhkBIjkT2Fniq4gHG6/qdxfRYfAFJdxt+SzrX6bwU31/c65KcT1iFmTcn?=
 =?us-ascii?Q?IW2f1GQRIObMb0McIW5wwcmCu8PashZuc8faDOQo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c64e55f-a4eb-447a-7054-08db7c86867e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:22.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnKDMymO2nXKNzI/RVAxHfv3uFO34dFUaJk5jLZr32ODoFj1pqMeyVovml6OW1N2a8r50I6ZBgMhiElYqe/BwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/reset/reset-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index 42c9d5241c53..810fe76452d6 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -90,8 +90,7 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(kdev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.39.0

