Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84118686F72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBAUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBAUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:00:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE7C65B5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH6UT01+bbPTd4bxXYdcHcKNuy4bb5ejDzr8ambigi3P+poYNOKpaXdMslgRCKx4xPpXa/EuePvY5w3s99r7t8nCsH3lsU/2+zt0KMILab+E2NOdVCkjoBfUFwavIYlQmgpioEQ3JrjbiBUDlKsjWzYzaAAnDteDs0dFB9wJap8mMmyseaSXE+tHxO9U2yQR32ryqTuTb4HIqC/Ps13AZZxZeGJFys1/owPuODAww5MnjBRoVYifmTGC2oy3Rwxg2zk4crpxhYlhvO2kC1UuIGDMRwSiTKhTOaQNefft1208grX7PRyw7Z7mPXiz9Jc8pcZmr5U7g0s48Q5x/x5EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFx948t0xuzhWCr+1BC7KCVdtKiqVRqS7KWAzieeYf8=;
 b=Wo/erIPlwHjl9OAgqboOLPq/o6A80v3QeVU2lHu0M8g7pfiyiW1cy3tMpm79DNib3WusoZFauQ8qN8pgHaedGZvJft2w+jE5/2gQJFXVuNcx8awzfnaBMmkbeIZY7L5EsnZGodACDVjYoCES20utD94CxQFZyKryjA3Eu7kwvp5FzQqnAkOQnxLt4bJ4pdhdBYp2aWNJQET7+J9Bf4hVcWpqhc/76qWBaswU40sAAGtBG+1tAMN7/MgdZKt4HCjIx/WcEmKAI2RAd8HtoTRaRpsapUMB9KSWdXwQvh6zeg/xnOC5QMJRt4pSvQdtqdo5aQL4M8gUE6LmDoGFvLxQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFx948t0xuzhWCr+1BC7KCVdtKiqVRqS7KWAzieeYf8=;
 b=rcxLeYyBi3Lk/Ex2CchxFOoKaD5TJlBHlugcOPTVHLjzhulqoNaWkXJz1HumRfyoxw49Yl2TJK1MCdungXTTMQhR9sHcZlljekLD0Vr6WBzSBXuPRFI+zKtHrHz5aPb3ofJA7B7AarexguVjSmqLoDuvPnXR+8XvUIq0t3vKcsvFwtxfHrxsfttHPR5LT9EzRwV8L7Mp0TXdFI7Wz1DZrf8zfiKKjLBf/tbA8HOdnpqrDM4LQ3rWxag44cvIhvvEfa93cTjJjCbMlF+Qi1F6ZopzuqmfRVsykbfPWWxh5+6U4ymnOENodlvsoyFznlpRS+wfIsMZyxgf6FoIp9LELQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 20:00:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 20:00:42 +0000
