Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD01D74D847
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGJN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGJN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:59:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759FD2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNqQ8R1vMgskmEZHPtG3VjEbrdFQfy+/cfAmAdOZgp4hb9vrArvE6LWfxENrwsIE6G/LgruU/yxdfLobOsfJj7dXfKSHxXq8qweWwu2kAAZI8XcHzVXvF9wQD0vOlxH/VW1KSeARM5GoPvJFPgABfQtumQRBaeApY+bwGXpbquNgpQYaKh3OHCcEPE7e34UiqH7S0LK18w0AF2fb8Ze6YhjmPJHXJ970CaKTDnZhcSaEhBqfuDk4xoCZSoL6uo/fFJu+A6AWdBTQ3bE5acKWbHyNejQ2lOZTXhjJp5hwNEvDpq5QggAOtGaAHKnFbfwmBjRFKv4K1MxlTBokssRVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+FynCTJ0dyoZEIsHDVjdi4nQbU69MAhofVfAR1TnLU=;
 b=NdlSfIrWPk/d2s1mG6euW0WD/DHzYxTNBktTf7fCFadGhz8xr35wN4Mqz23KTBt75kgXBwG99NcLQidHNCkKDCNSE0lsN6rKaZot6QeyEx7PvLxAuzqhB8H/YxzJs3GTLTyPnwXNsgI62VbYS/SHJYAiLfhWMKqX8/55mPUciv7Kz086KORn7bLSDtAVizkRY8IbA5Km7Q59buwujQbCSnsff8JdMeoch5tIgmU+5WD1zUXpqPUi6CeyQJ2uzyKlcozNGr9xK/7TgaQsYlZY5XT5IZVz0+UmggX2j2OymQEB0gFyx/Faeobbm3RaQqfMOpEPzwsbnkPCHUCS4UT2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+FynCTJ0dyoZEIsHDVjdi4nQbU69MAhofVfAR1TnLU=;
 b=LB3p8GdEl7Ewn4U8ZMaVU/e7o9EYYWqIpDIw8jIkU4feaJOq12c+Bkk54g0h3BT3NysWDAdQMaIrRAKuls/Vj1y81RxAXV/FsxfYY34iQM+vK0h1BzxP01EsiAAM8+IY8T3tS5CO8uldBgSpYWiccn+Od09LdGdX/0MoVQi50l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:59:07 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c440:6819:be48:f4b8]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c440:6819:be48:f4b8%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:59:07 +0000
