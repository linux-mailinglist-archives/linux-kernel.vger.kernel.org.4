Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085B6F665C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEDHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:55:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F0E30E7;
        Thu,  4 May 2023 00:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6AQjt1GF6rT6NY6zTyugv8dtDvb+6dotfFgvMv5R6os2puyXBxucJjCmkICku5e2Fi+dOqszl1cqiezXdrUpyrapKJQHAnPcejRaeGS90e8Ugy/UeZWeLIS/xqXX+iYuhf3bP2XiGmnmH0a+aEmQXs9YepKxyKkqyke4qBKXkbQcknxQEWILLNv9PRTDcP7/nA4YGwFdIxDsfiISjvX5eSVhVUUH4TVhjX0iSkHcl4N66b07RizM3LTy8E8aW8wvRlDLZ+z/BbcFvTe4DTf/0ethivoLaDrweN2bil8AyPx+6g2K1O213/9HvDkTuyx1AHpufuthMjWl8Q98QhFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNwuknCgwZuXwqrRuB54/WdLkeipg50hr3cUdVFbQHk=;
 b=WNrNrH3qaPxR8nGkPfA9eBreHPKLDFQttACqBgMfYZ9A5Lg2DKGaRLQ20DgpSD3WpVfknKlSsToagInVRP7TDcEcyWFqcBjKjooYpMhblPHOwjHrIQUCBEK3n7Vi/oi5tchj9sLDSbflZhNKiuIVgGlouXNSWkScZQLlacSRsG37ga+1hYpz9LoV375ZkAw+68O1U/vBKXDUXC7B/XURBnbsNNwVsw5R89DNHDT3hQa9a9GWEBhfOhrhAQqR03GZKqlpRekvbbkK1kRE1J+HHZZuUZzoFmV5NrV63MJuxfRn1LKsn4nQ53VKYlMSXVzdHsWV6z13FM4nKC/B7af12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNwuknCgwZuXwqrRuB54/WdLkeipg50hr3cUdVFbQHk=;
 b=5so/g5/dpbLDsOASwul6XryG3QOMaQgwsPFRjpf5Om2jd/4C8HTLuiGaqnlu7MfD5JpbDV5rx/8G8O5J/kEUInso7J78HDIYQyoj3bVc7URZ4uJcbC0TQEW5jdqYaoqjx4VMKptFZ4QAz1gmqq02CJ+bkowPpZNoGYDPgiiQpxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Thu, 4 May
 2023 07:55:22 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 07:55:22 +0000
Message-ID: <66c1efb3-32c1-b751-0faf-1fd6814bf05c@amd.com>
Date:   Thu, 4 May 2023 09:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org, Marek Vasut <marex@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <cca068980ae0b902168a9a9b78cab4efb43157a8.1683121150.git.michal.simek@amd.com>
 <4aa7adbf-f89e-6819-64d2-5942a456528a@linaro.org>
 <eb325b2a-d265-d8bb-8e98-9eef8f03355a@amd.com>
 <d5763073-3aaa-8a7f-1336-337c125b1a0e@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] dt-bindings: usb: Add binding for Microchip usb5744 hub
 controller
