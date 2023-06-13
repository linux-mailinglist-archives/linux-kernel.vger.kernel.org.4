Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372E272DE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjFMJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242031AbjFMJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:58:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA471BE7;
        Tue, 13 Jun 2023 02:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF5inGOzeggYc/yeLkpbpE5ioXhoDeK+jraVyU/v2Q/B32alU+c6diqQ46W+shNMcyd2rbe/tUFWCcBrcLZz0wDNQiducNbJOO4JEND02CjPlJzbyktt4EzfWfsgnoM90dGp089JCesQx78YGv/qjZFkOe2gnz/M0eChbUJ/+9zWjKTVXLre1a2QhtHMkIlaLX2XUHfsfL+Ps5uLf60SHJCgLPp/CnV4wcAuQaTrYHdVC2h6MmNTO7SbB6+AF2pTSO97kxi475P9wL9jQ/ZR0vlcfhYuDQox3shHH763c3qMAy1GcJCCJpsKyPPtzbEq32o5gHkV6EYXbCREaH0gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=KVowd4hFZRTmAXFhj5rjQ+HRmST9qGivWh6gRoBZhzmXVaOdXSq6MoU1u/9j2QcPn6dc7Q9CmVqp1SBAw6ptuo7hhTJpjT/9mMFwzsz6SW/7pxJ4J1L4t1a0LKCubnXMbzKeZ8duY3UaCnruPKw2ogsFkNiAc+MlybNtSqaFCnZwK60RmtfVMLfUKgCRN6YTGnVHdL5Q/RcWQgJUVo45jwzJtpALqef9ViquVcg26jE25bcUQdyRmEctLsnubZDFJhZAQVqrBgxBsX/DIsaQwGD1sIPuNohbRTgdaOrvXiCMCp/xe9lOSuRqurmnHmF/e/ZU2hSwyjbGfLX9Ft/tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgjRIFM7XXXA1ZiuM4luxgQMbyvfhlw0vWc2ywkdzrY=;
 b=enjQ6KTh5oqNB4pKilC6NSlY8XuoDWwThiiVOVwtBPwCoIa9sAmH1BBOTQJs9qi2Q7tLlnNBUkfsyqngOkAZp+bS19TsQCpaUFGM3IFgvJkUe2rqR3WVYKtSUbwvhCvvTH0sZ74oCJYOHIpLcoZ8n8pAXflC0lSTtMEw6NjkgW2YGsz9ZpGCbP0XKrjJsNSmPS9aC4hhv7aewajThKXyqezkh/v0SGGtW7DHABgA5ogjcG05XsPgV8t3zSerQ7bv4om8V2fbql/xKTw4/4Xftw67U32H6MyGXCesHpJmco5nMLhw7tKLLir6ShzNJWFRCmzwjB/ls6QIbRub8wp7QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 09:57:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:57:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [RESEND 5/9] drivers/thermal/k3: remove redundant msg in k3_bandgap_probe()
