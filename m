Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41666832F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAaQpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAaQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:45:43 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE52DC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn8WgqnO8KY1pGNbEag6eDfQLdNUtLUEiq77nyh0R4Ql4wxRjxX6RTNOpa005m8y383dApzVIGNKDWgESwuB062lgBUxilP3GQbixyB+A5Ee/rThvjgERa1kDvzeupyl9coX9O06aKjv2iPw5xDejktRlor1OuvyeAjJObYS5GxZsv8W0WXPgpZs7FyivZ2bRsJZZOQK58FQKAYf4hYp/KVuWbC10rQdW+scgRF2hBfQuI+NYayysxxAeiSs1DVysA1fzAkVKWeOXfYjmCgwJ1AChcX80B64chhKnk3hkZGPEcRWwlG+ymYKtEk11m9f3sTjua7AXEga3s05Aqp2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX1j3sAbsDvNdHxoMBRmJvMcFg8RX61hky8Rjjxa/6Y=;
 b=DgnPzsTpUcRzChTtqaLJJJMC3ABs+ZlNNxSn1/EJtHWLxC+1YnqPEeXsB2Rhjf0Ih/OGrP/dJ0J1WSAFK/EbVUhyev/9suO9M69F9i2p8V4DHq3tgxpARPnzhFAaJf8a2NxnoBZ6/fnTtr9oAIfetibbDi7xB5WAiQa8cyi30DRLZKMFZHQblc4TRQH6SbwO3A8UtY9tTr3OXOPFUAU0llYVYekmMjCwzJAHqWgte8Rux/tbVO8z13MsYFyBI6DdARe3JqHXRck0GAWcPcyXRazLJjCaB9weGAf5PCuoL5Lg2S33sVn0YLNAyiA1MutcLdd5BewnyUvA9FyqIJAkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX1j3sAbsDvNdHxoMBRmJvMcFg8RX61hky8Rjjxa/6Y=;
 b=ijz/5cq/1UTgyjS/Bup2ZrMgksskOrqdjm/lI4qoke/enGSVrStjuxIp6YwwDevlDHRxmc80CH81TGIO02N6KnZmh7zzCCS65tSJYRQbIapcrCcwmsNWTiEuoz7sezPjFgK1Bhpsdpex9KOJWmcw9ZL94lVlF4EPj2OBNS02++G/LuvXn3YRhwZrrOO37qq3u846OOIhPCMyJuQjiUclBsjG6pBdFkZVwMX4mNwR0kJsmLDfjk4AVVTHXn6PqgrrOWbhilWGS6+rCLw6on0N3cyUvrzwxpL66MOa70uotxO5iQvKrgBNWhVyQz809ZYLpGJc14x5dupLaVIVWe7zFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:45:41 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:45:41 +0000
