Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53118693CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBMDYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBMDYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:24:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436CFEF82
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 19:24:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv2UBNn9np751pn542fKenwqxvzFDJiYP5qtaK+4cNa29hZTH8wYhL4RkLioIaih9SY6bB37ZzSx2l2U9Bjh16/kQbxWi3WlguTbJX7PaAag/Zcsas5+PoQcWWQSGmCOr/gnMBA1aiqKNqEzIqalTFVLc9XrAMAtQDXIEzt56dc8n2UlwoBzxWh3M2OSCyD6hvYCz7eytzpNvEoJDePYUrHHce4ZndlGtZc8D0ybwyMGqRmD2Q1DxUH1S2HRuLeZW1UXGfsds3HftR+2nO+IhntiLplXh12JJ114C0nF6K++FRg+dgMUq3ioG9xOMoTxVEbFOwvoH9TDeoSC29SM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqwXdUjpJWgLC4W19o6ThPGHy2t2TfWfC7ebazfHbVY=;
 b=QWUZYhOjAowSQ7tI0JCYFwQcqAkKoYSDwZgU/59ejB6u1aJYAMhOI8oXTP+yK3h+QyQPs719yVaLnO9vDQeUjgYFe23v+lddqP+3W9M0Y6iwSNOD2i1srKqciI5nuCJqmnQe2fTOdksaf8069FtVjZhZ3U+ZDGP7lJKvmL924zY7gqXRie/RyIfJQrXDj8BpDsiboSdTqo7i8BA/QX1+hIJSrZkL2621Fs1ImbNXgKemu0JJMDqqXiueETpTqtCEn457NTVClfs4+ohQBzA0+DZpXjf5oDqHpWjPgY1CQJAJdOQ1CWb0THdagRdP9If2fAEA9S6oQxOaC3GDHMrj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqwXdUjpJWgLC4W19o6ThPGHy2t2TfWfC7ebazfHbVY=;
 b=3G/RLXefVH+jeJfhwMDUz5GZHdSF2a0aN50doJBYqss3sIJmYmG+Wp4vJkzCa+nEHPGvB+2uO4fY7zOMrFoIhFQ5JNCRLn9CTavzzA0SKrdoJ4qScFz8DTcEtK2MSvfk1p4Rx/rQF90flFyp7ZAu00Dlu/agHlsWGjWNhaUFj28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 03:24:03 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 03:24:03 +0000
