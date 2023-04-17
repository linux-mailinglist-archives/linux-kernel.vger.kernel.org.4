Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2C6E4A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDQNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDQNyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:54:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894546BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UprnbyEAIRqm+6gwGWXYx5cLfp4CDqjUEbZwrh1R3WVJfvM3QJsCXoaFkCAjZkVebLV5aj15oOPakAu2uU/n+XXtR9xEnwsYOUaWmER+RSWou1hv9yzrJzgV6kEtanxS0J/it1LrUiqAcu1XK8k+T26YakQ4qAYdclyii5R4pK5BajmYP8C3wdBbk+rOX4Ln6aoAghTxOI3uZwZzprTdiMd8OkQCyHEQ+Pbsl8aAo0729eR3ElbZe9/RStTQuKTque4mOdp2uPdU3VYGc1hPU97hqwVQ93sBweu9CaiZzy70cGX3AVvGE1nHWnZY57e99exy4uzYExPpDWhXZF+dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RuOPtlkY7SJ6RlA1HxgLAtZZ56QaDQI/6M9Ft5MKH0=;
 b=H0VPcWmzbOFkMQkX/sV5saRmRUEQZCWKMMgbmhWnZw1cy0WDbC+VRoODffNImJPMZjRrDZuf1pMECOJ23NVuzP/ZQeBR4kRrQg/Ni0v5Tc2ZLk5gYqE+te+BH7k3oARBJJTb/Z3dYyTp6hR34V+UbTt8JfrxfL1RX8Lv7RW59rBztViHaJA2GMt9wkolNB8F7UwZm5VdMHjWOLJvPC1q7/G585Dsm2oxR9fc/+P4PciPLoApu4ba2Vj8B0YYAQ1lov3HcKI8pR1nZbhhrIxldjP2ldPLGiKJ0XPeExx1Zvx49Uy+2VG56Fn5LN8UP/E18g5HWUhrPl/YjGpZACjjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by TY0PR03MB6728.apcprd03.prod.outlook.com (2603:1096:400:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 13:53:06 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 13:53:06 +0000
Message-ID: <6c573ffd-55a1-6a39-1ca1-c2681e0e960d@amlogic.com>
Date:   Mon, 17 Apr 2023 21:54:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/5] mtd: rawnand: meson: fix NAND access for
 read/write
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-2-AVKrasnov@sberdevices.ru>
 <889cf54e-584c-9bee-2106-633155897324@amlogic.com>
 <3f247cbe-2798-4871-82a5-5124142fdcc5@sberdevices.ru>
 <4f552f57-c31e-985c-82be-081dff38d377@sberdevices.ru>
 <dc690524-51d5-7bb9-a106-fa153c4e6250@amlogic.com>
 <68f3bea8-4b79-db48-172f-712dcabce65b@sberdevices.ru>
 <d3d5cf52-cf1e-31d1-46c5-d1df06c61fb3@amlogic.com>
 <ac6d67ce-54e3-83f4-fef4-fb93bdef2515@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <ac6d67ce-54e3-83f4-fef4-fb93bdef2515@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|TY0PR03MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b9ee3f-30e9-4b39-00d4-08db3f4b116c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAaxnnto53LO7pam35jaDKk5gp91z/qBg3KuFG8qKvfsFmyou1Ba3OihkMjm1wktlNqmizZuX8Ulh2bg5ogJfC4sp35kkvHUqQxx0guACta9vaiv2VZgjFsC7A+lnrDXDQfUMB8U0/Ww6MNPoXyYNVY8uz0MiitOd3HguaaN6VQsiimYb+35D8cQ28MpSFThn0UGF/R8X0gya8XLyESppe+bn3PGCKaj1mTEfNgpk5TlY3i9AT5ogiG7UNHn5H5wmk9iyBqTAR3EWUA6ezcOjBP3Egm4+2WcjMSOHSwBk/KQioM3cdxceOXmU2TgMVcyDymZuIbBcp5sUlcB002ldRSX9l9oD5ubhjRuFeINKGeIvkcLDZMp6YQRgsKBNKfsUyyD7y15OvuhgTpyGIGXywJrm3eM8uRnqZDV6KIXyxwaj9FyMoVYuaBnNG2ZkwlXmTUdPd1hIapq7fUyQC3/+hZhtvKW7tC1GGIO90u1+5xMMBz+o0czw43fVsTQI/B642DHHZfJOKO+zP+AIq6+50jG98VZ6u6eXho3RBM62MIE/gW5CYo0FBsWuTMJetua4jvaDzEkMx/VRRnju+7qlNBJzMACX8/fCs3zCJOfKZr7NZ8PV64pMnmzDS71XY2d8Pw+9dW9ubeTSV2gEEotgxPqBYzI5QlhyiyF5EJQwzKlUPk8wVxkvVZKOQrb2XraibVEwdDBKMn773XhG7/GPiASIZyv7t9FcS44PgnzvWwa2QdhUjzr7xDv0Bq2dviI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39850400004)(376002)(451199021)(6506007)(4326008)(2616005)(6636002)(6486002)(83380400001)(478600001)(6666004)(110136005)(53546011)(52116002)(26005)(186003)(6512007)(7416002)(30864003)(31686004)(36756003)(316002)(38350700002)(38100700002)(5660300002)(66946007)(66476007)(921005)(41300700001)(2906002)(8936002)(66556008)(44832011)(31696002)(86362001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lEb2x4clQvbjJKQWo1OURDUEdDWm5WWW5tUWU1dFp5S1c0ajNtYnQyUUZG?=
 =?utf-8?B?Y0o4RHBlcXl1TSsvdGdqalpPbzJqcHI4ZnJXNjh2YVZHUGRKYVFBZXZnRG04?=
 =?utf-8?B?RUlQRkxEZDAvekNWVG9NdWZ4RkVXWXJWT1ZGaW41NEFjMTAyNnlaMjZ2KzlV?=
 =?utf-8?B?QzBtNGJhNEp5bjhCVHZmWEQzanREUmFFeHdkNy9QOFNEU0E5d05KS0dkQm05?=
 =?utf-8?B?aGJEVExISmIxSGhZblJ5Nk9EbHZvaUVBZnIzVHpjNW1uQXd4YlprcytSeEhS?=
 =?utf-8?B?OGxBZlJEL2ttd0JIUjZlV3B3N0M0K0J5bEJVMnRPUWJ0L3dDb2RybksyOVI1?=
 =?utf-8?B?YWVqeEdLZ2FFVGNtL0tKczhWZlNpd0tValV5amVTMGMvRG5pSWVBTi9zZTl5?=
 =?utf-8?B?dUp5Vk5SOUsrdjdhZWV5LzQvcUtIeThxdXZYTE8rUGp3RWFrdzRyNWJ3Qk95?=
 =?utf-8?B?Q1llZXphQW5lUE1YWWZDQWVESG1jM2Z1QzMzTWN1Qnc4eklKeDdyU1lESG45?=
 =?utf-8?B?MmswWmxvWjVlVnFTWXI0aytMK0F2VzJYUDZxUWlncTVscm8wMnQzM1F1TzVG?=
 =?utf-8?B?TjlTa0ZBUWhIZWhRMHhWVmc2Q3lxYWZnb05GV0d2b1hVZDBpQWVla1BPZlhW?=
 =?utf-8?B?SW9heUhLLzI2TU81NCs5YWZkRmRXNXk2N3NLYzVicHgwejhNb1QrR202b2Rh?=
 =?utf-8?B?NER0Y1BYUDRQUUllVDZjQUlXeldxbkl2cDFQdng5ZVllN09jK1lOYzRZQzg3?=
 =?utf-8?B?SEVncTdMR1JSQ3c4S0czLzdUWUZiZUt0MjcyZDNjUVBscXNGT2l4Q1VBdE1N?=
 =?utf-8?B?OHMrMHBZWkJhMXlzNkVDSVcxWU90QjFkN0F6bFBsNmM0R1VXVjVOWWhibUJU?=
 =?utf-8?B?ekcvVC9DMWV2U2x6NHVxSHBvc290RzBQWFhBQW5ZZ1pBOWIwRmJ4dEg1M1hJ?=
 =?utf-8?B?d3pUblFxN3pMcDBRckxzYTlyRHI2bFA2VWxlRFRFcVIxRU02OHFRaWtpb3BY?=
 =?utf-8?B?cWUzMENVR2JzOW9iVURSK0xLZnJaRGRuakkrdk56L0g3RGYybWRzdmRVMkNa?=
 =?utf-8?B?TEwzRUE5MVhENHdsQUdObi9aZGJoY3l1SU1HZDdkQWRGVmFSNDFuQTVncVhy?=
 =?utf-8?B?cy9jUThzenJZUlVJZEp4aWhQd2JZRmFFNDdrbE4veExYU0dEZ2RabWNnc0RL?=
 =?utf-8?B?NXcramFJRGpvNHFvd2duTnkyeHlwZkRCdDBMRmJhc3pkZVdNNFNLNVRjNlY4?=
 =?utf-8?B?UDBGbmtZaUNHSFRBQ1JhSE41U0p1VmdWdFhEa2pKTmk1N3JKakNCSFBXZlNI?=
 =?utf-8?B?Z3BvSU9FbnBIS3lvLzV3bWh2dzhXbnNPYXZEVmxyZzlXMGV3L2hZbnlvdXQ5?=
 =?utf-8?B?YnpCaGZaS3l4MVBUUlFjdlRNTU9IUjlmVXMyanVVYUVONVltU2wxZzZVUjJv?=
 =?utf-8?B?L3V1cjNRTnhkYllSckpGd1V4Z0VSei9oMTJaYnZYM3FSWVRXOXpYKzNFbnZW?=
 =?utf-8?B?QTZYRGNsNEVxUjBIYUpCRThqcVNPVUlHWlM3MlgzREJMSWlqcmp5TXRSQzIy?=
 =?utf-8?B?WXk3VG1GY21jRmNNTVZnWnIwZ1hiKysrMmp4bmFqSUh4dWVxNUxlbGZpMkRR?=
 =?utf-8?B?UGJ6dzZHak1hMjFzczVSbUlGR3l0V25BWGRqVC9wZUtZcHFwdjdOa3hwbTNL?=
 =?utf-8?B?UEx1T21FS01rc3Y0Z2FuNzBDemthaTNsV1lFa0lLZjh6aW1TY2xEdzlkUDRv?=
 =?utf-8?B?NGx6eFVwemNZUjdUT0VIcU5jbEhrbUJpdDdKMU4zakg2U1gwMGFSa0gwbUpG?=
 =?utf-8?B?blk4Y1dWQ3gyaFVScEpPQjRMQ0pFRzFRcXdPcUFjUVVQNDUrc2E2K1ZvZ04y?=
 =?utf-8?B?YUpsSzJpNnhJeUdvcmhOQW1ZUVZ4dUQ1NmErRUFkL1BSdzJRUkRhdnl3aEZY?=
 =?utf-8?B?WXFheUxSaThPSkRUL2tETTlxVlljWldGRzd1VW0vSmt0ZWFueWxSTnhmOVNa?=
 =?utf-8?B?bUlDcEhIcWJFVkhFL2NROFpTRWxYL3hUenBXVWZVM2gzQk81MUJwb0g3Y29a?=
 =?utf-8?B?eXo2ZTBJTWRqNGxKaExmb1piTWJxNDVVdjRySFh1K2VPOWVRbjZpUjhTN3FL?=
 =?utf-8?B?TURDb0hPQ2kydjVDRVZlcHRGek1KTzhXMFA1UW11SlNPVndjZXEwSnZ4a2Fo?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b9ee3f-30e9-4b39-00d4-08db3f4b116c
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:53:05.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa3HS5hIg6fxU8n4TpjQXfcxVSjC9pFsdNmwLynnqwlABORhUDPM/UzYcN1uYP/wEGetkbtDdRzIA5PL9mJTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6728
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/4/17 14:47, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> 
> On 13.04.2023 08:57, Liang Yang wrote:
>> Hi Arseniy,
>>
>> On 2023/4/13 13:10, Arseniy Krasnov wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>>
>>>
>>> On 12.04.2023 16:30, Liang Yang wrote:
>>>> Hi,
>>>>
>>>> On 2023/4/12 20:03, Arseniy Krasnov wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>>
>>>>>
>>>>> On 12.04.2023 13:24, Arseniy Krasnov wrote:
>>>>>>
>>>>>>
>>>>>> On 12.04.2023 12:37, Liang Yang wrote:
>>>>>>> Hi Arseniy,
>>>>>>>
>>>>>>> Thanks for pointing out this problem. also comment inline.
>>>>>>>
>>>>>>> On 2023/4/12 14:16, Arseniy Krasnov wrote:
>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>
>>>>>>>> This fixes read/write functionality. New command sequences were ported
>>>>>>>> from old vendor's driver. Without this patch driver works unstable. This
>>>>>>>> change is tested with 'nanddump'/'nandwrite' utilities and mounting
>>>>>>>> JFFS2 filesystem on AXG family (A113X SoC).
>>>>>>>>
>>>>>>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>> ---
>>>>>>>>      drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>>>>>>>>      1 file changed, 101 insertions(+), 15 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> index 074e14225c06..256c37c76526 100644
>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>      #define NFC_CMD_IDLE        (0xc << 14)
>>>>>>>>      #define NFC_CMD_CLE        (0x5 << 14)
>>>>>>>>      #define NFC_CMD_ALE        (0x6 << 14)
>>>>>>>> +#define NFC_CMD_DRD        (0x8 << 14)
>>>>>>>>      #define NFC_CMD_ADL        ((0 << 16) | (3 << 20))
>>>>>>>>      #define NFC_CMD_ADH        ((1 << 16) | (3 << 20))
>>>>>>>>      #define NFC_CMD_AIL        ((2 << 16) | (3 << 20))
>>>>>>>> @@ -84,6 +85,7 @@
>>>>>>>>        #define DMA_BUSY_TIMEOUT    0x100000
>>>>>>>>      #define CMD_FIFO_EMPTY_TIMEOUT    1000
>>>>>>>> +#define DEVICE_READY_TIMEOUT    1000
>>>>>>>>        #define MAX_CE_NUM        2
>>>>>>>>      @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>>>>>>>>          }
>>>>>>>>      }
>>>>>>>>      +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>>> +                     unsigned int timeout_ms)
>>>>>>>> +{
>>>>>>>> +    u32 cmd_size = 0;
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    /* wait cmd fifo is empty */
>>>>>>>> +    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>>> +                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>>> +                     10, timeout_ms * 1000);
>>>>>>>> +    if (ret)
>>>>>>>> +        dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
>>>>>>>> +
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>>>>>>>>      {
>>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 0);
>>>>>>>> +
>>>>>>>>          writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>>>>>>>>                 nfc->reg_base + NFC_REG_CMD);
>>>>>>>>      }
>>>>>>>> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>>>>>>>>           */
>>>>>>>>          meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>          meson_nfc_cmd_idle(nfc, 0);
>>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 1000);
>>>>>>>>      }
>>>>>>>>      -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>>> -                     unsigned int timeout_ms)
>>>>>>>> -{
>>>>>>>> -    u32 cmd_size = 0;
>>>>>>>> -    int ret;
>>>>>>>> -
>>>>>>>> -    /* wait cmd fifo is empty */
>>>>>>>> -    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>>> -                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>>> -                     10, timeout_ms * 1000);
>>>>>>>> -    if (ret)
>>>>>>>> -        dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
>>>>>>>> -
>>>>>>>> -    return ret;
>>>>>>>> -}
>>>>>>>>        static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>>>>>>      {
>>>>>>>> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>>>>>          return 0;
>>>>>>>>      }
>>>>>>>>      +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
>>>>>>>> +{
>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>> +
>>>>>>>> +    writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
>>>>>>>> +    meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>>> +
>>>>>>>> +    return readl(nfc->reg_base + NFC_REG_BUF);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
>>>>>>>> +{
>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>>> +    unsigned long cnt = 0;
>>>>>>>> +
>>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>>> +
>>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
>>>>>>>> +
>>>>>>>> +    /* 10 ms. */
>>>>>>>> +    while (cnt < DEVICE_READY_TIMEOUT) {
>>>>>>>> +        uint8_t status;
>>>>>>>> +
>>>>>>>> +        status = meson_nfc_read_byte(nand);
>>>>>>>> +
>>>>>>>> +        if (status & NAND_STATUS_READY)
>>>>>>>> +            break;
>>>>>>>> +
>>>>>>>> +        usleep_range(10, 11);
>>>>>>>> +        cnt++;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (cnt == DEVICE_READY_TIMEOUT) {
>>>>>>>> +        dev_err(nfc->dev, "device ready timeout\n");
>>>>>>>> +        return -ETIMEDOUT;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>                          int page, int raw)
>>>>>>>>      {
>>>>>>>> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>          u32 cmd;
>>>>>>>>          int ret;
>>>>>>>>      +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>>          meson_nfc_select_chip(nand, nand->cur_cs);
>>>>>>>>            data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>                           NFC_CMD_SCRAMBLER_DISABLE);
>>>>>>>>          }
>>>>>>>>      +    ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>>          cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>>>>>          writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>          meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>>>>>            meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>>>>>>>      +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>>          return ret;
>>>>>>>>      }
>>>>>>>>      @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>>>>>>          } while (!ret);
>>>>>>>>      }
>>>>>>>>      +static inline int meson_nfc_send_read(struct nand_chip *nand)
>>>>>>>> +{
>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>
>>>>>>> it already calls meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in meson_nfc_queue_rb()? and we can use the irq method.
>>>>>>> also without Ready/Busy pin, the meson_nfc_queue_rb() should change like below:
>>>>>>>        ......
>>>>>>>        #define NFC_CMD_RB_INT    ((0xb << 10) | BIT(18))
>>>>>
>>>>> Sorry, I can see this define as (and it is used in the driver):
>>>>> #define NFC_CMD_RB_INT          BIT(14)
>>>>>
>>>>> in drivers/mtd/nand/raw/meson_nand.c
>>>>>
>>>>> Which one is correct ?
>>>>
>>>> we need to modify the define 'NFC_CMD_RB_INT' as ((0xb << 10) | BIT(18)).
>>>>
>>>
>>> Ok, NFC_CMD_RB_INT - it is "Ready/Busy_Interrupt" ? You suppose that currently it is
>>> defined incorrectly, so irq waiting does not work?
>>
>> Previous defined BIT(14) is for having the external Ready/Busy pin of the NAND device connected to the controller. the new define is for reading status by sending read status(70H) command and read status from the data bus(checking the IO6). the both can work on AXG soc.
>> when the controller RB command is sent, the controller automatically checks the level of external Ready/Busy pin or the data bus(IO6) periodicity. and generate the irq signal if status is ready.
>>
>>>
>>> Thanks, Arseniy
>>>
>>>>>
>>>>> Thanks, Arseniy
>>>>>
>>>>>>>
>>>>>>>        meson_nfc_cmd_idle(nfc, 0);
>>>>>>>        cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>        meson_nfc_cmd_idle(nfc, 5);
>>>>>>>        cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>>>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>
>>>>>>>        ret = wait_for_completion_timeout(&nfc->completion,
>>>>>>>                          msecs_to_jiffies(timeout_ms));
>>>>>>>        if (ret == 0)
>>>>>>>            ret = -1;
>>>>>>>
>>>>>>>        writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>>        ......
>>>>>>>
> 
> Hello Liang!
> 
> I've got small questions to clarify Your comment. You suggest two thing IIUC:
> 
> 1) Send NAND_CMD_READ0 from 'meson_nfc_queue_rb()'. This means that extra argument is needed to
> 'meson_nfc_queue_rb()' which shows that read operation is going to be performed. We can't send
> NAND_CMD_READ0 for write operation?

