Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFB5EB5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIZXcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIZXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:32:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A39E79625
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnQktm4fWUz+X7u1FpFcPxWSkXKgAyPcyH0hsYola2HfHhvgQeuzXCJDpsdxgvpCcIZ5VHJKnH1YBSns0LriWVPYod1WAYgZtj5dAHWzkwla3T0pxYOGCDfAcCC3k/+acNCzCE1WmgjHq7J4K0849flMGr4doFq5ozl4Vi+vfEYRw/06QhCt5yMEbJk52TWyI7e/okgtIlvDEdPwRjeaR9Iovutdcn/K4XxoCpCHft5JGxU+aTI9jQTjfPovwYn2zkmAhDHA6hlIaGTHs+SFwYmVJOXqgbyWCoSBihf5Fg0F8PYMi30EtNg0X2ZZOnwlHAlpB5OWan+JmiQp7QQf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsbQDCCiblilSnhF/vN+4JhszxpDTDU+h260WYwlCbc=;
 b=mCpOGURa41NNrhIq11ny1Ta+lBIbcJN9i1e6KnnCxVL4b+IlmsMoc/3u1VH2GDyhFRnGt0tVpNl4U0SPvFy64Emv37+NgnNVVnL+MLFFTezG0Lw86kmCz4e7Lg+QZCdCJTFv2v6ypvTqYktRjGzVgNoJRFAcOgPFhSVbBe70OHW2YosnJbQBhjI7Dg/o4JMePtSpiLg3NmU1MEHc4FBWO0U+WYEedIhY8TMXLuknfP+YqE9h56G4omudId6ymLMYK2nQxUUfqxkFJSKQnDFvBPRfBv/jJRnhED8sGe9AwSndEzPIjwKhnpz2HDIMwSRKsHTYgFTOOR032X2FTThXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsbQDCCiblilSnhF/vN+4JhszxpDTDU+h260WYwlCbc=;
 b=qHT3x7ggcu2dO1NJpeNLK5VoOUfgK12n4zhgItsp3ANNiIduUt2gO5q4mNwC70Wx2LK/i1NH7lxHLeoB71YVr7QAGDXIBq2kdqhg3F3mPVYDb84UJEj+ko7iAfwIY5nVA/bmxLGC65G2Ar36V9rKW842CxgZIcpb5fvw+1YzjCzPCqAFBWyA2O6KnvQOIo+ECmCbathi8O7uA/yRoxSOh72w8hrkezyb+o4vM89boJO56GqJypxs7cy974O8UktaTidw4F3UZbOhBnkS/K+UqoJ0mQj6PvUGnbmNZDLFORVpDNKeP+S2TTKUwa9z9SfXr3ssg8aijJwfw+uKLKxKag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 23:32:33 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 23:32:33 +0000
Date:   Mon, 26 Sep 2022 20:32:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush
 and mremap())
Message-ID: <YzI2jzvc8D9lYU6G@nvidia.com>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
 <Yy3skVk/DvwVnPXD@nvidia.com>
 <YzIHzIxknGNba6CC@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIHzIxknGNba6CC@google.com>
