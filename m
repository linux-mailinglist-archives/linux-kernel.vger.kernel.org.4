Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F26DF7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDLOFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjDLOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:05:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32119A4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyNOTUaheUaWkGUz3S7hBzIu9GUgMx6kMHfOtO5ltbYGS/9/MATHoRQa03/6v3XpPaxzUlP0CyyLEl+BasPmtmrhHDUa3C2t7vbjToG73rHuZWSRf7LgCHc9U8iTTVsI4MU0dVtoZrmniNUx9sKldG2ugDOhgqazpgESDV33k0+QNpBX66TJCG5AhCEvpsk573vTMDXfu94FjlgAWxZMKwaXzrT3WLD5nda3G5dUoKmIS9HDK/vS6+uDRXqQcBgdYLtomlHx4/Y9Jw/ZhCqZrRXDEHv5Lr5y28SWRsQxVNw5nak09XFcNRrUYuULatg31RN0n5aVtjHBjZZ7gX6FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6r2HEJq0gzHwdiOCgT31WaPPnlwIsGzUzzGdV5Vu8U=;
 b=GCm6SHxRFm1fIPrpoD0Plo/x6qdl7Y0vIxBHgkg00oFmk66eLCCEFJ6yc/xqWtnBCU/Ahxvl4EikKlTg5LpD4icwsPUO7L06Fh6YYKBZUVRKsm92g7PUeMW3EISz0bO+OdeM8DhdAeG+llbgDrcALW3+4Sslic976PwMAoqy0++++9kbhO23SYLkd2oEf9QpWQ8MF3Ikpaj2iMOMYjcWvQ2BXL9QJ+0gxgpZBG9cLYuodhWSNTQi9G87PIgGm75hfZHSTgTedgyIAwTmbZc5N9qViWl/NtYhXD6glEdJP0HDb8PztQPASP854AVap7I5CVdmslZtwEZ7J/H0oDX8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SI2PR03MB5942.apcprd03.prod.outlook.com (2603:1096:4:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.41; Wed, 12 Apr
 2023 14:04:36 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 14:04:36 +0000
Message-ID: <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
Date:   Wed, 12 Apr 2023 22:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
 <20230412094400.3c82f631@xps-13>
 <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
 <20230412113654.183350d0@xps-13>
 <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
 <20230412141824.755b2bca@xps-13>
 <eedaaed9-0a41-2c18-9eb2-792613566986@sberdevices.ru>
 <20230412145715.58c2be4a@xps-13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230412145715.58c2be4a@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:404:a::24) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SI2PR03MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d6b345-60e9-4f19-0fb4-08db3b5ed8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXWTrw8Xx8FQ8lRz8uo0OsmgZiCvReFiQxtNVZbDsh/dU1y27Pz/1m+WyM/39tzxnz1IEZHf0zGxrGkRAOqyRmADxxCQ825m9C6xaVVWaAfHFYQv/7IXbPjRBSjdC234yAx8wJ2ZIkiHu8OBwbpuT9L7IgD9BNEBP30XicmIMM5EalP6MwqqE06jMHIVsjiXW3it0/u69Nihm9sZjUjkX/1f8w9wnV2306qZTd+nnDfbHw0w2dXS9D0vOtxUDyAfdBYgt8M8tj05N2RBRsSlx56pn/I2KQcuMWC6gAYq/1eV8dG+H2QCuvWvk863mVFSBsYfoKm5sNvmjsTGYW73shW71lldUEemTzuSOjeQpVqHiiRQjIKt+7Hwo2llnKGqX1Huk2IB7TDC/d9WTeGbaxBCQAHK/Oo2X1jTlOz3zMZ6T1hHGbUrhqn46EClngBiX9WEhASr6D7Gm586RLlYjvWV6xpKUDiYRHLK+dUhe+1OioCI4gt4TBPxXR88tJt5jpuj7Gfgk1dcxZVzOOwngpYcgZHI4pAxK4wblBvV43OyoIb9VO5qnZq0enIhaXIgWTi9lpKN8XmTJF5wg/cYzZ/Jrm8ARjss+mZ2pxy/20awGtLnjvU7eOQ2zXpQQs9awCaP8+9QTn6FP8o0WBiaCEGkX74bf2Bwm1xnGkFvvktGSTLpY4JbbAne5lYFmR8dN4OLav5wQRRqqdEpwXmI2FAMtOVGlnyvrwTsknCcw9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39850400004)(366004)(346002)(451199021)(2616005)(66574015)(83380400001)(478600001)(52116002)(6486002)(6666004)(316002)(110136005)(54906003)(26005)(186003)(53546011)(6512007)(6506007)(44832011)(7416002)(2906002)(36756003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8676002)(8936002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVrSUZENjdKd2E3aDA0dXFkZC9WcWsycHJObm9tL0xQVW9TS3o5SDhtcUs0?=
 =?utf-8?B?OTdPc1RxWkJKVDlUc1EveFQrSkI5WVhtRGpscy96TGQrRkJobk9CVDNIQ01r?=
 =?utf-8?B?RkxzYzBZelhPTUYvTStLeTJ2WmZrV0pFVjhJWktZZkM5S01aanJ1NEg1Smln?=
 =?utf-8?B?NXVVS0NCRkpmd1VNcWFYUEFaWCtVTzRYZm4rRVlmZ3crTE5aYUczYkxxMmF3?=
 =?utf-8?B?cVZKUThOWG9STzFKVEFuczhmUkNaWDZITjFXVThPVlVNOXVaZUEzR1lxVlBu?=
 =?utf-8?B?TU1PeUFnelNTRHZMYUNBNlhtMmp5U2N6bE0xaGI5bS84REkxRDZDSUEzKzlI?=
 =?utf-8?B?YmNiOWdNcitxUU52WUpmQTR3ZExaSzNwdytKTkpyRGFnNlpycFlPVlQ0QkUw?=
 =?utf-8?B?RzhjRWJQSFBXZVJ2SFlLMmgrdzRXbDBZbVYvaDl4NXRmMGFVNGVMUGVCdytW?=
 =?utf-8?B?N3lxbE5XZ1Z3a1hPUFVOem1pdHRxK0hCUyswejNDVWR3aFgraWVPWFY5T0hR?=
 =?utf-8?B?SDduU3JsQXVKdXZ6Y2F2VVg1ZEFnVnVvWnBjekhieTFKOXh1aTM5WVJXUWhm?=
 =?utf-8?B?U1NGbENsZktxUHlweUw0dU9HOU8wdEJ1VURySU9ESTRVTzk1bFFyNFJhMGNB?=
 =?utf-8?B?S1lwZ3lkaERVOXRWcDk3eUhPNlhodjJvN3pWSzQxS3BybG93TVNETjFWb0ZY?=
 =?utf-8?B?bnlzNSs0TUZsVnh5Y0VCSVdiN0dveVlsdXJxcUtBUmVzVmNxU2ZjbCt3MS92?=
 =?utf-8?B?dWlZTk4xOStRVGVNaTdwTnFtZlFYa1N1RUdlbTZMcXRYZU42bVhuU1Zqb3NN?=
 =?utf-8?B?QTdyNVlVZkhnTktFVUNBeXBsQi8vVVMyQWpyLzU5YkJWQUVXR0hYUjFnaFI5?=
 =?utf-8?B?MjQvN2o0RnQ5Vm5qZnJwMitsTzlYakFIL2pDc2RQNXhlVnFKMkFRVWxSaFpI?=
 =?utf-8?B?VkhrelEvVldwRUJtbFZ2Wnh0YmlVTU4xMUV5WW93NVZ3MVFYaDlmeWFyOUFP?=
 =?utf-8?B?RCtIY0F5YkFxM2V3L0I0L3NLVW1jMDBaZmVTOVJXSmxRR1U4dkhqdGREekFN?=
 =?utf-8?B?aDh1RW1vN2FTQnF1MWE2NXhxMXBiUUN1Uy9aeW91ck5xbURIWlEvRVRkRnRG?=
 =?utf-8?B?b2NVcmJqMFZFMU56Y1h0OXkrTCtKcVRZdTZkS01yOWxvYmRLSmZSRVRlMXhC?=
 =?utf-8?B?R2dQaEZWb3hTZUJFejlraEZhSVpPTDdCNStYYU1TRHZLWm5RUTVYS3Z5TzND?=
 =?utf-8?B?SnVzYXpmQlQwM0xYcXhmUi91NkZ6alBQbEtYbmRLWitnWVNqTFg2UVBySDRo?=
 =?utf-8?B?c3NnQjE3ZTRQNmxybkZOVzNiTFpENEUvRWRncy9GMml0cjBBWHVaVWM5ejlB?=
 =?utf-8?B?dDBpaGlaREVVZk5kdGk1U0RYTm0zTzNOVGFMa2ZPdkx1VXBQS3Y0bTdpbTE0?=
 =?utf-8?B?bjNqVWtaRU13eFc1V2dKMWE1dDJMZVg2dzZtVWlwUzFOUkVjMm0zQ2tpVnV6?=
 =?utf-8?B?VFVQV09pbDNtSWYvMjg2RkZtbzBTNXVTTjVQNzZyWGczTkR4bWY5bVIrQmpY?=
 =?utf-8?B?OHRJcWNzb0J3bnpFK2d2YlZsdHpwUkUrWFRHbEgrMm9zUzZLekNkS210S3Bq?=
 =?utf-8?B?Y2l0MXMwL0ZpeVpjQWY1T083MmY0UEhHNTlNeUIxT1gzVGN5QnNxL3dwU242?=
 =?utf-8?B?S0Ywc0hma2xDSW9EbDBVd2tQNU0weVkvZjArcG9PdVlKYUFscVhPL0U5WXBF?=
 =?utf-8?B?cnM1OE9iRCtQb1V4Ty94WGNXM2cyTFVxZXEzR3dPL2drMFFRVStWcjdKWDBj?=
 =?utf-8?B?YlNTSEZVelk3OCszakY1N1F5U0g4ZGdhWVBUK0g2WHRwYkpEV0MyZlYwdGk3?=
 =?utf-8?B?YlFxYWpJZjJiemNrMUhvQ3ZibDhTNzltc3J5OVYxMkhGeE5ZLzh5N3lyNVdo?=
 =?utf-8?B?bS96VHNkZVI0MzdEcWRBNjlKVzB4SG5JV3dEdWdlRE9FUEEyVk5QV2hvY3ZU?=
 =?utf-8?B?VkhNVmRMcnh6UnF1RnZ5V3lRb01sTmJMaStWaVVtWXFjT0RSMUZ2OHJJUVFi?=
 =?utf-8?B?Y0kxTlRSNDM4SnhCbjYrSTltbDFPN2ZMd0Q4cTBUakRIbDVJYzVqUnZGRDRW?=
 =?utf-8?B?bWh5NkF3Q1VTa3dBcmhPczM2blNwVkxWVnRSWkU4WVByM0ZDenF5dVJXSThR?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d6b345-60e9-4f19-0fb4-08db3b5ed8e8
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:04:35.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhWzlQRAPTOhLjf0BboEqt8h+nE2qI0c9tF3Lgmak7XbonZc/5jW6p83oGDfxZWufrMVZZbf9CaHh5tXnIvw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5942
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel and Arseniy,

On 2023/4/12 20:57, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300:
> 
>> On 12.04.2023 15:18, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +0300:
>>>    
>>>> On 12.04.2023 12:36, Miquel Raynal wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:
>>>>>      
>>>>>> On 12.04.2023 10:44, Miquel Raynal wrote:
>>>>>>> Hi Arseniy,
>>>>>>>
>>>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
>>>>>>>        
>>>>>>>> This NAND reads only few user's bytes in ECC mode (not full OOB), so
>>>>>>>
>>>>>>> "This NAND reads" does not look right, do you mean "Subpage reads do
>>>>>>> not retrieve all the OOB bytes,"?
>>>>>>>        
>>>>>>>> fill OOB buffer with zeroes to not return garbage from previous reads
>>>>>>>> to user.
>>>>>>>> Otherwise 'nanddump' utility prints something like this for just erased
>>>>>>>> page:
>>>>>>>>
>>>>>>>> ...
>>>>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>>>>>>    OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
>>>>>>>>    OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
>>>>>>>>    OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
>>>>>>>>    OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
>>>>>>>>
>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>> ---
>>>>>>>>   drivers/mtd/nand/raw/meson_nand.c | 5 +++++
>>>>>>>>   1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>   static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>>>>   				   int oob_required, int page)
>>>>>>>>   {
>>>>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>   	u8 *oob_buf = nand->oob_poi;
>>>>>>>>   	int ret;
>>>>>>>>   
>>>>>>>> +	memset(oob_buf, 0, mtd->oobsize);
>>>>>>>
>>>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>>>
>>>>>> Yes! Seems in case of raw access (what i see in this driver) number of OOB bytes read
>>>>>> still depends on ECC parameters: for each portion of data covered with ECC code we can
>>>>>> read it's ECC code and "user bytes" from OOB - it is what i see by dumping DMA buffer by
>>>>>> printk(). For example I'm working with 2K NAND pages, each page has 2 x 1K ECC blocks.
>>>>>> For each ECC block I have 16 OOB bytes which I can access by read/write. Each 16 bytes
>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when I read page in raw mode
>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is reported as 64 bytes.
>>>>>
>>>>> In all modes, when you read OOB, you should get the full OOB. The fact
>>>>> that ECC correction is enabled or disabled does not matter. If the NAND
>>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>>>
>>>>> What happens sometimes, is that some of the bytes are not protected
>>>>> against bitflips, but the policy is to return the full buffer.
>>>>
>>>> Ok, so to clarify case for this NAND controller:
>>>> 1) In both ECC and raw modes i need to return the same raw OOB data (e.g. user bytes
>>>>     + ECC codes)?
>>>
>>> Well, you need to cover the same amount of data, yes. But in the ECC
>>> case the data won't be raw (at least not all of it).
>>
>> So "same amount of data", in ECC mode current implementation returns only user OOB bytes (e.g.
>> OOB data excluding ECC codes), in raw it returns user bytes + ECC codes. IIUC correct
>> behaviour is to always return user bytes + ECC codes as OOB data even in ECC mode ?
> 
> If the page are 2k+64B you should read 2k+64B when OOB are requested.
> 
> If the controller only returns 2k+32B, then perform a random read to
> just move the read pointer to mtd->size + mtd->oobsize - 32 and
> retrieve the missing 32 bytes?

