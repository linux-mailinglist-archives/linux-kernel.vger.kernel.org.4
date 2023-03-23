Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A26C6D87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCWQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjCWQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:29:43 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC312A99D;
        Thu, 23 Mar 2023 09:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU0+TqyZCzzL864oV75VKtTUuVoflwtSSVtqJMSTen4Fg/OhcLOE8zdPlTX6GJWI3SagnbsPyCJPjOqG1oX6KRzLoSYlZzP7VvSLxwQ6qTkKCsoCRGv226pHvB1qckS6ntiiuwf8Bacqv8Re2vE7j/qwEGnPtwHK5aWc3ZnZSKuqwAUrSzrNctN4AUgCFyh5H7mRWM/cFIiE6dso+w02PvzAyL1T3HphvbOsu3p6QP4o9HhG81Dg/waBq0+GmZxEmrvD3rT4XEJ9QKpBScW4OmvTkYiqjatFvjfe6i9T9sE4q9u1zmtzMOZWg4oOIPqoLo2KzJ0e/uXcuZQSHoOtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gehGhJYidCAwfSCEXspbzB7RwUDD2SGECeZt4rnTZE=;
 b=TWDdHekV8BTdueZ4+4kSbCVBscJ8p2Gl6LZY35jkVE2DtZ+HkdIwAGdYC6fNhuZLav29dYwUWvhRN5CR7ZehGC77pTn4ZWTutpwjCy4PeV242K0K6jyixu+g/h6BkDKnjQuAOC1DLEncAhQE1rJDbC1vFCrwevEJT7tq7+aMBD1QaZt32wXbgsjnEE7QsLtcSLG1ugjHltqvDHRcBpk3BOEJDp9oizSsEpYTeMZy/8G1MoNkU1BreXzNBBbVVq3nFZcJmSEwB1Oq/NK2zu8YEGRfhj5KGQhSUF+bS2y9FWHM/haWOhK0xDAPExYf+lcg6yikN3BJ2jz5TMzD/aFNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gehGhJYidCAwfSCEXspbzB7RwUDD2SGECeZt4rnTZE=;
 b=eJu57aoabyez3lunCRAw2W2G3IZpnth2pfEmIfI1wQN7tvZhZ2fgldjRjLp4XJQELjVzxCDdZ7ww5a6L5x6UO3MbLVDifC9kPKEF+ceO4Gt6aXTTqekVy0EGr7ZUF3yfkyK+TP6tSJY6cWfWyEU4CF6X5hZIz44QxxaPR9G4bLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 16:29:32 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::215a:437f:2330:87bd]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::215a:437f:2330:87bd%3]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 16:29:32 +0000
