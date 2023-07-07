Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9A74A9A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGGEGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGGEGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:06:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4B1FD8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWLzjXQOLzG83xsxTOMmtdU+ByBDhg6qcKE0Hd5jmx99AWQqgj2VCkHt4e/sVwbEdH+pbbPRgS0CSlYX1MJ95ztDMo8jLMZe8I26DN2fDfvHjyU9SSnP1Ek1HZU3A8RgcoxsOuz8YViirnJhHBSeojZy/TNOLqjERQQZ3rIwO9BLoB2R3Pq+sMtWJvUgEM9GZbuUamsGVIXvHmyc/9Kzr7fONl3yKvgSHiPq8Me0AE/92QDFfWiMQSfT7bHvGd000qSyPrEWEFabJuDGgdwaZx7OWZvlrp8UiefNP5TsV+ghVq6+Iz9Ta3zlTpUAu4sZpBCX7V36gXohyfoBE74xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOPiujfmumy5qPnC+xECA6xjofv/nI/7adzc/RmsMGE=;
 b=QhdM0Ph4IxNL7aUuCcMLi2/Vf//4PuG/Lib3E8hamUoe7xLUJw3CeT1i5dFrae8gdS7czw18Fm4FQkTIkI42f2zpQa/XQ+bcAblYmeJ4pnddRFugB8WuQwnEvVxAL8HfD49URSHDrP2Form2PBHE/a8vb+xo/1lxCBTu1UbnT2LQr8e/mcmJW3ayvvKudVsZN2X2VNj170LVmyhvqCca9qddK9Io7sGllBfqs5A+k21WXQMlxHnzXEWKF+dmyzbRqPYyyPTRAGVonJy31J/xktyw0tO9XGKE0PpQvOtH/YUxwifDDOXFqTzQcJk13ECU9AISvXiYGzF/2QbdtkYjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOPiujfmumy5qPnC+xECA6xjofv/nI/7adzc/RmsMGE=;
 b=RCcivcgyf3sTtJWCVaU8lLK3c60rPeRb/QSWTqcfEIOyKAIJAhp/N4OLJVMOdWQBacJRfnc9ltmJMsDDJVcyhdQv6Sk00orGeH63EYS17AdHi3GXZfn7k35zbC1qeUCJfpIBuxSH9R8OboV7lfpsYqNHq7zep+7gIW/KORkncuWErkxvbiFlrqK7wu3SfJRJQ+a5XeEgID/+FWdwg9ZGJ7QiCQf8uQoh6OlgoKH3wSRJeLDUfCjh5WfzbxwSnIbNG91HT3u9vAt1HKGoRksbM3H4QswCuQAIgHxPME4OmexKIiWjPWxC53VGWjvCaiCM3FzT/RhY38a6wtR2Ypw+ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] mtd: rawnand: lpc32xx_slc: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:06 +0800
