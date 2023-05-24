Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB870ECEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjEXFPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXFPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:15:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3AB5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtOkPcI84GC37gWLMjazgagL15QY692clrltrvlCPIgaKWjX6GIKKnUFtHXB0ckFDGKiGS5GFQsCiJGqCXhAtUtS5PlhWPgH2MRpTtHhXlQsGcjWAkGsf3eiy0qzNaAs93NsfXS4sWBWgVtV0CRtsuPS45hyS3kGq4JP3H6hPWwdJRr27JMc/uO/dDonA+ojxwvrp+Rl+WIlO+4oLsYtbE3tjoVovoszUeUjHVArwfydwZHBV4mQvEpN2XiBrs+VX4I0pvXWAGEc5LVHrmu7fbpVujz7747Rb8yE8Ltwi8u8zUA711eYfXnGgGxoRr2UCvc55NLPf8xxHmDEMGGPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1qzclNYR3t73VCRoSW80gLDWp71p9BUsGRVbDdDKpo=;
 b=ns4EaP12Yxc+06fZKV/crJlTZQfTANU7+WXS7Tnz2Z5ic1MRTQgCxNBukQBSy6n0yfzI9o6dPo5jGAlWgux0c17zAb7vANSLPRJxsHIsWmyIuslFwhHGPQfzolFScdQ/VO1gnvO9iTFyjQDvTmugRw9r6KJtp4jQ8bcN1X4o4/4CqMvqAeiYhVxo3NfVnbpNYQeZbthrvKe+Vr2OVihBDl/i3iC+mDaCuEZw4NgV+QGpOXeJyOzpj2AK4gvBwaimkSnTiq6WPwm8tvIykd7Kk9nc34bOGjrrt9yJszxquKdV61j3XL5py5SwZeRc+zuRPPRbDsm11sVhNCAw83qLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1qzclNYR3t73VCRoSW80gLDWp71p9BUsGRVbDdDKpo=;
 b=l4+u3DsTrg6yxmtaPc6Vuz9fZEsWycIfXDMJyHNpJDoTsol30ug1PHjzlNstAwEbi/sOnWYcLYRaiLWgaJ48rz/Qet1p9wz0kROUidRm1y8UDvJfj/Uqh3EmdXCehoGKNtgPg849TY5+QPUlZkBiCHCG8oVBPQk8W/7ttCMckP+36lsRWFBG++9kRGM5NFK8gqrvmJQcoKUlhjSZsTydkJwOhjrVaYKqrOJuwnkGBcAnL+QQiX+siVW0aEJDDKhNII6wfGUObhItltHd1OT0sD+JnPDT5MqUv8ghINSu0oMcmkBAMgfHIVLvst1nq7YlrgFXnSd9pShdesJdcFJ0tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:15:05 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::dc79:d410:23d3:f718]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::dc79:d410:23d3:f718%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 05:15:05 +0000
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <ea51bb69-189c-229b-fc0-9d3e7be5d6b@google.com>
 <877csz943s.fsf@nvidia.com>
 <838a5172-f7f2-43db-e990-d38b36b544a2@google.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 24/31] mm/migrate_device: allow pte_offset_map_lock() to
 fail
