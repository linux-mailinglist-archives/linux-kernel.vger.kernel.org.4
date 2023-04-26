Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A96EF5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbjDZNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjDZNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:53:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E30527C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipkFZyqdG3+Xn+Fk3Pj/E6430In5yjR3pFEWxXte/C3FO43GGfiGcNs0FuceN2OgbIw7EqK19lx7JMiU1DaljLA9evgMjD1KC5nSlpxq83aNYgZQSPWqlrJPCu0UqWcD8tAjX7SvknvQbHawKtFjDy24C/RgrMOwWTjvKjpv/Gzhxvg6g4tU1K1Pqt3mzTC0aM/w1JFilS5nVy9voZz/ranjG+m5TWoejkBIeJC/TNDmjuNyWvJXHLbuip08nuWvpTa4XDKPAcvU9EAXVANeQEyu3MySl9VRKic0yyKHkkSCS7Ku0Z2sPO82/3BNshdzP6VPhsa7EmP4fW0rDXcn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKRUORcCeOrcq9FVguYifAmOfZTC9j3nK2srGeQHp14=;
 b=M5FSlQp4P5//WcGnIjo2hGYy0no+3va3tm3272AjYrixk2hFgi5AtfFx9EduIXXcx/VFbjkOdZsVjzzv4D/I35xKy0N9ku20MthDTT9csvM2w2Gxf7QgtHqhOprA8lR0AYywIV84TMxJC3CAZhGlHhZDfxVnxN34C6Y+1vRlW2cmasd00va6XVZKQ5xXPjKdWzYaBABe0qITNqtLT4U9o9MsVbWgMFn5xrDiLsVZJE3mnlRvAX2E7NaIA0VmIMifBRDLL4E39C9prhxgKXO5PsoFcm6ZXse7qWqH2IUtcEdZv/3GgoGNAsD81fYQrwMevUDd4HiNbcEztWPy2Pz+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKRUORcCeOrcq9FVguYifAmOfZTC9j3nK2srGeQHp14=;
 b=qLa1G1tb9O40YkTF0Xx7p1uigD+R3QZmA42B6+LjUYRbxROwUQ5hfTP40+W9+rXJdvdIuJfdarmZ9+glpx3VTT0duUbVSha31uIO2nJxZdQiq7Ah7DiUXAqLZesrUQeSF3aOomb9mNU5mqMqF+dBvROQ2/jTM/vxGfdmr7AcL5IjLmMD5hyA47hQgEKqKBYo7US6qVMf5POg4BIC9Ea6ZHjScDKo3BS4M6rYVPdcRAcAsdVOXSnqcfQJkOP0kEpt6p3SmrRohZsr+nFgcIPAnoKFKSmUE3aNlukjMtI04o7ovvYTTrCeflXmfQCWoDCnPxFcrabU4D7EMikNV/ejcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB5040.apcprd03.prod.outlook.com (2603:1096:4:d5::21) by
 TYSPR03MB7581.apcprd03.prod.outlook.com (2603:1096:400:40e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Wed, 26 Apr 2023 13:52:17 +0000
Received: from SG2PR03MB5040.apcprd03.prod.outlook.com
 ([fe80::c90d:11f9:daff:dd4c]) by SG2PR03MB5040.apcprd03.prod.outlook.com
 ([fe80::c90d:11f9:daff:dd4c%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:52:14 +0000
Message-ID: <a5010dcf-a8ce-f144-949c-687548cefce7@amlogic.com>
Date:   Wed, 26 Apr 2023 21:51:33 +0800
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
 <ee10bdeb-416c-70f0-d323-7107fe0746e8@amlogic.com>
 <5e4b395e-bf9d-0123-a0f2-2b378d950b29@sberdevices.ru>
 <fda1ae91-4bf8-6945-bd0d-b6dabc9cb4bd@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <fda1ae91-4bf8-6945-bd0d-b6dabc9cb4bd@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To SG2PR03MB5040.apcprd03.prod.outlook.com
 (2603:1096:4:d5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB5040:EE_|TYSPR03MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 234555fb-878f-4ba7-a80a-08db465d5df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSMlJdq7GIR0uDD6q3XA2K+vrIsp/CZSoNucncZyZ5IlXVqDhulppvrnJ5RA095CpXL8qtmmuhMYt6P1MH86OC/71DTOCZh4x/IfV91ZVdua3aCaD7sFr4jx1nFTtyTxsoH7GY7nE729eJU5FLEqq0GoensMYLLna6jFiLwXak5cA1+fA1sq92VcMeal5mLe0UT6kZ6Y9UhVX25BA0HuzmTZa12fcfKqCdM5Bhd4yJ9imb2l+XeEa0ocoBLUWcGtJYWK8ze4nL2gzHxtxJ+tDLEdSuVp3RlrszWeAef7Td9xlz2DZMqeWkw1KKCz6GdZgMgZMg1xyqgrxLaOZBCdLb2E01OBwAVqeBzIpxh1/J6dA9XvK/zaflBNpK2u4Zqd04T290YPBvnkUBeWonzEw4A1n2rHhUMwsTCuwKnT7bxU1odPo6pfPgVzinSQlSxJHR+KhzC+sb+pwjFcV8Zq+UTGJ9jY1K8fYMUqLwuqFjtPfB0pj5UjBbMBUEtbgZUkz+NmUGEwsFd8qgmNYNaM4LiekJvL4hAdkrBU0c8mAIekyi2MSQN1j4VAlePwORyxnlcGuzFLxWdOEASh5pOQ7XxdWb45xtQimLdpcw0uIGv9IAT2fZautfDOwRHnc8asfVB4NV040e5WHZdQVRF4BeTlsSWIZjJ2WGP+h9tcnvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB5040.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(39850400004)(366004)(451199021)(2906002)(107886003)(53546011)(6506007)(6486002)(31696002)(86362001)(7416002)(52116002)(44832011)(966005)(2616005)(83380400001)(66574015)(38100700002)(38350700002)(26005)(6512007)(186003)(6666004)(4326008)(66946007)(110136005)(66556008)(66476007)(54906003)(31686004)(8936002)(478600001)(36756003)(5660300002)(8676002)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBERldnWi9SL0VqSmJwUUd1bUJFMHpwNStLRHZZWFJYUC9SZ29TeUhUNEM4?=
 =?utf-8?B?a1ZPa3c4TXhuWXRaa0JnOGwrMzRXbmxjamtib1FkN3FBRXFnMElCWVBIcjgr?=
 =?utf-8?B?MzBoNWtEbm5LNGFpVkpMdWlXS01ZVXZOMm9ucmxsb0pkUG96ckxQcWlrNXA4?=
 =?utf-8?B?UXo1cGpha3AzR2RqaWsrMjhvNFhPSW1QRG56L045VUxCblVuUkYvK0tMd21X?=
 =?utf-8?B?Zk5HN0xjRzNPRnV4ak5oVEtVdU9MVWhDZVREOEpmVkx1ZlVNME5kd3lreGRO?=
 =?utf-8?B?dzg5MU51TFF1aHVUbEh1SFpMb2F0Rk81VzRRVjRSbnhGQTdQd3J2VjhCT0hR?=
 =?utf-8?B?Lys1SU5KTU8ybDUrclZETy81YVN0eE9MQVdDNnNJOURnV0VqWllXb3JqMEpF?=
 =?utf-8?B?TjVQd2lkTitXV3NpOTIvTys5Rnp2V3h6L3dKOWk5NFhhOHlGUVJSWmJPMVh6?=
 =?utf-8?B?ZVVsbXpHL3c3cml4WEswU3kwZHJYV3k5TjltcHdJVDhuVENEd0g1d2RlUG9U?=
 =?utf-8?B?RUl6cmQvdGdNZ0xKb2dIWDQ4amRnanNCeW8vU05JQmdBZVBPWjJNZHlaRGlX?=
 =?utf-8?B?Rnl5UGhqMDJrcitpVVQyU0U0K3RWQ3VQWWZxLzkvK3lObmt4L3NZMmo1WFRZ?=
 =?utf-8?B?QkR2MExwMGhGdGRHSytUTkxuZHFUcGtjTTNJNXllQ2NlcjR4WnJCcC90bE90?=
 =?utf-8?B?eGF0QXpJdTZ4R3JWMFVHQlZIa1g5M0JjSHRhVWY3RVdBZDlidDJYeTJNYzMx?=
 =?utf-8?B?NStzTVpsMXRSQkdQamhqK0luUW5EM1ZONjVkbFczNE9nQUFFWllXRTQ0Q1JB?=
 =?utf-8?B?K1lLRUZWenNnbzYvL0ZYV21RYWdHclY2M0hBbWtSR1JoWk5kWFhMSDdoN291?=
 =?utf-8?B?YXNxWWIvSXYxTjh2VGtmeW1oalFzTm9qK0hvUHVDOXIxNEZMSDYwalB0MEl1?=
 =?utf-8?B?cDM0OU9aaWR1SHoxU1hmY2trY3labk8vUnFja2xYcHhjMDQ5NzZVV3A3MFhy?=
 =?utf-8?B?eFRUOTBGbklFVy9VemdvMjhzSEVBUENUS1g4ZGhoZHg4RFkza00reW9nbnBl?=
 =?utf-8?B?ME04Vm1hSG0veWxwdmUrWGtKb3htcjVDdWtKcFFNRlhEbkVmNGprRlVNeGRC?=
 =?utf-8?B?eUtiQ1d1TTgxVlhNZXdHMlJad1JrWEVXMEpKSnFpMzFnZ3BZbXRaLzd5bk1I?=
 =?utf-8?B?YlAxS25EVW02V1VidWJOSXJKMU9jQzlFbnNLbjRoSXdzenFuajFyajRoRFl6?=
 =?utf-8?B?blk5OVIybE9YUHhlaExwQTZOdEhURVhGSVV3ajY5QTRiYnN6VnB3aU9ReGIv?=
 =?utf-8?B?bTNWR2pFY1RRaFVaVmp6RG1PeTROYS9LdEx5T1g5aFhENlFIRHE2Vkp4R3Zi?=
 =?utf-8?B?WlVpZFZlZnBrYnlHWlJQSXRkT2NpMDVaaE1MQlVQUFlOeldtUE1rY1UzNSts?=
 =?utf-8?B?cCsrVXV4SEY4a2JxR0NHb1I5bENjSVNSeGlnenZ1ODVUbGVwaG9JOU1uZXBN?=
 =?utf-8?B?cytXNVFSekxiYXh0NytNcXJZQk9TKzlMckk2WFNxSlk5S2pNZXI5N1ljRmw0?=
 =?utf-8?B?a2RqdU8zZ1pyVitNS1N3cndsUlVYUWwrWVkvdWFVTkZKS2lYYUZ6QWJvUHhM?=
 =?utf-8?B?WDFqQU95aUdKeUNFK04zcWVCcWhXWjk5WGNZVXhKSzhXdGJTZC80UGM4Ry92?=
 =?utf-8?B?bDhRdG5rVnpXZC9yTGZCeXhEOGRnVE1HZ2M2a0RITlR2bzVtS2IwT3JjaGRY?=
 =?utf-8?B?NjdiRHVaZVoyVHRvUi9jVVIwWWFHOW9TNGYrSFR1UDZoLzRMVE9DbmQwdWYx?=
 =?utf-8?B?akNxMHUvVFpmcEJWQnBEVExsd050QjR2T2orN0RhUXI4cE1QY083UjdDb0JD?=
 =?utf-8?B?czIzMHJsZklMRjFkZW9DNjRMVXlvdHVrRE1Ec0t0amRvQzdnaUpMMnVMQW9a?=
 =?utf-8?B?bkYyRXFaNmg3SnJMRmpQeXB6SlU0TGV6OThMeW5ORUdteUI4QmVsZC9QcDVx?=
 =?utf-8?B?aTk2WUMwL3NXQUcvb3pPWXpvSkxvMzBKQ1VIKzh6RXBvZ3NrdW92WjRmU0hK?=
 =?utf-8?B?enBQS1RqVUpucktjL3Ftbm5XTDh0V3AvM0pqYnFyY0twZURodnNudTZiWnNq?=
 =?utf-8?Q?E+3+Mfv1O1KJ8ufPxk8Tw6Xia?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234555fb-878f-4ba7-a80a-08db465d5df8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5040.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 13:52:14.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6oxGNGkpnrjygbsUul8kwOpUD7SMMxDI3twOwUIMBJ+4kMPS0I8JVKvMCyfsjzsfKwjiNkEX5c9U4lz+6gdog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7581
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/4/20 17:37, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> On 19.04.2023 09:41, Arseniy Krasnov wrote:
>>
>>
>> On 19.04.2023 06:05, Liang Yang wrote:
>>> Hi Arseniy,
>>>
>>> On 2023/4/18 22:57, Arseniy Krasnov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>>
>>>>
>>>> On 18.04.2023 16:25, Miquel Raynal wrote:
>>>>> Hi Arseniy,
>>>>>
>>>>>>>> Hello again @Liang @Miquel!
>>>>>>>>
>>>>>>>> One more question about OOB access, as I can see current driver uses the following
>>>>>>>> callbacks:
>>>>>>>>
>>>>>>>>       nand->ecc.write_oob_raw = nand_write_oob_std;
>>>>>>>>       nand->ecc.write_oob = nand_write_oob_std;
>>>>>>>>
>>>>>>>>
>>>>>>>> Function 'nand_write_oob_std()' writes data to the end of the page. But as I
>>>>>>>> can see by dumping 'data_buf' during read, physical layout of each page is the
>>>>>>>> following (1KB ECC):
>>>>>>>>
>>>>>>>> 0x000: [         1 KB of data        ]
>>>>>>>> 0x400: [ 2B user data] [ 14B ECC code]
>>>>>>>> 0x410: [         1 KB of data        ]    (A)
>>>>>>>> 0x810: [ 2B user data] [ 14B ECC code]
>>>>>>>> 0x820: [        32B unused           ]
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> So, after 'nand_write_oob_std()' (let data be sequence from [0x0 ... 0x3f]),
>>>>>>>> page will look like this:
>>>>>>>>
>>>>>>>> 0x000: [             0xFF            ]
>>>>>>>> 0x400: [           ........          ]
>>>>>>>> 0x7f0: [             0xFF            ]
>>>>>>>> 0x800: [ 00 .......................  ]
>>>>>>>> 0x830: [ ........................ 3f ]
>>>>>>>>
>>>>>>>> Here we have two problems:
>>>>>>>> 1) Attempt to display raw data by 'nanddump' utility produces a little bit
>>>>>>>>       invalid output, as driver relies on layout (A) from above. E.g. OOB data
>>>>>>>>       is at 0x400 and 0x810. Here is an example (attempt to write 0x11 0x22 0x33 0x44):
>>>>>>>>
>>>>>>>> 0x000007f0: 11 22 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |."..............|
>>>>>>>>      OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>>>>>>>>      OOB Data: 33 44 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |3D..............|
>>>>>>>>      OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>>>>>>>>      OOB Data: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  |................|
>>>>>>>>
>>>>>>> Hi Arseniy,
>>>>>>>
>>>>>>> I realized the write_oob_raw() and write_oob() are wrong in meson_nand.c. I suggest both of them should be reworked and follow the format of meson nand controller. i.e. firstly format the data in Layout (A) and then write. reading is firstly reading the data of layout (A) and then compost the layout (B).
>>>>>>
>>>>>> IIUC after such writing only OOB (e.g. user bytes) according layout (A), hw will also write ECC codes, so
>>>>>> it will be impossible to write data to this page later, because we cannot update ECC codes properly for the newly
>>>>>> written data (we can't update bits from 0 to 1).
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> 2) Attempt to read data in ECC mode will fail, because IIUC page is in dirty
>>>>>>>>       state (I mean was written at least once) and NAND controller tries to use
>>>>>>>>       ECC codes at 0x400 and 0x810, which are obviously broken in this case. Thus
>>>>>>>
>>>>>>> As i said above, write_oob_raw() and write_oob() should be reworked.
>>>>>>> i don't know what do you mean page was written at least once. anyway the page should be written once, even just write_oob_raw().
>>>>>>
>>>>>> Sorry, You mean that after OOB write, we cannot write to the data area (e.g. 0x0 .. 0x810) until page will be erased? For example
>>>>>> JFFS2 writes to OOB own markers, then it tries to write to the data area of such page.
>>>>
>>>> @Liang, I'll describe current test case in details:
>>>> 1) I have erased page, I can read it in  both raw and ecc modes - no problem (it is full of 0xFF).
>>>> 2) I (JFFS2 for example) want to write only OOB - let it be clean markers.
>>>> 3) I use raw write to the needed page (please correct me if i'm wrong). Four bytes
>>>>      at 0x400 and 0x810 are updated. All other bytes still 0xff.
>>>> 4) Now, when i'm trying to read this page in ECC mode, I get ECC errors: IIUC this
>>>>      happens because from controller point of view ECC codes are invalid for current
>>>>      data (all ECCs are 0xff). Is this behaviour is ok?
>>>
>>> Yes, it is exactly reported ECC errors.
>>
>> I see, so if we write OOB (e.g. using raw mode), there is no way to read this page in ECC mode later? And the

