Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD46C6D77
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCWQ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCWQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:28:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35711199DE;
        Thu, 23 Mar 2023 09:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpVn35kiRLuMNolMl0TdqDgGSaf7SoBbxFBubGN9uMR6J7Qq6P2OlxOEiA04qk9JAZ204a5IaRjQ2zhviz7rfh6Apbpk+0Ht4Fkam88Wku53Ep+bX7WTK2d4wepHiDoyNdQAte1rE3tTiAMFKo708xJEIxu2A0xco2TE4vZqtVA5+yvsBoeep6KYMI3JDoIhtUW7qy1UmcwYeS2hiqCsaHbOIw3FGL5S/FxIzugVJJDNziK5IrhIstrVu+6m8ME/TcXNv1IoCPGaQ+OGJkNTKuJVvruAVWtSzb0umAW8vwqLMKUchcuZTS/HnCSw7Gc1AC4ZT6/vww00w8fCpniV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1r+8NFCVebsjkEBjRZ38iRFFou5ibwc1DOB7Y8xmRU=;
 b=PV9v4T/bJNA4nD0IcphIJbz3Zjbf5tqMtngPMxHMKAXkwDqRQ0QO18uoq8MEhLwHg7JVgZx7eVQToE571ypgRmbqTbEsUA6OgwJCV1+667Q6++D09F2vYtMwWf1+Sb9zo4U695V+lDLCsfF1Chrt7oLRK46tkGH8Av/JOndi12jBm4GcbMTCdxX1QaBulOxzLSotX0ZISwGpJhhB31m4s64EEwHqctzHAbmXQEQEYYiCeQmqwkVxIYnfR9FBfU4Tz5kwXC92jzYFQEsZx/X53z/WGG8/z6PIC6hKv5bnP09h3CMqfAapQqDk7NaO89LmKeLLx6kNI6ivpLknCeqKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1r+8NFCVebsjkEBjRZ38iRFFou5ibwc1DOB7Y8xmRU=;
 b=JFqQ9gmcOR+qKPmThvw57+9z/GCIDTghTuj5NffXQOJiMCGa02Sk2y1ZOs5m3cjSaaCMmqOXs179ydGCHmfXKqUHQ2dToselOjI4h5kPcnGCfP5OFrOzBx4A7zk9nuZ67s8Tvtb5AWSiKXAhr61VbVdIB2sIqbkhKUFIl6X15Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PAXPR04MB9374.eurprd04.prod.outlook.com (2603:10a6:102:2b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 16:28:21 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::215a:437f:2330:87bd]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::215a:437f:2330:87bd%3]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 16:28:21 +0000
Message-ID: <3be4b989-816f-5c1c-2d4a-99eccb098757@oss.nxp.com>
Date:   Thu, 23 Mar 2023 18:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 03/10] media: Add Y212 v4l2 format info
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1679461709.git.ming.qian@nxp.com>
 <a92bc69054de555bec1d58ca9b767a49d21a6ebe.1679461710.git.ming.qian@nxp.com>
