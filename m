Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751B6E7067
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjDSAVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjDSAVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:21:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588483C9;
        Tue, 18 Apr 2023 17:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7HsCq1PtUyvcMkdNdZEkIYxB/gUJHVgOxpAHHO9a0DkMjLPXWxu638F8Jon1e4AYMm1skRfuNVhu+77KLMU7krmzC+ZQIPa4NVl857TqCMPpnqLMdMrT/14M+bgjQLolu5v0mweQpncn1Yed48IZ594zl3tEHMjjAHSOgeF1moZvBw+GmhWZcLblcIn0cAg/pt8q6Ht1iyXzFybAfXDwf3Kg1+ehjvSwZPh2Lc2uBPsndGSAJM6I8JnMRFJjKyr47x87nNtXp+HWwY2vv888Wd72lHVj/HzHwtgh9H6+wIdjI+cCn5c0m4hrWTIl5+vNpNNbutb92X0CaCcWuMLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDz8MdRdOw3ROKacK2QBhgLhogSC2YDQuMwCGGury9Q=;
 b=IGVqcMD2l/VTSR5Fevdzk4uKI/RyT583ljBIzxhJ0ZXDyRxhA22Ie5ob9ePXmA5FqnOJLOkXzBgNZwNOWAbZ1FfIlZEMxDfovDeB+bzp6hUlNGsSvYzZPl6BaMtONMzqybJsyrq8RsHigCs1+g6Kvaj21KLbopS99nsdVfYMGnDT6gjTz9yPCPC3yqwppM7VWstWKgURV2yorOUz598GmrebXH/LQMGPNCBLbrRRa2P9ZidP4pjMZoVteFZgjW4Qs6e0v2iodIL33/DaW05E+gAlAqBBEiNagN1ANBUFUOBpAHtl9U9wYshTnkdsV12Lw5P3ExwhtMNmudU4/JD5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDz8MdRdOw3ROKacK2QBhgLhogSC2YDQuMwCGGury9Q=;
 b=EHs1hFFyUz6ZPe9Y1MtNNZ+t29oo5adHo5ItIjGRFA7C9zDNurHJ2M3Z8zs7iGlTOv05ysEj5i1pigLPXchVmZ5qPPynG3v8PgBYBGTVDht5ogwZc/Fm4CEUpcVgsQdgrTUo68BeZ9Yz85j9i+enSDKMfBY2wFKID5alNNWoDgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB7621.namprd08.prod.outlook.com
 (2603:10b6:510:107::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 00:21:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 00:21:02 +0000
Date:   Tue, 18 Apr 2023 19:20:55 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fei Shao <fshao@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend
 property
Message-ID: <ZD8z57MBvcfExJx8@nixie71>
References: <20230418124953.3170028-1-fshao@chromium.org>
 <20230418124953.3170028-2-fshao@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418124953.3170028-2-fshao@chromium.org>
X-ClientProxiedBy: DM6PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::27) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a990de-7de2-407b-ced1-08db406bf48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vvmzJ7t9VYYII3QxoxTmK8fFZfdJOkXI/1bF4iih7IVCpe5HxBPuCJTChuvgQNYtXAAY7ORMxmUsmjChgX5BOZ2ZLqSPAqFmr+Sz5D5JRMiuACuiUmICIl3teUIPimJ1s4ccE1aeWRd1S6JENq5G6LA628ySLcSyDaCO3W34EagBeF4Y/qwsAXTIIS6SXIy5D4Go96V+/oLtOlfXtfMSkyj7WwTE9QJZCsTv4nsN2mAnLF/UPqhYfGHaRDoAEgWIY1KeIt6VNKZoJQhR7Gpqk9ZyDYRTIESa/ZKh+DqpkGt+9onLCzPj0VywHnIe8LS+jpuLqq558Pu21j4ZjdWN8OyjlBJh0zInTTUrIwsxcjH9sqAEWOWaOtFDlP91CGJMwO4TpybHDVLP5jZRG2Sunz8RlxDCX4YcuQZxMMaAZ+Luzz13JH5Q4xi9obg/YsUvUy1P5nAPX9gM7DcgDaH5UlBVeV1HoQsS5lPFr2RqIV2mohQWK0LE8OmplHD4mv+vNKMjBCuJbBuq9yIye9nYk+hmJrje3yh2FJs7IYQYdGrkoZZk1nu7gFEtoStWDws
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(346002)(136003)(39830400003)(451199021)(54906003)(6666004)(478600001)(6486002)(6916009)(83380400001)(316002)(66556008)(4326008)(41300700001)(186003)(6512007)(26005)(9686003)(66946007)(6506007)(66476007)(15650500001)(7416002)(2906002)(8676002)(38100700002)(8936002)(33716001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcMCqy5sCQ4cgECxVnI6jdi0Y8zjURklhLFHzqJoIWsXi/z/qDd5Rt4GazFO?=
 =?us-ascii?Q?bH0D5YLcqZf/23oorzzON537SBMVExFt/j13mbLP4VjQe/Mjj2u+Lnl6w+R+?=
 =?us-ascii?Q?0v+4DFPkZon4k9UeNADlHanolRqDf6lWi9oFK7Wok+Y8t8y7QKBT8ZF7aRZT?=
 =?us-ascii?Q?9bnsYe55i8Qa9hjbkYelDYDJBK9ga0p/+C1Lx0jOCF8Hg2kfrk1Od6uhyWxW?=
 =?us-ascii?Q?xiBXpiLcXSk3LY2suyvzzs4SIIVJd99SEHWMIy/vVFrnwM9nAVXJ0tYIn4Jv?=
 =?us-ascii?Q?ce7yOQUucl8dtgWpXg3iTr8Qf08PIY7ri7rwcp+oSCOhnqQQIXeqoxKvbQCW?=
 =?us-ascii?Q?+ftDtRpneUSbw3oEKF2oWrEJFH9XqFWVzkyr8uyv40dFJTHgOkmSa5KW/aR8?=
 =?us-ascii?Q?apleqilqAl6IcmKA0kdkgqANZqNqMvLfpn3htCUYrmsm3RTf3Mgj6WHUEQ9O?=
 =?us-ascii?Q?/pNIjIvfcvabFT9NoVpHoyyn45/7Pwo8nXHa8n9wajY9TegxY9DxHgSKuB92?=
 =?us-ascii?Q?CG3J1LRoyh5e0OkHdP6SJrqra5d3WxfjdnGKuol6Mdz3sBUv+D2Tf6ov0jx+?=
 =?us-ascii?Q?SShJhzGkeaYKI6w43mJu7tvut9k75+QI7egzsztirbNBl8/ohqhf28gndaP6?=
 =?us-ascii?Q?vSHDYSBsPl/GXxNB5s42C8U2d6oksirbrJWIW3WUhZao0lQR1EsxLS7H+hVP?=
 =?us-ascii?Q?jZ/rlqkhOw8SDrlxmC1dAJ0WTGSIys4nWQLVEDRyXRwiJXNv1/nl3C6W3HzX?=
 =?us-ascii?Q?H/QWymYTUmPl3a/g0DMOfqg3y1lJdeeSwpVniYq2DI3rG1waEmkYnPWqf7x3?=
 =?us-ascii?Q?CdxKeOkLdCKzxbqPRpx0Yh9BtkC0D05s7DhjXeroURkURjlGKQSfg1UhTuqP?=
 =?us-ascii?Q?n3mzsdt9hixLr7tytEo/XpxedXyF9HovAK1kWxuImMzgD/Wcv7pusMFk7cBF?=
 =?us-ascii?Q?PQQ8L7rwqcS4ndWVfBRfrRKDghAcpB6MsNsgXdLyeLVRSfpI6VfH8j0yi+aB?=
 =?us-ascii?Q?17Kdwit8F7ZWGAoM1XOG5TXQLiCBuvavFbLbXs5iL9Is9l+14UtzIRnJ+qwO?=
 =?us-ascii?Q?MXeaLwqY+jnTKmf/15zbQYqRnvNTe6ZRAXamPOoJh6r4TBsrSPC6AaJ/7+hK?=
 =?us-ascii?Q?S/+zT1IEEIJk6b2vwFF5IlR0e6uu7jd2XSZqmXsERQ+tLCqB3JlCcns9M5rj?=
 =?us-ascii?Q?f5MRtcUWIc0lYAec7bDc4nTshYL5uDSV4f/Ci87gpe3ZRpjwzDRDAd29L5JY?=
 =?us-ascii?Q?vn7ERJKaAZJA7KScAnZIHxhRPylhCjuxKm0LR6WJSyMbxWWroBRyvQ3QffX8?=
 =?us-ascii?Q?U41pUI6AE+k+t3DjxtUGDV6Z41L+Pyk0Wty6tix8y4xntbV4mkEM8CJOw9vf?=
 =?us-ascii?Q?N3vi30+1VRmNM9ODnlepZoUR4fHPKHipFNrKN0iZiYAjOH5W45KrsRmHbcRI?=
 =?us-ascii?Q?HRbqMpxr3O/XV/Xf0gY5cSESpFd556NmJGDMbhBuDj+h1MJUUUA+TBCxWQPR?=
 =?us-ascii?Q?OxSCLxyP/6Cy7J2G83zoggHEiA4KJgT/Lmi49tx7NPMzLouCWmIemWtXaPoQ?=
 =?us-ascii?Q?iir2PnXaD/aRi1lUextLrqfAoMD271nkDTF4Ek4Z?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a990de-7de2-407b-ced1-08db406bf48e
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 00:21:02.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrTTaYfDA04YS3Y7lem3YQ0uQt1UubG/LdhZGno9ig15p/Y7H+idXSIsimXqQzJF54r8n/GJWuv0qHhD65ewhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7621
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fei,

On Tue, Apr 18, 2023 at 08:49:51PM +0800, Fei Shao wrote:
> We observed that on Chromebook device Steelix, if Goodix GT7375P
> touchscreen is powered in suspend (because, for example, it connects to
> an always-on regulator) and with the reset GPIO asserted, it will
> introduce about 14mW power leakage.
> 
> This property is used to indicate that the touchscreen is powered in
> suspend. If it's set, the driver will stop asserting the reset GPIO in
> power-down, and it will do it in power-up instead to ensure that the
> state is always reset after resuming.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---

This is an interesting problem; were you able to root-cause why the silicon
exhibits this behavior? Simply asserting reset should not cause it to draw
additional power, let alone 14 mW. This almost sounds like a back-powering
problem during suspend.

If this is truly expected behavior, is it sufficient to use the always_on
constraint of the relevant regulator(s) to make this decision as opposed to
introducing a new property?

> 
>  Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> index ce18d7dadae2..942acb286d77 100644
> --- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -43,6 +43,12 @@ properties:
>        itself as long as it allows the main board to make signals compatible
>        with what the touchscreen is expecting for its IO rails.
>  
> +  powered-in-suspend:
> +    description:
> +      This indicates that the touchscreen is powered in suspend, so the driver
> +      will not assert the reset GPIO in power-down to prevent power leakage.
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

Kind regards,
Jeff LaBundy
