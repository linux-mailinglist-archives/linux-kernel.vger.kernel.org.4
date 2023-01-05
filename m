Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3202E65EA5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjAEMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjAEMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:05:05 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070358F8A;
        Thu,  5 Jan 2023 04:04:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWw97sbndWxiYwfQdSwFUCBDcbemVcoPsRTtJGyXb4FSjMVirl/InW2gpUQI+H0yk1I/aYAB6Gywg7YPZJrCRO/+LglwTpPBOjRFABLf27adlrA1AzWnt7nU+su4/bwPvM6vxfTMHh3Wkr/zKkAPr+MAJjTv/gUmZshfh+SAQpDcBivaCRuMKBxVTRSsnLbP+aWEVmyqYGZwhBgwTCc9/HjA1lUhoAVeI/oApN+LNOxcSShJ1KA+DvEBVHZciIFhqiUtLEczy3kANOCPmzkRVBbNWmKmC30Us0+1N8T7ZIpk3vqQ452HwMwzpp1LLxOxEjJDbJLNZUAh3igbPboQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvBa6Io8rgPNKID85auOCQZKaxSpTX12gRaWHUy8Xdg=;
 b=Hkf60p7HRoSoSsIBBogo5r3Fyc6ZZaT/XCRdB3E10dmQ17Ectrils8D5X+mEr2sUparrC5U+O3VQ8B7YI09vscStuDr3yUwgwZ/5TlLtR1g2Y/c3RhDNFwxliNkPolAqhxAeHBR9PWF6w3vnrqoUIAYI/qRspMFtbqP3nnyhStOGnokJf4dacCaqee9C0MlCgPv319y9Tex5krhnBLfeABMQQdy3umzUC6pBkfZWWXjhwuHAwH8NKjhh9zTwGov4Xld9qctG/8A3lU+9KErUyvb1hU61beEzl0Yhag77xM96nEMksRogl4VKhfNoMWLAIbydqHqJdiaE6VT9NJ/GBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvBa6Io8rgPNKID85auOCQZKaxSpTX12gRaWHUy8Xdg=;
 b=Z1gfYJBHfJ+bxT3o9/DURDGzsLnl2EwEKK+Eh6MX8zwauRlx99TJAiObaSOdWiVs96u/+V3p8lgDc0V49MvmVmI6h7MPA8CWZxA5EEcJQJqmkRbZ97oRcIJuRv9jGfMERNY2uJlrLqomS7wgpnlaRk8TruNf35qKDeHCgirxCS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 12:04:51 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 12:04:51 +0000
