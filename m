Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA66D5003
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjDCSHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDCSHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:07:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41AAD7;
        Mon,  3 Apr 2023 11:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqE8zsWzS7+cFxFrZiHktYX0fusFkNurrYnRpMSKoEAIPIk+2gS2IJVAefy0/bV2wFIqDAWeycuCp+MG/uz4xsCSsVJNrV++occtXhSA6UBtKE47Yx6eaR+ufYubBIY/FuRrSIbwYOgRNLDDjmbKzcxeY2QmPSCFKNIcgjZgEFJVDn8a4op9Bf9dWc6D1EP75SnrTLTH5zCaNqJ4lC82xtfxTjKVfHj+8m6Ls+wlHbzaOJ4rCaWfCDeYv46UqvE+MU9lKxjAXsZg7t8dR+7sGncg4yUHS3dW3nFM3XHysg+p35yGk4qiLTi26JCGHp12YGp5xa6rVD57+UpnzLwQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvPL0JEt002GeSUvHcTVkAolGmEAceHHm/hr/38Fxa8=;
 b=mNrXeBp6hraVoDSM+mOwB/OrtsUP1WUfqM3gKXPa6RapYR0jI4whTagyMXQUieLZzdv1ZsL2it/Rf/d7SXNXiYn/4876BQk68RwFV/HaJKcJ4ySxYSzT6j7/CmFymJkjOx23Nphwo9/3OCG8ooubOXVpOJ9Z7QBWWxu3SVDn2Hmk4uFuauzYMhAaTLM2rVxePXZP2KDyb4Bv4mNRmv0W9JwihVcOcSvoHZcH6zMk1e8dsg1WphWDorODjKsR+ItKOxssXZGb5zhETQCU7pTTwUE+1VB8gX5hHa/cpBSL06ZsOcBQYRpRxHMOL2XuhEvg+s+9A8D6x2xpgu55sZJzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvPL0JEt002GeSUvHcTVkAolGmEAceHHm/hr/38Fxa8=;
 b=P4ANY24U4Xa4ZjcRss1ivHV3gG0WiZtIUiABy1p4goxPl4Aelp+nHAaLXXbBIhwIgXu5K2Lz4nM1hvpfxB1dMtEUapyZ8QkxFEtTbxlsWlU3HL53y+C36tGAWBxT0IYxiZAGwNsSwFwVI2H4Rqg+xZlb7JRnflfPGg3KbnrSab0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 18:07:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 18:07:46 +0000
