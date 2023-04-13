Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD426E069E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMF6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:58:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D483D7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntyxvctIsUUZK05Aiv1zgkRwjr2hLBeQDFfMG0pj0OmH6g5G15FXPK6jyWRNtZQs7O+V9irNqWx+qIIZqqq7PFz4Obg3zV+UVnaVbycLgkrLV53++zWi2vWp6gO93Ky4iad28gdrV5D7S6Q8t5B2qt04UKX64FPhoeltld1wTWqD1ZIB2s+YaGTR0yXHnrQ0Ot/PWNjfqA0ppOSSuYW4CzenF8Vg4PY8QYQft6nORQBzQ+ER/Ag1fQHWVgSWJ+KeUPXenjgE98gWYZhXrgx1RTzxycmpPATsGZsL63KTJk+CVFT5t/jOZ0nliixv2HNviYH1Dm+whg70qNhyWnyCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ausw++pFsF0YYIjMI2yoIvwgH9Ov2kMlO5o0E0WOIfY=;
 b=GaKPR95xdw9k8Jx6suw/B/WSDq9nGweAi/eEH9BkM4V9uj3KV5qxV9KI6lQSNdN72cv6zwblog0PCNPiuQEPRGeJnPGC2VKNdoAmN9LMIiCmSH/HaCAanF4CQ9w7EhJj6FsIYuQQN/4Yx+4kJ5TO8YJwwEti/8DWhGnJ6poJ5Pzr/tXKg2DcqoM1t11gf5n8tpl/wlZvoFbG9uuJC19X6CsY4rv717yiGhteDu6CoOcRQSsd+hikRU4PnGzw2vEfhVyT2Do59+z3rqG+szFnJUUfm2utN1LxD60LxEO8ULR2vDnWfo/yJLDNQ+lYAaEV70oLUVK0TETTMBuQxWgi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 05:57:35 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Thu, 13 Apr 2023
 05:57:35 +0000
