Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315E95BCD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiISN3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiISN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:29:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736FCE07;
        Mon, 19 Sep 2022 06:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eADOohsVzrRnoNUmtiKcRMHsUQUFp68qLgwFSzp/uh507a+mSgI1x5l+62SQ0Gjjnu9l6a008W6imrlrY6WK7L6NfWEhcP99zo9g/HVZ03q8j3iRJ4xjBUwQe4Tj9WFhnElVnWVa0yrP/R+EXF3LLOp0DR8h6XLF3R1SFhybq8go7oCHtiai/CvGhekphvdkV5xQePIVbKWJdUN7JYL8WsdrLzt3vwPkX5Nhn35YcxnOuGjnjHuEGwdIY41SDM8A+XyAy6jDJbNBdZ369vuu65Qsn6s04vLcEOfzPF91h13U3EqmcjJWzmk8RX8qC0I/aljKx9/G4anK3i5JTeYtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMgAw/uhVeWiunbwOzByN67++oT5+3UzD7UPcC1cg0M=;
 b=FAkdzFkQ6iPeR2Fn1/fFa/sWf2lUewZTj3aUDHZ69G+iGICrStrA2ZhKIvMTv9QR1deGOjEPNq+4On0HaPTefc4oB9zBVPr0UC49u1byQL0ofHBSf9xX+QHz9M/stm/SIjR7P6vIcDV6KOMnHlFMBi0upPV5+sj1czCLMWxNWWfAAGZe6AzWJIB5hCIX6882F6eek8u6DKyEFf2gntYuI32HvtQqgfU1VcLNTe7jX80+qZ6jx3sAys9bIlCp0gDulxVAG+4+LXPddq+0H4MP2vAwjB9yDf1fbFu7/V21vl5SJqGLInzol0VwOqMGAru4f/jxT/+5lzv5vSVKCOnC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMgAw/uhVeWiunbwOzByN67++oT5+3UzD7UPcC1cg0M=;
 b=M2XlvI4xEOxQSfKv0M6TiqxT3IUppteD7F720gLeUr4Q5FX5eYA41oZVy6IQ6AlsEUEBI4ikvKuzOlqGXJY0B0/O41wNG/QuNQeKFMXkCvnTAXU3YFAY3jYyO7z4yWgltQqaOhoUWTeVr80QStmUZulgJRBuTWKD7gmkuvlKGEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 13:29:33 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 13:29:33 +0000
Date:   Mon, 19 Sep 2022 16:29:23 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Message-ID: <20220919132923.qsai4ijitvvto3g4@fsr-ub1664-116>
References: <20220919113715.243910-1-viorel.suman@oss.nxp.com>
 <ab9154fd-26e9-2d8e-c638-860e716ca8e8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9154fd-26e9-2d8e-c638-860e716ca8e8@linaro.org>