Of course, there is no ECC parity bytes in it; or raw write the data 
with the ECC parity bytes per the layout (A) you describe above.

>> only way to make it readable is to write it in ECC mode, but before this write, we need to read it's
>> user's byte (from previous OOB write) in raw mode, put it to info buf (as user's bytes) and write this page. In this
>> case NAND controller will generate ECC codes including user's byte and page become readable in ECC mode
>> again.

yes, you are right.

>>
>>>
>>>> 5) Ok, don't care on these ECC errors, let's go further.
>>>> 6) I'm going to write same page in ECC mode - how to do it correctly? There is already
>>>>      4 OOB bytes, considered to be covered by ECC (but in fact now - ECC area is FFed).
>>>
>>> If step 4 has excuted "program" command at the page (nand_write_oob_std() does), it can't be written again before erasing the page(block). so we have to read the whole page in the ddr and change the content, erase block, write it again.
>>>
>>> I don't think Jffs2 has the same steps (1-6) as you said above. are you sure that happes on Jffs2 or just an example?
> 
> 
>>
>> I just checked JFFS2 mount/umount again, here is what i see:
>> 0) First attempt to mount JFFS2.
>> 1) It writes OOB to page N (i'm using raw write). It is cleanmarker value 0x85 0x19 0x03 0x20. Mount is done.
>> 2) Umount JFFS2. Done.
>> 3) Second attempt to mount JFFS2.
>> 4) It reads OOB from page N (i'm using raw read). Value is 0x85 0x19 0x03 0x20. Done.
>> 5) It reads page N in ECC mode, and i get:
>>      jffs2: mtd->read(0x100 bytes from N) returned ECC error
>> 6) Mount failed.
>>
>> We already had problem which looks like this on another device. Solution was to use OOB area which is
>> not covered by ECC for JFFS2 cleanmarkers.

