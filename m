Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3572FDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbjFNMK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbjFNMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:10:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99026B7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQXrX7USjiSl5g4pL20xFMxS5t6H8rC9EmK0DSr7TFUmUySvOnY6ecO4PWkC8VNyr3sKHB6m8jPhg1VUaJVQ5dC6POEy5y5HArtojqEssvgCNvJTpJLGTiI4TdgHHzZSkevT2LFNTmaRxzfs85ZUJ5SU/PTcp8b3ooV/iO/JgKHNrLiMe6X+Sah0tC13gaHTg0dxZcL/ihcFn4CFO1KJLQvovOab4MUfhxFGLVhSWUqyGuHbmjzikhQ1JhficAh/rH4I9CP3sq9UflKmvcxK+6uiFacZJx3UKVFqnhd8Nj8aMkblyNoAUSdJtVAsCkhT50INjaJguD4luc8f7Ki/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqV/xBS+3jj6C15URDB429RR6pID+njVOs2aYxkLAwo=;
 b=KubS3gn5/pP52PAibK0R/aR07fcmoc08GBwSl3/Y9a8fklXi1Ja+CvCm9k0+CVN3JtkA800ZtLiHTo/FCG7eiQ9gRLKXYwSDPihQ5fi7cQNFdAuErHdAReBMM5+UskApOLNYp6ze5m7rgouaFdkeaKe+j9bsP6v8XKo9Rht18SpITsI56htPrm74ia674aH3egm0pmgp0w6nX/YnxGN2DMgc1/nKJ8j1KJO2lUJnK+mVIAQcoWh2oRI3BEsoHlTaMwiDH3ZT+lqpZhVHUEsqym3M5wHp4RHn0LXczvB/O586+wDn1r/MXkQvKMZq6OYoSfzOSzArdisJx0mYjbFJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqV/xBS+3jj6C15URDB429RR6pID+njVOs2aYxkLAwo=;
 b=F+FGApJlFoJ/poefAPzjSmce3Ab3bvVFcn2XFcBJ9/1ZeCB/GVeSS65oAyzKMYJEmUjUxCsvE6y9VY5cOPChLUWz8KXcjo/bAWCzVRBXxHcTICwL1eWwjgIy9WQoIW5ficNoTky3g8j0Cbfv4ys0D9ZQtV2BByW3HJDlNENO/Tl/X7JImWl5pES6RxSLliSCKimNVGi231mdrWatuQTgI+p1e6OQPxCoActqFyqah/Cj1gWUh2DsnRHFGol1HhjhYXHlHsC2DwCXrFZEkgmY0QM1Ooeg7SGcUzdQdaNo8wuhIZK/6bl3GQwAAZ5FTTNaZhDxopgDL3WfIqoiIMIYaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 12:10:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 12:10:11 +0000
