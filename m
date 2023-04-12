Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD49A6DF23A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDLKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLKwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:52:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CCC65A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TogAAFMiNXqK8pGDpFWAMcLelTv3oeRbnEZsDakYhX7mUJtZPMZ3UAO6IoLi9AHIQDJlRi4Sv7sWlZ+js7LDBFZ6ObedD8bx9O2lwzELS8ywdTSPztMxpIW16VFK7X+dsVAjAcBgMuNRSDsuU3wdH0k7ud0gvETul6n4LqeJQjjRPJARbOdmB+s1kLB7x+V6L4fbva9em/hMMPA0ofsI6qAYwCetoqrGoP0ZFP9wI3xNAfYV7BabrwnqEJ00OQIhfTa8/k9iBFa7yZmwXnkSMMP59jflVM6dKEWtGrPDeQ8c4jnfXtL2MZHC3AmxxHGK0XEny+kVizJOmvrb3w46gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot4aTBd570dddjhGxPqKrbamb7NtoFMBBv9Pc59moGg=;
 b=myvuHpFcTQL90RFewrZrc6qXZCzzcEoYtQcFbrJ62q3gKXvA8kTvRSWAcxAt8XdZ/0071EuRNTqkHGO09Cf4TeWD1piM7T4pimpSO2dI3TTzQ/NrIvJ458nBoEyuJ+qJCpLNzJEovMhcSpux2QU/GxAkgd097RjykBmedvQi4BaJ+ENacLQVS7VCOrL6dssnomqRGNcPIM0vudQg4s6tZ6Eqd6Li5hXxTXmQBj46GyzIqYVY0hptIV+Afck+WXZuwlfXMKyuSu7dutSwdc523wl+7DM1P+D98c5w4zVDY8foTRpV5gyzclqsZTPtlI1MJJRp68+UdWnlbuU7WdSWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 10:51:26 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 10:51:25 +0000
