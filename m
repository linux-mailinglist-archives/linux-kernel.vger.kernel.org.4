Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17F70FE88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjEXT2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:28:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46D12F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs6uiefz92yCQ6GpT7zKCgVdoxZsAon7WsSTj16ClpG+7cPWwaVVGGqNTj8bT8FFOTPh8scMc+QglLXELTeaP6imJm4SDgyZYWhAuixHuocduERO9/yBaH/v1uJ61WGAawuSPEQJI83Y2Q8e+8xZ8JiVUB0Sl2qUpzwvtTmyHoVcwygv4M1BxbGNKjsJZPdn+UCx9z0GwULUc6SMlhpxLq8Ha04KxuWs3Y3YcyzI2/3o5jIpnGJTgZhgU+oDj4rgsSFiJ18C1XzbEhKu7lxU2h3yv0EhlUaUqetjMhllLpYFNwRurHtgRrigDQtHZhK+6Z85BoM46sOSuc5jGQIqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iljURUTwpeHL+08A2m+8VQaM77j/U63Md7+kkqMll98=;
 b=MeKvuQRttX64MNX+oQA1RFTn8nmOCxifNM8GsL8zTDEkNZtTuAiND8Ao6637RS0fr0TrCxaI6KMPy6ItWtf0g5YnuIoQ4XuSlgPAGbk2wyJ21kSQYkMdigmt+Eg8mXYu2XEu5i3A7/ySYm4EyVrLW2GKQL1mUO+6inZ7HnLNr4SPKdo+gn3IcckpPlGnRUvyxTiyYTOhIS3Hyu7R4VzxuJKYio+VzNusssehSDEKYaqGNMFHMco+aFla/R92ui/luSpV7FBuOI2tNCUz1dkh6YzYKmcZGxivxwyGxeSQugNURXyQ2IeIXPp92YoFl4HokImGlJZKGKdfhFDK7Dioiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iljURUTwpeHL+08A2m+8VQaM77j/U63Md7+kkqMll98=;
 b=NR+fsDliR/CVPkGGDmdMVzYwIr4CyytP7GS1uD9RuAF/77LeKP6YhbiutQ94WWyrZGnMP5c+PJNCLdymBBBWi2TAM8Btly/UQgA/6M6KseaAyn5Qs9mz+Oi6TYEZ4gK2lsIl0ga78nhpYHiYG7AjNzwgQhqcZtvrMp1aHmKcdHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 19:28:00 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 19:28:00 +0000
