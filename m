Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94260681ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjA3TuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjA3TuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:50:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F145896
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gINqh3MNif/7L2wJwwPNxSrbVaF7z3O3TLmSCPkG8QLWDhAwnM9bUPalx22eVzfyjFV0KfzYJ7u3OTVDMu3qpAVR/XRKTBTsv8PvxwpiA/e0WaJi4W9IR5RLOjJes+I+vzrmSGKJ5ixclvA9e4n5kZ4j6NM1oQuR4uNrq2dNdUHGs8p9atI2M2J7dc5HzGT2vlSH7whxKpslhB1WFh/iuY9KFxrZ2Zmfggu94HP2w95SaTFyWJISpyfg+QY3beLVWsXgPJDFOZ1Ij+pOMXw+8NWBs8qLEHD8W4Q7w+/ocHA8Y5KBs8oWkIVD3qAFUlZJWLYFgDnci4ot8cpFthvbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nye7j5tEpfCYePqQXTsbCw3JGDJeua6huG9IVYYXzdM=;
 b=XpKQl5UVEK8aRwvu0o/G1fFfAQF5bIxV4RkfBYbRFGdlVKtgXVLnWT+J+bYIbgVdDxRx+k6Bzus6xfNQ20RZ/k9zX7Aej+kQXG6JFJ3TpVthWBCETTevNQrMXHPb5KUxCxe6AhjqXg1VIOAjrCX3ouWlTSA/0ixw+80Mm/Ve9TOAGpVKG93pl0r86AHhBH7jirqK2c3V08Gy6mLQqHxrPWNr6cnA6XW2wpKb3uKwlPQNKxMOzxyxljemUO2LX6QCVJOT5tTMoxzXvqRzAxDK96xmrskzrUA46Tf25RUyMz2hWEhG5fmr1hXrYT+lJ4YBxg8TZh8y2of9ZmVj21PxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nye7j5tEpfCYePqQXTsbCw3JGDJeua6huG9IVYYXzdM=;
 b=HxW/tzGLz2yxgdN9LQ0/JpgYtjvLBFsY1/bI/tKsEmlascUJjdnzAypX4XZGb31hZzOgpPb1cNMwQSIYCUStk0osX9La1iDpqFYIveCBginP2Gb/Cqw2MmZ2G3YnCikRrubbVk6pwLQOSIiMJ29y/WM5MWqdfuXcAzoF80ThUIo/8r5fknTVqlfyOyG8qTwAhUpni687SEgEsmXPKnZghHT97Npdr6HuUD3agPVjYmfuDffBFeuIkw0Q3hFLuxXHqEijRPAAbzXou01t6j/0VaoJUesp8WKl+tpkG8III1GObzFqivF/h7ZoGyDyBy762xn/UwKV3PlD5MWJaVmjfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:50:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 19:50:10 +0000