Message-ID: <e1e34d00-0a3a-30b0-8627-0e7aea40780c@oss.nxp.com>
Date:   Thu, 23 Mar 2023 18:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 00/10] media: imx-jpeg: Add support for 12 bit extended
 jpeg
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1679461709.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <cover.1679461709.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0802CA0026.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::12) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: d306d967-c7cc-453a-7436-08db2bbbc84b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULIBvvlLDIBkIpE2RhZl3vQNgtVgJvVVVqu1c/T7/OAoyN4TqiZgARCEuP288WJAsclNEbHI842F+lAwfyV8JoDoztPkS9y66NRh5bzNg2+lOs+hNzJAWDsjVBKmIN2pBIlx/T1OETfBmqvMx0E9/DVaXP+ZdAdKcrjhrNjvf7vV1pZxgOl1yj1bW+7KKglFtj70WsXmh/G7lC42KpHgbpH9dNQmcfEwuobiiiL7L3ib0eo5ZRRffW2bfBUQmT//JEA3dUAbW6eZnLuk79KsGndTWMaQotYgETA308TiAiJMkg+wCezvd9kp4TFxp8rXWQqY/8/hItVXlaFRV/E6KGpgH2Rex44OjgH8Aqt7d5vZ//JHzgxcrgH1VBM9yyr25//YOVqMyS4K7w4ldge/TQnfp+0RgIgwJTrvugRusDdKMGyOuRSbpVojkgOb/nHgkMxi/MArCotIMsMyOnNOBdU2Qped54NMqkN1Z/kQ0A9xGMIls3+QsnBw4Gk8FDzD7cZRzDYII7bpADuZEWgHlujAIeB1l8Uq8JFdN2O6awlwQ2nfOesjkD1ON+xJ6xdorY+TZuOba3KQ7mN3x+BMoE23yQxiEkm2w5Q2iYpryXydzG8Qp6cHtkLaxadqjVmQMH5Q92JWW7JnvxfIInYQItpVNE33gToBhPJdGmw8BB04/6qkC9oU48ui1VpyouKaf7D/2wfVtu39sGrQib7Qd05LyzCUYkO0p92l08uqMyY1Yzv94LvZccZ2Qy31a92eFMIccw7GZQ1AJmsY88U1yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(5660300002)(8936002)(316002)(31686004)(86362001)(66556008)(66946007)(66476007)(4326008)(8676002)(41300700001)(478600001)(31696002)(7416002)(2906002)(6486002)(52116002)(53546011)(6666004)(6506007)(6512007)(26005)(38350700002)(38100700002)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxFbVkvcGdrV2ZDaWgvQkdlRDZZZXRzOTRCRDBjNXY4QmRXWjAzNlFOelVS?=
 =?utf-8?B?UWNBcm12K1FpWGVKZ2tUVGVqL2dZK2pwK2ZGTDFkanRRUzdNTmdONE5OUm1J?=
 =?utf-8?B?Sm8zeitSQkxpMWh1QlBnWkFwUE1sRSsvSDZXUEhaVkxsT20vN2RyYzBkQWhK?=
 =?utf-8?B?R1FBbnlKcXdMMUJEM3lWNWQrZDlRa1dZYnE4YXI5MDRFbVZraFBCMmFUSHdw?=
 =?utf-8?B?S1JnQVEzTjJEOC9lbVdVeEdROUFTQWtuTkkxR0hXM1Q3T1VEaU8zWWg4YjhT?=
 =?utf-8?B?b085cnBvMmVpaGMwOG16Vk9EMnZzOVJWQ2xmcFdrKzlvSmNoOGtEejFaWGdH?=
 =?utf-8?B?UTllRDh6Z2VjKytOQTRUeUl2ckJ3OUFsMlpNSzFBQ0RaaUlWeGZaUWJDMGNF?=
 =?utf-8?B?RjJsVmNnNm43eXF5QnJmVVNCZi9GUHVCdnpaMWtKV05EbktNa3Zmd1BtblVt?=
 =?utf-8?B?YnJTV3RVRUI2cEI2N2xNakw1eDFLSmhEQytzcVA2bGh6Y2dvQ0hVTjdIRUZ1?=
 =?utf-8?B?anZzbnhMZU55cnBmL2tlZEduc2FQSzBjR1F2U0luTlZSSGhIQWxBem1QVGJH?=
 =?utf-8?B?YzZqeU5RZUhrNlZnK1kzUXhJZEZ1N3BDYlBGSWRJd3N5dG5PVlgvU0x5SHdY?=
 =?utf-8?B?RW4zLzRnZEhTZmJlcFdjcm1TY2d6Z3VNdi9yMDI2OWxpVzMzY3djOHBrVCtI?=
 =?utf-8?B?MmR2ZGZ5VitFTTA0U2tkNkgvU09NQStPR1VuNms5dzlzdUhRVGhWUnk1NmlG?=
 =?utf-8?B?QmFQUzJRcndpamVJSXROeWdadGdrZTNuZDRZNDhrWHlEclNoY256YjRqTlZj?=
 =?utf-8?B?VGgzT1NNdDhTRnczR2FDVXppTEx2R2pnM3RWdVlkdFNvYnlPZ3BlN25hcnFw?=
 =?utf-8?B?WGQwSENQVm5OQzNuYVczTlBrc0pzRFE0cnE0Nk1qTmFJV0MwRldRb1V6d1Ri?=
 =?utf-8?B?Y2JoUnNsWGdDNlNncTh4bHBmMXhCWXhLM1JHSnh3b1o5VHJ4TlpQeURvbEh6?=
 =?utf-8?B?dXI2dkpOZmxmVERYRGoyc1A3R1VqOEJ6K25KUGVmY2RFZVMrTUlsU1RIcmtm?=
 =?utf-8?B?Y0NKZ2s0VTlDZzgzRmJ1MWFFbEhBRjRrQm9ocXJlSmQ3bDVHUTF5K0tYSm45?=
 =?utf-8?B?VHNwTE5ZdXNYdjV2UTFvMFdQS2tSVkpRdmJxNlBnbGp4ZjlNbEVSMjhUdUhr?=
 =?utf-8?B?aFpHRTJPWEFPNTBTVTE2Ni9yRkQxTUFZZk5EUXBJL21VNDl5alk0b0NxSFhM?=
 =?utf-8?B?WE8rNWNxRGJUWldSTGRXVmQwSWlpcW1pRTJOc3hzWlBCcXVMWFZ5TmZ3TU9L?=
 =?utf-8?B?TG9NVTZqWEJodytEek1PbkhQUUd4dWZLMXhKektXcXRzQjJGOWMwV3hjUGtz?=
 =?utf-8?B?UFhidHUzQWtxMkR5SWEydHlVVWUzaE9QTnc5MElYS2dJRGJJT25SblVqMkZ1?=
 =?utf-8?B?SFd4bkhpdDN4Nk5LSlJsMTBUL2l6Y2gwNys4N3VkWU1sMit0bW5WN0NBOTFs?=
 =?utf-8?B?ZW9abW9razZYUTVlL2c0cXpJWEl2eU9MbXY4M2loVkpXREJ5LzhNY3cwSGkv?=
 =?utf-8?B?eXZpOHlYeEJoeGd1cXZyN3pPMnZXYVdlODJGRlU0eWlRdHVhTVpaN3hKbVI2?=
 =?utf-8?B?YWRySnc3UzJqVTVPM0VCWTRRL1BvUEMvYmNKbTJrbm83Vy9QOW01bmxpZ0I4?=
 =?utf-8?B?YVozQzhCSUE0U242TWVHNGdzRGZvK1pPOVZEUlJkUnI2TGFQbzBnWDdrUUlO?=
 =?utf-8?B?VDB0QWhjMmludDUzQ2NGTlRXV1FTMHVucFdPcnhQaGM2bjhDaVNuS2N5dVRu?=
 =?utf-8?B?UjFMcUxuRyt0OHV1TzB3c0NMZmVkektyaFMzQ2tCeEZKY1NXSm5FdHdPRmtk?=
 =?utf-8?B?blEvcGFVdGFTQ2ZwZ0xOdXVBd09zMVpXdTlDa3gzbkJ3OUoxa2FRcmlCcTlC?=
 =?utf-8?B?bko0OVUxRG51QjRubE1FcmpKbDBEeUd1bThjTHFKN3Ira25nR2dJaGhNWWcw?=
 =?utf-8?B?UTRIaFRSSjFJaHdaSFlMY1pQUW1WRGJCY1BpUUZ5ODU1ZzI3MDNxUzE0Z0gv?=
 =?utf-8?B?VHFlVms0UmhabjZlTWludGpmeVU4bjBvNlVrK1kyaHAxKzY4a0Z3YUQvbjVN?=
 =?utf-8?B?dGhzUEx5YW5MK0hGdnBSeGhKeXZxZzF5UGxmOHdRQ0N1NVZUZWVvc2tsWmFF?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d306d967-c7cc-453a-7436-08db2bbbc84b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:29:32.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUx0NiQWiMo/x8DIzIX9nTvy0U22qdd+Ndf79qcgREv/vrD05rPvC6kG9PYwXXa6ZLbQsGr3FasvpyYmGW+IBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2023 07:13, Ming Qian wrote:
