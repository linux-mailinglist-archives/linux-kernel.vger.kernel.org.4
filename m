Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7172273B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjFENUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjFENU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:20:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D05A6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU+PfNIYI4M08wv5xv7Uok2+wqVtD70cwzJLn3TTfXzCgjO5jDL+RXYErENvXIwn7y4y+nUkWbD3TrBn1MAlU32mHjuS/DJjYIUlJw7AxUyhpm+5RszsR8GoBbVlCB5TRsEIQTpY2pYz1dtl61rsNc7/qFr8sjJOwiYDeTMTEDUc233z3X3Exa/PElg2m30mRsxWCFOrfxD8sZlgsagkhpUAXBl6nhjF7EpNQI+nDp5JalEW+2h24V9oD/Ery9OYCfnLE4Zxft7bz//2Mn/rVqxGbRs9cFwo+Az09RXVNhYanLiyaOoSZxaHg/0jhhkkz2+VHiGt2l5tnEIsVzZIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlVaCU9qUpBlVnAZ2hu46ODagJrBZ2n7SgbFubqRGL8=;
 b=cIZ9Nb6ORfvz3qJ/v5IulRCkmDs3Vo/RVH5GnR2rhJ6LESvynyrJDL17Y1NCBSqpCE7e+OkENDmCe9EjPfn6IxTw6H92NqxLW+wHPkpdIs9kJtTk2lO6Sgnu3uL9HDFlusClajItKUcW+CCMG6IS07aCO5G1WoijghDmSgWLunvR5CTF+Qu0Q64BB9lN9Bm1aEUr/av3ZaoVBFGeTQOAH5KB+U10QSTIqyJEztOmd2Zhoyg0qL53kkhP5QYsotqiV2Gd9j0HcFPnTBnA5shDj2Sj46f7x4hcuIjoxgMP1igw02uyExbAz2a3tJZswF47itKsb/cLJ4ld8ig5G3XvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlVaCU9qUpBlVnAZ2hu46ODagJrBZ2n7SgbFubqRGL8=;
 b=cRZ/IV92bgAbfTQ1p6Nf1JtH297o4VDjBGroKMj2y02zoixJjg15Oj38OCnzQwDeMSsbWbxvmeHHC/XxiYExvAvGg5+8zcA/kAfu9RFeZZAqHb2oO98oipY5caGRYRRzqWzodxuPimoOjXEeCZ0EsDzMVVBeE5ejJCPfpilJYpm4uYuDxzBckSMVB8HtpznML/yK5YWeFShMzD8bojEmuaJR99LBMoqzCTBDgHlFdZ+ODL1Vxjp55wfH1VU8MErOFFD9P8eYJgGkV39bsFlb4pVIgRGmD8cy+qOb9zlIduGFSJsa7GYQSNRx6mTLUIxeWGo4O7Qbayqs6Ql6vPtl9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 SEZPR03MB6914.apcprd03.prod.outlook.com (2603:1096:101:a5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Mon, 5 Jun 2023 13:20:19 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%5]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 13:20:19 +0000
