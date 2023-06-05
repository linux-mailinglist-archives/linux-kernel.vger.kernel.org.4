Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1A72276E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjFENa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjFENax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:30:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E9F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb/Fw1qYqJ7/BWBBr1BiEvwYPfvzc5z4AN7AXZ0Me1D+HI3hYXVwrr7D7FoKftSx/5krSfkRDoP89gDJdSdyanyq2Us5Qf+Uf7CPiBj6VTHiWeoG1bHEiLQQiYPVnq9BHA7jBmovT53p5OoebyQEAl4KPWZKrFYYx7B7uv9KL9KsgGYERjRPzT3BlvjjQIDxc8xVXcsm7Niv66aLR4bfBSkZEJ4a8opivT9K0lKR3z3sP6/nJfn4UnjLuFo1uDCg5pRrM8PYk5UrLZBlsI9/FLXk+MgOQziFSmr4Onqm9+OMbM7LdpuP9NOBECS1Hq/AiuPj/bFS54UIdqQnTp2yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AOf8Mi5+6XHmr+qXMtay8Qr5ZKz3w93LDE/dk8pGVI=;
 b=YoSAKTjqsr4P5mlTIMviRD14PBOjrCo8sihrf6q7yxEFAw2xmp4A6n4FmXoO0YhAvgkBKvp7oCUP1YuyHJ/1809JxgtHQaJkG0OCijfKh6YjpTzPwcklmajiLYDj46N3GxFOwYTXLeWTI+hfxRrn/ASVYmvLUtO257nN0NoifVjQ3MyJRG/XaruMnL2gMjEBRikdsrC+YeBeQsNMYRp0RuWlQs/zeJYtvzqC3DD0nCwLIOJuebitTLWO+5q7U1TDz7BJbtOmPio7FugvfzdYo16yslS3gmzrt2EFfrdI6XrzC7ktN4CdCwXrqHpEsZpnpwRRMzdwW7/088QjMte/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AOf8Mi5+6XHmr+qXMtay8Qr5ZKz3w93LDE/dk8pGVI=;
 b=GRsM1EwKXYenixBFt+tImkxogsUclVvvqTfSXhJwlcsVitWnAcblkPo+4q7UUfoPCSiT/wCenwML4YSiCBXxwjZ0V3Qwa/VLg/L5d1Tz3hHnGJ7oqlxm4f7WQ10JSRBLopIQ28QQ+GhsVfVFo2QshejSZEXaX2bBBOTZhuPpAluZwgg5Jy1nXKGiO5oqW9/7WlB9xRFL0YIMcLd1ERmgnuNVZ0hOeFpBogKM588TMvvvmjQ+CbaY4iaITQkLeCAmF4roCJ7HwdUheet2LE9hYlO2BqcWImmHrPgk/SqUfb+6eT0hXC1PUkiaG1YSxS/P7vJ4HyzOdtY0c3AqncK4vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 TYZPR03MB5584.apcprd03.prod.outlook.com (2603:1096:400:57::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 13:30:46 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%5]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 13:30:46 +0000
Message-ID: <163e0684-caff-77d0-1eaf-9a58290c200d@amlogic.com>
Date:   Mon, 5 Jun 2023 21:30:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
From:   Liang Yang <liang.yang@amlogic.com>
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
 <2a755783-1d56-9842-2eee-b5ab41152c81@amlogic.com>
