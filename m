Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70769BD2E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBRVv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBRVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:51:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6AC1449A;
        Sat, 18 Feb 2023 13:51:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TudoRFya774Ymo4TgnO51eZoWlMCBlrk0CmlsAl+DsSq9X+uDEHNiFCAVcD73b8/8bGCEABS/KM1/e2ko/7Ej5jlfdYPHEfhjy94RESJ0jQh1A6SxhjIh5FoWuzPvoR8X9MmEVyxYQG9PYnbXjeTZvFmxBqMwTeBsJFyP1dGK13S9Q75VbaB5EU8ocSkzcZn+5sUHK/m0vyDCurQiI+mAhnx0uCUxKWitd1vIR1oR7nvvUADaBk8K9ZmFrz8B0Fqk5VhHb1kKyaRq0ohBBWYZIyDzbp93zLun72FJX0L0TlqNmFfwXPbvb3hVuSj2Pg90tZZdroDzPRg5glwnROGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WikfODRl2vT5mzIiq5BdDFdk8+5mgz31rTWeI/cJh5M=;
 b=VhGpSNyJ99zrpW6n/IPofsEapVPFpyE5r+Nnc1MnijHaL8EY/Td2uyy7w8OkbNzcmEOnq27ZkdNXb0bI13xxnN0VL4SPxgWJJ4F3oPSB/GRu6Z6oUi19SIbiN4o3cvdRG5asAfVGUJhbSc9HvKxzgM13n0LK6v+Vinq25dSsk7VkcC+RuiTZuKELdv8airpdErWazP1/4p0ut9dyh2QZFF4MgakatfatN3fj8gzjt+1GFSFRY6Do+oXShQF+6lN6yhS4JQ6jXEFQJlu+234JjX+ylYTp8nxobM+giY8pZWvwyOUjZexInit/vufQaq8H2SO7snazJk58Sa37dgz1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WikfODRl2vT5mzIiq5BdDFdk8+5mgz31rTWeI/cJh5M=;
 b=J6OsTzlftJo8KswQBynPVs7aeFmf8fY4wcOyB6qGpmMsNg8x27w0tgUsipMUloTpdtyGNJNh1htMPXfacPAnOQeoNer8tfpofbnnwpU454rXWh8flg4RJKxtQdEUBzK/cwxpuffGTMIL/eQBcFOaMbLb+lPQYsksS6AKVUGTqSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 21:51:45 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0%3]) with mapi id 15.20.6111.013; Sat, 18 Feb 2023
 21:51:45 +0000
