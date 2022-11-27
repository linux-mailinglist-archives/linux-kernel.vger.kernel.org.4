Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F47639E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiK0XNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0XNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:13:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2097.outbound.protection.outlook.com [40.107.243.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B12DEB3;
        Sun, 27 Nov 2022 15:13:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgLbBizLqpiIpEt7Zfgp6j2MvHiZv3WDBGfCJqVsd5d4eh3l0fqL2VmqSPbw6CFooeJMfSZEUSmH7QgIs+vkK3EgBPMtG7sOxLnitX2ND9o/PiNmsLahyR6MKUzvbU1BrFktyOGJ/MjFk3/zdJhvEQcrxachAxVvVgGyH4vi1sdVV2nIv15q1AMcBNquCD3RsqQ80baPv0iDx8m1Z2pJpghPfrFOhDEz/UMDomvdsGHbrbX0LYOt5+3azXIRtARa7M/NLjhQNY/CkX2cjOg/nJur/EcZIimLRy4GcfuZTGH73Nzuiqm0fXy4t3a90VgiY4+xkA4atQANzJitZLGa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwOVk4WAzQEtZVrUayy6yMDJBttYav6/BsqM94W1+94=;
 b=V56cPY8gxAwQT6Giw8Iq4s9cm3bXUGnaij5synqjQqRTqtyVsd08pUmPAJMHhWuuOaV8iy5MSwJm84NkZUg6GDSSV6Wm1SNUqpejGyO6ku2ehDHGx3jU77R0ODEXj6iXi0it3P+h/YlvuzL7WAEjXOgz4urK6xqd9We+ScN8Jl6Aa6XQ33CjurXKPpAus9BQLIOBzVUtEsdpszjUh+3A6OveUkP47gFWb42W39zz1p3t3KpFIJbEckXrrxm4I9BExZDer5CMUiso0tzmmBoUHm9G+Ukco/80NMThq3XHah4P3iP8q+OZqJgobmoDPCjLB42sww54CUEViq36u8ZXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwOVk4WAzQEtZVrUayy6yMDJBttYav6/BsqM94W1+94=;
 b=Hj5szBAfXaUO0eeh4d0AdS7hp3Kea8msFi1CBqxXDBzfZaJyDLsaNTS4++M1TdTA8+8XBZInAR/PUkFj5i/PTMJYBSNzW+pChMVJU1pEqcVuZu2gyZUgwBGvPZCN312bee4W7WJKJwk5yTeq4cMLEB+U7+zZFfhg6fDB4W1dblE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by IA1PR10MB6100.namprd10.prod.outlook.com
 (2603:10b6:208:3ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Sun, 27 Nov
 2022 23:13:38 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c%4]) with mapi id 15.20.5857.022; Sun, 27 Nov 2022
 23:13:38 +0000
