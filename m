Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014E26E7168
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDSDFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDSDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:05:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F92527E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd4C5sbo9yMquwyVubnE5qoRcwEVV0uppJnAIpdTgh527RR0HPkhcHU31Nq1b7bnyixg73kPUN9bgkk8NSagckYvS4vlm7BEls7K4snISSM61I3veEJao7e3ieI3lW2tffEfNAtElUpHdEUGH2gTrWJ8cvMs90O+mL0OgFhQiJgqFL2LrURjxYV4vmv4oVU9zbRzLXZbG/9OH1ujAnr7k7zQfLfMp3DB8d89hLJpqEUv7MrlSUORHvXBzJBHi7msTF6MGiSCfRYZ0sIXPtHYrSG2gMXczZ1DeuDR/+TbDeasr4m7sa6jXmA7eGDm8AkfnXT+IJEShOiHL0HSMSiWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0vTH6rb0EB9zrHR4zVFG2bV5NIrfXaLnRVg6+PvjkI=;
 b=lsHGaCOXoXgH08IQ6uG2IvvpgQW08Hkv78md2QXA4K+t56yA6NYToXc6EKoq49mvt/BM7g/T2qMjHPc3Qv/SflOCxbnrGWpTNDm9mRqglATejV8waX/FZ1QBKNfcsVE/fa7RI79yQnw2hMd97TOTowjNgX4IP3oh0c0TlWEn3zGjwiXq/cA/Qm68BegUDTCClQNfLilLd6vDsxQj0aozyKYjaPghgS3UxOAQty4oI3wBzhlHwu3U6v1TiHEbYrK0c7sEbBRoD5IpAzSpBsELskayYJK1b5rXHhxPmb09/OGwOQ/wC4+9Je/qvwskgwzodl0TrgG3LgxOp07C/IAJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com (2603:1096:300:7b::17)
 by PUZPR03MB6019.apcprd03.prod.outlook.com (2603:1096:301:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 03:04:17 +0000
Received: from PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909]) by PS1PR03MB5034.apcprd03.prod.outlook.com
 ([fe80::c56f:c862:ff8e:909%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 03:04:17 +0000
Message-ID: <ee10bdeb-416c-70f0-d323-7107fe0746e8@amlogic.com>
Date:   Wed, 19 Apr 2023 11:05:30 +0800
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
 <780c0cae-18b6-2652-1c2c-6d398ea60451@amlogic.com>
 <e7c49f2d-b3c1-8d9b-76fe-c8759b37c7c7@sberdevices.ru>
 <20230418152505.72fc16da@xps-13>
 <15a6e415-1489-a81f-fc8f-2372678ad2cb@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <15a6e415-1489-a81f-fc8f-2372678ad2cb@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To PS1PR03MB5034.apcprd03.prod.outlook.com
 (2603:1096:300:7b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB5034:EE_|PUZPR03MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 880b3c79-6fab-401f-0521-08db4082c2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjQ8H9pDV318RyK6UiQYXS90mz4dNAa3ohiWmGgBfy5+XbCUMce8gXMzIyh2zgIvBneaLazIaxjcK6bxlmkADCU6rHmgcDhaKwxh3Izv3x1Xk2K9m3cNRJM4aN+83saXYDH3BHb5siUQvdvdyBbmlw0JwXdgFt7oaEhfmBHVOS4/m6XCyCGtvuz3JexMZ2Nv6I0zllffQOrv5nPt0Oqq8IaI1iuzqSoT2oNsd1OytcxnKTqcxySn5v8PZ7kdrOoLEoB0eAphhDDooMjGOUHt2O+T873c++Bd3gkKq54poGSF50HHsirarug91UN+IDkQNdQ/aAMCP+251th6wMuTCbGf3v/bRHpuonywyDZEPPP1ztAhb4UbeE4Ve2uiaC5bw1/2w+/MmOQR1ygP9GMFQfAho+4r8/jTvKjnzcIpWQ+YY0785NT2fAcvnDXAWfYMTDPwobhfYaF/deJNFGJ9eV0bsyN+QiZzjUg0AorXrut+SBYdzWrk+CvWRKRcArjp65RKzTXe0axzKQtu6E4mG8+MvB2tVPf/xNslJ9khacztvpeS2woRIfNETi9FrzLrxl6Q5wTVlAS+OiF99j7HNUGTacRImIFvd9Z8+Vm6EovS6lR/DAbH7xxw+AzBOnm0pGN0ITDsqGwQ6Mml+8y7D1xSeypjktPtzRKc7VXU97a5a8yKdFNYe/GrX6YBxqlEQqKfMcNL58CAyXAtPrHSg9nDZtWNd0JZA45BiDuSWx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB5034.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39850400004)(366004)(451199021)(36756003)(4326008)(54906003)(110136005)(316002)(66946007)(66556008)(66476007)(53546011)(52116002)(6486002)(41300700001)(478600001)(6666004)(5660300002)(8936002)(8676002)(2906002)(7416002)(44832011)(86362001)(31696002)(38100700002)(2616005)(38350700002)(107886003)(6506007)(26005)(66574015)(83380400001)(186003)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlWOUViVnZxRDFZSytnT3loZEZESWRtMUlOUms2SnJBOUpGZ09OQ0h6SmJo?=
 =?utf-8?B?YmswL09FZkhxaWJzK1RKSHhiY3VzOGpVaU1BMVQ2U3d5d1g1STc0RXdnZDZr?=
 =?utf-8?B?MENQR05hWnFxRGhhWHJOVUpjVkpPK3JBWlNQaFpheExKVnZrUnIvbCttT2NE?=
 =?utf-8?B?aXRDV1hFMW0veVpIM1poaU9lZUxCM2pyRy8zSlZndzRYTzBXMWRxdzVBc0Qw?=
 =?utf-8?B?LytRcHpOYkljYmxJcnVKSzZoeFBVN3FiNDh5cWFOaDhUclJ5Q2tDV1JIeWQw?=
 =?utf-8?B?UEVUYkJuR2cvR0RxUDNnZFpVeUw1M1Q5QXBjTUMyMEZ6eDRtNEtiMzNLZVNt?=
 =?utf-8?B?MEduYWxPZUFTV2VUYXVhZXFGTVRKQytVTVVnR1QwaS9UZElIbklXMUY3dEdz?=
 =?utf-8?B?MXV4dlFWVmpKQlU5cVUrdVNmRHY0TGl1TEpGdkpJWE9OQlBTajM1VUo5WHAx?=
 =?utf-8?B?d2xxVy9YaU1tRlk1eUtNSDFCcWJzcW5PUjFSUnI2K2hwa0F3OUlaR2lWaHhV?=
 =?utf-8?B?MU8xak5qZUFQODlycUdQaGtTcEFSM01MRzRrdFRESkNGSlhiR1RZNUx0aTVL?=
 =?utf-8?B?TEtDZURzWUkyVlBETmNncWtHSWhYVUhZNU1zWVkrUE9BNVRNZlJkR0xUUDg5?=
 =?utf-8?B?Tk9kR2c1ellDYUo1MlhCTWxodmdXeHRsc2txUFRabk5hMGp4MXg0YVdra0cz?=
 =?utf-8?B?SEVJTDhSU2w4ZnRUQXJPM2grZldIQnN4b0szMGtZZXhqcG53WHZZMVE4ZElr?=
 =?utf-8?B?enQrd2dOWXBzaTh3TVpJNG5wK2hKMnM2d2szbCtNVGU0aGFSNkFZTUpVc0cy?=
 =?utf-8?B?TDA5OE92TjE3RjVGZzVEby96bXNaS1pmUGsvaFZ5cnJnOCtDMU5IY01DblFX?=
 =?utf-8?B?YXl1dFZmRDZLa1BNcUdvSFFXTi81TnQ2NWpoRFRBSDE0MnNjai9mQThzUCt0?=
 =?utf-8?B?akxBWDMvTG0zRndkaWozWCtVelRLc3ZNaFludUJHMkpIY0tSRnVmdG1ZSHhr?=
 =?utf-8?B?SFBnR1U5bEhZTHNqbnJWcHVKRE1qTzJmYytRNEVzWlFrUndFYThQTjVMUEx5?=
 =?utf-8?B?R05hK2xWaEVLQ0FXSTk4ME8rUnFzcytHZGFBR1llcUcrR2pxSlFXVHFGS3VC?=
 =?utf-8?B?aEFjQXJLdUxxZkFLVmJtazBMWDFGRmNvR2Zvb1RxNk1Fdlo5a01JZEtmOUZk?=
 =?utf-8?B?TDhQWW9ZZ0xZdEpzMDJJYTZJQmowWUhFY29Ia2kwWk9GZXFCbTlENHJONnU5?=
 =?utf-8?B?VFFybmk4VWhnN2hCbW5ZUmlQaGZldGxjSXJPMjA1RkZSTkR2OTY1MkNYV1Zm?=
 =?utf-8?B?ZUZoOUtIWk5CSDZBdlQyS1FXZXFXQ2R6alZjZERwUHV3ajlFQ2lndnIrVDV3?=
 =?utf-8?B?K2FSV0V3MCtlZ2gyZjMxb1JMYlplaHFsQTMwenlBdVJ6eE9JMkUrb21rbTJ2?=
 =?utf-8?B?N3FYZWJpcStMLzFoYUEwYXFwNXZQZVB3VFZCS0g2N2VjRnhmeTY5Z3drREY4?=
 =?utf-8?B?Nm5KaHpjWmREMHNjc1d4bXV6Y1dqWnd5Q21DR2lZZFd3R1VGOUYvZUlqOFF0?=
 =?utf-8?B?WnNmOVFZY3d1VUR1bWZZdHgyOGNBYzlSNHV5V2RuMmlkOWdtdVlCMjYwSi9J?=
 =?utf-8?B?VmxTclQwK2JuOFVhR2VjRUVtL3IrSlpUUEs3NFlSOWpxdlU2bXZOQy96MUNG?=
 =?utf-8?B?SjN6czdwWjZKcVAzQkZROGFmR1RadG0xUktPMnVmNU10NnlRUXpsamx1K2Fy?=
 =?utf-8?B?Tnh5S21PelB3aXlyMytSODROU2xManhnbVRUVzlva2VzVEtjUnNtQnYwNGFv?=
 =?utf-8?B?dHlxdUIwRGJhcGxpdzQvU1BOSmZ6Sjl0bGNaa1lCVlZZWWxGVGphc1VnQ3BS?=
 =?utf-8?B?K2hrb0lvV29ISFRlT1JDeU9XYUkvT3ljSkdCS21hdk5ZeC9WMXBLTUxkSlJk?=
 =?utf-8?B?RGh0bVFIZ0ZSSDhvbTRUcmlBeTRtVERpNGNmWXNMNHVmOFFmTUZzTFRFV2FO?=
 =?utf-8?B?a1MwYWFLd2g0UUdnNlNlWlhhRnFxWlBFenZxV0tBY2tYZTJyY3U0Y244czl2?=
 =?utf-8?B?dENiaE0yZlRETHlRYlJxbVVWZi9XNVVJNVliaWFOU0xGVDc0RTJMYTFVRWVE?=
 =?utf-8?B?UXhWZHdPL0UxRm5xd3VHTFNYYklKQTBvMlMzMlNhczNuNk9WUUxaVGtGNVlz?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880b3c79-6fab-401f-0521-08db4082c2cc
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB5034.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:04:16.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWgRy43WRLiokw1RYrSbkC0vEAeXRs8cWBxWMVWZ8r2Va3cL6bFlsZ5XTV6E5UkN/PKOG4y7Rk3/dbxH4mwXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6019
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/4/18 22:57, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> 
> On 18.04.2023 16:25, Miquel Raynal wrote:
>> Hi Arseniy,
>>
>>>>> Hello again @Liang @Miquel!
>>>>>
>>>>> One more question about OOB access, as I can see current driver uses the following
>>>>> callbacks:
>>>>>
>>>>>      nand->ecc.write_oob_raw = nand_write_oob_std;
>>>>>      nand->ecc.write_oob = nand_write_oob_std;
>>>>>
>>>>>
>>>>> Function 'nand_write_oob_std()' writes data to the end of the page. But as I
>>>>> can see by dumping 'data_buf' during read, physical layout of each page is the
>>>>> following (1KB ECC):
>>>>>
>>>>> 0x000: [         1 KB of data        ]
>>>>> 0x400: [ 2B user data] [ 14B ECC code]
>>>>> 0x410: [         1 KB of data        ]    (A)
>>>>> 0x810: [ 2B user data] [ 14B ECC code]
>>>>> 0x820: [        32B unused           ]
>>>>>
>>>>>
>>>>>
>>>>> So, after 'nand_write_oob_std()' (let data be sequence from [0x0 ... 0x3f]),
>>>>> page will look like this:
>>>>>
>>>>> 0x000: [             0xFF            ]
>>>>> 0x400: [           ........          ]
>>>>> 0x7f0: [             0xFF            ]
>>>>> 0x800: [ 00 .......................  ]
>>>>> 0x830: [ ........................ 3f ]
>>>>>
>>>>> Here we have two problems:
>>>>> 1) Attempt to display raw data by 'nanddump' utility produces a little bit
>>>>>      invalid output, as driver relies on layout (A) from above. E.g. OOB data
>>>>>      is at 0x400 and 0x810. Here is an example (attempt to write 0x11 0x22 0x33 0x44):
>>>>>
>>>>> 0x000007f0: 11 22 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |."..............|
>>>>>     OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>>>>>     OOB Data: 33 44 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |3D..............|
>>>>>     OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>>>>>     OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>>>>>   
>>>> Hi Arseniy,
>>>>
>>>> I realized the write_oob_raw() and write_oob() are wrong in meson_nand.c. I suggest both of them should be reworked and follow the format of meson nand controller. i.e. firstly format the data in Layout (A) and then write. reading is firstly reading the data of layout (A) and then compost the layout (B).
>>>
>>> IIUC after such writing only OOB (e.g. user bytes) according layout (A), hw will also write ECC codes, so
>>> it will be impossible to write data to this page later, because we cannot update ECC codes properly for the newly
>>> written data (we can't update bits from 0 to 1).
>>>
>>>>
>>>>    
>>>>>
>>>>> 2) Attempt to read data in ECC mode will fail, because IIUC page is in dirty
>>>>>      state (I mean was written at least once) and NAND controller tries to use
>>>>>      ECC codes at 0x400 and 0x810, which are obviously broken in this case. Thus
>>>>
>>>> As i said above, write_oob_raw() and write_oob() should be reworked.
>>>> i don't know what do you mean page was written at least once. anyway the page should be written once, even just write_oob_raw().
>>>
>>> Sorry, You mean that after OOB write, we cannot write to the data area (e.g. 0x0 .. 0x810) until page will be erased? For example
>>> JFFS2 writes to OOB own markers, then it tries to write to the data area of such page.
> 
> @Liang, I'll describe current test case in details:
> 1) I have erased page, I can read it in  both raw and ecc modes - no problem (it is full of 0xFF).
> 2) I (JFFS2 for example) want to write only OOB - let it be clean markers.
> 3) I use raw write to the needed page (please correct me if i'm wrong). Four bytes
>     at 0x400 and 0x810 are updated. All other bytes still 0xff.
> 4) Now, when i'm trying to read this page in ECC mode, I get ECC errors: IIUC this
>     happens because from controller point of view ECC codes are invalid for current
>     data (all ECCs are 0xff). Is this behaviour is ok?

