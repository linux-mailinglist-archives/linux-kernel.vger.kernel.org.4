Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51FE5F6AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiJFPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJFPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:44:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC776973
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGtPx+dPNlmLAT8O8Cbz6ECw7lyOwzz2JRQMtDWnp7PDSG1RNcQuuk1xyOvub8kLEvzxdBI/FeQdtcCjcZ7Mz2cee2H+0dJLbKL3CJAzFX3xTiyn11BEKLt2Rkit6SVJM+sn6QsF6g/NoMiDt72EnVbwGTJaAtUdm2RShlu0lfICH9KwbY7u4nGBut91uyDOm/r/bH5Pbg8SU9wDnlLKQJlBzLD3sS1KiQySRAX+P5bSOok6tXRoDf6eO7ckYQWo8yJVN3CR9G5Sp8jGciO4/rEuZdI+xVSC3OumX7SJjuEf7ouW0T5nkNk9bKsJD3CS5AJstN/vCW1+ortaq++wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmQEM4vqsF0tmnZ+y1qNpzcSWHkz0w2rU4K4UATW4AM=;
 b=BwuPNiJjMcbY15pXoAMo85js3+Uy9H1JxPlDQNMGtyy3Qpxw4pvtqoYIa+0VqehFZtIJke254A9k/bZTeMM3eG38VCHxYbjPKM/a8Rqsw7krF4Krt9raq4cmaNB6rXHfIsaydeJzGGRK+i03mkwLIwU/yQuUkZAwJm5H2Df+0kCtGodArbKhTIh22gyf065hD8NkhQFlOGBPuSUOi9NYEf6Pc9BhulQiYUFthhjyXR2Y4t9VjB7P/BjLtxz/3DuZBE9z+lfnNULSzMQuVQR29aUsKYpNZDx2ZXtfOMgbXTdC2N/U7+43ik+fpvlBdnezO6b3EDxGAiMF6zfcyIqtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmQEM4vqsF0tmnZ+y1qNpzcSWHkz0w2rU4K4UATW4AM=;
 b=UMzC/2E7MSLpL/vE97AwTYMN7xwghHXC3uhn+yikMBOuJBf7JPtubR2zUhOrCQmDDv0tQKP6P5ekUPTdpB+Dhcn40PHaFvLQJLfdSKaiJ/rjASKbfyvAybsVqRdGd0/cHvXXEwn56d96qDAj6wsmCakmA8l61A+q0sCYFymdZ/YsVHSAaPRNk38+zh0hGdhyZYoaiCk5V86pE1TT07AJNusMuJ4Xs0IyrCpVIoTVDcxwdNdbMpMgV3wHdpMM6UTsnihSCbBFUjleXTE5fSrUA68Oe6eKleiKrLl/cRpPbNb0E0McKhr5Phox16P7dW81Ik3SZPhpGWQss585b63S3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 15:44:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 15:44:24 +0000
