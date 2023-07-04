Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E9747054
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGDMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGDMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E14E62
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIltnDH8+Qf8sNWJpZ32OmvJkjqezvM42P6HumcPbMW76cpzk3KA5b24iCpNXWFrVObUWGUqxO4WyV97FFpLKmAxPHnlc03/9u9YAPM04urxyYXU27EcLPgurBlQA0/bAYiILiT81bzjHW0X12aIqt/+bPhDTDnMMmd8dc7s1snGupPY89xBH07x5SNi81AMDE0IAxiFecAAt/tx5mlc0zwC6f5wDAFgEwm0BBRGpxT0smabNykdRbCBjIxqjAwTc11myLGatfSQbuUiBiGRAoQ+zj7ZLGs+gTV21xSALDJRdmOs43s3Zfzjc9Oblz7ujdkDpV4RYBNkKKGp1weu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecH+KkpEz167wX2z/VdYfQe4tGjxQuo5p5IfQagxbTU=;
 b=Di45d9khu+dNXknrX58ayJmFPeIx+sPy0TbwUdNEuafSzR2yv9EEpavRee28YIlZp3Jm+zdf5W176JYtuBGAXXENdWmwcyji6ZN5jEN8HJ2hmqA1HNpPjwdrXUw4AplusEa5l7cUnk+lZuO4UfLA9nulB2vlZma15KA+2DdpXH76Q7TS39bL1G9OKQDaKZGIERyruNQYkG3MEAsOCPSF+MH01P6auR6xWlBnMM0txYNd1Y5wbcPk+Et6mUyLm7M0OAmLVQybhsfO4B4wfheBQZivgo2fwL7FxImly9MheorNAeO90m9XV6OEHeynInwrqswqjssS1UAQD9MTBeuATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecH+KkpEz167wX2z/VdYfQe4tGjxQuo5p5IfQagxbTU=;
 b=aK+nBpNBY+M9LATalPdjKGURS2+g9GcFTr/SjMVuaA44Bojcwd89ZVOQSu446n1qYbUpRWR2tpfS2JW0Gi7+kNL150ns6QNhWKkC3umur8lOuhQULqvpuNy9GW44tNnXWqv8NAb2LW32C34REaEX6nNskh/HVPl1rDTEt1MAdLf/hn9TIYWxTmwc5mp3ANvF3JNx4X0NTn/kuZ6ZICocBuXTrmB40apVcMV4o+ne1kf6jjg3ddftCXLoGwiV3rATo73O0POIogR69Juh7Iumn4eFXJPoF7XKiWBWrHWN3kKhYhpo1Qymf+ADy5rrQU6SEjbLcYaKjdYMZJBbeyweZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB4999.apcprd06.prod.outlook.com (2603:1096:101:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] reset: uniphier-glue: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:11 +0800
