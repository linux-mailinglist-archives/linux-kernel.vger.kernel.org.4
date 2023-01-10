Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0166432F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbjAJOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjAJOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:22:39 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC9751311
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:22:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSAA0U6vxGsqZRf4l08w5fS6pKVt2FT9fVBlhVpGa6xLoCf5f2CbZ7svKfFr87JFYKVEfpknZ/t6P25G16B5A27jMvA/qawlie2IggMvUsm6ncs/marecwPPMN8Whk/M6uTAw04/1vaV/C/o2CRia4m4ECeym3s0qZLAK2h2iIH1MtZE9O3MXuZywZsl+M17JrOUG3rMCjXMKY4pACEeVtBgOCbeTxRWzQdfAV0+tuWgqbDx54Ys0wuxD3dtKpbqIbBjd7krgq0r51yErE1p7/zK8GtYWr9AuHb9U0nDVnUQoy/v5GcHcgv7egPV+Fe/7P40f9ZjiAQAt+Q3rXl+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnJT4+ugXVjJhhgtdXNG7z9KuONAF+n9gCQRJTRzYm0=;
 b=cbD14fPCAgM+TQ8n2J/ODHqpGKiVCQY5zpoFsjk4NUsTFa3A6/nmj3yLfqPOvN7R7Cv6HN+l1frs5I3+1yFsBA1ZL2uqJZ5H7jTl4ELa4qQvyHhMp9n1e3pQSJ6EbkA/w9iHpCzxsJF1vh1UJZfpAf5Pn16RP5l8p4oqmo/RXE9cKU/BblEaCm5lpSRc/JK2lxWWi+80aiUcXWyVrJIediwOdeYSSu44gcOuzYETUqWd2jpdqdfFjOZ/BtVGBTOOIgr1K0kF/EQfLW49u5QJuAvNnrEgvPzUtK18jl0Jrbj68YzjLkBT9GFe4fU1HW/PEvHD3kuKnhMwHk+CmZ6pSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnJT4+ugXVjJhhgtdXNG7z9KuONAF+n9gCQRJTRzYm0=;
 b=rKbl6DmT0yPREOM/suhLfzS8uTEP21eULp3IdQ82Qwf5y3j7xdcTWn+Z6hAI5bd5IyvcBn6joofiT8tGd2EYIci0Do6YFhBNbSOVcg7tU4XccEynhUkJfEiP7IvCdAO0W/xL0bJbx/hENu/qUTy60TVilZ+iZfekWW0J35h2wiSZ9NDPgYVrfEKGqjTlOzpuw9hqO5Z7osAV00eYxog9zYCFa8MS47dvHJrAZ42Uh5UrCXo/pPgLgbsEF+SaEKJh07pUykjKVrRmgxOlXLoGDpIHtf8W5Ve9LEP7owHwaBo6zEB9MRsJI6RsMbe9NmEz/Y86i8Z53xNLG6WYIL5Dcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:22:35 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 14:22:35 +0000
