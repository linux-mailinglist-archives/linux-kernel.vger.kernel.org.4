Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA16E96F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjDTOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjDTOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:24:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67A6A69
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrXWX4dwXG4VCPpA2AI0cpdvL4y0qmjor/Szx0tfQljqrz+zuxwtK9CrehuUixk8noae5TKG9qHZY5uHGLBRxby8pwW5WxMq922KFWXinTj29xd1guK90pz5BsQ+6ShUfGqrOQZJP0mUtbo22gd28kZfrrjvkt5+jyo86CkcIJ6g0R23D6EMc2WdCoSZsTVhingkIHTW1Yzig6CH3PZ6c+kSAJePadYa+63O6Fhc9WBW7AfEOEAe/JAE0oDrarFVwiFkJ4xGtAzioNkSHK0swRVT+UycQoVDKy2Ig4fCfPywMAWggR1rzr8s1wiL12LAuSKPY52fHMXhqzOrxzq+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2WxgcYecxZ/xXHIeTEQkSw/E2QXzeDze4oFcBH4FyM=;
 b=G9ZCLicQ0nbdSupRkGsvdg1YgMtICNtoAsNgT+qznpZiWgFbUXW7bw/MdZosjdVtcgFLGEGPAtBdUdHlirNL5oT4BPMm9fs/Y7IExTNFAMWOJTCyTzIANB8WeJ99kMRoZEVE+xkAbOXC57a4uNSfsT11EicWIoSp6Ts6TFx9Kq1gqXZIlV1iTT1AbnUjXY4m6MpPRNPQ1niZ1fpI0hsMvsSRU7/WwrS/cV5+pV/CoJCdpAM+/r1wVcEjMPPfZ6I3zNdeXH/4KmZq2PVFE+l9vxDY06X5jZxL0ZyWa/qIg4e6naRO+bRy+F6cunEXmXAhX4ggr0uV+HpW3927BeVt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SEZPR03MB7033.apcprd03.prod.outlook.com (2603:1096:101:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 14:22:51 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 14:22:51 +0000
Message-ID: <3f96eab3-5350-e0fe-7475-cf7845abdc60@amlogic.com>
Date:   Thu, 20 Apr 2023 22:22:42 +0800
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
 <6c573ffd-55a1-6a39-1ca1-c2681e0e960d@amlogic.com>
 <44dd5bcc-2b98-d402-7e8f-5e2d4babf898@sberdevices.ru>
 <ed74240c-5028-c151-7904-c437b87c5f2a@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <ed74240c-5028-c151-7904-c437b87c5f2a@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0226.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::20) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SEZPR03MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b519879-d3ad-4340-41c8-08db41aab80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8ztyujwQDKX4xWeNCUicfelBm9SVe8IMOXe8UULdjXmqueOpI7wIDL6Xahw6KcRyCGs4ivfl5e+/4Ahc+ry8mjaE/l7QYWPjaKDLXdiwM0eMQPNh+0dWe2NiiWyQ72ExxBlKPuJ0vsVInWdc7oMVbN1mXS4kIaQwulVuYLUF8aHZT8CFbyPkXWcmv7FwIWAShGE7VesF8MtC3ks7Nny9V/lqxihibNJgYj9nIY3e4ij8Lw5DySNjq+tnkTWfTq1t7EqDaGqGOJbGQ9AT8apuSGfoZ4JLNHbOzCEUbpwdgsfR3aG1CXmAXCRiK3T8dCgSBC+0NVXKWwSWYjyYCTYaGbmGfceFWH9qYJnMO3CtnybTM8jYMeACKi+yuKdQpa6HEq/dW5okUQXWn1NWa7G2fd47IK3y0oQghFGR5j5rG4snOGO720gSLJpRHywfWCStx4Zq78g35Hk5FQ58z1kpoGZ3IwuLJ89NW4pLOh7BmwosWsO0swoMaUQeQqAAGjZh38a3UBtou+HGAwEYhbdL2hlx1NHq17HDb8H45wr/TX4foMhTnPfNiVMrsywcNoZrF9pthyA0ctVOGXwjFWn/p2xY8S77FgOXK192xlRFd6ugj1P294mwJ0YcuD4QETah48hQVNSqhYXRr+01ovkgOz13F4wuZPo72z2onMdUjlPwL4+ISIN8H3ZvaQx1LE7JfTWFK27bgUx0tH3VvL9lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39850400004)(396003)(451199021)(66476007)(66556008)(4326008)(921005)(6636002)(66946007)(41300700001)(8676002)(8936002)(38100700002)(316002)(38350700002)(6512007)(26005)(186003)(53546011)(6506007)(52116002)(6486002)(6666004)(478600001)(83380400001)(2616005)(110136005)(86362001)(7416002)(36756003)(5660300002)(44832011)(31686004)(30864003)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFFZ3EvTGZwSDROR3ErMjd0M3dyYmUzYmhvRjF0M0tlOHU0VkRMUXhGVkla?=
 =?utf-8?B?K3Ixa2hYaGhrMUNLYzhPK2dWR3RiajhqelZuQmsrVnFmM0phWTBJajd0Lytq?=
 =?utf-8?B?cmZuV0liQkI1Y05HYnd0RWwyUmROT1lSS2g4bnhRWlYzZHlkL09GNE8weDdP?=
 =?utf-8?B?TTFELzFmOE93S2tJaExBSmtCMFBNNXVVL2UwWS9hdU1hY3ZlSEp5R1NwdFZ4?=
 =?utf-8?B?VnIwMGZEZUkzaXRZTmxYclRLNEVpUG52YWFVdEFmUE02RU9mMGdWczNPVDJN?=
 =?utf-8?B?OGxVNTNXNmVzaW9ZYWFWM0pjQzZDUjZuS1d0cEdMSkxCSGRRVHF1aXFjYzIv?=
 =?utf-8?B?MkNkZElGOW5hYzRUQ0RMd2lPYWxuNi85M3pBSDl6bnIrdlhnaEtxYjVUcndj?=
 =?utf-8?B?SU00endETDBMUHhUSVdtTUlVWjVJNUExWHQ1SUhhdmExOEUxQ1g0OUR0THlk?=
 =?utf-8?B?U0VwYjhVdXpNOXFqVDFTUWcrdTBnQ1pXcTBPMldpTytrWFV0SCt6bE5ERGNp?=
 =?utf-8?B?c1RqcmVtMWxUL1gwRDA3SkdlaTBteFdQMFJTWHMyNjhuYVFyNzk0SGNqUElu?=
 =?utf-8?B?SDN6L05QQmdObzYxRENtMUUzTjBaelRWTmlyVm1XeWhsU3ArdTVBWTU0SHVr?=
 =?utf-8?B?eWx1dE1uZGh5L05Cb0dXcEZtblE1bGNIZEhlUUF0RXk0SUttWHB2VDd4d2ow?=
 =?utf-8?B?N3RIaks2eXBWZC8yK2hBa2FqQ1VyNmprQUp1cXVtWXZyV3M5R015ZkppL2JR?=
 =?utf-8?B?Ylh0bXVaZjJGYmhkdzQwS2pkVElGOXVMUnh6dSs4VkVqNFA1THd5cHl2NlhH?=
 =?utf-8?B?SWhTSk03MTJHZDRuZW1RYytXdWxaK093R2kweFJDb3haU1FRbVRoRW1udnI1?=
 =?utf-8?B?UXRoSFRqRC9VamNQN3hUNzg4ejNaVG9FTXo2OE5odHoyc0JkQmVzTE5BUDhC?=
 =?utf-8?B?KzhtQlJsQ25JSW1BdVBWNG9XWThBclRlVXlZUFZWcisxc0MvaDVHdmNSVUN0?=
 =?utf-8?B?MzQ5cXV6YWQzQkxDcHFoamhORTd5VmZ1YmgzVG1nYTgyQ2J0NkZ2aE9MR0hh?=
 =?utf-8?B?UHFzQkViR3VNNWRna3FUa014TFd5RmpKaTl6MDNycUJRNlc5b0F6TTBMYlh6?=
 =?utf-8?B?bEtkZ2JWRHk2SDFkWjhkVThDSW1EM0p5Z3g2QzljSUppcGVpSU5PUkt6bTBU?=
 =?utf-8?B?TTNYeUo4NHNLd0pZNVV6K0ZRNC9BcVNvTTFONkg4N0pEK25jNEdTZ1ZPS3Z4?=
 =?utf-8?B?eXZKYVp6YjlKaHFyOUVybis1K1kyRGJYUzdqa1QydExFU2MzNFdNOFZPSXkw?=
 =?utf-8?B?d0pUUW56bXQ2dHlPNjMwU284cGMvaDBkU2l5QnNEZDF6YkZvTXNHYm1WTVhv?=
 =?utf-8?B?ZTMvK3I1bW5NK0RrajcwbDJrSHhRemxEVm5ZY1M4blJXMnRYZitLTFVqKzFx?=
 =?utf-8?B?ZGMzTG50cDBWZG1xbm0xOUcycSs1Z0svQjMzNDhIcm0zWW1UcnJPTGF0Uytj?=
 =?utf-8?B?TVlXZE9YalBuSDJ5eENtcmdIcll2WTFYV0JCakIwbENyNmhOdHcwS2QzV0xp?=
 =?utf-8?B?ZFJwVy9CYmJ5b1E5NExpdHd3eG1jdS9Hc3hUR203Q25ha0V1bXZObVBPTWpL?=
 =?utf-8?B?MXZnRnNUWk9tZHFUUnVoOTlYK3NPKzBURkQyTGxaVmJaVjY4YnZWSUJXWWxn?=
 =?utf-8?B?cGRabmR2K0krSGlpa0k1OVdWV0NibnJHU1J5OHc2akJiUG9LRFlqZGVRdUc0?=
 =?utf-8?B?T1B5YjRDLzVaSWI5djlXMGpmdVNITEd5RVZHZ0t1NEE4NmdlVjFOTTMvd3ZT?=
 =?utf-8?B?Z1lxaUpQbHY0QUd1MlBFVnhQblc0b250QU1DSXlzUkNSMGc4a3IzZC9MMDJB?=
 =?utf-8?B?VDdKSUUwcnZUUnNlMldLSzM4cnU2N2Nzd1BNMWdRWi9PN3N2QUUxUUpmakk4?=
 =?utf-8?B?MEZnTThLcXVOVVRjSWFoQjFwdUtaa3o1NG9VTkFGamo3dGlJMWlmZ2hrUTlw?=
 =?utf-8?B?U3lTNFJ1Z0N0dGYxK2h1MkxnUGxtVmRDN1FGVUw0aHVTTzBFZ1Z3ZmUvN003?=
 =?utf-8?B?ZnFqcWdibDFIWkhsRjFROFQ4b3hJQnNvN25MUDZzeG56Y1VsL3g1REEyekM2?=
 =?utf-8?B?NFc1T25TWTJFMFcvNnhHSEhDZkczaGdkZTNzTWFXWFFCVmQ2bTY4OFZvWkda?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b519879-d3ad-4340-41c8-08db41aab80d
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:22:50.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrDn7mCf8XD6xzJ22C6lvmCD4xRIufMvSjgHy6PmkeaOQQHyY8sdC4GB5GjmzW45k3gz9Dw1LxPWW6Cl8OCSug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7033
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

