Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E966473C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjAJRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjAJRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:17:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400E1DDD2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpsmOAryBz9krRPxKwYLtL2AxSf/CxTfjI9xQsgJaY5UkfSigFywuvqe6/l2BjzQcU0rCjX4Uzb+mcDIrPGtCludLCzL6fRiPuFN/gz+f79+AOAcxlPTD0KzCoTLBk5fDuU00KkXWCBJKiNjpjtl47QJUplaBvZc5BQKQ3pK+E9BLCbZPOjk08NOT3AD/I5ezmQ12KZUjOycptJdgVzL+k0+vc9D1l6212WdewAp0rYXokb9073BfEZKTxMsFDLH1gmHI+CXwaYuLeOtsoaP5jTnMBthkEJNN+67o2qEqMJL3OsUFZxkytXlzfhaIsJ/7vLZOtcbXlDJ5SJVu8BQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpmfbGp7kJjL93oerWLX37tRM/tHyTF+w7UOutSk86E=;
 b=iWXDQYy81T6y7xxpRSaW1surbo0oEF7b4S20DYvfXtHrlN2FRro2FCOZD9SgQvqNHUO7BlFAuhqrrIhDZxmODera6guNpcLd0lmVVhHewWRw7fGbamJ19BuRFuFPk0mnZ9mn6nHWnxKn8pqs91GQeGLdSY9ieMvMCpLQTqChAhYobnWIAgnPm7Nb0cC5rsmp4EJ1dYYmsIhwO4qzfcSXLACDQSiLhnEh117eNl3/gW940k3vH+5pUx48Io+caXyMfpaRxCnS/8iy+8tBgE82Ntp68+7ZgNq8i8dl8nHqc8RSQt7oGerU6+R9zvXyl7kW0m6W/50vsK2SIVK4QDw1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpmfbGp7kJjL93oerWLX37tRM/tHyTF+w7UOutSk86E=;
 b=cu5xH+N1lig1oGifNnq4sTgk1HaZneSgL5nNMyUBD8eEm9U94qiSMds7qQ7BTe5C3ypm3tbkh7Cha7a57BhJDjb4UumpZnqAxLQXDoLDDIqMGGTl0/VDtWX1LZo+DqfOaVZIIJ/s1CAQJw7RJxQG64qiR9nRYRmFjw/Xum66q4fdozMhyiWdC+3RpEeOTaN8DEBt4+cMkt+uwEMUnnkjFz+fmoi+bPfjjHuId+dSnwdKOziH0IAfvSu+HKSCSZM7fABnbhAKNcUZjEcS8gvBtFDIK3GdH5Jcqp1wlrFFT9Bfm5f0LllXDit4kGmrGDmD4rMsLeGNZtlKOh5Q8q+DtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 17:17:50 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 17:17:49 +0000