Date:   Thu, 5 Jan 2023 14:04:47 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Message-ID: <20230105120447.vnr24pusr3ihdhwk@skbuf>
References: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
 <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
 <20221214165356.6tbzmfyoifqt4cwk@skbuf>
 <3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com>
 <20221219121618.z3dcyob542cnmdnk@skbuf>
 <67ae3a53-3db9-c1bc-2b67-08df14bc15cc@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ae3a53-3db9-c1bc-2b67-08df14bc15cc@arm.com>
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faea793-9620-4cfe-b105-08daef150c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYII4Ji4+He0vJh9tzEphMMQKCuGGzgaaNmcqUb1GqvUIEWQRY0s7VEsGRHLHbyFuurYCDDJwpWcvz5xboTiBTb+TLHcUOFZ3ZUhhn6eO4AdT2bmy7+DUWlVdG86NoMPUTJDjZ8O+qcl1aYlCdzbkXxBPDLW9X2t2MAdVxdB+VdLZEmCh3qZqcMytZHak4nmM5CGVCSYuEekHM1Ez/dc+Z4cReu9I9+Qofge76n1zWkjO6gTlXmPIL1+JLGrNWTihMU6+a6fqh0TBuAkdUlYDuRfvEUIO02zTxZQVJOQOEG4DzY/MvdUbAlABpnamyNmhPvkSwEcHI1wVvomZ/QlA9Y/mTXR1soqW3Lzgi1Q4WbHnkpRU891xDFGSuMgOQkUXgbW58frQnLt2cnsAse8Hkwj/O15/XL9wm3TCay7uFTopSmp7XO9TefyDtJTrvjK/0S26R8oG/Y04GhrE+S3L4di3H2hGBqnNW8c6iX38mIG9MDSscCiwhPXZ8/2yfcEVBC7zFpXBk3u6CEjkD2ovPMiZZU1wVKURAQnZ9H1XVwEJUmyaezIjK30BDWgNwX5h7cQop1XPSbeK8O7FsjrokwS68FoSodhAdz6fqSpRDZ0NptzRH2iE6s+7CfgIb0DLv4pgLlWC7cvECXnnfHHIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(1076003)(6512007)(26005)(9686003)(33716001)(6506007)(6666004)(86362001)(38100700002)(186003)(316002)(4326008)(478600001)(41300700001)(8676002)(7416002)(2906002)(5660300002)(8936002)(44832011)(6486002)(66476007)(66556008)(66946007)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6OVnJO3zIu13zZUc4WQSb9zW4C7NrecTDqjUfVC10hAYqsR6sf2Jz+OdcBxp?=
 =?us-ascii?Q?fNFkBD4XkusJNeGumph5yglATz2+5jPXOuA7BWoJLdQpRslS9//ixnHQPsiq?=
 =?us-ascii?Q?z4NHEPZ1wWcaA4CWwpnK5iS9uhKKLBE1QfRbxe02TQIthTu07GCMWxZVMiZz?=
 =?us-ascii?Q?vSb385ApGQrGoY6I6rmJjznmY4TZBMbFyviYrYLy40Aafxk4HJYcADk/YIjl?=
 =?us-ascii?Q?D+bn5kjqlzZJRmOzVJxmeHCwnh6w4+kqMO1cSdY48kYs+CPc7gUz+TgA7fVx?=
 =?us-ascii?Q?IJAPxYYRtcHwX9ENkpPuvHG6KGXnldLDxao2fcp7Db50tkrnG8YEymxQVi3j?=
 =?us-ascii?Q?TyYDsRzPLVaPQ1ErB1weP9IF+qk2Ii2cQGI/GmN3r/QODBIX89NeylJuN4bC?=
 =?us-ascii?Q?nVz+XqFEkyDD823REFxnlfkucF43LMFcc3rb6ZrKst+feIjHaPnwn9f4mKdQ?=
 =?us-ascii?Q?w7fM7zptVDJoxVgFA06wsEDOr9yYh8KnMj/DoF5j5l0cZvc0PPy6kEsS/nKe?=
 =?us-ascii?Q?VbMNWiDEwm0/yTEZgwwynSz1Cx2outD2MOQSao48oXd4LTmADHwjQTy633s5?=
 =?us-ascii?Q?PkyWRDtGwW3AvkZaHVtNTrAEmqFtE2BLI4repMStAKevjk9tMe9KrrmY/Xq2?=
 =?us-ascii?Q?jcdK03jReeBA76R+VeHuUl57UIZFhcQeXdkqDWHPn+82CytXma8KquwCJKwh?=
 =?us-ascii?Q?yNg3/g7Gt9/TYiiP93MWr9QhsGLZu8kZWAJqBch4N/ZHYE2xVzzT37R4cNZr?=
 =?us-ascii?Q?djTDN1ILo7B3jPuhg50XuTF0Wr/Udp5QQOZw+UlOdDG+zcs36dmmEbDP4N/E?=
 =?us-ascii?Q?6hszuzV1ja8Xd3GITsvpLY9upPRrvTKf22y+nDu2aftdys9H9x+xVjCVLQoQ?=
 =?us-ascii?Q?nhdBg95TwT04bsYQBY9D1Usc2Ubaehi4tMr3gX8eGaGbU1qpjTswN/3tyIVd?=
 =?us-ascii?Q?Ekndibo9io5Nnf8pMHpB/KnMQcmndrLea6CFO7k9gVXsBA9OWuu/gKl3C8Et?=
 =?us-ascii?Q?tr2eSWH1EMrD5uUymhVxhB2IkX29abeqrAiPo68Ok/rj1/5rT+b0QC1GpzXY?=
 =?us-ascii?Q?pfs6zU/rJXWG9qV0m2gYibsmf+N+ctkDR9JC8zIB5g61e7yEKuTsyZSPgf6S?=
 =?us-ascii?Q?1R7Ga0zHUyktEm7qfIyuo7UHkFcmuxwvHTVJVd2n53nzR8QsNtlwylmGohjg?=
 =?us-ascii?Q?cUIN5iM2ba4ouWUD7Y5loPexuEigziRqvp1Rm8NGCUb5X/PWMZUnWTaeoNko?=
 =?us-ascii?Q?ThJyWOJbyW7WgHLdPRSWWKOF6PnjcuiLrhxDXeNZIGGgTues+8sDxfo1QVxP?=
 =?us-ascii?Q?Ouxj6v8Xam7+jyP5RRKv5VsoLsxOHyvlv2WTYzAbeHeZR8dJRUARBYOaA7kC?=
 =?us-ascii?Q?f+DK3uhGqgXcXq8C7+mhyj2tSqEFp2PWdThmgY6HtOoORIuIcnSmwnK9YXCL?=
 =?us-ascii?Q?GaR6XIOOLJ9cEezdcLvHgY/pgin9xI4lqsEOK6Fk3uQiqOt4PyK7ebLyAs2/?=
 =?us-ascii?Q?OsgI7jCygKPduAYYuIuB/AhMQ+wQZhQLnIh0v9cSWOraYeHNLaxpUc5gZTpq?=
 =?us-ascii?Q?JAbc8qfWXKQIy/UMw7TB/pwVetjQv942gHp2uYzyDDEcnHuxNnlWk1s8/4QB?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faea793-9620-4cfe-b105-08daef150c92
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 12:04:51.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNxOQYK7qfNg5HGfSsBg8U62w4FywOFMzFXFPJzPGK9op5TokdKMK9Ynpp3LvdnJPPmjahoUVPPakz676ehGVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 06:12:29PM +0000, Robin Murphy wrote:
> > I have a side question, why is the dev_name() of your SMMU set to
> > "arm-smmu.0.auto" (determined by PLATFORM_DEVID_AUTO if I'm not mistaken)?
> 
> This is an ACPI-based machine, where platform device discovery and creation
> is... different :)
> 
> SMMUs are among those managed by drivers/acpi/arm64/iort.c
> 
> > I'm asking because I would like to study the mechanism through which
> > your SMMU platform device get probed, to make sure that it's not
> > possible, during shutdown, for both platform_driver :: shutdown()
> > and platform_driver :: remove() methods to get called by the driver core.
> > This is generally not disallowed, and even possible if the entity who
> > registers these platform devices has its ->shutdown() method pointing
> > at ->remove().
> 
> Yikes, I'd very much hope that that's not a thing!

Ah, ok. Appears to be fine. Looking at drivers/acpi/arm64/iort.c,
it seems that no one is removing those platform devices.
