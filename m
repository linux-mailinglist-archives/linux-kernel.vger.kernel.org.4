Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB474AE44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjGGJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjGGJze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38D2105;
        Fri,  7 Jul 2023 02:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED9ySqh4FU/2gMiq/1sIMmhre5hBoY+qDp0CmHvAulQJQTW3F4CK9kEMWv7maahOLLnw2+10blbJ9BY5dxVKJUlCtepNaFUq1M9uwBvTnR5lktdxvQyQFVBKgs941aE+ZGAV0/CKi5J+MK+0uNvI/sRXVW0vdI9CJ6rnSEV6c5cGZBsDXY+tGi0izbyXZUcYduO7YiDTbtnz91j9QVLHWJUALAOKNWCt7j/G8yJ/3gsSk/4AqENP+RyuZWSJwOIxfcCBQB01xnFlsm+kIiqxmcon/c8MZQzNsaV5Re/hj74Net/fcg8YXKhyMbjpxPR3jnAR/fAg0B0JIOBqdKfwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clT28NDDnXG0lYtow9Jcn0FNxd+1sybluxxuiLZdlc4=;
 b=DwYAc7tjgXnNMA9tGasCHney6zOaf6i9xm1CT0u/GQ+86dY3StoTu3o0fnRxX37XrXUz7mfR3DNUazs0Gmu+C1ohLoiZdRrbCeV6fFy1omY8E7Q2eOgzpTP+Qjp5UpgVQJgZ70YU82XrYQLo32CMyFRCuTUH9USuT4jqp3lN0ouyrHBvriO2NaDOwOcZBIRoX4Hp1SwENx0NxRr/VgWlBMn3LX1eJleR8mfRGvOE7z9y3N70+aJBDXOT+4jHQnNjLrm5thZR9i/TxIHgmZbHKHf81htNyQb2sg6pi4rk7gO/d/GVCjG3VDsGP1Due8P2DEqTrAp0T9RtA8RLiQuTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clT28NDDnXG0lYtow9Jcn0FNxd+1sybluxxuiLZdlc4=;
 b=AOU1yxGPbg97ZH4E29tbNY60nThb3IEH/AY+k2xlXRKkUZaPSHzYOQzHUZ4NEY+eU9IXYGzGZ1EKiNPaHulLb/8aimsNm+rh79zUhgneA3tsWkGFpQis7c4Q9hgjY3oSssrMmvz8yM92WyZ2DQPLYsDIgyA/8n6v9hrCJHmXbReVxu3hsrnfP3jBwir56p/fbzEuJQX64ev5BKYaBzg3OIcoGHX0Z3FLTf5dzSglQsHrhsGnO4bXujJgRipveFFUrCER7Qcm0jzGQxhJlPS6gM0oJ/y4NvDAGOpc/mRu6T6mJ5yMAJa1m2CSJhqWwnuKNLwrY8aPhWe1L+JPKT4X9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] ata: ahci_octeon: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:03 +0800