Date:   Tue, 13 Jun 2023 17:56:20 +0800
Message-Id: <20230613095624.78789-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613095624.78789-1-frank.li@vivo.com>
References: <20230613095624.78789-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f99ec5c-f51f-4db9-ecd9-08db6bf48c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ3QzG5rhAJ0ZHJ78PoHbF6nj9ht/8JXy7or3jAb33Uhrpp/NY6Vh22slPr2Amw0NlhkXTlnL3CuvlpAl3muI/+X9wFdGuHlU/gAdL7417rlq9jmTqdScnfIsy2SEL/kSzte/B1NcW6timisWN6P24iKPL93buuUu/AKX1QwmuA83Hk1jocuxpqhZu+RQCCFbYrjM/mEn5kLQDLI6pvYLUXn3aEubLL/MwxuPF5BamOJL1wrmm1DRfwtxaM7KyAWr15RZty7Kf4I6eIbN9QYKpB3X94tTddcyMuAp/D/UZj/47qg1/er0kfThP5aiCB020vDjuSvoxTm+PtOSMNs4jBqyIbhTff0XBjhuDg+ZmMdKvA827NnpoDIOc1MM1lmHYgUF+75HXjjwA0u/Y+UFc4ZGXRfEFBPPCFwK6gcweqsGNBeoroas0JUUhDqfxp1MGS5Cr6MIBTaI4wamzPDTqW1WRcZJVJg+fyoBF+0SjXvbNR0Ez9kUA4oWz8n6y3NFycv2cyi4sFgsZ0D8QPN/kToJheQqqlwlRfcB66FI21p+V1Qh5wOMaZroZnsFtR8glWb9NYNRTQ9X1AEQBfX01fAhlu8+ZWGw4GvcJaIyGUlqvLKSyvA6b3qF83PK34/kxP+6qZM9M21P89+NRhzaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(4326008)(8936002)(66556008)(316002)(7406005)(7416002)(66476007)(41300700001)(186003)(2906002)(66946007)(4744005)(478600001)(8676002)(5660300002)(6666004)(52116002)(6486002)(107886003)(1076003)(921005)(6506007)(6512007)(26005)(36756003)(83380400001)(86362001)(38100700002)(2616005)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foPhasOcUN0yPQqI1CiAOuxfbyb7HDttxQMlUNHaPrqGa9cYhTz2WYc43a3L?=
 =?us-ascii?Q?MlgXN5jnlAEdvCgNketnLZtQW7UqkLpUsa4on8kqR7XKbhTJlkmy/X7XBe74?=
 =?us-ascii?Q?3S6Xeq58vr5XNJRXsmjyKSZqHo7Gk0tcxyZbTkSJJJ//yGbq75Ivjwh/X1eo?=
 =?us-ascii?Q?R/jI661aWbMzcdJPEyKtTalYc54jDHGKyhaCi+QdLpJlL2YcaEmP7hS+ylQ3?=
 =?us-ascii?Q?7cNwrOk2e7inRz5F8xBSEM7ATn4iTjS8Vc440td78MGS5FGNKOeUPwzgs5b7?=
 =?us-ascii?Q?8YhUt+tFYvKlc9RhIaba6y539yYYhtufMSt/gKoTKgMLQbUDZihlL13b2EUE?=
 =?us-ascii?Q?IdY74jtdfgxGPGvgEDTt/ojA6PbzVFEsdJ7YOU+eM5lJ68LKnTnbV/3P7mRV?=
 =?us-ascii?Q?ZjVNtc25UNzpcifL2PqODkjbU1avPeCpCLR5R/wqljxnaSKfaOTCrj9gmwAx?=
 =?us-ascii?Q?ui/+9791lne/fq8ZZrscid0sGmAHpyxR+OlK8HJY0ayipB2pCRmOsreeddII?=
 =?us-ascii?Q?ziOnqQ5pe4frayinapLcTH6Fnmstcos9zUqvq+r0PhkFVO4RiZ3xiK5ey63f?=
 =?us-ascii?Q?eVpB8+ZPF/BhfDPOvbP1hlzdIujsEyuDl5PLlAdurBsejWDX24Fp+XfyOKqy?=
 =?us-ascii?Q?ock+ZoscY6kU+oRTuT6XtPSzUfcYf7wM829R7Jfeunfy+Zp1HA3pKDwdoO5O?=
 =?us-ascii?Q?NFOtiNqlvvhW7rVgdxa/ZpU8zCLSYjWV08KGKTOpaMbnPs8XRUP+FWiq44/3?=
 =?us-ascii?Q?evMvI3WMYaK7/BtbIJh9ZHJBmNfjA+RkG9401MqqKEPoWMLpia5OFvhMT3Cu?=
 =?us-ascii?Q?oJ1Gd+Uf3ZwBwlD+2jwCWqdRujavqauM8Smp+50OHjtHDKEZ3QSJGhCzl8Rg?=
 =?us-ascii?Q?G8OKZcgsggSM8+b8tL4/dvGaABg2RIoi2W1nGfxn71qzGDYr/K+2WzHiraFQ?=
 =?us-ascii?Q?GKW7rdvWFQBiN0QlmJeW2XDbV0y2fjAsdoN9nmAzVGqEI0d2/kWlQlAxuR9/?=
 =?us-ascii?Q?536NGyL+gq2fbjoszlie4Br83wr14V32AmjjLqvdztfADH2nv+y8P8+pLQdO?=
 =?us-ascii?Q?HiWcZI2UifpGqvixHf12gwRyGhu6Sd20HZQUtU8UUOTLhJYtgPh/T85feuh8?=
 =?us-ascii?Q?LdvTXPiO0gwfCskPJXvloy8E1S6anU1cx0P9IMuayKRt8jcMAqIwbOmcDtSj?=
 =?us-ascii?Q?VaQ3mu5SjgGIYbW+FDeHMcy0rOCvlAxxa2MKHr4w72OZsxjSbPdqSqsQKvub?=
 =?us-ascii?Q?1E3dYwYqcboEupX8xJ2axlmL5Dmr1mnKyAqmLqhQbu2LCxSd5g5ELFTVoNm+?=
 =?us-ascii?Q?NBCe8O5EDqttqMl/yytisW0/tG9bkiwsrXdc80TRbKKeG78JxUtCckPwSUcA?=
 =?us-ascii?Q?LMMaIIN5hrBcn/oXuNh9M6N/HQKcP6xlwtCt5OwVHM/JHZSE6l/Bp6xV9860?=
 =?us-ascii?Q?Ivdrk3C4c5AuYsbc9735WQGCROjOcsFH3N92bMVzuIr2GyHocPA/xv5RW2IH?=
 =?us-ascii?Q?IUHZ/cZC8znMZIZaoHdpQ/FzciOXl/bRkARrY5CIBQDQNlEP2raNFTAX3Lg4?=
 =?us-ascii?Q?qpIJXokoaP8VbRYCa8ixwPvvzlKT1IulrNCL0tPO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f99ec5c-f51f-4db9-ecd9-08db6bf48c5a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:57:07.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4mCyEthmO1fZs8G8MIWpaapAKi6ca4jfM8R+mzbJG2GZyLkq2VbwxIw6roFCZ2vaGIubFfwtgRqDmvG1WmsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
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