Message-ID: <b734fa87-c3ca-5c21-d8ce-ad5083461200@oss.nxp.com>
Date:   Sat, 18 Feb 2023 23:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 03/10] media: Add YUYV64_12 video format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1676368610.git.ming.qian@nxp.com>
 <f5ef51d5e0ce881501a3d72a8e49c8a040fc64f6.1676368610.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <f5ef51d5e0ce881501a3d72a8e49c8a040fc64f6.1676368610.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: c632a83a-a2a8-4670-9a57-08db11fa53ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOVcFLyjaaoLdKw0VSU1rEEDoUYJGTKRtclrnXbqEHO7R0BFPfrBAlX65vkrKxzbefj13tOJ46XQmM9d3DqP3VTP57HBL6EbUlwTWUvkzHkN51pGgxJV8hS7ollgFebJbGYOPUDpVX1f7uCPDlxdwnetQemcsfIV9iJgtTKYvgCcO+9dPpcZCmDHFujuFwCgIfr83OiA6/jnx8h7YA7razwQ8diJffBZWNCKRtMRn++7nshP1mTMBrlkSEoODABAlBSu/HI99K7pS4x6lk8t33cG8LkrpbRaL+/seaF5JVeoyE+MMRMjVVfbTg9HZZ7B8w5A+ZG2ek7T9XAmsFsP6EBTK+oTooOlB+zvf387/cR5KOHToRsnzzXH6m3skJLXT2vVxHsDOji6WbuMBq8rSo4Abjm27Qhj5bjKRVt4SNW46WhRN8rEkBT9phhG/dmX/SZU235yKq2U+9mQiPC/6ZW7Pqg1onl1B3nvO0z9G2YnB0/r9nqIDdObaMZ4CxH06K/NNzidjg8PXaqH+RBbcDfmHb3dIrFFYo4yI/LYtXIWoi12cSCzHzP0iQAJ0o7BWNtrMjyVh+uiDy2aQ8PvKPMMG4+MYpp5xY4heAr0UuAXMyAMIApA0+02p0vRx3sxgYc8RPKRTKaAf4BSJPv37UpTY6JSs+mE7o4MFqpVS4wgqcYj0p+LoymV1v8Dqk/mnQDrTF/JtHbkX/s5MUXrFhmceb84W/yQz2TUDb8erv6FrOM6e1QYDKr7wNAVrNEHA0a5A5cbfJotuDeyjXC1lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(52116002)(31686004)(31696002)(6486002)(86362001)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(6512007)(6506007)(186003)(26005)(478600001)(53546011)(41300700001)(8936002)(7416002)(5660300002)(2906002)(38100700002)(2616005)(83380400001)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVloZk1BajBEbXdsV3o3NEVpK1JwdGZnUitlWFRuN1lyMFI5YmxrUzNMTDQ2?=
 =?utf-8?B?eEhVcVJwenBIdVBSa0cxNFFHaFhOdnQ4T0lEY3o2cVBUTXhDalhJMXBkQVBi?=
 =?utf-8?B?MFVKT0NlMDJjR1pKNzN1UmFZWExuK2o3UHdzVnVMNmRwcnk1YTBWbjBzMHdI?=
 =?utf-8?B?TFhoU2ltNitOS1hKNElwa3ozYXRpVkM0akI4RENiaFNxbmNHUGRSYUFsZm92?=
 =?utf-8?B?aC85TFlmV0tUOEpFTnh6U29uSkpRaXprL1BZcllNYWtQUzNjdXpsZzk1UTVD?=
 =?utf-8?B?eWNQRW5OdloxTGR5anhyaG13Z1ZOMGxaenZDVVpucmIzSjljclhWaXBsMjJF?=
 =?utf-8?B?Qm9PS21PZzkraE1RUnVTZjlER0V4S1p2UjVMcDVYZkppS3lTU1BFbW1VWDVz?=
 =?utf-8?B?TjBXSHJoTndlWkgyWm9haWE0a2RVbzJyMjAvd3BaVkpBd1hBdkMxWjdaclhU?=
 =?utf-8?B?dSt6LzQyQ09mVjJDb25uMmlyMndMRHVaZnByU2thcmI3c3NEZGI4MVJLVkxL?=
 =?utf-8?B?T1AvVGRkakpQWnFLS1krYWg5QjRZb2lCMlVrR0pJVUo0dmlCcWtXdDZuV2dl?=
 =?utf-8?B?QlVjSExLN3JyNUxieXpMaHBRZlROWnBERlFLUTR5bzlCdm1ERUdGeC90T2hX?=
 =?utf-8?B?ejF1ZVBXejhpeUJycStOZ2JBUmxxVEc3ZGo5R1Z2Q0xBK0ZMb0pIVnMxOXhE?=
 =?utf-8?B?c0UrY1JJeDQ1Y0JQWVpFYy9ZcGU3U0VHeE5aa1BuZnJsa0FIeWpPQ0V0a0ow?=
 =?utf-8?B?QU9CUkRSQnBqREhVUlZuSTNDU3BCb0NaOUVyV0gxK0twcm0vYUxIWURrMnk1?=
 =?utf-8?B?aU5MVStUbGk1Wk41RU5UUE9LbU9rLzVGS2RmcGdZSWs0Y0ZZN1FpOFB2WXFU?=
 =?utf-8?B?UElNRWNDY0x6ZHNzbXJTUFZXYjE5a2dRZlBYNnI3UFRJWnF5NTVrSG0ydkZB?=
 =?utf-8?B?cFpqRnN4R2FPbnkwckZnY3ZXbWd5dTI0UDRGZ1VsQ3oxY3RrUXdleC9VTHZL?=
 =?utf-8?B?a2pxNUlvd0ozOEtvcnN2WmprWm5jUHoxWHpFNDB6MHhlcTRiUmtzdXdtNmNs?=
 =?utf-8?B?eU80ck9JemVxejVxS1R5emw2SzJQNWFkSXRBYmtMTi85UEZLVjhXQ1pjcGt2?=
 =?utf-8?B?MjVUL3paTzlDNjFHU0pMTWFsOGZBVlB1TGh6M01IeVVGRkk4THlpVThRd0ZI?=
 =?utf-8?B?OTFvMHFlMzFLTlNtNWhmd056SlU4U3hObXhVUklycHdORGFZdWFqMnpaZE1C?=
 =?utf-8?B?NTRjQStBTkc2Yys0VlcyK3hCSlBkelE3SFV2ZVBKcy9QLzVxOFR1VGJ4NlFB?=
 =?utf-8?B?VHZ5TWlaalFyVEVTWGhYVmp4WmJoaU9qdzZmNWtTUlBTYUh6MVZFRFIzUisv?=
 =?utf-8?B?dnovaU94a3ZHY2hHdnk3eG1sYmxnQ25nM1Y5VHhDejV5bEY1aHNNUncrTnRy?=
 =?utf-8?B?ZTFuYmYrWStPWUp1Tjg2TG5iSjVBZTk2bHFuN0NtT3NRNHMvMCtRNlpzU2RV?=
 =?utf-8?B?dFR6VlRXZ3lXR3lsVmpUMW5lRTRHQlJiMFhKTXhvWTNlNU1LbEp6SHByT1JI?=
 =?utf-8?B?RFBOL0Y4M3NNU0I3bnBNSDhEcEo5RDIvUWdlNmVMeVlIRDRGblFVRGl0MGFy?=
 =?utf-8?B?Rit1TjZ3YTV2TlJQMXJ3ZGtwVUNmWEwyUEFHN3RaWm5mL0NHcitDdGJONmpj?=
 =?utf-8?B?MjR3bkVNZmNYck9YUGY5azZqbURWeVdMOWRUQ29maFpBTTdDNlc4aXNFUWk2?=
 =?utf-8?B?OUtFSTFOdURnWlgxSWl5ckpxWXhmNnZCVTRFMzQvOUxsMER5Z2NNT2thNVhY?=
 =?utf-8?B?NGZmS1pqWDJhaW1XdTVRYVBla1JJWXN3TG9YOTBlQXc4eU1ZeDV4M2h4NDdx?=
 =?utf-8?B?bDZMRTRtTjhmL1d2QW9iKzRGT2F6dzZKMFFOQS9oZ0d2akFldU1pYzdRZ1Ja?=
 =?utf-8?B?UmlXNHZoTlV3bm9GWVdpMEZ2NEpIeTQ5aFcySm9KYjQ2NVd6ZGtoMzVjSFFO?=
 =?utf-8?B?eitlQ3M0cGoyMURIUUdJV0lJM3pmQ0tWWlY5ejdRWUxGVkZLTDdYRTJONS9z?=
 =?utf-8?B?YmF1cnpNNTRVeEJnTWR4SFJneFM1WXV3cExJSW4zd0pvNGVQbUlVYVJ4Y294?=
 =?utf-8?B?TWJBVW1DRmczOG80bG5FMy9vVDVsTFU1cXZIbUhnWTIrZnlNcXdwbUxjVWY5?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c632a83a-a2a8-4670-9a57-08db11fa53ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 21:51:45.1842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3C/vickPKpgYSc9JFrSOEJDDP3N0LtbJO0hChTK5+IJafDLsnbswPIetS7r79e34m48GC6hAw0M6b7Sb/cXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14.02.2023 12:04, Ming Qian wrote:
