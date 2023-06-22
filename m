Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86FC73A9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFVUoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:44:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F778199D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcva9ZNgPzAkoPB9m1peP0lqsxbn3XsFukYCcObUZ2iW3bljm53CS37SI5QzFejRdBDbMz9WfCQRWqm4p1LcUpMfUmvg5cmUGYfzbtaxdilyXnxvw92KcSS1o0MysKjgv+DS3hbjSGRqHwmZd82qjQz3Q4fkmdrJsaOao68OJVftDH6kPfL8Swf+2afztmCoGkShiuvVOLToX1X8LtFH1CJhP0s6awzP3hknLPZKK5kkAJ83sn79RHO9NuItrLaBKbPJUZmY1rdT8RO0MXCFL1VxqWfcM1f1E5AkHY9VRKdHEGgl6jK3HlP/YX0qrOUdWCSEHvQMSFiTGXYawdUopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFbgtwLPJbVI6RxhYcWw3437u8KDmznVDBno+9GEHDY=;
 b=EJiEqB8MWrFTuam4/cY8EqSIPvsocGXNtuheXoPpyb2YMc56bka9IzvI9ldyZRlulpQ7bT13PfbGHEPD3zCTMk4XqipDLPDhRFPl6sMKJWZTdmiw+jXg7Rjgv5kzjgkGLuSNfQ1exa7x9rplLCL7Ljyj/nv3RWje7+v4zpodiytOrS66x6ldybRFjOatOXPzFHccWmyzEIW3GtIzoiLec6pqxiHQKMKSF3uuuHs+D7onFhR9WrBDfItClk5SAnWO5DE5k68qFWAMEw6VfGxeYrpNBU/nnHuAEpU4DQUtRw9rvjUJxBmL1qkac0W27prnfEVU/0qQol1Q9sTb/sGLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFbgtwLPJbVI6RxhYcWw3437u8KDmznVDBno+9GEHDY=;
 b=SltY3kW8eRTiENEU+fKlq0AUWJVLBwSPt2GMBj5OQKoMq2FuWG2scrK1hHrFKjy1L031csho0+gSQhCFmdE/gSqXqGqPYPMQ7JyXm6+LvRedqV0FcZSEflQp6VsKn+Xqxj0QDeSBu7Wpht+hAtB3Q2JMVXICiezu89NwmL72TAgiFxn9FcfaOAwObSJt6FbUOK1tXgkvwwjoxTeha8xcfJCJw2jT/e0XjUdeRWqv92UBe4oblRWUw4HRgr0Y3d4XAMMCp2lDZ1JKmdPLAeOTdNi8fkdd+ZpiXEZJ8xN8zDR1KJGmfpI2JgDOA9sP2YGB3y2LYjV/iPJrhlx0pqHiGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:44:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 20:44:39 +0000