Date:   Sun, 27 Nov 2022 15:13:35 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <Y4PvH1dW3FqHGRN8@euler>
References: <20221123233209.1854806-1-colin.foster@in-advantage.com>
 <20221123233209.1854806-2-colin.foster@in-advantage.com>
 <0a3b491c-7b91-4732-e280-3e49d9da01c6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3b491c-7b91-4732-e280-3e49d9da01c6@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|IA1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc76a9d-883d-4dc6-4a2c-08dad0cd0445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gthqJy+jy6lbID/nLB2DkH3v50J8RP66JnGZy4QLPsEC0hZWeov2G277JaSqJZSwNMsChs6btcoogNQaUPyRyJbUWKwisIqmHGcsztlkckXg1Z2B6YN8Z4t450doyDQD3mivET/10ln6M2b4ckAahLDxL6gJLQLEQEiMeWe+C5Ta4jlbmvYmnrlTW454DA7a1WfBWTIHGoOMB/GOR9IxLJjyWl8Z6I1ysjCCj29kB9yjHFdRHg6KSB1pl4ppqAS0VAaWuvplv/ffuzxBVG/vQA7MknY8wyz+WBay+wJcHJMo9Qj2OkglweyOsEb3Ka9sCGPI4SkdWzoWgcwH+ThCqWPACCKwidMi54XDm4jk9/0BoMg0STcPh5BBSJHv5qZxWugee379D58SV0g6y5fDFA/DNE4KDmg0GXER6NoNoqU4RbQNWQneZh3hNghE2lDqyDsJ8IlzjqgbSvwKIEQAI8zwU9ul4GBNPL539z94cUm2eNTTC1XnFLY998yCq5oZ5Ze5HA88zVR8DvhEzS1DWex364STB1itUMG+P68zVIO9pM7TM69M8k2Lisjj68Tx5+WPcEJaetouttpO+C48CB6w5eIhN+U0ldLe0OHv3xWR6FYhpKAi1bl3FySG1cyzFgFgB/D76CLpCm0mWXv2cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39840400004)(136003)(346002)(396003)(366004)(451199015)(6506007)(41300700001)(6666004)(38100700002)(5660300002)(8936002)(33716001)(186003)(7416002)(53546011)(4744005)(6512007)(26005)(9686003)(54906003)(6486002)(316002)(86362001)(6916009)(478600001)(4326008)(66556008)(8676002)(66946007)(66476007)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F70JFaWbpUrThPs4AOGziIid0IliWu5PLMT/2zKZA2/MqiN8iEzU9AjN/G8E?=
 =?us-ascii?Q?Lzt8BAe5xd3Ed/1vs3KUfS+0ZkoCupqmhsgQlvePy0PBO8TbwC9c/57kfPr3?=
 =?us-ascii?Q?fPHLXCAmkdB4gpIQY5X681sEvEkfoIbGXwG0sub4QlDAPeXcAxOeYXkGqgp/?=
 =?us-ascii?Q?vJ2BANo/xgU1pUOiVyj03MvarCtQbdf8DPNWXfJKCLx9HR/6TdOk71WFgiYV?=
 =?us-ascii?Q?l0E8GByY/KuK2mnBdzPKLGKIo4bTee7R/vtwbLooIVyRE+kW5qWxZ2SwsJHx?=
 =?us-ascii?Q?bUE2Eekh2pyC53v3v4TK96vcQ717ttKkT3fVXSYsANCEVC/PHXmk5S2l7gIi?=
 =?us-ascii?Q?TYPFRDJRnsrXJbUXuP2W0j2UeGUDM2omAudb2hrthrEftodpTqoQrlsBNYxr?=
 =?us-ascii?Q?dJJ/cO+afOGy5WlrTzHVmBu28cSabNMtCPJoRJsfVybDTeN7Tf6cAHGTCaYg?=
 =?us-ascii?Q?xM4voNFvD6rSr1D7OHVZc3ztrd6WwF5vTr7EDYpkTzMUL2S2l/0TN8UwmOda?=
 =?us-ascii?Q?jSj7LgHvaLugdEmfDtoTQss5tzrA5vz8MkNe6LFg4U087q9IfM04007abGyY?=
 =?us-ascii?Q?q9o6XEr0fkRgxPccf+STZ9z2LWeMWWOxGaHWMFf1GAM73csZO8s4LlN/ubBJ?=
 =?us-ascii?Q?iDYm/g714VIzZapgPyOrxFt0yFb6qUHyLal46eoOsQMhIQjubAghbCvj1gdR?=
 =?us-ascii?Q?dkUKxbyvnYyk8jYCN6eZMEke9rU8s/phnVqpnD13aLHS37dSuslLFHLJvpmm?=
 =?us-ascii?Q?SBcxXFHjpP1t/3adqlHBY5Yrvt2uao3oqJcWlFHOecVt1rcB4RtuHgwIjC0P?=
 =?us-ascii?Q?s5LtVCKSGp+bw9+30xXQFdrDiZUNXISkuMxziycCVbBkHHpUCanBxRCJINYQ?=
 =?us-ascii?Q?9PqbApfvr/2bbh8Co571L4F4DgYMwrZOwtbnPgZy1DHuoV3S0Z67kOyZgRRY?=
 =?us-ascii?Q?14tQJJfZckgg7akCsQIM453kgrl20+F71PEOjJY2zER5s4KQ/w4wQT2sXcSx?=
 =?us-ascii?Q?JExjaldW/HOOdH4doiqjvVSHZXR2HZkOkHbpsPwHEeI2Eoa0LDoPHKC32UQn?=
 =?us-ascii?Q?XDPAYNGEIZBMYA/zDc4ygCeXQFCLNKAdBl28C0T6oHb29+yrSc9TvTxoRvc3?=
 =?us-ascii?Q?hjXv0F389tCdvByPQQNRb+jNqZ25dz41nz/swjqZ/smArn7qmJ6tnK1UWAry?=
 =?us-ascii?Q?v7JXSqNU9Tmj+DknfCbM0QnFLuE68bLJ8IOkd7Cf5FAlKB8610nrTcJQyglJ?=
 =?us-ascii?Q?IVJEw2/TL9+138Zp9FVauGZYDfJp1Mttws1hAzo27A58BnqHqPfwmNrgMh00?=
 =?us-ascii?Q?v2L3oRAM7A0oQuzJW3npqTd+W6nva+T+JEB6Ajgo1pTNRCVreTyTvApb3hQA?=
 =?us-ascii?Q?lPid9lQuE/jDgwOCXxZ0lYiQGlvnn/bJwrZi1mHpTy68FUIqW+0cWLDy0haf?=
 =?us-ascii?Q?Pzso+wVipdtauf8ILrzM9GGBnJiFLIiUkBHxn9dh7u5rPQH/nn+HXaZKXEq8?=
 =?us-ascii?Q?Sx9p2eOc2OafpNfPEZmucfwLnbfhp0r0IM0OgsC1Ig9X5nSndVsljSO26UrO?=
 =?us-ascii?Q?aa4s7VCt4ltY9PPPgAOcPABOHowD5ot6As2YyTNYNanvnMGvTuBtqVxEKNzx?=
 =?us-ascii?Q?RHyukM1RngjSiFUjQxTl56E=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc76a9d-883d-4dc6-4a2c-08dad0cd0445
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 23:13:38.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw4a2SE1TFzWC5xSFYZNvAlnkYl7nJL8JZVtxdvo/lrgsPnmYouYm9Vwq5W2wjLdjuHJkUUNFU+D0GT8SVFz6rtvKomoIS2aDkcpx0MDIyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:53:32PM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2022 00:32, Colin Foster wrote:
> > Add documentation for additional OMAP SOMs and development platforms,
> > provided by Phytec as the PCM-049 SOM and the PCM-959 development kit.
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> > 
> > v1->v2
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Would be nice to convert the file to DT Schema.

Agreed. Thanks for the Ack despite this.

> 
> Best regards,
> Krzysztof
> 
