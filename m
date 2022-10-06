Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6A5F6B51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiJFQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJFQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:15:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B157B795
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3rRUVJp8Ln5aHpql2ZQJ35FZISrML7rSq8b+gdR8oJVb2+0IQqQPApc93AklFdrGsqGib5T3kKuN4UMHNekWq8Ez9+hsJZTOY4y/VS7dfPzfErNKklKESjNxApPQMkpiNvHgHrcbE8TVU2zT4t1VwLGHsI/NV5hOFlslAgqvLFS6EdZF4u+vEc0xCjMUfUCQ6j4sSwxgemnzT8ED/UmS3RLaQIUZ7i9L5ZYk8Sgw/4xoc+TvGvcJAZg8e+r4r9zpIDMAAQNU9fBxMoUQMUI/UD8N3iDC34wETIfVMpS7E7I91yhCNe5oy+Qu2PrUDhSAliAYMzMVlxcs7lHTKDSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmjf5m3KCpGW2ICpmFOnWErY7GsVH5nKyBhG/MY5SFw=;
 b=faocujJIVJh6b/OpFJI5Jv1CFuzhLmUHX9CQ6aa002Ca5rCpKWpwwSStVnhCgK+C5VE3TnA2f1OQxF2i8DXhMS5RGg1DnNcRG1j1VViO8dm7jiRHlIMXCJ3BVWPzzB7Rmdja6v0bxo0kGgxxOUA2LfKnKlpt1IZVkdT3g8o9CZcs02xEI4YaFT6rWgHFBBS0s5AhzQETsBp46UAG2Ds01QVpuiHiHP34cfmeFT/yhpcnMEo50DIG04uNIITGv/U4Lg8oluwgyHOrDlaPBS/tQZKsn07f/pbo/1H/Xu729uFKxgWZp3fVbbBzWVJPKCSJTP3eKgVYIG1v2qfw15kTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmjf5m3KCpGW2ICpmFOnWErY7GsVH5nKyBhG/MY5SFw=;
 b=MQM1Ri3iQ1tZbESUnWmzbPM4bn3omwdDg0Ifhr8HqREnD/1/im0F/HeAWfSdNETFia8XjEDJyOCKuR1rXMwWgjpHT3nv6QtJizSUNV5PzXnh+oK3EXBdlGqq3cq1sMKQ6YKxKgxWiXbWy7zRDbEcIG57lcwTEgCNWYPOX8K4sBXrOLRIaZqFaOKq/NgHfK4Onw+Qonv1DjjhfAhUUIHFPw+D/d2nBP44cjbXMzSH6w31Vo98QSwa82s60fUXpY/Yugf0R+7UZhWEYLvE4CcxJGPV3y8qevIvTVwKVGeAubPhMK1bVrjDJN/m4bj0h8z7jEDuCD/SyD/xrF732wcB+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.34; Thu, 6 Oct 2022 16:15:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 16:15:36 +0000
Date:   Thu, 6 Oct 2022 13:15:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: ptep_get_lockless() on 32-bit x86/mips/sh looks wrong
Message-ID: <Yz7/JtbinFmNpQMM@nvidia.com>
References: <CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com>
 <Yz7316NubHtw2xCa@nvidia.com>
 <CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com>
