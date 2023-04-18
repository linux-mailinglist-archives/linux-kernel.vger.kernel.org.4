Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D16E6126
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDRMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDRMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:23:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4D0273F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eawIG4zPiuGQ+TH+tk6q/WZpWgzc2WNN1sIJIiLuGUb1Nn/YLJ1YtMcV2fYXkg4Xqqi1OgzA8XVuaa97FtlUhlQqVv8eRLK3CuEPzRtA/3s9FHNX7bLlnq6/23Bdx+l2de9Evl+QJidhF0x3WLLFy94u8mHoQAQamUpK2t1cE+PjFWTf1wVcCKyhDlsGxedeVofsN6VeOS2lJ2B3R7gcCOTiQ6J3f6/gMfBhUvwYREme0Bo3HWtaBWt2u2WsotIxyNwEayQu/1NQ5hW40/Gj60Owd0YSBct7ykKaaXKJnpHp3fIiKGWgVxsfJogvOMDpGIwRZS0IYHOampofDEXPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BetRalfcuesIKb68JeXsuOKtO0v/f5cr0gUbppoWOY0=;
 b=eDtkC2eins6pkMi95Feb0kbqUsM7b2TAU6J/PKqAucH43dvosNmZZqjaRau16iIR4USW3NI98hfIUzV7o9wxSy3S3Lzow4IFt6E45FJUmzvyRXfTfe0CHbXvFWEQr97hCGKDAXtVPgcteiMVB15H/PmkXXOpQ3GSn3dbrKTTuJstz7MoQfJpQ++y4x13nzcPIHMhbK6jdSk8d5/nx5XBfyiZrnACcUxQcL/iYs8pysHIBBREDPXDif4xbSoNHm9SvuHPPiaP4kUy6Bd7PYcpySuzS0w5V5c9K1X1KRVkauAlsxNirmBy7yXVRDuSWYnponJ/xe/o8tan5JiclqoR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by SG2PR03MB6278.apcprd03.prod.outlook.com (2603:1096:4:169::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 12:23:04 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 12:23:04 +0000
Message-ID: <780c0cae-18b6-2652-1c2c-6d398ea60451@amlogic.com>
Date:   Tue, 18 Apr 2023 20:24:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
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
 <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
 <fbb8cb2b-0996-3029-b368-f67087d73487@amlogic.com>
 <7520e512-8a19-ff04-364c-b5be0a579ef0@sberdevices.ru>
 <20230413102200.309fbe9c@xps-13>
 <b3279de4-e89d-db03-a515-a6aa52ab90d3@sberdevices.ru>
 <20230413122252.0a8efcd8@xps-13>
 <569a948e-654a-b21f-8a4f-55dc4b295387@sberdevices.ru>
 <60fa656e-bda1-1de6-a79e-3e3041cd69a8@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <60fa656e-bda1-1de6-a79e-3e3041cd69a8@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:4::21) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|SG2PR03MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f840b4-4749-4e16-5f96-08db4007a7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73DdZyT2T8zRDuY56kim5PmyhhAvp44qdNQT6BeX7L4ks5tW1Fzhm5xvCxUV7g/ne3Gt4eme7rUaBV0o3OWBs76ZopqLpaGaSdxpdiico17IvNzJnsh4UD0nhkiw4g4Y3H4adIQwja/L3LnW3PR1LiCCN2WDMnt/xM0YL/Ysl6W0FmqjoJH8QrrPai/u47Tkk2bzMZgjhoog5UPwy2MZ2QNMRrnBkGi3zWpDGkbbbmR7VmBYwmau7jDgEbuXGny60A/LkHDhoXTj5eOXoWICGbULbNdRpNVIDCiXcCByDpwlS/2HrJrolXsueR0/cgQ/n/yxLv2dVzb4DXDMDX5xreJh7CC9m1FP1SFtfV6yjfnPs2IuJb8K1WHNOwNS81f1MbqpyikiNz1zzvwp1jC4YiVtghs81HBo4EppVQKcee3svFGlsCvwrbWLVhXA/PXgsEAv378bwrWu6yvCww5ZH/+elSMjE0CpzqRgVr/QDAY+tlkdRH0UsM4OHn9HDHIgxxCxeKNalHofufFO0ehTlOhXwoGOGCeERUnshWhSGlt2OP7TriJ1LKAfkmvYDOXB4AKQbdnP1AN6Oemb7b+WlozCXwctdoMFndEdPUgFsGsXJBqeTFla7ZE02xPmFhPrKt5iiqWbTbymAxWkYneI8iksIbDUS11HpYn5ZNiJbWFrFjhUjXk3sVZA1/cUmZkEk1/g0RMNNJNROnU9hpUO6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39850400004)(396003)(451199021)(7416002)(44832011)(31686004)(5660300002)(4326008)(30864003)(2906002)(66946007)(41300700001)(8936002)(8676002)(316002)(478600001)(110136005)(966005)(6486002)(6666004)(52116002)(53546011)(6506007)(6512007)(26005)(107886003)(186003)(66476007)(66556008)(2616005)(66574015)(83380400001)(54906003)(38350700002)(38100700002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThVZFgybXZPOU15c051bVZ3MUVwVVRNdW8yemNHeFpPdEI0QlFmNStRcVp3?=
 =?utf-8?B?T0JkZXBzVHp3cHorU2RsMjRianVJNmVmbFpneklVRk1wRnhqcStMeTFoYWtz?=
 =?utf-8?B?RDZubHN1UWJnZ1dSdFlrSHJWaTJwT003SVNtOTMyQ1RiaGYxck0rV2d5dWEv?=
 =?utf-8?B?YXhlNVQyUmVSSGZGSmI1TE5IelpObXI1VmRaNW9hOStKTWM1TnVIbGNMMlhQ?=
 =?utf-8?B?V3pnVkxYWU1CbGlZaTV1bm5kYUIrQi9CaFpOcWRPQTdxcEVxOFZGc1kvRHN2?=
 =?utf-8?B?VzB1dHFVQnloQUN4ZWxlOU5DZWJNWWxtYTdYWnBhd2hPM0JlT1JtY2Q3TVRw?=
 =?utf-8?B?cDloVFRXOWQyd1JUdW8renFpN09BL01rR3BmV2YxNEZSbmJCeVBENkhtWW5F?=
 =?utf-8?B?UGFzQlUyN2paVU56ZlBmekZ3TkFZdFJaUzhWWGpMaHpGSWl6SEM1dkltdHBv?=
 =?utf-8?B?K2t6SlM5V240bHYyUVRGRlJocS9TQUVxV1dYM3lBZWdGdmFZNDJkeWtWaGcy?=
 =?utf-8?B?VUF4Q0VtTzh4UzdIOUM2ajhlQUR2cmM2RmdSa2tTZXZpRWxzSytrb3A3QTcy?=
 =?utf-8?B?N3ZTNG5haFFNR28xQkFnNFVKdzB3N3dnVkN0WW5nZlZFbitXY2t6RXN5ZXZa?=
 =?utf-8?B?WnJBa1hnTnFGOHhTb1cvQWtsLytLTUFWVWc3a1liUm5XQjJ0UC8xRnNNaWhD?=
 =?utf-8?B?SUNkbUJ4WjJ5RVRZcTZSdGZ0OHFkcnVzTkN1ZjZrd3VvOFVuN1AvTW9VczFo?=
 =?utf-8?B?YlU4dkZHczVzQURoWFBsM0pzYUdiUFFoVk4wWkZoekxhOVYzV0Y3U2FrbTBM?=
 =?utf-8?B?WnJQT3hCc2Q1eTNUa3ZrbmFIWDR0TytjY1hMS2pxN0s4RlpmeGpDQ3U4MzA4?=
 =?utf-8?B?OERTYnV6Uk9XSmRPTlJGSlBMVEVNNzhERFpoZzhsWGQ1VTBsSlphcXVPUDJn?=
 =?utf-8?B?eGgzK3N0c1BCanp4azg5VlZwODhHajhMNjBBdmpzTGd2ZExGL0x5NDBDZXlZ?=
 =?utf-8?B?bXgrOHI5YTMwOS9sRmpCSUx4Zm5oV2V3RDl4aXZMS3I0OTNzREIwblJJMHJG?=
 =?utf-8?B?VTZ4eFVOQmRBWFRhYTkzWmQxR2xTMGlkYmlQYVE0U2N6dDBNM3dNNGhNY1l3?=
 =?utf-8?B?dG1DZTBTVGVyY2YvRGxZeUd0dmEyTHR1aE9Lb0wzQTlvbXhOWDB6VUV3Nk5y?=
 =?utf-8?B?a3VFalhjR0hReDNOS2JSYWJ4b203MURKc3lKVUpOZWsyYTlCYngydy9HSGZT?=
 =?utf-8?B?VWZPVUhxL2NyQ2RBaHJnbkY0YVdFNmp3WHBLWWRhc0hhWjFKK1R1bUlpOU1F?=
 =?utf-8?B?aGpFcCtpb202dFRrVkJQSHIreFY0Mk0wN3duVllVWURlVUxPdHlKWjN3SkVZ?=
 =?utf-8?B?OU42YmFuRWNqQXAyYXVndXFmRU5Sa0IwVVdVL1JOaTA1bG9rNWpHdThYUVNz?=
 =?utf-8?B?bzNUVFBHMEhLZFd6bmdxcUJnSk9nOFVlMEFRVUNIWDFYaDdHOFFBSlNHMWln?=
 =?utf-8?B?bWVLV1pkV3dpd2d5aWUyZEY5M0M5NnU4V0MxNS9taVVSTmxRMWx3TVB1S1Y3?=
 =?utf-8?B?SkRCK3JsRks4YUE2ZjdwR0UxL0g4TEpxb21XSjh0R2FjU3VGaWJVTzFSUysv?=
 =?utf-8?B?M3hWbG1CdGRzUWR0K3E0VU9xT3NTQlM0UW04eVdWWmhhNFRkV0JQUCtpTUhJ?=
 =?utf-8?B?VVRXa3JoWUJqbWJaSVRBb1NrYnErNmRBdElpak5mcmJRbFl1K3c2d0ZMNmFx?=
 =?utf-8?B?d210MmJlbXlLbUJwUUZ0clk2SnFGTW9Ob1MxbUtsclY0TzE5Zy9mNFBiOG5R?=
 =?utf-8?B?aUN6Y1NsdmVZWTMrQlJDTHRORUNha3Q4dklhSlgrakExck85R3lVdzVDQ3hV?=
 =?utf-8?B?b014VjNQUlZHWWNyZjVaTUxWQmJPVjlHdS9BYlppTXBvakR4R3ZkeVZzS3Z4?=
 =?utf-8?B?Q3RyNWxNbFY0MGpqMmpPS0k5NzlsaHdiY2Nya1dyVnlmeVdXMzRBR3lnbE1F?=
 =?utf-8?B?ZUl1SjBzMEVMUVIyUzBaWUx5MnVUcmxuZERLSUJiS1NObCtvTS9hU1BCMG9w?=
 =?utf-8?B?Y3RVYnlzbXBhT3Z1R2lFRWVoN1NiTGpYOG0rZGxZdUlTT0tlQ2dsR2xqR0Ur?=
 =?utf-8?Q?uA4bhyZePQCoOJihWqgqy9UXZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f840b4-4749-4e16-5f96-08db4007a7fe
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 12:23:03.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdWnkQm9P5Y432AynCEvLRT0ee6wYVpPAc61piNkcSHhFM2XsaklmOBGg6qkS5T0GfD5kHNUUvbJ2p4DppVdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6278
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy and Miquel,

On 2023/4/18 13:12, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> 
> On 13.04.2023 13:35, Arseniy Krasnov wrote:
>>
>>
>> On 13.04.2023 13:22, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Thu, 13 Apr 2023 12:36:24 +0300:
>>>
>>>> On 13.04.2023 11:22, Miquel Raynal wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>> avkrasnov@sberdevices.ru wrote on Thu, 13 Apr 2023 10:00:24 +0300:
>>>>>    
>>>>>> On 13.04.2023 09:11, Liang Yang wrote:
>>>>>>>
>>>>>>> On 2023/4/13 13:32, Liang Yang wrote:
>>>>>>>> Hi Miquel,
>>>>>>>>
>>>>>>>> On 2023/4/12 22:32, Miquel Raynal wrote:
>>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> liang.yang@amlogic.com wrote on Wed, 12 Apr 2023 22:04:28 +0800:
>>>>>>>>>     
>>>>>>>>>> Hi Miquel and Arseniy,
>>>>>>>>>>
>>>>>>>>>> On 2023/4/12 20:57, Miquel Raynal wrote:
>>>>>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>>>>>
>>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>>
>>>>>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300:
>>>>>>>>>>>> On 12.04.2023 15:18, Miquel Raynal wrote:
>>>>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>>>>
>>>>>>>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +0300:
>>>>>>>>>>>>>      >>>> On 12.04.2023 12:36, Miquel Raynal wrote:
>>>>>>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:
>>>>>>>>>>>>>>>        >>>>>> On 12.04.2023 10:44, Miquel Raynal wrote:
>>>>>>>>>>>>>>>>> Hi Arseniy,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
>>>>>>>>>>>>>>>>>          >>>>>>>> This NAND reads only few user's bytes in ECC mode (not full OOB), so
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> "This NAND reads" does not look right, do you mean "Subpage reads do
>>>>>>>>>>>>>>>>> not retrieve all the OOB bytes,"?
>>>>>>>>>>>>>>>>>          >>>>>>>> fill OOB buffer with zeroes to not return garbage from previous reads
>>>>>>>>>>>>>>>>>> to user.
>>>>>>>>>>>>>>>>>> Otherwise 'nanddump' utility prints something like this for just erased
>>>>>>>>>>>>>>>>>> page:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>>>>>>>>>>>>>>>>      OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
>>>>>>>>>>>>>>>>>>      OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
>>>>>>>>>>>>>>>>>>      OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
>>>>>>>>>>>>>>>>>>      OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>     drivers/mtd/nand/raw/meson_nand.c | 5 +++++
>>>>>>>>>>>>>>>>>>     1 file changed, 5 insertions(+)
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
>>>>>>>>>>>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>>>>>>>>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>>>>>>>>>>>>     static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
>>>>>>>>>>>>>>>>>>                        int oob_required, int page)
>>>>>>>>>>>>>>>>>>     {
>>>>>>>>>>>>>>>>>> +    struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>>>>>>>>>>>         u8 *oob_buf = nand->oob_poi;
>>>>>>>>>>>>>>>>>>         int ret;
>>>>>>>>>>>>>>>>>>     >>>>>>>> +    memset(oob_buf, 0, mtd->oobsize);
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I'm surprised raw reads do not read the entire OOB?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Yes! Seems in case of raw access (what i see in this driver) number of OOB bytes read
>>>>>>>>>>>>>>>> still depends on ECC parameters: for each portion of data covered with ECC code we can
>>>>>>>>>>>>>>>> read it's ECC code and "user bytes" from OOB - it is what i see by dumping DMA buffer by
>>>>>>>>>>>>>>>> printk(). For example I'm working with 2K NAND pages, each page has 2 x 1K ECC blocks.
>>>>>>>>>>>>>>>> For each ECC block I have 16 OOB bytes which I can access by read/write. Each 16 bytes
>>>>>>>>>>>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when I read page in raw mode
>>>>>>>>>>>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is reported as 64 bytes.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> In all modes, when you read OOB, you should get the full OOB. The fact
>>>>>>>>>>>>>>> that ECC correction is enabled or disabled does not matter. If the NAND
>>>>>>>>>>>>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> What happens sometimes, is that some of the bytes are not protected
>>>>>>>>>>>>>>> against bitflips, but the policy is to return the full buffer.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ok, so to clarify case for this NAND controller:
>>>>>>>>>>>>>> 1) In both ECC and raw modes i need to return the same raw OOB data (e.g. user bytes
>>>>>>>>>>>>>>       + ECC codes)?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Well, you need to cover the same amount of data, yes. But in the ECC
>>>>>>>>>>>>> case the data won't be raw (at least not all of it).
>>>>>>>>>>>>
>>>>>>>>>>>> So "same amount of data", in ECC mode current implementation returns only user OOB bytes (e.g.
>>>>>>>>>>>> OOB data excluding ECC codes), in raw it returns user bytes + ECC codes. IIUC correct
>>>>>>>>>>>> behaviour is to always return user bytes + ECC codes as OOB data even in ECC mode ?
>>>>>>>>>>>
>>>>>>>>>>> If the page are 2k+64B you should read 2k+64B when OOB are requested.
>>>>>>>>>>>
>>>>>>>>>>> If the controller only returns 2k+32B, then perform a random read to
>>>>>>>>>>> just move the read pointer to mtd->size + mtd->oobsize - 32 and
>>>>>>>>>>> retrieve the missing 32 bytes?
>>>>>>>>>>
>>>>>>>>>> 1) raw read can read out the whole page data 2k+64B, decided by the len in the controller raw read command:
>>>>>>>>>>      cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
>>>>>>>>>> after that, the missing oob bytes(not used) can be copied from meson_chip->data_buf. so the implementation of meson_nfc_read_page_raw() is like this if need.
>>>>>>>>>>      {
>>>>>>>>>>          ......
>>>>>>>>>>          meson_nfc_read_page_sub(nand, page, 1);
>>>>>>>>>>          meson_nfc_get_data_oob(nand, buf, oob_buf);
>>>>>>>>>>          oob_len = (nand->ecc.bytes + 2) * nand->ecc.steps;
>>>>>>>>>>          memcpy(oob_buf + oob_len, meson_chip->data_buf + oob_len, mtd->oobsize - oob_len);
>>>>>>>>>>
>>>>>>>>>>      }
>>>>>>>>>> 2) In ECC mode, the controller can't bring back the missing OOB bytes. it can read out the user bytes and ecc bytes per meson_ooblayout_ops define.
>>>>>>>>>
>>>>>>>>> And then (if oob_required) you can bring the missing bytes with
>>>>>>>>> something along:
>>>>>>>>> nand_change_read_column_op(chip, mtd->writesize + oob_len,
>>>>>>>>>                 oob_buf + oob_len,
>>>>>>>>>                 mtd->oobsize - oob_len,
>>>>>>>>>                 false);
>>>>>>>>> Should not be a huge performance hit.
>>>>>>>>
>>>>>>>> After finishing ECC mode reading, the column address internal in NAND device should be the right pos; it doesn't need to change the column again. so adding controller raw read for the missing bytes after ECC reading may works.
>>>>>>>>     
>>>>>>> use raw read for the missing bytes, but they are not protected by host ECC. to the NAND type of storage, is it ok or missing bytes better to be filled with 0xff?
>>>>>>
>>>>>> IIUC Miquèl's reply, valid behaviour is to return full OOB data in both modes. So in:
>>>>>> ECC mode it is user bytes(corrected by ECC, read from info buffer) + ECC + missing bytes. ECC and missing bytes read in RAW mode.
>>>>>
>>>>> I believe the ECC bytes you'll get will be corrected.
>>>>> You can check this by using nandflipbits in mtd-utils.
>>>>
>>>> Sorry, didn't get it, i'm new in NAND area. Bytes of ECC codes are available only in raw mode (at least in this NAND
>>>> driver) also as missing bytes of OOB.
>>>
>>> Gasp. Yeah that's a controller limitation, okay.
>>>
>>>> So IIUC ECC codes are metadata to correct data bytes, and thus
>>>> couldn't be corrected.
>>>
>>> We consider them metadata, but they are fully part of the ECC scheme
>>> and thus their correction is part of the process, bitflips in the ECC
>>> bytes will count as data bitflips actually.
>>>
>>> I talked a bit about ECC engines at a previous conference if it can
>>> help:
>>> https://elinux.org/ELC_Europe_2020_Presentations
>>> 'Understand ECC Support for NAND Flash Devices in Linux'
>>> And also wrote a blog post with a chapter about ECC engines:
>>> https://bootlin.com/blog/supporting-a-misbehaving-nand-ecc-engine/
>>
>>
>> Thanks for this!
>>
>> Thanks, Arseniy
> 
> Hello again @Liang @Miquel!
> 
> One more question about OOB access, as I can see current driver uses the following
> callbacks:
> 
> 	nand->ecc.write_oob_raw = nand_write_oob_std;
> 	nand->ecc.write_oob = nand_write_oob_std;
> 
> 
> Function 'nand_write_oob_std()' writes data to the end of the page. But as I
> can see by dumping 'data_buf' during read, physical layout of each page is the
> following (1KB ECC):
> 
> 0x000: [         1 KB of data        ]
> 0x400: [ 2B user data] [ 14B ECC code]
> 0x410: [         1 KB of data        ]    (A)
> 0x810: [ 2B user data] [ 14B ECC code]
> 0x820: [        32B unused           ]
> 
> 
> 
> So, after 'nand_write_oob_std()' (let data be sequence from [0x0 ... 0x3f]),
> page will look like this:
> 
> 0x000: [             0xFF            ]
> 0x400: [           ........          ]
> 0x7f0: [             0xFF            ]
> 0x800: [ 00 .......................  ]
> 0x830: [ ........................ 3f ]
> 
> Here we have two problems:
> 1) Attempt to display raw data by 'nanddump' utility produces a little bit
>     invalid output, as driver relies on layout (A) from above. E.g. OOB data
>     is at 0x400 and 0x810. Here is an example (attempt to write 0x11 0x22 0x33 0x44):
> 
> 0x000007f0: 11 22 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |."..............|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>    OOB Data: 33 44 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |3D..............|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>    OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
> 
Hi Arseniy,

