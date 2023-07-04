Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25D674729B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjGDNUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjGDNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34310F5;
        Tue,  4 Jul 2023 06:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4686rG0kmNEiUv6oM/kcbqnacLPgJ49jUnWhxtMX3xQ40TtVHrysSHQzaaffbWaKZhmUR9qjAkDGFHKosPMb2J8IlL+XWfaYzwjLIm18mZGcxd/EftpzKRGgNKp2SULbCyl74K/ABpkckFrEYiAgnSUe3dbWu8dNA77I432EcYsOQXZZXFAFH3BgF/eR8+BTkT6NzWcqVFvzXFP6zX3ZjI9oadKExFtHUOH8mej5satMGkBQapPevVZKLE6pXA3VDeaBrHu7y2TKDUdRRqEK7jTvpHS3UXkWPBFSb3O88NbqRjDq3paZUj3w9O74NNegT6mbc/ublIhzpxaZlZ34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BLyFlcu+9o8COCZQ1tv5oRD+VsOX+UdYmPcWTunpMo=;
 b=Tn2SQsAOAkLZF6y/AklYhs7vYSLa2PVyvbiqpDsfeYMuviqD6uUA2FF8zAUCajFF8pY4sJx8sjBVXT7G9v8sR7SOMo8VzyvhPTimfSoss+izDnRs93wKovEVbWARny0GY+ckSwUycPNCbl3xewgQdaryFJyaElCtWuR91euFHVk3HSW5ABuU/ciHW1g16NRBc7I3LtV1RgnJwA/bmj9DMKL894qfmo+oKBoHLBQwOoB4UUixMDv6N30AactmsNQZLywh9KmsOFdnwHx5vVAk14GoQ5UL8+kbypAfvdaqqtFbl6TWYC2ssQKnr+yfI72CATRGYKN+PLNa6LnWsB3vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BLyFlcu+9o8COCZQ1tv5oRD+VsOX+UdYmPcWTunpMo=;
 b=F8R6qyX8F/n2DuesV+1Slamqpadu9/vhw4iM2SM7qSCwDiTUzSK8d1dF2idPvZrDpnq055ETJg+1x+T/wW2lG2xCwt0Lx9SThfZ0pyKC9ZKi6D4nYERnEvZ3+W9GIkLbRJCxI8WWfJKouCeUYMvnoQhE8ik3DS9ULzkG3ZJ/KVav+iifqE7S+MyzqTgIz6QT6+Bf9FXOngDdhp0C6TB7NhKQFKGZxehwx7GM1xtZ1PH5ynO71Hh5PEAXoVtL7o0r4JTmdw2cti/uuBb4LBVt/3JX5keXqPJwBM9B8GPsp/HV4CccgMxQ4++MuZ88HzDJ8PC/Ihwv3PGXEibWEzzbsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:19:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:19:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: omap_hsmmc: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:19:37 +0800
