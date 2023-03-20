Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3F6C1AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjCTQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCTQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:13:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D724BDDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6o2NFjuKKzMdsPrPvUjfUjdO3mP5nJKxvptqBxYPasyZoczGe1RY1sBytYDC+QoTxa7YJewvL8Dj0edxXyS43BFye+ZMiNcB0oMZgoMFHEmq89HvPJMMz0gctR0saSTUfv+Lh62nyEByVjRI/nJFpKgoVQXlh4LsP1Vip6hGhG5AsVcy21gCclsdYoMwrnMj+ZZMSoS5zCGw+YlW2BDEO02eqZYQPB2RJ67HrqaK/lRxfYBu6f8RMhFndzHkDGOA41iy4XEqvvqo14EHH//1HxzLFIfJULwQh1cxtmsFVRVZ3cuZOSGdSB5gvLVoCLaIEtMF2qew8mUwH6Zbc6u3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSU0iSAIG4Ld5lJp0Crvieg9dgg09hY15Mi7uSySmFs=;
 b=dA3r4YXHE/uMrNBHQE7Ptixia6fKRhlu1S8PvSWpDJAg2Mc+ayjb8W6imWuKPcIZqSuc+IzaVGRm+DcoRiG++xsn7N0QYC5Bv3rD0sqsq6oVFQ6Ua2oziCiPi9tHpGeYNM3ivTzZitYfvUT+7xzCarTEUWRdMyj4hpyt1L5Q0KB/s5YinepP57OgueL0A5E4OKFjVnOh7s/p1AX7QNamMzvWBlg9TQv+bAHL4XhTRCvD/Vjca8Oix2v7N/gEenUTS13r1zsEKipVFBS0Pjd4g8epJ+ZLkSBSRQmZCGiVDEGoe8XU6JlwtQUMwmHIP41gmnDH9Es2vONQ3Ka2buTGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSU0iSAIG4Ld5lJp0Crvieg9dgg09hY15Mi7uSySmFs=;
 b=JmhPoUnUICZ/XZiFG8vOD4Pqc2yD2i4lE586sBRpS7epZJbQL4sWQ5cCr+JoJmJnmaP+0dQjepIIvgWYyBZx04sziRdhK14DEhBG67M7VpNQhHQcF58Ss3eS8/+fahhmB975aLP581mOb4f0TmECdaF7YkwNbABXJwseFAssuxd+2wqFBRCyEwzrJnrowC7Ea7/l1XUdpz9WppewvnIt/B1LGG6i309sSbxzdQ2D6TUbgiQnnYoomqjaeHxLwPZ7rodcTU15ayc/4yppLmQsmUaKT2oPhxi+rQEvSyldyf3GmvJZ+tWdwjzhROrdGMp+UYvnqiqJFVQFggCjgLDjjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:01:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:01:55 +0000