Message-Id: <20230707040622.78174-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: f96051dc-f48e-4d5f-7ad0-08db7e9f8e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiumK/UmRsYh6OG8V04MV3N/S2lN6yh+biyfMG3hfqt4/YkRR5CXa0q5qTKvhG+qg9cz2VvZyUWv8mpdmHfil03SXtfkfGWSqjpuKmH2LyYuqij5uqetVp31QR0h46QY2xKmADpDPAciH1g4JFHjws8ZC4pIb6vSphBO7KWtCLFHqW4v7GntYUZP3V/oAFmxq96QCCkavEQXLuNM5HHd12vg5qBROGJl5NPMh1gHj4R8z3EN8zqaVeDWoiQEIi/yxV5ptxMP8t0zFqG2spxePh49j5ov4dwCZVqfcyZnt1RCVzZLYjpwhVDrNtx+6OQgh3NI7lG6U8BhTSq8OM3/c6RYU4F5I0OMMF3BzeM+30/2ndAUWsf2cc3gnrR3rYYJE0n1ylaXDwR6ve6x+49+tKFZGm8/cdGbtVN09d0iDx+deo89P0ImeSG+aWbmBr7+EpDpayj9S+oTFiiAfHUQVwfWVykR9tSXLpRKMHXeG2qpFbonLuOV9cs5r1OkOLAGIVNU7+peFO6eSo9VItEZuqp4kIQSO+GJZ5a3P6RlCPjpLjYs3xmfcSjwwPloTkEURS+04AilIXL4lRyo2SRHvSQKCfDZgV8FmkoFOMyAVfqeQUcKgcU8zJdbyMJyTQxq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuLGR4rCjEWuU/sToyXSnXkoZh36krdI35iI0CqeXR3/fQNupzwB9JJdg7fh?=
 =?us-ascii?Q?Q88ExzNxby6eZkDb4w3ThXZCMIV7XL/wTpXt44oRqDModl2XJNXut7zWQ2u/?=
 =?us-ascii?Q?Roe3VJGa4LerQCIVYdZSX55vLSVOAfut698XFJB0y4qb6YWxFmgjTaCxYLMD?=
 =?us-ascii?Q?RenTvl0PH+hfEWcexdKSTv94XgdnZJFiNvUZH5PpWJHGXJkJnLMiWLzgDjpc?=
 =?us-ascii?Q?FRjHK+Sy3HISWK7OwVLGnZ2+B1VVD04YbOgi7Qh95MtamutB0uWkNYE/hBkT?=
 =?us-ascii?Q?agEVfhYwr3iKAABzaNYLDs0EHUzqK3eh6oOxSUu2IfwUrflxpsCZigcReLol?=
 =?us-ascii?Q?1gPFC6m4NDjvBDLQPjpMkwlmIyb+pt/mPwQgXNfM6VIkX59Tn6TqSFJP4phW?=
 =?us-ascii?Q?1cZUxSJ+0QyFL+hmN9UtDEd/ebOmBYf/r7BZ5SN4Hvov2coeGZbfZhKSE8Pj?=
 =?us-ascii?Q?OWNkHV1iI53cgDRDRAloUY/3IE97P7MIBpxredAs0QBpyZ1sjeWyF3v6047n?=
 =?us-ascii?Q?FEP+AV0Fbs9Dq61j+A1PXA6QkxsBQic5HgfurQkgCKpnM/bdJ/mnENDxSjE0?=
 =?us-ascii?Q?0i96P56nW5nEuWeopp74jcBPoRaXmITRrrARqJ29IZPihGP2T/neBkqcvavM?=
 =?us-ascii?Q?DMdisu3t002tYlPzYT7B5+NKpAK+VYK1kmpHqzrwFYAFrVekLCo8nHhYxbsr?=
 =?us-ascii?Q?XmI36MHJTErJkrnHO6Hd/MNekXC1wA5tk+3p/Q+TKfCjYfAtDJauLh+ec42t?=
 =?us-ascii?Q?QlbNEOlaxy5IbEHyXjdI/GCgtl/YLpZ4GpI2uVz7AUpmXn+I5Axtnp/iDBsV?=
 =?us-ascii?Q?mJ9MtBseV/h7No7hxhkrECfLVSr+wiKYP3QQhqTmKnC41Mx8trBScg31Xf4V?=
 =?us-ascii?Q?jgrMFd85bYzSU5ptyoKLlL+CwvvxE4uDplGDHLJoaQYNLPJlWN82r6j9Ue9v?=
 =?us-ascii?Q?B6f6qH559xG2icNMQc/jXrX1r7Ek3VjMvMBGLP75lUp4lCiXxvg+WfsafdIO?=
 =?us-ascii?Q?x7y4Afv+bbjj7lG7v6HqiXgE/UQeqH/W1fyoj3cGbx9ccQxnv9Mn2xP7s3KK?=
 =?us-ascii?Q?hg9yVNV6u1LxOYSGXa3hEKPj/OuyOdIazDfqXxOxfMnAUZIDV5pUAi7NOG0/?=
 =?us-ascii?Q?mhizdBqXmYPUT4aMwZxuaJVxOLDVXZ5J8reOFw5sr2j4XPNeqQ/x7gveR6Hq?=
 =?us-ascii?Q?+Datw3hhTj8YrBP2ylVvVOOqGu1egJjZdHvZOhlEepEo+YzlqOcO+Pzj9lR+?=
 =?us-ascii?Q?dvKkuR1Dsucrom0aSRMbBXjjomBG7jlOFpnIbgSUuxffDLk6zTBESgHISnDS?=
 =?us-ascii?Q?4zXI+F17ql+UzU/f8d7AuoxKU7Ojvot9tQBS7BdIuajEsXF28+nrySGMBhtS?=
 =?us-ascii?Q?qwZdIcSiHZTuIfFLAIHDwADnWxciq0ym58yEc+Gx5v3KBoOs2kvb718hwx8/?=
 =?us-ascii?Q?CPiDcjBz2mOPHKSsURrAdvdsYiLntyt+f+olQ/1x9XKB9eeLQ9esU2QdhMeU?=
 =?us-ascii?Q?deHsF0kHtxg8X6za4IxzQmLqBnvQ79wQcOS0Tl3EaNCWwb0zb0AOY0mAwLql?=
 =?us-ascii?Q?VaPaVLCMnamjrkUsRjs2wO1EMPPD/0bV/a3mGL0y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96051dc-f48e-4d5f-7ad0-08db7e9f8e9d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:36.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMV9aq+JgPF/ioFF/rsFrA+zhRdupc4FBJ/sryIhe3erspANf3EbsyHuBQ+Sg0X+XOJM23gEK39Ma6ObHUE0XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
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
 drivers/mtd/nand/raw/lpc32xx_slc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 3139b6107660..2201264d3c37 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -836,8 +836,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
-	rc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host->io_base = devm_ioremap_resource(&pdev->dev, rc);
+	host->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &rc);
 	if (IS_ERR(host->io_base))
 		return PTR_ERR(host->io_base);
 
-- 
2.39.0