Message-ID: <8318ced2-9a4a-c0f3-f4ca-f56bf8beaa20@siemens.com>
Date:   Thu, 22 Jun 2023 22:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Content-Language: en-US
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
 <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
 <65d010fa-c801-eb4f-352f-8bfb52a67c85@siemens.com> <ZJSbE/82z+319sTL@hera>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZJSbE/82z+319sTL@hera>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 4865e8f2-ee7d-4eea-678d-08db73617f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPyNmN3dVglXMi4qhuSzqAiRWrlO644RPpVgK6mYJiDEKxe5AcFirbqX2c5OmZNocaFLo7nloItx/traPG7vowjpUoK6SOznQG5T9+N9M/kzDAhTnmT0p1S/fC5iRKWSL5KnHfLGFt3qMaAZbldP3i7Y0OXl/uFr0aYYBSNEi2+PY7FkTxR73Iph8nwF9DWBlJUBfrmahfDiv0YHPPG2b39qn1DGHJJ47pGrGKmd443Fg38rfY8QeuaXzX7TrU2WV5njw9zL2JK26uxozkOM0sG5gq681kIy/RrQ2psYudlPUl7ujz3TkwBq+rxpal7sJgW6vtb6h3zDSHUOGp1pMw0KvEX30gImEscEpK9lUpRWrwTd34lcQVrKpFXNr8TxLUrWRgYGkQCsTZb9AhvYrFC4UeZ+3GBk2kIaxE9Dbww61YkFjubIQod2HWRMhtgOyOXWc1gJdRh7aW4JCPJSQ5Dl/tI6MeoeOIjVeH2JoZNkKU+8ODAmUAwDnQzqFnCpi2uTLNKTG81iM0VuO+x3pGQ7oLZF7LF4Dc/c8w2yDJT7bTePXy+srQddguXSPx26cFQLOiz7VEOGc9W+mVUeW1bQIEnP0y9+uj23Cp2lk6DkBhJbk08y+UC7DN5KAgz7LhQunyzi4TnDwTrxyqSOuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(82960400001)(6512007)(186003)(38100700002)(53546011)(6506007)(2616005)(66899021)(83380400001)(54906003)(66946007)(2906002)(478600001)(66476007)(44832011)(5660300002)(86362001)(66556008)(6916009)(8676002)(4326008)(316002)(26005)(31696002)(8936002)(31686004)(41300700001)(966005)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUplNE1qaVFCeXE5bTNXbDBybWdqbzQxOUVwUFVlWGIrZjVNN2dObmQ3SHhy?=
 =?utf-8?B?ZGtMemUvRmJSOGx6YzJ5WStUQ0FoNlRLckxZVjlxZE1yZ3ZLM29HT09ZWDBY?=
 =?utf-8?B?Q1EwZCtRalhKeG9ZVGxzd2FidkdaQUtHVzRoZWJOL3lPZStxWmwvL2p6NWJy?=
 =?utf-8?B?NjZBcitqYUlKbUkycmNINWxhdjE4Q0ZjR0dWQXlIRGhnVSthVkU5bFV1SVl6?=
 =?utf-8?B?UytFa0dkQ1U5RWxjcUpZMkxhQXJTU3VKL1BDd2Q0eFprLzNuMDF2VFMvVzlu?=
 =?utf-8?B?QVNVNHF4Zkl1T2IzZktQaVRzaXkrZGF2c2VtWkwxZDB3ci9BTFpsMnpNY1F0?=
 =?utf-8?B?dm9aK3RraE1IZDYvMm95YzRldHlHekhtN0NXRU5LK0xSZzUzZlNaaFJ5Q2pv?=
 =?utf-8?B?MEZBcXMyRyszQnJzL3dNb0RQeXhGcWZQTG9aenJGU1UzeUEyNFZoYzFWaWNO?=
 =?utf-8?B?cjhqMGsvMWFkQTQrSHNXUkNJMVNMdTBFR3pTTVVjTkhza3o3U3R0RDNyRkk5?=
 =?utf-8?B?dDFWRDZoSXhDMk1hbkJFUHd5OEpVbGRQNFozTGI2eFh4NjJzckY4enBueDdW?=
 =?utf-8?B?UTJ0dDNhOVBjcnFjcGFBaVYzakJCWGVDd3dWeFpIdSsyWkVwZDdld2ppcFhK?=
 =?utf-8?B?OS81TjRHMWEzM3R0KzllQ3R0dXZUVFMxU1VjQW5mRmVoMDIxcG54cm05dnlK?=
 =?utf-8?B?ejQ5VkdWb1ZzMk9XYUE0RGR3OXQ4UGJ1bXE3SkNuTUFhc0FoQ2dPTGg2ZGxy?=
 =?utf-8?B?RzhxbDJvVEUyWDNqUG5tc1ZBa3ZNWUQzUWh3R3JYNTlaVEdDTHR1Q1p2RGRD?=
 =?utf-8?B?UFFTRThiUWtFaHBoRW9MVkU3ejJPNFZBaW9wTE9Jb1VtTjJISXVGZ203TWhZ?=
 =?utf-8?B?OHUzZFMvWXNDNHRNQXpvRFp5VWtmVnhrd3VHcG1TbVozRXVWRWlXek8rdVVT?=
 =?utf-8?B?NHMrVzV5WmJ4SFY3MmVDWmlmb2xZOEQ0UFl5bTE4d2s4RGk1aEYrYmNhQUIz?=
 =?utf-8?B?T21VeWZzUWcwbTdDUlo5aUgwRXRnaGJaT0JtUm1lQ1BvK3NMZ1lBbms4REZK?=
 =?utf-8?B?dXNid0x6cDJZNjhXcC84RzdudWRKdUhnL3o0a3MrbVEvWjgzRVdJZXc0ak9L?=
 =?utf-8?B?MDFtVUc0WGZ4TWExcFp5RGhuT0V6V0lNQnRLN0xJT3lJUXVyRC9rOWJSeS8x?=
 =?utf-8?B?S3JjdWZzK09pNkJXdk92dG1YcWdvSTVKMERyOXUzM3pwSWVwT3dpQythdWRK?=
 =?utf-8?B?SlRubHVNa0JudVp1cjVqazlVQ011V25SSnlCMTFham4yZlRKMVpDUkx0SkRn?=
 =?utf-8?B?ZXE0U21QZ2dVRnc2QTlRcU9TMDE2WjBudUI2OC9XZkNqYVpPVnNtNHcrYThI?=
 =?utf-8?B?WWgzWjkvbTNKaHNRR2lsVXFjV2lFUnZtWmV4KzV5UlVhUk1EWkltTDZYSTdr?=
 =?utf-8?B?dFF6b2VwTEtzUXp6cVJBNVZETmRpYTlaOTBoU3d5dUJXa2thTkY2UUdrcy9j?=
 =?utf-8?B?cnBDOUI3NDU3Z0FWempSSzhoWTNVYU5aR0xNMmtMZ1d3NGpKRU43UXFJWEZV?=
 =?utf-8?B?cGFmMUNXampKSVpMWWdjZTVOSWpMWXlBVDFSd3duSFZ0eVMxL2R2SHMxSTNY?=
 =?utf-8?B?djk4WjdoU205Ym5DUG1ycG15QVViQzRiaVZ2cjg1a25LdlMyYnBxYXNyR1cx?=
 =?utf-8?B?SmlRbEU3Vmh2RVdjOGFFZDFBWGVVWSs1V3FXWGtIQ2ptbHQrNjZQeTBlL2Ni?=
 =?utf-8?B?RHJ5c05oZHdNcktPeHZzbGtrUFhBa2FFSm81K0VJNWYweXVIZHBXSGdpSWdp?=
 =?utf-8?B?UlJtSFBQY1g2Nm84MDJqZER0OGgwR2J6K0RiWUJqSGRMNEdzZkh0YXV4Kzd6?=
 =?utf-8?B?WGtYRFgwNldCQ3ZpUnhKQ01vejEzd3hReC9VUU9QamdMdDBtQkhnL0NpZldm?=
 =?utf-8?B?cnozSGxVN2JJS3pSSTBIWEFzSHpIczR3eHNoL3RFcTB4Mzl2RHpLc3M2VUw3?=
 =?utf-8?B?eHY5TE9qd1dURmVrRnBuZ1duTXZJZHhuV2F5NldxenhGN1ZGeGhqT1ZpSFAz?=
 =?utf-8?B?Z3ZDc1A2WGxIQ3RqVytvWCtaaWlRL2dLdWpuM1pXSTIrL0JvaHhaK29OakN5?=
 =?utf-8?B?UVc4Q1p0SUpUYVBnaUh3ZS9QTFpCU1BIUzJBUk5MR3RPQW1aOGVpekNOTHl4?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4865e8f2-ee7d-4eea-678d-08db73617f96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:44:39.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFKyh3/2FReOvLVMlcz+nk4nRktiHTbXdQu/4kXMzZT6qFG4uhkKQFQMeCTP77+09HtQhNVKVdZAD+9mWEekDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8275
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.23 21:03, Ilias Apalodimas wrote:
> On Thu, Jun 22, 2023 at 08:32:44PM +0200, Jan Kiszka wrote:
>> On 22.06.23 17:04, Ilias Apalodimas wrote:
>>> Hi Jan,
>>>
>>> On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 22.06.23 10:51, Masahisa Kojima wrote:
>>>>> This series introduces the tee based EFI Runtime Variable Service.
>>>>>
>>>>> The eMMC device is typically owned by the non-secure world(linux in
>>>>> this case). There is an existing solution utilizing eMMC RPMB partition
>>>>> for EFI Variables, it is implemented by interacting with
>>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>>>>> and tee-supplicant. The last piece is the tee-based variable access
>>>>> driver to interact with OP-TEE and StandaloneMM.
>>>>>
>>>>> Changelog:
>>>>> v5 -> v6
>>>>> - new patch #4 is added in this series, #1-#3 patches are unchanged.
>>>>>   automatically update super block flag when the efivarops support
>>>>>   SetVariable runtime service, so that user does not need to manually
>>>>>   remount the efivarfs as RW.
>>>>
>>>> But that is not yet resolving the architectural problem with that
>>>> userspace daemon dependency. What are the next steps for that now?
>>>
>>> We are trying to find some cycles to work on that, however, I don't
>>> have a time estimate on that.  But the question is different here.
>>> Since this addresses the problems distros have wrt to SetVariableRT
>>> (even for a limited set of platforms) are we ok pulling this in?  I
>>> can't think of a technical reason we shouldn't.  The supplicant
>>> limitations are known and the firrmwareTPM has a similar set of
>>> problems.
>>
>> It will not change we have to do on the distro side because we have to
>> deal not only with the startup issue and StMM but also with fTPM and
>> with shutdown. Only an in-kernel supplicant for RPMB would resolve that
>> according to my understanding.
>>
> 
> Exactly and it's worth noting that even that will come with some minor
> limitations.  E.g the randomseed variables set by the efistub currently
> won't be supported as the modules will come alive way later.  But it's all
> reasonable compromises for hardware that wasn't designed to have a
> dedicated storage in the secure world and support runtime variables sanely.

