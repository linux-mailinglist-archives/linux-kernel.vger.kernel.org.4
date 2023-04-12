Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878F36DF73A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDLNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDLNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:32:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435DC9EDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3uzKuKCMLreP3681aGQskmUNPdeqL4Gin/WcVmveioUaCnIjsABoFuTtlBjONdF/BMB/ekDvXSl3kYHW4dVD/3S0t3YXnKU+K1BM6mVEI4B2HHfpzD3a3BzpO2/9O/hYL4X2W3pNw3fcX2z5aCt0zZRYUEPEPeAUfYqPX1XosNTvet8FGjrD8nUbgJrpHkQtBl3iErPf1fZCWOS3VgjzNRJqtRJ2kCAlpYT7frXf8s2tgmcdgPF9I19/7Vdi+CpypDF2+kRXmlRtDc9v11M1q0YNMJTwmCuPld/0wO6zygkTy09ePGULQqX/Slz58749RvPil/7P8WXr5U0NyeD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATw9//7y4W9do+U4RtIabhlg1SsOCkTdE5Mglnm6zRw=;
 b=jutd+xSlEtj7ElfO10YL4h/m5dpv7/r6Qg2Px6SPzuFsDZBjyswRR4K0y1zGvUA+LVjC1RDazVA/J6F+66I3UyCr52uqYjIfesz6I+ZK42tSiW4LuHUWf6WmuDM2ODr90SScMZj4uQLysFjJXntII0bJSEiWnJ1YzS1hObqbkqIlb7Q4nYj5SazGjBF0sbCfZ3iKCVMjDZyzzAZCTWYDv97O7fzq9lMkVphFex4hnWu3mNZZwHk3GnAzpm1rOIG0RDPLltMJxPQfwRR8blyCmA7f62o9qEb1k7klwvO374RPYFiyaizWUOOpgmRoCtH7MfxazIdLwPO9gJxMNa+naQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SEZPR03MB6812.apcprd03.prod.outlook.com (2603:1096:101:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:30:48 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 13:30:48 +0000
Message-ID: <dc690524-51d5-7bb9-a106-fa153c4e6250@amlogic.com>
Date:   Wed, 12 Apr 2023 21:30:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/5] mtd: rawnand: meson: fix NAND access for
 read/write