Date:   Thu, 6 Oct 2022 12:44:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: ptep_get_lockless() on 32-bit x86/mips/sh looks wrong
Message-ID: <Yz7316NubHtw2xCa@nvidia.com>
References: <CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:c0::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ed2f24-94c0-4cbc-5354-08daa7b1a4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCIKtUkxIemSeOf4tjeSPuBWaZ8z0Spznj5JT8Z0Fch+rXgzI+gW3vR8/oJF01HA9CUjQDnf4DEX/LumKWLGOYVIWMJ2O5WH9iNBe6rhLSIBfQR7gtGHxauQCKyNpgWbZjm1rkvBLtJnh0lp06+DEMq/nfox4hYwwwwOqtpvYGp/MQrURpxDURx4AtdpYfe9i8tWyNU+/QXYadjz+v9SgvqNaunBF9skldgd4Gdax1+8JmasKNt+UNvoznPtC48Kyq9uQa3xP7uiaKJMFozQ/1g2bi5qGKIndn7v4UikqQ4HYRvsxi/WetcE/ytNQmqSw94S7w9BhyItklCeMIfHnk36YyhbJQKki86YS+vVt2H9MKgZlUqBtOa8TiAHjBfy8YaHTVGEgje5MAyxgtrT2YuVSclA/6ZU8oDLASiI64qGArJ8Qpl8TrDqHniyRDVhMMdYSJyI2+0XswjZwsuDINdj013//vOHqE/W8+gl77pbNHn/LhBYtD8xRgclsyVH/Awj2RBKMO5qNvc9f/Rv3rDjQ9M6RLDBZy2X636FFr4s56m9UxSkXJqE+KcLRk1kdKjOxUHGg6Tsb/MWlfHczKTKnWI5mqGdWrCpZqSABUEkDCAQBShZkP4vD5LjBGeJC7M56rjbU4kYyP2PEHi1CqZn7QcyXtO3xmnY+hcAwxrvRw3QGCzEz3V/r1fmSe0IGJ4W68kANSnxzYUbx0pSRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(54906003)(41300700001)(6916009)(66946007)(66476007)(26005)(4326008)(8676002)(66556008)(6506007)(186003)(86362001)(83380400001)(8936002)(316002)(2616005)(6512007)(36756003)(5660300002)(2906002)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWtcOpl85K6X4EVNX50Pxuh/ItvmxTDtPEyWin5sPPmTrNnLIS09816IJueo?=
 =?us-ascii?Q?AkaAQo544IAx6Vi/Pvb2WJhdX370OJyqt6MfJXbDv+vUfHhOpe+iuqwCrqGA?=
 =?us-ascii?Q?wQ0NHAX8jIH3SJ2JfkAjOj35ZekvSdxfyMOwzFiWaLulAt5pnW+yph/DUaLE?=
 =?us-ascii?Q?Agzxy7wdgS/kDKeHTq4IwQgTR5IPrDz38yWRMCg4YqdfY2iszmsUx7inphLJ?=
 =?us-ascii?Q?DIIKWIpBxSwisJiPZrH/H95SRcO1M2khQTx6vD7cQW5d4opQWFAUbfMN0tnA?=
 =?us-ascii?Q?5bkptlwyQjpDiDtFDnQTUrXhaAFR3jLWw322kFDs9LZdsvSJr8v/UA//Gxdk?=
 =?us-ascii?Q?HZr9KxtlXjd4ISJMJyn6AL73QmgobXhcHi6LnthrQMrMCksIBE8BxI8IbfQh?=
 =?us-ascii?Q?Py/eDblnKZ8RmzhnHOELJcWk3hx9eZ+vDvm5gyw1L5i+POLnifDcYsM50WVv?=
 =?us-ascii?Q?sBR/IPFxifvyH1onx0KXdVYm+fCheOj6A9OcGQK2HdABPAKEiIem3cxAdzh7?=
 =?us-ascii?Q?bSD1q17zc0SwGfDmSCmbySO2ZYQI7+kRVT7hI342MTG73GxbUQxc5lRJwfjC?=
 =?us-ascii?Q?qNagLegVFWTc0l48krBiUXtcsrHydWxmQQghNmnStCFKw2YpFaS1Nys2U4XX?=
 =?us-ascii?Q?BAXyYVARMymCrAPmv0SsBVSYTmi0SJYFt53e/pl2R70AyzoylaLN2WL0kiLG?=
 =?us-ascii?Q?/yBJvv4i5PRLBgzZrOAXUSb4IwhfPdL9uKiBS2sYz/f6AiJGkyfsaGHGqHY8?=
 =?us-ascii?Q?fb7uehDU9erltG5625+uQA7NmfMzHujSF/+Pd6G3CZEM9Bp084jHVAkJw3Qb?=
 =?us-ascii?Q?WQ8XIEthCW5CxR4qq6RyCRuYQIRG41sM0DKZgBov6A1hp8ZC+CN67RuC8gjB?=
 =?us-ascii?Q?nvgCjEcAZ8gOuoLlXNzIuS69BJ/aR3Gf6G1x4bfQyhdyGd0Kne04TGred3Fc?=
 =?us-ascii?Q?e9lwzl+KaFbHG1qkj2+hoxm+7gykW2HNw8U/1YU8YkHuodJozHk7igF+v/Py?=
 =?us-ascii?Q?CvBCiJ9rlx3sqGC/uhrs3YyJYpwoZ106AfZqiLXxmYpNqm5CTKWdtQclhIZr?=
 =?us-ascii?Q?PnbEbvdHMqF0/ARl+6hB9uMGmbHfpPHHr1eWGywYTRZQ0gPnW30DVkiESyQ1?=
 =?us-ascii?Q?SAIHVXgd7jtPe5rjIC4ANjV+dwsYEiBVLGG1I6LQZe/b/w2K1BrxqUaoKgbV?=
 =?us-ascii?Q?KZp3Rc+3ndQp94bE706oA8fTlJsJxJMwcZmUpSLB5Z51jun3NBp/WBu+tWD+?=
 =?us-ascii?Q?YtavUnW/AEa8IzDBz68YK1vhaJlVHHW8ZZC1e2B5qIJQjWFhXXssIR/Uh/r/?=
 =?us-ascii?Q?b3qHdDrzAE13RGCGz/pK1VkurwHJBzZ95PCrS0S4mv/Me3feA0Rq/578sr05?=
 =?us-ascii?Q?BvVVzmddTOmiuogoHpFq46C7cbAzVmgymnz7LpJmkVSyvYcvUYPo8QAjh4VD?=
 =?us-ascii?Q?IJh+H6e7uuq1Z70OhvP7okRn/oUF1ZG3mrmKgnN2z8Tx8FJIuz2kT3joEq2w?=
 =?us-ascii?Q?DDyVJyKhvjPPv7bIy4062CW8gsBvJUT2oeA5OhN48R0n7fOR0WOUBqN3Cdp8?=
 =?us-ascii?Q?0tFgMTyGCztWFaUTuUg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed2f24-94c0-4cbc-5354-08daa7b1a4c9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:44:24.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycsMHouiDpeSNX2HzxuWnj854c5YfnLI1Kb6jN8gsren5iTyVO0bNU79HOD6H56R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 05:23:59PM +0200, Jann Horn wrote:
> ptep_get_lockless() does the following under CONFIG_GUP_GET_PTE_LOW_HIGH:
> 
> pte_t pte;
> do {
>   pte.pte_low = ptep->pte_low;
>   smp_rmb();
>   pte.pte_high = ptep->pte_high;
>   smp_rmb();
> } while (unlikely(pte.pte_low != ptep->pte_low));
> 
> It has a comment above it that argues that this is correct because:
> 1. A present PTE can't become non-present and then become a present
> PTE pointing to another page without a TLB flush in between.
> 2. TLB flushes involve IPIs.
> 
> As far as I can tell, in particular on x86, _both_ of those
> assumptions are false; perhaps on mips and sh only one of them is?
> 
> Number 2 is straightforward: X86 can run under hypervisors, and when
> it runs under hypervisors, the MMU paravirtualization code (including
> the KVM version) can implement remote TLB flushes without IPIs.
> 
> Number 1 is gnarlier, because breaking that assumption implies that
> there can be a situation where different threads see different memory
> at the same virtual address because their TLBs are incoherent. But as
> far as I know, it can happen when MADV_DONTNEED races with an
> anonymous page fault, because zap_pte_range() does not always flush
> stale TLB entries before dropping the page table lock. I think that's
> probably fine, since it's a "garbage in, garbage out" kind of
> situation - but if a concurrent GUP-fast can then theoretically end up
> returning a completely unrelated page, that's bad.
> 
> 
> Sadly, mips and sh don't define arch_cmpxchg_double(), so we can't
> just change ptep_get_lockless() to use arch_cmpxchg_double() and be
> done with it...

I think the argument here has nothing to do with IPIs, but is more a
statement on memory ordering. What we want to get is a non-torn load
of low/high, under some restricted rules.

PTE writes should be ordered so that the present/not present bit is
properly:

Zapping a PTE:

write_low (not present)
wmb()
write_high (a)
wmb()

Reestablish a PTE:

write_high (b)
wmb()
write_low (present)
wmb()

This ordering is necessary to make the TLB's atomic 64 bit load work
properly, otherwise the TLB could read a present entry with a bogus
other half!

For ptep_get_lockless() we define non-torn as meaning the same as for the TLB:

     pre-zap low / high (present)
  restablish low / high (b) (present)
         any low / any high (not present)

Other combinations are forbidden.

The read side has a corresponding list of reads:

read_low
rmb()
read_high
rmb()
read_low

So, it seems plausible this could be OK based only on atomics (I did
not check that the present bit is properly placed in the right
low/high). Do you see a way the atomics don't work out?

Jason