1) raw read can read out the whole page data 2k+64B, decided by the len 
in the controller raw read command:
	cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
after that, the missing oob bytes(not used) can be copied from 
meson_chip->data_buf. so the implementation of meson_nfc_read_page_raw() 
is like this if need.
	{
		......
		meson_nfc_read_page_sub(nand, page, 1);
		meson_nfc_get_data_oob(nand, buf, oob_buf);
		oob_len = (nand->ecc.bytes + 2) * nand->ecc.steps;
		memcpy(oob_buf + oob_len, meson_chip->data_buf + oob_len, mtd->oobsize 
- oob_len);

	}
2) In ECC mode, the controller can't bring back the missing OOB bytes. 
it can read out the user bytes and ecc bytes per meson_ooblayout_ops define.

> 
> This applies to the two modes, the only difference is:
> - with correction (commonly named "ECC mode"): the user bytes and ECC
>    bytes should be fixed if there are any bitflips
> - without correction (commonly referred as "raw mode"): no correction
>    applies, if there are bitflips, give them
> 
> Please mind the raw mode can be slow, it's meant for debugging and
> testing, mainly. Page reads however should be fast, so if just moving
> the column pointer works, then do it, otherwise we'll consider
> returning FFs.
> 
> Thanks,
> Miquèl
> 

-- 
Thanks,
Liang