Message-ID: <d64145d6-966c-2e9d-beca-b8f896c8d2f0@nvidia.com>
Date:   Tue, 10 Jan 2023 08:22:26 -0600
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
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cabf473-c83c-48a3-0236-08daf3161e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4+keyzCY8C//cdLMe2pxj9pjxTMSvVmDHitlLb4M7o/BoyDzuPZoro6HRBTY/NppTFi7+3GAM9Yw5/NZlJVARRqEWTx6NtgASObkIK0KruiO4wdBfAd0lxXLkKuQH225+pgKdH9hDD0ZFENbfsDuavWHewXzbEHowZtBm0x3pLAWTh+q4ANuKb/mHmdXDwJ+JmTOhNnc7Ldcg6KynyhGO24XhNhhXrADRmyYYNXM+VPJYOOB3CICHpi9JUe+FKLtHY3faVEd+xU5ayNjAKwFQrNceiKvA86sAA5qVP4ex+rYNne3oqrwgiHO/1pwP0a8708IjXEF+H/w26zqcomKBeUQXz8HmSjsHnCnXtk7ygrtCGPoi7Tne3BMKy+C6BYuNZA2G84aBjo5sGWLGmQ0Zm2zAFKPVpBD0FvMJ2/RKpnbyBEqVOCDFw7zoF9S0WzKy7vm1JtAMc6L4f3mMry93KUnRQQm8IZ1D8v9M53hvO0DUZjsFJOt7SrhDO78Ktg5/zXcs1WiOdJ33aRTb8uYKUNGIdkI1BFWd960HGmxDYIpmVBUJlDad8W88CItQ0Tm1M1/9ltDHgQwuP8Hf4gH6UhOH+vxGjZf4l0E0wse7bKPLoDnuq1+jFh636Bt3QuBTshZzPS8PahN+m7COlPo+vTOTPXn1j7FvL6jrlqEqMG3BgNnASlkmhVSYAywnLWLOLvMVH1m1jV2IaHBHhuvfFKAxwqzm5VaPJ2/A8e0t0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(36756003)(186003)(26005)(6666004)(53546011)(8936002)(31686004)(6512007)(6506007)(30864003)(2616005)(66946007)(5660300002)(6916009)(66476007)(66556008)(316002)(4326008)(86362001)(31696002)(38100700002)(478600001)(6486002)(54906003)(41300700001)(8676002)(83380400001)(66899015)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ynk4SXgwYjBOLzJTVUNNeW5wZnBxWklIeFQrUlp2M0czZVh0Ym1hRW5HNmYr?=
 =?utf-8?B?K3gzVG1yRVNtSlhvSlhsTFdkemg0YUtxZmZTUjd2Z1R5ZWs2UTdRK0R0MERM?=
 =?utf-8?B?MnV3MUZYTUJHRllMbm9QWFBibnBkUzRCM1QvYmNpWjBHcVlJNzhqLzZDdWRt?=
 =?utf-8?B?Q3ZSeEhBTzhoT0hHMW14MEhaQzFiNTUvL1dBbVlQdTVjU3R3cVZLTG1aR1Bj?=
 =?utf-8?B?Q2J6NUV3aktBYk9ZRkdReTNOeDhaL2VIQ0cxaVFuMlBPVmdJeTc1NFNUN3JZ?=
 =?utf-8?B?L1B5OEJ0eTB4M1d6TVhBSHhBL1JMU0QvaDczSGpMM1g3SDY5dHl2RmFkQ2RE?=
 =?utf-8?B?dTVzUm9aZmxSMU4vMXErY3NmWWk5emtocUZHZVlkNUZvQVN5b0pSdjdrMm4z?=
 =?utf-8?B?bldWSnQ0M1k5L0EwTkNBSjRJRGlIdFY4K2d1VmtvelN6dk9GRFZOVUhFQXpW?=
 =?utf-8?B?TTBHcDZIMHZpTmtLZ0paUFltQ003eHR4eU1SQUg4Y1VONzVvVWV3dXJxWC80?=
 =?utf-8?B?Z09ybkhKLzR4aXZjN0RkT0RTT0tQMlVvVEpjSjU4dTd4Q3NFelkvYk5uU1ZQ?=
 =?utf-8?B?SDd1Q2dDZ3JvOVRhS3hYR0lybHhsbW5TYmw3Q2IxQ3pmalkxRUFlSUI4LzFu?=
 =?utf-8?B?WTcyRjgwWjhlR1NGQmNNM1kySHEzcFk3TXFzbk42cjhzZFYrdm1HQnZ0MWRX?=
 =?utf-8?B?ZG5lZHMrbGlNQitBaXU5aUhQb3pmQkxudFZOS0trMnV2RnlCQ1JwdmpKbmls?=
 =?utf-8?B?Q2xSWUcrTlFIcUQ2WFRuR1I4VE8yU3c2ZWcydGgvU3R6bmNCQ1BaU3J2YXNB?=
 =?utf-8?B?RVh1T0xDZ1hpbmg4NVZJVUlaQ0ZuYW53MDgvYVNXWmYxcEF6N0xVR2ZISmY2?=
 =?utf-8?B?bkVZcWNJc3JYNzVVREMwZis5ZEhWendSTHYyaDVlWGwrOWJLeU1Ra0tvQVl1?=
 =?utf-8?B?a0owRkpxY1NTeHZtV1NNR0xGTzh3RkRHMWdkZ1Fud0RJM1l6bUlSbWwwME50?=
 =?utf-8?B?dDhGWFNma0IvQXoxVC9RTFJBYlZ2bmV6UiswSVlCRFZxZXA5U0xBeXZRNlFL?=
 =?utf-8?B?djRoOTVhV0dlT0lhcUc4blJLWUgwWEdwak1jaEhOcjRoT0t1ajI5TzVLUVFR?=
 =?utf-8?B?RlNWZlA0QmdObWRPVHo5Vi9XNWg0aDBXTGJhQURTanZtb1ZwUGJ4NitwMTEw?=
 =?utf-8?B?Wmo5Q1NPTlpqcWhUNml6K2p6TVBXRmd1MldOOUtHMlRjQU4yblptVmlaTnlN?=
 =?utf-8?B?MGpjRk41U1UzcHowNzFTMGZWSFpYWWtjYjZ6TmNkMWJpa1RJZEVGYStWRmdv?=
 =?utf-8?B?TjFvS0R2QXN2WWkxRStHSGZNdEJpL2hqbzhpbiszcjZFUmZkU0Q5N2lxNUU5?=
 =?utf-8?B?V3JDaWVQaXhmR3p5ZWRsZ2VTalhGMWRtWlN3bFR3NmpMalR5RHR1NHFzQU5x?=
 =?utf-8?B?VWpPNisyY09nc1FDNGthelFsbS9ndndrSXM4aTZobDZpdFJHbGNxcTAwTURH?=
 =?utf-8?B?STBlcUdaT0hpdmtacHQwL2VjZVozSjVhYkl1QVV6YzF4VHdOU09GNWEzSm0v?=
 =?utf-8?B?bmU2ekFXQWtPcXZxUFZSWU1jZGgrU2x0WS9hYjhkVVZSaEIxZmJUaWNkNkRG?=
 =?utf-8?B?MktsU1dMSE82azZ0WkpqSzE1TlJWbEIrSEdKeC94SlJ3enZPU2RtOUpZemE2?=
 =?utf-8?B?Wi9iWHhKdXNLUWVYMVIrNXlHdnJ1SW5zUlpOY1N6SkVWZXBYanU4bHpFN1ht?=
 =?utf-8?B?SElhb3U0ZTlvVkw5V0l1V0dRTjF0bHkwaFhhcy9wZDU5VHJhQzM5RElpUU92?=
 =?utf-8?B?MVBaYUVWVXBGc0cvWHJCZDFZUkFlSkxXaFcrUmMweGhHZkY5SmcrVnJkY1RB?=
 =?utf-8?B?dWxoNm5UQTByTTFia1lFNnk0U1ZNMWlSd0JJOUNPRGloWmZBQ1RaVW1ZUDdK?=
 =?utf-8?B?YjBDdDhmZnhmMkNabFc3T2RVb0I0WHhhV3o3TlRFUHl5VmFBYWRVSTZyUERQ?=
 =?utf-8?B?NW1WcXNJKzlHQWVXUFpSckUxTldkNjBQUWFiUWk5OG12MGV6b0RCY3VMaUdG?=
 =?utf-8?B?VmZ1SmpPaUo2REFFVi9qNmU0Y0ZmR1FtNk4zRVZoNFFrUUtmZG9seE5URS9R?=
 =?utf-8?B?eVJtckZ4SFhWb3gwY3oxQ09aQWU1RE16V0RhcVZRRzlNL0FMcGhoUnEyZ3cv?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cabf473-c83c-48a3-0236-08daf3161e30
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:22:34.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyIwSe1x+MpuP6O7wyEi8yqlvyqsRFw2Ge402bWHqP0gboG9EKbhKTV3w2KnPaacwOzdvpPlGrt8YlNotkZX7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

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
Thanks for providing the guidance. The irq_resend change will be simple,
IDR will fit perfectly. Could you comment on the below 2 patches which are
using IDR API?

