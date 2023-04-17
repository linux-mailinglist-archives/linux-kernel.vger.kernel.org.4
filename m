Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562426E49E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDQN17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDQN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:27:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55260F5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As5RqRwKysZjrvHfLkNUjiNcgwUVG1glToq6pTqcsPgdzTgROws1aoTaBkg+SUss9AX6qJ58HS8r0qeS71KQrwU5ekQ730c/3/pjNh/dDUJCHEOSKgwmFL/tfaeaRZeuq2QSdRi9Ed5moLGNFzvlC1C9mOnuyidBeQIuTdL/ao6C7vmZZLhChqsDwSMKO+3WqatlOBAnx7aa1sTeJgfgd06yh5sYsDvH6TMwblMveEVmB+6yk0hN0fqC5GkhREDkMcIWcxLrBl7z4i36ve09ekOpyVAx6C/hRHUH0K1Cv0hqQu8Wqwr8y88/iLqIjqCtynpgBXIyU0wRA03C8gqaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTri252DAUKET+DxxsIP+0Ulpzf3+ANHu5q8l3/zaZw=;
 b=nNShVruL8MdQ7P3xxXoy3u6wEOQHW5urcRhmC2ikY9p7LZSXgm0Qxs3TvRGRWZ0nL17h3ygsFl5LcJJlHdI6ge68sOGDcYsT6DF5n8/HP3qLWXYxlasKy68CoL1Evw5/I9T5Fv65P489B8HAXh6jEmVgpxiG9YdkbZgsMTXHR9WglcxIp4TopvF22Z1OAUZu8DgVVeKDc4ERUbQDEjz+6R87iSRjtFDBuuVeuKNj7P6X+oF80+I633qOjVy1OPMtLG9+WmjVGJaYK92NFwr8MPrkopWkG798GfuYIzfdKkG/HGI7R6Xyo/ILKPrK5osAwNo5QOqdVwh/tiZozjAzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTri252DAUKET+DxxsIP+0Ulpzf3+ANHu5q8l3/zaZw=;
 b=mVeOizGEHmEl+mZ1H3oJLlDoii/xsT9TYIg7Hxpn0O2hkAcJBGA2cEEsZrHYDen2aw5Mi42ma9RbSxjXuAbwHz5tCsHVbJw32uRO8d98OKQN/tsLqiazSI9XD7CvCqTtiXNqV2q5WtyZM11TnzjNPAqvWxnmYR56X1HFz+Msul+/YlyHqS1SCLQnROUZ7CyfWDIuESH7bjdYuPyGa7SN+nCRkaWCCwH4vL3Focq5/pP9uGbpxyZ6+29/8kbaoAXZFb5iSWukheOFFNhto9jUBaiuye2R4miz48D1Vyq5dWvdlUn1VXenkGDgpVvSDm4nQMiotKUD4NM7GlN5pZ5njQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 13:27:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 13:27:50 +0000