ok, so there is not ECC parity bytes and mtd->read() returns ECC error.
does it have to use raw write/read on step 1) and 4)?

>>
>> Thanks, Arseniy
>>
> 
> @Liang,
> 
> Small addition, if i'm trying to implement OOB read/write in ECC mode, then step 5) will success,
> but later, JFFS2 tries to write this page (in ECC mode of course), and in this case ECC codes will
> be broken, because we can't update them properly without erasing whole page.
> 
> Please take a look at this patch from my colleagues:
> https://lore.kernel.org/all/20230329114240.378722-1-mmkurbanov@sberdevices.ru
> It is related with "We already had problem which looks like this on another device" from above:
> in 'f50l1g41lb_ooblayout_free()' we reserve 2 bytes in non-ECC area for bad block markers.

It is about the SPI NAND and use another controller called spifc.
but in meson nfc, it is heavily depended on the pre-created BBT in NAND 
device.


> 
> Thanks, Arseniy
> 
> 
>>>
>>>>
>>>> That's why I asked Your opinion about moving OOB data to nonprotected by ECC area (and
>>>> leave user's bytes untouched). In this case OOB access is free and not linked with ECC
>>>> codes which also covers data.
>>>>
>>>> Thanks, Arseniy
>>>>
>>>>>
>>>>> A page is written after two steps:
>>>>> - loading the data into the NAND chip cache (that's when you use the
>>>>>     bus)
>>>>> - programming the NAND array with the data loaded in cache (that's when
>>>>>     you wait)
>>>>>
>>>>> In theory it does not matter where you write in the cache, it's regular
>>>>> DRAM, you can make random writes there with the appropriate NAND
>>>>> commands. Of course when using embedded hardware ECC engines, the
>>>>> controllers usually expect to be fed in a certain way in order to
>>>>> produce the ECC bytes and put them at the right location in cache.
>>>>>
>>>>> And then, when you actually send the "program" command, the NAND cells
>>>>> actually get programmed based on what has been loaded in cache.
>>>>
>>>> Thanks for this details! Very interesting!
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Miquèl
>>>>