Message-ID: <2a755783-1d56-9842-2eee-b5ab41152c81@amlogic.com>
Date:   Mon, 5 Jun 2023 21:19:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
 <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
 <20230601100751.41c3ff0b@xps-13>
 <9e106d50-2524-c999-48b1-a20760238aaf@sberdevices.ru>
 <20230605110546.6cb00a8d@xps-13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230605110546.6cb00a8d@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::17) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|SEZPR03MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aec5691-6d23-4998-3df9-08db65c79b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0BNcWphX1dv8rvUc0ww6oUYmi4WUOTOQs9s3XM6tsQfdk1xVRrefKnFzEJ0CeTDLjDU3w8IpnS3qjvg9aec3s/vAhJC5c3sreaCPxSmVhlsR8qF/OpOI91bkMIMKmTHjjSdY29X9BjCsUC2Er1msSvVJWh5+QoNh/22my1i2H9//gEVJuTr5giqObm5N5RMRlR6FVp9O9FhM0kQbys0WPvOVR+tjTf3f3ty57SlZZYe9aLwBbNRpnUQx2+YsAEGZgwV1GO8uuis8/hhOpGV2A1xY7B1g6Y5HEZTG2FEF62yLCjO8jYgNp61ioIhE4zZYckA7mCxjUwdr/m9CGM07iS8rTON7wuWwBMIcAlsNwmdK5iO6//up8hpgHy7+jfGufmRR2E8h4HAq90txTfeCBYL8Pv5rzjCBaTGxBwZ6JzUp1gd/1w2+l3Gcke2o5u/9vBKuPJ8zaRazUjYK/3Oms1OBH49tvu0kQXLMFLSE2BqH8Th8IMvL6NQ1Fc4iKkPYYwLq1Wd95cK0CHipiG2xZgnc7CuM2o9A94t7k/JVzHCXX/WfWLP+JCqkdBcxykdogI1+KsfIMNkGRAts84+VA6RfNCAgTwXprSR+RAgvjw5fL8AkqkQm/oCz7KlVADr1EXq0NNfjLjiCsdlRpCOQWTr1Ze5OHmb+x3AWMWGiMFjV8cVf3DnKXISif0ELCuk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(451199021)(110136005)(478600001)(8936002)(5660300002)(44832011)(8676002)(54906003)(7416002)(36756003)(86362001)(31696002)(4326008)(66476007)(66946007)(66556008)(316002)(38350700002)(38100700002)(41300700001)(31686004)(83380400001)(66574015)(2906002)(6506007)(2616005)(6666004)(6512007)(53546011)(26005)(186003)(52116002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZElJby9FUHlSVDBpUHdPV0x3L24vdWI4a29IYmwxdVNMSlJZT1RGOXRlNUUw?=
 =?utf-8?B?eXFVeTgvTjF0M1dJbzE1amk0dDAwdnducTgzc0hHS2RDYWVJL2NhRFYxNWkr?=
 =?utf-8?B?YXdJeWZwVFF5VU0xTzl4Q1Vkb1FqQ2taTmFySWlIUURMTG5UYlFoWmh6WlMy?=
 =?utf-8?B?Y0hpeXA0R3ltMFpvTnZXNUJMK0dQRzRUTzQveThKY2dyaWtTUEMzd3lCZ0R3?=
 =?utf-8?B?emMyejdLeDJVTXoxZ1VlM0xWUldIL3FoNmJPQ3pISUNOR3I4VXRpaDhFQnJS?=
 =?utf-8?B?cERZalhpTVZXbEQzYmFvQWxOUUNYM09LSTlJVUh3VVU3WnJwUjlnalFtZ1hh?=
 =?utf-8?B?dGpkelVPWFkwangzbGRqcjBGeGFnVFNLZUtET0JkMHY1bnhuL1dmL1hMQ24y?=
 =?utf-8?B?aGZZNVM5Nmh2ak9YMjVpSnhzQnY0eGRQcU5xN1RqZEhuMlJWdW1UY1RYbklq?=
 =?utf-8?B?bS9tanJNaGdHRkFvSHYwVEpDU0swWWFhczZiOVFwT0ZCT3BSSmoxOFlNRGVZ?=
 =?utf-8?B?bmsvWUZtclFNb1dGT0NPdmZCSzhMbFF0cEFOa3ZPR3N6TXhzYU5BeXJBSnVV?=
 =?utf-8?B?L1cwOXhINzdsOEtHUlRaQURzZEIzRjVtTTJ1SVR6S2pFT3MyWEl5WnZqR1My?=
 =?utf-8?B?SlJJVU5pRitRNmlUZy83aUkvK05Lai8vMU1ScE5ZVFFmdVNBajBCRExlWDU5?=
 =?utf-8?B?SlRqbVNuRFZjQ2VIZzJoaVh5NEtlYnZ1UjJ2c1MxaGhWMlVpcS8wdkd6bGRH?=
 =?utf-8?B?b1RRQWZKbWxXN2FoRmlXSzM4eFFKd1VEQ3g5ZC9yaWJRejdYaGpvV05DM0da?=
 =?utf-8?B?ZGVYVE9tdit5WUJXTEFuaHRsSUpFa1htODVuV0l2TUFaU0RRTzM2dGFWQlJT?=
 =?utf-8?B?ak9YYWxsa09DcTQzVU5xck9ManE4WC91Z1gwU3ByM3RwRndDclhsa0trenlP?=
 =?utf-8?B?N094Sm5lSDIyQ0lFanFFN1duVHZFT1QyRFlOaTIxTVFJcXNiYWxDK3VmNW5K?=
 =?utf-8?B?bDVsNlJmVG1HQktJeTNGK3ZCZzJaelZ1Z042Q2NzbnJGeVVuem1iNkJtVkUw?=
 =?utf-8?B?dFZ6MVBMaHdMbHRxV3BVd3gvZFlQb2hwOWswVjRIT0pRMzMvM1YxMzVKK2o2?=
 =?utf-8?B?SFNqZzRWcVZiUjdGd25qRTlhNzd3b2QwcWF5K01mSHB6WmYzNG9RZ29hVHU0?=
 =?utf-8?B?NkQ4N0ZpNTFDcXlKT09ETVZzSHZxdlpPUk9UWXNtUUpjRlc0c1lWY1QzMDRt?=
 =?utf-8?B?Y3g4SGE0eVNvZFZSWjRxZnRjcTRkYkxJYTlybnVoY24zNkdhQXFaYUlGOXlT?=
 =?utf-8?B?akRJY25CS0tGaEFESGplc0YwejBYSkdMM1JwMGpjSlU4eFhkbzIweENoMXdF?=
 =?utf-8?B?eStNYnZXWUQxTU1mdFRyVDFDTDd4UkJ1OU9hbm9nRkdiQ0NRMmdSZE1VS2VB?=
 =?utf-8?B?bEV6czIvOXlESzBXSUxLN2kxWDhXa05jREVEd2hDTDNmSHZEelVuV1RNK3pQ?=
 =?utf-8?B?MmwwVmZKbzY5dUlPQzQ3Si9NSmVNdndNb1VOdFlWcXg5VWVKS2kwbW9xNlky?=
 =?utf-8?B?NFdDUXQ5T2dPeFFtWmdGUzJKTExkL25kVlVSb1V2L1ZnbVl1KzU3bkZaRGNh?=
 =?utf-8?B?alZ4ZGQrcW1nbEpvb1VIUDdWK2xrWVNMeFp5QXY5QnBJcXZEK3lPOUNQQXl1?=
 =?utf-8?B?cU91aVZyT2FUckR3YzFhcldpeGpMbzljSlg1NEQrSkp3VVljL3E0VzBFL1da?=
 =?utf-8?B?MkttQVhmR0d6WlVqNDJZeTV4b1dPYmlibDl3cXhuQ0NnMXo3RE0vRHltaTFY?=
 =?utf-8?B?STFmeGhLRmZ2VE5MaTdXUHBOajlWa05oSWxvUEhqOXBtYkZjNm4vMjJybmlC?=
 =?utf-8?B?REt4Y1dwbzhvUGt0dnhuWmpFSkwrVzdtOE4xR2MyRUhNTy9xK3BWT2loV3l6?=
 =?utf-8?B?S0c1MUF5Ykd1WmxmYVRsbzJWc0dOK2RLQVhaR3Bmb3BLTG1DQmZQcFhNZWtQ?=
 =?utf-8?B?S216VkprM0k2SXkwS0g1QnVIK0J5VjBEczlhODhFQjFNc2xRV0t6S3hOSWxp?=
 =?utf-8?B?QmlETjBPTzc3L0lld0M0SXRVRGEyaDY2QldacXF4N2d4NCtUcTlwVGVpMVFB?=
 =?utf-8?Q?zLWXN0gnSliXJeBcrK/3FWb74?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec5691-6d23-4998-3df9-08db65c79b78
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:20:18.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHGJNJF6/nWECod8H4bIYBicPNOCQNgsguDmWRyjq7mMT0Q1oWKzuMMWxSV964QSJJtKnn07LHVR7tFPavGynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6914
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel and Arseniy,