In-Reply-To: <d5763073-3aaa-8a7f-1336-337c125b1a0e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c23545c-7dcf-490b-6b43-08db4c74e9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAoalg2fdSFqmgmvnMTVmMb7EPnuEVBKPEnzewK8KzIz/rGA1lxgPnuBtkX+cjVQATcOzhvfyMASyO2EsJmsIDXnm2wPVe7D2mbkDWEY1Ih6pXHcKHmU/8SYNqM+BszqC4q4KwBoRF95NmLfRQoKggRGoDwwmj4S906Lrg/56hNwsFoT58hN56N68tZuFWhUuj6xkvhsW4GfaJ5WvD9oqDR9IMZaE+ZE49nZIOYnt1d9z+wkR2WHIZPwn+E1q4j/8jyN+YTnxv2MNXrCb12qUG+8B7aNRKyWNhJVGNchtnkUbZ1wd/XmvHSMnonzZkOTkZc73bplUeoS64hSe1mb0yZyLzanz7OmtIP4y/oduoWZdxRYSKIiio1U7wxEGfvPoOEVzpqd9f2wPFytk8oNoA/pL1gCCmrhH3+jDe7l4aghoKg36l9jF/TtkhWPtcaHdrbnM4nCKFaPlgIbALSZv8RaA5MDLoZTbZofApvNITSKIsuhsZCvjPNdCw0jTdB6HlL2+QIWZU9Z2nyG86Ks9eavlF4C50XEXYYk7kAJ3b2hqVZmZx65IzxKgkS8fX4kLdY3RwdCfuq/jwSwpHLM3Lj3nyIUl891xLfBowWlIZ7kb2A6bb/3LyyiAMcEimF3qz1LvWToEeNUEyirLqirwmHoUNiwAqYY0ONytPO8V+UTnlQgD80RdGEG0wdEOpD8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(86362001)(36756003)(31696002)(38100700002)(66946007)(5660300002)(66556008)(41300700001)(7416002)(4326008)(66476007)(316002)(44832011)(8936002)(8676002)(2906002)(2616005)(6486002)(6506007)(186003)(966005)(110136005)(478600001)(6666004)(26005)(6512007)(53546011)(54906003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZYRTVoNjBQVjJsRFJ0RkhmRG9mU3FqSEFPd1NtNk9WQWw3ZmpqUWZoY1Fi?=
 =?utf-8?B?c2daS05UYXViZGN3bXV5bnJOWWhpb3BvWDVrRkVGaEJiZVVDdHBiV1ozTHRR?=
 =?utf-8?B?SFVGeE5wZDZha2xpK2JQb2NsTHVXVlIvV29ZQ0ZVT3duTmo0cUZ2eGhpV0hz?=
 =?utf-8?B?dkhEVURlZVFvcmZyY3l1YWRqamlHRVE3KzFMOGRzNFBnN2dMNWd5Yzk3ZHZJ?=
 =?utf-8?B?cklVM3Y5VXlvbnk4Y3pXcE1oSHB4bHlrK3BZVTJzTUwxNVZJT21OTnpzekRt?=
 =?utf-8?B?ZEVHQWNXTHRFc3VPWTBMTm1pY2VKVmtyUk9LZDI4SGtmTTRhaGZ3RnVub3hU?=
 =?utf-8?B?NENlYmlzMGRxeHRNNnJFNXltNlRuZ2RTQWtNTzhIY1VyQ2NYSGJsN01sK2RW?=
 =?utf-8?B?TmVHdmlRSHVXZzhFdjZqcTUvYnFmNndLdlFHVkgvV1B3OVJ5T2VwaGhRei8r?=
 =?utf-8?B?NXdsd3c5RC9EbFp6NEhobTg2ZEgvNGUxR1FHUjJoMWozbVlsNC82UCt1Y2NV?=
 =?utf-8?B?dnVVU3Bld2FWRHlrcDkzaEhSUVMwc09ZR0NOS1k4MUtnSkNOS1BUWnVyMENF?=
 =?utf-8?B?N3RNRUdyTGFzWmQ1QkxZbUtDbGNRTXB2bmc1YTJnTTN1K3B2T3Evejg0VE9Y?=
 =?utf-8?B?VnJRTC9hOUlLNmlhdjdrWlVmcHhuNGdFSzZOMWxUeGJSbFpUanhacW1TK244?=
 =?utf-8?B?TlMwSzJLOUEyQVd4MW5oMFBpUE1jc1FIODBlSXBHeWgzbVJjemNoYUJib2s3?=
 =?utf-8?B?OGFCNHI0WndncVVLYmpsbnduNDR5TnZ5dEs5TzBIM2QzVDlCMU9yQzMrVmtx?=
 =?utf-8?B?RWM5Yk94MXQvWXNYdmx4ZWpia0RXbG45a1UvVUJ1MjFZd3JURitPdWU5VFNV?=
 =?utf-8?B?akVONGVSV2JicmYyV296aGcwbGpUZ2x2WGw4ZnpjSTBJVEVwT2Y5bDBPdUpK?=
 =?utf-8?B?c1NudFdkZndOWEZjMVZ0SlgyN2FPSkFBUGN3QmZ0dUhlanFaeG0rMFlvQS9B?=
 =?utf-8?B?NXczcnFaOGxXUytQU2o2UVI3Rml3U3NFWFpXQVNEVDZwOXBITjhYaFBTVkNB?=
 =?utf-8?B?c05EOG9CbENVL2JDS2xQTmpZV3Y1bGgyay96V2ZqWjJPVE5iYjF0ZGZ0OXRV?=
 =?utf-8?B?dlc1dzQyeVlpd1VzUmVuRnBVbldXV1BvdVNNc3N3ODJlMTVLMHJmWEdCcHNs?=
 =?utf-8?B?REdxYWZRVDlaR3pHMEVua29TeUhMYUh6Y0Z1VmhnQ012M1dzcXRqQUZMZUZs?=
 =?utf-8?B?RFM1Q1JmRmtPakRyekFyODY2bGFmVy9DcC9ib0c3MThJLzhJOUR1YXh0S3Jk?=
 =?utf-8?B?bE44MWhhRVRySHNIOGxJOStveCtSKzBVU0xINU9Sdlc3QjY5STk0K0h1b0xG?=
 =?utf-8?B?WkZ6WmJwMG9KcVNORWhwVWZ6c3RLeUVNYzhSZlBwUy9CNndjdHQ2T1dmQmJs?=
 =?utf-8?B?c1JBZGxtQUxRdThOU2pBR0w4MGhpOElRR0tHMTFzYVZ6dVdhQVdSN0k4TDRN?=
 =?utf-8?B?bGQ5YUplTE5HenFmRExrcGxoTklITEFSRkR6NVNaSTYxUVIremFaSkJOVUhG?=
 =?utf-8?B?MThTS0wrRmFQMlR6Rm1pbzJmR1RGMTVna2R1d2FrOVBPRHpLblB5bkp5cmp2?=
 =?utf-8?B?eXpUV3hyeDgzKzJzbWFweWlmVkFFZ2hHT0l3RkRLQllWTGZiUEJMYUVUQkE1?=
 =?utf-8?B?ZDQwU3BTZTdkWFgvRDRybURhQ1FiaGRZNFBHSGQrUEpSUEVSNDNXWnBBS0dL?=
 =?utf-8?B?NkhPQWZpM1ZsYmExbjQyYmtqOFpvZDBUTHZNMXhJOGlVTi9wSlVnTjhTQmlT?=
 =?utf-8?B?emJxYzM4VUtrVGVlMTVtMnhVdmc3dGtGRWRsZGl0U1llT1hOMy83OTVoRFV4?=
 =?utf-8?B?ZzhqeFh4WngrOGhCcHZjVGNzdG16dWFBMW1xRlg3QWdxcjZMVTFUUmxLUDB5?=
 =?utf-8?B?cHFpWDdRMzR6TDdnTnNKUWJzSE9yMmpwQjVLUzRRVVlCV0t4eFQwOVJPY3pF?=
 =?utf-8?B?V2tzdTRqRDdtK2RPWDNkSXc5djdNQ1NuUjVSSzd5Q2NLTkJzMk5aekpMbEdO?=
 =?utf-8?B?SUlva1F5Zm9LaUlWMjFwTGtZemg3WW8xQ2R5cisyQkxZeU81cU5PNW1uemls?=
 =?utf-8?Q?3eSrXrtX5XPyJih0IhMLc9qCg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c23545c-7dcf-490b-6b43-08db4c74e9cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 07:55:22.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKakvOiMyiTEtmMAFRBuETxYulS9Sx26D7Eh9/3ZQWzTEv4ZTtvwKR/pyu1i6N1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/23 09:31, Krzysztof Kozlowski wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On 04/05/2023 09:25, Michal Simek wrote:
>>
>>
>> On 5/4/23 08:46, Krzysztof Kozlowski wrote:
>>> On 03/05/2023 15:39, Michal Simek wrote:
>>>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>>>> The binding describes USB related aspects of the USB5744 hub, it as
>>>> well cover the option of connecting the controller as an i2c slave.
>>>> When i2c interface is connected hub needs to be initialized first.
>>>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>>>> idea because address can be shifted by i2c address translator in the
>>>> middle.
>>>>
>>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>> It looks like that usb8041 has also an optional i2c interface which is not
>>>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>>>> Add binding for TI USB8041 hub controller").
>>>>
>>>> i2c-bus name property was suggested by Rob at
>>>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>>>> and
>>>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>>>
>>>> the question is if adding address like this is acceptable.
>>>> But it must be specified.
>>>
>>> Why? phandle points it explicitly.
>>
>> Ok it means just list usb hub on i2c with label and point to it. Works for me.
> 
> Right. I missed you want the address of the hub but phandle goes to the
> bus. I think listing it on I2C bus (see
> arch/arm/boot/dts/vf610-zii-scu4-aib.dts) should work. I think we can
> have I2C devices without compatibles.

Device is definitely on i2c bus. But the problem with phande to bus is that 
there could more the same usb hubs and different i2c addresses of it. That's why 
I need to have exact match.
Marek has similar hub where i2c address can be strapped too.

> The problem is that property should have only one definition/type and
> i2c-bus is already used in other cases as just "phandle". If we go with
> your phandle+address approach, then this should be phandle-array with
> items and then we have two different types.

What to do with it then?

Thanks,
Michal