Message-ID: <cfc3b77b-7e02-d5b7-382c-00cccc4e2914@nvidia.com>
Date:   Tue, 31 Jan 2023 10:45:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors
 management
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-6-sdonthineni@nvidia.com> <87edrb115j.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87edrb115j.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e866e7-8e45-4413-4684-08db03aa96a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqnJ6AAzSdHKmKpSrp85Naa+3MQzpxpMv5q831Pm9LLYUyIvN48DAK1znLuqjb4NZaq3USsvmtzZV+0T3gXyQrwG1UzeKn0/Nd0CC5f/ThUck6fGJImz7ALc83EugrzlERAgrF2pZLStOyflRhRB3FyWITbxIDLJ4rmGgHus8LEfh6ZZm7ZTtvUDK4xWV9903sHe6v0Mi6kdy6jQ4drbClM7lHwaEYwzLh2RRiTp7NfuJovuz6poo/xqo9V4gFgTBXOM4ZQjNq6gYHsqLsy/tIsBLtAyvbjb0+Gjn+06NI4D6nD4tcKE4CGB5knTDFoiBn6LUlzObLu2qOQ+PKT+XW9cYMDTWclpWsKfR3EIZZGHjRteB5NW+JnTC6Dndx+WnBGA8lL83E8z8l1CESQHIHQF26IS/nAoEuikQxECqpYk6JRNfLqxKmSKyxm4sM/sZ5EGSDXPpPsqW7KCr0n3mrEHnPqkY8JTytoXJHVd7VXt/WqlSgh0K63If1CQp4r7jXJ2zgFMtguj+li5DY6cOhuB2yTrDU4Ktowp9GUp6dttvNCqQHlS9GaZgGSHJP8O4hPvraJU+X8sWub8Sw/WEbKrvotEU+UuXzYANJrZC7/p5NI9J8dc5MXcgFgBI0K/RHRR0qqxnX4JDDfS6TC1Pf1EhTrxycGvXBENjd0l/scGKN6agKiroj8OHo1TNycy7kkJbvbsZMKvccOXs2SpQ12v5ux1UllEbf9tZZCPNgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(83380400001)(110136005)(54906003)(41300700001)(8936002)(6506007)(66946007)(66476007)(8676002)(4326008)(316002)(66556008)(6666004)(26005)(186003)(478600001)(6512007)(53546011)(2616005)(6486002)(86362001)(31696002)(5660300002)(36756003)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmkvSVpmT0t5YVh1UE9wN1pHbWEwTEdzRTdIL3JhcXk1eDZQdzdaN3dMSVRM?=
 =?utf-8?B?UmRlTHgxVURlNk5ic0gwZjg1WFdvSXVxRjV3NkFnZzdaZG0vNDkxdU9XMHdO?=
 =?utf-8?B?Z0VnLzNiQnh4YWdFSGdscnNyNGFPTVlRdTNzN01rS0xvYjUvdWFqS2JuL3Iw?=
 =?utf-8?B?SU42V0YwMktJaWp1aGFGZjR1Yk56aklxbVIvSVVITHd4ZXdaZlJGckhqdGtu?=
 =?utf-8?B?QngyRlU5bFFLM2RvRGtsY2lkV2pCRUkveUZkYzU3Q2JiTWcrQVJwYVhMc1V1?=
 =?utf-8?B?UEg5MjNQT2pmeXM3SERNN0pHMERHNTJUaDVZcWlHWXpuWm1kRUgxTVJScWY5?=
 =?utf-8?B?N3dON01IVmRSMFZkSmorWnpOYWhRdkZQaHJGdmdzanZMZ05JMWt6Q2RnU2FR?=
 =?utf-8?B?c1FKd2NBamxqVGE5RGJqb0JVQW9GR1owRFpUNkMvd0hJbStIQWtncVcxelhl?=
 =?utf-8?B?bzUrK3BHK3N5OTVWMDFqRGV2bVl2WTZPUDhxdU8vb2hPYXY5bWMybzNSNFcw?=
 =?utf-8?B?eHdaa28xS1BBZDhkdWN2OHNQRVNCOHNGNUxCamg0WGVnRVdyekhpZHlBL0kz?=
 =?utf-8?B?UWU1UVhmWXJ1RldjdFNrcGFtek11cXhlM09nb3JGWVBZYjVoMVpTeWhpZ1RZ?=
 =?utf-8?B?NGExamgyQ3ZUcnVjbzg5cHZDRXZxSEdnVzdTZHdNU3Bvb3AwN3BPNDZoaGlT?=
 =?utf-8?B?WXN6TWJkY2EvSjBMNVNKcFFjcmRIUmhPejR0NysrcXB6NVBieTZmcWYrRkEv?=
 =?utf-8?B?Yk1rdlRXTkxURkRCSU1FcGhBMERWR2VvbzZxNUZ6UVVkWEg3QkVQUzZ1UnI3?=
 =?utf-8?B?b2l4TjdKTzlqdnpKcFptT0c0cGRDZERPeXpWYWYrTmdxZXNjRmhucjBBMWpm?=
 =?utf-8?B?aGFIcWdqcmxHRXpXUmp2VDIyaTVlS0pKYkNhc3lTMzdZYyt2WGJYakRCZ2hh?=
 =?utf-8?B?eXpLdzFQdEVDaUtTSytPVGZXcWMyZ05rR2hOWVZlNm1BVW5MTnpPNTF4R3Va?=
 =?utf-8?B?SzYwNXBRT0hwakhpOXByVitXdHZ3UTlUMk4vQzdwMEtUMGV3b0JtSGl6MDFV?=
 =?utf-8?B?eCtmQ0ZXQ2QySnR3NURqckl4M2pvMmJDaW0yT25nd2tRYUdPaUc2OWZoRTYy?=
 =?utf-8?B?eU5NK3NhTG8xb0NSL2ZYWElYMTFOM1pFc0M2UTBya3NzVllHS1dHZzFLckI0?=
 =?utf-8?B?UDAvb1RTTjhZRFJkODFYY2VDT0ZoMm9oT25pQUtUZ2lzZVJ6R3ZvZ0grQjdE?=
 =?utf-8?B?d2RpUmExdWFmRndJK010Y1RsTVVWdEVpUzlVNlBWZVNUT2lWMmgvY29PYzVx?=
 =?utf-8?B?dFZNbi8yRlpVOENySWxXSXgxa0NHM2pmMXlESVpsOHY3TnM0SlpxQTM3Q0Yw?=
 =?utf-8?B?UU9hWnF6NExhZzZBMjNmYng3bGFGUTZHcXBSTXRub3ZJWEVVK3Nkbnoxb3Nv?=
 =?utf-8?B?OVRFcVM5S1hRUGdaUm10UVNZRXM4TTZqS2xCM3luQmlTY0NxdVA0eWtORVhk?=
 =?utf-8?B?UjJCYkNOVWZlbWZ0dkF6UndrOEhJYm52VHRuQkJKRGVQKzJubUZLQjcrenZx?=
 =?utf-8?B?b1ZSOE9DaEVhY3JjYUZxZ3RWZ1J0SDkwSG1MQWtuMFVOMXpKT29keFlFSDZN?=
 =?utf-8?B?ekZsTzQ3MWNyOS82OWZjVmJSbDVEZ2NyUG9RaFRBeTNYVXpZZDN5Si9Fa2Nk?=
 =?utf-8?B?WkNPUEtvNURtb25WMHZmVDk0dXJWdlZWYzV2OXE3V3J2dzVvMk1YNXRGQ0li?=
 =?utf-8?B?NnZ2eDRUYTdFSHd5UW1PT3JibGRkUjJ4azgxLzJKeWROSHpvczJGZ1hUNFo3?=
 =?utf-8?B?NFFLUGY0V3dMellTTmF2NkVGWkNnZ1ppNnMxUHRzRmFGMXIrMlcyN2lkZk0v?=
 =?utf-8?B?RmY4RjE1WS8zREJBbmx1Unh6TlFNK3lrNjkya1MySldBdytka3NYZm9vMDJ0?=
 =?utf-8?B?c1JYbk1odjhtVEZJLzJsSG4xazBRM2d4MkV3Wm9rb1ZBNlc4VVRqaGV1WUxQ?=
 =?utf-8?B?NVpvT3hSUlZIbFVwWW1ZZzZqbW9xcFh2WkxmZnpjeDBhWXdKU0o5UGoxVVkw?=
 =?utf-8?B?Y3RtMUU3dzU3TGFQbFl3c0E3RldCam9rb2xYSXpQWjd6eXZxaGMwWFZCVVdy?=
 =?utf-8?B?TEd6S2NXVDdUSkw4RjlTN0ROU2ZLdFo0dHpKc0lnN2lNSjdKMWNtR2FFWUJP?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e866e7-8e45-4413-4684-08db03aa96a7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:45:41.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNE8lGb35411Tpb1DzhazVRThpXIz8V1IJBsZzmK4QGBCmIoGtbO2alBgHBMfN0wbaicPwyvGj4ZurqYdYwx9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 03:52, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
