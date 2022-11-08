Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5478162123B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiKHNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiKHNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:23:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A24FF98;
        Tue,  8 Nov 2022 05:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpG2xSfa1HLMlUoeIi+g/7tBt0wozc7x/8D49Ji4O70BNwwr1YIswezsjosHvt9EAVDbDgm/sQlqodsxXs2gZoWN4RJkYsgXkEm3vz3ChSNvn4a/DD4oaP0WglYKGGEVqO1KGXuSbDeiZW3sRTwz1DuvHfCRReGIzJAGziTed0V8SVyid5V/AKqFua8TCoSQ66hjzm1LJXXzJ8C+JKRNk0fBlEuc5X6GaaLdaF0ewPBRdluyujOCWq5X6jPg3/1e3mP0HiYbwj5LnOgviNHweA8/8BquE1Ptl6vmVzlik/SRVRZOQpPg4got/gTD6dASGsp74vn35QEa0v/iQIt9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4lg1aVjB5ZHRwdIvv/hl2uo2jH4KOQIwL5Zvpbr0TI=;
 b=gIzS+gbXe6qSmZ+pzRjOE0mAB12perKxa9i6VlpOruutuFnuI25BhD2L3Um9XV4Y8/nEhvQD1rZbJ5ZUM4SjjWLiPipgtp+6mOIp3miHfs9RRzxd1uORmdZfoq9GgR5dxIk+dL3GlMJ6TLEb0aq8hEb6fvgj/9DKEY56GZilXrHjaMnxLEAwUmbX/McXduCxLS6Fp0hOkU0ZRa4TuAp4YysCmDK99KTPWt+3ndxaibCArPgNBIjnNaS8r1V3lI+az8AmWgxvHBC+0o1BCv9lwABUott9k4OvgEdFqbhEHpebDj1lDk+k4puuB2/QhPOCBNOikSKuZintnmvgs1f29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4lg1aVjB5ZHRwdIvv/hl2uo2jH4KOQIwL5Zvpbr0TI=;
 b=pitefX8Qc3ow3eTLM8p37Ho3H7ls2ehktxYNXaEVz4319uNjK2QpSF3rN4tVv7hlaINcm7Q0kpDGj/Qj2VnKOnZJVHCS3XuTO4Ky821t6DhJ+4xvF3dMuGI8kX7G+ZQhGq1ZDROIo1qtzclyG1dJeMe9lt3lIY1eMgSjZFju6n2iob4E+ZG5BBAu8Um5wqwjccJfyi9NzPMiXnplvYvW9qjs+kSbeAWG9nsrtPWb3c+rucM1IJZIDUxhkwhKra5zCn8GUG4DMhg2q+c20oBy5iaAzH8XJHZ4eSk2KrknBSxUKqy/qKEeXI5TITrzzigld8JgOD8wqPiyATOIXrAZlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 13:23:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 13:23:11 +0000