Sorry, I am busy on other things and will try it on AXG platform in next 
week.

On 2023/4/20 3:43, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> On 17.04.2023 17:10, Arseniy Krasnov wrote:
>>
>>
>> On 17.04.2023 16:54, Liang Yang wrote:
>>> Hi Arseniy,
>>>
>>> On 2023/4/17 14:47, Arseniy Krasnov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>>
>>>>
>>>> On 13.04.2023 08:57, Liang Yang wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>> On 2023/4/13 13:10, Arseniy Krasnov wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12.04.2023 16:30, Liang Yang wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 2023/4/12 20:03, Arseniy Krasnov wrote:
>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12.04.2023 13:24, Arseniy Krasnov wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 12.04.2023 12:37, Liang Yang wrote:
>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>
>>>>>>>>>> Thanks for pointing out this problem. also comment inline.
>>>>>>>>>>
>>>>>>>>>> On 2023/4/12 14:16, Arseniy Krasnov wrote:
>>>>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>>>>
>>>>>>>>>>> This fixes read/write functionality. New command sequences were ported
>>>>>>>>>>> from old vendor's driver. Without this patch driver works unstable. This
>>>>>>>>>>> change is tested with 'nanddump'/'nandwrite' utilities and mounting
>>>>>>>>>>> JFFS2 filesystem on AXG family (A113X SoC).
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>>>>>>>>>>>       1 file changed, 101 insertions(+), 15 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> index 074e14225c06..256c37c76526 100644
>>>>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>>>>       #define NFC_CMD_IDLE        (0xc << 14)
>>>>>>>>>>>       #define NFC_CMD_CLE        (0x5 << 14)
>>>>>>>>>>>       #define NFC_CMD_ALE        (0x6 << 14)
>>>>>>>>>>> +#define NFC_CMD_DRD        (0x8 << 14)
>>>>>>>>>>>       #define NFC_CMD_ADL        ((0 << 16) | (3 << 20))
>>>>>>>>>>>       #define NFC_CMD_ADH        ((1 << 16) | (3 << 20))
>>>>>>>>>>>       #define NFC_CMD_AIL        ((2 << 16) | (3 << 20))
>>>>>>>>>>> @@ -84,6 +85,7 @@
>>>>>>>>>>>         #define DMA_BUSY_TIMEOUT    0x100000
>>>>>>>>>>>       #define CMD_FIFO_EMPTY_TIMEOUT    1000
>>>>>>>>>>> +#define DEVICE_READY_TIMEOUT    1000
>>>>>>>>>>>         #define MAX_CE_NUM        2
>>>>>>>>>>>       @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>>>>>>>>>>>           }
>>>>>>>>>>>       }
>>>>>>>>>>>       +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>>>>>> +                     unsigned int timeout_ms)
>>>>>>>>>>> +{
>>>>>>>>>>> +    u32 cmd_size = 0;
>>>>>>>>>>> +    int ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    /* wait cmd fifo is empty */
>>>>>>>>>>> +    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>>>>>> +                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>>>>>> +                     10, timeout_ms * 1000);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
>>>>>>>>>>> +
>>>>>>>>>>> +    return ret;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>>>>>>>>>>>       {
>>>>>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 0);
>>>>>>>>>>> +
>>>>>>>>>>>           writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>>>>>>>>>>>                  nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>>       }
>>>>>>>>>>> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>>>>>>>>>>>            */
>>>>>>>>>>>           meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>>>>           meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 1000);
>>>>>>>>>>>       }
>>>>>>>>>>>       -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>>>>>> -                     unsigned int timeout_ms)
>>>>>>>>>>> -{
>>>>>>>>>>> -    u32 cmd_size = 0;
>>>>>>>>>>> -    int ret;
>>>>>>>>>>> -
>>>>>>>>>>> -    /* wait cmd fifo is empty */
>>>>>>>>>>> -    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>>>>>> -                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>>>>>> -                     10, timeout_ms * 1000);
>>>>>>>>>>> -    if (ret)
>>>>>>>>>>> -        dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
>>>>>>>>>>> -
>>>>>>>>>>> -    return ret;
>>>>>>>>>>> -}
>>>>>>>>>>>         static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>>>>>>>>>       {
>>>>>>>>>>> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>>>>>>>>           return 0;
>>>>>>>>>>>       }
>>>>>>>>>>>       +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>>>> +
>>>>>>>>>>> +    writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>> +    meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>>>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>>>>>> +
>>>>>>>>>>> +    return readl(nfc->reg_base + NFC_REG_BUF);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>>>>>> +    unsigned long cnt = 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>>>>>> +
>>>>>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>> +
>>>>>>>>>>> +    /* 10 ms. */
>>>>>>>>>>> +    while (cnt < DEVICE_READY_TIMEOUT) {
>>>>>>>>>>> +        uint8_t status;
>>>>>>>>>>> +
>>>>>>>>>>> +        status = meson_nfc_read_byte(nand);
>>>>>>>>>>> +
>>>>>>>>>>> +        if (status & NAND_STATUS_READY)
>>>>>>>>>>> +            break;
>>>>>>>>>>> +
>>>>>>>>>>> +        usleep_range(10, 11);
>>>>>>>>>>> +        cnt++;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    if (cnt == DEVICE_READY_TIMEOUT) {
>>>>>>>>>>> +        dev_err(nfc->dev, "device ready timeout\n");
>>>>>>>>>>> +        return -ETIMEDOUT;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>>>>                           int page, int raw)
>>>>>>>>>>>       {
>>>>>>>>>>> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>>>>           u32 cmd;
>>>>>>>>>>>           int ret;
>>>>>>>>>>>       +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           meson_nfc_select_chip(nand, nand->cur_cs);
>>>>>>>>>>>             data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>>>>> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>>>>>                            NFC_CMD_SCRAMBLER_DISABLE);
>>>>>>>>>>>           }
>>>>>>>>>>>       +    ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>>>>>>>>           writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>>           meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>>>>>>>>             meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>>>>>>>>>>       +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           return ret;
>>>>>>>>>>>       }
>>>>>>>>>>>       @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>>>>>>>>>           } while (!ret);
>>>>>>>>>>>       }
>>>>>>>>>>>       +static inline int meson_nfc_send_read(struct nand_chip *nand)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>>>>>> +    int ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>> +
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> it already calls meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in meson_nfc_queue_rb()? and we can use the irq method.
>>>>>>>>>> also without Ready/Busy pin, the meson_nfc_queue_rb() should change like below:
>>>>>>>>>>         ......
>>>>>>>>>>         #define NFC_CMD_RB_INT    ((0xb << 10) | BIT(18))
>>>>>>>>
>>>>>>>> Sorry, I can see this define as (and it is used in the driver):
>>>>>>>> #define NFC_CMD_RB_INT          BIT(14)
>>>>>>>>
>>>>>>>> in drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>
>>>>>>>> Which one is correct ?
>>>>>>>
>>>>>>> we need to modify the define 'NFC_CMD_RB_INT' as ((0xb << 10) | BIT(18)).
>>>>>>>
>>>>>>
>>>>>> Ok, NFC_CMD_RB_INT - it is "Ready/Busy_Interrupt" ? You suppose that currently it is
>>>>>> defined incorrectly, so irq waiting does not work?
>>>>>
>>>>> Previous defined BIT(14) is for having the external Ready/Busy pin of the NAND device connected to the controller. the new define is for reading status by sending read status(70H) command and read status from the data bus(checking the IO6). the both can work on AXG soc.
>>>>> when the controller RB command is sent, the controller automatically checks the level of external Ready/Busy pin or the data bus(IO6) periodicity. and generate the irq signal if status is ready.
>>>>>
>>>>>>
>>>>>> Thanks, Arseniy
>>>>>>
>>>>>>>>
>>>>>>>> Thanks, Arseniy
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>         meson_nfc_cmd_idle(nfc, 0);
>>>>>>>>>>         cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>         meson_nfc_cmd_idle(nfc, 5);
>>>>>>>>>>         cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>>>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>
>>>>>>>>>>         ret = wait_for_completion_timeout(&nfc->completion,
>>>>>>>>>>                           msecs_to_jiffies(timeout_ms));
>>>>>>>>>>         if (ret == 0)
>>>>>>>>>>             ret = -1;
>>>>>>>>>>
>>>>>>>>>>         writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>>>         ......
>>>>>>>>>>
>>>>
>>>> Hello Liang!
>>>>
>>>> I've got small questions to clarify Your comment. You suggest two thing IIUC:
>>>>
>>>> 1) Send NAND_CMD_READ0 from 'meson_nfc_queue_rb()'. This means that extra argument is needed to
>>>> 'meson_nfc_queue_rb()' which shows that read operation is going to be performed. We can't send
>>>> NAND_CMD_READ0 for write operation?
>>>
>>> it is ok to me. but does NAND_CMD_READ0 really need to send in the controller driver? i don't find the other controller drivers have to send it for the old vendor NAND device.
>>
>> Hm, I found this command in the old driver. For example without it I get the following error:
>>
>> # nanddump -c -s 0 -l 2048 /dev/mtd0 --oob
>> ECC failed: 3975
>> ECC corrected: 47
>> Number of bad blocks: 10
>> Number of bbt blocks: 0
>> Block size 131072, page size 2048, OOB size 64
>> Dumping data starting at 0x00000000 and ending at 0x00000800...
>>
>> But data is not corrupted and seems ok. With this extra NAND_CMD_READ0 everything is ok - data is still valid and
>> there are no ECC errors.
>>
>>>
>>>>
>>>> 2) About code and define above, I tried to replace current body of 'meson_nfc_queue_rb()', but it
>>>> didn't work. May be I did it wrong, because what to do with 'meson_nfc_wait_dev_ready()' and it's
>>>> call sites? It must be removed? Could You please explain Your idea in more details? I'm asking You
>>>> because I don't have doc for this NAND controller, so it is very difficult to me to add valid
>>>> logic to this driver without any references
>>>
>>> Could you please try the following? i have tested it on another SOC (not axg).
>>>
>>> static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>> {
>>>      u32 cmd, cfg;
>>>      int ret = 0;
>>>
>>>      meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>      meson_nfc_drain_cmd(nfc);
>>>      meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>>>
>>>      cfg = readl(nfc->reg_base + NFC_REG_CFG);
>>>      cfg |= NFC_RB_IRQ_EN;
>>>      writel(cfg, nfc->reg_base + NFC_REG_CFG);
>>>
>>>      reinit_completion(&nfc->completion);
>>>
>>>      meson_nfc_cmd_idle(nfc, 0);
>>>      cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>      writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>      meson_nfc_cmd_idle(nfc, 5);
>>>      cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>>>          | nfc->param.chip_select | nfc->timing.tbers_max;
>>>      writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>      meson_nfc_drain_cmd(nfc);
>>>
>>>      ret = wait_for_completion_timeout(&nfc->completion,
>>>                        msecs_to_jiffies(timeout_ms));
>>>      if (ret == 0)
>>>          ret = -1;
>>>
>>>      writel(1 << 31, nfc->reg_base + NFC_REG_CMD);
>>>
>>>      return ret;
>>> }
>>
>> Ok! Thanks, I'll try it!
>>
>> Thanks, Arseniy
> 
> Hello @Liang, I tried this code, seems with this implementation NAND driver works very slow,
> here is for example output buring bad blocks lookup:
> 
> [    2.060835] Scanning device for bad blocks
> [    3.350085] Bad eraseblock 20 at 0x000000280000
> [    3.536389] Freeing initrd memory: 11808K
> [   39.133952] Bad eraseblock 581 at 0x0000048a0000
> [   44.837917] Bad eraseblock 671 at 0x0000053e0000
> [   45.677964] Bad eraseblock 685 at 0x0000055a0000
> [   83.637917] Bad eraseblock 1279 at 0x000009fe0000
> [  132.833318] modprobe (56) used greatest stack depth: 12672 bytes left
> 
> 
> Take a look at timeouts. I used Your variant of 'meson_nfc_queue_rb()' from above,
> #define NFC_CMD_RB_INT is ((0xb << 10) | BIT(18)). I tested it with my ports of
> of dev ready calls from the old vendor's driver.
> 
> Thanks, Arseniy
> 
>>
>>>
>>> also we need to check and return the return value for meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute() and meson_nfc_write_page_sub().
>>>
>>>>
>>>> May be I can send v2 patchset for review without this change, as v2 already includes udpate for OOB
>>>> handling which is I think more critical?
>>>>
>>>
>>> sure, it is up to you. it is more important, thanks again.
>>>
>>>> Thanks, Arseniy
>>>>
>>>>>>>>>
>>>>>>>>>         Thanks for reply! I'll try this code! One more question about OOB processing in this
>>>>>>>>> driver (as You are author of it):
>>>>>>>>>
>>>>>>>>>        OOB size is 64 bytes, but for example if I have 1K ECC, 2 bytes user bytes and 14
>>>>>>>>>        bytes for ECC code for each 1K. In this case I have access to only 32 bytes of OOB:
>>>>>>>>>        2 x (2 user bytes + 14 ECC bytes). Correct me if i'm wrong, but rest of OOB (next
>>>>>>>>>        32 bytes) become unavailable (in both raw and ECC modes) ?
>>>>>>>>>
>>>>>>>>> Thanks, Arseniy
>>>>>>>>>
>>>>>>>>>>>       static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>                          int page, int raw)
>>>>>>>>>>>       {
>>>>>>>>>>> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>           data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>>>>>           info_len = nand->ecc.steps * PER_INFO_BYTE;
>>>>>>>>>>>       +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>>>>>>>>>>>           if (ret)
>>>>>>>>>>>               return ret;
>>>>>>>>>>>       +    ret = meson_nfc_send_read(nand);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>>>>>>>>>>>                            data_len, meson_chip->info_buf,
>>>>>>>>>>>                            info_len, DMA_FROM_DEVICE);
>>>>>>>>>>> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>           }
>>>>>>>>>>>             ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>>>>>> +    if (ret)
>>>>>>>>>>> +        return ret;
>>>>>>>>>>> +
>>>>>>>>>>>           meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>>>>>>>>>>>             meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);
>>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