Content-Language: en-US
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
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <4f552f57-c31e-985c-82be-081dff38d377@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::8) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SEZPR03MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: d2220fb2-8f61-4772-9fec-08db3b5a203f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PPfjm56L3gC+7x0eDInTRPy5ebsxVDi+y6zwzQdMcG31aTATX4LjWE+n31UPyqCxGdBxVUClSAukL1yqzpcr6M1sYR7uRMGU0kT8EhBA0Fuge4Bp2C7eNJukaf0Go6Z7CEiX2tYZIscePaIqw087odcqnkuD3+HHQKGyCLiGlZBt6854yphIW6T8Z/ShIJtB7OvO7J1Veqk/oQcJ69+UdLk/1EBS69gffru+xHx+z1SiTCd4zCOVu7M7EIuktClnhRHsnlI1ZdVHAJaxw2/VzYhtl4eeblBqmL/vTxkMg+5ix1ixlL5eFvxomjn3XLGZntz+8ovEHOK4fwKUlTT6Qjp8bEIIYJjKdVENiEJDf5TXoYa3i9tnk1Ni8AgOFBlnejWgJ+VzItBlIb7GJ7gyGUap/WQoIiQAJt7f0cHNU13fIGRXvDWc/O63HYuL3zIzzUU/DkzAS2OG1zhYlIp7TNvrv/XoRxRov7A7ogHjqhww2MPglYX0vpUx8NfrvdwNtaLUF0cxfeUtdoE0eOcWS9hkCXXRS5W4S1tIJYTsZnkQe3KUw6V1IonC/kO7+iKNLa1VOc8M8y8XTNBUIFw/fBUjlw5+iTx3aM84rO1xWjLmQ5RAjaif5idjyeY8AMWnge2vw9k8k5AwnDqZHCq5bxrSFA+YLc557lg/6wfdTliJATiMHVTJzA25GzeLw9dFdcWQMOqHaJPxC+HcqLjqBXG/KdBvVrrcXrZaVDGDE0DRQoIueNVZI6JXTWZdmjh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39850400004)(136003)(451199021)(36756003)(31696002)(86362001)(6486002)(66946007)(41300700001)(110136005)(6666004)(66556008)(6636002)(66476007)(478600001)(52116002)(316002)(4326008)(5660300002)(8676002)(2906002)(8936002)(83380400001)(44832011)(7416002)(38100700002)(38350700002)(921005)(186003)(53546011)(6506007)(26005)(6512007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODZuVDVxSFIwMXBXZmhUZkk5NnV4dVVYcWJaTTQ1SWt4MVcrdmhTQmFuSGM2?=
 =?utf-8?B?aS9Bczg5QzZCMkViYmh0VC81U1gwaXluM0VwbHl2SndRUGl3NHNPT2JONTcw?=
 =?utf-8?B?bGF3cHZ5SU1lV25iUWc2M1F6L2FmLzUvTjhnUjZCU0N0OHpNWjM4WGVzQ2Zi?=
 =?utf-8?B?MDNJakJrUzUvNCtNNENvNWlqS1RvT1JzM2txL1dYV3Y1b2svKzNZUEVTcjdZ?=
 =?utf-8?B?QkdtOUxFVitqaXcrUmFGL2wzVXJCYlJVdGJ2YWtRSHUxY2RvMEUxVUIrQ084?=
 =?utf-8?B?SU4ram9wdURaMWtZL0dsSG5jVm9PMXpnMFJBUzJRZW5HRzdTdGloWm5OM2po?=
 =?utf-8?B?TTZwOFluWTdzQnZuRUVrNnhCa3pJUWZBRmNMS3hONWlHdE9aYXVOc25XZUxx?=
 =?utf-8?B?U0szeTFlV3JJeTIzVU9JM3ZIeldLT1BMQTdCc3Q1Zk54M2tXdlZnNXR2RHhp?=
 =?utf-8?B?cHFONGZTSjZNaU9Va1ZBdHVYdW9LdjQrQmVhbVBZNnNHaGZTakZPRitkK00w?=
 =?utf-8?B?ZmsySHU5VzNBU1cyNjY2TEFCcDBUZ1FnZjREWi9zZ2NnOWduUjNmbEtUclZk?=
 =?utf-8?B?LzNqWWJIQVVSK2lFNmVMZDhxS0Y1b3lwcGRjbGZpQXU0S3ZJZjVNK2RqOXFj?=
 =?utf-8?B?M3ZOM3duY2RQQVNINkphT3JwNGV2S1VzNDNoNUVRaEg1T09OdUdlQXZQdXVR?=
 =?utf-8?B?aldzenVEcXdpbTRtb08zWVhxQ2tsdXZjamYxQW9GNXg4LzhDOWpoWWRIOTBS?=
 =?utf-8?B?aE1ML282UjhXWk95eEV5RGkvQmdVNlk1L0FVYnBZWncwcXllcVRhVDh6RWV1?=
 =?utf-8?B?WkROV2xMdFZGTmlrYlU0dlh4dUVYcHdVdHN2SnpoaXFBNWR1VHljdktBOG41?=
 =?utf-8?B?TWtWSGllNkR5b1VTdjhOejNiUkdoQzVZNGJFVGlJSVh1ZHY3R1Mzb1BTRjFW?=
 =?utf-8?B?bTQyVlVqTUtnZUFoYUxyTTI3TUo2UFkxaGFoOVRVcmNxTElVZTY0RStVWDdH?=
 =?utf-8?B?VjY4b2xOQTRtME1PVzVOYXp5MFNJb3NxdGY1MTIrcnFFK081YWtDK3M5MWFB?=
 =?utf-8?B?ME91akN2NkplV3RNRWQ4bkViME02VkRFQll4eThWUUpJcFU4WHFDM1hPaTVB?=
 =?utf-8?B?S0xFK3VJSlREQzhhV3hubFN0S0Y5WEY2SFA2L3I4eCsrcUZzWHdRWU42MHk5?=
 =?utf-8?B?NW9ZejNSRWltRy9yeUcrRndTY2FFakRQOVhLYjU2Z0ROWTZ1VDYvT1d0TFNS?=
 =?utf-8?B?TjY5dXNOdzdkbEh3bDRlNW05L09Jb2MrYjRzTGxKcVVHR0JBN3lWK0FVN1FW?=
 =?utf-8?B?ZDNYd0FLZEF5d0M4Mi9BQ2dwdG1hUWpwYiszQXIzei9LRFJQMTN5VTBCZ1dh?=
 =?utf-8?B?Nk9iK1l0elNtQXlySkl6cklGVjk5aVBHNlJESlkxTHlCeXdmak5YRlhoeWlk?=
 =?utf-8?B?NFpaU3FYRnhHUndKRTdnNnUxVWxNVG5wWVRORi9Qc24zWGFvMWFLOFplT2dh?=
 =?utf-8?B?bU9CbHVxZWRrY1NPdzRGamlYbjJpekFtSGRmM0ExbnE4T05mRU5DNjFIbmVl?=
 =?utf-8?B?WGhkdEJzRkJ2RmJlTGxYbU5NVUhjaGpXU1ZneE0vZ2F2SFNqdW1Gc1daNlZD?=
 =?utf-8?B?NWhHS3E1c0E5US9CZ3NYWmlKeE01bDVhZWdod2oxWFN0djZNM1AzOWM2SU9R?=
 =?utf-8?B?TjBnRVVuN2czL0NnQlhaeVlYR1BBRllFT0llcFFmK29SUngwOXZlRUN0WjVp?=
 =?utf-8?B?WFZ0c0pnNTVrWmphQ1ZVWEdUbm1mVmRCa0xYSGo5V1NyK2ZyUlc1TVpxZVpZ?=
 =?utf-8?B?UFpZbEwrRWx4U2dDQUdLUHk0dkYyTFc3ZlBSK2VEdHg0M1ZicFNEYll6L2FE?=
 =?utf-8?B?K1NyR0RWdGJJTmg0YzRCNzdBdTE0Q0tmNGM2VkFINHFvUUhTdDFzNzZXYUV5?=
 =?utf-8?B?eDFzaVpEaEZlQ0hPVVZ3WTV2VllqWk1zdnR1ODM5RXNYRm15ZFpPQWgwUmUr?=
 =?utf-8?B?a0MxNm4wa2JKRFU5cW8zSHNETDVYWUEvRHJjeGtTc1lJdWgwR09qWmwyOWxo?=
 =?utf-8?B?S1JoVVhQTU5wMWZHOG9XMFZUWCt5WXVTU0V4MzYwTk5JMjBTYThyOFlMby9R?=
 =?utf-8?B?c1FRdkNlUTNDMlVnYjl4MW5ma3RPT0V0akJqWXNuOHVrYmJTRWc0VEV0M1Vh?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2220fb2-8f61-4772-9fec-08db3b5a203f
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:30:48.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC0xa2ey6iKtDlT8P8YroeHfhxAQ+6UpBDTsx+5QBKwPinj70oTwWScjBcI26Mgmgt3u7bJodfdWi9YEemZWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6812
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/12 20:03, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> 
> On 12.04.2023 13:24, Arseniy Krasnov wrote:
>>
>>
>> On 12.04.2023 12:37, Liang Yang wrote:
>>> Hi Arseniy,
>>>
>>> Thanks for pointing out this problem. also comment inline.
>>>
>>> On 2023/4/12 14:16, Arseniy Krasnov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> This fixes read/write functionality. New command sequences were ported
>>>> from old vendor's driver. Without this patch driver works unstable. This
>>>> change is tested with 'nanddump'/'nandwrite' utilities and mounting
>>>> JFFS2 filesystem on AXG family (A113X SoC).
>>>>
>>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>>    drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>>>>    1 file changed, 101 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>> index 074e14225c06..256c37c76526 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -26,6 +26,7 @@
>>>>    #define NFC_CMD_IDLE        (0xc << 14)
>>>>    #define NFC_CMD_CLE        (0x5 << 14)
>>>>    #define NFC_CMD_ALE        (0x6 << 14)
>>>> +#define NFC_CMD_DRD        (0x8 << 14)
>>>>    #define NFC_CMD_ADL        ((0 << 16) | (3 << 20))
>>>>    #define NFC_CMD_ADH        ((1 << 16) | (3 << 20))
>>>>    #define NFC_CMD_AIL        ((2 << 16) | (3 << 20))
>>>> @@ -84,6 +85,7 @@
>>>>      #define DMA_BUSY_TIMEOUT    0x100000
>>>>    #define CMD_FIFO_EMPTY_TIMEOUT    1000
>>>> +#define DEVICE_READY_TIMEOUT    1000
>>>>      #define MAX_CE_NUM        2
>>>>    @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>>>>        }
>>>>    }
>>>>    +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>> +                     unsigned int timeout_ms)
>>>> +{
>>>> +    u32 cmd_size = 0;
>>>> +    int ret;
>>>> +
>>>> +    /* wait cmd fifo is empty */
>>>> +    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>> +                     !NFC_CMD_GET_SIZE(cmd_size),
>>>> +                     10, timeout_ms * 1000);
>>>> +    if (ret)
>>>> +        dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>>>>    {
>>>> +    meson_nfc_wait_cmd_finish(nfc, 0);
>>>> +
>>>>        writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>>>>               nfc->reg_base + NFC_REG_CMD);
>>>>    }
>>>> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>>>>         */
>>>>        meson_nfc_cmd_idle(nfc, 0);
>>>>        meson_nfc_cmd_idle(nfc, 0);
>>>> +    meson_nfc_wait_cmd_finish(nfc, 1000);
>>>>    }
>>>>    -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>> -                     unsigned int timeout_ms)
>>>> -{
>>>> -    u32 cmd_size = 0;
>>>> -    int ret;
>>>> -
>>>> -    /* wait cmd fifo is empty */
>>>> -    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>> -                     !NFC_CMD_GET_SIZE(cmd_size),
>>>> -                     10, timeout_ms * 1000);
>>>> -    if (ret)
>>>> -        dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
>>>> -
>>>> -    return ret;
>>>> -}
>>>>      static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>>    {
>>>> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>        return 0;
>>>>    }
>>>>    +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
>>>> +{
>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +
>>>> +    writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
>>>> +    meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>> +    meson_nfc_drain_cmd(nfc);
>>>> +
>>>> +    return readl(nfc->reg_base + NFC_REG_BUF);
>>>> +}
>>>> +
>>>> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
>>>> +{
>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +    u32 cs = nfc->param.chip_select;
>>>> +    unsigned long cnt = 0;
>>>> +
>>>> +    meson_nfc_drain_cmd(nfc);
>>>> +
>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +    /* 10 ms. */
>>>> +    while (cnt < DEVICE_READY_TIMEOUT) {
>>>> +        uint8_t status;
>>>> +
>>>> +        status = meson_nfc_read_byte(nand);
>>>> +
>>>> +        if (status & NAND_STATUS_READY)
>>>> +            break;
>>>> +
>>>> +        usleep_range(10, 11);
>>>> +        cnt++;
>>>> +    }
>>>> +
>>>> +    if (cnt == DEVICE_READY_TIMEOUT) {
>>>> +        dev_err(nfc->dev, "device ready timeout\n");
>>>> +        return -ETIMEDOUT;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>                        int page, int raw)
>>>>    {
>>>> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>        u32 cmd;
>>>>        int ret;
>>>>    +    ret = meson_nfc_wait_dev_ready(nand);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>>        meson_nfc_select_chip(nand, nand->cur_cs);
>>>>          data_len =  mtd->writesize + mtd->oobsize;
>>>> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>                         NFC_CMD_SCRAMBLER_DISABLE);
>>>>        }
>>>>    +    ret = meson_nfc_wait_dma_finish(nfc);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>>        cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>        meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>          meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>>>    +    ret = meson_nfc_wait_dev_ready(nand);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>>        return ret;
>>>>    }
>>>>    @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>>        } while (!ret);
>>>>    }
>>>>    +static inline int meson_nfc_send_read(struct nand_chip *nand)
>>>> +{
>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +    u32 cs = nfc->param.chip_select;
>>>> +    int ret;
>>>> +
>>>> +    ret = meson_nfc_wait_dev_ready(nand);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>
>>> it already calls meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in meson_nfc_queue_rb()? and we can use the irq method.
>>> also without Ready/Busy pin, the meson_nfc_queue_rb() should change like below:
>>>      ......
>>>      #define NFC_CMD_RB_INT    ((0xb << 10) | BIT(18))
> 
> Sorry, I can see this define as (and it is used in the driver):
> #define NFC_CMD_RB_INT          BIT(14)
> 
> in drivers/mtd/nand/raw/meson_nand.c
> 
> Which one is correct ?

we need to modify the define 'NFC_CMD_RB_INT' as ((0xb << 10) | BIT(18)).

> 
> Thanks, Arseniy
> 
>>>
>>>      meson_nfc_cmd_idle(nfc, 0);
>>>      cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>      writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>      meson_nfc_cmd_idle(nfc, 5);
>>>      cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>>      writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>
>>>      ret = wait_for_completion_timeout(&nfc->completion,
>>>                        msecs_to_jiffies(timeout_ms));
>>>      if (ret == 0)
>>>          ret = -1;
>>>
>>>      writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>      ......
>>>
>>
>>      
>> Thanks for reply! I'll try this code! One more question about OOB processing in this
>> driver (as You are author of it):
>>
>>     OOB size is 64 bytes, but for example if I have 1K ECC, 2 bytes user bytes and 14
>>     bytes for ECC code for each 1K. In this case I have access to only 32 bytes of OOB:
>>     2 x (2 user bytes + 14 ECC bytes). Correct me if i'm wrong, but rest of OOB (next
>>     32 bytes) become unavailable (in both raw and ECC modes) ?
>>
>> Thanks, Arseniy
>>
>>>>    static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>                       int page, int raw)
>>>>    {
>>>> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>        data_len =  mtd->writesize + mtd->oobsize;
>>>>        info_len = nand->ecc.steps * PER_INFO_BYTE;
>>>>    +    ret = meson_nfc_wait_dev_ready(nand);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>>        ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>>>>        if (ret)
>>>>            return ret;
>>>>    +    ret = meson_nfc_send_read(nand);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>>        ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>>>>                         data_len, meson_chip->info_buf,
>>>>                         info_len, DMA_FROM_DEVICE);
>>>> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>        }
>>>>          ret = meson_nfc_wait_dma_finish(nfc);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>>        meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>>>>          meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);
>>>
> 

-- 
Thanks,
Liang
