Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E0653C94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiLVHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLVHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:37:56 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABE1900A;
        Wed, 21 Dec 2022 23:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiV5zAMFoJ0MiqRbt60M/IF/enKb8vDYWRQ4tP8C0kdv+W3utAzuTlEhAuMqd4mzuChjrc67MQKG1oQg2E0YGI+aYmGQtyssSeuCFCSouTkHfmpqE0khnoROLSEpXpi5pnu3ZbNRBPIvba6zTEql8W3YolI9DW3yqyHC1w/Y15YOuJLkVX0edJLpKULHHFvVIAZgv7psh3ggKPF0aE7cxGXuKO2gMFrPA/RQOSgETRiH1ZIi84tLqUJVAN0gKb6As5pCq+3G8Qx7lnEUbhi+jfXWduhRQzetAWl0hb3Op8U7Ol4GzjdvM5Ll2I+mocsFHdCZetjGz3+OwJifx1FW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnclSI31i9Z9Ok/npWLlz8ucL+qRlAkeZAtbRRNmH6o=;
 b=FsyA4ZdkqPCKQD0hcxYSbAV/LqGdqSdkSAT8dRlrjgIDmRzBz9syt/5sEi8ndzgVCaSXDfKAHPjJXkkafEjSeMFJBnDbb2SPo9wjGUG1jpMssPOViaSRfUNTSO2dOGASj2uH7FPJJRqMBgEPpbd2/u7wqBO1oBAdTpVPwgq7xvErFpUMd93BM/mJnHIw3+8YSH4OxbQ+YlFSkCd1TglN2YI3hKiaYLZPJqo1jza4+G5pwyGwYoq77WBLe+qU4AfoyYna0I9sXOq0iG2SK+zj1zH6RkFvHIzyggGsp71m/P6i6G7JX9shLB9PzqLq625cCxXD0X0fhShSdlm2VC1L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnclSI31i9Z9Ok/npWLlz8ucL+qRlAkeZAtbRRNmH6o=;
 b=XiCkkEhEuY9YuknyVKJKiPx7bopi75S9c5uJJQsJovF3CgR2rCG975Vf2a+HHnY1w0LjKC6OSIj9Tn3x27aAaxiklsh0Ph3eQSD3x1FRdOAtPZ3Lpo9JjnpcE7e6DvjC87Po8CCKJvhD7eWBjDVZS4h1ajO/8ozY4tXFH/a/NoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 07:37:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 07:37:51 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 0/3] Add support for XCVR on i.MX93 platform