Message-ID: <3c811078-c869-452a-8e2d-ebe720d21691@amd.com>
Date:   Mon, 13 Feb 2023 08:53:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
 <a0127c3c-22c9-ac46-1e9f-200978fec392@amd.com>
 <87cz6eb7e6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87cz6eb7e6.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: cf09c95d-00ff-479d-e06c-08db0d71c16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRkGXvxka4vc2BjrmUyOveKqYPGY2k6c8oONlxYOZ650UXDCgeCllAxfKb8zAsOtT0hq18jDIdf5aS48AFsDHt59jIgLjNV+IC2mlTymoIre1ikWvoCd5v+fIHhYHQ/ptPWt3H+fChHW581dC2qlr/i4IGHwsn2Rgxac3CLM437moTIp2loPBcXTD/C5RZU+57IkleWBMDIIKhGHPv1kcF4W2VX0P4X4VrnsJHv7f4WGrknxyMerHVquPKDKuD1GNtg/PX7yaisDHcD6ptOru6n3anJyMRaeU3s+6R/9B7pbarzwidEMnUy1PdC0+UONinlZaEs8vpXkNed11B9rK3KhY9rcmLTDlz0tH6NcA1vD9Fc161Yanc1JAkLd605XTHRs96GgYj0+F9AbTVSCT4M9v6/AOgs+vow8x0XVPHiGKiTkTYOqKhaD2AGbfKbaecHzYv6dN53TD8gsG+6p9J72YXRULQ+HV3aI/ydh4BWxztpce6rJ2+ehd2UOqPoYt8x5M9O6OONklz17mYd5XHw34K4z/cPgrzuvSjhCxu6BONwhypPz/LpB320AMVPWCmnkoPD4SC2MGoBVcgPqOWdTHVeM7I6LRUBCF8tS9EhQRjsu0kohb/49HatC+gJAECj5IM6mJG1Wdp71KzIulXNks1kjNBtrFeF2mFZ2W9szAEvVoqbUaBsPP54XN6gWz08HDtSpTUpumeLvzQ9KlR7hEx9jSdevPFiCQA+6TJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(346002)(366004)(376002)(136003)(396003)(451199018)(6512007)(186003)(26005)(31686004)(316002)(53546011)(6506007)(2616005)(6486002)(478600001)(66556008)(66946007)(66476007)(8676002)(6916009)(4326008)(6666004)(8936002)(7416002)(41300700001)(83380400001)(5660300002)(2906002)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVaUG9jQ0I4eGlxcEMrQUlWZWdEOGpaMk90RitudDBSZEllYWNHaXhLa3lQ?=
 =?utf-8?B?czNqZm0yTGg3dGhSTjZlSXp4a1RWenlDVlJnNG5SenVsSS9Bb1RSNFlhVXlQ?=
 =?utf-8?B?Yk1FaXNCeWtSRGZKV250UzFrblkxN1ptbzhLRzhqUjkxTXVIMVArdzdnNW5z?=
 =?utf-8?B?eUZ1UUFIbmlUbytHQWdVZXFGSUxvdTY4NTVFUml0b0UvY2tMUDJ3clNLMkhr?=
 =?utf-8?B?RzJwaWNSZDN0dWxEWnJLeDB0YzdCNUpyeW1abWVDNTF6ZE80bHJaNVVxakIz?=
 =?utf-8?B?elRINlBzU3BpMVNUQnIvWTYveDM1aEp0dFR1UWo4amtHdEIra1FKYjhaMFBX?=
 =?utf-8?B?MCtnQ0F6a3B4TzltRlRyOXF0MkpjV3pUUkVpRTRKRkhVcDg5N3Ivbm9idVAw?=
 =?utf-8?B?MU0yVitFQmlJMTEwM0NkMTk1WWF0YkVidnVId1Z6VWZFK2gvT1hCdk03UmtJ?=
 =?utf-8?B?eExpeUJpc0gxaU15djNyb1VscnBwUVl1bkNSc3NyMDkwUWRiVmt5b1FxNU9V?=
 =?utf-8?B?VDUyQVpLVHJiT0FrRm1QSUhzMTVlNTRDM20vU0xUMUtxakZDZG1xV3JRcyt6?=
 =?utf-8?B?T1hNN3hmaTF0VHZ3MmtxZUdDOFZQSHZmMHRLOFRFdFRPbjIyK2h5YW9TeTBr?=
 =?utf-8?B?aG8xTXpqeGg4cXN1L2xkT1QyNXgrNEp2RG1NZ1NzR0Jwdzc2MWxEa0wzdU0y?=
 =?utf-8?B?WW9lbk1lbk9TK0NTT29UeUZhMzJJbTJwV3VXN05PTnZldnp1SEVhbDJqYUR4?=
 =?utf-8?B?WjlRaEtVQUJ1VlI4anN2bTVBdE8rcEFZRnZYTDhEeDlTYkdrdXM5ekRTL3RR?=
 =?utf-8?B?b01ZT1pLdjJFNVUzZjkrbGFpK3BrY2ZnZGFGWXNFL0tzVFc4UEFjNnkreFNO?=
 =?utf-8?B?QUpjTHk3NHk4SmE1eCtkMWVJbkNaT0YxaExhTFVnRFBQT1FPUDNublBvblEw?=
 =?utf-8?B?NlBtVEppS3VwWkd4dTBLck5YYVBTdGtQT21BY28yTVdyWURoR2RtZ2FMMzBN?=
 =?utf-8?B?bHdRWkpDWWlEV08xOHVKbXh5RXNIR1lPeEtBVGlkTVVGNHVtQ2tUMGFyalph?=
 =?utf-8?B?NWpsMlE4SDRQdTZPNXRtMElpMnNodWpCalJiK3FSOGowYjhsWlFOUHVWV0FQ?=
 =?utf-8?B?N0xlVVY4VjlkYklVZ0paMUcxVXhUUHBzb1dXM3VqdW8vWW5mb0xrNjhpWjhJ?=
 =?utf-8?B?Y0lIam0wc1JndEdwUFBrY2w4dUE0SG9EYVd2ZTZmTWRGQlo5aDZpZWNKdXFL?=
 =?utf-8?B?dWZ1R3Z0TGVWWHZ0ZnlpYXlUeEFZN2VNY3plTEVHSC80TXJ6QjRCVi82Ynh6?=
 =?utf-8?B?bEYrZnRrRFpTUExENW11RHZXUWErTUNjMUdhVlB1OG1sTTZVZFZ1aGtzd2tY?=
 =?utf-8?B?SVRZMUUxUHpxdzFpM3pwa3lmNVd6K29ESjJ3akw5VDNVTUg5blAvZGduUFpO?=
 =?utf-8?B?N3Zydk5KL3VTM292eU93SW1CK3VsNVV2dnQ0VllMRDNicHU1MG10MmY5S1JX?=
 =?utf-8?B?Qy9XOVF2N0lNUWVIRk1Gd2xkb3EwbzY3ckY1RS9WMVNCSzIyRG1tdnBGdCtN?=
 =?utf-8?B?Rlo3WDlBSE5vS0FoWVE0aUpmeHU5bkwzK3RHbW96TWtFZzVYZHVnV2hPdU13?=
 =?utf-8?B?Wm5pMFljWVJlRFF6Ui9xdUZmc2VHVU5tSzZ1a3V0QWZ2L1ZicEc0ZUc4MmNL?=
 =?utf-8?B?L3RGU095RzE3N0dyY3ZsSWNFaTI3N0pLa0c0eXlNTDVDTFd4b3ZkTnFDL3JC?=
 =?utf-8?B?L2NCYm54VHpaUjYzZTBRbnVNdnBZckdGaXZmNE9mKy94eElONnZYNW5pT29i?=
 =?utf-8?B?TnhMcC9kYlU2MGM1TDJsTjVkTGN0Qnk0bFNGNWxrdDJjeDhoOFlJbjZxMDY4?=
 =?utf-8?B?aDNaY1MvYWNDaWp6V1NiMlA2YjBmdlltTjFLak9hTk9GQk1FZ21NZzNoWnZl?=
 =?utf-8?B?cENjWUFNTHBHM1FtU1VZQzNlb0RwYnBqL2JLWXU0cHVKNFBzY1FhSkg4citG?=
 =?utf-8?B?N1ZpTFFaaW5yYTdkWVdUd3A5NzFYaEhFUnpxaUcrbDhPbUhCazkySzB6Tmk4?=
 =?utf-8?B?MFlaRUV1Zm44eGFiWHNZa29nTGNZTEZKT1pHWmNoZFhPbHQzU2ZKOU5lekRG?=
 =?utf-8?Q?8Xf4duUMZA6v01udiUa9AhBu9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf09c95d-00ff-479d-e06c-08db0d71c16f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 03:24:03.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWgbaaDlNNXFVcX/QrkgKfvZ0pwkTVEiBkkVX8uLagOPqZXzlnWTnHm/nvpBKAxVz8nELzkI05mKhj7bcNVUIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2023 8:26 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> On 2/8/2023 11:33 PM, Peter Zijlstra wrote:
>>> On Wed, Feb 08, 2023 at 01:05:28PM +0530, Bharata B Rao wrote:
>>>
>>>
>>>> - Hardware provided access information could be very useful for driving
>>>>   hot page promotion in tiered memory systems. Need to check if this
>>>>   requires different tuning/heuristics apart from what NUMA balancing
>>>>   already does.
>>>
>>> I think Huang Ying looked at that from the Intel POV and I think the
>>> conclusion was that it doesn't really work out. What you need is
>>> frequency information, but the PMU doesn't really give you that. You
>>> need to process a *ton* of PMU data in-kernel.
>>
>> What I am doing here is to feed the access data into NUMA balancing which
>> already has the logic to aggregate that at task and numa group level and
>> decide if that access is actionable in terms of migrating the page. In this
>> context, I am not sure about the frequency information that you and Dave
>> are mentioning. AFAIU, existing NUMA balancing takes care of taking
>> action, IBS becomes an alternative source of access information to NUMA
>> hint faults.
> 
> We do need frequency information to determine whether a page is hot
> enough to be migrated to the fast memory (promotion).  What PMU provided
> is just "recently" accessed pages, not "frequently" accessed pages.  For
> current NUMA balancing implementation, please check
> NUMA_BALANCING_MEMORY_TIERING in should_numa_migrate_memory().  In
> general, it estimates the page access frequency via measuring the
> latency between page table scanning and page fault, the shorter the
> latency, the higher the frequency.  This isn't perfect, but provides a
> starting point.  You need to consider how to get frequency information
> via PMU.  For example, you may count access number for each page, aging
> them periodically, and get hot threshold via some statistics.

For the tiered memory hot page promotion case of NUMA balancing, we will
have to maintain frequency information in software when such information
isn't available from the hardware.

Regards,
Bharata.