Date:   Mon, 17 Apr 2023 10:27:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/7] mm/gup: introduce the FOLL_SAME_FILE GUP flag
Message-ID: <ZD1JUzCJ7kz46hWX@nvidia.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <7ed66bd5243f7535030e0fa6a8a94b76dc5033f1.1681508038.git.lstoakes@gmail.com>
 <ZD1GGiHBOj1mRDu4@nvidia.com>
 <7f9c3ec7-ea79-4f2f-bc23-acc4c11c9620@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9c3ec7-ea79-4f2f-bc23-acc4c11c9620@lucifer.local>
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: edcba3bf-8eb1-46a9-5423-08db3f478a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtcAEftZHd4yZRnTgEaIO87QnJl0GepntfaLQ0cs2rKH9OByQWjXzPviJExllbCcdTC57NM7kXXj8HQfQTUsxxRF9vqHGVH1CNf4+m5HGwr1xA7Y8gRMYCA/EnXpESefz6cEWnKZkW9gU9oAfOO+AZQ4fuIMD34qN3DN9+GuEw3ToK/4txQ+GL6+ch6S24YViV4tuDTFHnj04kPMtlsPz50jtHU1yuM6KLA7khOnNQGAOTez3hmb+qqg5l4dvTw0149BPV3WcQEe+3Htg5B8+ibl2uws73WcacPk4Xq1sgEWbGMyXg+sliYCKmQ6CDjiQ7PiQ/2OZUDJsPlByDMA8pPXaI4ENCb7LY7FrJA0pLrsS4h3l9esOjWatnAL+3Um2cXOyMT/N2WggV5rfzeKybV9VgEC8rzZIdDjaLgLIxw1irn6ITW86pFO64FfyEYbQwmlhUpEsk34aDlzYzVUDXSqp44AGeAxY++roozVs+0gZ8L9dbyek2HNGypN+excTmvx/z9F9k0sZ9/RM7QcHB9r4ZqQC9aUnRbutXTw2hICTtg+kW3cOwAgGSRtlPo6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(86362001)(36756003)(2906002)(2616005)(186003)(6486002)(83380400001)(6506007)(6512007)(26005)(66556008)(4326008)(478600001)(6916009)(66946007)(54906003)(41300700001)(8936002)(8676002)(38100700002)(6666004)(5660300002)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttSUGaruV005PNbtl26pSYMOxZ6IWtxDoioH8s5MnR4mTKfG4gh2b/bnK1za?=
 =?us-ascii?Q?/8lAVUszccaLGV1U213GrzxeF/nDfrwboq56muEy26veN3mpP4har98xGcWt?=
 =?us-ascii?Q?U/2v+ld0iqKy+AbH7GZWV8sF34H4Kf43VwTih7JTFptpU16RHaQ3v+8qbDPs?=
 =?us-ascii?Q?IGYsicv0tuBKzhCYrrdjyxugNLA81V4UB3yILl3BoRMeqk+Ze40D8ytUqziV?=
 =?us-ascii?Q?tTlCriYmU7VDikpVAV/yCjNx07JuaKw/k9B900lf867ium8AWGZdefp2DKWd?=
 =?us-ascii?Q?que656AlFZzJqDhmn71X5PAmX3FUbu3bnavD84gk9bBi7Sdk+Hcb8D8wfVN9?=
 =?us-ascii?Q?uB25nsbNlG8Bf2sZ531EREXiK48kL6o3uv26aMHk4tlRp+OE+XIzjCvSJlua?=
 =?us-ascii?Q?QrT1p2IE8Jlw9m2Un+45M35YGKAie9bP4SvhGzdAT29h/uTP0mfwYgOj86H8?=
 =?us-ascii?Q?osLD32e8qCeS34ri5rhJFM4eGhKFRCn3ybZS4k6VsLYElOYb9VaMKDny4Jkz?=
 =?us-ascii?Q?Qw8fP1RVaenFPf2mj2y1wFabitqhxziM/vzRHIlxaoqJ5fjZW9iCtHnsP5Fx?=
 =?us-ascii?Q?Kl8mHJ4682KIGXfKTaLSwbPcQVSQ12tnALoK8fAjgLNXnN/E2KrUFzSo+PKy?=
 =?us-ascii?Q?Uhlv1DUbeAoMaDMOOVY4dQD8TcA4HTqTOH4iFZrr4Qrslp15xss6rVQwPWd3?=
 =?us-ascii?Q?py5nmD1xWrHUhvxPJ0neP8rXxZKKknB0MYvzb9hL/Xx1t3j0kvAJwZ1NV20U?=
 =?us-ascii?Q?5xEZ5GaHEyI8PKpczvUjcnMbYOdh6YJzSAywFsF7Gbj147zVzw3TBQMJethY?=
 =?us-ascii?Q?K5ZFIz31BVHSV3IRAmeO9yvE89KgeMT4rUuPyhs3wMoZ5xcMCoVx7985/mws?=
 =?us-ascii?Q?W0+4QbOcT3Sp9nWQZT+Kpl/LwFYy/uhYN6d7UoPMgaxqlBZlQJNKZXUi2SAI?=
 =?us-ascii?Q?ZKEqt2rcRDIttq30XkhauFlUmSz7IGQSC2royHV9uSkil9l9f0TjIxXS7oaX?=
 =?us-ascii?Q?wVe0qsXIAs2b5EyYxaiDZmume10Ycv2u0yKD1VX4TWfhEMwzFfPkku8LPESx?=
 =?us-ascii?Q?ZuSctZ5DisXYHHVkmaSCU3PqIMsw5tthw1VHGsfckB158Iy9vQEVlsMfk4qe?=
 =?us-ascii?Q?s7a7IW0QrsK2QNcTlSk4JknXgo65tdIRjzPunMuEzbpMQNS1LjR8OZ2qGmQu?=
 =?us-ascii?Q?UFGNgasJWDV3O6qJ+HvYMMYw0WUD1KOBSNLpoxA60Hdih6kGWMTBqX5TQ0bk?=
 =?us-ascii?Q?MW8gGX9BEmg6CC7I3D6ndr93Qf3FHnz3qFaJM8PGMRUgMV5aWzPor+Ap9SO0?=
 =?us-ascii?Q?Etjfm7IIJ/ctpeVYOV660GSdOMWzOvvRwIQvCo+NzyR/K4afFs19QSWZc91C?=
 =?us-ascii?Q?NkjB7heFfuLomwzziUpPlzUSybBiAxTEC7TWE9i8HF2rn1sMJHBd6mxoa73Q?=
 =?us-ascii?Q?XPG3TXY3w5OxKcO3oWz0N4/DDcvmx3Me31TQW7MFaf2o7q09qqDS+ztZbD68?=
 =?us-ascii?Q?ndRUbrnsHvERt1FtFpXNjfcAvw1YD+hUSowd6BauiPvQwYgbx/LJaOtNgm1m?=
 =?us-ascii?Q?dBVUhSQoBGdMq78HYI9L8zMoUa40PnXqSDuRR0mQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcba3bf-8eb1-46a9-5423-08db3f478a70
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:27:50.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uNp1exTu+II6N39SthGAYQVeI/HYYa9pAlINMEEyImxAHXmDldID/4OMEU3NPO0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:25:54PM +0100, Lorenzo Stoakes wrote:
> On Mon, Apr 17, 2023 at 10:14:02AM -0300, Jason Gunthorpe wrote:
> > On Sat, Apr 15, 2023 at 12:27:40AM +0100, Lorenzo Stoakes wrote:
> > > This flag causes GUP to assert that all VMAs within the input range possess
> > > the same vma->vm_file. If not, the operation fails.
> > >
> > > This is part of a patch series which eliminates the vmas parameter from the
> > > GUP API, implementing the one remaining assertion within the entire kernel
> > > that requires access to the VMAs associated with a GUP range.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > ---
> > >  include/linux/mm_types.h |  2 ++
> > >  mm/gup.c                 | 16 ++++++++++++----
> > >  2 files changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 3fc9e680f174..84d1aec9dbab 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -1185,6 +1185,8 @@ enum {
> > >  	FOLL_PCI_P2PDMA = 1 << 10,
> > >  	/* allow interrupts from generic signals */
> > >  	FOLL_INTERRUPTIBLE = 1 << 11,
> > > +	/* assert that the range spans VMAs with the same vma->vm_file */
> > > +	FOLL_SAME_FILE = 1 << 12,
> >
> > I hope we don't add this flag, but it needs to be rejected in
> > internal_get_user_pages_fast()
> >
> 
> intenal_get_user_pages_fast() checks against the complement of accepted
> masks, therefore it will reject this as-is unless I'm missing
> something.

Hmm, yes, that looks OK

> As for not adding the flag (an entirely understandable sentiment), it would
> be good to get an insight into the semantics of what you feel would be more
> suitable!

I'm hoping there is not a solid justification for why io_uring is
doing this check so we just delete it.

Jason