Date:   Mon, 30 Jan 2023 15:50:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9gfbx/fszb0aTJn@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fe2fdf-f276-4a63-28fe-08db02fb3227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIipOBsvgJfs6GHj9nYf/dYuPjkAguY7w+kg+ZZURHXafOCVeO0haYbyqmzLQHJIN7YXiBLZoxfATFh7EQbLayfLcv8YYucNKKtcOR6hgc9Ig4ipDeGxAgpzlMqW2CYcVHnMZc4Z+BDqbHI5UVRzGnwDNxLB0xMQ0QtGSNMoX0AX1vclEWhu726Z4K5ltn3TghBJrFaIfm4ExQxdhrLSkfNI9+ix096lc4trlg21gT5MRJRAbNH3+B5a+ZPCh2vdKE+ZC1n1aajTB9CLsiOpjw76M8m602FLn/NVuHhuKv9/LSBa5bSuWNwwmjshlMHoDDe8nxsye2Ys7wtLUeSdBguTzbPDNq8+uIGTnQPMMmFUhlf7UZD+bepgJBSL3JEQc/o1FqWu3aixybm/3YhsFy3TEwyld7Ijz6IOqArPWJGUmDfo/q2DTWT4SVtGWdHywhb7PMofKpLd2NDIC3ZiStPoTcHqeuGcukmPpfemumxTvSzh8lUSznFcD+U1LtuPoD+Py2XMwK8wJrLeDl8Zo4NgTkwpwcaCE+6Lhum4WFVBbnwMEHXWciZvBK3dDlOxM0MUXLQmXSKyKMv1qGcOCTpNzD/z0mQ9bAqJLWE73c4pq74ZjFYDNTXqDAo4GvnY3MB6wj4gXQtUxrBvvQVQNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199018)(86362001)(38100700002)(36756003)(37006003)(5660300002)(316002)(6862004)(66946007)(66476007)(6636002)(8676002)(8936002)(66556008)(4326008)(2906002)(41300700001)(2616005)(83380400001)(6486002)(478600001)(6506007)(26005)(6512007)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8l37EHlPWmnhtOGyT2pBhfPXV88n2yYaJg6qYk4tWs5QMTCfjvPqsfRZGSH?=
 =?us-ascii?Q?8wKfdCyGU/tVAu4QlRipMBDewijvICScB2/9+G94SrKnqXv60yLWvJz0hV6a?=
 =?us-ascii?Q?qfs2xmy616NbDhUf5bPHIG0J8D93cLcDgeF5ZQTdZ+eZl0yEZICOYYK/ViQn?=
 =?us-ascii?Q?yyEsX38ocTvsHHj/tIaKSiorZoPIx8/dsuhlltv7Ae7bHwreuzlpC2M62hk8?=
 =?us-ascii?Q?4A0p5nkFp4uqF4mQOVn9DgyoDpbOmP5XM7UfEjzgfyGd1tTuWn4yO9Y/jU4I?=
 =?us-ascii?Q?foKvP74CDjP5idT4Bw5Np7rgMrBe383u8UOnvDy0edCCXifDhgfeaEPIovAS?=
 =?us-ascii?Q?GxN2j+6h/Ijcs8NtKQKruwRSeyXTp0QNDsAAdHtYofbsjNaWJAwY+mPxhUQJ?=
 =?us-ascii?Q?XvEruhE+MKXiQLegf0YfRdLMoFsNtlrvY4VAy3Tte/J0bwUhMeqB0tpYe/p3?=
 =?us-ascii?Q?B/1oMz2OLmznVH2W43GlU6m3wCDDKIzcd0jO/2XDzRfkRoKnQlfBK+M5BPzQ?=
 =?us-ascii?Q?XDiFq/2uKWnSBsjlZFrUY5tF8Fthz6j1ftq7JXgSIWQef9402fwSYzbt7QlX?=
 =?us-ascii?Q?8YGJqYlHSvz31I/kJ7nU2fYBCeuSPwRCmJk9QDVfn9tac1PdDRwrOKAdovlP?=
 =?us-ascii?Q?IMkDdIV3ZcHzBDH1SuXvpcMMobmhL/AB0J2rIN20OvakCEyILYxGfV0Vw8jq?=
 =?us-ascii?Q?jf3Pa17ZFolDuafT7nrNF8simJYSr7/3TR0V1oSkIw+8qdhYMp+JjIhl8/5m?=
 =?us-ascii?Q?qFh5kewNINywJ83iWvMCbs8n7xSpjeGmY0d1jpiZ665TEniRCaslv8sXnyMq?=
 =?us-ascii?Q?oHPWPNIEdof3qTUQYMrPp5a7iGa0oBvro6AXIiu1fRMZjJkk5QRlL5Wpe7ST?=
 =?us-ascii?Q?JVNt8NyyogLmImvuyfNKSAJ4CtElrEjbZvQmWXHx0B/wDnrM9PqknVnXGp0b?=
 =?us-ascii?Q?jgg6L8I6Rlu3dznziDKjxQi3uYxuFtbcQeUqommEuwPsGOBxG4czJ/rAp3Hs?=
 =?us-ascii?Q?0LVKxA1FszqyLi8nPjAyihUO1Pv6noiMFuo1LkMlHnfXStrrJf5e7YZ8zETG?=
 =?us-ascii?Q?nRfkHrbynRoWtlESKQXhEQoGGhzoTm0osOe+1FA60Dmqnk7HUOCfLCo1Ajsl?=
 =?us-ascii?Q?sXzFQE5bjByvWrf1GtnLuc/GagfpTjcOHafaBVyMy7Gedx3JdLqT9ec5PoFc?=
 =?us-ascii?Q?BGMcPR8WHYHuUicD0lqM+wRE2o0NGWsrmtg0tu/cCSzjTW7zEShZqzpOrUxB?=
 =?us-ascii?Q?sel3Y+PlV9BlpIy+aazNnECQ/beq6SZ33v+nIDLxVFvX9J+53GFE9uOkBuhJ?=
 =?us-ascii?Q?5RGc5xWte+zzGf8B1PfX7s7jU4mb0nOIWcygJcA92278bkfUKgN7+sT6Tmx+?=
 =?us-ascii?Q?Gh2nqsPQUuQpU+jzLZwD6ZT2oOnRGWBWtc2VY4UMIfQMWSBW4U1VswT7XaZ8?=
 =?us-ascii?Q?Fg7y3oy+0jRJFO0oEf2q1RJ+jN6hgw+ytGzzNO7qyx2dQhMb4/1ZKNbSNiYj?=
 =?us-ascii?Q?93NH6CRi8xHZZzEkBxS1r8UfOssRnd3CKBik6JwqXe/ILfoprBxjvE+ipGni?=
 =?us-ascii?Q?zJwmm8CADs0Ao0FbrWDdNYmQi6C4FKHC3JTjebFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fe2fdf-f276-4a63-28fe-08db02fb3227
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:50:10.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Btqs+CTsKURVqKSPWfVwpXSCzEezZIQYMVMsu56bdoZ4uLUnd+mZyGXwi2xDBNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:27:37AM -0800, Nicolin Chen wrote:
> On Mon, Jan 30, 2023 at 11:02:25AM -0400, Jason Gunthorpe wrote:
> > On Sat, Jan 28, 2023 at 01:18:09PM -0800, Nicolin Chen wrote:
> > > From: Yi Liu <yi.l.liu@intel.com>
> > > 
> > > Currently, hw_pagetable tracks the attached devices using a device list.
> > > When attaching the first device to the kernel-managed hw_pagetable, it
> > > should be linked to IOAS. When detaching the last device from this hwpt,
> > > the link with IOAS should be removed too. And this first-or-last device
> > > check is done with list_empty(hwpt->devices).
> > > 
> > > However, with a nested configuration, when a device is attached to the
> > > user-managed stage-1 hw_pagetable, it will be added to this user-managed
> > > hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
> > > this breaks the logic for a kernel-managed hw_pagetable link/disconnect
> > > to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
> > > multiple times if multiple device is attached, but it will become empty
> > > as soon as one device detached.
> > 
> > Why this seems really weird to say.
> > 
> > The stage 2 is linked explicitly to the IOAS that drives it's
> > map/unmap
> > 
> > Why is there any implicit activity here? There should be no implicit
> > attach of the S2 to an IOAS ever.
> 
> I think this is supposed to say the following use case:
> 
> Two stage-1 hwpts share the same parent s2_hwpt:
> 
> attach device1 to stage-1 hwpt1:
> 	...
> 	if (list_empty(s1_hwpt1->devices))		// empty; true
> 		iopt_table_add_domain(s2_hwpt->domain); // do once
> 	s1_hwpt1 device list cnt++;
> 	...

No, this doesn't make sense.

The s2_hwpt should be created explicitly, not using autodomains

When it is created it should be linked to a single IOAS and that is
when iopt_table_add_domain() should have been called.

The S1 attach should do *nothing* to a S2.

Jason
