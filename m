Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5762AE59
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiKOW1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiKOW0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:50 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE42FC1C;
        Tue, 15 Nov 2022 14:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo1i+hFPrCa2K2r72BAIPt9VQrmewDB2A3bTI+4frtCOtwkid8KVBkRMyLIYItuynVomHHq0ui6Hpz1YnntDKLOZNFC7+Ip9xMGZ1KHGdTdfmm4Grhnr4bmS+InWo/7zHoBh56n4C96UrXs4S0ZhFUD80Pe3AZKJ/zxxJtatoMCH41ZeVW1Vo+tXlklkpawB9nFscFoltt2Xe41UIyP1JnxfQucHLAVdYjmvjU+EZL3IfpXIFREa4M1yIr/A1AHu1uiTc942lE0wwLVNaeD4ZXQYQPVrKX93Nogybke9FnIogteEpgae7fFQNpVlpVII8z0LbkWBQOreJ+vzEttK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5THZfB0HQX4QxFjsTmjNixcKfQKQfDB6Y1Vowe4yQKE=;
 b=kt91Z2dIiWEmS1xatGq9pyAfCMGZCK5M3iVv30qpODwo6YLaMMYM2jCwUjfng5lKlIZi/kcnENGQlvr/9X0FSrCukA91JmE4z98MXgGM9NzutYcU6CxUJURWKfXaU2qUlQTcBvfrSYnajxN+WMaGXMLZtSnLNe93nhDf5YTqr1b9NynxQtYxpTt67T5/PHnKQMg9rkTGf5RKfE5rJY1nHVIE+HCxRftzTeOgH+MYiNXUgd/atYPzeI/PJgDcxYvdngkywPyiXwmpWz+SLRTzTm98NdwTtpKwPwm9lzOEyQATSldNTXi64PSfAN1f2zId2os1uk5d+JiwQ+/NfVJihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5THZfB0HQX4QxFjsTmjNixcKfQKQfDB6Y1Vowe4yQKE=;
 b=byRhOg+OmtsgUV2fcxiSFrjeyYXcgEOM3WHq1YqEfZjjSAHcgjZMbv2vg1wCt9U4QTrzxALI8GZ24200a/xbmkbKAB7quLUgOs1T3hBspzd2FThjn4B1OIIks93WtdFLwM5eyxsw8DhpFKKnjtfhW+hWjPxOGbuhPjWbmzWDMiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 22:26:47 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 22:26:47 +0000