Date:   Thu, 22 Dec 2022 15:36:15 +0800
Message-Id: <20221222073618.1064415-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf53cfe-4f93-4e82-65ec-08dae3ef6e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZenyBRGvrpFximAPSNG8t4pmc1dIgTNdKX9HSVULBjuKysMVs+sVJaHAdRLEJGp7FqBRL42aIz2KR6V87C2XCedVPRCHO6T0b4tuZIvjX4qaM6ak9QlsokQiChjXS9YyCgdU84IYw3nEXHMjSm4kzNhKGXkrq1ZM9ORmNbmE5dsu9Iwz1mHVtWCDdb7PcZonuW67qhmV+e5bAqapx8oQmP7bclmA+ZF4BOtGJzK9cg4n0DwILhR3I639CSxRXitFixRHrQGzX59JWvhjGZIttbnN9oxEBd90sUkAmABKDwCqL1Rp6QU+82IVU8ObkIlOFRI+zht+JS4y9T8u1PutB9qOUfHo8IHz+fvPI7fPyxtt45c22bcB8BTd2SpkpwxaxNfJw7wfHjP7BtF9zf4hhkjYBLPiDgtfktcxC9ap2ukN+KO25MOU74DdPBevKLFCnfRrJoj+cqF4ndb4PJBOpAsiBjPy0uYggG6BdVI0hFhjwNl4/JfU6YGiSi7VQNEHtkeZjcZY0oIf2tT7qdIkFKv7vGbgG2KrUfZYbyC0fDUUdb5ZwF6XtqsLpxRDHjd84mfdebWIuR602Fr3nLHOI1DHXXbW+XfrB+ChCptuYyHPa4HVK8XSjCi2CU6MNmZeCj3rdcKLWVcLcIzSsR9s/fqOurWbFMERv8U+9MnArIEs6oDNQU7/OK14tgjXH1NLe3/rVBVoIATtz2np/JqMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(41300700001)(2906002)(8936002)(4326008)(66476007)(66946007)(66556008)(44832011)(7416002)(86362001)(8676002)(316002)(5660300002)(4744005)(921005)(6506007)(186003)(6512007)(26005)(38100700002)(38350700002)(52116002)(6666004)(36756003)(83380400001)(2616005)(1076003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGk/c2NC/vE8Fgny6J/6WcnqMFdHXI8iyR+BZ08PgLOgqlSyRsi+LP0A4qf/?=
 =?us-ascii?Q?aR/DYuDpsOvSOmpKlhxJ49WnHN1Jt1YxCOGZapheH5we7LwqPnbQo90H8Xxa?=
 =?us-ascii?Q?zVSd2NINKugKWxGr/yH7JGx67xuPinADfe4pU10FwS3y7FpSjXjLgVCUfZ+i?=
 =?us-ascii?Q?8FoY/iM8Ownc+05GS3muQUs7TDEkfHaZ+QTwoUSiw2dJukJiC/XJNF0G9VQ+?=
 =?us-ascii?Q?CgnjRl60778l8Sy2ILwmkcDA6O9dqhSsosbz8qc3J59xOi73T2DlqDdbMdrv?=
 =?us-ascii?Q?BC/2M/zaFL5TYDFBil99/tRP8yxNeEo0LfeIPRsziDNn0zQKs2Ejyn5jKyfK?=
 =?us-ascii?Q?uQCjc3FtT4suHc/0FT7Rm4LZcytj49C8OaVyqhAW54x55DBCUPYVmMybuPXV?=
 =?us-ascii?Q?gdrEdIJsbGBLgcGkUfESJQPSLi68VePtzPFJB2RNaDg+wVPz/qUjjoAZ69c9?=
 =?us-ascii?Q?O5+6Ka69Np45IrnVXP+MfKmcnMTbF3Y5qzZLOLs0lLnxWRezq8/RH0to+4Dq?=
 =?us-ascii?Q?JZT1Og+6gsPkZs1X6dJbjrgd50a3lPd72LDcbjcE8b7KDLWKfY8lXCt/QG1R?=
 =?us-ascii?Q?K07IFRG9fWMnChS3Ids40/ehrCQXZzflZocEGz72/BtPCK6YgR8ViVJVBBHH?=
 =?us-ascii?Q?f4WvtyVzMwy76C5Egh+vL41zT0mBuA88eu4lrGpDMe10zo07qaVXlrbeeZ93?=
 =?us-ascii?Q?CP1EzmIffL8NwQ0MnGjtpUKrPJHfM/qtdL2MaKnwFLfVB6RdanD1dRQLQAHs?=
 =?us-ascii?Q?AASajdUOWgWjRBN6d7ccWa9QFBCXO4sYGmMbeLkJeXXSQkru6HW97DgbyngI?=
 =?us-ascii?Q?1thgTPkoQV1T6adtqB6Ap2YKluE9cxge4vWyEoyebF1Qs04gK72sF0wDV5Ph?=
 =?us-ascii?Q?Z4XTS+5BO805mWhB7t3Y44yPfQf7ULX7OA9CW9c3Dt/1tTU+WlSD9tKYessO?=
 =?us-ascii?Q?coG7bsT2arm9WamGHkM1A+AJ013lPLLtJe+4U9dKa+DArZq9BK5JOhSMXEwI?=
 =?us-ascii?Q?45f66XJWe3YbY/BZgwrPgmHY1VzD5rLOLC53C9R3zkggm+As9haAttKK1YGX?=
 =?us-ascii?Q?MJNN0LD9dQe2AslPEStPrGYWQHa+ZvOy6OppCEEmogGmVYoqt9eaWGA3obKf?=
 =?us-ascii?Q?/h7sWVHqnmtjPwFDGCz4GBmkWsybbJJKst+SFCGDVzal45K6xRKg13bc83m2?=
 =?us-ascii?Q?xLvV9M2kLJ+Un9YD8r0aBzThkKcGS0GmgOdnOKFHzB0wd2BHhTdlq7qj/4gX?=
 =?us-ascii?Q?t54/3Ik+JqzXsJQxG3jn4NuD/kABqsVoxji49sPC0EK4nRJeqQirwLHpZpgv?=
 =?us-ascii?Q?cvcCq30HV4mvXyZ0rcCNxbJC7gThtorQX4XlBBEF/MdwVaxa+EToIvvXiyrf?=
 =?us-ascii?Q?f67oHSm9n7Cf2w2kym6xnQALxVXBnaZj15eAscI6jyPY2/HtnEiyko3jqNMe?=
 =?us-ascii?Q?creVnwJA7z574JP+tNkpa/+OyuXZc3/QF10FuSyAReemhHwAo5y+dczySk3u?=
 =?us-ascii?Q?1zLOJZ082roUTOQJ7EW2S1dIn25/KbV4wuOH4/AUh3Zmjr4mHOA1i2Te2HNW?=
 =?us-ascii?Q?jsJ+XAB9NEVYAbcUXYK091n3pL78eZYzRMgg2+bu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf53cfe-4f93-4e82-65ec-08dae3ef6e14
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 07:37:51.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs67zwOrpB5d33w5ag4XuyhwzsxRgZZmVvM4/p9FxHRVOwM5TnWVr6apBiR7ID+zOCOEFF0pjrAWX/0/bRXmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports XCVR on i.MX93 platform.

Chancel Liu (3):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
  ASoC: fsl_xcvr: Add support for i.MX93 platform
  ASoC: fsl_xcvr: Add constraints of period size while using eDMA

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 167 +++++++++++++-----
 sound/soc/fsl/fsl_xcvr.h                      |   7 +
 3 files changed, 127 insertions(+), 48 deletions(-)

--
2.25.1

