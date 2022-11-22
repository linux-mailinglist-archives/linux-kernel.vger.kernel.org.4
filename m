Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8F634328
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiKVR7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiKVR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:59:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21200DE82
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8KaFbnmfFecjKkrdbsl9KHBv/4lo1wU2mjO+9mFJ2uCO3XLvr202VS8EGJs8LeZVVT83LuHBxZGy1FT9aPgQ0jsx4OkjHILMyUPPscvjjpwUs0S9WwdBTyUJpZMFi+4vVGm/GH8hSU8/ZpUtgJDjQ3y67WeYHv3To+EaAbtr9cspuTH6X5gbEoQg5OAWLn8ZSiiNghALw567EYQEZOhfBkpC9YZKh9tzzp84mjULdrpSXg+28twt6T8UfLoKz0KjgqticZvuRj1uVvQr3Nl3ZkSnJnIYmQhbd4HHfwbW/m4jAlpql5Ipr+LkFDOm2c4x6bR//uU/wiQ/P8trfTllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU+B+IVPY+FfM/rztG1HTcKlJsCng/wAy09i6/vV5gA=;
 b=GCuRUXKecqipS+WNO+s0woTcR2x2twHpGOgOfY+qGqANM/sZuk1P9CE+NWJdH0c7jQ0ZYcNjq99V7RYKCfbGmQhtWng834x9hPyWqDP6ybjQzWeZKazGmjh/7xJzRe/T4mjGGK6sAekwPzBmubWkiG8b+dd/qq6mk1BwubUWx+ULckqwcHyKUHWOEzSxeIgFb76xG0PQaazyvK+iLg9CT6XUvo08rU6MmYSmqjM4dy4ciHWD34leyOOXbjeJExd1Ee8iluQdKlC8UhYOKQfva54O/Z24ikV+2udmEnZ5mQApkW8Fh2aVdgAMYvIXy0A/tzzjgecqZ1DSOAqbkMiYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU+B+IVPY+FfM/rztG1HTcKlJsCng/wAy09i6/vV5gA=;
 b=VH6byiCIjnitOv8bYeai80rLR/gWSK0EEHh49S3/dtA+LblMEVN4yk5L6j/gox59epVU0V7Y8588r/YQoC1MzrBAkBbDTwfIvIAPAvEz7JOlE8/fBOZ3HkzbYb+f+p+O3YeNirQF6oM2RXOGoVmfYvy+TIrbQ97PCUYpN0mNecdlI8YjH922XDu2wk5qaR4XR+nWWfWQafReTULEHtGEzVbuQIE3ghKHXo6iD6MONXjOOETL8+0LdA1YRUJYSHKoMOgZbs1P+7BdyWqgU8MrFl7PeMHqDw9+9rjAmRdng1bpDHfGLO58aFx8EX5eVUqRDUS7HvVRUXf5ewDSNzE3Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 17:59:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 17:59:26 +0000