Message-ID: <cede79cd-4986-ce3c-ab74-a4497e9e1230@amd.com>
Date:   Wed, 24 May 2023 15:27:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: enable more strict compile checks
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        Kenny Ho <kenny.ho@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230524191955.252212-1-hamza.mahfooz@amd.com>
 <CADnq5_Mz6aPFYGnr8J8C8UeTpbo7JDg+uvjqAxo7o4vmTGej2A@mail.gmail.com>
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CADnq5_Mz6aPFYGnr8J8C8UeTpbo7JDg+uvjqAxo7o4vmTGej2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::16) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 95361d51-1f79-4e82-3927-08db5c8cfc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt/HOmtKn0YegPNf9Yex883mJ/FfWTZubbH6+gtldbtRbQTXR7290A5kd42yNrpnQAuQpUVcBAtbcw/ZkBYiNWyBU/40egQtxY9vkV6QZzFdjztbDgPRLuH4wULr7MypcLMLdjk8+bsRQZGRiHGuqpKQ4SGd++WMTNTXwfpzdS/p4DsoHzw+knmw5uXjJBlxFaapRRcsETtiOeOJhk5figZ6ofv5i7m9K9CJvCdYsHoUVVWTpv4taRazCD1H8XuG4syYJgdoOLF+yCLXnDOV/rwr92uLojNPS2eLBvHouD0vPUt6AitxjoU5HMuwwzFV1H+IMhHdyJUS797BiqN83KtUPxuRmiBOPHXU7TPVbeAYFUDKYv5o+qc0CbNMxqPB8A5LsOopIcMbwI7rEgYwOKRVzrkdTI9xRNPC6XqGvx7FPJOG597qdhKEM+/tujlHgMlC5MWGs621hOYwv/GhkzUc9DyQncxFFo3Lq32ecYLvCaqP470pPgygskWHsKjZpG0TNZi5g9LDLWKCovVI9XryzsXotpz+G+xdoLwiyQ3APKUU3WVziqF+I/TkHP6zPTUzq49Yo0mghei3quOv+DDYChhj3qh6ZMuX2eTnPAVqQ1T1To2BnqwRct4c+s+zoV/XWSzB+MOwMfwsOM/X7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(31686004)(54906003)(41300700001)(31696002)(86362001)(6486002)(478600001)(316002)(66556008)(6916009)(66476007)(4326008)(6666004)(66946007)(8936002)(5660300002)(8676002)(38100700002)(44832011)(6506007)(6512007)(26005)(186003)(53546011)(2906002)(83380400001)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZrL1BrMGVaanhPa1Z2SHVabnQ4OWd5MGJJM0Vzc1BqYXNzUVpUaFNBeXh4?=
 =?utf-8?B?QTNRUkVXMkNwcWNobVZIWWpOeUJ5Ykl0N0Vvd21VWHkyRVFUR3NSZHFqU2pO?=
 =?utf-8?B?TFlHakNjWkUrS1l1VkxiY2d6QStSVGt4bE1ZajRZNis3RHJzN0pPZmVCSlV4?=
 =?utf-8?B?OWsvNjUxTUJyaTkzazUrSHdIZnRqY1dxT2UwN09xOHVmRHJYMUdoaU1Yc2NJ?=
 =?utf-8?B?TmE3TkFQRDNtWTU2T1Q2VWo4dE1WcjNwUk9LaWdEUG1IR2lNYVJ0cTh5Qk9R?=
 =?utf-8?B?dVdXZ0NsRW03RmtqYkRlQU9RMnlaaHRPaW50Q2J6emN3enkyd0RNY3EyZHds?=
 =?utf-8?B?RDFYV2JONVh6WlI1bzdodDg5MXZaRmZsUDlvdmU4QWpJaHVXWENYdHpkYlJR?=
 =?utf-8?B?c0U2dnI3UlU1aWp3UkZYbEY0SDBEUExLOTFqOUljbjRpeUpxWnRHMm5SMWw3?=
 =?utf-8?B?WkFBUkhlcWhSSHNHb0FFVHBndGcvODlzOHRkTWFoMjc0R3ovWjJ0eHQ2VEJS?=
 =?utf-8?B?TUpMaUc4ZWtJZzBpbXd3VFRrRHpXY3huVzJ0MGMzR1pVNldtTTFIaWRubTZR?=
 =?utf-8?B?eXpaODU1L0xDdVFpOUJQK2pDSng1THI4TEFZTWJ3NWwyZ0srOGU2QzJ2UDRX?=
 =?utf-8?B?aWovaC9Gb2FmbGxQZFRtM09YSCtCazI0bHkxVGNOaFBXYmN3YWVnc0FTMjVE?=
 =?utf-8?B?Zk1DZFM1WVExNVZQR09vbmpwM2JkZnVqUUtRR0ZJUXFUU3VFWk9WT2JLUHNu?=
 =?utf-8?B?M2lkL0QwbkJZSTNrOGRyZzhsd1N5QndRc3BNL0dxeEd6eDE3YnFMVDlIRTgv?=
 =?utf-8?B?ZkdUZzVidU5tclJwM2poWDE3b2NMRHpPbUE2eHpnTHMwallDRGY3U0tkbHBp?=
 =?utf-8?B?RmdXRU9rbXlNSlRTclhqbXdhK3BGWmlRNkthZ2ZNZ25PSzFBS2dXenYzbnJC?=
 =?utf-8?B?R0Q5MVZKNVZhTEg0a0o1d2JIQkhEenJOQWdnWm1HZ2dlUFdidmdEVkYzRW9W?=
 =?utf-8?B?d1A4aWZSc0E2cEJtc1dQWUdSVjMrajBtRVJtUGdLbkkxRzB3SXZjOUd6ZGNp?=
 =?utf-8?B?WlN2RDFZekRBZU1XNW5pWTdnVWtNZ1B5dGR1N2RpMC9XdWdlNzJVdzJwSkFM?=
 =?utf-8?B?VVlidmkwMEt5VlZmMFlGMURnVDA3NEM3Z1FYM1lYcnlOV3pJNVVsYk1hRzlZ?=
 =?utf-8?B?ck9MT0VKK1FBeXk4YkxubFBPdDA4LzRnbEkzdk1FV3hlOHlUNTNDYVJnaDVs?=
 =?utf-8?B?eXp5S1RhMlMxREh5Q0pKQjdLdFBpbXJORGdQeC9NckR6R2NCM2xSYUI5YkRw?=
 =?utf-8?B?bm9xVmduYW0ybEZqNzhXRlFRQlIrdERUY1V3NGQrckZ6QXFXaWxlTVhoTmRQ?=
 =?utf-8?B?NTBQd1RtMWFtNHFvV1BXYmxXNmwzY2laN3hGTXhSaFpObnp5MjVFS3Y5RXlS?=
 =?utf-8?B?QkdsQ0k3TytIWGpPTFdrNUNsbUVxMmZ5b3pRV0V0TC9IazJ1SEFMU2FFanNy?=
 =?utf-8?B?Tm5JSEtVWU9ReFBZdXRYQ1p0clBIbCtOdWF5Z2p1OEZMdFBqZjhGQXBrcnVT?=
 =?utf-8?B?SnU5NVFZSWY3RXJsc3Jlem85VDJDL1phV2VTUTdIRTh0cjAwbVVFRUd2ejdK?=
 =?utf-8?B?M2EzVG81dXJpc3lrbFlKZy9WckVqT28zRUwzbUI5ZEloQWprMDR2ck1vRHFj?=
 =?utf-8?B?eTJqZnFXVVk3NXBzdDlPU3RIMHV5eUo2Y2h1eUNZeVdYMzdYWW5DOTVyUk1G?=
 =?utf-8?B?TFpORytwVUMzQWl3QUxVMUZVL3IzU0NMYkZHWXBJOUJ6d3U4azJXbm1ycGRK?=
 =?utf-8?B?TGJOVEw1WDlzZ3Jub3poazlyOVgyZ2hzcERPQzc2WWFzd0NsL3JiK0FMZDQr?=
 =?utf-8?B?RFk4c0Fobm9kSTlNT2RMU1B6NURiSnFVbDdTdnp0T0UrVldUOGF5SkFCZVMx?=
 =?utf-8?B?WUJmYjZPV0dFR1RCRTc5SnpsdFRvN3ZVaXVENllpMzNzMXpzNnBLa3lJMHQx?=
 =?utf-8?B?Y21hU1dsZTNtT2pWaWFFbWFwWlhDdnFTK29wT2pnbVhadFZDWmVoZnU2SmF3?=
 =?utf-8?B?L0VSR3hYOVRLZlB0SG5vSEJqUFluWGRkZE1IelJYMjl3S1FpU2p5YU4rL3RW?=
 =?utf-8?Q?rEGRWmHpKWUz4xN/17nheXB0u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95361d51-1f79-4e82-3927-08db5c8cfc1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 19:28:00.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02hgy0i4UKp3iaad1XvDSC9GfIoBoB59Sf2QVLi9uSnz0PDTkuF65Dn9vCMc1R5rojJoFKdzJTLDsT4MvxumIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 15:22, Alex Deucher wrote:
> On Wed, May 24, 2023 at 3:20 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>>
>> Currently, there are quite a number of issues that are quite easy for
>> the CI to catch, that slip through the cracks. Among them, there are
>> unused variable and indentation issues. Also, we should consider all
>> warnings to be compile errors, since the community will eventually end
>> up complaining about them. So, enable -Werror, -Wunused and
>> -Wmisleading-indentation for all kernel builds.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Kenny Ho <kenny.ho@amd.com>
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> ---
>> v2: fix grammatical error
>> ---
>>   drivers/gpu/drm/amd/display/Makefile | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
>> index 0d610cb376bb..3c44162ebe21 100644
>> --- a/drivers/gpu/drm/amd/display/Makefile
>> +++ b/drivers/gpu/drm/amd/display/Makefile
>> @@ -26,6 +26,8 @@
>>
>>   AMDDALPATH = $(RELATIVE_AMD_DISPLAY_PATH)
>>
>> +subdir-ccflags-y += -Werror -Wunused -Wmisleading-indentation
>> +
> 
> Care to enable this for the rest of amdgpu as well?  Or send out an
> additional patch to do that?  Either way:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

As far as I can tell, if `CONFIG_DRM_AMD_DC` is set it will run these
checks on at least the base driver code.

> 
> Alex
> 
>>   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
>>   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
>>   subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
>> --
>> 2.40.1
>>
-- 
Hamza

