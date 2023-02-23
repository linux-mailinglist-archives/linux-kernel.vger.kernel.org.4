Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF586A07E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjBWMCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjBWMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:02:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1D521F3;
        Thu, 23 Feb 2023 04:02:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNBaRhhHvDZtJp02qsXIc+JkDMik7L0z+8JuQv+S72dvjkr3OE4GdAOKKIpwjYPHvT4XmKpSk4HOFDsPndAqp1qwF5jbO0yKleyK0drnnuRrVKHo4D/ozxq6WhECQ2yOgPC+HNu3Cu4wB9gYeL6agBjjK4nNehv5+75QwWFTFSnTPr44SvlBUmwOs//qPAlc6ODJk5gGSv5b3tpIKqLlY+Ni4FEq6nqF8RX+9uqRy8feYC6cAMcc+egBwIPPhLNmdkPH0LlCA45BqzBAXIBdMbbMntYqsJdYz7Td5TuLV9d0pOJrXL5ZUVBn2lo2S2uxgbNkGxcyHxw1S8chsKZBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjoJ9HeHZ19pq2ZYarVRWy0rsBDz64pQhPcySVe1wDk=;
 b=IK40BOm0CM0Nv3ntviAnWVigkh0U2kQe7GEv4hss12r4WCziSUAwa03ua94n91ZigtK3XAD5FKcfBEDuzEOdR2Y27Ne0VYvSAJPs4iLv57U4LW/gg26c5rup1p9b3aQSsVpC6taUVwZ/g8b0xsLkoFur9g5ewrfdNUpTdZp43gA+Bona4TWwKZSxfGLIjiCJ8PsNhD7G+4iDf5ssB0NkdFqAFIsv7ef16ZpnUOFtMZxMXhXUuPm9K0bGZy4wZBntabdOHekFECmTIxN0hoyz2hzjEytuQokAIerUo9eesIniQ6sTSQjK1UiaT+w1t3IKxXks0W9pZZJJZiE7mapByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjoJ9HeHZ19pq2ZYarVRWy0rsBDz64pQhPcySVe1wDk=;
 b=TAX8HsyzZd3rkcq8FXBQuc9+Mbh8fDCtFFEiwKiNhpx04THpPqKcKU/wHPrvo30dgLyrvlVYZx9zcZRkS4sFaWOBVh98uAqwwFx3gbBLklQFt+0X9lrT26EoUPqFnIbG5HLalCc3IKp073T4ZauVuCa2Sfahv6Ok7p/lQk8WiBk7qTmetoNPoe09Wj0qMHB/4urKejDbRIlNJ4dEjp+8BHnn9ipLAc2HW98fu9A5oeslbWLJ44UQYsWgYBE4QFzicvbSnkH3g9RJTr6IOb+eE2Drtwb0D9OuwPd3YnbCs0Lfu6QqP4vGE4w/bU4uYjHy85juDFYlanD0ilRnjc0y3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM0PR04MB6945.eurprd04.prod.outlook.com (2603:10a6:208:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 12:01:57 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc%7]) with mapi id 15.20.6134.018; Thu, 23 Feb 2023
 12:01:57 +0000