Date:   Wed, 14 Jun 2023 09:10:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZImuIPrB2YeulNn3@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: c1de1e24-c0b3-4f82-b0d1-08db6cd04d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X///R6m6mvssyNyUVBf4OyJqWAkZdTL5kdTd5o+Na3pFDUttj0wEYZO5UGJ4gIcPR8X0JwjQbR4+LM4RYdkiZkHWiztWKkNgK+RC2/omEbpByFYiQKvyvxDN6rr5a7DQXwyPa/mFDC9UtEh/uB46I7g3C3OZxuBd7hLOmRIdthEUcAYJldNXL3PVZH4oBQxJ2wjsLcpi9tF5AxPkHxbzvCjcqywra23v/9ZQyIjgc3tndjyDDVSRH7oxV6huSOB+qcxZ7v+d+eiMKeEp9lK1VRZ8GkaYbdq+uepi2GHavNYj6hH6AqoO0I5v5s1HB957ho3Bc/B01Yy8QUhCb7HUQDZRHd6oodhDkPwE7G9Mv1kfIdhzAjVqs7nNKcNgNPj+dq2yFeq5U0wIdyNR8ZaZuBwKWGTuWBgciRckxMpgw3MQi2I0KoYQSm6KxW/08R+p/UBJAAuQmU8n0BHGzSdoTR7S5MyjuHXR/zvssSs+/NSi5IfeQ6amjwydmDOJAG5ybKdKjyvkJ8ijj9xdMLKybNdn5+Qy4YB+7J1UXMx2SQIJVfiNJQmUAR3HRCsDombr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(66476007)(66946007)(6916009)(66556008)(4326008)(316002)(54906003)(41300700001)(2906002)(6666004)(478600001)(6486002)(186003)(26005)(53546011)(6512007)(6506007)(36756003)(38100700002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEViVWtkQkZIM21oQXlTbVpQSDhDdjc2ZHBIV2ZuTnJhVmNYakhBZWZ1d1Fu?=
 =?utf-8?B?TDNRenFVNGNrMXhCVG9ueG1uSzR6dmtFZzI1SWxkZVozelRTL0dhRXFaTXFV?=
 =?utf-8?B?UldYb3BBZFhQMEJYVWhJcDJnUmVhR0xHNm1LRllzdFF5M005WWZpZ3owR1lJ?=
 =?utf-8?B?bUMva0FrUVd5T0MzdmhVOXZ1aHRKckhMdjl1R0ZnejF5bDJHV1lMekpUelBS?=
 =?utf-8?B?K0xoZVNHK2V0aklOcHJrRElzaDczRnRQOXRGR29YeFAzR1k3KytFK2lYMGZJ?=
 =?utf-8?B?L1dZTW9mQzFNTTRYM3Q3cnVIMEpkL051U2dDK2VnWlhIQkdtNUl4MGQwd3Uw?=
 =?utf-8?B?RnM1TTJ3cnFMa3ptZi9YMTRoRDh5VzdjTWNxUUpSVklzSkgyRStLaVNYMzd5?=
 =?utf-8?B?UWw2aUJ5WE1BZWE5V095S2RSVVdSc2hDTUVPYk1oWnorNnNQOEhBUm0yb044?=
 =?utf-8?B?WFpSRW9oa3pGOEVyRmppOW1NcTU5QTdpM3FGMXpGVmorRFZ0N2RkUjBNbWdk?=
 =?utf-8?B?eGtkTFFUU1VhNTNXOTJSUUUrUk4vRW0vdFNsb3pKUGxMZ3YrWVQrZkF1OTdR?=
 =?utf-8?B?TGoxTEJ3UktDbHo2Q1VBV2prYjdMOGdSZThzNTdOaUZXNk5DNnRaa1Z0bFMy?=
 =?utf-8?B?ZEVqZjFoVU1EZXE2ZWx4aWMxR0hNanNWL21zMDBOdzJMVjkvYmJDSGxiZnBz?=
 =?utf-8?B?YVRObEs2bzJOQk8wU0VuLzRJdUhoWVJ1RzYzaGNhR3I4cGZjYXp1SmhHc2E3?=
 =?utf-8?B?QW82SXlCQSt2dXBLVURzaWdQdDN4bjhyNVdWaDQ0bENObEdZVnRWa1VxTUhr?=
 =?utf-8?B?WlFReXR0Rm5hd3BwcHZMU25MMTRoRlQrYTg1QzNITHVaODVPNkR0eFcrRWNQ?=
 =?utf-8?B?bFRhbHM2VWhkNm0xWm5GS1IxRm80QSs4MGlvRTJlamZyZFlJMm43WG43STdt?=
 =?utf-8?B?N3dtVmdTTmVockhIWEtGQzYxNHNXUm9xUk9sWk1OWDdyTS9MeXVsR0dXNUlr?=
 =?utf-8?B?RGUvUmNZeEREUXY1d1ZYc21LWGlhN2FGVVllUGNWWnJ6ZGswNnBFUjVvN1JG?=
 =?utf-8?B?bWNWQ014SE1uV1FMVkhxREFjNS9GNk8yVkRJQmlZa2ovNWVRR2QyL3crMlJU?=
 =?utf-8?B?R0NNWldmZ0Ezd1RLVnRQMjhOdm5hcURMcTd5eUt1WW5kN0kzdjdWUlUwTzZ2?=
 =?utf-8?B?cUsrd2ZQMFZJMjdCbkxhYmY1MkNSZDBrbDZDNGxsSWsramIya2lSNEp1NHpn?=
 =?utf-8?B?MTR0NEU3VGdQSERGdHJSdUpWWWF0U01IQnlsQTN0NFVTZUpHSEJrQnpvYWRy?=
 =?utf-8?B?R3IrdE1ETlFlaUZHR1IySGtDalUyM0xYSWlTK2ZQSHdzUzZFSHdmUW9ZRm9G?=
 =?utf-8?B?MGZDZDhMNmRRUHo2RzlQTWgvYzF6aXk2bElzdkkwODF6WFdvS29JTUUybmhT?=
 =?utf-8?B?VTd1alFsOFdkT0Jra3JCUWNYQ056TkpkUUEwRWtveUM5d2xZa3pHWnRTZVp3?=
 =?utf-8?B?Y1k5N0dBWnEyWlJPTytOMWZzTm5YM3k1S09XVDlZQm4wWGcvVm5IMzM4WGpX?=
 =?utf-8?B?ZFNaSkZ4dGU1TkpIUHRFNXBDMlFXaGd6QTU5SkkyNmJnSS9wc0ZqMEV2YXFy?=
 =?utf-8?B?dWozdnlQZ0hHUXNzK09DRk5oc0JMcTByRzBsWHk5R1Jyemg3ak94ZE9qMWRH?=
 =?utf-8?B?VEhxbCthWGYxOWxuNTZpL0xUMGxLYmxQM3NsV3NaQWJCY0pKbkVzKzAvODl0?=
 =?utf-8?B?M0c1cTJYNzdQd2dyVTVxVDUxcGM5dTN4dFZPTnA0eVgwU0ZvZ01KUWxBT3U5?=
 =?utf-8?B?UVQ4dFVteEw2bloxYkFGb2poM3RQdVFwQnBiYVhkZk52djZpOU82aXArN25t?=
 =?utf-8?B?K3oyVDdTdHlPRk90dFMvREh0OHZub2NnTWJ0M3JwQTV5ZmUxUTBQRHBuclpH?=
 =?utf-8?B?d1ZJQjJOL0NERGJvZFM2bWs1L3ExdXowOERsOGRSRjB2VmRnZFRHTmkxcVFY?=
 =?utf-8?B?M0xBMUhTSHhuMHJsTTJCaUdsN28yOWkwWVRJSHpBR2Fick5MeVgzWmZDUDRG?=
 =?utf-8?B?anBYWGo1cXlsdi9TQkR4Q0tQUzI2WHZUekpqRW5QU29iTUxwbnduYkhvNjNm?=
 =?utf-8?Q?AuwyaitMW5Iv5xQZYVgKIUTXU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1de1e24-c0b3-4f82-b0d1-08db6cd04d8b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 12:10:11.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJgSD6eaTJp02szH4hgecqcn4SSWCJMeLq/ynpaKyTuUcews4TCCsXh8lnVIeGta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:17:03PM +0800, Michael Shavit wrote:
> On Wed, Jun 7, 2023 at 1:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
> > > SVA may attach a CD to masters that have different upstream SMMU
> > > devices. The arm_smmu_domain structure can only be attached to a single
> > > upstream SMMU device however.
> >
> > Isn't that pretty much because we don't support replicating
> > invalidations to each of the different SMMU instances?
> 
> Looked into this some more, and supporting attach to multiple devices
> is still very hard:
> 1. When an arm_smmu_domain is first attached to a master, it
> initializes an io_pgtable_cfg object whose properties depend on the
> master's upstream SMMU device.

So, this is actually kind of wrong, Robin is working on fixing it.

The mental model you should have is when an iommu_domain is created it
represents a single, definitive, IO page table format. The format is
selected based on creation arguments and the 'master' it will be used
with.

An iommu_domain has a single IO page table in a single format, and
that format doesn't change while the iommu_domain exists.

Even single-instance cases have S1 and S2 IO page table formats
co-existing.

When we talk about multi instance support, it means the iommu_domain -
in whatever fixed IO page table format it uses - can be attached to
any SMMU instance that supports it as a compatible page table format.

ARM doesn't quite reach this model, but once it passes the finalize
step it does. The goal is to move finalize to allocate. So for your
purposes you can ignore the difference.

> domains). So then arm_smmu_domain needs to be split into two,
> arm_smmu_domain and arm_smmu_device_domain with the latter containing
> a per-SMMU device io_pgtable, arm_smmu_ctx_desc and arm_smmu_s2_cfg.
> Each iommu_domain_ops operation now needs to loop over each
> arm_smmu_device_domain.

No, if the instance is not compatible whith the domain then the
attachment fails.

> 2. Some of the iommu_domain fields also depend on the per-SMMU
> io_pgtable_cfg; specifically pgsize_bitmap and geometry.aperture_end.
> These need to be restricted as the domain is attached to more
> devices.

These need to be an exact match then.

> 3. Attaching a domain to a new SMMU device must be prohibited after
> any call to map_pages or if iommu_domain.pgsize_bitmap and
> iommu-domain.geometry.aperture_end have been consumed by any system.

Attach needs to fail, we don't reconfigure the domain.

> The arm-smmu-v3-sva.c implementation avoids all these problems
> because it doesn't need to allocate an io_pgtable; the shared
> arm_smmu_ctx_desc's

This isn't true, it has an IO page table (owned by the MM) and that
page table has all the same properties you were concerned about
above. They all still need to be checked for compatability.

ie from a SMMU HW instance perspective there is no difference between
a S1 or MM owned IO page table. From a code perspective the only
difference should be where the TTBR comes from. The SVA case still
should have a cfg describing what kind of IO pagetable the mm has
created, and that cfg should still technically be checked for
compatability.

Have in mind that SVA is *exactly* the same as a S1 iommu_domain with
PRI enabled except that the TTBR comes from the MM instead of being
internally allocated. There should be no other differences between the
two operating modes, that SVA became its owns special thing needs to
be undone, not doubled down on.

> > I think splitting it into a series to re-organize the way ste/cd stuff
> > works is a nice contained topic.
> 
> Should I explicitly resend this patch series as a v3 cutting off
> patches 14 and onwards?

I think it is good to make progress, it looked to me like the first
part stood alone fairly well and was an improvement on its own.

Jason