One IDR variable is used for both the IRQ ID allocation & descriptoirs.

I'll test and post patches for comments if you're okay with the approach.

Patch 1/2:
     genirq: Prepare code for IDR based allocation

     Introduce helper functions for managing Linux IRQ IDs and
     define for both SPARSE_IRQ and non-SPARSE_IRQ seperately.

     There is no change in functional behavior.

     Changes:
      -Helper function irq_alloc_descs_ids() for allocatind IRQ IDs
      -Helper function irq_free_descs_ids() to free IRQ IDs
      -Helper function irq_get_next_id() to get next IRQ ID

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fd0996274401..a40ac0c58550 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -131,7 +131,6 @@ int nr_irqs = NR_IRQS;
  EXPORT_SYMBOL_GPL(nr_irqs);

  static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);

  #ifdef CONFIG_SPARSE_IRQ

@@ -344,6 +343,7 @@ static void irq_sysfs_del(struct irq_desc *desc) {}

  #endif /* CONFIG_SYSFS */

+static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
  static RADIX_TREE(irq_desc_tree, GFP_KERNEL);

  static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
@@ -469,6 +469,22 @@ static void free_desc(unsigned int irq)
         call_rcu(&desc->rcu, delayed_free_desc);
  }

+static void irq_free_descs_ids(unsigned int from, unsigned int cnt)
+{
+       bitmap_clear(allocated_irqs, from, cnt);
+}
+
+static int irq_alloc_descs_ids(unsigned int from, unsigned int cnt)
+{
+       return bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
+                                         from, cnt, 0);
+}
+
+static unsigned int irq_get_next_id(unsigned int offset)
+{
+       return find_next_bit(allocated_irqs, nr_irqs, offset);
+}
+
  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
                        const struct irq_affinity_desc *affinity,
                        struct module *owner)
