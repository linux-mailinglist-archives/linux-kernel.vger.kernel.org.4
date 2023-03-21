Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284156C30C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjCULsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCULsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:48:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7A2D59
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf+DjkmrGGOuJXV5YreVyTbJqdjDhGiXm0reaq5JrQiwweOFe/1acprbVTq9XXbVGy4rQVu1ZTSQi1uMWUET6Lg7MDlR4klZ4UHqE+plfaJhCqjqvn90YfobsQ8luaadIbxar3yPtKJkh1e9SFfLHHqrEFm6vtTbNS2Q5hyxzcnhmmXF15/k/Ul1w6W8Le4knPS+NK0gNwFM8YzLXlNfT/Gstm4CW9zdERNjgzrtv6XYzA3f5gz1mkcUDT9QX93PbOKPJWAziEDlDTM+xutGkWdeeuZ9kJDMfsugsUjiY7i/JHkk/B4h0fAo9MB43+zmNRRwgt/CIwsogkmVAkRvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lIIFx4IaUU87FU0KEKvOknYQzWqNkbU/NH6EkP6QSk=;
 b=m9mtraaHVVuPiWVNmTIin6bG+0ukXFJDSItIobRL8789wAGF+ypzIje4sReG5ZdDEBY8IZ7s73YJasnRqJ4dqJ+eSTeoII52qcpfFSA6Onsf1jokYP3VNtSR7X2y5w17kwJ28zxNeBBKGZvjsRS+6NR2kV9yMlpP6UMnbcZpYxH13Yi4cgFNgTsjfdCQAd9xb0c54eL3b66USEXz9wkcmHPXW4LN1LnF8xs4ntIw6ZSiKloSouNjo8UtTn0TpZ04aiM+TE/WqKTh3TAA0gg49Gqmgo94cG+aQnTPWLLQmS/P3MeeU46riB4iOGtzb5Zd9HdwHFXETqZOcydrqvuFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lIIFx4IaUU87FU0KEKvOknYQzWqNkbU/NH6EkP6QSk=;
 b=BIf3bYqQDTEAoYlIgJArJ4L1R4zVW1pwlJtHWd2Pem4IGbTR4xsmoVoKUxSfHv9pEna23wVN7DDOEr+sjNXfu6NkG7jkx7I9wm/ukXf7h4YtcS8qeOdluacg/cjJ44uQkJJjGSzP2Hh1x8s/Vo2rzqY0D6J2My7hMwz1WOEXFevDTovGgxSvl/MszvPyRhqMXEvZx4xNU+fR+0hOEBURGZBP8cQmGJQveKTgN40fOntPoaWM8kW9eIbxHxbFb/dfouBcipb2kBMrkmaw961LnimAo3w9OmDxWCfYZ2VPkKHm67w1q39QkJN9pu2Xjrk6246wxF0zYtBuvcYPSvYi2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:48:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:48:32 +0000