Message-Id: <20230707095513.64224-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c0216a-f71d-4522-d2df-08db7ed04a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rz9SkEscwIrR/DDOftDFaWTkw/IAD4KaBGaiyDtDjU8r7S8s8lUgB9pTIsl31sydhCRKVZHmuFRJwA7tVM2AeJcze6cz7hNsnhktfunj21dTFsVvyonWNw27PONUddf2wpaniofNJyVSH1+uY1ejD3XB+MyQO0efNVDEFdCPS7GOurKJsXNbf3Gum/BKWqjlD1srUo+J9BU/ezStQM4n972zEd2KD1WGk/0FYINbHKrVEwLtpj/a/HUhTAlNIqmYkMgBXBJhtR2CWwDvlgFttIZMyUkDkX3zN1xVA3NrTgCMkBUNPN8UCEkSMw6DMP9H/gc2eqadzRwHZHS/xfS8psUJcjECV/PSUEy8L4Tr43kR5jS8JNG/pM3LLthSRhfDb7SppXZZdMO9IaETxhoWVGouOv1D+QYQIt6RynBH21mivQbvVJuVX0B/PrzY90ztsDWi23Ycv/1SuaDQYOpFrOMRk/fOcqnsg2dYA0E4N+dDGt1cLSJUcmexZ/24lmvcsLKuZ8FWvOK82Xp7ecJKKbFVWy4E6tazKMrGQcocAH5himd5oZGYnqbkaqtFhnX78K5hiQm6MzPbHfC8U2qOm9IhNlNXIjq/s432lfwovi8iIZP+hKKKvKTEhQyn06gM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(6916009)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(4744005)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wk15DWVsDubNBIF2fPeEO6bOr5jTF66A+SquM6TgAR4bxMfRG+GnLtFE0ZFd?=
 =?us-ascii?Q?RmSLC8ZaLgI/XsBzQhsXY4Vqalu0lFCf2Qedrs9wOWP3a1o2KiFnfX8LwoNg?=
 =?us-ascii?Q?4pJnlp7sieEO1aDyxDMI1DRAfJgyEQaGb+qwqNq79/w0MX/Gv+0k+BN2ttSs?=
 =?us-ascii?Q?40Fj+7cr6GIEgulSQ4XGjsU2q9MVTRsaurTvDfEjgcJ9N/FRws+QABtFWNPq?=
 =?us-ascii?Q?2ce+I6IZ5DsmWP+jmV656FE4FgP/yF5UHDbmWo2mYKKWx1lYhYh22pR40C6x?=
 =?us-ascii?Q?iWj2wXB0sKapghowJGKIcQG6mRKWeoRtBCgvRqqrKBEDvKgYfpBGA+VuB4Zy?=
 =?us-ascii?Q?GeiQWJSUeexGy91rDR/q3Be0BMXCKbxHwF3o6qtR6nin3EuSGrQw9JfeWwA9?=
 =?us-ascii?Q?D2MwUkTrmJo5ALtf4djkFILJIgt1aKXDozlr5+2z02C4aYlHnQc7LopeiSas?=
 =?us-ascii?Q?8Bnpz2Hkz5e68ICf/He70z3L3KPMIS96CSXortW5Zw0aAJMeNizLA+Fq35Iz?=
 =?us-ascii?Q?fIBscmzEbZSpr6LUK83yyyNqzCYi0b3Ie2T/RcRrz03XZ2WwijD99rzFg7mb?=
 =?us-ascii?Q?ju2olUAdy1U+4+kbAKPJiINkzMWx6RC3XuYQReTWqWHePxqyhOvtgagQjw1v?=
 =?us-ascii?Q?gPgqsZ3G1rKcyjTIHqyRwdJwTnP590Ps8AbmK+ykOWixmZPdHpyhr7X5LWCq?=
 =?us-ascii?Q?H+jVvWj3TE4bh04kr2fydwrdXpNPDko1gj4WKYIYX8RMx+xMOh3qPuGz0G5C?=
 =?us-ascii?Q?nx9pFlc0pNCq9kmlcIVRczLhrfKHo1Tr8do+TZU6McS0ie3X9sUEugwBaLx4?=
 =?us-ascii?Q?saZ2HC8IS/EzBMbGRkFpz91UARsa6oVpdGVsaGIM57UadUIg2Ja1Jb1nbgYl?=
 =?us-ascii?Q?VdmRN5+p67izs6uGGdtbCRNcAQcsfs7VXVfXlUkWODRYv1/r5P0SW40guFfi?=
 =?us-ascii?Q?t6E9Jw6pC1ZBeJ0Md3leqP6af/6l9j6wmysM5z/wbgYGgREw4qH+EmMtDimJ?=
 =?us-ascii?Q?pJ29zjgUCD1z+ln+x1kQ84Y3laqrvOaN5fmDdy9Dr6Sw6BZmvmr/1PO+2Dsp?=
 =?us-ascii?Q?HkfGoQk3i7Ol/uDqLvJpMrlQ/m67a9UmXz8cSkLk8kXjpCDyPmcGpGZTXiR6?=
 =?us-ascii?Q?MG+NHgMc+i69ILl1gt+Dnxhtp3gIVGEMmYldn8Cng6Lx+7+d+dJncsVLME7t?=
 =?us-ascii?Q?c0SQ6fCFrSZNWnNmz05KNdQqyAzZWMhJDFfcpy1o8HIufpSvHceIAjZqYrjE?=
 =?us-ascii?Q?lH75dUOHeiMzUAOA68qlXFS3tvbiyXc4koNrE6RaCFLFNPYua0aUCztlgoqk?=
 =?us-ascii?Q?DDYsV8w3FkduyQ6cvJDh7DcYhI+xLvVnkowynCLkw/Uqj3YxTy2iio0tWxwQ?=
 =?us-ascii?Q?f5ws1DQPGdSO2JAi8ANbphgLQoqS3+rNzlNflU7FvbaFba0HVb8GAyAHptda?=
 =?us-ascii?Q?OW2pze8DAzAJBKTexBG4/Bm2hHOjaA6HqVXjorP4dHH3qG27eNdCcidEt1m8?=
 =?us-ascii?Q?ACm5H4GNK/jpKe2xkyxklXBGmn1v6JZD/CBX37QKBn1HtwNHB6eDx/+T5i1f?=
 =?us-ascii?Q?siMbLUhVZIyozDhY/mNOqnnstzDbXArq619VGLej?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c0216a-f71d-4522-d2df-08db7ed04a7b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:27.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4O0zW74lQgnZyWAlwB6ccqu3uWLRb9Px+r4+b8HFHFPp3LdWcv9ruk56103+pyDNMykRrl2/OQpkpO+Jh2BJQ==
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
 drivers/ata/ahci_octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index e89807fa928e..9accf8923891 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -31,13 +31,11 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	void __iomem *base;
 	u64 cfg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