X-ClientProxiedBy: MN2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:208:15e::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 184fd604-8d6e-44be-92ce-08daa01762c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZJ3jzRs6cA7NtElXqt2AB0qc+G/HFufeUJPfjvX5DSQ36mhXtPgGrdpvkQRpP4fUvjs87sPYIh2oJXcqH19QaLSnA9PxxjE6Cua4bQbQyenFe1UW8UibKVupUrqxx3Y07Vw8DX8TOw6Pa09c4edTcjTWI1CN/KCO69lxA0EbbsN62tbzyZju5zprIycY500tb1MTUDMUe1JsfRB/oc3lEdVBoy7xFCGGFdjkZqnblPu2pYnaESlc9hN9NxuYDBO9wPhs++aUKCqy2f43RKEXLQwUQ9r2vZJ2IizBc8rblSsVVVclxtZ98oHX5aJFH8B7jHMBmNel757BBxr+T3d6O924J5eUgvgLONXdskfBIAR4tq+xyr5dnhUd8AgiR0jN/dwzw3BUocBQ4Eh03JyYqGTBam50mpe+ps+On3UUFjJ7ynWeYhyw03OWD7iKrQk37XMLC+YY2LzVXJHL3DHJrbcN1b/00x8hd2IevhOnNw02kcw1Znq242KuBOefAe8Vf//U2tpcGg+E7fXt9EFaE09l0kY5gssypy7Lh+Z42iElYMAZoXNi0086a0V+Nl/J+hXOsZ0laai7+3TQMiZEtsL71HQijKq5x5KHBtB9P57LBVDFP/fBkZvsj8CTI/XrL1PkpGyDg6u9Dw8EnloWoTfI2YH44wtjsDeY06BNbWs9MR0TUplVplYSVI2/cRgD6xkFI+P72qZJAxZ7f+85Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(54906003)(316002)(6916009)(8676002)(478600001)(6486002)(66556008)(66476007)(66946007)(4326008)(5660300002)(38100700002)(26005)(6512007)(2616005)(2906002)(36756003)(186003)(8936002)(6506007)(41300700001)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHpz3XLNsQLnAfC26jtqydNC+j8h4uJO69zaiplO07VzgDrhUvY0RkDNnQFk?=
 =?us-ascii?Q?M+5AR142qBTWrjczPZYuV9VtxFpvyvyHYPIui+LHW6DXSdmQUOjKqmUWE1nX?=
 =?us-ascii?Q?K9romB+i7E5OjR8wOr10DyjmQlN59W+tdawiCOO8eOo5MlqePMxGrpkBUFDv?=
 =?us-ascii?Q?tz7dMiq7uef52iNUWJ6rfX503JbKB8OKfwzAKQ6IDAZKveXZuyyDpcj/Izli?=
 =?us-ascii?Q?626tWkJfV/EgwHC0vhGGJk09aHyviJbeEXy8fjYZb7nx9YBaUTiffnMl2kcT?=
 =?us-ascii?Q?cG0bl/ZoViECwTm+8rzK5I5ZhMJyp0BD075DgnR1VFky2Urr9liSt/u05haq?=
 =?us-ascii?Q?PdBepiM2W9Un6vI7oj4Y4ACHXK0AZYHLk9TvNclcDqxhQ2/5hfCl4xw0Toww?=
 =?us-ascii?Q?EhK4Tn4iFsAWulrza+DmQb7z5Qm/gguSRMSLsawW7IZW6QsN5Ma8WQojuSXM?=
 =?us-ascii?Q?PEACcWnw5vVE6D6b+JE0042X9E20KjylZYiiWoTm8xBThlqFL0jynIszthvf?=
 =?us-ascii?Q?GHKJWARVZMJWTjUY5DQnPjYYd5gOrhG7snXkEQGkhQbMuK/EAXGUBvybYQSY?=
 =?us-ascii?Q?doPUzW2DzHgdFz4m44FD4dnc0RSjgu5uJrlpaTtmsMv13eFA4NPmoeQ9jYuN?=
 =?us-ascii?Q?5qu3i9lGqhuEZR/hbli2yqD3zv3JAjw9lYv1l9y0IbWBcHbrAhVvZhyv7jHT?=
 =?us-ascii?Q?5OFVgv6XYTD6wXiU8KKCcxD9U5RrswBIrPdJZnXQhak0jzCtcrfbhcXlxQHl?=
 =?us-ascii?Q?BMeYT5Dm5sO5xvLQzlkvZBm/UUc/7yQt/phFfkhCoJ7AausXckJVOavKjRL8?=
 =?us-ascii?Q?jm0sDc6KnMPCl3NcK7AUNePtyaydgZ5zzr6KJiPNc9YHUfSk6GyBfWuragAx?=
 =?us-ascii?Q?E7NzhMrlYhz3kw1AMvDd2SL8tNdVvQbLnay5oVxv+0mlrBQaszTDGiLwTKGh?=
 =?us-ascii?Q?wQ+1X88v2NfONEk7zLBAZ+Ng/xafaWFZCsSTkAFVP8z7xnlOwwivMjb1OQvn?=
 =?us-ascii?Q?aK4RxFqoNJPFgFSrYpY/CVjv0fwWlxIUch25FOOkVSuNqNKjoLt7yCDVNiW+?=
 =?us-ascii?Q?SYt5EBwUnfUSaO7oFyByHlB9tsHOfHu79Jdkn9M/VaFYC01M5o6Jz/pl0GZZ?=
 =?us-ascii?Q?rSqm14C1464mTJ4VAepVPuPq0pDnN72CbAMgnslR8ElKkBE/v91gly1mUCK2?=
 =?us-ascii?Q?DOgLuXsTUWuX4dgPqDTmgoPEmRjXf7CW0264uHAXYwEDglXBGCxM1Yfl+X6r?=
 =?us-ascii?Q?jB/qRxlvtlKqyWjjNkYfH5zNx7cQjQbumlt/SedGPf1LGL3JCvBO3kVCydBJ?=
 =?us-ascii?Q?ncxcUshI5/Cg+tpZObrd3Nm7p9i9ELF6cNihYWZynEHMw+ASzjGP8Ep0gD3n?=
 =?us-ascii?Q?tyw4GxHQXV4EHk00KVLiwMdrqhuLd0/gfKSa+As+19AWkthfh67L3AYPTgFP?=
 =?us-ascii?Q?DiuRKG01cHMSmWjBuvngqUYk4UID4hCfdj90Y5zFsyXvXgRThGc7VHh42sE8?=
 =?us-ascii?Q?NZ/deQ6MasYt0oEOv+LDHVZeYtxsoR2QEP6aq3BsAR7hgO8C3Q8Uin7j7K2b?=
 =?us-ascii?Q?ymVjdOowXwhzKE4Lh7s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184fd604-8d6e-44be-92ce-08daa01762c1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 23:32:32.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2VXARh2hItw9weKVnlZ2lRzcbsq8C6ld+gLOs0DqI8HiZXd/UnfBU+vS1BOXGW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:13:00PM +0000, Sean Christopherson wrote:

> > AFAIK if we are flushing the CPU tlb then we really must also flush
> > the CPU tlb that KVM controls, and that is primarily what
> > invalidate_range() is used for.
> 
> As above, for its actual secondary MMU, KVM invalidates and flushes at
> invalidate_range_start(), and then prevents vCPUs from creating new entries for
> the range until invalidate_range_start_end().

Was it always like this? Why did we add this invalidate_range thing if
nothing really needed it?

That means iommu is really the only place using it as a proper
synchronous shadow TLB flush.
 
> > Which makes me wonder if the invalidate_range() hidden inside
> > invalidate_end() is a bad idea in general - when is this need and
> > would be correct? Isn't it better to put the invalidates near the TLB
> > invalidates and leave start/end as purely a bracketing API, which by
> > definition, cannot have an end that is 'too late'?
> 
> Documentation/mm/mmu_notifier.rst explains this, although even that is quite subtle.
> The argument is that if the change is purely to downgrade protections, then
> deferring invalidate_range() is ok because the only requirement is that secondary
> MMUs invalidate before the "end" of the sequence.
> 
>   When changing a pte to write protect or to point to a new write protected page  
>   with same content (KSM) it is fine to delay the mmu_notifier_invalidate_range   
>   call to mmu_notifier_invalidate_range_end() outside the page table lock. This   

And then if KVM never needed it why on earth did we micro-optimize it
in such an obscure and opaque way?

>   is true even if the thread doing the page table update is preempted right after 
>   releasing page table lock but before call mmu_notifier_invalidate_range_end().

That feels like it is getting dangerously close to the CVE Jan pointed
at.. We have a write protected page, installed in the PTEs, PTLs
unlocked and other things can sense the PTE and see that it is write
protected - is it really true nothing acts on that - especially now
that DavidH has gone and changed all that logic?

IMHO if we had logic that required the CPU TLB to be flushed under a
certain lock I find it to be a very, very, difficult conceptual leap
that a shadow TLB is OK to flush later.  If the shadow TLB is OK then
lets move the CPU TLB out of the lock as well :)

> That said, I also dislike hiding invalidate_range() inside end(), I constantly
> forget about that behavior.  To address that, what about renaming
> mmu_notifier_invalidate_range_end() to make it more explicit, e.g.
> mmu_notifier_invalidate_range_and_end().

The name for the special case should really capture that hidden point
above 'invalidate_range_delayed_write_protect_end' or something else
long and horrible. Because it really is special, it is really is only
allowed in that one special case (assuming the logic still holds) and
every other possible case should catch the invalidate through the tlb
flusher.

Jason