Message-ID: <32bdf227-66ec-adf3-23a2-bd4e09bdc974@amd.com>
Date:   Tue, 15 Nov 2022 16:26:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs/sp_SP: Add process submitting-patches translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
References: <20221107150815.296699-1-carlos.bilbao@amd.com>
 <874juzan8v.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <874juzan8v.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 92209cc8-7b11-482f-f94b-08dac7587bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWBZ5+5N62eW75HSPFOMTl+2On22t6EOXSiiELobB7FYJgWAKGuAYQuPGWzceifZ3pzQegDzd/ymk2ry6+laFpUoOFYZ5qC0QJGiVMYXD4ipz+I1LEaMyoFe4/rLIrhytp7yzHR5Uo3RCSqol/ZLPQHL9bTqMFviocN+fGLBj949kqIZ18E8w1t/mM1L67U+rrfjOWEs0tKhCeVmjkZLPD69XxXBJUzPnQEtOi04gwsvzAY84DkBJE8JtiO/skr4rEWRrXnNY13/Di3GyMniSpRrmJmBGZvu99n6XnYGHzIJ7VdihhLNKuZLx7GWBjbBdgG5tk0JqElVx9MxcviCk7e0oi9E+m81LKoiahEcSqiBEG6de880D2CManYpCiQ6RZTqLiRFggESc/pkQcxfIrRcMOEB0a5HWzVUoiJYpEdMV1jGERmamjpydBMWoOdM7nHYk44HjvT/Rx1Hm2AWWFZ0dCDD0nbM+NT3SuvuXNwg2IGLYLOacsSQIaVTUS4GhbsN+WltHXB7bSdq+yWXSeEPjITK5Of15RpiQpHyOKJtlbOsVtXlASfD5khVr9FePOf1tMkw7VJu8dLVTD3NIatVmiGpgZERlVIiNW8AAYwFwSn253XmL/RXBqQKu/hxgTPt+pQG0MeaofnZaNlSY91+i/I/wY7vjddXIAv0EjIfa2xnS6ddOrXSlBXAC/SCC6lXyjlrLlBEaV2wJB2aCyNQ8Rj2aZowpElzG6672r/BTvggE046sD/imcY4t9Efng/qoOTiX5cGeQx+TKfnTKW9Wspoh0XmxQHMM1d5EE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(6512007)(26005)(53546011)(6506007)(86362001)(478600001)(31686004)(6486002)(6916009)(41300700001)(66946007)(316002)(66556008)(83380400001)(66476007)(8676002)(186003)(5660300002)(8936002)(44832011)(36756003)(2616005)(4326008)(2906002)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFprQ3RlSVZvSUYrUEx4cHdrbHdRcG50M3dEUHdRSFJ3MTBTNWR0dTh0ait4?=
 =?utf-8?B?SGR1ejJmZnRwWStNU0MvSWVhdkQ0d0RKV004T1FLRUZUUC9sY3VUbXEvb3M5?=
 =?utf-8?B?TGt6K3hTdGp1dnlLcFZSeXBOeE5ITUZkRzlNQ0x6c1lsWGdKakI3Wm8vc3hZ?=
 =?utf-8?B?UEN3ZEZGWktlWkxOY3luK1F3Y0w0RUUvZTdFRFhhRGVBVVl6Q3MyUm0wTGxy?=
 =?utf-8?B?UWdwZzhIbHpUNlNoSDZCV1N2WWVFSHhjVGQ0OHZOaFFDTmxnOXNBMEVaUE5M?=
 =?utf-8?B?TncyK0RzYTBjdVd3NkZib2Z0UlFndCtkQkQyT1NjVWUxNFN6dDJ1aC9Nb2dj?=
 =?utf-8?B?N1dSbkd5cVV0YkhNbXdTanNaZjN2RERUc01TczFMTkNLUStDckFCRjB2amVa?=
 =?utf-8?B?eEp1RFMyOVVxdnVDNCtGYUliMVdUbDd1ZlVaWDhQaVF5V0JXM2VWd21PUThp?=
 =?utf-8?B?aGtvY2NWNFlLb3FmcXlKaEhOVkVqL1lhcFJ3b3Qza1RTTG9NV0FOcW9kTXIz?=
 =?utf-8?B?NWJmRjAyRlpVdWh5U2R2amkrTk4rV0NnMFhWWkF2QThCQkQ5N2NhbXA2K05P?=
 =?utf-8?B?dU5iMzVhdVNlNXN3NjhtVHhhd0l1ZUpnV3ZlZko3MXZreXVkSDdqY3FmWGdl?=
 =?utf-8?B?QlpVVnVUeHZHSXlTZHUvbkk5Ni9kV3FnMDNWZjNhSlQwam1nMkdXMGhvK211?=
 =?utf-8?B?a1REVy9FNUUvODFINzRpM3NHVHBSbHlaN0dETXZCM3dWa2pGNFc4eEVocVhy?=
 =?utf-8?B?cU1ZaStUYlpPZklJLzVvVm02d3B1b25xb2I5ZFJ5RTZNK1VqSHljMDZBOE5i?=
 =?utf-8?B?QjRqcCtUdjkyZVFlTHdPejJlaHVhTEdRTVRmWk1rSGswWUpkTU1ORVUwelRh?=
 =?utf-8?B?cTJGUzBUeFNEcXkrWS9BZkZBZjUyZFVaWjlzTytSOTFNYVo3UlFqUkZoOE9B?=
 =?utf-8?B?di9SdEVMVWRWMWRaVDhqeUxRVUM1bzlGMGZmQ20yMjZIV3J5ZVZLaU1qTEg4?=
 =?utf-8?B?TnptQ0FEMjFydkhZZ0p0U2NZcmVHYzE1N0dhQllXRUp0ZnUzYllvTnlJY1Fv?=
 =?utf-8?B?TkNBWlNTdktkQnRnaGFMV21PQVB6eGhKOXlEMHQ2RThIaTFTNVVVQkJYeW1l?=
 =?utf-8?B?cmFlWHdzc2lpMzV6YTlYSk9qbDlqZlVMRzdadzV5ejFVSy9mOXBqN2FGai9x?=
 =?utf-8?B?TUtiaTdqMGlwM1FBZnZuTnJ1cDRKaGduVGx1eWF0NTJrVlpwM3lhQTlReVZN?=
 =?utf-8?B?WUlkSS9hRk9Cd1JuZDRiVkdDSzA2K2tWTGpYOEM3VHN0eDd1Tis4dmhha1JP?=
 =?utf-8?B?YjdkYU1HWWhOZTdvc2VrbGdtdUw3V3BVYnIyc1JWOTgrcG5Pc1ozaUQ3OWEz?=
 =?utf-8?B?VnlrZ3hNT0lyMG5sVnNpMVJ1VzNTK3pTd2NsajlQdWdsNThaTGxkQ2h2SUpw?=
 =?utf-8?B?a2VXWFNwYklQTzVIRUlmTDdEbXp5cjFkOWxGT0NDWEY1NGxndVdMTjVsYXpl?=
 =?utf-8?B?TGdBU1lFWlUxMmxsUFR0WDkrZS8ybFhBdWcyeHVLei81L3FEYXhoT2E4dXlv?=
 =?utf-8?B?TEQrR1M1bnhIT2lGY1BZcEd3eUVTczBIeWhJQXpMblVnSGdaWWhaYWVFUSt1?=
 =?utf-8?B?MU9RRkVJUXh6dVNpSVBSYWppV3pZUmVnV2grTmZrM1FTMG91cmJ2L2I0eGVj?=
 =?utf-8?B?UngyOHRTYXdJVGFxUHl6WVltclpwNDFDRUZ3eElsOXVzZUk3UWNFL2VZSlpX?=
 =?utf-8?B?WGx0cVNHYXFqNTZKL2pHTFFqeG8rblBRQUdIekpwVXhYZHRyNnVYOHZnQjQw?=
 =?utf-8?B?MVY0aDJLeDNaa3JBTFI0R0RsUXlhSlVPWDBUa2oyWXpzblpWNUg5MnZBSWJh?=
 =?utf-8?B?bExmQ2RBYkRyYmFUY2xLeFBlOW11RGVYcERUbmdLazR3ZlhMOUg0OXMzMEpI?=
 =?utf-8?B?RWVLRmhQUXV0UnhVV3B1ZU51NFIzMDBnSk1QYXFmUmVObXBFY3F5N0xHdnoy?=
 =?utf-8?B?NFovMmQ0aCtFbVJNWWlJd1pPZXp6WFF0RUpLLzFsZWR4OTZyTXNXRzE0ZWxZ?=
 =?utf-8?B?aDk1RHhVR3VpeDluYmttdXE5TTJXKzRGSllpNWZrdlBCYmExOTJsa3cyR0dt?=
 =?utf-8?Q?+/nmM1xAo+H6n/CEu9vdsFVVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92209cc8-7b11-482f-f94b-08dac7587bab
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 22:26:47.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JyZiBXUtq7hG3fjHXdMQuOl1puh9Dxu+VsL3csDLnaGBRjHoo1NgR+40XJWY66wFplujRg04e9iNHFlDrf9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 16:04, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Translate Documentation/process/submitting-patches.rst into Spanish.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   Documentation/translations/sp_SP/index.rst    |   1 +
>>   .../translations/sp_SP/submitting-patches.rst | 894 ++++++++++++++++++
>>   2 files changed, 895 insertions(+)
>>   create mode 100644 Documentation/translations/sp_SP/submitting-patches.rst
> I've applied this.  It sure would be nice to have some reviewer support
> for the Spanish translations, though...I'm *pretty* sure you're not
> telling readers that they should actually be running Solaris, but it's
> hard for me to tell for sure...:)

Thanks Jon. I assume I made, and will make, small, *unintentional* mistakes
translating here and there, but I hope readers will notice and get back to
me eventually.

For what is worth, you have my word I am not an evil translator trying to
ruin the documentation.

Unfortunately, countries like mine (Spain) are quite behind in terms of
teaching other languages. I have many acquaintances that are brilliant
developers but know little or no English. Personally, it would feel
fantastic if my translations help bring any of that talent into the kernel
(and far from Solaris).

By the way, that's exactly what the English documentation did for me. Did
you know that my first ever commit to the kernel was on the documentation,
and you reviewed it?.

Regards,
Carlos


>
> Thanks,
>
> jon