X-ClientProxiedBy: MN2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:208:15e::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: afb3f3a5-f45f-4174-cb66-08daa7b6006a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aleVHIiE1oJ6ccFjTfjaWuh5c1YFp6MLlP80a7PJHNkM2WvP7ykEn6AHcctEG1wXg+j9TSCmP3ATBRysgjDn523ns9EH8QjQTTtchQrIfNBvO6Mwc7otfYSrL+Rcm8CKMC4w3kyiZN2lDFfySo34yB26I0E0WC0ioMTe/98bhi0u7u2p96uy3LuR+XQuRLzcHOT8EXWuzxp5JKjHCHD6T2TvnvI5LGXbesqzh0k2PmYgSqhrwQYpS3jEeukdaOf/vtFimEkCCx0n5cJmgoh7RG1LeiycJeAU/6zZrCYW8O+i1tmQD+Y2tHonqJc7chvlEWpRlb7r6kn1cCu92C+OM1phK0QJ1TzzUt2TxNkWE4liYi4wQgufXt5yow7FlxCuaiUMFYj3F9s4ytoiudfbE7aABw13rYdOC6z+uYEoZTIi/jnMn88SX5jhnhrEC32ASSmYeOJsXrF6vCGh/Yd3eVgf82AqF//S+APV9KRM6AuqcC2FFnW0GfLAocdk8OjnnLj4yy2Y2Wkh68gXXhOKgXk5bB2Ih3y8KdFoUs/ZEknkGWM1LeNb/ItnVwlaMX1j5DjnTEhaEc1HxJMBnxiExJIiGm5lv+ZifSnLyWMVkV5cpIXqxsen1eiIuyGDEjtr4z7Bj4mm2JKWBlo0W+3blbeBnyjc5v0dlELxL6PZAlkjhz+349I8sO8iLtV8BtLvIsaZfJfIVh6JkHFg8Cr1eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(36756003)(26005)(6512007)(66476007)(66556008)(66946007)(4326008)(8676002)(86362001)(8936002)(2906002)(5660300002)(41300700001)(38100700002)(316002)(54906003)(83380400001)(6916009)(478600001)(2616005)(6486002)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bpTZhR+BtpZo1lRG8wCSVcFUzEP59Pb1W3JUiatZj27e92WOVHJPNPWbVEBN?=
 =?us-ascii?Q?3oYuCyS9cRb+ykOsDN3oSV9jDLadZ9O4i3L1/QbCBRt3k59V06jq+9ASOxy+?=
 =?us-ascii?Q?vZVe+LeiMvLFJDylA/JEFKcogsV2WVMXOWfajbVHoCRn6lF99SMf7okO5eBy?=
 =?us-ascii?Q?mtFulKn48Lf5Zb3MGLi3Q+EQWICwlpI7AK/mHdMVWB37T2S6O42HPLZHLsOr?=
 =?us-ascii?Q?PTcTghVB5PElkWhoK9E3R4CHOOxh4tKePw1i9sY+ANNW7b5n1bIcPUafaofg?=
 =?us-ascii?Q?b0ll1JPi94uUq/L4B/nx36/sebHWckUX9UqQ1rlcw2p4oMydNTOdDHjEmUMN?=
 =?us-ascii?Q?gvjIqgU8J2CHIHxwWAwFg4i449QV6grGNtO3cdWgMxhylERpW3Aberadkd4B?=
 =?us-ascii?Q?BjIdakgdW6PYGV9EH5As5S7GNgYhR/bG7gosc++Cm+A4VEVzDjgJDq8/AT4U?=
 =?us-ascii?Q?5FVAhhRkI0Opwzjn9rBKmdoI9HauyFm+5IwunDNwxRmUiYUquUN2c+9Mfx26?=
 =?us-ascii?Q?crD+m+Aqy12dojitr7K9scjVPv0vxWh5UhTsGWHB/K6WFlcRbjIbxmQ3ctOq?=
 =?us-ascii?Q?iXnqtGtq3rgAxbIVyiA2h5oAfVkb9h7J4vYOBOd0/b0NuSXViqC2dGeAdo4j?=
 =?us-ascii?Q?5eN/xhMChOz3ui4m0K3rEYeZ+lYcwG9IF6A6X20Un3fmvbbFFptGz4blK9J8?=
 =?us-ascii?Q?Ar0efxJXMrZXEjZ7+yuLOj+Hwrji3A3MN6IAIbAkgUKGUo5c3ZpmnYUZr9S3?=
 =?us-ascii?Q?4xN1EveUanG85dIJ2fXlHdiXv6UrkO6MFCaGcJI01lCYtbpeEPCBmfBgjkBe?=
 =?us-ascii?Q?kEEBjLusIdsnxyYBe4/rEeO+WzjUci3/UaIPpH3Nbl8mq89s1Akz6fa/gzNO?=
 =?us-ascii?Q?8LocNI48i7/x/1GopSG3l+5kg1/7jWrq1IHf562akUk8MR2ZHYCP19Y+RexB?=
 =?us-ascii?Q?gDQCPlPTfesGObOeZt8bmN6VSvNr6pZQV13HEdGYm7YK9vnsnZiB6/JB525A?=
 =?us-ascii?Q?d9VXtX+IcmgEaWdX+Ua3ugW/vkeDj47vLi4c7cI4lJTYyMLNr1Ja+eArFJZq?=
 =?us-ascii?Q?prNNL6UX+djB8X/NL+FJX0GObQN44JOiAVUj9IxGLJVBQJ+3pHYJPjGvlex5?=
 =?us-ascii?Q?WuGyQ88zR5p8/rMkCikLJFFPAfvrzTUDYrT4sVqOI7KDwoSfFO3Ad4SMnEDx?=
 =?us-ascii?Q?dX0lzR3DNA/dK0scABbj9utI/nC2ManHTxJHQlNUoQrsZVnOgXyL2Xq8noOD?=
 =?us-ascii?Q?M+hiHSOGIoii3zQR7drFmOb4n5k/J4QMKvwcAi6Ufi4EjjGjpWQvOg9nc/qj?=
 =?us-ascii?Q?7bRUtba9RE0q9LykdOloSawHDMr6XRrPKhkC1NUXUICBBZtbFYm/6juYWXTO?=
 =?us-ascii?Q?lKp0R+dEswzT9dQX2k/l1OptN4Q6dguWEXc95Eqr8UpS3caTnqhRd7bsXrzn?=
 =?us-ascii?Q?31QAKqrd2oFA//+J25a+FwQeci6ErNhQPkiuGDa+w6RURLBbyyVzaQxO4Rhc?=
 =?us-ascii?Q?H9+b/ppcHBpSxFKgXEdSzJEPunMLpze0LtQQp+rd0mqc2EIJ/RQjqHsYzaf9?=
 =?us-ascii?Q?ZJR0lMmeeGyV0pE7n4g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb3f3a5-f45f-4174-cb66-08daa7b6006a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 16:15:36.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFs5pQcHh5wlE0TtEvtJ+yKHXKZd3tH2PUnQlz+yV+zc/0/tzceF+Wk9FQBs5HoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 05:55:54PM +0200, Jann Horn wrote:

> > I think the argument here has nothing to do with IPIs, but is more a
> > statement on memory ordering.
> 
> The comment above the definition of ptep_get_lockless() claims: "it
> will not switch to a completely different present page without a TLB
> flush in between; something that we are blocking by holding interrupts
> off."

I was always skeptical of that argument..

> > So, it seems plausible this could be OK based only on atomics (I did
> > not check that the present bit is properly placed in the right
> > low/high). Do you see a way the atomics don't work out?
> 
> The race would be something like this, where A is one thread doing
> ptep_get_lockless() and B, C and D are other threads:
> 
> <PTE initially points to address 0x0001000100010000>
> A: read ptep->pte_low, sees low address half 0x00010000
> B: begins MADV_DONTNEED, removes the PTE but doesn't flush TLB yet
> C: page fault installs a new PTE pointing to address 0x0001000200020000
> A: read ptep->pte_high, sees high address half 0x00010002
> C: begins MADV_DONTNEED, removes the PTE but doesn't flush TLB yet
> D: page fault installs a new PTE pointing to address 0x0001000300010000
> A: re-read ptep->pte_low, sees low address half 0x00010000 matching
> the first one
> A: returns physical address 0x000100020x00010000, which was never
> actually in the PTE

Okay, that does seem plausible :(

> So it's not a problem with the memory ordering, it's just that it's
> not possible to atomically read a 64-bit PTE with 32-bit reads when
> the PTE can completely change under you - and ptep_get_lockless() was
> written under the assumption that this can't happen because of TLB
> flush IPIs.

It does seem broken then.

If the arch can't provide an atomci load, I suppose the "easy" way to
fix it would be to use a seqlock to protect it..

Though in practice the chances the PTE changes multiple times between
two loads might be sufficiently rare on already rare 32 bit high mem
systems, perhaps it isn't worth fixing..

Thanks,
Jason
