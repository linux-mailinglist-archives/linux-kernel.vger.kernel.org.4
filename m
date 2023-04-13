Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56BC6E0675
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDMFdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:33:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881A6EBA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/x88JwbnjycuTKIQ5qcIrkejCaqI+mZeyoyVF101YCfY6K2r1HP+0inKSMi9in96ywm/dYZvQbtFIKqwI16SxaTxsAQ1G838vr1CZeL53TIL2cTA8mZnJggiphm20naH0jx1tgCPvGc9agIkBUzMtaayNVPrZX2PuJ+i2pikGJtWBms/XB1IBDqJ0iq98Q9s0qFAX3QEFvx16B/Vh0XXINc694uIyBbqipme7oMmE7npzwnde1mqncsvQD6FbSLJUqG1USl463KLW+eAizD8T8ZpH58HqJzZaeudqSQXVI/16LacEFtjmzVXvz7Zy8h7quJl3ndmPpnwMyrkcnU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukYkvx6Tjfjc609TwTjbQTYT0FQflbxWy5GV/xLck94=;
 b=BDWEa3kDd45UHwwLlK90xryF6ooLHRKC6uwCtKhGF2FcTzGejYVE5RUUJu/peJNbphF2q2vXKn/JzRh6mcRSIXRhzdj5R/Kgiq1TxMIL+7Y1fPVwQqKJFOCfXYbwHurFqm+sZW7u/deB3XAlIZtnDv/DJqUplUWSly6T7WEiAYp1S4BS0lbRYi9d3cC31c3E8/01ZkwllWrRf5juwHdo0YbvJHU7MDz8i72Pnd3RHKzB1XgwZKYwgj/R3y7hlImb5YaLj3ftlBn+FArGWYOOAYZoCx0rQfVdWNqsA2n2RaReTJ1/N1Qp7bV3LNZ34+tLqV1AB5XKygIQcTo0ABVLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SEYPR03MB7021.apcprd03.prod.outlook.com (2603:1096:101:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.41; Thu, 13 Apr
 2023 05:32:09 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Thu, 13 Apr 2023
 05:32:09 +0000
Message-ID: <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
Date:   Thu, 13 Apr 2023 13:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        "yonghui.yu" <yonghui.yu@amlogic.com>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
 <20230412094400.3c82f631@xps-13>
 <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
 <20230412113654.183350d0@xps-13>
 <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
 <20230412141824.755b2bca@xps-13>
 <eedaaed9-0a41-2c18-9eb2-792613566986@sberdevices.ru>
 <20230412145715.58c2be4a@xps-13>
 <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
 <20230412163214.0c764bb3@xps-13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230412163214.0c764bb3@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:405:1::23) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SEYPR03MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9fef95-410c-4da7-dba2-08db3be06cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUJLoTcoAjT0AMJbgHsVONqhw63XspUMXah8ZEg31bwE+o286Ac5c/dt5Q+AWagf57Emxt+8TY2AWGzNKUPAIshwPa/0mgUjuBhn0JI1DDtJq8geklNmyzOHG4CbDRkzsYpHkuO03hgl2qJLN9fgrc8IyZrENYZmhuCefv7vY6l6gasStpr/ZVw/z2Z8kCIcGgYeeh/EfeYKhvW1nWfooeIjS2asT2YcGjQGTN1gulY/mbYfwyx6Ibb/UlV2C18k3ixkrFtExvniEy69L/EBzsI9K++zgTJ+eJCe/3AWmWNsYHE9qUpuXfKSLYBi9I03BLr/yb86FLQOZfq30qeNj+X2NEawwxml36u47HR/ey+rprfcz/H2qT8eHcXhavLkJNJpJ2QMd4W/jAJNfsSUTsOwoS+UQ7fwxhbmM51DTHjiHBa3sjywxXfzHHRkVDCjs8N9N2WIR+hTMEenGQMHs6Rf6g+sFi21TVhca11Na8rmrAl00N3Rs8IvAw5ik6qb01w2NamBUIXL4e0rWAvika+2XOiEzyEIVgED26ARCfk3JTmbrE5cSDQ1dr3wOFdqQwmP7hpClfGG/SWw1mmXarIueGcK69zWYrmZmftT1pZtLrqa7xcis+2Y2QHM5xftZm+8mMMXpdowFRdu2boQ0OpUqRsnoJiX7BKCvr+Xif84adc0NSlSbU0cY/1JQ5Py
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39850400004)(451199021)(31686004)(38100700002)(316002)(36756003)(38350700002)(44832011)(7416002)(2906002)(66556008)(8936002)(8676002)(5660300002)(86362001)(31696002)(6916009)(66946007)(4326008)(41300700001)(66476007)(66574015)(2616005)(83380400001)(107886003)(26005)(54906003)(6512007)(6506007)(53546011)(6486002)(52116002)(186003)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3paOGRuTjB1eUhWMi9kelUvZTlBTWZLd2dTQlZQN3B3L0prb0wzbk9PQ05V?=
 =?utf-8?B?NEtJUC9YcDNhZUptZnZKK1Z3WXJDb2ZqU1ZaY2p6UVk5RDRaRnJwaXAvMmo1?=
 =?utf-8?B?UHFhZjRKNjhQOEZlcE5LQ09kRUl3d1Z1Mkx5NmZUaC9KWVpMYld0NVJFUDZo?=
 =?utf-8?B?bG1ERm5yYmV4dHJORWhmV01acG9MZDh3ZXAzZENDUjJVSDFtYXpqdGZNSGVZ?=
 =?utf-8?B?M3RVdFE5dDBUOGZ3NXlyWnc1SHVQOVRkYU1DTEhIeW55aXdJbnpYajJ5U2JE?=
 =?utf-8?B?OUxoMkt0MjBmTnlFK2dpNHNSYzRRNG1Jb1ZodC9jSHd0Mytxa0xwMk1NaW0w?=
 =?utf-8?B?bHVFa3pBQVppQUxJb3B3cFFtbDhDeE9qemo1UjNvTXRhOWlnZFVtNytGYW5E?=
 =?utf-8?B?M3NCcUtFcFZEcjloNHU5SEFmWWxTZUxrSStVckpHN2x0U0RKa2h3MkV0L3Q3?=
 =?utf-8?B?Y0N3WmVQOGkvL0t1WjBPc3N0Ylp2SGhpY1ZrWWgvKzM4MC8raWlkTHlTVHBM?=
 =?utf-8?B?R2c2WFY0aVIvVDA1SUJQWTZZNjkyc3ZKSTdiMHV0WXBzVWd6UGxxN1F1VDNO?=
 =?utf-8?B?eGQ0WUxNeW96REh4OTR0emlETWFnTE5UQktxbE1qUldtL2Fla21EZ0FnM0o1?=
 =?utf-8?B?M0tMb2xOa0hkcHczWkdJL25QMWFGT3AzZXhpMjNBRVNYeDJZb2cxRThVWElC?=
 =?utf-8?B?bERId0ExNDZDdnBObDFkaHRBUi9sSVZpVnVSWlh5ejI1S1h3ZnR0eXp6cG5P?=
 =?utf-8?B?amc5NjM0Tm0wNEwxWUdTSlo3V2NFMWpxeDdzZDhkWXU0N3htU3NCdktMLzhr?=
 =?utf-8?B?Y1FQRGJ1VjZtMEJqZjI0T1hEVTBaVW8xM29EQitUTG94UTdneFUxVGJza05w?=
 =?utf-8?B?M0VPNjhGMGVPYmRWQmtaMlI0Yk41Rk9uWnBPb1lOTWoxazlDWmxGYkhPT0hU?=
 =?utf-8?B?RHJqTG9FYThNMHFrZUtqenI0ZVUyTDFtOHk5aU8wNHdFaER2R2NNRkhwTklt?=
 =?utf-8?B?WGNVODIyUExHU2djeWFyUzlIdVhsQmlXTThuaU5NaEh0cUd1L2dLM1hZK0g3?=
 =?utf-8?B?UDN1c2VqY2RENVdhS1JkcjBudmtaNnpjci84a2cvaFJ5Sjd4QWsrK2c4M2l4?=
 =?utf-8?B?bVcvaUYvejMxaEJ2cjBqSUdzN3VSNG94NmYyZTVPeVYyM2Z1QkF3RG8rS3pn?=
 =?utf-8?B?ZW5Wb0Vid1VJay9NMCtnQ05pUU43UzNaNk9OalRDRjBuUEJ2QXdEN0w5NUk1?=
 =?utf-8?B?U0pPTE8rYS84MTRwR0pkY2ZUZlN6T2FLTHJCeVNndXRhZ25mdnNlY3Budlk4?=
 =?utf-8?B?UzVFcWcyZ2NGN25HcWN2MXJDOVM2S2wvdk1JZTJtajJkREJaQkRJaFFjUWFR?=
 =?utf-8?B?bHVZZmJheTBzbndaUEEzbW9FOHMwUC93bFIvT1VHbjZFOXUrd3hCWTQzcFBq?=
 =?utf-8?B?L1RRY0k5SmFaSFJrc0hEdGZjc0pkbHhxWjR1TE1QQVY2bmljUXR0ell2OFov?=
 =?utf-8?B?U0paMHJ3N2VCWHllZ3BmanFzdjNiR3FXaEx1M1pSV3JTTldjZjYwWXBQRSsy?=
 =?utf-8?B?MVF0MDZ6S1FYcGhycGVSM1ZYcXpzbTMwSDF4Umt6QW1uWXVwbUlIb0dvcjRY?=
 =?utf-8?B?Y0dJYlFYM3lEOURZWVdodUhoVEV6dXRYM2FFallRNzQrV3FoN0FXZ3lBdGlZ?=
 =?utf-8?B?NWFTU3RsTUFoc0dKVVVBK25lWXZGZzV2ZElhTUE5a251UitlZ3h3MGJSZUwx?=
 =?utf-8?B?ZTNKbWtnS1lLS0FUVXhrODdaREkxMFBnWVE5bllYZkxyRjlKeGxoeERsMExD?=
 =?utf-8?B?S3NQRkJKZ2VDSGMvMkU0RkZjRVJYazVrcjZKR1Bxd1FSMWFTS3JtQVVzUXc4?=
 =?utf-8?B?SmZhN2F5NUw4QUZocXc0bUt1R29Tc042T3E4cDJqMlQ1cDZtOGx5bzNjQi93?=
 =?utf-8?B?N0NaMmRXM0RxK3dJRnBsMjB5RDc3ZEo0S01nSGxUMUREYTlCTVFwL01rbk1B?=
 =?utf-8?B?R1l4RjRpSmw3KzhkR0owY055b2RKTkZBait6aWxHTVNHQm9reGJjdUs4VTlK?=
 =?utf-8?B?eFhsemIwZk92ai9sR2IyanZNdE9KUzNoZjVMY0tCRk1QaUFxZnBKYjlHbzFG?=
 =?utf-8?Q?1lE4bof5RTuKqkZudePO3kejJ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9fef95-410c-4da7-dba2-08db3be06cd0
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 05:32:09.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwWncQVMRjn+iHH4HKTtZu4djjY9lHYEOB5xgCI+pg67Y5xo/FmyAh9S7v2Cnr2kjDZXfvMRNoORhEbzXeA/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7021
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2023/4/12 22:32, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> liang.yang@amlogic.com wrote on Wed, 12 Apr 2023 22:04:28 +0800:
> 
>> Hi Miquel and Arseniy,
>>
>> On 2023/4/12 20:57, Miquel Raynal wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300:
>>>    
>>>> On 12.04.2023 15:18, Miquel Raynal wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +0300:
>>>>>     >>>> On 12.04.2023 12:36, Miquel Raynal wrote:
>>>>>>> Hi Arseniy,
>>>>>>>
>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:
>>>>>>>       >>>>>> On 12.04.2023 10:44, Miquel Raynal wrote:
>>>>>>>>> Hi Arseniy,
>>>>>>>>>
>>>>>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
>>>>>>>>>         >>>>>>>> This NAND reads only few user's bytes in ECC mode (not full OOB), so
>>>>>>>>>
>>>>>>>>> "This NAND reads" does not look right, do you mean "Subpage reads do
>>>>>>>>> not retrieve all the OOB bytes,"?
>>>>>>>>>         >>>>>>>> fill OOB buffer with zeroes to not return garbage from previous reads
>>>>>>>>>> to user.
>>>>>>>>>> Otherwise 'nanddump' utility prints something like this for just erased
>>>>>>>>>> page:
>>>>>>>>>>
>>>>>>>>>> ...
>>>>>>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>>>>>>>>     OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
>>>>>>>>>>     OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
>>>>>>>>>>     OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
>>>>>>>>>>     OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>>>> ---
>>>>>>>>>>    drivers/mtd/nand/raw/meson_nand.c | 5 +++++
>>>>>>>>>>    1 file changed, 5 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>    static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>>>>>>    				   int oob_required, int page)
>>>>>>>>>>    {
>>>>>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>>>    	u8 *oob_buf = nand->oob_poi;
>>>>>>>>>>    	int ret;
>>>>>>>>>>    >>>>>>>> +	memset(oob_buf, 0, mtd->oobsize);
>>>>>>>>>
>>>>>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>>>>>
>>>>>>>> Yes! Seems in case of raw access (what i see in this driver) number of OOB bytes read
>>>>>>>> still depends on ECC parameters: for each portion of data covered with ECC code we can
>>>>>>>> read it's ECC code and "user bytes" from OOB - it is what i see by dumping DMA buffer by
>>>>>>>> printk(). For example I'm working with 2K NAND pages, each page has 2 x 1K ECC blocks.
>>>>>>>> For each ECC block I have 16 OOB bytes which I can access by read/write. Each 16 bytes
>>>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when I read page in raw mode
>>>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is reported as 64 bytes.
>>>>>>>
>>>>>>> In all modes, when you read OOB, you should get the full OOB. The fact
>>>>>>> that ECC correction is enabled or disabled does not matter. If the NAND
>>>>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>>>>>
>>>>>>> What happens sometimes, is that some of the bytes are not protected
>>>>>>> against bitflips, but the policy is to return the full buffer.
>>>>>>
>>>>>> Ok, so to clarify case for this NAND controller:
>>>>>> 1) In both ECC and raw modes i need to return the same raw OOB data (e.g. user bytes
>>>>>>      + ECC codes)?
>>>>>
>>>>> Well, you need to cover the same amount of data, yes. But in the ECC
>>>>> case the data won't be raw (at least not all of it).
>>>>
>>>> So "same amount of data", in ECC mode current implementation returns only user OOB bytes (e.g.
>>>> OOB data excluding ECC codes), in raw it returns user bytes + ECC codes. IIUC correct
>>>> behaviour is to always return user bytes + ECC codes as OOB data even in ECC mode ?
>>>
>>> If the page are 2k+64B you should read 2k+64B when OOB are requested.
>>>
>>> If the controller only returns 2k+32B, then perform a random read to
>>> just move the read pointer to mtd->size + mtd->oobsize - 32 and
>>> retrieve the missing 32 bytes?
>>
>> 1) raw read can read out the whole page data 2k+64B, decided by the len in the controller raw read command:
>> 	cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
>> after that, the missing oob bytes(not used) can be copied from meson_chip->data_buf. so the implementation of meson_nfc_read_page_raw() is like this if need.
>> 	{
>> 		......
>> 		meson_nfc_read_page_sub(nand, page, 1);
>> 		meson_nfc_get_data_oob(nand, buf, oob_buf);
>> 		oob_len = (nand->ecc.bytes + 2) * nand->ecc.steps;
>> 		memcpy(oob_buf + oob_len, meson_chip->data_buf + oob_len, mtd->oobsize - oob_len);
>>
>> 	}
>> 2) In ECC mode, the controller can't bring back the missing OOB bytes. it can read out the user bytes and ecc bytes per meson_ooblayout_ops define.
> 
> And then (if oob_required) you can bring the missing bytes with
> something along:
> nand_change_read_column_op(chip, mtd->writesize + oob_len,
> 			   oob_buf + oob_len,
> 			   mtd->oobsize - oob_len,
> 			   false);
> Should not be a huge performance hit.

After finishing ECC mode reading, the column address internal in NAND 
device should be the right pos; it doesn't need to change the column 
again. so adding controller raw read for the missing bytes after ECC 
reading may works.

> 
>>
>>>
>>> This applies to the two modes, the only difference is:
>>> - with correction (commonly named "ECC mode"): the user bytes and ECC
>>>     bytes should be fixed if there are any bitflips
>>> - without correction (commonly referred as "raw mode"): no correction
>>>     applies, if there are bitflips, give them
>>>
>>> Please mind the raw mode can be slow, it's meant for debugging and
>>> testing, mainly. Page reads however should be fast, so if just moving
>>> the column pointer works, then do it, otherwise we'll consider
>>> returning FFs.
>>>
>>> Thanks,
>>> Miquèl
>>>    
>>
> 
> 
> Thanks,
> Miquèl
> 

-- 
Thanks,
Liang