Message-ID: <6984b38d-0b55-0e31-4096-209b2a0f7ef3@nvidia.com>
Date:   Tue, 10 Jan 2023 11:17:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104023738.1258925-1-sdonthineni@nvidia.com>
 <86sfgq7jb3.wl-maz@kernel.org>
 <2a0116a8-fbd0-d866-ada0-ed50f0523f1d@nvidia.com>
 <86k0216ydh.wl-maz@kernel.org>
 <4cc4114d-7fa5-1c23-3504-0ca4dbdd0f62@nvidia.com>
 <86fscjoe3i.wl-maz@kernel.org>
 <ed471259-5d32-e93b-20d6-42a32b8b3d89@nvidia.com>
 <87pmbmer6x.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87pmbmer6x.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:806:d0::26) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8b4063-daf1-4d12-8dd9-08daf32e998e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJlyEaRObYlou0atIluAd8MHVYb2y8jUeQoHGfnxkxAFoQ/P20S9IVZwU03qgVJL3RKErVqjJpba2HOYVQwIb+alYGJCQR2Xz59hmfiqEMPfAQf2KsFlJ1hoDIxYglUV997l/MrFZajhVfMaBD+K5nVTrx9J4NyOZ1qcrRUdZauGknsMYk/cib/geaOjELTz1lSGJaPyjkT47R+3nljhBJPQFe6B07KwPYNDbvJvMvK4JG7EFsV3gITUVL1BP3mhM0xC3R1GqHu92+0U9jKzO9k6JqsvNPys0B9YlzHpEfWXyU4l2UNgsqh2ARbuewsrcxt/X3Vk1hWeZw5Q+LuuhPDbjPw6iRBRBj44RL50jlCZJ5cgOCvkK7JdiGkhhyNFkeNUaOA110e4tPyTJm/d/bpzdqMYT/mF90H8hjo+XverZr+LsXnEnCIO7mkskZhsilYFB1OBYQjaP+YnF7qGkXOhHYawWIGj+jYc0vVg5H5Ul3bylF+L6Pnm8rZMJYFkEeb2YpwV7cl4f+ceZ80ruYfTKqeH0zEp8A8BQA/iL7Shsr6yC3VWk9i/WVLS5qZr86ZqaEorpktLloe4ljrLnjM/KZ+Gr+8RuDKHWFxUJfq9ohqKU+oA4EKRoc1tJnv7AvRqhfEuHY9NqhJPujEbKHShpSrpXHAJcIdG7J4e8pNQeLNdexI2ypXh7Dg+MJtf1+4+2Ui4XNObbe0YXs4mA2/yRdffF48GASn5xlCaW3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(6506007)(26005)(478600001)(6486002)(53546011)(186003)(6916009)(6512007)(66476007)(8676002)(66946007)(6666004)(41300700001)(2616005)(4326008)(54906003)(316002)(83380400001)(86362001)(38100700002)(31696002)(66899015)(66556008)(31686004)(2906002)(8936002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhnWkpLTDQ0bXpzQldwRVZxYkhST1ErNEkxT3VvNm9QbWRqV0pqOXFNUVMw?=
 =?utf-8?B?ZThMaE50c21XdFFtSXcwWEdNQ3FiemdlenhKdGpQSDZ5azA1d3A1VXI5TXRo?=
 =?utf-8?B?M3UzVWNFcVB3cEFGcHZIVWJXb3NDM3FFNXNxNDA0NVFBOE5GR3UyV3MrZlBU?=
 =?utf-8?B?RDdXMTNyMHRXVFFQUXhHVmNsWHdyRTBRaE9RVG1UeG03NlNlUUJJb3U0ZHNi?=
 =?utf-8?B?N1BRaHJ6YXgxdXluT2xuSHBvaWprNnY2TVJZSU5mVTM0T2FqaDdGSFVhVDll?=
 =?utf-8?B?U2N1ay9JUzdWVHZZaHc4YS9LdFlsbG51Z205UzVVdkVxc0VVMXo2TnJ3eWtl?=
 =?utf-8?B?cHJHMGxOb2FHNDF5MWJyNTZORVp1YlV2aSt5cEhqTUZBQWpZcFlaL2xUSFQr?=
 =?utf-8?B?VTlFTy9MNVFDSDBOMnJDOFlnMFVYWWQzQUdVV3RnblJtczJPTDFjOGpPQlBS?=
 =?utf-8?B?ZjNDYm9mb2Uwb1JXWTNhUmgwanoyVjBDcUl5d2ZxTnhNL2RMLzVDRDZ2MzZW?=
 =?utf-8?B?YUdZZS9Wa0dIOU0zaExZR3RhdGF2UHpnOC80bXhjRld4Y0FnZXI1TEpoZnpk?=
 =?utf-8?B?Z3UxUkpQV0dCcks3dVJiYVNlbm02WU02ZHE3aDJBcTJEa001eFNJclRzYjRu?=
 =?utf-8?B?ZFhrL1MzZmdMczNyQXFod001eFdpZEtjWUxLTVdYanMvUjNmUFByMHZrNzVR?=
 =?utf-8?B?VXhFL3BNc2hCWG5aVzIxaUU4TWVWM1hKSUJFakdsN2gyYWk3SEVLRWpwY0RY?=
 =?utf-8?B?aVRoQVJmaDZuM3J4TWZNQUdHczVWb0ZuUGhzVmJkTVhETFRndWxadEM1VXBq?=
 =?utf-8?B?ZzNWODA2Q1pvR05qRUlCREM4S0FJaFJjTmtHc1pEdHBPdGJWVndBVDdyaXdY?=
 =?utf-8?B?Ni9tS1VLNWVpVWRuc041NENBVmNYWVRhTVNZWVZGL2tsNnZPbzJhbGhMUVZE?=
 =?utf-8?B?MTZTRkJqSi9XSE5FRmtwS1hoVlVDeHZqbGdHTUEwN0tyNld5dk1HTENiRjBo?=
 =?utf-8?B?NWUxUTBudFRTQ1FFMGt2VWxVajR0OTZ6cDUwWUROTlViTG1tYVBGS0J2T0Mr?=
 =?utf-8?B?eXpHVDdjeW9iUndHeFV4SkIrc0h1cEZ5YzRyWStVWW5rSkt2VUxnYm1CSUZX?=
 =?utf-8?B?azNhUVZVRTNoaHV2djJEWHo0b1p1UGg3TjRma3MraG9mWU9nb21TQ2QySGRu?=
 =?utf-8?B?YTh1T3IyUTM2SlphQWJTaWU4WHVhajkvYzNVWWJxeHRQTmlXVHVQWG5zTjYz?=
 =?utf-8?B?T1hmTGF1bkVZYTJkaVhDbU0zdms2N05oZENveUdjUEJpaXFieVNpSGt2L1JY?=
 =?utf-8?B?VGxHZHhWbWxmdG9QMEIvSHREN0dYWjZIS1YraDhld3NjNVhMMnRSMy9FcUN2?=
 =?utf-8?B?b1dxQkRJdTBCVDFRM29rU2V5aVpSdmVOTnpjTk5EK0xVbUNZUi8vMlltS2gy?=
 =?utf-8?B?emZYMWo4WHJvUmNhcmVYU2t0TndsZUFPK1hOemIycVVQdGF1TzVyUFYzWG1D?=
 =?utf-8?B?SUpINitLMWs5N20vRWtiMU9vUFlqcmJNTit0ZjFQL2FabFFJSmJ6aVBTZ00r?=
 =?utf-8?B?V1RxK2VsVUhFUnVTd0tpSlNYMUtFSUo2YTFVOUJxTGZNNDJzYWwvQ0NVVU9F?=
 =?utf-8?B?T1BoN3BLVFBabGU2b0lDdU5NdTJqbDFwV0xBMlJ3SVl5SForNDJ2YThvcUZ0?=
 =?utf-8?B?Q3VpK25ZOEl0NXlPUUdwc1EwSVdmK0ZJVXllR3J2TGJQRXZ0emFNcm5YcWZ3?=
 =?utf-8?B?cEJuU1UwMzBUWkg1R3FxaTFwRGNROS82MUtuK1hpWGI0NU1yYlYzRFlVRnlM?=
 =?utf-8?B?Y0VnSnUrSWdKK2xrclFONkFjejA3RHpiMGlra3FiZ2dmVzFKK1JCKzlzd045?=
 =?utf-8?B?bE5NamdBRFp5Nk5CWUx2R3VpVzc0WjlwQlRnUWNSMTBTaEpBUUFVSThFV0Ja?=
 =?utf-8?B?dmEvd05hVFIzR2hacXA1WFYwd2dYR0RDQ0pPTFdPTDd3elNwTU1NVUNJcE4x?=
 =?utf-8?B?dk5NQTMvTUU1bE5EYXZwTUNyWHF1T0FWeThEUk41eEhkS2kwWEZhNGNrK2ox?=
 =?utf-8?B?Z3FjNUJNZ09oYllQcnpHZUVmUFhWTnhpa1lnL2FmdnpsVHNWTU9tOHk3Z1lK?=
 =?utf-8?B?ZkIzRnRxMHNPcWZ1ZExVcklPQjM0K2dmbmpuT0NwR2JXWUV2TWt1SGFleDVV?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8b4063-daf1-4d12-8dd9-08daf32e998e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 17:17:49.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyV1lnm3o3U7hfyi51KkUBcAdRqNTd9JGhWO6btXgVOgVJDi62SG4o/y2hYE6YFnzYw2mlkcJ2CscWb30XFnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 02:20, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 09 Jan 2023 17:13:25 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>>>>> I'm happy to help with it, but I'm certainly not willing to accept any
>>>>> sort of new compile-time limit.
>>>>
>>>> Thanks for helping with a scalable solution instead of static
>>>> allocation.  Please include me whenever patches posted to LKML. I'm
>>>> happy to verify on NVIDIA server platforms and provide test
>>>> feedback.
>>>>
>>>
>>> I offered to help you. I didn't offer to do the work for you! ;-)
>>>
>>
>> I've looked at the IDR/IDA API. There is no suitable function for
>> allocating contiguous IDs to replace bitmap API.
>>
>> __irq_alloc_descs():
>>
>>        mutex_lock(&sparse_irq_lock);
>>
>>        start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
>>                                           from, cnt, 0);
>>        ret = -EEXIST;
>>
>> Is there any existing API that I can use for allocating contiguous IDs?
> 
> I think you should address the problem the other way around, as there
> are lower hanging fruits:
> 
> - turn the irq_desc_tree radix tree into a XArray
> 
> - use the XArray mark feature to reimplement the irqs_resend bitmap
> 
> Once you have done that, you have already halved the memory usage.
> To implement the allocated_irqs bitmap functionality, you have a
> bunch of options:
> 
> - make the XArray an allocating XArray, and iterate over XA_FREE_MARK
>    to find the free range (see how the infiniband subsystem is doing
>    exactly that)
> 
> - use another Xarray mark to annotate the allocated IRQs, find the
>    distance between two allocations, and use this range if the request
>    fits (a poor man's variation of the above)
> 
> - use a sideband data structure such as the GICv3 LPI allocator, which
>    is already dealing with range allocation (I'd rather avoid that)
> 
> - something else?
> 

I'll also prototype using XArray data structure instead of IDR based.



