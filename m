Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD758645CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLGOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLGOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:30:46 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8AB13;
        Wed,  7 Dec 2022 06:30:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia/r+UDyrHKoFAoVs75sJzu3MbzBoYvO/TH8zsT5MVVVta9OyaJsmPn9dZOmSeO9nuOUb4A/nYN53UJ9nEiSEQpHkMq3wqhaLjD+buk30Ot3mFuECsrDXfJDVRi6Z17nqzaVzzlbjTt5xHfaFQGiwBPT2vXcR+xizHkvclGbPITtJ9uiDgLZpLcEskeMdAhA2Q0fz/AVzu6UXakDxzRtZJSdhXyERLw2GFa4vzn/8zuXasK1TMrnospkkcbBFs04k/+6xOC/XJsPcbrCW8njep6QCNVvsT2pcysiD3Cz+A83slmULkzF4trnSijkk+lKXdQijnL6AmTXEuB3W6e1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gs9rEKeSXgxcJ6No+i+hAnvKELy2+a+PfVtzHNX/WQ=;
 b=BLVSHthKNgBHSsd+xOFv1SQ9Pq9C1AJ0c9RGxRGss5BxcRe09HYpARUHaEemTdXSTyeo0xr7HzGUXGKAZt6y2QZEdkDirI1eUhY1eZcAUWzYFtf+BYyIvmBdiD5Ll9iTaA71uveDeSWeVNe4r/76N0Er/Og00VuPMAPK92EXvj6EBgtqFq94ZeyOkftR8u1ik/ZTqMk7t3b0u8uJRoQBrnx8KVFU8LSWtnYunbzGbPJJRdlpg/p3Y4HcdsKk42J2kDD3heDgg6a4aIs+aPUUDGwfxXl0f/6VozIRqzjqfoz/w6sEYfXHKxPcZryV9rbEAhzNcI2U7gX7RyArW2YBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gs9rEKeSXgxcJ6No+i+hAnvKELy2+a+PfVtzHNX/WQ=;
 b=ufirkGJaV4wzc1zTzKLQNkdZGnovXTzfP2vesNJ6tSZWhEZy2TF/B1EkwbYQ/nV3C0VynlUdwsK9F+uVvGSrlg5ZjhNlSU4v0MaG/NJ4UVmMWE++prGCH2NfYCa+UUCg7jDBnxBbnTJRL3OfQ4YfKS7dasrPaj6MIH4mn1ro26GDpziY0r3neRSpNOav03/ZxhvfK7n5usIg6zk5yvmFTdiOUniYYt7+Xto6QlM++EXrTIhE0osh5uppAIOYoUu92QooReNfud6Q7krvXdsOWp9tzaoNRCxTdnn1BLiOSMmxxW82tTGQHlm0rLpoNQTzqvN/QqSsVxKuJrLxwH1RZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 14:30:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 14:30:43 +0000
Date:   Wed, 7 Dec 2022 10:30:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y5CjklN39iYeUDX9@nvidia.com>
References: <Y4TjWOXYD+DK+d/B@nvidia.com>
 <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com>
 <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
 <Y4Zm53o1ovdIAqr/@nvidia.com>
 <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
 <Y4/LsZKmR3iWFphU@nvidia.com>
 <f9433a12-eacd-9e6b-a517-c3be438193d1@linux.intel.com>
 <Y5CT4BBO9hsmjJfD@nvidia.com>
 <73a033d6-c1fe-c012-4648-774aa5b93a61@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a033d6-c1fe-c012-4648-774aa5b93a61@arm.com>