In-Reply-To: <2a755783-1d56-9842-2eee-b5ab41152c81@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|TYZPR03MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bc3a8f-bfde-41db-e4ee-08db65c9116a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/0GAeuVmNYFbgR1z8RfzXveDdjR2AzQSSf0jnRPmadXKeo71K+Ji1rKhEPSKYFash0F3l1XN7/vrGi8mZJugXlP8tIQqcOIIdID/8GqnXR1UlQDVFa8eArgZQUmkMwee82O65nlWKT2aSl/OgEsikTJKp23TuODmR5Bm13IueLQcYVdmax5L969M/2CxymqcNZC29uJb88EySBC7yhaMOm5+OL/n5e7S/Xd0sNq2R7RUwboa80BQjgFgpMZqsauIoVNFpcs6D0+936Dajwr9MzO7gs1rtBADrAYmgwwA3Nvu89TkvnWX/aqWxNsBvNr88i+RGWJ2+xKYgVXd8pqyq604uwgDWsQ2Nb3GpMlaI6grsS1Ik/ftd07JgVEpaiUwlxOX1dg7M7wf8O+DdT9o74MBX0mN7VKHA1d4XQzRW/4zEvXAzqTNAji8xQM3T4o6QZnIYBZUB9ODF7s23LG6AAwW5acI6LYpkjC8r2D2+iArkDR26sHPt4LTJ39yF3zZhc7fsA4eLgEaXf8AfPmMGq29TJvSSqWFc/rWHQppeIffbt28OBsFQk2OtRGTfd9n9HF0ql/2+ClXwcYtuEGKMiItkU7eBgTTnYRfS6c8R+cAkIlT1JiDvTCkxEMPvmZBHRYQCOTW5HaLyJQ+37VIDzBLCFf92kQCjJcRxtkyG4B7CPqG4aAY1ZAppjFM7jR5XdA063+B+m0tuLLTmLnDfcJPG3wOHwVb1h4rvD03c8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39850400004)(376002)(366004)(396003)(451199021)(54906003)(110136005)(478600001)(8936002)(8676002)(5660300002)(44832011)(7416002)(36756003)(2906002)(31696002)(86362001)(4326008)(66476007)(66556008)(316002)(66946007)(38100700002)(38350700002)(41300700001)(2616005)(53546011)(6512007)(6506007)(26005)(186003)(66574015)(83380400001)(6486002)(52116002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJRNXc4TXpFMU1WSStQZVVrZDRDV2MwK2tyNGpRWUJZcFM1Mm9kQTRuclJ4?=
 =?utf-8?B?QjVBYjJiejBwYmpmaHdtdHkxMnhvdGh0ajQ4WGNEc0s1RkJWeENHWmFCeUpa?=
 =?utf-8?B?VlpVSFh0VmlqNU5TT3Vqa2pRSlhGekE1WDJKZjk5WHd2RG9MdER6RWUvY29Q?=
 =?utf-8?B?bWVJdkhSbm11MGdiSjREeG9ud1JpS1J0Qm5IeDRFL3JSd09JS1IxTzVVbk9D?=
 =?utf-8?B?bnU0VmgzRGd1SCtmeVV4N0dxNldkNW5heGFnTGZnY3M0OXpYK2ozcTRkVVhG?=
 =?utf-8?B?cEFkZFNFSkN4dHlNYmdMSG4wTjU4QWxLTmp6WFEyWGxvV25KTmVKd3ZwQVUv?=
 =?utf-8?B?eEVHYkd5RWt5QXRlUUhzZm8xMlN1NjhTeWpoQWVXUDFZQUNianVYeCtaejVH?=
 =?utf-8?B?RzJQWmxVV0w0MVZXNDd3UU9rTjRsNzArUVkwcFNqUHprRkhFdjZCQVk5VWZq?=
 =?utf-8?B?SlRJVTFaZ0E5UUFBQXRYTGlzQ2hOODVuMkM4QmVGQWQrL21YS0FyTHZHSzN1?=
 =?utf-8?B?ckxETldDRWhJOUFiWUhsbDd3MVM3cUwydmFtMjkzSVBYemhBU05Bd3hYcW91?=
 =?utf-8?B?N2ZqSVVNaWwwYVk0c0Nsa1AxaTN0ZUN6L2RkTjI5TjE0VGtuQlg0dEYwTGVj?=
 =?utf-8?B?WGRqaEpxSEg3RTJ5cmVxMHZrV0tQb281a1pHWTZKSFppZzZ0SHpVUmNIZllK?=
 =?utf-8?B?R3d5YjdCYTZGR3pPNmpLU0ZlcVZsbmh0dnA1Nyt3RWxWOFovMVN1ZXc2Q0Za?=
 =?utf-8?B?MHJrVUE2RlFXbkpXV05SMUVlSTVFY1hIZE5GY3JuUmpkN2VvUEF4NktQcnEx?=
 =?utf-8?B?cTNVRXpjMGJXeTRPRFB2dkpwdmVGck52UlIwcFVlWnc3ODFCTUh6Nk8zRlFU?=
 =?utf-8?B?VlhhSEZGdk8yQThybXBOMnQ1Y1ZreFRvYzBlN2tmRHkxNDd5VXZaQ3lXamo0?=
 =?utf-8?B?Znh5SUx1elB2WGk3V0xiNVd2TGw0QytiM3NGQkpTL0ZxZ3cyU3lGM0F0cjRY?=
 =?utf-8?B?dVJEUVUxK1VWZjNsRlIxZTg2KzBVM3pnQ0FEaThnVmdvZ3Z1ZkZxVmZ1YUFk?=
 =?utf-8?B?T3gxZHlOdElPRkJObDdxZWsxa1RXSE1GMTFNbGxxSzBLUEw1L0VPMXN1c1d0?=
 =?utf-8?B?ZWxzUGR6VE9GZ20xNUV2cGV0RlhMR1hOV3V2VkJESEpuZmZJVVJLWUc4RFQx?=
 =?utf-8?B?OXdhaE5Kd2lSWGlzbVFJS3N6M0syM2F0Q1ZJTXFnNGZCSmZmYTE4TlRlQlZW?=
 =?utf-8?B?L3I4UXFXbmtmU1o3aE16TnR0RGgyNm1ReGZFdEMzaUdyUmdtVUxRTlZaU0pD?=
 =?utf-8?B?MFQwQklFK3hZTWZ3dlJwbDh1N05mN1Axa3NPR3ptYWluTVlXOEdVSVJ2NnZz?=
 =?utf-8?B?WS9GNHA4WXM0bS9hUGprMWh5VnJmV3lGYVpBZEVZT1YxdjA5S1FWblJ6U3Fn?=
 =?utf-8?B?aG9yd1FWWkplanRQWCtSOHJHNkUvSmNrbHh2SEQ2WWU2V21sanZkVjg0amRX?=
 =?utf-8?B?YUsrRDZlenExcUFsT2FTSWpFWWVGUEtDcFJudmFSOUpEZDd4ajJ5TnhCRmQr?=
 =?utf-8?B?NDY1QWg4MC9lcmZnVEJOSzN1S1Fyd2E0TmZjVEhHYXU2UVJJb0p3ejRjbUJa?=
 =?utf-8?B?VkR5dG9sbDQzZUZVL0MwditmZGdSTHRncXV0MmJRdmFId2tsVW9FU0JFaEFo?=
 =?utf-8?B?Qk5QS2F2LytLMHVCcElYOWZHcU9mYW4xam5YSGVobC94ME9tTFF1V3hjd3Rh?=
 =?utf-8?B?TlQxb1RmN3d2WjJDMElEWW5oTWdPTG95UDVuOHgzUW1INGtqY3dKejhUK1gr?=
 =?utf-8?B?NWR2dUtld3crNHUranFWVGFhaG1DdmNLNFdYVXRDd21WL0IyaSsyL0ZOeG1I?=
 =?utf-8?B?QW5QMUFQNHJzZEhUY3hORDZucitTOHljejVoSm85TmhHeGh3RVB1Ty9vb0ZJ?=
 =?utf-8?B?alNOVDdrNkxOdjlHdU4xUDNVeDZMU0hxYU9EZkZsbllVNVk0MnUvRnVqdTlV?=
 =?utf-8?B?cWJQcXRUQTNxUUtZS1JNL25OMnR0ejdyNVlqY1dRaTJaZThzOEExd0w3VHhy?=
 =?utf-8?B?SzFiQjhIbXpzUGUvNGxNd0VTMWZFYUVSMHVrRFZQU0o3MWtWYW41elFCWU1r?=
 =?utf-8?Q?Z3lOuQlP2Kr0UTcznmuhyhNG/?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc3a8f-bfde-41db-e4ee-08db65c9116a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:30:45.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1t+ur1cjnv5FJxweQrYRGlQjbc37PQTqcLLMoQVt5ylUrEU7Ine2+bJ2n6GSomk3oxo8fvZygKg4b46tlaleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5584
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/5 21:19, Liang Yang wrote:
> Hi Miquel and Arseniy,
> 
> 
> On 2023/6/5 17:05, Miquel Raynal wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi Arseniy,
>>
>>>>> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct 
>>>>> platform_device *pdev)
>>>>>             return ret;
>>>>>     }
>>>>>
>>>>> +  nfc->use_polling = of_property_read_bool(dev->of_node, "polling");
>>>>
>>>> This is a problem. You cannot add a polling property like that.
>>>>
>>>> There is already a nand-rb property which is supposed to carry how are
>>>> wired the RB lines. I don't see any in-tree users of the compatibles, I
>>>> don't know how acceptable it is to consider using soft fallback when
>>>> this property is missing, otherwise take the values of the rb lines
>>>> provided in the DT and user hardware control, but I would definitely
>>>> prefer that.
>>>
>>> I see. So i need to implement processing of this property here? And 
>>> if it
>>> is missed -> use software waiting. I think interesting thing will be 
>>> that:
>>>
>>> 1) Even with support of this property here, I really don't know how 
>>> to pass
>>>     RB values to this controller - I just have define for RB command 
>>> and that's
>>>     it. I found that this property is an array of u32 - IIUC each 
>>> element is
>>>     RB pin per chip. May be i need to dive into the old vendor's 
>>> driver to find
>>>     how to use RB values (although this driver uses software waiting 
>>> so I'm not
>>>     sure that I'll find something in it).
>>
>> Liang, can you please give use the relevant information here? How do we
>> target RB0 and RB1? It seems like you use the CS as only information
>> like if the RB lines where hardwired internally to a CS. Can we invert
>> the lines with a specific configuration?
> 
> Controllor has only one external RB pinmux (NAND_RB0). all the RB pins
> of different CEs need to be bound into one wire and connect with
> NAND_RB0 if want to use controller polling rb. the current operating
> CE of NAND is decided to "chip_select", of course controller internally 
> has different nfc commands to regconize which Ce's RB signal is polling.
> 
> <&nand_pins> in dts/yaml should include the NAND_RB0 if hardware 
> connects, or use software polling here.
> 
> @Arseniy, sorry, i don't travel all the informations yet. but why don't 
> you use the new RB_INT command with irq that i provided in another 
> thread. the new RB_INT command doesn't depend on the physical RB wires, 
> it also send the READ status command(0x70) and wait for the irq wake up 
> completion.

Use "nand-rb" in dts to decide old RB_INT(physical RB wires is needed) 
or new RB_INT(no physical RB wires). the new RB_INT command decides the 
RB0 or RB1 by the previous command with ce args.

> 
>> Arseniy, if the answer to my above question is no, then you should
>> expect the nand-rb and reg arrays to be identical. If they are not,
>> then you can return -EINVAL.
>>
>> If the nand-rb property is missing, then fallback to software wait.
>>
>>> 2) I can't test RB mode - I don't have such device :(
>>>
>>> Also for example in arasan-nand-controller.c parsed 'nand-rb' values 
>>> are used
>>> in controller specific register for waiting (I guess Meson controller 
>>> has something
>>> like that, but I don't have doc). While in marvell_nand.c it looks 
>>> like that they parse
>>> 'nand-rb' property, but never use it.
>>
>> Yes, the logic around the second RB line (taking care of CS1/CS3) is
>> slightly broken or at least badly documented, and thus should not be
>> used.
>>
>>>> In any case you'll need a dt-binding update which must be acked by
>>>> dt-binding maintainers.
>>>
>>> You mean to add this property desc to 
>>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml ?
>>
>> Yes. In a dedicated patch. Something along the lines:
>>
>>          nand-rb: true
>>
>> inside the nand chip object should be fine. And flag the change as a
>> fix because we should have used and parsed this property since the
>> beginning.
>>
>> Thanks,
>> Miquèl