Message-ID: <4baac18b-c223-d346-503c-f5f9ae49320d@amlogic.com>
Date:   Wed, 12 Apr 2023 18:51:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
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
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::26) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|KL1PR03MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a40906a-af39-4eed-5548-08db3b43dc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6qxRq70soI/81fXl7mT62pQGrErGLbS/nKGNUDxhmRkkzuG4vQd9LPGCeOMiqJedBZknZPjT3swERI3GrMnQALBPfJyKiuiOcZzgLrCMoJFUrpGyHIUIIZKCoCTQKFOb4wjI6mwoUkS0qzEFrXfcGPwdXFIW6jFYBYNOZec0xDqVHRq8Eu88c015Yd2Lkz2JCI55/nTuCnKiK9aFsQZNgba6AqxJ+wlESbMJcqPzZlPkmdjIhHLUWvcg6WuWwKtLEYY7cgo2pyG9zJDtPZG27O6ZDu/+4Y/TJLYsZ/ohDGWlNTTfK28phxnWWdL7jYao/w4ni55YH46MQYHvQRIxcBiJogLKoDmK/6+P7ms3bqaoR2liIyuHuJuaDlkH0El+KiOYLOF9lu1eQKRsHt8pVkPbjCTHy5p0yxz6qOiV+YugfkWxsp9KuiUF3GgU4J7IvUYDB3iXcYWiMYdrGJfWwR24DXGYVCpJj42g1fiBAQ/jv/7zQUFC+veCCeRprsUimRc39VX5DjXJP2yr9CL6U49aD703ZEsOrULoD4Bg36icVNyX8AdZHM20KOQxFFh4m2O8vHIUO6ckJUtE/oUNjW53BLFRS4U7yhSz24VDZW4Vu/t8WIM1EcgDFG9CNI8PG9TNr6nCGnlyqj/b8n8qt86am3qgdErIS2V/BGODqL5l1FvyEC+9/alkoXK7pAL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39850400004)(366004)(376002)(451199021)(2616005)(83380400001)(66574015)(478600001)(6486002)(52116002)(6666004)(26005)(6506007)(110136005)(186003)(53546011)(54906003)(44832011)(6512007)(38350700002)(2906002)(7416002)(36756003)(5660300002)(38100700002)(4326008)(66946007)(66476007)(66556008)(41300700001)(316002)(8936002)(8676002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBPSzFTRTd3ZkRST095OFo4Z2tJd1YzTDh3MVFZRHJLcFB5Z0VNb1NFck03?=
 =?utf-8?B?V3VGUzhpVExORGVjKy9KUlpqbUp0NHE3SWJDZVlMR25EcHdXKy9hK2UrZFJu?=
 =?utf-8?B?NWZRaURXdm5FZ3pXZEI0cUpZcEFYMUVySFcyZTNpUGFZdGk5bStaeFY1dUNH?=
 =?utf-8?B?eFlFWEJDZ0x0b01lbERLNU5mYmNtUTU3U2s1S1orcDk3RlNXNUUxd3JtMVRj?=
 =?utf-8?B?WFh6L3Voa29LR1dUcXNhRzBJRGdrc0xIc3N4bVl2alB4Mll5eHh2bCtqUmhv?=
 =?utf-8?B?aVRuQkFSYTlYejAxV2Jpc0RybnM1c29vQUZ4Z0ZLK0VpTUhLV01TeitidVRE?=
 =?utf-8?B?V2xRdEVPcHVaKzdhc1dpNmNNRVNoVTRjb0ZMNFJvK2tHWjhDUXgzS09jbkls?=
 =?utf-8?B?ejRWSTg3aUE4SWlmc2NXSlBKbm5rRUN0Y05wZmhQbHI0MXdyTlVNZVZTSEs1?=
 =?utf-8?B?WDNyKy9hTzcxL1BtcWxGcXZPMnBEUlJiRmhES0lTaStVSUZJSXVBUjVocVN0?=
 =?utf-8?B?bU1BVkxXZG9xZko1UmswTHZQZkx0VWFRZVVuVGI2Y3FDdmp4MEFLOGtzQklp?=
 =?utf-8?B?emlBNXR0NS9zcWdFSy9MM3MxT1lXNWM1ejVVZkFkcVRTWWNmd2FLT2h2bkI0?=
 =?utf-8?B?TEFoaWl3alloK29jdGR1QUUwSDFKMlE1N2R6SHFnZGMyZkFYNzQ4VVlYc1NE?=
 =?utf-8?B?L2hEWjFRQU9kSDVZSUgyM3ZPUWNpNjFPQnRpRzBqV0puM09Qa0N3VjY0RDVa?=
 =?utf-8?B?VjZvREhOT0RtcjJnR0xJZGl2TEp5MVZJaFQ4UEk5NUlycVBpTVpEVU5RckRy?=
 =?utf-8?B?ZnVXYW5USlJodjR6WmxyY3dGbng2ZmtuSEYxdlJqQzAvTFV0WWdnS2ptNUxF?=
 =?utf-8?B?SkNNOW5NMTYvaSs1cTdmdGpmVGpuVXNyUXZPRTgraGdqVytHL3AyZVdSS0d5?=
 =?utf-8?B?UFhrYnZ6cnBDeThJNnZPQmtLY0VpaEJEczh4YjFkWXhNODhSZmc0Q2dmM1N1?=
 =?utf-8?B?elp0bjVoZ1NvS1h5WXFTemFXY3FpOTlCUDhBeERmS2JRYmJRc0ViYjc2NnlR?=
 =?utf-8?B?TU9JVmdmUnVGbG9HTTZsSWllMU9sZVYzYytSTisrZnhtVWFXd0hKZlVpVGRy?=
 =?utf-8?B?SEJkemJyczR4eXd0SkgydkNRT3dGZi80U1UvY0lneWVXSTlMdlRmOFFZS082?=
 =?utf-8?B?L3lwNk45cjJLVURiRzhjRVU1MlpNWmxwN2FDM0hXSlJPSExDZHVKWHRuRkd4?=
 =?utf-8?B?ZVpEUUlUdXR2WVhaWUVlaHdEWW1lUmRvYlRkSm90SW0vS0FVVGNmZDlKa0J0?=
 =?utf-8?B?bkUrZ1A1N0lqN2M4T041RE81K1N5U0EyZUtHUVBlSG4zQk95c1N1TXY4T1Ew?=
 =?utf-8?B?akNHTDl6cEJJZ2p0YUlNQkVHNHc2Z29CSUx6VXBLTW9aUmxIVkNQckVPeVkx?=
 =?utf-8?B?ZzlUbUlidjVhVC8xUGtQUSsvU0FtWnJoSFF3N3dLUElzNUljeVBjVEdFQlJj?=
 =?utf-8?B?V3ViN08rbnZBUkRwZ1hKT1hhbUZuZXpKNkZtR3piei9CaTE0UVgrU0U0L0tT?=
 =?utf-8?B?SHJ0UU5oYmY0YkFJNkpFVGx5TnVreVAvQjgyeXMwMExaS1hHRGd2SmtrbDdt?=
 =?utf-8?B?NDZla0NVR20xQmdHd2d0TVh6cFp2eFQxQzgyaElhSlJaeTVkRDgycGtNU1oy?=
 =?utf-8?B?MGtvWnpPSWdjVFEwbzdlN0U3TU1NTUJZNVhueVBvRC9JUmIxQThvektTczJn?=
 =?utf-8?B?U0lvdG1GbG02bG45SUpZVjUyTW1mU1pZcHVpenhsNnQyaHNZSm4xcEZKNzZP?=
 =?utf-8?B?MDJZNnNHSUgrTENnbWNBblhHeWhhZEVWeUluc1FZMW5kSEZreWtRRTViREFl?=
 =?utf-8?B?R1had016V1hnZnIyODgzamZ6bjViNGIwaHdlUUh2VTg2amYzWXc0QWFXSGRn?=
 =?utf-8?B?cFFHTk9yTWZuMXZmYXV6dmZBbEtROHYxSWVkQmNyQ2k4d0wvMGc1ZXAyUzVw?=
 =?utf-8?B?bWt5YjdSMDE4dlNuSm5MckxCQ2tlYVVHWGVNOUVPeGxoakUyeVg2S1VNN2hY?=
 =?utf-8?B?UWxHbTZqNEpPWW1SekVqcUxsc0NRZTFKSThjaGpaTksvTWlwaitWN1Bzd3JL?=
 =?utf-8?B?TmRtZkJjdDk4NWpnTW52YVRZS3UzczVOVjdSL1RSc0ZNaDFVcUtzQXBQaWlB?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a40906a-af39-4eed-5548-08db3b43dc84
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 10:51:25.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L6AEqTWWvhsXYdUwn4G2Ypfl0s85OOq0RJtTWSAkBFOl8mvmj2j/fiqmXBxNhVOi6tQGfXLAyUgTcSR5q312w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5778
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy and Miquel,

On 2023/4/12 18:14, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> 
> On 12.04.2023 12:36, Miquel Raynal wrote:
>> Hi Arseniy,
>>
>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:
>>
>>> On 12.04.2023 10:44, Miquel Raynal wrote:
>>>> Hi Arseniy,
>>>>
>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
>>>>    
>>>>> This NAND reads only few user's bytes in ECC mode (not full OOB), so
>>>>
>>>> "This NAND reads" does not look right, do you mean "Subpage reads do
>>>> not retrieve all the OOB bytes,"?
>>>>    
>>>>> fill OOB buffer with zeroes to not return garbage from previous reads
>>>>> to user.
>>>>> Otherwise 'nanddump' utility prints something like this for just erased
>>>>> page:
>>>>>
>>>>> ...
>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>>>    OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
>>>>>    OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
>>>>>    OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
>>>>>    OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>>   drivers/mtd/nand/raw/meson_nand.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>   static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>   				   int oob_required, int page)
>>>>>   {
>>>>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>   	u8 *oob_buf = nand->oob_poi;
>>>>>   	int ret;
>>>>>   
>>>>> +	memset(oob_buf, 0, mtd->oobsize);
>>>>
>>>> I'm surprised raw reads do not read the entire OOB?
>>>
>>> Yes! Seems in case of raw access (what i see in this driver) number of OOB bytes read
>>> still depends on ECC parameters: for each portion of data covered with ECC code we can
>>> read it's ECC code and "user bytes" from OOB - it is what i see by dumping DMA buffer by
>>> printk(). For example I'm working with 2K NAND pages, each page has 2 x 1K ECC blocks.
>>> For each ECC block I have 16 OOB bytes which I can access by read/write. Each 16 bytes
>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when I read page in raw mode
>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is reported as 64 bytes.
>>
>> In all modes, when you read OOB, you should get the full OOB. The fact
>> that ECC correction is enabled or disabled does not matter. If the NAND
>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>
>> What happens sometimes, is that some of the bytes are not protected
>> against bitflips, but the policy is to return the full buffer.
> 
> Ok, so to clarify case for this NAND controller:
> 1) In both ECC and raw modes i need to return the same raw OOB data (e.g. user bytes
>     + ECC codes)?
> 2) If I have access to only 32 bytes of OOB (in case above), I must report that size
>     of OOB is only 32 bytes during initialization?
> 
> Thanks, Arseniy

Yes. it should return all the OOB data. i make a mistake on raw read and 
there is wrong code in meson_nfc_read_page_raw().
	meson_nfc_get_data_oob(nand, buf, oob_buf);
changed to:
	if (oob_required)
		memcpy(oob_buf, buf + mtd->writesize, mtd->oobsize)

for the ECC mode, i define the meson_ooblayout_ops in host driver.

> 
>>
>>>
>>> Thanks, Arseniy
>>>
>>>>    
>>>>> +
>>>>>   	ret = meson_nfc_read_page_sub(nand, page, 1);
>>>>>   	if (ret)
>>>>>   		return ret;
>>>>> @@ -881,6 +884,8 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
>>>>>   	u8 *oob_buf = nand->oob_poi;
>>>>>   	int ret, i;
>>>>>   
>>>>> +	memset(oob_buf, 0, mtd->oobsize);
>>>>> +
>>>>>   	ret = meson_nfc_read_page_sub(nand, page, 0);
>>>>>   	if (ret)
>>>>>   		return ret;
>>>>
>>>>
>>>> Thanks,
>>>> Miquèl
>>
>>
>> Thanks,
>> Miquèl
> 

-- 
Thanks,
Liang