>> The current implementation uses a static bitmap and a radix tree
>> to manage IRQ allocation and irq_desc pointer store respectively.
>> However, the size of the bitmap is constrained by the build time
>> macro MAX_SPARSE_IRQS, which may not be sufficient to support the
>> high-end servers, particularly those with GICv4.1 hardware, which
>> require a large interrupt space to cover LPIs and vSGIs
>>
>> The maple tree is a highly efficient data structure for storing
>> non-overlapping ranges and can handle a large number of entries,
>> up to ULONG_MAX. It can be utilized for both storing IRQD and
> 
> IRQD ??. Please write it out: interrupt descriptors
> 
> Changelogs have no space constraints and there is zero value to
> introduce unreadable acronyms.
> 
>>   static DEFINE_MUTEX(sparse_irq_lock);
>> -static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
>> +static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
>> +                                     MT_FLAGS_ALLOC_RANGE |
>> +                                     MT_FLAGS_LOCK_EXTERN |
>> +                                     MT_FLAGS_USE_RCU, sparse_irq_lock);
> 
> Nit. Can we please format this properly:
> 
> static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
>                                                        MT_FLAGS_ALLOC_RANGE |
>                                                        MT_FLAGS_LOCK_EXTERN |
>                                                        MT_FLAGS_USE_RCU,
>                                                        sparse_irq_lock);
> 
> Other than that this looks really good.
> 

I'll update in v2 patch.

Thanks,
Shanker