it is ok to me. but does NAND_CMD_READ0 really need to send in the 
controller driver? i don't find the other controller drivers have to 
send it for the old vendor NAND device.

> 
> 2) About code and define above, I tried to replace current body of 'meson_nfc_queue_rb()', but it
> didn't work. May be I did it wrong, because what to do with 'meson_nfc_wait_dev_ready()' and it's
> call sites? It must be removed? Could You please explain Your idea in more details? I'm asking You
> because I don't have doc for this NAND controller, so it is very difficult to me to add valid
> logic to this driver without any references

Could you please try the following? i have tested it on another SOC (not 
axg).

static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
{
	u32 cmd, cfg;
	int ret = 0;

	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
	meson_nfc_drain_cmd(nfc);
	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);

	cfg = readl(nfc->reg_base + NFC_REG_CFG);
	cfg |= NFC_RB_IRQ_EN;
	writel(cfg, nfc->reg_base + NFC_REG_CFG);

	reinit_completion(&nfc->completion);

	meson_nfc_cmd_idle(nfc, 0);
	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
	writel(cmd, nfc->reg_base + NFC_REG_CMD);
	meson_nfc_cmd_idle(nfc, 5);
	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
		| nfc->param.chip_select | nfc->timing.tbers_max;
	writel(cmd, nfc->reg_base + NFC_REG_CMD);
	meson_nfc_drain_cmd(nfc);

	ret = wait_for_completion_timeout(&nfc->completion,
					  msecs_to_jiffies(timeout_ms));
	if (ret == 0)
		ret = -1;

	writel(1 << 31, nfc->reg_base + NFC_REG_CMD);

	return ret;
}

