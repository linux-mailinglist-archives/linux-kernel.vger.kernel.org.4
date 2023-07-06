Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5979B749488
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjGFEFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGFEFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:05:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3461BC7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP3aiT4Y1/Mf1IX94TK3LOgI140vIH7te9YSF+U2otFnrilq4n0bLSEgWsLwXR3qGrfAswmoBdat37l60zKUj857ZZsKCextBKiyysR5bvVyJT6JfErzw1nBMK2IQyb+xOXt6UdRZRWQFgcePHytVRKifqPkGRtADixXjJlFcC8sr7X9FRm/uHPv1XbABQrvJUTFJ6aosgu1RRsTPDwcjDT7hw1tY5J/k0gs4fmvnWdUGgYag52vo9QDirUskA4ZK6JS3mULBejCWPrZkHS7L9iUEmLpt5bJJqez15nhxBxOeewffPq3FEXNWAzi8Q1ZiUDt0TpgXwT4Z+zNTVz2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubp6aux1LzJBalZAHXr7TMc8xImu5SW559OR6L+4PYA=;
 b=oVIR0wRAkJUbnkuNjJi22npo++Yu2JFiz1rnvb2NL/p+IFMslrpIaEzFMbZnH9q3L13FKLXV3ILGaKyWL4ckxtPQtT8wYfqQ4krXslTRoD770QkkKhWzCPW1aohEUfW6KvWkNTm2xT2O401g1FNBjclA2U8kUAluJosk6QAjeFNpmRNmndPohLae1qG2uG73Az8s9sCvbnszgXs2heOm3rercl7xxJPCbh9Rzv+ECQkIsvM75xQ0mYEk4bLXaiHvBieMJWwBe8Be4IRzg4QEnGGUm/+4J5/uNyiSKrOSJM/0tjZwwSFcEakATZ8d3Z0xrWerpi+myKdcuv+PpqJbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubp6aux1LzJBalZAHXr7TMc8xImu5SW559OR6L+4PYA=;
 b=ho8jUn28xqXmvh83xQmH9RUMaCLnsTZe8t6VMPqPmftX2t0JHjW3C16murL21jfSchftPIAD2VdCxKZhrQWl6AxGvhihpLaTc6Z3kJUx7ksgXwNk0WsCRgFst/MgeBgGUxXu4fwAO1LhkrODR9ODXTt7jwpx0qcHWBgVzu9x4tsdoEriD51ZUkioUD6GUodNWCKJ0ISo/Jn9uursurKYb+M3zDdsniZqg7TuTsuAt6BUfLQ+9/i1WBTW2zywWoG5vq68U+CkXL4tQVIZQrYZ7BQ72Yhr98vjADLjkowjfqpd5okc+R6puEg8uryUSEVLUtyBSbaLIC1YUtPGZcuSgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4994.apcprd06.prod.outlook.com (2603:1096:4:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:04:58 +0800
Message-Id: <20230706040504.34057-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: c17ed434-8222-4bd7-1ff5-08db7dd63393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2hx4Gg+knOcXzfMD9MRavYoYiIayqF9nq97WVEslOUaxXDmEXznFpKre6TbDgHdDfyZvDvFbIks8vipxZenjwc8gYy4puAlw0dTlO32cluG4vEcEYx5TE6Nk56YHQV1vwigcTNeaVyvF6byIrY+GO5jQw3gG2fKBHHNAvETovyweLzSfX351xXJ+iUxwqz5SQGWzVdGykAsIplQJrOSPXSaEoTjD2PxnNhipwQWRHEM94Uq0cdK1XLo9r79+lun45Ubd7ogD5l/O3z6qRKT9bLlRqk6vJkQoEkDCC1d89arcrUWWFk2ipOqgzPIq4xnZBw97LHaDHUC2k3ZgcnwUfdZiRAecaTVbId8KWDpkUybBs25+8vcNKtWH5dIZ84NcvMQTocwbs7owxMEdMSGVlg5TTYahgm/XGf5HZMD+BtkpvelcoIsnyuBBpLKRpYEN3OxbIkGHvFQUD3VljdPwOa4l6nAbFRLLQPUtTVMRgqgtVs9Q89ae5FNw/khHV1ktfrdwpozvzaBtndSMVOoCJayFvJflE/aiiZsmJL95L6xHhntgZMx4/bjsXtWVfsTAEymnfpy5xwTaHRAgL26ij8Gp9sLmq++6/rRqOkxk5MD5UkeT68NZBNfR50xWkqN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(41300700001)(4744005)(478600001)(6512007)(52116002)(86362001)(38100700002)(38350700002)(6666004)(36756003)(6486002)(316002)(66476007)(6916009)(4326008)(83380400001)(66556008)(66946007)(8676002)(2906002)(8936002)(2616005)(26005)(5660300002)(1076003)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WibXDkv5LgE8F/SnpYiYR6NsyK0r5WtL0GgZA/RZelBpscOERTZADerzAhFI?=
 =?us-ascii?Q?t+06L4nijExhR4YH+kRb4bR7KLeagqyl+ucx6HMYtmLuu330qkkfBkTbZY52?=
 =?us-ascii?Q?O2THRArEQ5gYI1M2wLgDyZGVKzLpqvtVkNR6V+KQDv1cKqshJY6WRxedr5HN?=
 =?us-ascii?Q?7AWfZI1vmdgm6GzbnWWiuE5pDFLs2B7y9NlUHEOx3DSBxX+0sxJIbRzGgHif?=
 =?us-ascii?Q?o5WX3Wy7i5zEcZ3el5TJm5Tjj3YAR79X571ltIg6afz+HLNY6D4QBUK8o695?=
 =?us-ascii?Q?+pXcdO8B+Rnk/2gEkP27SG6jS9ilo+7wg+9rQXDa6CMSsoS8+jhUfRrywIP4?=
 =?us-ascii?Q?pqIrtlQ2+zzjDCXx4Aw6DvMHRLJOsW+90DTFVjZGIaL/bNqn65lCSMOO7LXA?=
 =?us-ascii?Q?X6yvrtl136LsmZX5NNX1a+5gbWBtBYYF3NEt+wgBHD8vywDq+FL1eL1S/+7G?=
 =?us-ascii?Q?xuqSXGVg4ORTZ1Y0Qo9LRVI3Q0iX5kjsxEQ1qvoR2O0vrFYMeAMDH256c0n1?=
 =?us-ascii?Q?fVP/TizXYyrTHSHmKDFuW3PGhLLmU2+LBhR44XKpAPBjbj11BbKm+EVuo+uG?=
 =?us-ascii?Q?K9lPYg8Z6cJrTAYR31dlBRCPQRvYvGeyJ+Vr0TvfnOl85ARAQU0nrYvvwMzh?=
 =?us-ascii?Q?xypCxYve6HJLTITkcj9HcIuKi+cRrIL24OOoC3z9Oy3D50aMghx9hsLJIbe/?=
 =?us-ascii?Q?mU/CbNg75Z9lQdGDyijz9q7AFXqolGe7444tDYrFvK5t5b89Za5ApJE6H6hc?=
 =?us-ascii?Q?2k6nI2ypqUhDy8DH8Su2gOWZSBmoSdsWDDQVxQibEGTN2bzPhPEWUu5cuoeA?=
 =?us-ascii?Q?+RYr0ldfFTKSfR4Corfs02iBWQu1PDLibkm0CDzBDsnxwkgmD+g2VcTe+DM8?=
 =?us-ascii?Q?t4RGFajLa3SeHJBzshubaCyKgfwQFOPARhA6SJYg2XJZFrXrBaqLhqdw7y0r?=
 =?us-ascii?Q?1GwhegiXAtD2Og0kXpUGyaHdSA4JVC8o5qKrubnNq1PjtV0Yn76VJf2lTg3y?=
 =?us-ascii?Q?mNubCihqkN4jNYWJVAY1yR7SYofhqu+gaAHvlITkCwh+SX96VxlERLm4NJDk?=
 =?us-ascii?Q?X6V+LwUy0gAdESUdyliyzOCStsdWgsm4Fxlwvd1CUrPQZC5d6VFeXAgIzYye?=
 =?us-ascii?Q?x/OhSZCuwOWmCElEeYxpfYLl9UTstwFRRQMPOtBI1JM6fhC1Eop58RDD+9Gv?=
 =?us-ascii?Q?B4uCdq8wdBcKzxEMdAJY95HPI095oR6c7UToZWKTGRnuh5e4s7seDFmTYMCv?=
 =?us-ascii?Q?j5EASykrJt4oGg5jTjdpNwTwlXJu5dPcO4qyDeTlPPf2C5iL9uTHM2+GMsa0?=
 =?us-ascii?Q?1OGaJtWDFRfly2pCre4oeLXNPVf/JZMC31RH0Aa+qEjFxyw9LUfINw61KoLv?=
 =?us-ascii?Q?neX5Y5TU3JS6glGJXMtzuDowkB4enVCQ9V9x3cqHxTmRnwfW7reYqK3yTYOV?=
 =?us-ascii?Q?pAC7RzIHoPxaCAuKWGe8AKk6VnEnWaBYP+9uwbB9BZlbwAxfRveN2ZyiiKMy?=
 =?us-ascii?Q?cSwzynXcFAeYrumBPr0YUYwn/L4aDmp/5NaFL6aDKva6YlPYpDIVPvFkyyzt?=
 =?us-ascii?Q?O/AVFb/98c1xmSstNjpdEuo9OQV0qwaDVOg57esD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17ed434-8222-4bd7-1ff5-08db7dd63393
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:14.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pKjOlgAC9H+odXdX0mXIJYyPhYM2IYUAaPn8yUn+LTV50q0fZ/7KFuXfC7PYSdFaLPpqkYIAd8HCdl9ipYWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4994
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/nvmem/brcm_nvram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 4567c597c87f..9737104f3b76 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -159,8 +159,7 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.39.0

