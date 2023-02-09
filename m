Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482F690026
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBIGEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIGEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:04:50 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF7212F18
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:04:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBB2gjJXnfXr6HX2bGlSewdxoyDFi5Aeesu4kMcyQXZeCzRyyO+ph6NSWyb9K4JPPB8zlhJ1MIW73Y0TYnznj+TKhM7qrazcpzjDiBii+SKKLOIfU1EoeG605gDKKhpjYPEiXpa55ZzyUjwh3oPIT2aIMEq90X+QTYwSEtRWZ3JKiejrgg/AjGZSNA29cI8f1brOxjz467PCnws21zWbrbo5xtkYIYIPhwx9ZvroV6cVXNk5Y+iISTBOPNt5C3EC5O0NgBaKSaSibCWscp8EJpzrCNaK/dIOEyEcaC12NYcl4F9lm6r11y7Ot5aw5Jw+/ZfM7kc4HUt1OMr6MXwDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9bZHc3VgOIlhbIFrePYHRK+LMEAPgnB5jAlPdtIIb0=;
 b=a1of7wmnI0N0qXMuV8LzQ6MMKJJ9qoXMbz6x/tTjeCGDYEqS2jgNgpPVCawjMiX8/SOf4QAnkYKzn7qYnPlkp1eHxi229P5wdjXhxTjkeB+RiL5XIbMXIwSV2zaDnQ8qcNH6t1yXFlwFOMLh50K5maNe2cLVyuqOaNmHUfpnRusldMoQ/ecT2/HM08NGmDQhCEXg/IQoQma1TriJDZzzKCACTF/lHBtZ+e4ngKHyZHsvKpsSvbzySGNRYdjrg8b5XMrhYcTtXwtmBoUb7D6ZHRVsrUQMmGO6/Yc1YlvWeG6GbhWtAMh9w0eROnnGxadlQPHvnvlfcOESft9xVtnbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9bZHc3VgOIlhbIFrePYHRK+LMEAPgnB5jAlPdtIIb0=;
 b=1s8VZvd6cw5/aQhQ8/2mcK4m8/ELOan0qugIeZI44tWX98zPLjuKzcn212uy3j+QpDZJTVjDL81+YRCB+aEhCay7EZlQP83MAt7QSfHIuOrqkHL6X8Pq6xCVt/P2vbKxOzeTyyGOlcwiBohJcQ8c2B20W00sYZimsiMkrniYj5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:04:47 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 06:04:47 +0000
Message-ID: <369bef08-92cc-9b55-823f-1fe780532967@amd.com>
Date:   Thu, 9 Feb 2023 11:34:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        tglx@linutronix.de, yue.li@memverge.com,
        Ravikumar.Bangoria@amd.com, ying.huang@intel.com