My feeling is that such simpler setups will be the minority, simply
because eMMCs with RPMBs are standardized, often included anyway, so
come "for free".

> 
>> But the question is fair if we can evolve from this stage here to an
>> in-kernel approach without causing breakages or other headache to
>> distros adopting it (too early). That's why I asked for the roadmap.
> 
> Exactly and this is my point as well.  I can't see a technical difference
> other than 'you won't need to launch the supplicant'.  The only thing we
> need to keep in mind is introduce the fallback between the supplicant and
> the (future) kernel supplicant gracefully.  People might still need to run
> the supplicant for other reasons.  But if we design it with the kernel
> module taking precedence over the supplicant we should be fine.
> 
> So since we lived with it a for a few years, I suggest we let it soak a bit
> and get tested while we try to move the supplicant bits needed over to the
> kernel. In the meantime patch #4 needs some adjustments, so I'll rethink
> the supplicant vs kernel module scenario in case I missed something.

Were there distros adopting all this already? I thought this was a
privilege of custom integrations where you can evolve things simply in
lock-step? At least Debian wasn't considering all these dependencies
yet, even though now providing tee-supplicant. We are patching it for
now [1].

Jan

[1]
https://github.com/BaochengSu/isar/commit/d7646e3bb9d882b26eaf2517fece624010cdd46e

-- 
Siemens AG, Technology
Competence Center Embedded Linux