Date:   Tue, 22 Nov 2022 13:59:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-ID: <Y30N/YCg9MOVnhLk@nvidia.com>
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com>
 <Y2BIbyxT0Bh6bCUr@monkey>
 <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
 <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
 <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com>
 <Y30Js24EqCncvqO/@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y30Js24EqCncvqO/@monkey>
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bed215-fca7-4223-0cc1-08daccb34b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOrHlWhZS0brBpF9LxfvX9me3aoRJoRb/ZP5tcLaz0MYn5o3XqqDZ64Ix2WAc4c91Iyz4ENX4BTPr9iGs5KnxBOv1mNgPV81nGrxU65WIgDXT49Ds6rU+lsqjnT2bbMftkZ5edkqv1wb1xWeuuj/2jiOVHYurtaiO2tfmkTSH9rJEj/7KGUbl6NSFX2wGI3LRpjDIHbO6AupEYMaDFvOMgOsVKBQ82dabYArtVNKrJvagHf0flmXloFE//uVK20I47VTZD3bedPkHUArfZQ+yhgZS/1WR9EEqIXXCNqD1/xn3i2c1D6TOMD1xx5/ZPVm6fKatjV8zKv4VdWySQ7zGLqN5+Bp8clwHfxzl1ledFHirjVtfCF2nF378N8kjM6VsqqiRqvg64TCRw8tNjpTw62R78IoxE8fgZOJ8w7rVqpiu76C9kDQqWvIHlrJ4gXX9LeSv751zMQlFxJ7ZFic6dc6SOeCo1zF+b/9DOJJHkeodAJNkBMjkuTCAQM2dCWbgzKCEIe+wcwGp51KaZFgzt78OVzpv3LWBQxHDEg2Yqme+dBw/pIR2FAp4keQLVMC8KjpdK9Q3jfKYYZCT+KqRNOAblwEMK07QDKqA6g0CORREtDK1faGFwgR3VkfO9itMrmUwbzdWMhAJdg64oYs7rycc/W/diDZh11acYNZGnMKwtO6+77pA8QgpOe2ue5SG0OQG+Shux/ZLkz5D8yxWpeT92Ni406uH/MEOSII1mi9RbS2dtidAfuugNOq4WF5sfw7NCvR8+dHu1MgeEC0ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(66476007)(86362001)(66556008)(66946007)(8676002)(4326008)(41300700001)(2906002)(8936002)(478600001)(5660300002)(38100700002)(186003)(2616005)(83380400001)(966005)(6486002)(54906003)(6512007)(6916009)(6506007)(26005)(53546011)(316002)(36756003)(66899015)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qm3JodVIlce4SXirAVRnifCmujhfw81BD2Bni20jW+Od6kor7VWUW4P598k?=
 =?us-ascii?Q?YsdoIIMLVv7sX50uycZQ6N6CwnMdIV8VeAmI+QPlRxyZ1JzarHztfpjE+hwe?=
 =?us-ascii?Q?QWwkuIVohucHl8J5Qv+1bKot9465uRZR6OdCsBFGCGfqH2nR0Z5QVMHjepfe?=
 =?us-ascii?Q?owfAdTRQQ3HzzZkumypgzyAbb120Y/bIs0HKWidUHxaK2TYZDn8DCIzo2e3n?=
 =?us-ascii?Q?RNMtbakBdlZClJRAvvFJmzkXldhiP8KIJqWE4dq3lQg6NK50bSR0nH40b85a?=
 =?us-ascii?Q?iOQO97+/I4cpFcX6FGy80GkgUqtaO63aEpdGx1TMBu+TQYZ5SBZybsfabU6i?=
 =?us-ascii?Q?2Ofegb8uSDInvKTOYQNSLnjybFDtTNHuVzz8mGWWH6oMDXNnCKycAbgjalqX?=
 =?us-ascii?Q?fzhWPk3DMUj5L63YV5WbYS15/KniuBJKmk4WW8qU+kWydkWvTLPW31SCeA9j?=
 =?us-ascii?Q?vwumKHFigy86Ui6kYMj6ga9FiWYHtNxz6EwhVmhK/I+Si9FwD+bsD5Gy+Omz?=
 =?us-ascii?Q?0SJIyqXK66+OvQS20/EGqngPAHMVtGlnxhNsaA7cwR4Lpkfnkr4VCaHkqcdG?=
 =?us-ascii?Q?f2Mi7mLfYp1VPDc313ecN8cLkJoeG+KVyhyxCJ7NHbXN5XlSHeL0bx6m5f/D?=
 =?us-ascii?Q?W+Yl9edjL6JOoeH3k9EOggREYAGfamDLIGbQ8lQXJkfbY4bh5FQlbQyAfYCy?=
 =?us-ascii?Q?+zLsz7B+dj+qsb2oiqbpQSRZZG6efBAyr9q2mXykhPo0Pwr9nLtTCcPT0A9U?=
 =?us-ascii?Q?QRaftmmJ81l9Nab8LefAFJ3syUp/xr3qRh/jQ413vJjSg5BY8oi0bmQt8R9a?=
 =?us-ascii?Q?hK5bcO+rPfFq+KGj5LWmToRB2K6+nCix1tKiaJwHLyVKDli1B1qyRuVfoJtM?=
 =?us-ascii?Q?OGuNGr//rnbRSE6KKdewjiga3UzN968SkqTqr6Dgx1TqXdC6GZNX2GIbahZq?=
 =?us-ascii?Q?A8DvKWoYCOooNxL1O7epZFDgFj8J9DXNz3PPsBhQePHJtu8VAOOfHggW2LV5?=
 =?us-ascii?Q?81TnIP79hRjPAhjOnxHvxOoKX78iagY2sctARPtad2h+jFWpSQZ0acwEeHvD?=
 =?us-ascii?Q?8MPajaCOjRry95hOMmDpaA/xFbzGtQ/WYWTtvAiKH7VNtdSgBK4tdwPbvJLs?=
 =?us-ascii?Q?mqBO4LEU/+h1tbyWF6FQmsKyOuaJOr5ZKt0CtBqsAGDHcMujh7q6HOcsLEd3?=
 =?us-ascii?Q?VqZ+aqFvVBSVC4+A1tz3rTpIex/kjSL5nZiMMppvwURp2YgD38T+BKQJVmO4?=
 =?us-ascii?Q?6T+oSckrqJYK6jNjAkUkfuqRelGbs707SM3F1LDGhj1cDcQ3b6hTbXdDHPXA?=
 =?us-ascii?Q?kLA4BVwMcrLgmja+fvUMjE7WWpY5wBeVJzvO32paasPcWrTXIiCN+LhQiNH9?=
 =?us-ascii?Q?ehL96RmnSVy5CFNl9R3y4cj5z2wSjVd9Rw3N//7RnVL2A/b/rg2ORaZmhwhN?=
 =?us-ascii?Q?dfp0L+t3WCuDz2JuaIVoRPukI2O9eQth1jH/4T9OIEE7Db4d/AIi1mM5pIBY?=
 =?us-ascii?Q?QrYD2WgF9hsaVjfh1vbCQEpYKaSSEvzoJp9QHE3M718jBFH97wcYj+TVG4Fw?=
 =?us-ascii?Q?6wDwJfYCZKisjndkHws=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bed215-fca7-4223-0cc1-08daccb34b77
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 17:59:26.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVAltAsuUAy4RBdkwDjTZWnwaGsMoZVFKAAA1+vtK8RcXqDPk3s0e71mHdyE8AZp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:41:07AM -0800, Mike Kravetz wrote:
> On 11/22/22 10:05, David Hildenbrand wrote:
> > On 21.11.22 22:33, Andrew Morton wrote:
> > > On Mon, 21 Nov 2022 09:05:43 +0100 David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > > > > MikeK do you have test cases?
> > > > > 
> > > > > Sorry, I do not have any test cases.
> > > > > 
> > > > > I can ask one of our product groups about their usage.  But, that would
> > > > > certainly not be a comprehensive view.
> > > > 
> > > > With
> > > > 
> > > > https://lkml.kernel.org/r/20221116102659.70287-1-david@redhat.com
> > > > 
> > > > on it's way, the RDMA concern should be gone, hopefully.
> > > > 
> > > > @Andrew, can you queue this one? Thanks.
> > > 
> > > This is all a little tricky.
> > > 
> > > It's not good that 6.0 and earlier permit unprivileged userspace to
> > > trigger a WARN.  But we cannot backport this fix into earlier kernels
> > > because it requires the series "mm/gup: remove FOLL_FORCE usage from
> > > drivers (reliable R/O long-term pinning)".
> > > 
> > > Is it possible to come up with a fix for 6.1 and earlier which won't
> > > break RDMA?
> > 
> > Let's recap:
> 
> Thanks!
> 
> > 
> > (1) Nobody so far reported a RDMA regression, it was all pure
> >     speculation. The only report we saw was via ptrace when fuzzing
> >     syscalls.
> > 
> > (2) To trigger it, one would need a hugetlb MAP_PRIVATE mappings without
> >     PROT_WRITE. For example:
> > 
> >       mmap(0, SIZE, PROT_READ,
> >            MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_2MB, -1, 0)
> >     or
> >       mmap(0, SIZE, PROT_READ, MAP_PRIVATE, hugetlbfd, 0)
> > 
> >     While that's certainly valid, it's not the common use case with
> >     hugetlb pages.
> 
> FWIW, I did check with our product teams and they do not knowingly make use
> of private mappings without write.  Of course, that is only a small and
> limited sample size.

Yeah, if it is only this case I'm comfortable as well

Jason