References: <20230208073533.715-1-bharata@amd.com>
 <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
 <4808d3fa-bb68-d4c8-681f-0b2770d78041@intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <4808d3fa-bb68-d4c8-681f-0b2770d78041@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c3a4fc-19c6-4d7f-bb28-08db0a638bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rN6iGq/35OaAu/VXmlDkqHX+M8za1dPcaf+gq3+Fa63AU9Wj1Btd93o0CpbO7bMTaB2p1y55DcpqJOr5J/y0vppJTSte2cpEU0mBG62qFSuObcMKBC8PbF4IxQytWwlUT0nYp2UJoqaAODVh/XnmnJwugyz94PmA6vsBkuxl+XBNPor6lqdUoHi1nSxvsgmjG8y4N3mfeJDLNG+CH5d9tYN8RU3jYRxz8nGzmC85yG0DuB/zENSXpXy3ki3dPGdEVURFWwWic32BrG76sjUhHKeAGKAtsIIPCAJ0hwNl0bjwoNSxm1vBVHZ7lD75CJGbDjh+jAt0xmn4/8sCTu+STCHBjgnEAhsr1bIuEsLZgZ0KHE0iMSFe9LvT1Bx+eyIh35hTWpymTf3Vur0H/mWTxOAnGPrBiZasMrfG1DE/D6niMbj6eB+0Edwwjn73eN/p0QHVvKjHfC6cE5oh+c5gCP7o4Tk17DxMYREvc4z7fAYUpDYx4Y40FylhJ8obURmGwxWXDTCQqkfxcoPKMCd2bTCzv9ZI96jrQx7efKLDrU4GR6uUGU9SLnz63bf2tNVZtjQI3Xg8xfsyV/onobqoo+X7ekan0/y3GWk+EllMoB/q2dqVAneG/rjEgHH+VXrDB49Onw8AyM5NPJdG5tq3LpYA+jINGn8ib/aIVvIpl23MS7uI0j0anXRQ7YtmLO5uRi/mKK5S02Val9cYOaIu+Mnx8VIalHuRFPf5d4Gp/co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(316002)(66946007)(66556008)(83380400001)(66476007)(8676002)(7416002)(8936002)(5660300002)(41300700001)(4326008)(478600001)(6666004)(186003)(6512007)(6506007)(53546011)(110136005)(2616005)(6486002)(26005)(36756003)(31696002)(86362001)(2906002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skp3bWxoTk5rQkR2aHdSL1pOaGpZYnVldTJJZUw0WHhjalRnbnBXcFZMVlh3?=
 =?utf-8?B?eUtjRHY0Tmd4cjM2L2g1YzYxTWhrTVR1NEpEdTlLL2dxdGZVdUJCSGlSYm5m?=
 =?utf-8?B?VmpuL2d0UFFYVlRuNjVPNkpwaW1tZmZSMXBXWlM3RVFCTWd0SnN0WHZVSEhB?=
 =?utf-8?B?ejl4TXFJRXVzd2pLOHU2dm9xWndhdVVUZjRiVHFYeVJ1bmJkcEdDcGZRZm9D?=
 =?utf-8?B?ZFJIOUlDTHMzeDdNZXdBT2xycjRYR2pRZnFGekoyOU1pZGRVUklyM3JvV01u?=
 =?utf-8?B?UkVUclRpYk1jQkZyL0N3b2tzOG1NdjliazIvbjkzVmwzUW9KOFplenYzcmVo?=
 =?utf-8?B?RG4yTEtDcjNnUDFNL216YXpHV0JsMXZZS3AxaEJMRStjbnhuOVZoTm5qdzhr?=
 =?utf-8?B?aGlQT2Z5UnlEV243eUVxcWMxZnhGOVpXcGpJYXJIQWszUmtLOVBpei9rdkNm?=
 =?utf-8?B?dVpBRjNuTnlvY1hQeFBEUmd5ZzBPNmExMjBSWnlmSlVLdktPVTk1cTZZVUVl?=
 =?utf-8?B?dTVSOGtFbkdzdURXL2ZzaWZjOEI0VzJCWHFnMWpRMXZuUnd6WmdIV1hBRmJ4?=
 =?utf-8?B?eGt3WUFieHA2dGxldjJYdjVqUEdGTXZKUUJWN0w1QWVEbnlBRmRsZVZLZDFQ?=
 =?utf-8?B?ZU8wajZIQkx6K0d5UXh0ZDRZZ081UGJ2aXh4RGVUOHM1ZTArRS9vd00xc21i?=
 =?utf-8?B?S2ZnVlQ5cW5FWU5vSjJHTnNTRDZOM2Eya2Z5WlJiZW1pUW5CNCtpQlQ1RXpo?=
 =?utf-8?B?dDRRc1dTOW5PQWF0Ui94NWQ0ZzF2YXh4citmQkFtWEozYnlra1pzSS93ak5a?=
 =?utf-8?B?WUEvK3VnRmNWT0lBZU1oRmwyRmJ0dHBwY0x3VllWaWtmVFhrV1g0UEwyNDJo?=
 =?utf-8?B?QzNPejZVRmdsTVhwSktZR2ozelJTejU4MUo0Wjk0TEdPRjVuNkw0amNOS3Jy?=
 =?utf-8?B?aWVhVWNabnh4cC9UTFJMemRDbzZ5cFpObWc3Q3gvNythcFhyWGY0Z214RjRh?=
 =?utf-8?B?T2NGUm56NDZQdXlmZnFlVGs0UXZTVi9NaHdLVDJ4VDdXRVdOOWxJUmtZbDlh?=
 =?utf-8?B?UG5IeVNiako2VWhFai9XSXUxSWlYNS9YUzB5RkhnRGQ1QU4wVWpramZVWWdw?=
 =?utf-8?B?VVFKRlRMelkzOEwzUFNxczJtTVY4RTcwZzhndVpVMlFqUndJVWFTT09VZkJi?=
 =?utf-8?B?blFYVjlncUhycWJBbjlRWmVhR0hBNEdDWCs5c0RUQ21RVHZrc1BneVVMaEhj?=
 =?utf-8?B?SGJwVk5PdE81RksvN2FZUVJtMDVMWU9qOXBuNytFb2hDN09ISFI0VHAyVnBO?=
 =?utf-8?B?T09kNEJGaVNBRnA5ZlljaXpjSlhYeUl6c1RMMzZGalNiZkwyKzZrM2xIcjM3?=
 =?utf-8?B?L29oUjNEZFV2bHQ1cTFLYkJUeEJ6MFZBeGNlck9zUks4WDZHc3FkVE11MFlj?=
 =?utf-8?B?eThZeHQ1MHRjZFQ3bFRyWDR4UGNEczZsaFFmODZtMlhUM3BCZS93b2Yrd1Nv?=
 =?utf-8?B?S2pCT2xHUFhramFmcnBPVTFKNlhyZkNOL0hmOFlOYkQ4bWM5NGl3ejhieUpH?=
 =?utf-8?B?UC9USGxYZ3lIaktGeEx5T2JiMG1PQWhTSWcvSHhYdkh3WXVPdGoyMGYrRFMw?=
 =?utf-8?B?Rm00NWJsMDZnRG56WEVpMEVyeXg5VmJpVVdqeE5NV3Fsb1BYdkJ0VmRGVk9P?=
 =?utf-8?B?ZHV1ZUpTUUtldjkzMjhsakNIQlArT01aV1o5VXp0TjdDL25PNkJRSnJiSFVS?=
 =?utf-8?B?eFFqL1E0TTl2NXZoNVJMMTV2Q3VRcWoyR2g2Zkx2OUVwYS8zVmNmRUFiV1cw?=
 =?utf-8?B?cFNUUGdPcTNCaE11cmVnRzJjMnlGM0ZRK08wUzhRTk5KYVJMYnNOTDJGYmF6?=
 =?utf-8?B?NkhvNEx6RnNkdmZRNnk5RkdqdUd2M1RiVEl4K3ZqbmQrYXkxS3RpSndobGRt?=
 =?utf-8?B?bUowa1REU1F4VTExbUtDSkJ4cVVOUUF2RHRvN2NJcURaMWI1a3RqRjJCWUVU?=
 =?utf-8?B?YVNvVTJJQ0ttT3kvdTZhRmhkaEx5dm9BSmZTMlByU2o1Qk9SUnZMYkFmbWVW?=
 =?utf-8?B?VElLeUtQcHEwN0NGSFVPQ1UxZ0g5WlBDQ2ZzYlZtTUJLdEIreWt4U3pIeC9K?=
 =?utf-8?Q?j3q/vgW7jexg3M49ohd7rwOEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c3a4fc-19c6-4d7f-bb28-08db0a638bdd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:04:47.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHslVgQ1i7+WUU0nXZ0mSxWsQOvqmf7hxIo+pv0scfVsk7dquBbtvZ2hthUSKdEb/P+m81envZtixG4lvcZLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2023 11:42 PM, Dave Hansen wrote:
> On 2/8/23 10:03, Peter Zijlstra wrote:
>>> - Hardware provided access information could be very useful for driving
>>>   hot page promotion in tiered memory systems. Need to check if this
>>>   requires different tuning/heuristics apart from what NUMA balancing
>>>   already does.
>> I think Huang Ying looked at that from the Intel POV and I think the
>> conclusion was that it doesn't really work out. What you need is
>> frequency information, but the PMU doesn't really give you that. You
>> need to process a *ton* of PMU data in-kernel.
> 
> Yeah, there were two big problems.
> 
> First, IIRC, Intel PEBS at the time only gave guest virtual addresses in
> the PEBS records.  They had to be translated back to host addresses to
> be usable.  That was extra expensive.

Just to be clear, I am using IBS in host only and it can give both virtual
and physical address.

> 
> Second, it *did* take a lot of processing to turn raw memory accesses
> into actionable frequency data.  That meant that we started in a hole
> performance-wise and had to make *REALLY* good decisions about page
> migration to make up for it.

I touched upon the frequency aspect in reply to Peter, but please let
me know if I am missing something.

> 
> The performance data here don't look awful, but they don't seem to add
> up to a clear win either.  I'm having a hard time imagining who would
> turn this on and how widely it would get used in practice.

I am hopeful with more appropriate tuning of NUMA balancing logic to work
with hardware-provided access info (as against scan based NUMA hint faults),
we should be able to see a clear win. At least theoretically we wouldn't
have the overheads of address space scanning and hint faults handling.

Thanks for your inputs.

Regards,
Bharata.