Content-Language: en-US
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <a92bc69054de555bec1d58ca9b767a49d21a6ebe.1679461710.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0802CA0025.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::11) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PAXPR04MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: 76edee3c-08e7-420d-f27f-08db2bbb9de4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C11HPKZFd91R3Cmw2c+UtDT21EsYDQGbrSm4lzx2gy8Kp8+ns6X1Jo+67u44NT0l4rApzHzdkTeMdQ/0ZPo9FWyN+f77xXWMWPgl7rliC7lntjPkoEd7bScQJAniDNrrZQydOT1lEHVDRk4LQYQmvmggwaD88EMSxqdCUqwJbgtj4eNDOTbwdqjBGQ2ezQJLM460yayxrQztNF5EysSFZpIz74PMvfcd2DyXGFz4nLasRxCWpTG5spN9KLd0cVMYlUfbVZLAATOGFJorPCKZToSgO/wuwK7HHvm0upCjEtA4OgznUb2ENa5x5MS7H37K18+VnrlGEfFc8vWBjpnVeRr93I0Hf+t5wToBlV2mMbGgOstoy2EJ6NSoNPGFfcwqkEAMj5vtsH7h7kvmyfNG+ppuWDmva5psQP5R61jeKHdkyyNXxIHnE0zJJ3IL7smXGz3On8gT9VgXViFee8AfjYnGbXZxcVvjTc9O6cGEEapKLlSq2gcmH9thJoyAKXCA+mfE089JYBvnaZNQ/MRaLeFvXZT5qRjNOXVamQk7rbO8Lm2UuCxegNSOtqvxEP/Hy300k97wDLt7SZnH6l6hbUf98WjOXllBZHtS9/u4ioLSnHNJqroIl4XLyvK4yrW3eHujA9WZpn5yNIpkWGkziZl9WpqjkSfrth7Jd0WkmgfrAoK7IuBfjWFTLe84qEvoa0QE6oSX1GuyL+GhZyyVMHjzT9/Afu42IYnlzALwlRtxcdaas/NiB3EE4du7O00h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199018)(31686004)(41300700001)(66476007)(7416002)(5660300002)(4326008)(66556008)(2906002)(31696002)(86362001)(8676002)(38350700002)(38100700002)(6486002)(66946007)(6666004)(26005)(52116002)(478600001)(316002)(8936002)(6506007)(6512007)(83380400001)(2616005)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlYxREswV3VickdzY2c1U04zNSt0QnF2S240Uml1cGxTNlAxZUVSNndYa1pw?=
 =?utf-8?B?MGxKa0lkYzhoLzQ4SjFTbTlyMDJzaCtHUVcrckJ6bERMNStLZ1RqSnpJa1ho?=
 =?utf-8?B?a0Z6S2RpUXJWaWtPRWZFU2o5cG5JaWNaNU53YmY0TEhpUmFHbWNHd0dyVk44?=
 =?utf-8?B?bDBQaW9mOXBrUlBuK2lOa1dPeGJQS0FudjFhWXRkdVk3TXFpaHlnUytZRDZR?=
 =?utf-8?B?eElrMC96L3Mva0JxcjdIT1FySVBTV2pSWXNZYTE4Yi93NE5DTmJpejF6aENI?=
 =?utf-8?B?ZHVKQ1RPd00velgwdnF4OUVJUzFSdzJiZG12ZncyOUl6VEpoUzljaDFpL29Q?=
 =?utf-8?B?bGhOSng4Uys1MU9WT0Y2Skl6OGNNRm4xSWZPZGp4MEd4SlVhQTlDVzdRSW5j?=
 =?utf-8?B?ZGNHMzhxenllT3NZNnFwTlhxWlY5RDVNeGFhM0FGV0k5ZkRiYzZtOHQ5U3g5?=
 =?utf-8?B?em9xUVp0VXFQMDRhV2ZYdzRncXFTb2JYSlE3dXlWdmI0Vkd0ckxFenNYVm85?=
 =?utf-8?B?TThXS0xOZjI2bXRXZngwYjJXVkU0WHVwZS9veDdSM2NIaVhualA4SUx5TkRN?=
 =?utf-8?B?Nk1HdE1sM2ZOTWVraVN2UGhnNjJMcXpINm5BMktHUkxjUzBjaGo5cnBHWk9T?=
 =?utf-8?B?Y3JrT0xSUHhFU3JJQmpTWmROTE5WTEtVMW1KYkp3RjVWUXY1TndqeFMzSUow?=
 =?utf-8?B?N21XekJ2UzFUN3JZeHlyMi82a2tUbnd5SDdaQnFjd2NTV29YTzd1blpLRmFD?=
 =?utf-8?B?Nm4zQlh0aEdubG5wRFBVNHQzZHR1MUFHcHFtVkw5OVFHL1pqT0l6SS9EOGta?=
 =?utf-8?B?eXNwTURvVDI0QXNoNU9zMmpGOXpmTGI2a1NFeWFFcWlpYWQyaHVhUnhnRXhq?=
 =?utf-8?B?ZU1wanVjRWpyUUZhT3hMN1ZIUEJ0QmhzTjY4alplcWtDYlFGdWhkZE84U29r?=
 =?utf-8?B?dVkrZUQrcHhORjZFcXVjWDEyNHdRTXIydGtmRE10ODg4TEF6Nk1zeWJhLzJk?=
 =?utf-8?B?d2t4RUpDZlA2ZUUzSTFUZ25lNTlFTGJxa2lwTGNpR3d5ZUhKdFVDWjNmQW1X?=
 =?utf-8?B?TjkrWW5GdFVDSWJxRzBkYkx3ZVhJNXREWFIvd29jNUpVTmxQN05oQ3drblhG?=
 =?utf-8?B?Ui84blIwVGNPeVhaS1Z1NUVGYTJ2Y3d3b1dMMXFuZktoeVRKZU92RVBJTnhs?=
 =?utf-8?B?NVRtQUZlaHZyWlI3S1BZenZWMERDTitxREZjS09jNDEzMG9XTWM1ZmxIdkE4?=
 =?utf-8?B?TmxxWUlsUEdaZWJ3aERHQWppL3VURHJnWVBycWc5NDlSckRyaWtLZVVOM1U5?=
 =?utf-8?B?a0lGRENFWUhMdFB3aHpiSEZISnNMQ0sxQS9TazJjek9ESVc4NmQxSnp1MzFt?=
 =?utf-8?B?RkdHNEpmOW1ZZGI4am1PQlFYdnZweVA3cUwwdi9rT0lSbGM3L1Q3NEIwbW14?=
 =?utf-8?B?YUNSTno5bi8yZ3A3WHBFUmtPOSs2OXJ5R1VGMkc4dHk2M1FxeWNNaHRoR0M3?=
 =?utf-8?B?MnRDckJwdlNrdVB6Ymx1emhNaURSby83MEk5QlU0d2Z3S0pkY29hZFM0UWU0?=
 =?utf-8?B?cVd6ZW5RVHg2YkZaeGIrM29ld05WNkhUSHJBNEVleVpGOTI5ZHFCdDdQMDZH?=
 =?utf-8?B?c1NFMURQM0lRWTJ1ZDN0VWVQSjFaUW14WDhna0lvMFEyNzh6c0prUjdLSGdy?=
 =?utf-8?B?SFNybURONUk5b0hkOXIrcUVBUCtzREdGTSt2S3pmdlpsSXNVMHhhQlpTQWpm?=
 =?utf-8?B?UjFJdlZTaEU4cFdjcmF6L1IrSVBWR21wU3dYQ21ZQktIUjZVczhNUEdhT2hJ?=
 =?utf-8?B?Nkl5LzBXOEVuVllvZ2w4MVNJSFlKOVJLWnJzQ0wrQUVTNHpwRk9HenQzZzVG?=
 =?utf-8?B?Ylp1Rk1FbTY0aEg0TldwWEZvTzVQMjFwRkhyRGpoL3pZQmhjS1NtSVV5OWlJ?=
 =?utf-8?B?ckFNaEhIVEp6RzM2b2l5cG1sVVZUNWw3a055OU1CMmVGVFdUVzFneTBSQnph?=
 =?utf-8?B?MXJvNlAvNFBsN3dBVktMMi9wSUVUckk0dWljUDUzWHdqU0huZWxLWXhUekU5?=
 =?utf-8?B?RG9pODFIaGNCcjczWk93Z0cyKytiY3hwK0I3aHN3TkdSL1ZJVkZrZ1l2Snd5?=
 =?utf-8?B?eGp0TGRuQ092aCthSCtaTFhtb093QkhKblpickI2K0ZHQmFqT2tFV1pLdXg1?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76edee3c-08e7-420d-f27f-08db2bbb9de4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:28:21.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsD+SmF3u9Rd3RdTl0btAXdid1XHo8mZf+nwB5EAR/J0GVHXByY1streukblT04QqfUjIQKeoXVXhF884PlAJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9374
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2023 07:13, Ming Qian wrote:
> Y212 is a YUV format with 12-bits per component like YUYV,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.
> 
> Add the missing v4l2 foramt info of Y212

Small typo here: foramt -> format

> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   drivers/media/v4l2-core/v4l2-common.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index a5e8ba370d33..21ace56fac04 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>   		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>   		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>   		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
> +		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>   
>   		/* YUV planar formats */
>   		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