also we need to check and return the return value for 
meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute() and 
meson_nfc_write_page_sub().

> 
> May be I can send v2 patchset for review without this change, as v2 already includes udpate for OOB
> handling which is I think more critical?
> 

sure, it is up to you. it is more important, thanks again.

> Thanks, Arseniy
> 
>>>>>>
>>>>>>        Thanks for reply! I'll try this code! One more question about OOB processing in this
>>>>>> driver (as You are author of it):
>>>>>>
>>>>>>       OOB size is 64 bytes, but for example if I have 1K ECC, 2 bytes user bytes and 14
>>>>>>       bytes for ECC code for each 1K. In this case I have access to only 32 bytes of OOB:
>>>>>>       2 x (2 user bytes + 14 ECC bytes). Correct me if i'm wrong, but rest of OOB (next
>>>>>>       32 bytes) become unavailable (in both raw and ECC modes) ?
>>>>>>
>>>>>> Thanks, Arseniy
>>>>>>
>>>>>>>>      static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>                         int page, int raw)
>>>>>>>>      {
>>>>>>>> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>          data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>>          info_len = nand->ecc.steps * PER_INFO_BYTE;
>>>>>>>>      +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>>          ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>>>>>>>>          if (ret)
>>>>>>>>              return ret;
>>>>>>>>      +    ret = meson_nfc_send_read(nand);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>>          ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>>>>>>>>                           data_len, meson_chip->info_buf,
>>>>>>>>                           info_len, DMA_FROM_DEVICE);
>>>>>>>> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>          }
>>>>>>>>            ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>>> +    if (ret)
>>>>>>>> +        return ret;
>>>>>>>> +
>>>>>>>>          meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>>>>>>>>            meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);
>>>>>>>
>>>>>
>>>>
>>>
>>
> 