Message-ID: <3f7ec97b-5fa6-9c54-b4b2-58ebf4f88449@amd.com>
Date:   Mon, 3 Apr 2023 13:07:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Content-Language: en-US
To:     "Box, David E" <david.e.box@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
 <20230330194439.14361-5-mario.limonciello@amd.com>
 <CAJZ5v0jabz27wk-g=iZRSnpUCmWimfjSUZO+iuNeRbuzPxW=DA@mail.gmail.com>
 <59127d2ac2e60d59b5711517eb049eee334a3cdd.camel@intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <59127d2ac2e60d59b5711517eb049eee334a3cdd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 653f0fe4-84da-4d7f-ad4f-08db346e53f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfC42eatmfMxvkFBD/VVpcn1aD3WBRwpCgw9CE+xr6/fdvM0TPKM3YBb0hAmIIpw4E5rXc/4TXryFaI5NwEnzxyJ6TXB0HXoNrX/Mfldb2B7FSeGiAufas5ZEmq1ChGz1GW7RqMZ2sd1agX2pOhSXLvYG0qZAuSm41IG3RHuTzBWKZpfiPARXGoiMHMyMF1y2Jj51xekL4TlVZ6Pnm2XZapBcnOiGQFwec3rDqobvCS2mkoIPw39n7w7tOXMq1bW6fWXK6XlbQIgyfttDZvtoRB2BluZXQ5hhy7XZ0seKTodQ3kPHAiYiqJYbjp4AsdBYxz6Z4yxx7IT96bqUSpDMhE1rezlS0IGUjEv9P53xPkoei15AkCF8JMeAJkZSCQD2YmXsCpgSu2YzLqqLDwf8jhaiUWbKXfDU/9pFjheV6fe+MmqB6ox4TwSoWOdr5l/pUsf0UK0OSmXgfXGzFox5qKx7UiOTxTjeL2v4yO16S3KorJGRc7f3OAAwvkVccusJutnYPgcPzErFX+H38bD9IrMO000FD5JAwhFb5bIy99aaWRE5eIjjZaWKns0xbv90kHVfBrObE/w0pc2HpEaOG4RakbG9vYfdv6rX1ZW16Hrctjagnh35bhVfxHQZLKJUfEFLaJbwVGvLk9MEynQlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(41300700001)(8676002)(66556008)(66476007)(66946007)(110136005)(54906003)(316002)(478600001)(4326008)(8936002)(7416002)(5660300002)(38100700002)(53546011)(6486002)(186003)(83380400001)(2616005)(6506007)(6666004)(26005)(6512007)(86362001)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZFVVNsTk5uZFluMHhvaUdCZE81NE5IMDZEdFAxRkZjUm1aOFV4SHlNbU0x?=
 =?utf-8?B?K0FldWY1ZzdqY3dveDlqNlkzRFBjWlRFSlp3UENjYmhVT1Y0eVpGc0tlcXFR?=
 =?utf-8?B?NkI0VGZ4V25uVEJjZ1hpeUNSZk1kcVpyV3BXMVkyeE0wUzdRQ09kanpPMlpr?=
 =?utf-8?B?eWxMVlVoUXhOMmlxdGlWWjZFelg1Rmc4eGxRclFVeWhGZlVzcFhKNmdXK1BN?=
 =?utf-8?B?Qnh6dXUzNFMyZ0xmSEliSGZ1QlhqTFZzcXloa3k0THd2OW9FdGFIdFFXbDBO?=
 =?utf-8?B?cWszc2U2TU1zb0prQWpubEpJQ0hNNC9lM0Y5SEgwMGJvOW5kQ2xhWDNndWdk?=
 =?utf-8?B?Tzd0d05sdFRVRmhHUnpWOHVZQWxZd0M4YXBNaXZOREd3RjlXV3hzd05Ma2Vr?=
 =?utf-8?B?elNCbnJrRGtySDcxeVFDTkFyd3o3RE02YjcydXhBdk0yTTNsSDdBM01DbzZV?=
 =?utf-8?B?RHVqbFdpOXpmUWdzMmY2QnU5VmtpOWovQmFpN0J0Z3VQMmRJSHNnaWJ3K2dK?=
 =?utf-8?B?dittMktLY242c0hhdnNWOUVLMk9oZkNuNGNSWWdERTBGeWN0OTZkQ205dDBq?=
 =?utf-8?B?bXhlZGU4Q3NLQldRV0thWlYzL0NPN05yUU56Tys3NzhwRmhxSGVkQ1JJKzRE?=
 =?utf-8?B?UGhxRkRqQlVjU3didlpMcFYvKzkyM1hZQjJmdkQycUVlSmdjQWtRTGkxOVcr?=
 =?utf-8?B?OG11bER5Z0dtaEtmQ2tvK0JrRlMzSStnRmlYYW1WSW9heS9obkxDUnJMeVBp?=
 =?utf-8?B?eVZaeUdVTlRHQlI1aTVTc0I0eW9HSXpaZXNwR0F5elBtYWZmWTRUQ01pRW9H?=
 =?utf-8?B?RGFyMTQxdWZlREgrUEthRk1aZm5kUUZuM2xrcDEyRGtMcmwzWW40aUhFaVhl?=
 =?utf-8?B?ekUxSXpHYWZTaXVVMzZFOWJab0h6ajY5TmJPUEdPVFR5dVpCTzNWQVVaL1h6?=
 =?utf-8?B?MnhrbVBQdk16cUVldE1TZFJEZ3IrVmJqdUNtN09IRGR5eFh4U3lvZFFHdEIv?=
 =?utf-8?B?THBScThZUVN2dVdNV2NFeDhyWlR2YU9kNU9BSlFJc1RsQ0RPNDVCMnlsMWhD?=
 =?utf-8?B?QVMrYTJvYUV2Q2FOckZNZFNFakpyQThIREJ0dGRONjkvUGxCVUVoTmpZTlF3?=
 =?utf-8?B?VUsyb2JnbmFDVk05MTJXSktySjNBV3F2Zi93ZGZKNGtLNmJnTHFuUm9jQmhY?=
 =?utf-8?B?VW1FSGlOUCt1M1l2aHZJZ1pnckt6cXRiMHhUWGZ0Y0plZVVCTFF0d3RiS0V1?=
 =?utf-8?B?S1hVRXNUa0VabTZTQW9HbDZSLzZSWlhaRm80VFV1S1VnSTFqWGxSZElOVjF3?=
 =?utf-8?B?Y01Cb1lmM0QyMUlLajVuaVVNMVJDYUtHaUN5VVVsM0R4dkk5R3QzUVp5emVy?=
 =?utf-8?B?Z3BMb21iVFJtdFlPKzdaNjUzWUhJK3BuS3BvWWNvTC9YVHdXTGVuV3lTeWw3?=
 =?utf-8?B?UFRSU1B6Qkl2ZDV2NDZSRW5VRVhmUkRyeGVuWlNvbVUzWUpaNVVVeVU0Z212?=
 =?utf-8?B?WXY5ZnhDSERYWk8rWHhqQXdzZE1aR1hJRHVEY25MRllhYXZCZjkyZDd6c3lK?=
 =?utf-8?B?UHh2YTB5VVRFU2d1cEN3UGFLcWticFV2Z3ZOMkdRRFRibXc5ODh2NHJDNFpJ?=
 =?utf-8?B?eUJiM0RXMWI2TTNUTUphdThPZk13MHh2ZnkyNXBwTmJlSjlseUEwR2o5a0t5?=
 =?utf-8?B?YVo4VFQyQ0x1MVVkNi9jazRmdXZ6WkI3VGQ0Z2x2SVpzakxDeVk1aFA2SXp2?=
 =?utf-8?B?bkk5MS9YN0Noa2ZkSFI0TmdwZWgxQ1FRN3d5c1FFMFVRS0VSNDIySkZwK2F3?=
 =?utf-8?B?aXQ0NDJqZ3BOMmtkQlAvSGEyekRFYm9QcjdKbEZmbzFPd3VTd014YXNPcDdw?=
 =?utf-8?B?ZmhqR0d3aGRhTVplSWpBdldqOFcvdjBoQ1RoU1NrQVFpN0c0a0g2YXRvai9N?=
 =?utf-8?B?V0dNbk9uSUNKNHJ2bEhnSzFDSDcrSnNFZ3dIa1kycmFCcW5XRGUrZWxyTkpF?=
 =?utf-8?B?MzFtNE10MXNwNjdtNHlxSnl0NWhDVmxBbmpwZWlDYkxoSXJQZkcwTTFKdGVr?=
 =?utf-8?B?K0dCTTl4dUIzbUc5elQ1QmMrU1RTOTdEdnBEUFFQVVE3bVc5SWZGMFJvVlBC?=
 =?utf-8?Q?ZmUx0OooKyZNGV1WqbDUDQO/P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653f0fe4-84da-4d7f-ad4f-08db346e53f7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 18:07:46.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh7u6ugrV4lu24bqMnygPv1Y3cUMYYEL5SMPgIqKcFBP/gChtupe1RuTSLzDC5B/IeygEPhXHWwJGli3iwuQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2023 13:00, Box, David E wrote:
> On Fri, 2023-03-31 at 20:05 +0200, Rafael J. Wysocki wrote:
>> On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> intel_pmc_core displays a warning when the module parameter
>>> `warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
>>> state.
>>>
>>> Report this to the standard kernel reporting infrastructure so that
>>> userspace software can query after the suspend cycle is done.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v4->v5:
>>>   * Reword commit message
>>> ---
>>>   drivers/platform/x86/intel/pmc/core.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/intel/pmc/core.c
>>> b/drivers/platform/x86/intel/pmc/core.c
>>> index e2f171fac094..980af32dd48a 100644
>>> --- a/drivers/platform/x86/intel/pmc/core.c
>>> +++ b/drivers/platform/x86/intel/pmc/core.c
>>> @@ -1203,6 +1203,8 @@ static inline bool pmc_core_is_s0ix_failed(struct
>>> pmc_dev *pmcdev)
>>>          if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
>>>                  return false;
>>>
>>> +       pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
>>> +
>>
>> Maybe check if this is really accumulating?  In case of a counter
>> overflow, for instance?
> 
> Overflow is likely on some systems. The counter is only 32-bit and at our
> smallest granularity of 30.5us per tick it could overflow after a day and a half
> of s0ix time, though most of our systems have a higher granularity that puts
> them around 6 days.
> 
> This brings up an issue that the attribute cannot be trusted if the system is
> suspended for longer than the maximum hardware counter time. Should be noted in
> the Documentation.

I think it would be rather confusing for userspace having to account for 
this and it's better to abstract it in the kernel.

How can you discover the granularity a system can support?
How would you know overflow actually happened?  Is there a bit somewhere 
else that could tell you?

In terms of ABI how about when we know overflow occurred and userspace 
reads the sysfs file we return -EOVERFLOW instead of a potentially bad 
value?