> YUYV64_12 is a YUV format with 12-bits per component like YUYV,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   .../media/v4l/pixfmt-packed-yuv.rst           | 42 +++++++++++++++++++
>   drivers/media/v4l2-core/v4l2-common.c         |  1 +
>   drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>   include/uapi/linux/videodev2.h                |  1 +
>   4 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> index bf283a1b5581..76fc331f126e 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
> @@ -341,6 +341,48 @@ components horizontally by 2, storing 2 pixels in 4 bytes.
>   
>       \normalsize
>   
> +The next lists the packed YUV 4:2:2 formats with more than 8 bits per component.
> +expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
> +arranged in little endian order. storing 2 pixels in 8 bytes.
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{3.4cm}|p{1.2cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|
> +
> +.. flat-table:: Packed YUV 4:2:2 Formats (more than 8bpc)
> +    :header-rows: 1
> +    :stub-columns: 0
> +
> +    * - Identifier
> +      - Code
> +      - Byte 1-0
> +      - Byte 3-2
> +      - Byte 5-4
> +      - Byte 7-6
> +      - Byte 9-8
> +      - Byte 11-10
> +      - Byte 13-12
> +      - Byte 15-14
> +    * .. _V4L2-PIX-FMT-YUYV64-12:
> +
> +      - ``V4L2_PIX_FMT_YUYV64_12``
> +      - 'Y212'
> +
> +      - Y'\ :sub:`0`
> +      - Cb\ :sub:`0`
> +      - Y'\ :sub:`1`
> +      - Cr\ :sub:`0`
> +      - Y'\ :sub:`2`
> +      - Cb\ :sub:`2`
> +      - Y'\ :sub:`3`
> +      - Cr\ :sub:`2`
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
>   **Color Sample Location:**
>   Chroma samples are :ref:`interstitially sited<yuv-chroma-centered>`
>   horizontally.
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index a5e8ba370d33..8fb1c0fa8158 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>   		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>   		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>   		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_YUYV64_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>   
>   		/* YUV planar formats */
>   		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index ec1c9ef27e88..e5002d6fe7ee 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>   	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
>   	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
>   	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
> +	case V4L2_PIX_FMT_YUYV64_12:	descr = "12-bit Depth YUYV 4:2:2"; break;
>   	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
>   	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
>   	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 3d8f89bff33c..3712a36d6fdf 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -618,6 +618,7 @@ struct v4l2_pix_format {
>   #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
>   #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
>   #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
> +#define V4L2_PIX_FMT_YUYV64_12   v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */

It seems Y212 is already added with the same fourcc code, causing build 
errors:

drivers/media/v4l2-core/v4l2-ioctl.c: In function ‘v4l_fill_fmtdesc’:
drivers/media/v4l2-core/v4l2-ioctl.c:1455:9: error: duplicate case value
  1455 |         case V4L2_PIX_FMT_Y212:         descr = "12-bit YUYV 
Packed"; break;
       |         ^~~~
drivers/media/v4l2-core/v4l2-ioctl.c:1349:9: note: previously used here
  1349 |         case V4L2_PIX_FMT_YUYV64_12:    descr = "12-bit Depth 
YUYV 4:2:2"; break;
       |         ^~~~

Regards,
Mirela
>   
>   /* two planes -- one Y, one Cr + Cb interleaved  */
>   #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
