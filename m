Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3558E5BCC65
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiISNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiISNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:00:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CD24F36;
        Mon, 19 Sep 2022 06:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9D5veCAKJ6fTWh4QQBLCVZw6RCwfSKwvRz5pLmuiP+rZuDW/6+XTB3zhHyuNxmabbVzFh+2CwoN4PnlelFQGTiRN/z/+k1am/UC8YTchqr1A+VQ9rXO9+BZiQva35O7hzrf/PIDEZPYwDquR3we7sKQkxua/Dnl6x1WdSsk0OE6NnTOqo42NJ+6u4bfh1VCry+ym7AZxTxEJLG5whdLu06XmR17XOG9ACUMWsfwXbSKgu8U0kQQ950Hmp/urR273zO7OOFZvo2tjdmXPW0F6SYW2wAoWSee1DuphJtyDI/7JolNASACfpjAB1Fpg1xnS4CbL0YcYAB8SSmqKMjgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnL5shh8hbDQVaHULVhug5CGMONKp0qktdXagPYpCJQ=;
 b=gtvadUaIZmg6aoq6PASAfl9pzvqpT5OKZn3ks8GywnsuSqkohnQBglkumCp/wUJ2y8YgNjqEYHA+Qu95xnyVCDXKYNiBEaDerMJIcVcTw97eYGJxoBzjFMgzddiOOtM/cpiQM3TSUycyILR9TXWy5MeeodfIQsu0DE5G8dKF0V7mrWHM+ZwPRIYntacqD11Cea40htli+hxIFJFA71IYYoLaxNF+HnjIhVsqQNXvXQ9GfCE5EFRbTDnyuEcs65WKfFIBECsb6wBazhjpUUes0dKvFYKzsLy0mq15P8z18JztTt4HZJg6XnW+uKvOCFT8+Icg4IsOtdefcz/G6DJOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnL5shh8hbDQVaHULVhug5CGMONKp0qktdXagPYpCJQ=;
 b=X+vInlhqACpI+La8nrA02W5ZsPyy03JofdwlT61lurFw4hMeAv6bmBmJR2S1Y6/Ygsnb8GEl8nFEBhRUkKT//eE0mEas/NWd+b8Nf2saPityz/pPrhXbSzkWqupDBzz3LtKjwsMxulvSNyLQpa6zTQ/I2cA5bBm6fJMvrYQq4/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 19 Sep
 2022 13:00:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5632.017; Mon, 19 Sep 2022
 13:00:51 +0000
