Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07CA62D814
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiKQKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiKQKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:34:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BDD25E9D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:34:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjlaeUGWwceBTsdaV2j9aNqWvpEPZokGRQ2vhPcMvpZLBUaf4/nBumuslTl/+ksQATpLIQ6qltTQs4RXf0gXyN80piLUM0mCjR6L81OsA3BMgVDE5yT+8mu6vrbN3X11KAhlyn3Fe/sN1amQeRpU7Xy5euzs6dBbPdp96oS0JEZgBNi8a8F+yrgkDn2I9v8/BznRL7K7x1p6L8qzrhsmxF5lx5bW44aw63ZtjA85uR+ikyD5I0wWoplnKakL53S/WutpIbc5ThX73fRr1nHY0U1PEzllAt9aHdqelJMACtCbeOpzty1eJU0VLr7Sblgj3ci+YZx2gj3KwgrNV/SbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHSVX2ie/9vwi1z80vGYmYZO8wq9Do9goxl0davajK8=;
 b=lorxYMtgfoKKb3bya6+WwdGotKcMteVBo9hvjPMaveqL9ov68e3Xn/ZvKIwi4B5zBPL9hZveVnqnCGXX7YLRVIPLQVYnq8GfwV2ecPL5GXsl81QduzxHf+Jf7D9RvvjgE+gj5H5kkzDvAa/Lyb4p2QbiXKwRgBO5al2tfAyx/iieeI91utRmhzXMn+9UPFp5VFHNoECkCwKdzue87ksfLK+SiLNhEIKGixqMfWEcNrcvv7BZ0Aj7zzWJQqXDJodPPyHLchvd1kWMNvyqqTcE+2qa/nvQpUFlyIEOqaHVOH/LKtC2EOFWREBReo4qMEBBuoQFMrrVzEc/KhhWk+tMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHSVX2ie/9vwi1z80vGYmYZO8wq9Do9goxl0davajK8=;
 b=1jtYm+f0iL5KFsB8XcBKqV4R57u5tLjvbVzFOpaxlTi/Ssc/MNd39NIVg48OEW/K1+FMUg6wkkd36g5tulbhd7d1weQmwx4FKd0EYNGlwKWL8WDpFXP2vydPt4hssmXD7VVGRd/pSiTtV9PqJq7zLh1PTQs3cRXeEnghfnjrZQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 10:34:07 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 10:34:07 +0000