X-ClientProxiedBy: BL0PR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:207:3d::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd8576e-600b-47f9-74f9-08dad85f9f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj5AJWtpB117n8k0nDdjoDTrrmUC24dUJ0IYKiFjKkp55/mHMJmqtHv2HvN+q/Ky+qNTBA7yZcuEzepUIjocJiwsAbHUTQjpGw/dmu7lX5revKYFenX5C9tGci4t9Ruwpom1GNTPuCfE9vexjbPRjwCLQREyXukjuKKyoJUXb97gHe1bWBSWAzW0MzZoHPyIwajQkmvJKwGJCpSFVrmefmY6U7gTQvlKCynJt8y2OqF+GjLXp9ZLYsbwIke4T5MxDwtjN2dUdKLDw3MmvElJb/8ineqSfNhdAoGz1IeNiyJja3rACTLhx0mmnuyrmGyReq8MwB7Q69vFzyyshrALGfaD/1vR96X5rUAbuIJttiY2jEXJbEgQSkHbQDQuEnoIigu3w1Ctf1iOD/K+OrMlXflWM2xUmvsWbZvMiGkAKtntIV91YKOmnBLjLQr4gMvJ4O5CmEMJAkCf+LrD9B5qcxvk4QBwrPJR9ChAFGY7zlZnyfi+HoNGFO/w67IiORmgl4BANSMRLw5FR+iXCiysoIqFjLwKnrh5mQaxaTRTxsg5shZtTjwRqLVu9T2qT/0Z+XwsZ4kJoGFtrjxQynFhA2oD2/4X+zHsLO0Wy2CgpxCt5oCneenzz91pQi8npXM4jP9A8gPPZ8WLnzIO2tWQmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(86362001)(66476007)(36756003)(41300700001)(2616005)(186003)(7416002)(66946007)(4744005)(5660300002)(4326008)(8936002)(8676002)(478600001)(54906003)(53546011)(66556008)(316002)(6486002)(6506007)(6916009)(38100700002)(26005)(6512007)(2906002)(83380400001)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRgT7cpaTOxudt0AMLh5Xhs7+9A6xsvol4vLnkaYfQNyWrvV/gCsag0z6Xg/?=
 =?us-ascii?Q?3717qX2qUTbYAIq+yNirxaVnqONKEAbpCuibk0/OK7vtw4pxSAzeBiOkxYGm?=
 =?us-ascii?Q?diafymenr/rk8P5tP2UbmIzUpmvnUgBRLZfwIWZUuzjbZhhH2QemZCGdolAE?=
 =?us-ascii?Q?LGsHqRKKN5kmY9UGE32fcVpAitdDOLfpo11PEypcbp1478V5gwsMj28A60hc?=
 =?us-ascii?Q?XSuYhmzinxPiI67AqKw3e6iZs1H/llhIf1HjRdRp1BI8KocAfoKpKI1jLmZu?=
 =?us-ascii?Q?K2QrBSe5RtDeVvnnBlaheehcaC+Qt4GW1GZgcDW1SQ0bl3vhtV1Hk4MgAoBK?=
 =?us-ascii?Q?Ut4Qv4WTLK1p0WqJUtX6ty14XoXj3Gk/ALVdnyFV+p/nepG+0YPkEbTJCn6T?=
 =?us-ascii?Q?N40lEjWQNsFkzLp9f6upBCnCyzegDAvHHIOGnKMjVpGCFQ1gYRCWwjMIUr+O?=
 =?us-ascii?Q?ksWeFKl4pO0jkVcrr4pV+VyBBxaM5gql4BPc7S1IcgaUtJmQ4AtzRX2mFhIJ?=
 =?us-ascii?Q?N4PNf99Nam07DzeIBUZe4b3MR0C+UXyksRddQslAy8ixshSNQmbI8mozAmSs?=
 =?us-ascii?Q?WHu7y0OMqLHMiwY8qefh1kdftQ8MczGS9Kw3UOAGPJMWJ3g6XCKZHMYqpoWK?=
 =?us-ascii?Q?x6GuRWEDE5mmMqLtkuxc4FXhv0i0LqhbWvTLiUAt+aH0u478PCW4o6BM4RLU?=
 =?us-ascii?Q?iGRhU/rH/pkZzVg+5v6Zg0CPdYCMCcUlv4KPFlRoKFToDrySeQ9dMKmXMryt?=
 =?us-ascii?Q?G96qDisRP81yv6oLSMOnfWIJKIyEyc06gGuyRym2o6BPnbeo8f/+q4pKwb/K?=
 =?us-ascii?Q?g6xbhl9/2tC9rLdj7UB4AXrLEPCs/OU3tUa+lSKEj1UbzS7xdXCqimJ3kE8q?=
 =?us-ascii?Q?gbZxElx7rNnhplmDqzzL3/nmfZqtv8QvR73C+UMLL8K4wFAA9aq3mXjxtSh8?=
 =?us-ascii?Q?DzzHgvP35CNMkYHwDXaerGXjz9KEpVkL2OSA1+OYnCVDEeKr1P8VbSyNH51j?=
 =?us-ascii?Q?QiKfWKHblvZjKPVKXZ4ukiyDC42bnclzpUqZZXftURnCLLbY+ghV6ZExFgv/?=
 =?us-ascii?Q?kDvVeHi9DRe5vbQmrVo6/iJcy5At4r5MjoGSyeJ3Xj13pKk43hyT0gXKeJrZ?=
 =?us-ascii?Q?do8WoxV3al+UZ/7XWs1XTFnybSZ3Ds7Y9BC049gmGuEBbS2J7pHyRG5Gh3H1?=
 =?us-ascii?Q?IDAowwojI2s6SWRTw+JeefH+oe8QUr+/2hfKXR7KM+snet5VnI5M7v4D8CHn?=
 =?us-ascii?Q?Hmz4KfOX164T8LeXDrRVzVbZxwgpZZXDxWC0KGgrdiukLpZE5N88Y4it9pho?=
 =?us-ascii?Q?NOKKHMyUxjxvw6qXBblrQetNGTqfj8ANqJ4g18OqwukgL/l/ihXfd6tLFhyA?=
 =?us-ascii?Q?Mv6umadsLvhRAbcxifsnZyYc4L4QuCh2qc8W9lIi5HSoSCR2Oo8doUjtF7MQ?=
 =?us-ascii?Q?vquflk9B5sL+AaE1R6tmDMfKpV20l4rjsf0wj5Ivk13yQH0J3bH5/Jo5jfg6?=
 =?us-ascii?Q?choQ/Te9NLzF+M5kVAqYvcGbLMryNpYki0JY/XXOX1dj0L7E7l8QupN7h7IB?=
 =?us-ascii?Q?cRV5+q18wkywzC0EEoQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd8576e-600b-47f9-74f9-08dad85f9f6a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 14:30:43.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovt/aSjinifkfjt9Kc0yLcwBiTkvFIyU7q1njwiWUpzD12dGzxiHyy+YNqk4ddqJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:18:36PM +0000, Robin Murphy wrote:
> On 2022-12-07 13:23, Jason Gunthorpe wrote:
> > On Wed, Dec 07, 2022 at 09:18:19PM +0800, Baolu Lu wrote:
> > 
> > > > -	/* Check if the device in the group still has a driver bound to it */
> > > > -	device_lock(dev);
> > > 
> > > With device_lock() removed, this probably races with the
> > > iommu_release_device() path? group->mutex seems insufficient to avoid
> > > the race. Perhaps I missed anything.
> > 
> > This path only deals with group, so there is no 'dev' and no race with
> > removal.
> 
> If we can now use the ownership mechanism to enforce the required
> constraints for change_dev_def_domain, that would be worthwhile (and a lot
> clearer) as a separate patch in its own right.

Oh for sure, this is just a brain dump to share

I have a few other patches streamlining things in this file, just need time...

Jason