Date:   Wed, 1 Feb 2023 16:00:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9rE6L8Nr0xShiKy@nvidia.com>
References: <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
 <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
 <Y9qxdinaS6anoWhH@nvidia.com>
 <Y9q8llC0JVokHLf7@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9q8llC0JVokHLf7@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b873fa-693b-4681-c61b-08db048eff5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TYhET01vaZ5Ps69EcaCdm3Y7qIAs7ZOwXXoaSJFPN6x0o5PcCqhBIV6CLw65OOR5cnL9il5iLcC3n0il42ZANbzbW0/nkN49lXZ8B42Pp/+hAZwYbqXmJ3icaD5p5MrKMOgilPqbI4TRsYBdCwrgDnZZzq8xjbRSEUCF1dKwee5dagoIpjBE5wPIwOVuWjWLI1pYkL+EW1qnnj5TdGCvPbYDYgBb/qp62OEe3wyJf3VbVVUBkTWBDK3OjdmxzZp1UzG+1Vy/ItlKUtDTlkI+GQD3t/MPQOL3dpw3adg/8mtb/JKN+NBOg1pTR45Rf4QoqqlbsOPCPh+DtfJqefCmMOHh46bT4GCfnFhfoXGlTC7DZO3qfB4IBE/Vj+SZwbU9otbl9B0Rr6wnh0NnvbVCSCcf4FoY5FyuapUlOUMqhthFDBbkorOT6b9hBsKchHofH4ubLX0seqoYW6kepnCyMeGxfaLsIsvCa5yWlwBNwUAXWNpHvly27juA1nU+Wk7cymAGLyzwPwtmvCowvuIp9sKMLMjV54QX0FSsGoTTQJxVKzax7LSWQwd+85S3RgAl0c/EEFE2FFLcvTxqw9RWyLWX+5puUQ0Qt6yBV3HKrgl3dVw+K/CinwLql3bJns0SE2+mP4CjnqqQZcuVQt87Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199018)(6636002)(6862004)(2616005)(37006003)(316002)(5660300002)(4326008)(2906002)(41300700001)(8936002)(8676002)(6486002)(66946007)(66476007)(6512007)(26005)(478600001)(6506007)(186003)(66556008)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naXahaePkcx+YEn2sKhyYCgZWWlaxaOahT2qwfEHE1RLWSHNOfu8EEfpny9Q?=
 =?us-ascii?Q?8e7rWxS1aFObMIoFEg9Sp7KxH5ZDkp+LihB5Gl9Yb/SepZnxT4WIf80pq+Yp?=
 =?us-ascii?Q?JkiXRq2h1o4e73i88oJ6g36Ao/cAjuo7wrvHBQijGdDkRqwD2hXzTXgygchB?=
 =?us-ascii?Q?Y5OXpex3sSHYgA3kThvedeIAZeOqgq0R2QW6tuB9KERULlk1akMFZxWcs9W3?=
 =?us-ascii?Q?MlccjWkzD9zPjmtVTJwFH44pFS9AtITykBGNVMWAJvJTXzHJPOQE88lpAZ7W?=
 =?us-ascii?Q?zLSqOyZAGkDU/0vcpu5+d8rkQdV+rOLyV8pfWCZVEWYFHZNGR9678Z2xOlhC?=
 =?us-ascii?Q?qZpAqrRfkECdKjK+RwgszJZgXP+58pPA4aTh4e0pyeFyB8KuY39tofpzioud?=
 =?us-ascii?Q?fmQ6kRqCxejlKVnTmWDFIZJP1JU31Ws0ae9O6PRXUeawLjnSgCxr14OC3Frb?=
 =?us-ascii?Q?SgrVKXt7M1oz1fdP/j2YOKIBAaiYzeSp7Ft1ENUFHI+u/z1JGhMW/VejFdKi?=
 =?us-ascii?Q?vOTPaq+YAl0Ksb/SM9ixN5bKFwcgJx3ehMu1+7WjzJsRVql5AU2dPc4plzbz?=
 =?us-ascii?Q?B902ec/q7ZbpJ3LCCi0pAUAsldENX5SUnV/2JgehAkm4NsB21PjZzD5ixHf6?=
 =?us-ascii?Q?UiZwmbtxpjyc2JfH9YUmevl8pWNrE3YhVq7hcqxZP8xiO03qPAYD5jk4Yfil?=
 =?us-ascii?Q?EN/fSe0ucLgBndhwAfTNfIS+Wq3DZXqrRKkRhKz8xXGoWKTDxgulmojhTVp6?=
 =?us-ascii?Q?Ea3m85Gdlzl8xNamJqi1+aeL2+4GSStv0fOadMN2xIZHSpKSjWqpUg6FgaUG?=
 =?us-ascii?Q?jmcb0KY2fzJeo33Gz5PKpfbzxmIPLHmMP3gCYWKIrPqlll40K1Do76hNgKaT?=
 =?us-ascii?Q?2t7kYkmV7oiwbH7j9fz79sXQ5PWM9jNJToN3G2fqbySpbQpQTACoBwQfEFvC?=
 =?us-ascii?Q?8y4vJu7h2R4q3J36lHJG8VGo28LMt1XmTB8OON80v+m2WLcjWXOWXetPaACX?=
 =?us-ascii?Q?H1mNdocVKHD5VoOYVU7HiUROKedI29Op+xrcFhNoApRGwvKbN5OyDkKD70cP?=
 =?us-ascii?Q?/DxczY8rS2JOiizencs/VKqO16Pn2lOuALskMlNNdCs2Pu+CI1s68umE70vB?=
 =?us-ascii?Q?YTWEuL71KzWZJvjh90nvJRCnYnJpjNAImqrjS69kRtXApU8mCOTWoLgZdDgM?=
 =?us-ascii?Q?K9jhpZAFdCJpwSE6Uvnf/DMOMIwRb3prf7wL0hj3dgWnlHs0p13EadXazXhQ?=
 =?us-ascii?Q?+A5pkiSsa4FqwD6z7jg6Zn4ulWFUX7MJZAmBnnM52xrABcXxpI6KGx+CUInf?=
 =?us-ascii?Q?zff41lymHN7AgQnTykkfAncU4xFtYo5pd0CtDJh3hmwJ8lj9U1lhx7NBH5Vy?=
 =?us-ascii?Q?t7CLqA8sw63pYYo6p5LyaappnS7IFzc+M7N3FGi1QeI5HsQz2IESlMjQs7S4?=
 =?us-ascii?Q?/AnBHzoz/47HYhsQ0mW1bB+QkIvHFgRq34bXSIwqvQz93AO+wCaY3vUOyYbd?=
 =?us-ascii?Q?TYez1DH+YVzU4vTkYx5ZEqGigYm0z9ssJnDo+HgkAvKtYcxJo5usBvuLkyt7?=
 =?us-ascii?Q?p41AYTpyQUKv+hb+xT7fn8pWP1jMkBM+z4GNQ+Nh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b873fa-693b-4681-c61b-08db048eff5d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 20:00:42.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwhnjegrUUUdnwU+ve6t5vafteLUqTUfK2HkFQ6plflfNkVnrjkX2hOZNrMX3ocK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:25:10AM -0800, Nicolin Chen wrote:

> The "finalise" is one of the very first lines of the attach_dev()
> callback function in SMMU driver, though it might still undesirably
> fail the replace().

It won't get that far.

Remember how this all works - only autodomains have the special path
that allocates a domain, attaches the empty domain, and then populates
it with the ioas. We made this special path specifically to accomodate
the current ARM drivers, otherwise they wouldn't work at all.

replace can't do this - replace must always start out with a
pre-existing hwpt that was allocated with a dedicated hwpt allocation
ioctl.

Wwhen the hwpt was allocated it must be linked to the IOAS at that
time, because we definately don't do defered IOAS linkage.

So on ARM when you create an unfinalizes iommu_domain it cannot be
added to the IOAS (because it has an empty aperture) and creation will
fail, or worse, it will get added to an empty IOAS and make the IOAS
permanently unusable.

> Hmm...in that case, we should hold two ioas->mutex locks in
> addition to two device locks?

No, the device lock is the thing that protects the data you are
touching no reason to make it any different.

Jason