Message-ID: <7bf54a3f-07f7-5471-f6c2-88d3d9bc7a5e@amd.com>
Date:   Thu, 17 Nov 2022 16:03:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
 <700710fc-1ac1-1b39-0e63-eb86adb4b984@amd.com> <Y3Vkmvi2vib7fwHn@zn.tnic>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y3Vkmvi2vib7fwHn@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a3e329-4258-48ad-8136-08dac88740b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gU5O2Ouo8fZnhQQqpa4prQHzoLomDkfEMurOOaLPD1YjSNNui8/ixJlpsqekxAhvcJaZfGyvnrNYse9xVWA5qBENefq4hwGn+po/pnyYYiiOgG9qkOPv8B08r5xO5E6icyVl0As8NjHVDTlS3TIs6cFB1DzDeNwc8qS5xmmo/vvVM095jhbv21Qfz11SCrpPEoOvqm2mPgpj5RuPvKHnP3pJeXggMSfz1cClX8acetw+tGtnOukoZAC49lbDGyeiBVt1MHIaFXvGzmIK+12f2RoDqJOANY72x18LIVj3+pof7HbuZRiEoBp9yfHZcI6FjhPtDVQzutAYmZZDSInDc0VkLuI+Z3ivCae4hzswnBJQc5a6cymq5KpLY+X9wxTEr8/ns6eSbQlex4bKI6+jij1oWlbXSl3LE5bwHTNavyh4Sx17e9vE322/fW5ODOq3dZeLUobJslShjBdmegusjJWBAEPMp/w8nAPrGvgpR/dpVVdP9wHImOXDQFk1APY41fJhGgBzTO+/ET40yPGVvOD5zjWAgjgH2Havl3hqznPqZDLwu/GrBVaTi7yJ971357ufAK0ebD8/F0Sw5Z7IVZzOIKiLFfhdwfI+RWq2TUBtjoUUqSbCpNqrA4BzhwvgSXgTPczLVRgpWqNk6n0C/nMy4X5UJcFKWyTV26uJ405oMnYYMyF69vqR3B9H+2+DZxEtsnvC1e+Da+W+GYn1MgJjpjvePHYDaztVbgwhXHmKwezNunnpqLGKT45alpK2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(478600001)(6666004)(6486002)(54906003)(186003)(6916009)(966005)(31686004)(2616005)(8936002)(316002)(6506007)(41300700001)(36756003)(53546011)(2906002)(44832011)(6512007)(5660300002)(26005)(4326008)(66556008)(66476007)(8676002)(66946007)(38100700002)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpJNUNHUWtsZXdTNWRMd2ZMY1I0M2pBcEY4UmF4OFZmemZ4T3ZWZDRKRG94?=
 =?utf-8?B?SzBlTVRrSFZjQ2ZrUWlCZ3lvL015eUIxZGtwcHEyUy9nRFNzWFVvVWR0RDRu?=
 =?utf-8?B?YXFiZW10Q0dsTGtsU3RrQ0hobjJVbXFzcXVxR3dORE9ZVElxQm1xdHFuNXMr?=
 =?utf-8?B?MW5SS2VPTWJwZ1F1YVJDOVgvWk5OWUpLeDVSN0RlNE9hL1h6TG9aUWVFc1g5?=
 =?utf-8?B?V0V4R2FSMGhmRFJoVlNXaXNnQXZlb0hpdklkVVFIc3BrUXhody8rRlhpY2Z3?=
 =?utf-8?B?blJOb0ZQSHoyTjdCdGhIdFJxMUhBSkFHeVlETW9VZEtuS1FwaTFDQytCS3dQ?=
 =?utf-8?B?dWZQME5PZ3NhRnNIUUI3K0VIRVQyNkRyVkNkZ3cwTi9vSGlrclFMcEYzTk9E?=
 =?utf-8?B?YmJlVnpZSkpCRWpKWnVWd2Z1UVlRZlFRZU1nTE9aRDVwS044dG1HR1BxWW5L?=
 =?utf-8?B?WlZsdk1YRzkwd2c2VU9sUDlINU1QWWE3Yjd5djlPRGQrbVhRVlA2Q25VWjJu?=
 =?utf-8?B?S0RBdWtudEJxalArOTM4Vjl0cUZuQWtDRGYwOWZHN28ybVRDZzFNVXA1OERO?=
 =?utf-8?B?RTJMZ0pVc3hBWEpqVXFxcEo5S3lTUGNGWWR1STZDSEpJbDRhd3VtY2pEZ0RN?=
 =?utf-8?B?K1BtLzRJWmQxd3YyYytuRmd1SldvZ1VVMEo0RkVHQUxvdDZpbFpVajdxZ3E1?=
 =?utf-8?B?OU9CRjN3Rzh5eTVtZXRaQ3JWTG1uVWpOelhQUnJBeUI1VlVjS2RnVnd4TWlW?=
 =?utf-8?B?d0FkMXBKU08yMnh1TzU0bVFaMUhxMWZ2a05YZTRDMWFaSE9oWElpei81YkhG?=
 =?utf-8?B?RTRON3FyL0MyY1lhOFF4a3lzQk43NlFSMkc0bTd1eHRWczBLT0NNUTZWakJ0?=
 =?utf-8?B?bDJJTHVvQ21oNGJ0ZTlsSWlZeGJxR2Q2QjI5SDdIajhjZWNxZEhkUXRrbEdp?=
 =?utf-8?B?VDBhc1krdmp0RWtjT1BBTjdXeHh5Rkd1OFZ5ZjF4RFpzUWpNbUg1V2hxeGRa?=
 =?utf-8?B?aXdzT3dKbU5WZEtVamdjU3Fsbmt5b0w5YSt6WlFHanFWMStHSHI1aStQRkFj?=
 =?utf-8?B?V2UrRkIwbjhOajhNS0VvNXNVN01RUjVQYkJNN1hkbEZPeFdaOSthSXRGeUNZ?=
 =?utf-8?B?QjVRYTZnZlcySWlycmtiUmpFdE5qRXNpZ1BYNWhnQ1lHaDdhckNqb0hHai9N?=
 =?utf-8?B?VDBUMGt5NDNGc2RjVnBuNm1NYXBmWW5IOCsyem9TRGEwQnZGeFd1K2FtaE5G?=
 =?utf-8?B?OTFSUlk5S1hIQXVMdVZLY3p5OGdOdUU0alYwa3U1WDI1K3dtMmg1SkpMVmJi?=
 =?utf-8?B?dHZqQ3RFUkluVGsySERlQjNCbXNrbE51TGdxYy80c29VaFdsUzhYRzQ3V3U4?=
 =?utf-8?B?OUQ5dVlRWm5qMDM2dkVXWFRScXpCd3Q2N09hcC8wY2FaSFNuZk1LcVhJb2pk?=
 =?utf-8?B?UEROY1pVV2VqOUNGSmIzNE0zV2RxODR6UzgrVXY2dWNvY201M0xqSEMza2lW?=
 =?utf-8?B?T1JQK3F6VHBOK3FkY0pQakRTbEt2TWxXa3p5cDBtT252K0xidHlCTzRUVE92?=
 =?utf-8?B?cGRWWFJ3a1pvcG9PcG8vVWVacnVTYzhRRmhKY3IxZmIrT0w2Mmlhd21nMnIx?=
 =?utf-8?B?eDVhSkw5dnFsdE82VUtoemdKbjg5dWY5ZmQ1Qjc5VEVyQzRTempnb1dwOWta?=
 =?utf-8?B?dzFhM1Q1VmtTclNBa0d6MFhqMDdCeFU0TWJEZFAwNjVnU1NUWXdJdTdsaHR0?=
 =?utf-8?B?U1I1ZUpvU1lpOUtZei9jYnRidWlJNWVFSm5RYzl3MDJxRUVyb2xyVWJoRzQz?=
 =?utf-8?B?cDM0dkVjVFEwaE9KY3B1eXp0d01lb1VWV0RjRjZpSmNkNENEVEhEZE9aTGxx?=
 =?utf-8?B?V09pdHlYcUk2MTJ3WWM5R05NVzF3TTlIQU1FRUxxdi9mSzhWeFFsRUFHT0ds?=
 =?utf-8?B?TzBtZm1GdkRYblFXeGJ0MDZkRFpHTzJ6N2dvZ3J0aHdiVWlnNFdUUFRoUmEr?=
 =?utf-8?B?Uk8zcEVkODdHRCtFdlhxN3oyc21BMUQ1TGRiNWZ4eFZqQVVSUmszNk1WS2Zv?=
 =?utf-8?B?d2pWeGVCdExseWdUbmF6cVpLOE9DWFZIRUNXeDJOcWJHdmJEVUptalUzNzdm?=
 =?utf-8?Q?vJWiZ8RdSU693nFIRw3cN7hLx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a3e329-4258-48ad-8136-08dac88740b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 10:34:07.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x4NZ+wxJH3kqduDtla+8sWP69UFBfCHUh5OmP+Qj0ran558ysrJCTtkkjNKIar0ttJGzWh50cbLmK1c1sUA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 17-Nov-22 4:00 AM, Borislav Petkov wrote:
> On Mon, May 23, 2022 at 04:03:29PM +0530, Ravi Bangoria wrote:
>> On 21-May-22 12:08 AM, Peter Zijlstra wrote:
>>>
>>> Norbert reported that it's possible to race sys_perf_event_open() such
>>> that the looser ends up in another context from the group leader,
>>> triggering many WARNs.
>>>
>>> The move_group case checks for races against itself, but the
>>> !move_group case doesn't, seemingly relying on the previous
>>> group_leader->ctx == ctx check. However, that check is racy due to not
>>> holding any locks at that time.
>>>
>>> Therefore, re-check the result after acquiring locks and bailing
>>> if they no longer match.
>>>
>>> Additionally, clarify the not_move_group case from the
>>> move_group-vs-move_group race.
>>
>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>
>> Below is a quick test to reproduce the issue. It triggers WARN_ON()
>> as normal user. No warnings with the patch.
> 
> Shouldn't this test be in tools/perf/tests/ or so?

The issue was because of multiple event contexts involved. However, it's
no longer the case with reworked event context:

  https://git.kernel.org/tip/tip/c/bd27568117664b

Thanks,
Ravi