Message-Id: <20230704131939.22562-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704131939.22562-1-frank.li@vivo.com>
References: <20230704131939.22562-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: e1152ddc-3963-4f38-6ab9-08db7c9157e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0IfAwsRRaV1txh4en0Ac3V/lW5XXPPBzrnPPAfMjn+cVME3m+tqgyP9lr2nUVa/ygDTNeyttLV0fh2Z2KSJ8osenMeOvfgCXg9nxCAp+7W5+jz6OeANHJbaUzMDH4jnlTC8aigaRlFwPz7qoTz6255GSuGkRuLZpoqyZ/ZFY+P1j+ZjO9fxya/u6eheHOXtPzxQCTZvZERTor7luAKt/mK/ZZv3h2eUEpry45kTwUN3fI2OFrWKEQaCHr7VeUGTe4r8qKIGoiEX++1ngUSg682cKOw/anT1BCVzA+e3HRAPD1tRThk+EmBcy/b2nsBvsHtUio44wXaT0YLSIts6pm0IEnntonpBwNiUw3FL9DiATZRiaAUG9HNJQQrSaol6NDq0/7PsFixBsDlwV9Z5vP2ApmHY9lKTKuDva4kg8t7RVLxSkiz762i7sG99287M1uiODFLq9kVjRuEbu7hKNknb1f38nm4bkiE/3XSPG9U2zc1VRoMHSvItpIaGj4LjypReCwWQvgvEymWIDPaEsYxm0wRAmOX2cQwuwPHDBdGh4SIUnYpYnM7ZsSwbMGVxQgRx0hnTahdDPPT7ZnfN3BwT7aDaWSSBqO6KWPT59JCcY+vOOt1UUbGWThnsGXLA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39850400004)(451199021)(2906002)(4744005)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(36756003)(52116002)(8936002)(8676002)(5660300002)(316002)(6512007)(66556008)(66476007)(66946007)(4326008)(38100700002)(6916009)(38350700002)(6506007)(1076003)(2616005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Npw/c2F2Nkonpu0GdrXH0+wwAa9rIrbPBPrINVrcw9mrFV7y8+8ONkbMsh2u?=
 =?us-ascii?Q?LS7bk66d4m3B144YMOgBWY9bLEkPV4Ds718PmvAET/CanVkSeA5SNlEF/d/1?=
 =?us-ascii?Q?K4FPP3MZPQK5aRAfIW/hVK/NWTktB0jksrfDZBfaSloga5p0qbiwNgm0CA7u?=
 =?us-ascii?Q?g3baVxIaPWbFozG9Z8m6OxWtNZwz+7YML2ohD0w7ihQhKiv5o4D2NJAtsgw4?=
 =?us-ascii?Q?/hPWjE+Eou/nZchGIAIa453NT/IzAcOWA6zOI5y3vFWWx7VwQXpyEj+TG9Fx?=
 =?us-ascii?Q?7j04sYeF6vjXgTfpz4ggIzatW+b9KW8zMmaJfAaVMijbzaD1VvLObRw7ZZim?=
 =?us-ascii?Q?NY+EyZYNsqHQZPTy1EuIvo/fVBDLgdwcGBZitwFSxzBIkD6sbkvJ6kkxVdXl?=
 =?us-ascii?Q?0hfMlB27c2Un62xpwsVfWXQvjMSytEikKlE+7+FQUXO6fr0unf6NMYDDwbev?=
 =?us-ascii?Q?iALomqxEoElIlSlec4WcWPwsdY3sdvfDg2oVF1Y6ATLcTs5skpZ/1/CL8wND?=
 =?us-ascii?Q?jKYz5uGxdJu1oMd7YcteKLIhyE2+PBmGEz86djMEoldXjuGApe/eVx4od19c?=
 =?us-ascii?Q?iAPdS6me/nzMrVWQ1979akGDF7vMu7/SjRqAvS49KvpqtLUzcW9d0ego3rfq?=
 =?us-ascii?Q?Jq35uQlqpZQ6OGUA95JccPoIzoFs8mInVZqBW3fmJWgVW/7mqdyJixVfoWzq?=
 =?us-ascii?Q?e9jaGmzUoEEr+0PU1jwRcJdsyil7d5UFoW714DrX9A/n12r7FYsHWib7jqli?=
 =?us-ascii?Q?DOdLZLGnXdS3KcB/xh9CvfyzJ4bcS3TXWIDWLjaOlOdeqXg7dIzEzk2HB8OU?=
 =?us-ascii?Q?yE9kfzmO38qpAr5E3M2M3ieDwOw2aglBk7FB7hdhCnff2oTjFx+HdsDszysd?=
 =?us-ascii?Q?G0u7x0jUJc41gSEtJeZY7lFL9tNnQyr3VlA1XiqcuqrfnVs1QI27B+gcx4Mi?=
 =?us-ascii?Q?wsk0OL7TD5+wzVrEq6meQ+Syx0870MbaQ29MHEN/m+Evk/iCAobVzdGKvRDP?=
 =?us-ascii?Q?BBIPG7bAqKxpFUHnV0ujITOxiJwzua9oBY+g/ThhtDOQLX+EFP7NyrkRf+F0?=
 =?us-ascii?Q?roXmxBKRo2rl337Q33XMzSiKbRHwVoBkCMSmhYyHLHckoHCW55vOMg+HaeTe?=
 =?us-ascii?Q?Zt1hg0yDMWWC8bw/ZToWYQD2admhLuG792FEaPKgImk7IGrQiJJGf8ED4R9F?=
 =?us-ascii?Q?XidM09jKiklYzizsDhmmC0vNuWxQA7Qd/I0kvINSYQTX+sAwHK2DfBpzPLfZ?=
 =?us-ascii?Q?HXL9+cY+wRBfyZ9ppxpmaw98UPFBjrpc1aq+MR59hHmS+8DsODmM3oN54+Y0?=
 =?us-ascii?Q?mRhIYfqEgYfDSuRLMBzbBdZ9xB2A+x5ttkqZRmZ7uzeRyKLllWyX4SUQnuWT?=
 =?us-ascii?Q?vKW2ALbO1vGy53zBZXG0FvSXRMKkB3kMy5LdnkykrfxFN0QFoECgqpdKluxc?=
 =?us-ascii?Q?zFlLsY7JnJf0n/RkFsRAkFcDnU3RbWm+EBGwD43tTX3EwdSc3xSP8kbUb9ti?=
 =?us-ascii?Q?5JtU8XC8u74yHfBJkmy9EnLrkLARyrPsbKZVVhVlnKEwhoDV91Vz5tnZkX4X?=
 =?us-ascii?Q?XsulFnbuwvczSEwViI7ZUkK0I4sQD4BvzJEvB5ep?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1152ddc-3963-4f38-6ab9-08db7c9157e2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:19:49.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzRYVE8zSLBnGxO8pxyZcb+wYUUOh9CFBdQcjwLZP+BmF0O6OwAEu7egfCypcn6ckjMspEYT91c+8AJGjgJ7yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/omap_hsmmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1e0f2d7774bd..93de00a06aba 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1790,14 +1790,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENXIO;
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