X-ClientProxiedBy: AS4P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::20) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AS8PR04MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c67508f-aeeb-4d30-c9cd-08da9a42fd05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sIHvyPPvrin1Q1lftmK7+UVNfKlfAQC4xfDcUqBf2a1Grd+lvSxM6iZ2sEWqsVmEuDHkUPp3Y/0TaNmVblyYuChwdFFRuwQ1gFor5LhVh0bUYwe9DcFfTb8V2Zhjq68sTd3co+hnnH4hBK7IMqKvz3WeLXr+/K+xqztIbYyvGHP0zvqpolMnRXs/Nr6/fWgXnCcdPlxfxoFApK9TJZAQIPL31RSvu//+EQBd/OKYl0JnadOgakcmfSqMs1oZG0JQXHLTqkkkhdu8xOlvw52u71P8JoADlJYisKkMKUrvKdYUqol/i46AqYrYt2vb+sanX6igOCceFJ0t2/gDSdC5JiGhm5gxhgb3beuFfLXLSTvgYY5QZAbGXKfuw0K+IdUKB1lXCZE2oEUYNyknM44bNRPv3THeFgCZLgkusoKvXVTkZ1HriMvn006zs7Ed9T5Rq4GkVcZJd3ferFgQ5SAqq68zH/tg7r8iu0F+nqlQ6mxNLQYBireGYNqGXEt5F8wcYOXMtHaN8LGJ3YksRmQ99g+dntQwyA9+/mA3ld+GK0dKGVfCosNpOY6F08qY3C/3SC6ofiBL6C4pSNnGW4Pvx+fM2AXD1i6j+tPG6tNsZ6lGuYgVHcOq8/UUSOUjbK0wyxOmh/FF8MTfptwikXxQ1Zp+rsVRoLzmXu7ZIdv5rOV+OFCv1cY0BEAHugaCIuksFDxcxL8eG42tHJe510Ly66D7V03UE1QXwIZS/Ob1QECt5L+olmJxxV20w075uTxY5m9FsgixCYleNs+EWzJQufyFl8QyonXCIevZ/YlK24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(44832011)(33716001)(2906002)(316002)(38350700002)(38100700002)(66556008)(8676002)(5660300002)(4326008)(66476007)(7416002)(66946007)(54906003)(6916009)(8936002)(86362001)(1076003)(186003)(478600001)(9686003)(6512007)(26005)(83380400001)(6666004)(6506007)(966005)(6486002)(53546011)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nx+j17YpJA//LUPTk81U6o+6qTdlZsZ3gMwaV1yi3EfxjP0XJbG3cbPt2b2y?=
 =?us-ascii?Q?/VSewFH+mAKrtXjuIpfA8y5QmnVxBa10Lcr3Y2V9ImJoFv6U6/VvbK/lZQw5?=
 =?us-ascii?Q?J7u700Lp/CHr4TPYL98xiGo9WGXeitILtS1+KCNYixIqB4pBaoYWMvN4qbXj?=
 =?us-ascii?Q?QWHX/gDvfRMWz6xKPQILrff2gCzW330zGiAv8sXlMNx3pV/XDXu+WHgyZBaa?=
 =?us-ascii?Q?jqdB4bYGKx9UnX94X/aRL3W/bo7Ruxbv+bQwA1p2b0ZQTBfzeaCQh471gkbp?=
 =?us-ascii?Q?ww54mV9X9dytkqWVzc8/INLSmEIt1dsJXX9srL0sUguh+CCGBP/7nPYCuaex?=
 =?us-ascii?Q?2rKy5IZAZ1hdoqCulh9nQ04viJMFrzfhufRCszKdKh3ZFhIrd6y3wqiUFIuZ?=
 =?us-ascii?Q?cvbAUV5aCe61NKQW8jX5bq0iytNsbCgQr3WuzCP8mfngTGHAkr+K7VM2B5JD?=
 =?us-ascii?Q?oqwPCPC0W0Ax1wX1xpgZsvpQ/2UpWzZeavvJFcTm77BEtLeW6zFWiqQhr33H?=
 =?us-ascii?Q?l6U+wZ/UkkQDjL/d2PvQc0+Q2LVThXKwxfPtL4asyWcKHGdjxWs+JTwwId0k?=
 =?us-ascii?Q?1/79ymru1emKdEYnXfrc5zt3bVE9z05O4jZv/FWonvAhpF6QkokumHjFk2ZK?=
 =?us-ascii?Q?FVUarBy5N9XHZyiUMqfeK7N0ZqGevwnM1jQQq4A+JVY3BYaDyDSQ7TMsmrYJ?=
 =?us-ascii?Q?59V/0SdP3liwhv8Lttk5dhzwuHJgJG3ZlbvC5UQINt5Iqn7awgFqupz2GJMx?=
 =?us-ascii?Q?jN0dXwk1EDsZNu0z0LHnwxJbZcJ0OZneaTERlXtZ3qjZZC3vOxat6HX1MpqI?=
 =?us-ascii?Q?NcstRtKA6hYiHl0T/22HCiDNv75rgYjXrrDHzawG9vPNN//stgbYiMiJca/O?=
 =?us-ascii?Q?X/8qluJjY/8gklq/aH53Kga2gklfiJ6dxrUekh8rvyo3NwgCwrhGvg6phCB0?=
 =?us-ascii?Q?u4j43snW1lnvO6/4seRnro8D1sa6COnBaSdfOIfy7DAK/nfytessb/RGgPwt?=
 =?us-ascii?Q?uxl/FR9rE0xME+Bebt5SP9drihCmeTgGNFlt9kb2fZhXwMRlfFZZgFqKOW7H?=
 =?us-ascii?Q?fkGvXdQFwMnRwRTiyzJYjflOaE7jYFRrLW6SJ1ajip7UJYhgL0ddcf2mTI+/?=
 =?us-ascii?Q?NB3C2RSenqQsH4K5UuAuELVApW9Q/0U0JoIGSZOlWgNEgutM8whwt6UWmn3c?=
 =?us-ascii?Q?sSNkwOhdfM2coIJoPmzmebJmXCNGU67xLT3JJUTrOOpNR8teSLLeopmRFV4Y?=
 =?us-ascii?Q?jUtnpAnaXiFMZek/ZOHbcGtP7Ivs1aPvLF+OZ07GwRztTvRcHdwa/I1m9NSR?=
 =?us-ascii?Q?/5z3Tp6c8iq3Tb4kUEOKVMMmfNKLgDABTi+lxne1pBKluLyN9vvBTM3J2H4x?=
 =?us-ascii?Q?pbnCCanB3XS099I9W55TO8XhtnyhntwXygq65vzu5tvooagAhQnPw+/pTa6+?=
 =?us-ascii?Q?T7fSgQqpgwLc+60jhFDLD+9CXH5bEG0ggi28yETEo4yO3J0CxUhRa4RjzxMx?=
 =?us-ascii?Q?J1OvzAep5daCCEiWpKbAjpxkssAkXU8ksmcJfvFhWZwU21YBAKypZhhBqcQf?=
 =?us-ascii?Q?08PN4PFLIRtCV+IRGTKSXUQibPH4MR4TpGy79Wil?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c67508f-aeeb-4d30-c9cd-08da9a42fd05
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 13:29:33.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qed5ZXaAMW+eIhS83Iw+2mYyu03qbNzR9i1PArgx1ke3yoO+jkmu5vEKh9jq+u6mHlGeptkQx2kQ8Qv9edMM+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19 13:40:18, Krzysztof Kozlowski wrote:
> On 19/09/2022 13:37, Viorel Suman (OSS) wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> > 
> > Sync defines with the latest available SCFW kit version 1.13.0,
> > may be found at the URL below:
> > 
> > https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> > 
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8qm-rsrc.c       |   4 +-
> >  include/dt-bindings/firmware/imx/rsrc.h | 292 ++++++++++++++++--------
> 
> Bindings cannot be squashed with driver change.
> 
> >  2 files changed, 198 insertions(+), 98 deletions(-)
> > 
> > Changes since v1:
> > 	Two patches squashed into one in order to keep changes bissectable
> > 	and compilable as suggested by Alexander Stein.
> 
> That's not the solution. Solution is to make driver behaving correctly,
> not squash patches which must not be together.
> 
> This is proof of an ABI break, so NAK unless described why it is OK to
> break the ABI/users/boards.

Hi Krzysztof,

In v3 I've added two more defines in backward compatibility section in order to
avoid breaking ABI, so there is no need to change the driver anymore.

Regards,
Viorel