@@ -553,6 +569,8 @@ int __init early_irq_init(void)

  #else /* !CONFIG_SPARSE_IRQ */

+static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
+
  struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
         [0 ... NR_IRQS-1] = {
                 .handle_irq     = handle_bad_irq,
@@ -591,6 +609,22 @@ struct irq_desc *irq_to_desc(unsigned int irq)
  }
  EXPORT_SYMBOL(irq_to_desc);

+static void irq_free_descs_ids(unsigned int from, unsigned int cnt)
+{
+       bitmap_clear(allocated_irqs, from, cnt);
+}
+
+static int irq_alloc_descs_ids(unsigned int from, unsigned int cnt)
+{
+       return bitmap_find_next_zero_area(allocated_irqs, NR_IRQS,
+                                         from, cnt, 0);
+}
+
+static unsigned int irq_get_next_id(unsigned int offset)
+{
+       return find_next_bit(allocated_irqs, nr_irqs, offset);
+}
+
  static void free_desc(unsigned int irq)
  {
         struct irq_desc *desc = irq_to_desc(irq);
@@ -768,7 +802,7 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
         for (i = 0; i < cnt; i++)
                 free_desc(from + i);

-       bitmap_clear(allocated_irqs, from, cnt);
+       irq_free_descs_ids(from, cnt);
         mutex_unlock(&sparse_irq_lock);
  }
  EXPORT_SYMBOL_GPL(irq_free_descs);
@@ -810,8 +844,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,

         mutex_lock(&sparse_irq_lock);

-       start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-                                          from, cnt, 0);
+       start = irq_alloc_descs_ids(from, cnt);
         ret = -EEXIST;
         if (irq >=0 && start != irq)
                 goto unlock;