Message-ID: <750c9dbc-8d4a-f7cc-df66-adfbed4497ce@amd.com>
Date:   Mon, 19 Sep 2022 08:00:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>,
        Philipp Zabel <philipp.zabel@gmail.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <Yx9ItlBjl6bxxu2H@rog>
 <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Yx9K88pXilS6qqL9@rog>
 <b94e6fd33938877d5863c9444ca9c68c01417d8f.camel@ljones.dev>
 <d3dd18be-9c03-7c29-eb2e-d8d617994259@amd.com>
 <33aec4d4782cbd915cfba3f06f5c8993c3414e96.camel@ljones.dev>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <33aec4d4782cbd915cfba3f06f5c8993c3414e96.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 935e21fc-2878-4203-f32e-08da9a3efac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7Rr6tbiFyYh+gebM0wMHXWKGWNtelL1w4RBmGUSybNJIQPQh6z2JO8byvSD3krqqU32ewk/xNcwILNjKGpfOppFm/okBYQYZ1HLhdCcQjbJngusioHb+wt2DlpfHAbqygST45bcUB7VE9i7MnMp+67jvNL7hau/cxX97kwkqzztwLx9xOvhONqB98n8rTzx/Cl4+lwEdlVF7281tzNLRzodZfgs23rZzU7WDRNGW+FONO/EWngLktWg3gAWyV85nvlVhBFp4TQ9KhspQU5rOXASe/S50UNPArB+KKQv4sLNpuh39T4ojTc0ax7xuT7e4wvhJWo+xzXWaUNEd/6zAy9WdhsQGE9H7zwuenmfEtmjMD2rKu+qrdA+VDmZZ/huow42d9V1LlA5olRYdhoSLWGis/rG3rigZkZPYOaZzuzGEgISk2GSFLBVS02jugK8w8XmN2w2ynxyk8OLwjMLMklEZXZ4nZSGzYDG1igyN4fX7P9DJ05o/izt6IujueMYP8aSzOk0rUK+b4jwctNnBabgyudNOpXiUgQQ8BeGOJynT0+fQjT8bkBw9rF6WoFEwG8Gwy+RRDYjp/zwJGmGcCkpcbXLQTUl3WWJFU113ieK9PaljbflhXL4scWFl0l5nw6deCTbz1G/imbcqVBv7mgTeKAyjvzzeC2LARQWij/sdTNx+Ic3IF0fvdG4WoAIHMhF8HR11hddy3XF+e+YYocHhCS7O6fRN6p8JQuAJjUHGZOo/GrRjCOX1v3gEoY6wPGG45lxDUqWWgcQ7n9D6siosNi+6kEaAXXFZyB7JSq3eUFgbBLKho14PW58AQF5pvDf3bIAu55pIH9Gd5I87w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(31696002)(66556008)(4326008)(6486002)(83380400001)(316002)(31686004)(26005)(8936002)(6512007)(6506007)(66476007)(38100700002)(186003)(53546011)(966005)(41300700001)(54906003)(45080400002)(6666004)(66946007)(86362001)(8676002)(2616005)(478600001)(44832011)(2906002)(110136005)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNZaFdaZGxQUGY3UnNZZFg3Wm1sTzNuMHNKZlRybFhVVnlDYjJiSkx2SzQ0?=
 =?utf-8?B?blZrU3VvQUs0UFVOTk9sbjRsNTVZRi9rSTFTYkZxSXNDVUhVeVNjdlJweldB?=
 =?utf-8?B?RUh4d0xzeENjQ092V0tRUHdBRHNEeUprNFY1bjhha2FobWZUcGRVQnJOYVc5?=
 =?utf-8?B?L1RjcVFRNkhOMU1kd1lQbWpUcElxZ25LakVUK0hSdmNSMUFnMUdmb2FxRlIy?=
 =?utf-8?B?NUM3aDk4WXBOUHVtYmNGMXNnMHNmQlFabTF4endqN3dTcXNQTkU0dWZxelBw?=
 =?utf-8?B?R29ZY2dEY29Td0hkYUlaMVpTSE5TVHdGN0RXVEZqQmNyTHZ3QUZiT201OG9W?=
 =?utf-8?B?YUI0SWJ3ckF3Mnc3Q2M2TVRlcmJsUklGVXg1N3lzRGo5YmEvTEZvWGdjU1V4?=
 =?utf-8?B?UHRqT09jUWVNSGtZT2d1bytYMnY5S2dwdTQweFZQaFVpVmRpNGZDWDFFZ0Zn?=
 =?utf-8?B?czNHY2ZVNG5rMElNVVhWamVicGtiNVJOdHBId0NGWVBld2pxUDhRNmIzNU5n?=
 =?utf-8?B?V0xTOWY4SldjK3hzSGRhdkpFNVVsT3RoUXQ3Vi9yTjlxNjBDOExCQk1tZTZT?=
 =?utf-8?B?OGVhYmtPaGZnZStUMVZ2UW5CakM2WUJvRFdVd1dqWVUwNUVBVnFNeks4ZlQx?=
 =?utf-8?B?NjI1eTdjSkpOQ1MyMmhUbE5mdHhuamFSWHQreStiRWhYbEgwaFI5YThwU3Er?=
 =?utf-8?B?OFZWRnpRM0ZLTlJRZ0l3RTJRd2Nyc01TdERYVVh5UjA5YTN2MnlJaEkwaUVy?=
 =?utf-8?B?L1REYmIwakxVU1lEVzZISk5qZmJ3YWYvdmlhZnhpSW5aTGJTT2xXUXVYeEQ0?=
 =?utf-8?B?ZnN4ZWRtTTRNYVpkKytuNU1xYk04K09OR1VmS2Jmb05kMUx5YmFJZnBpSkFC?=
 =?utf-8?B?cmF2SmJJeWFXYkUxZFh4dWw4eXAvWnlKaXlIWDYyZDRzOGszWDFZd2pEWGwr?=
 =?utf-8?B?Z0tuSXZoQ01pZ3RqK0hBMVVUcDJ0S3FjMmdva1J6R3pnMUpBZ3VDa0VPU1F0?=
 =?utf-8?B?WmE4WUVWNlZpVFJiem14bU5xaVBvMjl3WndPM2dlbzV3VzRJYm9BeVNaNmVB?=
 =?utf-8?B?QU5Hc1BkaXFhSGE5NXN4Njg5M1ArNTZlUis4MHpTSVVWTE5CZ1ppbmJGbFk0?=
 =?utf-8?B?RHZ4MFQyUENZanJhemt6R25BcU5VWCtZazM2WjNNenExUDdoRGlFODQ1ZE5Z?=
 =?utf-8?B?VUtNN3JYckFwRENib0g0a1lveXVOazZ1aUJHQldicjFPNllmQjROOHByL044?=
 =?utf-8?B?RUQ3UURNLzUwL0RsSUpLSGM1NW5nbEdoY05QQ0ttQWdiV2ZIU3JHVWF0Q3l3?=
 =?utf-8?B?Tk1rb0VOY0hHTDArY1ZzYmp1aFIyTndtSFFsbFcwNUFpb3BCQ251d1lNVlVi?=
 =?utf-8?B?YzRNMEErREVSaUpJQ0ZERWNwWGtIZWtRVnlQZjVaaG5ESE91ZnNMY0FlUmZI?=
 =?utf-8?B?ZDJER1NZbDV4V3J0cUEwTTQ3eVF4T1ZGdkU0RFpVanlIVXlxbFdnRFlUWlZX?=
 =?utf-8?B?TGhzRmlhUVEyLzY2ZU1zMFYxMHVlUWlDOXhLU2VId2prdUh5aXhtUUxWV1NF?=
 =?utf-8?B?VVYrL2xGUFArcGVpeEZBVjJndmFJQS9LeFptR1hFNXV4TjZNNmpYcnArakpy?=
 =?utf-8?B?SHgyN0NxckJ4bjlicHVWNE8valBBRlRLTmhicHNqV0NWcDRjVWczT1FjWDc4?=
 =?utf-8?B?YmdnRHk5L1dUR1ZtT0JhMFZ3T0RaaXdpdUhvNzZ4M1o0SDgvekgzOE03VmZ4?=
 =?utf-8?B?SmpIa3JGSlRReE5ERmNhZ0tCbllMK2dKUTJlbHBSSGFsLzlRbWFwbC9RV0Zk?=
 =?utf-8?B?T1dDb2IwZm1XOHF1Z3QzMlRucm1FNXF0dFV6S2dBb1UwODZnUTB5Y3NQMTI1?=
 =?utf-8?B?RzYycFZIVFd4QUVReDFjOFBlbmV1MUt2VUlUbEJFUVpwMHREZ2NuOFYrVHpo?=
 =?utf-8?B?MUcxN0tWS1lzU1AwdU5CYUZsUURhcU1ObktYWHNtOWFSSW94eW1GWUYrRW9i?=
 =?utf-8?B?YTlkVk9ITE5GOWtIZDZtdUpMancwcEsvczdlYnR5WE1kbTlSbXNxZVM4MWly?=
 =?utf-8?B?NTZ0SEFIeFBIdnIxUmVCSGpnQzRzMXNpY2I4OUg2Q1pkM1JhakY1MXJHanli?=
 =?utf-8?Q?GFsx2MuspW+JSV0a+983ohpQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935e21fc-2878-4203-f32e-08da9a3efac6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 13:00:51.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo+lbwdhdhdH2VgtFNWArIV7qaeemYsvmrGcwayxNQJmSPUtLc0RTwq0A2xRl4wYyuhQOS/IwTubgxepwdAx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 17:17, Luke Jones wrote:
> On Sun, 2022-09-18 at 14:46 -0500, Mario Limonciello wrote:
>> On 9/18/22 03:37, Luke Jones wrote:
>>> Hi,
>>>
>>> On Mon, 2022-09-12 at 17:06 +0200, Philipp Zabel wrote:
>>>> Am Mon, Sep 12, 2022 at 02:58:51PM +0000 schrieb Limonciello,
>>>> Mario:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Philipp Zabel <philipp.zabel@gmail.com>
>>>>>> Sent: Monday, September 12, 2022 09:57
>>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>>>> Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar
>>>>>> <Shyam-
>>>>>> sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
>>>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>>> Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt
>>>>>> laptop
>>>>>>
>>>>>> Hi Mario,
>>>>>>
>>>>>> Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario
>>>>>> Limonciello:
>>>>>>> It was reported that an ASUS Rembrandt laptop has problems
>>>>>>> with
>>>>>> seemingly
>>>>>>> unrelated ACPI events after resuming from s2idle. Debugging
>>>>>>> the
>>>>>>> issue
>>>>>>> proved it's because ASUS has ASL that is only called when
>>>>>>> using
>>>>>>> the
>>>>>>> Microsoft GUID, not the AMD GUID.
>>>>>>>
>>>>>>> This is a bug from ASUS firmware but this series reworks
>>>>>>> the
>>>>>>> s2idle
>>>>>>> handling for AMD to allow accounting for this in a quirk.
>>>>>>>
>>>>>>> Additionally as this is a problem that may pop up again on
>>>>>>> other models
>>>>>>> add a module parameter that can be used to try the
>>>>>>> Microsoft
>>>>>>> GUID on a
>>>>>>> given system.
>>>>>>
>>>>>> thank you, these also helped on an ASUS ROG Zephyrus G14
>>>>>> (2022)
>>>>>> with
>>>>>> BIOS version GA402RJ.313. Patches 1-3
>>>>>>
>>>>>> Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
>>>>>
>>>>> Did you use acpi.prefer_microsoft_guid=1 for your system then
>>>>> too?
>>>>>
>>>>> If so, I should re-spin this series to add your system's quirk
>>>>> to
>>>>> patch 4.
>>>>
>>>> Yes. I also tested with the following diff applied instead of the
>>>> module
>>>> parameter:
>>>>
>>>> ----------8<----------
>>>> diff --git a/drivers/acpi/x86/s2idle.c
>>>> b/drivers/acpi/x86/s2idle.c
>>>> index 6a2c94fdbeae..a247560e31de 100644
>>>> --- a/drivers/acpi/x86/s2idle.c
>>>> +++ b/drivers/acpi/x86/s2idle.c
>>>> @@ -420,6 +420,14 @@ static const struct dmi_system_id
>>>> s2idle_dmi_table[] __initconst = {
>>>>                           DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF
>>>> Gaming
>>>> A17"),
>>>>                   },
>>>>           },
>>>> +       {
>>>> +               /* ASUS ROG Zephyrus G14 (2022) */
>>>> +               .callback = lps0_prefer_microsoft,
>>>> +               .matches = {
>>>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK
>>>> COMPUTER
>>>> INC."),
>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus
>>>> G14
>>>> GA402"),
>>>
>>> Just a note, this needs to be `ROG Zephyrus G14 GA402R` or this
>>> will
>>> catch the GA402Q series as well which doesn't require this quirk.
>>> In general the model numbering goes
>>> <Range><Model><Generation><Graphics>, So for my old G14
>>> <GA><402<Q><M>.
>>> Or for example a ROG Strix machine <G><513><Q><Y>
>>>
>>
>> What _HID is used?  From your description GA402"Q" is Cezanne
>> generation
>> right? Can you please share the acpidump for me to confirm what is
>> happening and if it's expected?
> 
> Sure, dumps are here -
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2Fasus-linux%2Freverse-engineering%2F-%2Ftree%2Fmaster%2Fga401qm%2F408-fw&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cf7ff7320f72f483145c108da99c39de1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637991362709739412%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=S8%2Bqp%2BtwFh6j1ZikKLpwRodmrhhSnthVDwuJZ8Ncs0A%3D&amp;reserved=0
> 
> That repo is a bit haphazard as info tends to get collected
> sporadically when issues arise, but it may be of use for you for other
> things. I'll try to clean it up some.
> 

Thanks for sharing it.

So this system uses "AMDI0005", so it matches "amd_picasso" behavior in 
the patch series.  That is "data->prefer_amd_guid" is false, so the 
quirk and parameter shouldn't actually do anything in this system.

>>
>>> I don't know of any others that may need this quirk.
>>>
>>>> +               },
>>>> +       },
>>>>           {}
>>>>    };
>>>>    
>>>> ---------->8----------
>>>>
>>>> The full DMI Product Name is "ROG Zephyrus G14 GA402RJ_GA402RJ",
>>>> but
>>>> there is also a near-identical higher spec model GA402RK.
>>>>
>>>> regards
>>>> Philipp
>>>
>>
> 