I realized the write_oob_raw() and write_oob() are wrong in 
meson_nand.c. I suggest both of them should be reworked and follow the 
format of meson nand controller. i.e. firstly format the data in Layout 
(A) and then write. reading is firstly reading the data of layout (A) 
and then compost the layout (B).


> 
> 2) Attempt to read data in ECC mode will fail, because IIUC page is in dirty
>     state (I mean was written at least once) and NAND controller tries to use
>     ECC codes at 0x400 and 0x810, which are obviously broken in this case. Thus

As i said above, write_oob_raw() and write_oob() should be reworked.
i don't know what do you mean page was written at least once. anyway the 
page should be written once, even just write_oob_raw().

>     we have strange situation: OOB seems written without any errors, but we can't
>     read this page. First idea is to write OOB data to 0x400 and 0x810 in raw mode,
>     but this does not work - if there is some data, NAND controller will try to
>     use ECC engine to check these user bytes on next attempt to read this page. But
>     as these 4 bytes were written in raw mode, ECC codes are missed.
> 
> We suggest the following thing: use only area at 0x820 for OOB (see A) - it is not covered
> by ECC engine, so write to this zone won't conflict with ECC in future. In this case
> we change 'meson_ooblayout_free()' function which instead of describing 2 user bytes
> for each ECC block, will return 16 tail bytes for each ECC block.
> 
> What to You think?

the key point is that the data 0x820-0x840 is not protected by Host 
ECC.so i don't think we have to change it.

Thanks,
Liang
> 
> 
>>
>>>
>>> Thanks,
>>> Miquèl
> 