Message-ID: <fa869adb-a873-5f40-d843-73cc7e3a58cf@amd.com>
Date:   Mon, 10 Jul 2023 08:59:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:805:66::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eef198-e76c-4db7-ebe4-08db814dd400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttfUUjVLD7Rqgjjvo85X3LrXvqXhqu08+/0xLWW5aRuhxCYwzhu86pr28ctxm6YpN9AQUopXUe7+mDSxYRGTvgtFjoar3ssuH1/UAxMR9+Gf3p5I530J4i1Q1Ofp8JYItEzZ/H3EfInQNiDhNfZNQXEHinR9/74/Mlf1l2YJuCf6EhSqJeZu689VesKdx1u+HZxDCU5C2XpeM3UZ4xCQcM6y7U+qlbO9ivjt+VyuRQ4gC29hZ/Mj1hlC6Aii8VXqXkrtXbdK8U8IQrqTe4ZgTGnRYJI2zI48e6rEv3p8h2dGQCXbE7bvVr+XfmBBDL2H8FRhBS0gYsTc4ahi1u1Ud7VwJLwtjts2zY186lveCKW27xzZxBcA55PJsG6xtVVOoL5EItuwfJPxhScvNtPbrjq08zAvAP04Hf36IxdkvRKFCzEEYqyZ7MQShkXFbx7VGRihPDUtkAt91fNN8ZS2AD/Q9h3bGWJd/J7RhRko2jm7AU1njagUBJg2C411ub5bjsu6F7lnQTI0SXor/QE8Wh8NNgVIk5tUWPQHdtc/G6tbLcW91B+CXECdNroaqP6KLFSfEookDTGPRRy7LXZzOkE+5ic5IRfeNqdisNn1zPKp1Yez65IXd7/GseJVPqe+q4NxPt1guZsp4VYw0KTK0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(110136005)(54906003)(6506007)(53546011)(26005)(186003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNZUUtDczNZbGY3VzZScFU2ZGM2QXpaZ2N4RWJJK1JobjRIcGZoVWFKSzRr?=
 =?utf-8?B?TWtpMFByNThTbVlIZ0RVSlBnbEhjdjU3bEY3THB3NFV4dERxS0tFY0Zwdksw?=
 =?utf-8?B?WERFZzVoSU1udjNvdzJVc0F6MUt5S24yOUsrT3A0K3hRMXZEbXpMUkJIV3ZQ?=
 =?utf-8?B?eUgvc0ZOWWdPTEl2RWhHblI3KzN3K1FBZUhBaWJsZWdRZldaVzlGVnZHREFG?=
 =?utf-8?B?Y1V5c2s3Y3V4MU5zT3dTbmFqdkFQM1Nzb21YNHRGQlEwM0E3a0wydzIwUjUw?=
 =?utf-8?B?MUNLMGtJSnJzNFkrUjgvNVhrUERiVkZ6Q25GU0xaWkNkN1hWSVg3R2FjNVB4?=
 =?utf-8?B?dHUyc2t3NEhjZ2Y1Rkg3dTNYTXh3SkNTK1Y5Yy9HVkFwNGFxRTYwOHdsQVpq?=
 =?utf-8?B?T0xDTTF0UWVid3ljS1kyY0ZLTUwwTklLWW9sNXhPNlhYSEJaaVlncXdxeWcr?=
 =?utf-8?B?eXJLR1dZNS9ldzFqeTY2TnlCaHIwODhld1hQVk5zMFV5aUxBaEhqSGoxME9r?=
 =?utf-8?B?ajBjRTkweHRqNzlLby90eENaL3dkZURJbElCRUhaSG5DTThFZGp0aG9lSzdv?=
 =?utf-8?B?eTVQVVhpU21CNXUyd1lzMUVSazhycjRNV1BtMVVIZ2x2bFlRMFFQR1ZFTmpS?=
 =?utf-8?B?M2UrL0JaV2YvbzUvSE5IaklqZGFQNGhGYnp3VTFBenQ5SlFydnRoWlIxMENK?=
 =?utf-8?B?SXNJN1VWbXYvVG81ZXNEcmJNOE9rdzNPd3JRWVVaSmpzYUw2N3dhSUltOWJ1?=
 =?utf-8?B?TTMyUXVnbXlXMGlnVVZiNVlxT01rWVNCSmxBazA5NmhacjYveVQ0VzhnaCt6?=
 =?utf-8?B?RnF2UWlzKzIxdk1ndENXOHVneWlPQTBOdTJOYVlPSzRINUswS2JNUko5R2lm?=
 =?utf-8?B?R3ZjQ0JKSnBxOHA1eStxaDJUZ3g3NG9GQXNlSS9hb1hZTzgvcVo5eFpsLytU?=
 =?utf-8?B?dnJlaU1lZDRiby94VkViVVhkNUFYVnpXbWYrdVVSQTZ0WTNla21ZVytmNEgy?=
 =?utf-8?B?VlVGNGZlRGl3eGEwSzNmUU5mWVlLVFJKbDdwUWFCTDh1eUNYZ2hhWHZyYWVE?=
 =?utf-8?B?UFIxSFQvVUZQM3h3U3hxMUNGc1hNUWxPd0FsUjF6R3J6TVBhNkdsNE5VTVdz?=
 =?utf-8?B?ZmFzZ25mcUJTUmh0M3FZeDJsVVZTY0FwK1Z3d25LNUsweVhONDl4bmp1YnBY?=
 =?utf-8?B?elZ5T3h1OEdCWUs1Y0IrU1JBc2M5b1dTdjlrSUw0OENGNDhBY1FxZHkyZUJF?=
 =?utf-8?B?dXZHYURPNUhPZHV1QlZUeXZLR1hCeDFxcVJ6alZranliSWU1WjZtNmMycFJU?=
 =?utf-8?B?MGJtb3BsRGc4di80TE5sWmRqZGdqNFZZSmNZTFVqdk4yZldKY1RpZnlGMTQ1?=
 =?utf-8?B?dFM4bnB4b1NSMUtzUDlpY1ZPSjAvTnpuS0pNdTM2OG5QS2dHWjl5Ymlzd2g5?=
 =?utf-8?B?Qi9RNDc1RXVaYXVEMDExTnE4QklMYnhiVWQzTFRsQzhpMjU4empXOEhyU1FY?=
 =?utf-8?B?SXBCSDc2RG8xbEUzcGZTbW1NS0JibzgyT05OU2ZTeFlIdFdRZEVYdFF6SEx3?=
 =?utf-8?B?a1pqc2lqVFRiaEhiMjV1SEhyTG5kK083U1FZM1RjTFY0ekFZOTRabmNzVGtY?=
 =?utf-8?B?SUoxcFlPcmViRkRieE5CNFpFU2pHZHJWakVGM2Q2QWtuQVpRdXNkSHlUYTYv?=
 =?utf-8?B?MGNGaGVvdVlNVEtycFpJUmxMbjhZVVc3aDBySmpSLzZMYnVtWTBSVGJLQmFx?=
 =?utf-8?B?MkdrUE9FOE02dm5QRmtZQlNITFNBb2hrL2Z0eGltajNqT0cwOXJMV3l3Q1pX?=
 =?utf-8?B?RHJ0VVBHSHFWM2RuQ2g1VjFFWTB4Vmo5TEVTZklIakJJQTVBa0IwSEFtTGxk?=
 =?utf-8?B?TEh0QnZOWU5ZYytFN0l1TlNLeHpLLzc3cnBFS01wUTJ0UVNjV3VTYmx2WDBx?=
 =?utf-8?B?MmhlUTV1VWJMUFc0WW9jYVo2N3RualVhSnhMQjZuMWMra0ExYm9Db3FWRm9I?=
 =?utf-8?B?cWRVVm96bmR0ZUNrSCtFTlJmZVQ2TCs5a0J3UUcrcTRYWlBNSFBEUTluVGJ4?=
 =?utf-8?B?aTBGREpXd2NIZXVCTUZ5UTIyRkZ1MEVzRlBMWU1GVlc0Um9YWWl2RkhTK0s3?=
 =?utf-8?Q?hn+Pg3XJh2tz6q2QVlg12ad/R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eef198-e76c-4db7-ebe4-08db814dd400
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:59:07.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ9qKwed0EQ9FLF/WyqCUHv0ct/jZcBfa0V6AorFjGq2x9B+2TyaPrkI9osUmV4VNHvLIsUxHLIKk0RCCgEelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/23 01:09, Kirill A. Shutemov wrote:
> On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) wrote:
>> From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July 7, 2023 7:07 AM
>>>
>>> On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrote:
>>>> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, June 6, 2023 2:56 AM
>>
>> [snip]
>>
>>>
>>> It only addresses the problem that happens on transition, but
>>> load_unaligned_zeropad() is still a problem for the shared mappings in
>>> general, after transition is complete. Like if load_unaligned_zeropad()
>>> steps from private to shared mapping and shared mapping triggers #VE,
>>> kernel should be able to handle it.
>>
>> I'm showing my ignorance of TDX architectural details, but what's the
>> situation where shared mappings in general can trigger a #VE?  How
>> do such situations get handled for references that aren't from
>> load_unaligned_zeropad()?
>>
> 
> Shared mappings are under host/VMM control. It can just not map the page
> in shared-ept and trigger ept-violation #VE.
> 
>>> Any comments?
>>
>> This looks good to me.  I applied the diff to a TDX VM running on
>> Hyper-V.  When a  load_unaligned_zeropad() occurs on a page that is
>> transitioning between private and shared, the zeropad fixup is now
>> done correctly via the #VE handler.  (This is *without* my RFC patch to
>> mark the pages invalid during a transition.)
> 
> Great.
> 
> I am at vacation for the next two weeks. I will prepare a proper patch
> when I am back. Feel free to make patch yourself if you feel it is urgent.
> 

Michael,

Are you still pursuing the RFC patch, then? Just trying to decide whether 
a patch will be needed for SNP...

Thanks,
Tom