@@ -836,7 +869,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
   */
  unsigned int irq_get_next_irq(unsigned int offset)
  {
-       return find_next_bit(allocated_irqs, nr_irqs, offset);
+       return irq_get_next_id(offset);
  }


PATCH 2/2:
     genirq: Use IDR API for Linux-IRQ IDs allocation

     The build time config paramter IRQ_BITMAP_BITS (NR_IRQS+8196)
     may not be sufficient for some architectures. The interrupt ID
     sparse is huge for ARM-GIC architecture ~32 bits. Static bitmap
     memory for managing IDs is not optimal when NR_IRQS is set to
     a high value.

     It uses the IDR API for the IRQ ID allocation/deallocation and
     its descriptors management insertion/deletion/search. No other
     references to macro IRQ_BITMAP_BITS hence remove it.

     And also covert static allocation of the 'irqs_resend' bitmap
     to dynamic allocation using IDR.

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b557579..501f90962644 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -11,12 +11,6 @@
  #include <linux/pm_runtime.h>
  #include <linux/sched/clock.h>

-#ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS       (NR_IRQS + 8196)
-#else
-# define IRQ_BITMAP_BITS       NR_IRQS
-#endif
-
  #define istate core_internal_state__do_not_mess_with_it

  extern bool noirqdebug;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a40ac0c58550..bb1febd3a420 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -343,25 +343,25 @@ static void irq_sysfs_del(struct irq_desc *desc) {}

  #endif /* CONFIG_SYSFS */

-static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
-static RADIX_TREE(irq_desc_tree, GFP_KERNEL);
+static DEFINE_IDR(idr_irq_descs);

  static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
  {
-       radix_tree_insert(&irq_desc_tree, irq, desc);
+       idr_replace(&idr_irq_descs, desc, irq);
  }

  struct irq_desc *irq_to_desc(unsigned int irq)
  {
-       return radix_tree_lookup(&irq_desc_tree, irq);
+       return idr_find(&idr_irq_descs, irq);
  }
+
  #ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
  EXPORT_SYMBOL_GPL(irq_to_desc);
  #endif

  static void delete_irq_desc(unsigned int irq)
  {
-       radix_tree_delete(&irq_desc_tree, irq);
+       idr_replace(&idr_irq_descs, NULL, irq);
  }

  #ifdef CONFIG_SMP
@@ -471,18 +471,48 @@ static void free_desc(unsigned int irq)

  static void irq_free_descs_ids(unsigned int from, unsigned int cnt)
  {
-       bitmap_clear(allocated_irqs, from, cnt);
+       int i;
+
+       for (i = 0; i < cnt; i++)
+               idr_remove(&idr_irq_descs, from + i);
  }

  static int irq_alloc_descs_ids(unsigned int from, unsigned int cnt)
  {
-       return bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-                                         from, cnt, 0);
+       int start, id, i;
+
+       do {
+               /* Allocate starting ID */
+               start = idr_alloc(&idr_irq_descs, NULL, from, 0, GFP_ATOMIC);
+               if (start < 0)
+                       return start;
+               idr_set_cursor(&idr_irq_descs, start);
+
+               /* Allocate contiguous IDs */
+               for (i = 1; i < cnt; i++) {
+                       id = idr_alloc_cyclic(&idr_irq_descs, NULL, start + i,
+                                             start + i, GFP_ATOMIC);
+                       if (id < 0) {
+                               irq_free_descs_ids(from, i);
+                               break;
+                       }
+               }
+
+               /* Allocated 'cnt' IDs */
+               if (i == cnt)
+                       return start;
+               from = idr_get_cursor(&idr_irq_descs);
+       } while (from < INT_MAX);
+
+       irq_free_descs_ids(start, i);
+       return -ENOSPC;
  }

  static unsigned int irq_get_next_id(unsigned int offset)
  {
-       return find_next_bit(allocated_irqs, nr_irqs, offset);
+       int id;
+
+       return idr_get_next(&idr_irqs, &id) ? id : -EINVAL;
  }

  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