Date:   Tue, 8 Nov 2022 09:23:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        quic_jjohnson@quicinc.com, suravee.suthikulpanit@amd.com,
        robdclark@gmail.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        jean-philippe@linaro.org, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, yangyicong@hisilicon.com,
        yangyingliang@huawei.com, quic_saipraka@quicinc.com,
        jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <Y2pYPnjMqrwDDwB/@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
 <20221107152645.GD21002@willie-the-truck>
 <Y2mfaG1/6hd1qykW@Asurada-Nvidia>
 <20221108132041.GB22816@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108132041.GB22816@willie-the-truck>
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 68453bd6-fc3e-4d54-4584-08dac18c61f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GVZAk95Dokbdn6h4APRIbB5zfquYIHt3gvq3rjyO5rxpLEiPYc2f6Q16kgPAeAs55+e1qvAJtkpYZkcW3B+yo0If1+UPDAwWjeudH3CDIocBkEYVxrWNGr+BfT6EPiao1OyjTVMOY19hvdqG48E1OUshNvDy624A9KM2jiLMpT0npmH1EqQGkjaJjyXeGKgif90BdE0f//3528YMo3TUshutDdlAniL2tFuWWtQQo618BRZHtZHJXM3xzKoZmaZiUMQVay8dItx/uvtIGuvIh3IBuY7jNsvm7a5MFR+OkEqBPu+pfwGC0bA8K3+rN0TXnB6N4ldFT1x8ZtCOifuMISfcVj9xNNC2MYzuXMFHZPytivgG5lNIMDFUIMV34bl7imNtrmzlUpkyIzAVb2JgcRJJSu1mjThNgZ/c0w9t3GGd+TxmQIee3/TLO8JUHjkRWiIG2NDal4phm4tpRhMCJVoxJxaPJFHSxFUyC15EQ98+yQJEGbaLEsGlerFSncqiuh+HA3lA52D7dqDvS6+ktz9rLsBjTe5gyQ1kWarewqd7LY1WxnDwc3T9ygPhD+4qUBUSLfEzS01ynGhiD3YY1V17oKQckXXuXt+8a6Dyg7uI0/IGYOFEDYJPJQhlrsXDNb7G0pnn08sz/qjAjYWdJrroUzgMpdslSY4uSu3J9oWMMWNYdh/IMW1itn86i1SiUALOJzyrMz6CGNOrsQKYV4p4XZPnsNJurQenp9raGI9HZyousiM+5F47CMSswpO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(66946007)(186003)(8936002)(86362001)(66556008)(6506007)(26005)(2906002)(8676002)(66476007)(6512007)(7416002)(36756003)(7406005)(5660300002)(41300700001)(2616005)(38100700002)(83380400001)(4326008)(316002)(478600001)(6486002)(6916009)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkQCf9vuhBEdzbhXikAa2y4l3nWaDHRbjPGkY7ZSHF3zIYJN5LL4PgELSkd9?=
 =?us-ascii?Q?xZkYHpuCRDR9aGKfRYW9fWopmuslW2EIafc4gQQN3IoamcFSZeTnM8DyQ3we?=
 =?us-ascii?Q?i475crH5A/bdTh6UkZAZac48vKWpcRiTozLvR4iu/XcbkzzQtHhR3y+sZ9Np?=
 =?us-ascii?Q?U+RiK5bhmWKjiCJGXfJN+pdyLibjzSiD6l050wgunz8oipiOhgzdEpIhwK2x?=
 =?us-ascii?Q?aFVA4rtIxvoIH0DoJdC7jSkjfsUgHjWnkr9ocWqkp/gBplMJfmOrMEVZAvv2?=
 =?us-ascii?Q?/pXchugcqtReV9lRinwG7Bo+k/I/nwMNp+HbYbLpkodogSd4BRTI3heGnosv?=
 =?us-ascii?Q?mFpLMbHrR5Ls5SlPQ5sYWR/EBos9C1r3sF0OWj4UC5VpV8Rsc9+kGjGBc30m?=
 =?us-ascii?Q?m5YqLkrle23xA4vsY1OWpF6+pLp4KB0CwWXzd5gHoqWkj/6RlYoImIx7pKXT?=
 =?us-ascii?Q?qR2GtNRM9x9wzt9qlbeF+LPTZnFfPhccUlaiq2i4f2LtN7CGes7LzaX4Ax86?=
 =?us-ascii?Q?M3/50uespqgRXg5uTOqA92j/kJqaBKyXoaLMt4DzpT24L1YYvnEkB6fNHjfx?=
 =?us-ascii?Q?ARotWDtj3q+3PFfYHZJ7ZcV9Umc/keRu4IPgkEcku3amKulScU7jVRlbT68d?=
 =?us-ascii?Q?4K+3c9a5IoMo5Qx6AjsobDutG/xIomFYxBJkLbQyJp5EQmZYD/rHJDXbjkF+?=
 =?us-ascii?Q?nOD1pz2BIvYPgCSLsX30jGlNPQGfEV/RFOLTgi7JRZhwdsZgE2yR4fhAJ9iR?=
 =?us-ascii?Q?WJcv1fwuR7LP16rUmBe6093TdBEE0v2ubeHQuxRkxIfD7d2vqFPw8VkBkrkn?=
 =?us-ascii?Q?owAaJk6e0b9wmIXqahfmQ0NwwR1xUVUAc04UgIIx60//aT8M/gIq8Co8wVK1?=
 =?us-ascii?Q?aqoNOnYL4LVRESuOLoQ5JVFxkvTjumJj+8G7am5zVeQH3fyPVwLCLUncIjGH?=
 =?us-ascii?Q?arDNxqydBv24Mnda2NStobHE/ZrPg+Fd4dbR2x/e9vJ66+UQvGFd5cjeREJ9?=
 =?us-ascii?Q?nZI+E/GxEZmQaQdTEieWH74ZXype3BYSjt1Xi81ViYJMuVD9Sjh8XonAfHup?=
 =?us-ascii?Q?0CY2EftL1CcAYA/0evxYNRodbryhKBgyqga//2tYH3SpL4I6W1Mymo4pOEMx?=
 =?us-ascii?Q?XXCsjwQf1ZQ5irlQB6onvPHUsYBG8tNeQ7LOWFHRRoIM7OPp3HOFpS4jzkuy?=
 =?us-ascii?Q?McsyzDsTzk+8CbD+6FG/hXf39rR7RitYlrPwfl6VRIQNj/RkkCOMN2WzJmbz?=
 =?us-ascii?Q?k4SHd+AYPc30J7f1Jn+YT2XTNVEuP6vIcm9VhLtCtRL2skmKZgjOy2Gg9RgA?=
 =?us-ascii?Q?3DdkPlL1JEgMxUAtmMNF9+btyzx5BPs0b7lEv3Tm9g1IaY4zT/R+tyJWpLDd?=
 =?us-ascii?Q?3YUW8eRPEz1NT7167SvG8h75grgv9BC8/ZJVXKBDVyB/ZIiUmbjh3JadhvSn?=
 =?us-ascii?Q?AHpKqDxuOZGxxsJJFu0iSAchO8IiESHQ8fq2L+1HLFFLEFFcAZe2bI03Nr3r?=
 =?us-ascii?Q?3FpCTcNSEbSLEIiZW/mXwI56yIhUC2Q+gKwfBzIl2Elc004tSKgS7Y/oZxPh?=
 =?us-ascii?Q?/Av82d8ON8zgK+tnYJ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68453bd6-fc3e-4d54-4584-08dac18c61f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:23:11.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9j3Ieq90+XWaodEymm1VndKGYkQI6xFGPWhYitdQpHyiYDBEfyouYYv54g4Ivnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 01:20:42PM +0000, Will Deacon wrote:
> On Mon, Nov 07, 2022 at 04:14:32PM -0800, Nicolin Chen wrote:
> > On Mon, Nov 07, 2022 at 03:26:45PM +0000, Will Deacon wrote:
> > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index ba47c73f5b8c..01fd7df16cb9 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > > >                       goto out_unlock;
> > > >               }
> > > >       } else if (smmu_domain->smmu != smmu) {
> > > > -             dev_err(dev,
> > > > -                     "cannot attach to SMMU %s (upstream of %s)\n",
> > > > -                     dev_name(smmu_domain->smmu->dev),
> > > > -                     dev_name(smmu->dev));
> > > > -             ret = -ENXIO;
> > > > +             ret = -EINVAL;
> > > >               goto out_unlock;
> > > >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > > >                  master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> > > > -             dev_err(dev,
> > > > -                     "cannot attach to incompatible domain (%u SSID bits != %u)\n",
> > > > -                     smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
> > > >               ret = -EINVAL;
> > > >               goto out_unlock;
> > > >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > > >                  smmu_domain->stall_enabled != master->stall_enabled) {
> > > > -             dev_err(dev, "cannot attach to stall-%s domain\n",
> > > > -                     smmu_domain->stall_enabled ? "enabled" : "disabled");
> > > >               ret = -EINVAL;
> > > >               goto out_unlock;
> > > >       }
> > 
> > > I think it would be helpful to preserve these messages using
> > > dev_err_ratelimited() so that attach failure can be diagnosed without
> > > having to hack the messages back into the driver.
> > 
> > Thank you for the review.
> > 
> > The change is already picked up last week. Yet, I can add prints
> > back with a followup patch, if no one has a problem with that.
> 
> Sorry, I fell behind with upstream so I got to this late. A patch on top
> would be fantastic!
> 
> > Also, I am not quite sure what the use case would be to have an
> > error print. Perhaps dev_dbg() would be more fitting if it is
> > just for diagnosis?
> 
> Sure, that works for me. I think the messages are useful for folks
> triggering this path e.g. via sysfs but if they're limited to debug I think
> that's better than removing them altogether.

I suspsect it has to be dbg - vfio/iommufd will probably trigger these
messages as it probes for domains that are compatible - eg certainly
the first one. Even if it is a "once" it would still emit a confusing
message for a normal occurance.

This is why they were removed in the first place..

Jason