On 2023/6/5 17:05, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Arseniy,
> 
>>>> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>>>             return ret;
>>>>     }
>>>>
>>>> +  nfc->use_polling = of_property_read_bool(dev->of_node, "polling");
>>>
>>> This is a problem. You cannot add a polling property like that.
>>>
>>> There is already a nand-rb property which is supposed to carry how are
>>> wired the RB lines. I don't see any in-tree users of the compatibles, I
>>> don't know how acceptable it is to consider using soft fallback when
>>> this property is missing, otherwise take the values of the rb lines
>>> provided in the DT and user hardware control, but I would definitely
>>> prefer that.
>>
>> I see. So i need to implement processing of this property here? And if it
>> is missed -> use software waiting. I think interesting thing will be that:
>>
>> 1) Even with support of this property here, I really don't know how to pass
>>     RB values to this controller - I just have define for RB command and that's
>>     it. I found that this property is an array of u32 - IIUC each element is
>>     RB pin per chip. May be i need to dive into the old vendor's driver to find
>>     how to use RB values (although this driver uses software waiting so I'm not
>>     sure that I'll find something in it).
> 
> Liang, can you please give use the relevant information here? How do we
> target RB0 and RB1? It seems like you use the CS as only information
> like if the RB lines where hardwired internally to a CS. Can we invert
> the lines with a specific configuration?

Controllor has only one external RB pinmux (NAND_RB0). all the RB pins
of different CEs need to be bound into one wire and connect with
NAND_RB0 if want to use controller polling rb. the current operating
CE of NAND is decided to "chip_select", of course controller internally 
has different nfc commands to regconize which Ce's RB signal is polling.

<&nand_pins> in dts/yaml should include the NAND_RB0 if hardware 
connects, or use software polling here.

@Arseniy, sorry, i don't travel all the informations yet. but why don't 
you use the new RB_INT command with irq that i provided in another 
thread. the new RB_INT command doesn't depend on the physical RB wires, 
it also send the READ status command(0x70) and wait for the irq wake up 
completion.

> Arseniy, if the answer to my above question is no, then you should
> expect the nand-rb and reg arrays to be identical. If they are not,
> then you can return -EINVAL.
> 
> If the nand-rb property is missing, then fallback to software wait.
> 
>> 2) I can't test RB mode - I don't have such device :(
>>
>> Also for example in arasan-nand-controller.c parsed 'nand-rb' values are used
>> in controller specific register for waiting (I guess Meson controller has something
>> like that, but I don't have doc). While in marvell_nand.c it looks like that they parse
>> 'nand-rb' property, but never use it.
> 
> Yes, the logic around the second RB line (taking care of CS1/CS3) is
> slightly broken or at least badly documented, and thus should not be
> used.
> 
>>> In any case you'll need a dt-binding update which must be acked by
>>> dt-binding maintainers.
>>
>> You mean to add this property desc to Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml ?
> 
> Yes. In a dedicated patch. Something along the lines:
> 
>          nand-rb: true
> 
> inside the nand chip object should be fine. And flag the change as a
> fix because we should have used and parsed this property since the
> beginning.
> 
> Thanks,
> Miquèl