Date:   Wed, 24 May 2023 15:11:01 +1000
In-reply-to: <838a5172-f7f2-43db-e990-d38b36b544a2@google.com>
Message-ID: <878rde71kd.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:30::19) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4505a3c4-7f0d-418b-9b21-08db5c15d55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sPieYeOdOmu+Bj7IGvzJL9CC720Sm7so0+rSPHgWYrjyrVHYoCZ0al7MrNE9g7+bGCfHBiV3Pj5n1Buyqd3y2enojg0UUDaMGFGPxduSFzns8YbIdQ0/oW3/zuOlU0ZW3HpxnD4hcOU6UpfD4FSDvAX8pEIVip39Mgtt7C5b7Hk+Z+PBF2kANr6Hd1ag0pXK6X4dVX70Za9WXnpxNg9CQZg95kJRYBDZhsQ2LaRIRHZvwyq4PuHPlpMWY1IgxyoTyc8mAfXZ6shJK+/MicPbYkr2jsA0fkzSmjpbG3mMupcWO1XCBh4gmx+mCocRMm413hLHAHW9DEAnAslXpwrKp7lZHqW/hwbFsaalvaiZLkrBfd9ZNr5Ogbd9xkgmAWlz/kOe2IUBzyOMhmjTEHDjNqCbgcCFAl4m6E2Ov+M8VgwaKWqE+PVI0shcJyryWqIQ37ertQCO/ziMvFnRAQUcrtiLoFJNF/rQztjzn5vu+K0De6L82icWdoU0nDeMKFtFlTJncir0z2ee93rgd83BDKy29/7jhsG4IRsNnud2duUN96Vmx7JlAfrd/HTA/2H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(5660300002)(54906003)(8676002)(8936002)(7406005)(7416002)(6916009)(4326008)(316002)(6512007)(6506007)(36756003)(186003)(26005)(66946007)(66556008)(41300700001)(66476007)(6666004)(6486002)(83380400001)(86362001)(38100700002)(2616005)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJcXUYCwI2DufOgfZ5RRN3nXAAYdZB8sQ+jVinevjkVx6l4h7pQUzL1azURR?=
 =?us-ascii?Q?hjufR0MnnoyUou6K1VryLM9H7Vn/FpxOuTODjDr2anbJjPqPoNvlPfT2eXj9?=
 =?us-ascii?Q?lSgoYwDp9KJLbVLPEO+NZsV+aNP3H9OUXwWYuQfGQ6yH5FOYkSTx9SPL3svZ?=
 =?us-ascii?Q?RGO9NPe7kYWSixZ2bKi3gxQdFRN6h5dzmuwIScTWxOZLrfSuXy+hReMWRkbA?=
 =?us-ascii?Q?U54xiFsPawczOL8v2+mi2FOzhgsVsXlK2wte7eyeRnJZGUtltL+VFl9cRt/q?=
 =?us-ascii?Q?A3KaMR5LLc/bSS+wPLCm30K4R3XCa1Uwydngf4/4AbQFuX7mvE3jjhB8ezGt?=
 =?us-ascii?Q?mBJBLGL+wqGdc6FBKeIoicb5PnKRbyRRlTXsFU9f9mLOaj6VATZzBH1FKmSF?=
 =?us-ascii?Q?iWnSHtHhuZxEuMbV5txodntMhjX33F2IqHWuF0GDiN/84cQq0A3PpiXJAZjx?=
 =?us-ascii?Q?4UydYLphYJFp7b5nE39QJASdU8NPSaVZhc7IZZUh8+BnrpgTBmPWPCZjkRyl?=
 =?us-ascii?Q?M9Q6oq4zgpkUpAOiNtW/DLu1X1sNul/ogTQYLuwQs4lWMCDt5Z/3+1bytkuL?=
 =?us-ascii?Q?o2X7JTOFdKtK23NhV2sK7nrxzKaf14bk5DfZPK/2N6eCn/xZ6mKn0oMFd7h9?=
 =?us-ascii?Q?mqGMlzxoOUrgBLA8S8sGpKI6HDqMf74BDghSwP01ej1aMK8fK3g28jbkA67C?=
 =?us-ascii?Q?bFdheVvkqBAKHdW7Xv9kO0+COpy/LaFyteausNw3/a2DBB1d9m+Qe5X98vDQ?=
 =?us-ascii?Q?W/FHq695re8F8UCZt9m+TmBzOQd15cZ8vcPhcQ0ehbleaKI2LN2LGS63Aj7c?=
 =?us-ascii?Q?+Sw6UZWXjm5O4Srtf5Ln/dIJ2PXQ8defvdXB0LNEzWOh7cwJMx3e4RafU87L?=
 =?us-ascii?Q?AxzljEdkXzNbwsXOzGWlRzvn5U/kt1b+KDVqUNTJ4TieK65BSpBpHArPjRiZ?=
 =?us-ascii?Q?SDLDHjoGsGpKfEbBV7awxr6mQbXvPez23mklCuy0kXpgPdBRZpezYDy3qhqI?=
 =?us-ascii?Q?A35YBM7dXv3P2173GSxEusmvK5x1hfYq/jOn7/yXeeRE0orEfpzEhAY7vCST?=
 =?us-ascii?Q?HByGjId+fKzbrWS5bHTS8JPiKKPPzB62h2xWYv/UZpc0PgrnbCzUMjg5oArN?=
 =?us-ascii?Q?wFKE2Mp1IgYQlpx4sVLEhcWzZ6G/W2Z1Y00fG1xg6daqp2kJhohQqhbZFUao?=
 =?us-ascii?Q?U3XwiNp9saXjuPRT4KCSOfkZspzBP2r21zg+7AaM86wmUUPZf2tSwcA/Wtch?=
 =?us-ascii?Q?E0FDJydQGOqDMfRhvNQEsXr/rnKGUoDB7YXobk40yf1Sn4HRaIcotTHzPyYv?=
 =?us-ascii?Q?8Zf+Dr4ihwAjwnX3oEyFpQn0/k+65UByON5e8RK+ro+n5dAf2w93YdZYRPwk?=
 =?us-ascii?Q?gVOBGfuvINbieTKZfvjvlWAZ66cI1hpvwCSFx4dH2DBsOu54bTrbMyTl+EMD?=
 =?us-ascii?Q?Ec/5V25bXZmXWf+8xsAjBgI+OkGETJbz204/J9vv9qWbfMFurWZyAWmUzmrv?=
 =?us-ascii?Q?FXA1SbCE7xfS3CAWsvu9lJBPJnPvQVv9NLhGkbFBPPq5ZWAHyta7lCfSsAAg?=
 =?us-ascii?Q?uVwuIgtY1DwpOdVNu8qIUWfYKyJhor69xrx4GUok?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4505a3c4-7f0d-418b-9b21-08db5c15d55d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:15:04.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4auFCsChwcQDRUp/1M4LSvILoJ2hIRS0kv2ezDZwzmr0wRDMohMLiOE7bsFEgwtHbQe7I2EKeB6seYYv68dJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hugh Dickins <hughd@google.com> writes:

> On Tue, 23 May 2023, Alistair Popple wrote:
>> Hugh Dickins <hughd@google.com> writes:
>> 
>> > migrate_vma_collect_pmd(): remove the pmd_trans_unstable() handling after
>> > splitting huge zero pmd, and the pmd_none() handling after successfully
>> > splitting huge page: those are now managed inside pte_offset_map_lock(),
>> > and by "goto again" when it fails.
>> >
>> > But the skip after unsuccessful split_huge_page() must stay: it avoids an
>> > endless loop.  The skip when pmd_bad()?  Remove that: it will be treated
>> > as a hole rather than a skip once cleared by pte_offset_map_lock(), but
>> > with different timing that would be so anyway; and it's arguably best to
>> > leave the pmd_bad() handling centralized there.
>> 
>> So for a pmd_bad() the sequence would be:
>> 
>> 1. pte_offset_map_lock() would return NULL and clear the PMD.
>> 2. goto again marks the page as a migrating hole,
>> 3. In migrate_vma_insert_page() a new PMD is created by pmd_alloc().
>> 4. This leads to a new zero page getting mapped for the previously
>>    pmd_bad() mapping.
>
> Agreed.
>
>> 
>> I'm not entirely sure what the pmd_bad() case is used for but is that
>> ok? I understand that previously it was all a matter of timing, but I
>> wouldn't rely on the previous code being correct in this regard either.
>
> The pmd_bad() case is for when the pmd table got corrupted (overwritten,
> cosmic rays, whatever), and that pmd entry is easily recognized as
> nonsense: we try not to crash on it, but user data may have got lost.
>
> My "timing" remark may not be accurate: I seem to be living in the past,
> when we had a lot more "pmd_none_or_clear_bad()"s around than today - I
> was thinking that any one of them could be racily changing the bad to none.
> Though I suppose I am now making my timing remark accurate, by changing
> the bad to none more often again.
>
> Since data is liable to be lost anyway (unless the corrupted entry was
> actually none before it got corrupted), it doesn't matter greatly what
> we do with it (some would definitely prefer a crash, but traditionally
> we don't): issue a "pmd bad" message and not get stuck in a loop is
> the main thing.

Thanks for the background. Either skipping it or marking it as a hole as
you've done here will avoid a loop so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

>> 
>> > migrate_vma_insert_page(): remove comment on the old pte_offset_map()
>> > and old locking limitations; remove the pmd_trans_unstable() check and
>> > just proceed to pte_offset_map_lock(), aborting when it fails (page has
>> > now been charged to memcg, but that's so in other cases, and presumably
>> > uncharged later).
>> 
>> Correct, the non-migrating page will be freed later via put_page() which
>> will uncharge the page.
>
> Thanks for confirming, yes, it was more difficult once upon a time,
> but nowadays just a matter of reaching the final put_page()
>
> Hugh

