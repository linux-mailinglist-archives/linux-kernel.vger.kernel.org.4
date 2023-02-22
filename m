Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF469FDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjBVVkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjBVVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:40:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39531E2C;
        Wed, 22 Feb 2023 13:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0vw86dECq4mRKMhDOcjdZtW6FbHjlpwZUiV/BWNfiBTT95BxsuWkS5rNdvOPiwmBe/hkyh1UOMAXLImvUugbviiZ24d0c1LckhYXBAyb1EZaFf7zJMbK4x4c7Vfbk3Po0rr5XTSqApsg2BRyYgkcWrgioFQSB5R0Os4V5rNpUMyRLC/K7MZ+ybIVnE+7saY78wrXCme47sTOZQp+48ijoJCfPQRZwC8hEmAyEZqKd4YP0e0v5y0Ndp8nXScyA308AsDl2BfYCmoQ88Uhnpb/yJu0w6kW0UyRb88P+q9dZPESiYdBBMpnqTmMfVx2fjfo3WegC6hRgljjzU6OBOI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l51WrEul67T5+R+OBWm+n5zpCNF5OAppKutfiJtxOVI=;
 b=Nyw1vMZBhsWmwRt0REsqpnjRTYfof2ZK5aNLJjiMAZmN3OIJh7fWbvzssmbPmc/3R8uDhjAJ1tOUtL+HXAq24Mllot87zQgbPJGJ2EUbqBo0cjN4Gc3jWdXUJMLx7RZA1yTcv48rndllRTN87P1c+I8G0NB9QJ+LZssjuNaPltC9ARrxBS8HQnKWjuh6Q9jQXYcx5LTEfnw0v+a3NhpP2gl+sBdOPPSpvNp5DKR6LUvT8Z/qEsluBavPeEcGqxGe69XjiWdni4TrdbiIbgC+0R+u9FbHxPU6PozKGb/LbH0peoGo/cCzMBfw6IZIottUVCpyCMcdZvCKaVPKqV2Fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l51WrEul67T5+R+OBWm+n5zpCNF5OAppKutfiJtxOVI=;
 b=kkQTx/e2x4A91SdcZGnx/llT2NW5CXyR8L1DVa1QVuw1csbQCDgAYi+rafrMzqazms0ZPhLhN/WTOr/YWMx7qq4YDjEUn/yhXDNa+VIKiW4jx11BnKICMz+1dQnGD32Y9sSeW/3r1gVo1djPFA/Xxb7drPD0N9KljvSyNuwSKos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SA1PR10MB6446.namprd10.prod.outlook.com
 (2603:10b6:806:29f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 21:40:45 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6111.010; Wed, 22 Feb 2023
 21:40:45 +0000
Date:   Wed, 22 Feb 2023 13:40:41 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <Y/aL2fquXe0aJleG@colin-ia-desktop>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
 <20230222203847.2664903-2-colin.foster@in-advantage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222203847.2664903-2-colin.foster@in-advantage.com>
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|SA1PR10MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: e81494fa-02a7-48ed-4d44-08db151d7452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyWS4SNo5QAqwkQmaVWbaPNKX/fp1t36D1g66UplZ5QG1Mbr0Agm6vEPNfJ+R5lM5yNjnx9f+jlB+Fy8Q4JhT03xfpgUp5ZNEJPwwTMYwQw3a0szzp3cOQs0Xshov+L/bhwplCMz3LNI+PeUarxE/akPzlSPu2Q3hXSi/fM1hfCHcx5n0P6cAn0Z42oEZK6P/c8+nY6Py/AYjxJzG7pJbKTQXtSkVxW9vz+NAs7zy2YLpvQZTVn5n8iGXfYogQpCGJx5bOtRWc+d+GP2zGgzksqbCbKaEPVBW4Ea93vESC2u7+CXCWRnrDVh+yw3xdazD7K/9WqZJVrowHkZ8QfFRg7IU6FmGya7jryTSl7o80L31z4hPJhumdEeSqnz9e+V5/PqpUcukjaopPfYx/5mw5KlWQu6B0Sz5rUKncNBHUSTX4mmD9mQ9xMeLbMqEwKUsk3bf0S30Gyeyr9BflPfZshhpoVJD+jjtxdWqHXZF82gwOFLnm1n+8SeWLyd6YdXtVkMZSwJ5G+cQAJ5OcdHkI957wZInY+Q2Y1QUBzXD7dkwhomnXXYKgxJ3sbDIpVNeJ5mT0FzYqSoSlfPttdFUgswv17ubK02sZzeDy67cjKGXIot32GrOCOhLotFsmJD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(39830400003)(136003)(366004)(376002)(451199018)(86362001)(38100700002)(33716001)(8936002)(54906003)(2906002)(5660300002)(7416002)(44832011)(4326008)(66556008)(66476007)(41300700001)(66946007)(8676002)(316002)(6506007)(9686003)(26005)(6512007)(186003)(478600001)(6486002)(6666004)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVkYW3I537pQzMQhhuU9y7BWc7jxQug6ejXf2XuIalYjcuK16QTctJutke3q?=
 =?us-ascii?Q?AGb4c9xdqJvnLuzgiWptvGRwM2Y5xIbABQvTsHFRgqzRuT/YFT6oKlUMHt8I?=
 =?us-ascii?Q?2b3hsCnCiJauL/X/Nf9fz1u4Q2oeo/jX2xlOHpFDPdEqyx/D/2VLgx06WGPE?=
 =?us-ascii?Q?ps9UzndRLxBQ3xZeTgxmhwc8mOYNrB1rGIdRi83okVQT/qmJYXhPZVFoOGET?=
 =?us-ascii?Q?42uGJxL1NCIa8D+XiLWTmKkHuvQ4a7gGo7J21d4zs1q2+okpNo+qpggq2Rkw?=
 =?us-ascii?Q?wGfBr0kgeKtOV4p6SqDgQzC/ViawuzzonrTbEzCmtmI/mEzSdyvbU4avSGVx?=
 =?us-ascii?Q?g7mCTjyDEHyjBTng0ftOVP6AdO/7B53XqCqpEzeS6G4mutVbwvHX+UlOWnwx?=
 =?us-ascii?Q?3qrenni+DYhwXqBEb3Zu9lFFVf2sWaqG+sw75EhgOmU+cWnG7+/sOjb+Qv6U?=
 =?us-ascii?Q?rxYmvHWFm4pjwt+X1fKapPIyxn/jiPC8QBhV8Tg6b+prJI9TIyd0lWTdrgrZ?=
 =?us-ascii?Q?kHVClHy+3yVAcn6x7DZ42ocI27Zn2gX74THiJ6c7qoCiqGgkve1dggYLlxOg?=
 =?us-ascii?Q?u4Wt8Oe5ibLnKrQ6aKjqmjVSTvPUyshLn9RUB4VVhDUmy3tLOFF0ifZ36Mlc?=
 =?us-ascii?Q?qprX0Yj/YyjGVPx/WPXAPepDTMhR+IgIjiaUdK6Wy+VPHaTkpzHs8mqYuJ9t?=
 =?us-ascii?Q?fngEylThBSaqO7WHAWrIU9l/0l87Qk+eEItp8KR2pA/7DhYr1bQ6xTc91yMx?=
 =?us-ascii?Q?QF2CvWJZoZdo5dfq57nDw70Cv0jtKV1RaTnMwEY0sh08WE67r4fqgCeL3A2m?=
 =?us-ascii?Q?+xT1pNb+MpOo4FvhN3n1yayub3f4Bhsw/CzlRMd9oK2t6GwQA7uUVRWx0t9K?=
 =?us-ascii?Q?Uxl0Z+tPMbJdoMEGwJoIrLLhHPhQb1qy7q8a+JBnxY9e5mpkwcP5al3AwuG2?=
 =?us-ascii?Q?oVQdJFAzIBZ8obnf5JLIJ1bjHUq1WoRH9DcGcZkMl2ZVwAgkay/+SMjDfRJZ?=
 =?us-ascii?Q?UMZ+/BknDpyBethkvuDNuxI/0eZevEPUNZvqUDT1p+YARGwWspk0lmwT2HuH?=
 =?us-ascii?Q?b8PyanPHKVNkXF13GZ7tzRgB4ENWVeAGlrey5dc/jlZCHlhpl0LonpUOFaNO?=
 =?us-ascii?Q?3jol6RC002EtWSfMcQ62RewzfTjd70u7Cb93vCpiGrq2dmoFNJZvwEP3IOIY?=
 =?us-ascii?Q?TOz9Iu+IyqDWqLHn5ayfp/p+0XlucNNOhF/MPIbVfgQF0jkjaRq30zUqpwaa?=
 =?us-ascii?Q?Wq1ANp4RdLDwIRw4p/27Uc/dfOZ51zc3Ra/2FIfmpz8/AX4iaOdCfRJsgODf?=
 =?us-ascii?Q?9RUot12x+WKTJqZStr+O3+2yweY9nNwP4sp0jg/Ivx0zQL7pdGAXeKyt/J89?=
 =?us-ascii?Q?uSdnh3KMMgtuGBnA5VwnlaT7SVQYUykEZl9CXo6jvhd3RjCp3R6u+cWaLZwP?=
 =?us-ascii?Q?pZcIOYTWhVRT054do2ZObgAbwVgVpgmuz5RYGkGIo4GlgJLh/9/mHnC6E/UF?=
 =?us-ascii?Q?ykrB/8Iin9gNk708U5MJWPvLD0p2QlAd7A9ojxy0TAqnc6KY7+i7CiA+qXus?=
 =?us-ascii?Q?Ko9ft4chjclsMZf2gceDLJUiBBdfSI9vJBxk5OfGbrfAndKbdvM/D3LbImO2?=
 =?us-ascii?Q?7e4lPByz19EEyePOKy2vZ4s=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81494fa-02a7-48ed-4d44-08db151d7452
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:40:45.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbKGp9AYiWuvnu1eWidGTsdSnZW1PMnh/7A1GpYEYg0Bf24/+cbbA3CWQhuWkUpNVE65cM9ZvexHeMXvVLNzW25eKy6Fj8FHPlkfilDi88E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6446
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 12:38:46PM -0800, Colin Foster wrote:
> Add yaml documentation for TI OMAP devices for the Phytec PCM-049 SoM and
> the Phytec PCM-959 development kit.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
> 
> v4
>     * New patch, based on a WIP from Andrew Davis <afd@ti.com>
> 
> ---
>  .../devicetree/bindings/arm/ti,omap.yaml      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti,omap.yaml b/Documentation/devicetree/bindings/arm/ti,omap.yaml
> new file mode 100644
> index 000000000000..9c0e08f74fee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ti,omap.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ti,omap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP SoC architecture
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description:
> +  Platforms based on Texas Instruments OMAP SoC architecture.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatibnle:

Oops. Caught this typo too late. I can wait until after the merge window
or resend next week. There's probably other feedback.

> +    oneOf:
> +
> +      - description: TI OMAP 4460 SoC based platforms
> +        items:
> +          - enum:
> +              - phytec,pcm049   # Phytec OMAP 4460 SoM
> +              - phytec,pcm959   # Phytec development board for the pcm049
> +          - const: ti,omap4460
> +          - const: ti,omap4
> +
> +additionalProperties: true
> -- 
> 2.25.1
> 