Date:   Tue, 21 Mar 2023 08:48:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBmZj2pscX0hx2kQ@nvidia.com>
References: <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0297.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b172a4f-58cd-45f3-9d7f-08db2a023201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3bnOCTwuRA6bfw6LpVgNsfmHRvXVTHPtzqRoiW7TNX0TM3Ih6Vt6m3WInsDsqRxD4/MOam9CRui3Jipr2gAKDUU/F6ab9itA/ceVlabikbIJEP9oWrXgdECOeDDaYeL6Nm/3XpzcvUmSrxy+JOvCXndoy6woDp+i7C4AFntyO+qs0rLnIvLr+9710SAnXKAoPY4DJd6diLI0eTITarrFRn4K74AfOcDoLIV+QK+spLemHqIUvv6zm2xE3qoDp15YQ3WAKJf1+BvmoQd+zRSiErf9jvfueKlfciRnUPIiSt5CmM+6gz3f4+AK5UVkXWenACnkzbLU8rI6HnsDrn7+ymyRndNmLonzjZ0m9s+MYmxlwAE43m8fV3LGxUeIAWltN7U3MLCCM1W6uj4u6Ai6ybt/G7NGR+UwgZcUcnmNTIv9Kjv63lgiO0wtVkK2iZdf//URPlGNIlULt1wJlSWkpn7n3vkLTnD9QXXdfzwxD8p9d5rHEw6QZ9bUDCGSXgvbe/mZoesW32vojwvUduQKiZKfILo7YbpUdOvC7IsH+lvnwDYUiDlgYuDCunjCMw/B5eIInx09yuvLTU8IF7WWqkelMls3zSm9wbrD4c1hP89iJtHrjTeuQmcpi/aXGN4Sz0z4GH/IcCt8XGjZ/zR2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(6486002)(26005)(5660300002)(6506007)(6512007)(86362001)(2616005)(478600001)(316002)(186003)(83380400001)(54906003)(66946007)(36756003)(7416002)(8676002)(66556008)(66476007)(6916009)(4326008)(41300700001)(8936002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1rdCTSDlcr3ltLanN37FgLt0ShCPAceWwMBZpCXHw9IFJh5R9zGT3eQZkZn?=
 =?us-ascii?Q?HklsVGMNjdFB+03Hkb3l1NKllYwZ4FctVt4bETmtFtwiHQzxfZ9j/1FYzajS?=
 =?us-ascii?Q?RQ5pK9N7lzB4imdGr7780Yzbsolt4th7B7cCx6CZSSLhVIMTLBmdwTyBk3OD?=
 =?us-ascii?Q?cHHxNIdUbGjn+ZbyzPFvZIof9pQYq+O7TnSg+F/d+5p/Eir47L8EQVZwa2Ft?=
 =?us-ascii?Q?fYy3sGsVwMfgqMNdW+yVeNc4lE/OEBGfujtMn6IH25HlVB59WLU2FaNJHAQi?=
 =?us-ascii?Q?tbeqWG9hGDclr3LtE1BXrQINlp+cyWCzuCd7eQNe07sQ4HP+KwZfTPqkZzmL?=
 =?us-ascii?Q?EvTmiZi2QNRhGdktOVJslWgQsHIuNMvokigNSE1ouIFqOMqyI0RgaoLB04ir?=
 =?us-ascii?Q?N/ZWhoZncyDj3hkn07C3RLRLuzL2sr+L9hBRtnjlZacsoRnNB3LnL/tVLHCO?=
 =?us-ascii?Q?4wafR31KtKlnRiI6d4iUpviwxwEfu0UfF4xIvw2fBdFTZ/cuHKzRoZ9nuMzk?=
 =?us-ascii?Q?B+PMLGrpIJOIivFLsNjxCIhg+69J4tRTREHK0vTgiPZPUXviAswhIJ4uyYzQ?=
 =?us-ascii?Q?L/L1CVHww4t40dXaUhKhlXbMQOCpjGzjC6YyQuiyb7Htn1PfOKSAqIedM6x3?=
 =?us-ascii?Q?oEurMsmGgbEjKM7z8RngX4SUIHSPazNgiV917Bx8jzNOw6fQ8do7vQ22USgC?=
 =?us-ascii?Q?3POmfV6hvQHT8QWpwwm2YyMNv6RVwUbfcyXY4TPlkTIyrMpVFtk3CPBh9+ZK?=
 =?us-ascii?Q?aYvEHPIx5BCBMMBRJMbhZqESVMjiXpphI81p8SnyQHw/2QxJXQhv1UEROufo?=
 =?us-ascii?Q?aTMX90PDt3uMPvl/8XUNg7ycGu8dBumnnb0UVYxpzvRvD+1wMnjWHI5wO1Ik?=
 =?us-ascii?Q?9orej+r5GU/kLHbxCOA/JFrCC66qCd9XN8Tf5LQ03xz3Dm/7irO17a+IUfiM?=
 =?us-ascii?Q?4mIDfQS5MoC2BW3UFBrRaKc1tkFTlwLs6+fFig8CRfLH+DB6C8gerjPCEFDC?=
 =?us-ascii?Q?39i1YtXJKq6yEVMb2g+cOaqTCr1RafiBpKRfqn1uLcf7vUNpBj7uNezeA16/?=
 =?us-ascii?Q?GjDaadYnFq2QbzdQSjy+Pyus8pcE4CuTcMo4jdRk6C77zIoM37uas+zRTX+E?=
 =?us-ascii?Q?NCXOJArMpPUy0fTShh+PtikF/F1I3KrPBZ2Oz8EEGRWUn3vLXmRWpJB3ojam?=
 =?us-ascii?Q?vCrKwuEUu0l7bLNhXix31p6fH4kYs4d9/Rku3AMeP5MSXvdZ4X0F8gK5kw4d?=
 =?us-ascii?Q?jUHecIAt/MgZEogu3jEUIfjuY64H0NZdURObhXrLkdvUCV3ygft3XBVVMBTK?=
 =?us-ascii?Q?4ZhYXikg6ZZG/IutgIud7DVGQjdoQI9v7NAEBQAgt+LmjOhDJdtJHQp6fva6?=
 =?us-ascii?Q?74CRhrvbFn0NDiFzph02WiN3V91Tm/Cpd7F3mubIgDqJ5UJ4JGrfrUbCk74X?=
 =?us-ascii?Q?IK/XdNwxHO9kveiUlYJrbyQ7q0V0hp3nSTgnw/DOaw3vkGB/+/BquXjRkhhB?=
 =?us-ascii?Q?Ezf/79BaQzU3tF5GcqMGcF8/bDq15OJyvOXu/vdkJC0MuxaFr0d+Zb1i4ecr?=
 =?us-ascii?Q?+lZIW7RyMB5fswW0p+YSSNSh8yyfEpvCraXA1Aec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b172a4f-58cd-45f3-9d7f-08db2a023201
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:48:32.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Gf1SRpmQ7DjzuoenSlXotNWUaOK4o2bEtXy64DHA5tSQxynMvkQuzlp9Tf6Ka6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:

> > > Rephrasing that to put into a design: the IOCTL would pass a
> > > user pointer to the queue, the size of the queue, then a head
> > > pointer and a tail pointer? Then the kernel reads out all the
> > > commands between the head and the tail and handles all those
> > > invalidation commands only?
> > 
> > Yes, that is one possible design
> 
> If we cannot have the short path in the kernel then I'm not sure the
> value of using native format and queue in the uAPI. Batching can
> be enabled over any format.

SMMUv3 will have a hardware short path where the HW itself runs the
VM's command queue and does this logic.

So I like the symmetry of the SW path being close to that.

> Btw probably a dumb question. The current invalidation IOCTL is
> per hwpt. If picking a native format does it suggest making the IOCTL
> per iommufd given native format is per IOMMU and could carry
> scope bigger than a hwpt.

At least on SMMUv3 it depends on what happens with VMID.

If we can tie the VMID to the iommu_domain then the invalidation has
to flow through the iommu_domain to pick up the VMID.

If the VMID is tied to the entire iommufd_ctx then it can flow
independently.

Jason