Date:   Mon, 20 Mar 2023 13:01:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBiDcYwxL7eV1EmQ@nvidia.com>
References: <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
 <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e77002-1a94-403a-7ff2-08db295c6d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdiQGCh3DAkHeLUxdW/u84ruTymXbpBkTzokIeObKwFrLOW/TCcTieQmY6DmNxujNBYcS1HeEveHKP7V98xMJEitkb65JzfHLcPI3o4qda6YC7Txguzei0uLj+FaSCZrYcjCiM645gDJkHALMl0QV/qB/T0LY9tltIYzH/grMWc2JYRRQUnG2u5O9ni2MQGC2KF7MWl7nV4RsFcDOCkxayygIH7vG3L09HOzpSiA7Hed/5pdY3Kv/9P5CSx5u7YzDnJCX4apKdK2DVonQjqXBX/o//phRX8sysBg84fEEvylc4/5UGRw9uv9l2RxxDKlbo0i7+AYpFNx5CE95jFo/JOEtQkX2qAv3+68PqQ32PN4dYxGBYkbPbOXAfF8FoTiY7ClWCy2QelhUpS7Whz5SiIOyzIF/EPe/WoczWcZxJgeCnlqiHe3+tlnoSMg9DNK5ejzOoynNcbnbSsd5F3h7Jk1GqyYueEXeRNUqo/qiQIJqnYdm1FIrt+7IKvEWa+0vdiJB3wiXVhhJq9AGa45X6v6zOfD+524w72fK5ABKLPKWy+733F2Xd01ipmT50fncyL22c/0Ji7iNcUa8t+BYoWLmLyty8LHGYZyD+QHdv/ebiQTnSDrX7b1xTq/Rrg6oINjf2UZ15SryaCleIw0vmISNGs+UE728hcDONjWEF/egu9XfJyU8x366c8fll3a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199018)(6636002)(83380400001)(2616005)(86362001)(38100700002)(4326008)(41300700001)(36756003)(8676002)(66476007)(66556008)(2906002)(6862004)(66946007)(8936002)(5660300002)(6512007)(186003)(26005)(37006003)(316002)(478600001)(6486002)(7416002)(6506007)(341764005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?046HdMFVxTnOGAS2vV4cd17E3ytDEleMvzbhJmEZ2CXin7QD8WnfynWCW8GQ?=
 =?us-ascii?Q?1A+ZpF/OaS6vrDYCwGyyNaFTi6SRLp5M5HLJB64hj/8Yqe6zExjsoEvu35eb?=
 =?us-ascii?Q?fmiXro2QMBOKQvttJQs1lM4I/EIvIQYJnHkQMCqbcrycvXNpCHBoifwwdZE/?=
 =?us-ascii?Q?fLpyyLkuRYEVj9uKrsEj+FZ1WE7pH8w/rDUygyzeKhENQwuMxT3XbCOtxvj/?=
 =?us-ascii?Q?Acgl3xCQVuObnKog5zefYR+joS+uf8uXYZZi4ZZsurY4Kc74U1pOB4juqfod?=
 =?us-ascii?Q?/IlfASDQXU/4rMZcD/noVcDhZCvCmltBGL4dxqAFkMyyf3w53lOn/W0g7C8S?=
 =?us-ascii?Q?2TCaQsuOnTyqM8KXYu6PPiHGtTwt+hnz2HMZ0EVbGNMFa0QfV5AmPvWvM3QE?=
 =?us-ascii?Q?1sEysn3yWfiUbzIIMTap82cKPp7AfaxJr6eHfECLt6vIRMdrN/Kt9SBeGxbS?=
 =?us-ascii?Q?tluCwg4ndOqskfq77K8Wm42iqQeEqHI/Jg5t2zvrPvlNGKzD0ZGcJo0YjJUp?=
 =?us-ascii?Q?Yv7TPAGkF5f51msJ1IM8yFlVDYqzzne8OP8Hf62TdVBHLCxJCbSzPCD9R9c5?=
 =?us-ascii?Q?hhA8EToLVBImDYbj1Me5VHp69eByRfS99KCzCGcAQNMS+B7AWEsr3ZYlSwJP?=
 =?us-ascii?Q?BvIcZxTU3EicAvlEmdu9bohddYaZZanttWr6kjOnawvUk5J0S7RzOSwNKz32?=
 =?us-ascii?Q?2FaHSLcmJKaR5zbh3UUjSQTr/AojpqLdDZANIlvGJgVXyrpYnakL/QhFdGuf?=
 =?us-ascii?Q?tNCd3vAueeKv/y4W+QeDbpHWCBFuGc+Qn341ZLl5d+fRryZG/VJXkhEqMJy/?=
 =?us-ascii?Q?95tR74tkOr6pI3OMZKJBedxCJjbtqv7B6Y42KL4oEserlSpZWQAKdPtn3s+V?=
 =?us-ascii?Q?+e7D/XIgGNsf2rsmrWBUepHmzfSrZilyD47nuyu3+KYa4k9vRotpo9hRZnfo?=
 =?us-ascii?Q?lbOMqejV5ynyq5xNQ591fYlVsVg4TFapvLWTxHxXogUNChrRjo8ID5rzS760?=
 =?us-ascii?Q?SrlGXlq/SZiMIxxVl1k2V8kYC7LjSZr1z8/DfEdkM6xw8m4bc96F2NVPxYo1?=
 =?us-ascii?Q?PW7eD3HqsFv88DUQgVXD6DxNtYw4SGv2f2kKC2Hl5bNXsS82gE7V7gYqbvwP?=
 =?us-ascii?Q?L+k5XMVLOLpFm3CpPE4hU/MNVO6yHsyBTjgamBbb7v9RA/4ttOi3WfHNyBJ9?=
 =?us-ascii?Q?dIMLADqfiP89PqyCqsz79MKGBwwSxe3LiCObO+xwb3O5crEPB9GKG4pCfp5I?=
 =?us-ascii?Q?luZhaNPeWjvlnnir1SntFD9z1DzrJj4RaP6zHyeF6LokJydoZVzom+FIhB3c?=
 =?us-ascii?Q?y24boJy6iLin8kBYbo2HrXaQE9cXissyZp+ZgoHjKUv3bs1nz9k/5a7RgEr4?=
 =?us-ascii?Q?uFQHLoBADJ0uG37x6WcqqeJDIIKpmedbIMnnlcNBKOLwIafHqhgaoAijr0cW?=
 =?us-ascii?Q?0twRZhW0XzNcvPFiKP9HbzEEK+bcBuWIJgYUpFyIplcnRzcbOmNRLDiXTotE?=
 =?us-ascii?Q?5XTn3RjtSYyF9Ql3CqYp3CK8q1N0gxB+elcZmk27Cal4+gV8P4+s+Yo3bm1m?=
 =?us-ascii?Q?qQL/fpSSh3DbsDl2xcFETHYW0eL1GOjnIH6HQ0VQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e77002-1a94-403a-7ff2-08db295c6d1f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:01:54.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fIOlxZdxslK655nGI2RGwNRV9eaGwB5RZKUwGoKPVuIgnHkvMbNwZdvUG7VkY1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:28:05AM -0700, Nicolin Chen wrote:
> On Mon, Mar 20, 2023 at 10:11:54AM -0300, Jason Gunthorpe wrote:
> > On Sun, Mar 19, 2023 at 06:32:03PM -0700, Nicolin Chen wrote:
> > 
> > > +struct iommu_hwpt_invalidate_arm_smmuv3 {
> > > +       struct iommu_iova_range range;
> > 
> > what is this?
> 
> Not used. A copy-n-paste mistake :(
> 
> > 
> > > +       __u64 cmd[2];
> > > +};
> > 
> > You still have to do something with the SID. We can't just allow any
> > un-validated SID value - the driver has to check the incoming SID
> > against allowed SIDs for this iommufd_ctx
> 
> Hmm, that's something "missing" even in the current design.
> 
> Yet, most of the TLBI commands don't hold an SID field. So,
> the hypervisor only trapping a queue write-pointer movement
> cannot get the exact vSID for a TLBI command. What our QEMU
> code currently does is simply broadcasting all the devices
> on the list of attaching devices to the vSMMU, which means
> that such an enforcement in the kernel would basically just
> allow any vSID (device) that's attached to the domain?

SID is only used for managing the ATC as far as I know. It is because
the ASID doesn't convey enough information to determine what PCI RID
to generate an ATC invalidation for.

We shouldn't be broadcasting for efficiency, at least it should not be
baked into the API.

You need to know what devices the vSID is targetting ang issues
invalidations only for those devices.

Jason