> the imx8 jpeg codec support ISO/IEC 10918-1 Standard Baseline and
> Extended Sequential DCT modes.
> it can support 8-bit and 12-bit per color samples.
> Currently we only enable the 8-bit jpeg,
> and we can enable the 12-bit extended jpeg
> with the new defined 12 bit pixel format.
> 
> v5
> - fix some description typo according to Hans's comments

For _v5:
Tested-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> 
> v4
> - drop format yuyv64_12, use Y212 directly
> 
> v3
> - correct the new 12-bit format naming according to Nicolas's comments
> 
> v2
> - correct the new 12-bit format naming according to Hans's comments
> 
> Ming Qian (10):
>    media: Add P012 and P012M video format
>    media: Add Y012 video format
>    media: Add Y212 v4l2 format info
>    media: Add YUV48_12 video format
>    media: Add BGR48_12 video format
>    media: Add ABGR64_12 video format
>    media: imx-jpeg: Refine the function mxc_jpeg_find_format
>    media: imx-jpeg: Clear slot next desc ptr if config error
>    media: imx-jpeg: Decoder add support for 12bit jpeg
>    media: imx-jpeg: Encoder add support for 12bit jpeg
> 
>   .../media/v4l/pixfmt-packed-yuv.rst           |  28 ++
>   .../userspace-api/media/v4l/pixfmt-rgb.rst    |  42 +++
>   .../media/v4l/pixfmt-yuv-luma.rst             |  15 +
>   .../media/v4l/pixfmt-yuv-planar.rst           |  94 +++++
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  19 +-
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   5 +-
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 326 ++++++++++++++++--
>   drivers/media/v4l2-core/v4l2-common.c         |   6 +
>   drivers/media/v4l2-core/v4l2-ioctl.c          |   6 +
>   include/uapi/linux/videodev2.h                |   8 +
>   10 files changed, 523 insertions(+), 26 deletions(-)
> 