Yes, it is exactly reported ECC errors.

> 5) Ok, don't care on these ECC errors, let's go further.
> 6) I'm going to write same page in ECC mode - how to do it correctly? There is already
>     4 OOB bytes, considered to be covered by ECC (but in fact now - ECC area is FFed).

If step 4 has excuted "program" command at the page 
(nand_write_oob_std() does), it can't be written again before erasing 
the page(block). so we have to read the whole page in the ddr and change 
the content, erase block, write it again.

I don't think Jffs2 has the same steps (1-6) as you said above. are you 
sure that happes on Jffs2 or just an example?

> 
> That's why I asked Your opinion about moving OOB data to nonprotected by ECC area (and
> leave user's bytes untouched). In this case OOB access is free and not linked with ECC
> codes which also covers data.
> 
> Thanks, Arseniy
>     
> 
>>
>> A page is written after two steps:
>> - loading the data into the NAND chip cache (that's when you use the
>>    bus)
>> - programming the NAND array with the data loaded in cache (that's when
>>    you wait)
>>
>> In theory it does not matter where you write in the cache, it's regular
>> DRAM, you can make random writes there with the appropriate NAND
>> commands. Of course when using embedded hardware ECC engines, the
>> controllers usually expect to be fed in a certain way in order to
>> produce the ECC bytes and put them at the right location in cache.
>>
>> And then, when you actually send the "program" command, the NAND cells
>> actually get programmed based on what has been loaded in cache.
> 
> Thanks for this details! Very interesting!
> 
> 
>>
>> Thanks,
>> Miquèl
> 
