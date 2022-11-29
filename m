Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90263B911
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiK2ETC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiK2ES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:18:56 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAEA6302
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CejHS6VO7J2MnpzDhEoG5YH4romSPuCVjMhCOdJYSamzPZaQU5rq6U4L7uioTaeSYvG1F4i39tSVAPZSBa4En6iKGUWWoN600BF0BdouFhCeaRxHIu3ra8V0Vzr9OcIO7Yrv1lXXYG/x6IBuDst7uOPwo7yF8rhvrJ3YGYOBRz5Xgr1htzx+1xS60eDeD1M/1owThyzo3txCEmIjDgbDTO4zlFTAcd1zarZqAZ80QjIip4zww/UPPVymNAbWbYxBhVqr6oWziadVfNPGgS5D5Aw8WosUFObfjaVLC7Kw3pAjJCseaZU/DFJuo+tvCje/HaJqHpeVK1O0xFZ78bdwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxGFufAQURads9qg/U0YIwIqzUehJiJNq+38ap1014g=;
 b=g7MvaHDEFvn21E4eD/5Sec6I4VImtKMBqOgQ5YJK8p9V+Ve2azRzfh7JT+JOVVF/Lbg96JB+alnmLgZp3cxIp2G4wrUIusWrdsmi/f0NNVWsPt2WD2uoh4rt5JIMSEUcyib6mPmVVkHejeOA55vS8UkrhVcRfdH4W3li5VDOqi9GG0TARlMT7G5aRibH6+JKEiKAbiUFrkKK7n++bxhJ7+oPz24sH+1LuEUSXDxsMX2btDs+Sp3J65VebMvfz+lPM8HEIHzq7TMkscovbiBtsTLjsbMYSShTkFW5Rpea3Fi8Ywu97RvUCGLUd+mzvN7ffEEwvSI6tILc9S2gelH4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxGFufAQURads9qg/U0YIwIqzUehJiJNq+38ap1014g=;
 b=NEb6ZiKHFgKqRTmlGxD5I9m87dGFGf2hPBoUAX2Y+0dVXakQz1CIS6hgmf5Ex6gLdKoj+f9Vi6mUh7b51LJajuFvktVvye8T0ZX7A5OONY6aYbKkExp7YNKUxykIS9dd6ja/D684OZQ7A4RsDTXHl3JajT1Cd7c1Rix9/8Bt1o3qUZDxPMjDstGGVqIPBcdOSHuZwPT2fxCzRpxnAh2+dsD99QaNvGPNd5vcgjDtop3tNXLFTE0BxNEqOJi2/8UAV5AMFYCD3121EjCPNmaK0RCJxXeMlECjKlwW6M98aupTHyuLA2MnMXyCD+aW5MDtJS+rqWtkfj7GRFthb2MtRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4091.apcprd06.prod.outlook.com (2603:1096:4:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 04:18:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 04:18:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add f2fs bug tracker link
Date:   Tue, 29 Nov 2022 12:18:42 +0800
Message-Id: <20221129041842.81671-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y4Uv2tuHerLvJdLl@google.com>
References: <Y4Uv2tuHerLvJdLl@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ded18c-16e3-41ad-e7a6-08dad1c0d163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9JXkGIrLatHgx+e+b6PtCo2b8Qsaf55Y6f/7sCVXNDEB9ItfnMMvvYBRoMsgqMRh96btSFOAtaVPa+rEwVhDAlI3WqESwhv5Kvc+2vPTn87VO1L7pFEyOb1an99wQ5t5jXnoIxtQO6l7xxkQjIaI6r3XoYs022N05YMBCs6XpOZcJ758mwDFASxCRoftr1+2yKnPP3LrkslymbVPITI1Kq6Mshyeyc29yltgbhQ2SfKzEKtbcfJ9Z5i7aubNbLiUYQXSHofwp9jotP1Zjo1exKpP/UWkprnMt7j+XOORFkAIFtIN3kpRPaIJz6CTJUtML4/l/UmJiiP36Q7str/sHguFf8FYpd79WUpfqfHM2a9IPNKLOAF77/79u1bF+/TC0qC1ZwQaYrNQo5zLnN1kJlH2OHpz/lbrc8zf7U0O32x0QEkeQU19LO9kqIpwJofnQ1+1IS4vW0xItI1/EKJOlfgHpHDAkdayHGreMNq5nKdkK28iAQdBVkP+0fHp3q6qxs4/s0j+7vS9c4MpyYw+RtqJ4EYwodbiHncUwt2cEnpxEem3UvqD/0H74fxi4gcB2szeIGmv8PGrm+ZTBOZrFF+PaLDRBWrk/gEQOuHIVL82QxLXMm5dokwJx87GDRhW1nXCuBxUNban7gyqTXMJJSt6oas+LlrgXCt7p01jcrYR2yxp1wWgSWmw+4d7Wob
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(86362001)(2906002)(38100700002)(38350700002)(41300700001)(5660300002)(66946007)(8936002)(4326008)(6506007)(52116002)(6512007)(186003)(6666004)(26005)(6486002)(316002)(2616005)(66476007)(8676002)(478600001)(66556008)(1076003)(36756003)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f/BTqAdFnlM8u8JhUFFpjgj5RFNgQQjVdq3pc3snlJpI573ChpI28owjXJ+z?=
 =?us-ascii?Q?cPExQ0T3D0uGJaJwhU8QLyAK2+IfX/zR7EBiiw+FpUcV10Mc/TjJ361Nmq29?=
 =?us-ascii?Q?w1LVWS3A7QPGLwFIbI3+7UoIh0FuoUutihKFCVBSvWTpBImXVjNHRK14NsW1?=
 =?us-ascii?Q?pS2uF1Fa+O87VFWo5JEoMqckCQOadDM0PX0E4ZfAcyOnWjKparVLkAxrwX+7?=
 =?us-ascii?Q?GMT/svcW2OrPxe/mgGQieQTuU/A3J7CANu3detVVFh/81nFZ5d/F+TqUKAnD?=
 =?us-ascii?Q?VFDzAZh2n9O6lgoZ78BcvBDahCU5Az271BPbkDMLi7w7wThbKtIwMzNIB6Ow?=
 =?us-ascii?Q?AZ1o5g3nP95iAlj7deRP3oZRj1P0p6gnSCTq8PZrRL0zY40YSXSu/M+xXGuQ?=
 =?us-ascii?Q?1OaAEKNuRc+AQH5cWRRWlC2nchUspDFCa8szCxMwW/+xNhkA7GrF7R6ZaIKZ?=
 =?us-ascii?Q?uoi4do3NeAXSd3io8wyf1kGwcbP6vmHucDykwDYSKsnXUVZkzeuKXIGi8sJH?=
 =?us-ascii?Q?5tbLafO/MFJGuH1RMN0UHiGX1BqDV97pv1j2dy2rFTkfdVDt2xSxV8FY3ogl?=
 =?us-ascii?Q?qUhQW+ww4Z2hTqewxf6x+0HyGTFccuU5nqwdRam90MSAUGbZuDyR111M3EXG?=
 =?us-ascii?Q?yAdHfG9Lc71gUSe7UhzNqxUCJJnuCu18iZfUeHzGQUihsuKU8TbdVyEpD4pG?=
 =?us-ascii?Q?6tcDJCBuUIzT6Nf41M2RZoPAowKh6IqCmjG4Ez8WcdRygezuMWK24R5n7Z8x?=
 =?us-ascii?Q?FLd9tvKmHY0GyevlPixMrpiNSk2K27KsIi8KSsZ5MiElD/tR4BN3Dqfj7gEk?=
 =?us-ascii?Q?TqhMwTxXhb8dMK4WYxTM+7KZzqis7IDn5GYgk/kx0DXLg3JV9bnjFm1hhduR?=
 =?us-ascii?Q?zqtmEJzftMrD80umgKSM6Ryx8lgCvivyoFGpJk1zXPyZjMTk/EY2AXwMBa2N?=
 =?us-ascii?Q?vgCj3/2J21KgySqGIgtTcWieQjLWMRXjb2utdmbKdN3LpsGrCrz2div6jJle?=
 =?us-ascii?Q?nkIzI36OTrjl56q37lzXx83u7yl5tKNgCiGaZkdBwA2GlPan6jZ2OfUC9JZY?=
 =?us-ascii?Q?XpRZCjMxWcRlSuaPF1rHzjkIxpfNFKhxZtUEHncJNsBC3Qp/zF+ROrP5+39B?=
 =?us-ascii?Q?jDoA6nLkmlGTLyR7aeB5jYVCFZvf5yDL5lYgLkd8RrOp6Tqhowz0I8gQOPu1?=
 =?us-ascii?Q?tPpahAIzVto9sPAna/Y8kD0I4quo2eXS9r+Qr7RsrNEfwOJFJtp3ueNlgBIG?=
 =?us-ascii?Q?17+hnD0nt5nJwQLdKQexlmAPZwjkvfUA2TnQSFwrO9msnrGrAjbJkeHYXFX6?=
 =?us-ascii?Q?Sz30o6QsqTrY5sb2BWjcZLQ9OjzuXBN56VLfW4xiRm/301GrTN7rX6OSPr+y?=
 =?us-ascii?Q?FY5mH8HY6SerDqQFDhrIJXnHux0817V9QG/EAHqsGfIkGcxS8VKDhUthj/7D?=
 =?us-ascii?Q?FFXoxzYFEhdvjLrqW1ePPSmJlJP9q1OeNmnpmabFwGRnJ4C8pi6AV8C258Oi?=
 =?us-ascii?Q?RZy5fi9qnCXXc1jGkuUgoeb8Bkx7JXlea4MO44PP4La6pj57FXZu2jey1xnI?=
 =?us-ascii?Q?2mtsWrqOOgWasqZcf8UswSUeqp6rD0z0lz4k7FaB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ded18c-16e3-41ad-e7a6-08dad1c0d163
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 04:18:50.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwt/AHBSJlVmeZaLwKZGTbeqywTdoJ4j+237fkuxc4XH8Ui1p6zZ9daWeJlz+s4ouf74XQG6Zi1KLdZHg7xUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you don't mind, let me merge this patch into Chao's patch, since both
> are same topic.

Never mind, feel free. :)

Thx,
Yangtao