@@ -521,7 +551,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
                 irq_sysfs_add(start + i, desc);
                 irq_add_debugfs_entry(start + i, desc);
         }
-       bitmap_set(allocated_irqs, start, cnt);
         return start;

  err:
@@ -532,8 +561,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,

  static int irq_expand_nr_irqs(unsigned int nr)
  {
-       if (nr > IRQ_BITMAP_BITS)
-               return -ENOMEM;
         nr_irqs = nr;
         return 0;
  }
@@ -542,6 +569,7 @@ int __init early_irq_init(void)
  {
         int i, initcnt, node = first_online_node;
         struct irq_desc *desc;
+       int irq;
         init_irq_default_affinity();

@@ -550,19 +578,10 @@ int __init early_irq_init(void)
         printk(KERN_INFO "NR_IRQS: %d, nr_irqs: %d, preallocated irqs: %d\n",
                NR_IRQS, nr_irqs, initcnt);

-       if (WARN_ON(nr_irqs > IRQ_BITMAP_BITS))
-               nr_irqs = IRQ_BITMAP_BITS;
-
-       if (WARN_ON(initcnt > IRQ_BITMAP_BITS))
-               initcnt = IRQ_BITMAP_BITS;
-
-       if (initcnt > nr_irqs)
-               nr_irqs = initcnt;
-
         for (i = 0; i < initcnt; i++) {
-               desc = alloc_desc(i, node, 0, NULL, NULL);
-               set_bit(i, allocated_irqs);
-               irq_insert_desc(i, desc);
+               irq = irq_alloc_descs_ids(0, 1);
+               desc = alloc_desc(irq, node, 0, NULL, NULL);
+               irq_insert_desc(irq, desc);
         }
         return arch_early_irq_init();
  }
@@ -855,6 +874,8 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
                         goto unlock;
         }
         ret = alloc_descs(start, cnt, node, affinity, owner);
+       if (ret != start)
+               irq_free_descs_ids(start, cnt);
  unlock:
         mutex_unlock(&sparse_irq_lock);
         return ret;
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 0c46e9fe3a89..1c9db8e03fba 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -21,8 +21,8 @@

  #ifdef CONFIG_HARDIRQS_SW_RESEND

-/* Bitmap to handle software resend of interrupts: */
-static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
+/* IDR map to handle software resend of interrupts: */
+static DEFINE_IDR(irqs_resend);

  /*
   * Run software resends of IRQ's
@@ -30,14 +30,11 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
  static void resend_irqs(struct tasklet_struct *unused)
  {
         struct irq_desc *desc;
-       int irq;
-
-       while (!bitmap_empty(irqs_resend, nr_irqs)) {
-               irq = find_first_bit(irqs_resend, nr_irqs);
-               clear_bit(irq, irqs_resend);
-               desc = irq_to_desc(irq);
-               if (!desc)
-                       continue;
+       int id;
+
+       idr_for_each_entry(&irqs_resend, desc, id) {
+               idr_replace(&irqs_resend, NULL, id);
+               idr_remove(&irqs_resend, id);
                 local_irq_disable();
                 desc->handle_irq(desc);
                 local_irq_enable();
@@ -49,7 +46,7 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs);

  static int irq_sw_resend(struct irq_desc *desc)
  {
-       unsigned int irq = irq_desc_get_irq(desc);
+       int id;
         /*
          * Validate whether this interrupt can be safely injected from
@@ -70,11 +67,13 @@ static int irq_sw_resend(struct irq_desc *desc)
                  */
                 if (!desc->parent_irq)
                         return -EINVAL;
-               irq = desc->parent_irq;
         }

         /* Set it pending and activate the softirq: */
-       set_bit(irq, irqs_resend);
+       id = idr_alloc(&irqs_resend, desc, 0, 0, GFP_ATOMIC);
+       if (id < 0)
+               return id;
+
         tasklet_schedule(&resend_tasklet);
         return 0;
  }