Message-ID: <d3d5cf52-cf1e-31d1-46c5-d1df06c61fb3@amlogic.com>
Date:   Thu, 13 Apr 2023 13:57:28 +0800
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
 <dc690524-51d5-7bb9-a106-fa153c4e6250@amlogic.com>
 <68f3bea8-4b79-db48-172f-712dcabce65b@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <68f3bea8-4b79-db48-172f-712dcabce65b@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::11) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|TYZPR03MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: def05ef1-e490-40c7-c235-08db3be3fa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2hLAjMz5DK7e45NORr61T1Y2Jqu462uhLG+8IuaiDzcLxRVzE6An32T4fp05OLEHai8DhmbLBnCRaqSaMZ8cURaCz8CT+UWjcJF/cgYau2wk1GwaAUKyfIBzKqVLnSK2/GuFSlNwuo0TkH0VwXlonl4tKO0HhVYm6jpygFWiu7PR0No8LUSDOCk785CBQ77hA4cGJqirPtK9KUEJE54IDaxkodi2LdGyP5ImefCjf+XEgLcFU0a4b3lPpy6mpHs1VId2ze+919k2ZBUmJ87SNyg8eWzB+maF07sR3ziJceOHt5QtDZZRMr/xnGKJcD91Zx7Nct0ZnMJDTERgOHMtiUlzgrdOOjO+SKIOhk3zkOYKSdFKifg/C8cm1yDMwJBq+R0iTHNSmHMzwVDtQet6JkO5AyEXvh9RDi548oEdQdwk+5zzloFEvCuVkPoz+xCYr96OZ8T5+0B7YkWWNPkZZBQguTPHPLGD8cfzUkURxFqQ6Mk3/8Pf8q/dcoeBt3eosgTNkF81sMgRIgSVPITpe1Ml7syWO2Dx5eBIdC+Pvk5/ST2HA5aq0yWBHJVVRUmXRdC6CP65Lf1KXjmxNd8/nmuOXF9NnTbPprFhpbZ9MHiit8P7ufbWnB4I5TvuBiAxzpMJtPJt1KrPI7t87jk+OTSSP+pBQLJZGL/o0vZgLE/o3bY+OmFop2bUFUxj980gxRW3GZkhyud0qLMM3BvAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39850400004)(366004)(451199021)(31686004)(66946007)(2906002)(66556008)(66476007)(44832011)(2616005)(7416002)(5660300002)(36756003)(8676002)(8936002)(4326008)(41300700001)(6636002)(316002)(110136005)(478600001)(6666004)(6486002)(86362001)(52116002)(186003)(53546011)(6512007)(26005)(921005)(31696002)(83380400001)(6506007)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHlEaDYxZCtTT2lDYnpxZjhsN0pvWkZ3bDdieXRrR2NydjI5Z1k2SFo4Q3VU?=
 =?utf-8?B?RUx5RHphZWdseGw0Y1FkSVM4VEJaelZPK0JaS0p3U0tEWVJkbmZpLzFnL2Vn?=
 =?utf-8?B?bTVSc29saTIzaXFhamV2Ulp2MjJLeXZSR2NVNWVZS0VWcmRYN05qTnpHNEt0?=
 =?utf-8?B?OWZJZEd1MEw4RTJHeUVleU9WcEpvc1BwaS9rVEI3WWhEM2JaQ2cwZVhrR2Zp?=
 =?utf-8?B?R0QxYnRVbmxJSHlVUkpiQmVnZ05CZGJlNmhoSW5qTGZhU3J4aGJxSjVib2Zw?=
 =?utf-8?B?TEttZEZKc0hobk5jbVFqSnZYbzdWcVI4ZERXSVR1SS93em0xWjgxVmF1alRj?=
 =?utf-8?B?dGpIWnNQZXFQdUJhdEM4SHdmakQ3WE9INGlzV2JQb0VON2ZMbTl1Z3NmSUdx?=
 =?utf-8?B?SjBzVmh1M1hHbzdFdzcyNENldnpYVG8yRWpKSnlhd0xIOWVmaStESUpmT3dQ?=
 =?utf-8?B?VVdjS01GRFlCY01jUkZ0eTg0NjViNE43aFd1K05uakZNU1lmVFN6eCtiWW1G?=
 =?utf-8?B?ejNjbnM5TFpsVFhoeG8vS3dQWmlVK01qQkRpdUtUUzY2QnczMVZWbEx4UEZk?=
 =?utf-8?B?YTV5eTdhUU80VGU2bXRCSzB4c0ZWdGdpYUFXeE5pQUowSXQ1Q0lCZDR2dHZz?=
 =?utf-8?B?QnVGRGJQNE52c0RwRVYxbzVTY3Z3aHRsNXhJeWNDTmxtc2QzSVdKZFlTWWF2?=
 =?utf-8?B?ZmN1ZlI4UXV3UVBwamRrZVpWdjY3UzJ5Q2p3TVc1dUhhRitxZ08wRHJhRTd3?=
 =?utf-8?B?NkgrdllNemlsMjg4NSszdis4SGlFeERmb2hqUXN5ZDdvdDJldk5DYkJsajUv?=
 =?utf-8?B?Nm9nb2dNVWIyOXdPVTJtUm94RFZ1S2NOeFIvMkQ4S1BDdWhUaXlobkhqUnND?=
 =?utf-8?B?b1NpNEdUVVl1bGtYbHZYejlNdXNpVXk3OHRubENVN1ZsUjdabHdTTTlUU0d5?=
 =?utf-8?B?MjFTQW1ISFFZNzVXRWN0S2dBejh5WmViRTRjK1NNeHdSbGJnUnhNVUJ0dGdw?=
 =?utf-8?B?d3craWtZRzhVWGswTWs4QzcyRFBTODVtRnV6Syt6c0VXUFplQnQxR3FLdkpn?=
 =?utf-8?B?THJRM0xPSzF5WWNGMkpDT2o4MG1EZ3BKcEJXbzVlQ2tDNmpRUTJhNlVWNFha?=
 =?utf-8?B?WTNoMGsxc2w4aGVrZkdNZVBNSzlJOWtPLzhDYlowZ3dheGFoMTlkMkk3bDhn?=
 =?utf-8?B?cG1hcldOQjZHWUFiSElvZUZic3BQNTJsN2pDdnNHejJzRVZzNmdLNVVDbmxF?=
 =?utf-8?B?ZFRlVndRQ29KdnVNaWp0SFR1SUxuNjJJN2dIbFJzeXRpZkpWQVV3dVMrOElG?=
 =?utf-8?B?N3lTRDNvaVMzVi94aklPbndIYmp3NGl1S096Wkx5WFkvK3pxQ09nSXVETEtv?=
 =?utf-8?B?SzRJYTJHYy9ncGhyTXhSTGdURWZVZHBBem1BbXlIYTNPMERvMDhOSUNYZTFJ?=
 =?utf-8?B?SW96N1l6NkJoTXhtWUZxVmhTdDFwR0l3TEhCWHBMaU5LdTFCSU5xdi95S3Fz?=
 =?utf-8?B?ZnZweC9WaHdFU3duejBKRDRNdUpoOVluUDRldmg1d1ErSmRBZ2hyVmVVUTdY?=
 =?utf-8?B?cjRVckRvTWhPSHJ5NVpsRkVNamxkSElnTHJUT2FUZ1NwdXJtZzhHQ3hxS1pv?=
 =?utf-8?B?bjl3MHY0S0tyczh4TDRqaEFYZ0ttYVVCQlg5U0dBK0dzUHZqVWtMS2IyYWs5?=
 =?utf-8?B?S1lPSjBaMm9hY3I2OXZDZHVCcUcreFdqdVZ6ck1VNVlBa1hJcExvQ2kxTVFo?=
 =?utf-8?B?NG0yV2MwZjE2M01JTW5VT092OFhNSm1wM2lFOHNIMlo4L1FOcDVOb0NRNU9K?=
 =?utf-8?B?bGlSMW9YdERwMkJZcjdUVVJtMDA3QUxqM3ViaUlwWUlCTCsvSkJ4bEJxam9R?=
 =?utf-8?B?WUo4TjgwNTBCYWxBT3hLL1M2QmF5Y0VveHdjMi94cllaVDBxRVVEekUyQlpG?=
 =?utf-8?B?ZS9VdERxMjVzUytsQmhuSFBacW5FekpsVTNtVjc5ckhnUlhadXhEV3B5V1BW?=
 =?utf-8?B?NGRyNDFWM28wRWpndUZoeUtLMlFlL1hsMzYyOWNQYmxPVEZqN2owb1hqL1du?=
 =?utf-8?B?OGZVTGhFUDZmSmhFWkUyY053WkxuU2FOVUlMdmxsZlB4aU1vaWJFKzB4aHJZ?=
 =?utf-8?B?dVpmeU41OW5LNWJ4M3k5bTlJUkhRN0ppSmRWQjVpOVhVeFBsVG1NT0FIb0E5?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def05ef1-e490-40c7-c235-08db3be3fa47
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 05:57:34.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0lEMYFzzQoq45TBiJUj22uV3EzGEq9IBepmTrCegVd8Ev/mpoAmnfEQ9VdbXaUThy65rpeZvrQFuXRtsT9Wvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7001
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/4/13 13:10, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> 
> On 12.04.2023 16:30, Liang Yang wrote:
>> Hi,
>>
>> On 2023/4/12 20:03, Arseniy Krasnov wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>>
>>>
>>> On 12.04.2023 13:24, Arseniy Krasnov wrote:
>>>>
>>>>
>>>> On 12.04.2023 12:37, Liang Yang wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>> Thanks for pointing out this problem. also comment inline.
>>>>>
>>>>> On 2023/4/12 14:16, Arseniy Krasnov wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>> This fixes read/write functionality. New command sequences were ported
>>>>>> from old vendor's driver. Without this patch driver works unstable. This
>>>>>> change is tested with 'nanddump'/'nandwrite' utilities and mounting
>>>>>> JFFS2 filesystem on AXG family (A113X SoC).
>>>>>>
>>>>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>> ---
>>>>>>     drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>>>>>>     1 file changed, 101 insertions(+), 15 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> index 074e14225c06..256c37c76526 100644
>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>     #define NFC_CMD_IDLE        (0xc << 14)
>>>>>>     #define NFC_CMD_CLE        (0x5 << 14)
>>>>>>     #define NFC_CMD_ALE        (0x6 << 14)
>>>>>> +#define NFC_CMD_DRD        (0x8 << 14)
>>>>>>     #define NFC_CMD_ADL        ((0 << 16) | (3 << 20))
>>>>>>     #define NFC_CMD_ADH        ((1 << 16) | (3 << 20))
>>>>>>     #define NFC_CMD_AIL        ((2 << 16) | (3 << 20))
>>>>>> @@ -84,6 +85,7 @@
>>>>>>       #define DMA_BUSY_TIMEOUT    0x100000
>>>>>>     #define CMD_FIFO_EMPTY_TIMEOUT    1000
>>>>>> +#define DEVICE_READY_TIMEOUT    1000
>>>>>>       #define MAX_CE_NUM        2
>>>>>>     @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>>>>>>         }
>>>>>>     }
>>>>>>     +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>> +                     unsigned int timeout_ms)
>>>>>> +{
>>>>>> +    u32 cmd_size = 0;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    /* wait cmd fifo is empty */
>>>>>> +    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>> +                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>> +                     10, timeout_ms * 1000);
>>>>>> +    if (ret)
>>>>>> +        dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>>     static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>>>>>>     {
>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 0);
>>>>>> +
>>>>>>         writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>>>>>>                nfc->reg_base + NFC_REG_CMD);
>>>>>>     }
>>>>>> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>>>>>>          */
>>>>>>         meson_nfc_cmd_idle(nfc, 0);
>>>>>>         meson_nfc_cmd_idle(nfc, 0);
>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 1000);
>>>>>>     }
>>>>>>     -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>> -                     unsigned int timeout_ms)
>>>>>> -{
>>>>>> -    u32 cmd_size = 0;
>>>>>> -    int ret;
>>>>>> -
>>>>>> -    /* wait cmd fifo is empty */
>>>>>> -    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>> -                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>> -                     10, timeout_ms * 1000);
>>>>>> -    if (ret)
>>>>>> -        dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
>>>>>> -
>>>>>> -    return ret;
>>>>>> -}
>>>>>>       static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>>>>     {
>>>>>> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>>>         return 0;
>>>>>>     }
>>>>>>     +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
>>>>>> +{
>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>> +
>>>>>> +    writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
>>>>>> +    meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>> +
>>>>>> +    return readl(nfc->reg_base + NFC_REG_BUF);
>>>>>> +}
>>>>>> +
>>>>>> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
>>>>>> +{
>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>> +    unsigned long cnt = 0;
>>>>>> +
>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>> +
>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
>>>>>> +
>>>>>> +    /* 10 ms. */
>>>>>> +    while (cnt < DEVICE_READY_TIMEOUT) {
>>>>>> +        uint8_t status;
>>>>>> +
>>>>>> +        status = meson_nfc_read_byte(nand);
>>>>>> +
>>>>>> +        if (status & NAND_STATUS_READY)
>>>>>> +            break;
>>>>>> +
>>>>>> +        usleep_range(10, 11);
>>>>>> +        cnt++;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (cnt == DEVICE_READY_TIMEOUT) {
>>>>>> +        dev_err(nfc->dev, "device ready timeout\n");
>>>>>> +        return -ETIMEDOUT;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>     static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>                         int page, int raw)
>>>>>>     {
>>>>>> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>         u32 cmd;
>>>>>>         int ret;
>>>>>>     +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         meson_nfc_select_chip(nand, nand->cur_cs);
>>>>>>           data_len =  mtd->writesize + mtd->oobsize;
>>>>>> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>                          NFC_CMD_SCRAMBLER_DISABLE);
>>>>>>         }
>>>>>>     +    ret = meson_nfc_wait_dma_finish(nfc);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>         meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>>>           meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>>>>>     +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         return ret;
>>>>>>     }
>>>>>>     @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>>>>         } while (!ret);
>>>>>>     }
>>>>>>     +static inline int meson_nfc_send_read(struct nand_chip *nand)
>>>>>> +{
>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>
>>>>> it already calls meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in meson_nfc_queue_rb()? and we can use the irq method.
>>>>> also without Ready/Busy pin, the meson_nfc_queue_rb() should change like below:
>>>>>       ......
>>>>>       #define NFC_CMD_RB_INT    ((0xb << 10) | BIT(18))
>>>
>>> Sorry, I can see this define as (and it is used in the driver):
>>> #define NFC_CMD_RB_INT          BIT(14)
>>>
>>> in drivers/mtd/nand/raw/meson_nand.c
>>>
>>> Which one is correct ?
>>
>> we need to modify the define 'NFC_CMD_RB_INT' as ((0xb << 10) | BIT(18)).
>>
> 
> Ok, NFC_CMD_RB_INT - it is "Ready/Busy_Interrupt" ? You suppose that currently it is
> defined incorrectly, so irq waiting does not work?

Previous defined BIT(14) is for having the external Ready/Busy pin of 
the NAND device connected to the controller. the new define is for 
reading status by sending read status(70H) command and read status from 
the data bus(checking the IO6). the both can work on AXG soc.
when the controller RB command is sent, the controller automatically 
checks the level of external Ready/Busy pin or the data bus(IO6) 
periodicity. and generate the irq signal if status is ready.

> 
> Thanks, Arseniy
> 
>>>
>>> Thanks, Arseniy
>>>
>>>>>
>>>>>       meson_nfc_cmd_idle(nfc, 0);
>>>>>       cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>       meson_nfc_cmd_idle(nfc, 5);
>>>>>       cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>
>>>>>       ret = wait_for_completion_timeout(&nfc->completion,
>>>>>                         msecs_to_jiffies(timeout_ms));
>>>>>       if (ret == 0)
>>>>>           ret = -1;
>>>>>
>>>>>       writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>       ......
>>>>>
>>>>
>>>>       Thanks for reply! I'll try this code! One more question about OOB processing in this
>>>> driver (as You are author of it):
>>>>
>>>>      OOB size is 64 bytes, but for example if I have 1K ECC, 2 bytes user bytes and 14
>>>>      bytes for ECC code for each 1K. In this case I have access to only 32 bytes of OOB:
>>>>      2 x (2 user bytes + 14 ECC bytes). Correct me if i'm wrong, but rest of OOB (next
>>>>      32 bytes) become unavailable (in both raw and ECC modes) ?
>>>>
>>>> Thanks, Arseniy
>>>>
>>>>>>     static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>                        int page, int raw)
>>>>>>     {
>>>>>> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>         data_len =  mtd->writesize + mtd->oobsize;
>>>>>>         info_len = nand->ecc.steps * PER_INFO_BYTE;
>>>>>>     +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>>     +    ret = meson_nfc_send_read(nand);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>>>>>>                          data_len, meson_chip->info_buf,
>>>>>>                          info_len, DMA_FROM_DEVICE);
>>>>>> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>         }
>>>>>>           ret = meson_nfc_wait_dma_finish(nfc);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>>>>>>           meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);
>>>>>
>>>
>>
> 

-- 
Thanks,
Liang