Message-Id: <20230704120211.38122-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ea1a41-4f56-4f00-37c2-08db7c868db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+Wb3fNgF7XEBDQuRT0UZueVUyfUUqdM1pn70QkpyI81ZzB7IhSccJMsljhkRQARSTh+wvA88ck+wuf7FrajdUAYoCMCX8VtEc8Eheri75rB3SFPZ+RWOozACbUJF8eK1PR/K0fXyxzVJWqq6mBN7MoagwujVC9Ypug4QpXT0IexpwzFMuTocTa2y8a1kR3n3MLJZcQIe40ZV++jtHmi+n8pqgwbEjXtJI//4zmHKBmQJ9NkTXYu/0mJryvGhbgTCLSZn0nTSA0RZaLrNtlyRjkKfd12JcUEfXq541K3fknYg3wydMc3c/anIV1hPkpNUKCINoU1ingOCX1Sq+XhIxVBOWJF+j76hxJ9BPggD85wqP2lIY2qr7MlYDzbZ1dwvrZyApP/rVggLz2hDtrWSgZ3c31wyKBiJz15psK/6SN/NuS/cHcK5geRY/OQZihr/UUWW3h8U5B1c7MbUawnsEBdohjH5CWuZA0a1h3rrrybJ1H7J67IwwcUsWahajJzxcbPtFYF50iCMQ9uLb2+E2h9CwMsDQ3IH475eYJ6H2o5klE8fDk3vp/bLqML8VCEkqL0t/c8L5gv717CrNjgD7xUOGkpQFwQAb9vt8G5WRgY1LhT9FL6UOiiCyhm6AE1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(6666004)(38100700002)(52116002)(38350700002)(2906002)(4744005)(6486002)(8936002)(110136005)(8676002)(36756003)(41300700001)(478600001)(5660300002)(66946007)(66476007)(1076003)(6512007)(186003)(26005)(86362001)(6506007)(66556008)(316002)(4326008)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wK0GncXI+sX0AlWvLeCfAklMgDX4595kdsIVk5QRcNaIlu373B1DGx0U5txs?=
 =?us-ascii?Q?tcyrlicF7mU2A6RucY0/eSX+fgs5fq6lFjuNzQw24yGrtDPxxmgmd3zxGSZP?=
 =?us-ascii?Q?JAW1Bv5cB9QHkl2SokkJnNb4j12RWyXbaXTw1d5FGCtMXOBIR4/QJHyKyOXf?=
 =?us-ascii?Q?ReHfN9yNrcQL1UsEc4YsyJzKmzF/uvlWBW2m83p4F3IVnuMs+WGWV16jq6Ei?=
 =?us-ascii?Q?IJM/hkTlYkV7H25ZdsuPEH9gkssRBMmxPAEM0W1ndbDWBh7uhQdZCFWDmEED?=
 =?us-ascii?Q?VnBsLdJgDaIBU0RveL35bQ/P2hikSYn15/lhCp1s+hwcJpVHC0dMz8Ui7/aK?=
 =?us-ascii?Q?x5lmw3ZQGtyRNZHaCc+ZwS054DfaXBY0nlIS91XBsHcEhDPy9Kd5HICWFDLW?=
 =?us-ascii?Q?Yz4zZ78t5sGP2HU3XBV8F3Y2CVWVA7wBTi8w2sOjn9pfiCakHu8POtFq+9ay?=
 =?us-ascii?Q?Ydwmkun3TUF+syqenGxU6w7w4lYKptb5WV5jhv2nm6SXhPVzbhPB0pZpDCBr?=
 =?us-ascii?Q?YKpuiU59MiNXR361WMV8cQNJtjc5MzdvktKjJQ4I8Y125WOGW0Ao+Z42MF28?=
 =?us-ascii?Q?BgnrD6HhIIR+NaI+wfnKdtqsiK/rUOFfBK3VqjEj15mcoLbB+WwZa8np8wZ1?=
 =?us-ascii?Q?nY0nv5RHXLrnJAussG7+7QKaidhuxdPZbb6kOvktPyPl0LxjHJHZXiBN1g2y?=
 =?us-ascii?Q?j2RIvipDso41YdvMYTfVBbaXEqMLX3sFfTlM27IevO8QZWYXmBko73bPEosr?=
 =?us-ascii?Q?PL9eZDu8DYRj2wxoT60eMt/RUYrbcoLMf+QxgAOV3MQNBfNoStnhv+4yCHqT?=
 =?us-ascii?Q?P6U4nNmyw8ckpKvBm1ATHJvZ4+wvMWAOF6ZwzdAtj0/sCQaphonUbr3JQStP?=
 =?us-ascii?Q?MzLKaf7Ce34nR8R3lmzOB3+b2t4rJwpoBdPENA5dZe7vxFOqnd95Cdoy4HLA?=
 =?us-ascii?Q?cW0ZLYYg525rLDTHg0vB0sJNKIrSSOB8ykuvRvRN0jfA8nUT2lLA03rRX+pN?=
 =?us-ascii?Q?yFezESVfYJsyTlkIZimeprMEyFP1BWyLC5WmtlPTbGCpTGpUEDfY/SXEuSEY?=
 =?us-ascii?Q?GtPdR+vld6l9gofePuzrn7yCRqxCpUOj7Odbw7mRPTGthNRBHSu6ramRhZce?=
 =?us-ascii?Q?+Rzght+JO4Wzh778/LvwDHNbEc9PREWzlnR1of8cl8dRFrTjOYc2dHMIITKj?=
 =?us-ascii?Q?QkoqfvR9B335VGlG4hyQbue/N7JNJ+9Af/WOISedWvy0UNRvkbuXU+KEMfe2?=
 =?us-ascii?Q?hWTHciGE50hlYJpc7us1kP+E/CD/437R0oEQMfpXShOau6rpDYPAWAvQS8C8?=
 =?us-ascii?Q?NUj1OuqsHZ6mxZXHDjTzYBAhLUxZK3Tu3I8ElG9ReSAE5tGkt2+hN4dwRvtg?=
 =?us-ascii?Q?bHFVQdr4qpNFB4niB5/MK5w9QN7N1H5s2QWfrooQK6lZvVQ0AbXB6F3iy0Pb?=
 =?us-ascii?Q?yGm37W6Wsx17XO0ujTZUhVv70bMfTrnDknh5Uz/JfO5VN2lh0XVBFqGNQXLU?=
 =?us-ascii?Q?ycCDyE1ORiKXIAxTbXJxslDzvNBRSdfrvVMR8JZHlHfpIEt1dfPBPk1QkvW8?=
 =?us-ascii?Q?+aQuIfJRwQa0ab24WhmhJh/+TknaEMBjyH3MZiF9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea1a41-4f56-4f00-37c2-08db7c868db8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:35.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dKyUrzz0e6FhFzat4Bs38fKcL/c0ossZXiBhVg9YTbiZfzIA+F/pUPT2OeZvByJdqnCJhF6wWfrupcs5Iya4w==
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
 drivers/reset/reset-uniphier-glue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 15abac9fc72c..8f315dcb10a8 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -58,8 +58,7 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 		    priv->data->nrsts > MAX_RSTS))
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->rdata.membase = devm_ioremap_resource(dev, res);
+	priv->rdata.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->rdata.membase))
 		return PTR_ERR(priv->rdata.membase);
 
-- 
2.39.0