Message-ID: <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
Date:   Thu, 23 Feb 2023 13:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Wu <michael@allwinnertech.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        richard.gong@amd.com
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y/dMq2KKYfdMdrjh@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM0PR04MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cd928d-662c-49e9-99d9-08db1595c2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDRF24e3ys4+kLEVDVC3iQncb2HogvneoqhM1l/5ToYo+umyp4CVl6NqfJGbEXnljFbemUpUE4tQXs1rTadYxUP+zMqTOf7689NYFIJ2USQcbHpspVOZlC+g4fgjMZDV7NsJO2boky/XpAJ+cMKoEF8c9iuQb4QvRILh3lPgqM6LOE8mtIeR39WGUEJzxI09Cu8QqoBAX26QxQwf4MfxKMcbFUak+l0RNgf0CwVebhT89hu+9XW+4Mzg1O/rksaGGx8QsJDTrcPJpt1kkHHgRQnUsiarcXHuwcpbwZhuNZKVdeWxOvF58w0w2ycUQbF0sXhPltmqVFUMDQAJ6iQFwWqtOUWZ6Yyen9MkqfrcLEre8M2QMTc0Xj6MxKmPtRNu7QOdzFKVCcKtrNPNRAaIG4UZOSsxwnA5xDj9LUGaYK6FdPY9etZMyXEQd622Da1Na42lCIuvZcCik40p/OlfOg9pxntk+WNB2SZrYwzmWjTp2xPB0J0QPNyFIXGXZCas7JSJIxsPNK+2sk3jpEN3QfZY4hdNncyvTj+tCjenHE379AII9pSWxproHG4q8zqZifY/wdK+BmpKJ+ePzH54oefwZfHg8u1pOOlmiZKZlRs19f386M9RiuUcTezyDEntSbbow9cm/WYqXJ1oupWtUYEx/zL3Rav8aIkQkYaLgxywJky9PWLeliSvcprwIzQWeTLD6gFAyUYsxK34yz8Jqjd24KwUVVQkck9Ww/7TUxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(31686004)(4326008)(36756003)(2616005)(53546011)(41300700001)(6512007)(186003)(66556008)(8676002)(66476007)(8936002)(66946007)(86362001)(31696002)(83380400001)(6506007)(5660300002)(6486002)(6666004)(110136005)(316002)(38100700002)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djV1RnQ2Q1FVdUp2L3FuaHc4cjVTbUxwYVQvSGkvcS9OUUwzZUN4TGhNamlN?=
 =?utf-8?B?TGpvQ0tua2ovMTZKTFBuVkRnOVVWMTVMemxJNVNKaEpCOWxIRS9jU1R2Y2Zn?=
 =?utf-8?B?eEg3UHU2UVdQeXoxbjR1aVpYNnJObmRMUkhGakN3OHBkdjNWSS8vcHF5Y3lX?=
 =?utf-8?B?YlRxOTdmeUZ1TGxuTmh3ZjRGOUtLS2RycHJkejVHQUR5TE83TWREN3Q0UjBV?=
 =?utf-8?B?cENKcUY3S1JsaStiR2ZNVWF1TE5iMEpaa1U2UFBVazJGaGZpaTM4UG9kN2ov?=
 =?utf-8?B?ZEpraUlOa283SS9RRzRqay9DK1dMcHBsSFowL3RPYysxQitOcllRMFMyQXFQ?=
 =?utf-8?B?NTFBaG1MdjIzSkxZeGxjRVFCdm8xL2kvNTg0b015NkE1Z0xiTUR2dUlqVUho?=
 =?utf-8?B?aGVGMVR1YjZpTXI4bG8razc2emRveFhYNDQrTzc4RHBLRm9CYjBrZXg1MDE3?=
 =?utf-8?B?Rm41WmZpdEdaMjB3TzNUZ3dkdmtrUHhMVnF6OXhlVzZMRkR4S2wxNnZMbUZS?=
 =?utf-8?B?K0d4TEQ4N1FLVGF2VE9VSUxyOThjT0c5WExQNFcxOThWdUE0WG9iTjdNRWhp?=
 =?utf-8?B?L2hqSU9PczV2b0wwNFY1YUZobG9LelBjWDBDcEhqdElqSWM2eGYyNDkrTHlC?=
 =?utf-8?B?Qmh2RWU3dndGQ01ZSG5BOEF4RmxTczhXNUJUUWhNMVYzSWE4bWJqQ3FUODAv?=
 =?utf-8?B?VUN1ZkRRd09BZ2dwd1BpdTlPVEhmUWxpb1JjbitSbjkvNURhcXA2MHRreGcw?=
 =?utf-8?B?Uy9MYkEzM0l3OEZLa1hGVnYzUzJDLzgxNzc4VktUV2J3MzZFNzVDdGlSUTh4?=
 =?utf-8?B?QWUxN2E4a0M5dEFTK2xmaXBZRGxTTk0zU3QxcnhwUCtFTVh1Z3VYUzV4SGFO?=
 =?utf-8?B?Ym14Rm9sN2Qwa3B3VVQzMUQyRlJnZS83ZzVGbkZZWHphZENvTjdaTUFaWDdG?=
 =?utf-8?B?UzBDQWs0TklEVXROSm5uVkdlVU1rL1lxVEl5ZTZlN0tuVkMvdS83YUFMTHlK?=
 =?utf-8?B?T3QvMnN2TXEwOGhKQjR1VDFRQkcvbm8zcEFKNDNWQXE3TXpUMVFTcXdyRk8r?=
 =?utf-8?B?U2VhWlkwcFZiOEROVU92eTNsTG5QQmJVaVgwaG5vQUVxak10ckdqRWRpeGFi?=
 =?utf-8?B?amVTaXRQYlc5S1R1TFlBZ3YvTmNOVE8zZXZjSG1DLzJVR2JTOGRkVGRvS1R4?=
 =?utf-8?B?cGlHMjh1MmFVM2p5M3pOSXFEbU9UUmlNUWVGRXN6QmVaZUc5UFRmVCtSdnlX?=
 =?utf-8?B?V3FuVnFHU210elZpaCtRS3VtN0F4RG5sS2thNUxDb2pFZU43R0s3Yzh4VHB5?=
 =?utf-8?B?eXdJYU5VZnZac3hDSlJTbTZ3L1JLYlJ2ZkdHNDdMWjhsOTd3OWJuZTdUQTZm?=
 =?utf-8?B?TjlreVREZnVrelFNeThwcTBaWFYzMHdDRUVRL1lNcGpxSnJWUUlFRU5NZjI1?=
 =?utf-8?B?UGhON0E5dVRHYjhtNTBVRzhpdCtMbTl5KzEyaG94THFGaHpNeGIyMkpSTDA1?=
 =?utf-8?B?cnhMYk9vNEZ1R0N5SWdZeHNiRzQvNXFTVmxMSklROVVTYVRBdGhDVFB1dE9N?=
 =?utf-8?B?bVBJYU9RRjNnaGowVSsyVVFiTEllblVVdnluWVJ5bldMdVZsdzdHbDFHamk5?=
 =?utf-8?B?NjNKc3JZTThQZHBOOVc0NTZPZUhtYm85cjk4M3dSclBhL0gzR2ZVdStlNElG?=
 =?utf-8?B?RE5MNFpPd0dUdk9lYWdOdmlUVUZmNCtaRndONEtzbHlCRGhFWC9Wak1Lb2gz?=
 =?utf-8?B?NlNxaDBoc0xCQTlObUUxSXVneDFxV0FzbkJNOUJqdnB4S0h0d01PV2ZuVDdx?=
 =?utf-8?B?UjhFUGNtamNTU01MWmdCRjB1Qk9GSlovQkJtTGJ0QkdsNDkzM0pOZmsvRzdt?=
 =?utf-8?B?WDJSVmJtNzBsekxUb1hpUUtiTU1sSGVQODVMV3A1MkpyTm5tV1FOaXBCZDVF?=
 =?utf-8?B?N01rTkJlajRGMzg5YmV5S3hjdjJWMmlQMHhhQmR0MDBoc2pVcDVSMGd2ZkhW?=
 =?utf-8?B?WnFqWW5QWS9KRzVTZlJ6MVpTQXpXR3k5QWVRTG8rWTVWSzgxU2t2WFZLWWdZ?=
 =?utf-8?B?VDdUenFpZjVhbUh5NU83NUpIZXZDVCtvQktNVTg0LzI1b1pxRjZWN2paSVlj?=
 =?utf-8?B?dXdJMHFSZkRiQlE3SFNVemhmdGl3a0FOaEVrcVpmQ0t1OTY1andnQWdCRW5k?=
 =?utf-8?Q?dvFx3CZ3m1IookmoGTO4x/2SNDDUsLzhC8VrYzFbp69G?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cd928d-662c-49e9-99d9-08db1595c2f9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 12:01:57.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUO7sYPs1Qre0hAh543GcRa4YRorDPbDEIs4A96zL6LS8Da5khFwcE02C84K8I62Imkg7onAmxZnKmQU/Q7Atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6945
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.23 12:23, Greg KH wrote:

>> I just want to explain the background of my patch, to prove we could use a
>> similar way to avoid such a "disturbing" situation.
>> To reduce the influence, my patch enables remote wakeup for USB mouse
>> devices refer to what keyboard do.
> 
> Keyboards are not mice :)
> 

OK, let me explain, why I never proposed switching on autosuspend
for mice or using them as a system wakeup source. The reasons are very
similar.

Basically the standard gives us no way to ask a device what constitutes
a wakeup event for it. We just get the blanket statement of support
or no support.

For runtime PM I would want my mouse to generate a remote wakeup
whenever a button is pressed or the mouse is moved. Under this
premise runtime PM with a mouse works wonderfully. Testing that,
however, is a challenge.
It turns out that mice that claim that they support remote wakeup
by and large deactivate their LED/laser when you send them into
suspension. Hence they react only to buttons being pressed or mouse
wheels moved.

As a system wakeup source a mouse that generates events when
it is moved, however, would make the system unsuspendable, whenever even
a bit of vibration is acting on the system.
And as S4 is used in many setups to prevent an uncontrolled shutdown
at low power, this must work.

I suspect that most, but _not_ _all_ mice, are designed for use
with a system that ties power management to the screen saver.
That is a mode of operation that due to the lack of coupling
between GUI and kernel is hard to copy.

Frankly given these constraints the only default safe in every
case seems to me to leave the kernel's default at off and
put the work into udev's hwdb. Not that that is a good solution,
merely the best I can come up with.

	Regards
		Oliver
