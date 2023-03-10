Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C246B3510
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCJDwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCJDv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:51:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B0102B56
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:51:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfko3vsc0CQW9JXFRw2/mGz9mcrUg3XS81QC6rYaO5AOO1ISXZ8POnwWKE1Jbo5jTsf81cx5gJYllrcTClAFLirSi7K2c2JbonMOJmb5DVwKC9sc7PA65LeMn5KTfCQhZtTGkxu09R+ZJQsGNahU6lHDDtKwEe16udeP7YClT9z8PwmbanFfy5QAb/EAoS+au4owCXpwxmgm9MWAaCfRwzdOWjP1NIcdX76JUk7Sc9C4Nk5jcqipAAonXIlwVqH4ZAT7PnG7acsmL3yESU1q8gBbmX10B0GfptlMkUWdfju6Vt0sc4w87dZb7QkTJWO+jC+YrCTUkpBzOpp+iM7r6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiY0ZHGQ8vjZh0sUqTsm3z5voZ5jnNpo71s+xoHldG0=;
 b=YTlkp00OWATQKMgzCwxCFvPZWZBoLOKVf7+6HUCchuo7Sh22dj8eYeHaqKVf76+nM+yH9SGjYHRhi79VLtgT8CiP713XJg9sfTk4UC8lH1eMwZg+ASPYcZZjtGGO+JW4xrqYrQC6kDjmxhx/xrpZRbpCCvf7u8swS0o4OQkq88EsgWrAHJAE66VCb9yiN2FGb9p4KMKc6PX7fDZ7J6DSLUieN+GggOtQ8U8NHZ2UXiL0qplyBPuqO43BRyf6brg/XujXNRqXScrCDvkIt4BB5wJUvH6HReX4l0YMhpNPXddZi17xHGeCZB7y6p6WDV35gdvZG+zw489jdtIAbDo1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiY0ZHGQ8vjZh0sUqTsm3z5voZ5jnNpo71s+xoHldG0=;
 b=RPtc45jXDfhMKvn0xe7xy8abfiO8HwIx23kmjKWoZwm9ebjhqgMSHZJ68NDDGovNmRIPlfqE9Sw1QibZi2VBv2Rr/WkDuYEnVCBjsY+2LLxTulKL7hxANGD9A3S8zVOoxoxMnJ9uPUy9szHW9nmwv3zepDKUB1GJhUDyUe4Jb+S7OGAiZU1WT53Uc4Q6V9DPzyIqEOXzoXtTGr7hHh9cvnvH6K186KFKOjvCdWq/Y9uQNBlIvFfFyYlKB8W1lgxX2m3JbqjavSBBSiiNeEKbT8A3ozFlv8rTnbVBZQqwa57nZGT7auArmrpHYJ0LaQVRjxh1vGzIZr1/Y8SEAoB3jQ==
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 03:51:34 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::86) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 03:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 03:51:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 19:51:24 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 19:51:24 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 19:51:23 -0800
Date:   Thu, 9 Mar 2023 19:51:21 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a88218-50e4-4a4d-abde-08db211abe0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2A/egkwjyFRejwCRLQ0ydQjqWwXywVRQKaBTJ4JChhc87V1n9xIRDODrPTKJb0g+m0NydTJ2svY3tjeeMHRybC6tLNAwups6QLlRSum0V1oXyMIDjoH13fMTCPH42ZIn1bGw1dxhp48q6qXG7pJu47rQoterwalyjz2qU7tl91rgGT9vaaSdbZn8rEyDaHWr57KhskDKtgig/RzZdpAe9ED5Vsksaw+Mt9zIlslYYlA9fXjbsGpJzbHi/wH+cUdV8Uaj4IV2bf6AqZW9euiEcx9wgzHqMCRA9OT75nZO5i/QQrXIo0P0IzEWA4J3QWfzn7tM27JGOcU2jlKGm4BZTLMM4/sMuXaclIaWBwB694o/ZvL4repyah4xjp1ScH8y6HaphX9B/KHxrVnxQPN0Ue8xltN84HxTnY7hWjsjsI3iLSEjtnbbI5AuvZZdLludX1hHTtECdx8x3F+PLtEgxldOYIGysiQgz6IRVUWcbwczYuGMiZ6WF8QVcaCWGHLk+lW60t2Cg7f5XnTTGRFKp4H2M2rNryjqeY6T+culIc5gxhtJBRBqFf9A/nzt6cbZ0HtR2B+hj3UYz60rq1ad/S8XfM1K//nlUM4Ly7rghtYn4507OSnii4oyuimXnouBfiyz76auEYrYWHjawudTQUMF+KBEhSA9nXt8Zqn3UpddS472uNHy2pu2k31XYC0UPYO+JTsgSTpTc5kjulKsJhldgIJiebBOLRPwG5xGck8jE6JsW6NLopfAmvKa7GcF8g1FCIXJ29crXpIbrcq/m9wB53qmK7Bx69xiLnmjNrW6Zb03/fGdpWLd+8pzIDG8wxu/KeTH5kI5ryctmtQlMPacKLlDAiDudse6ACb5OkZZ7KfWhdAmJaYawnox+O7TKZqEkKWk/h33oS9Z3YKynXYX8cjMqJWl/V12e/vx87M=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(47076005)(426003)(336012)(66899018)(54906003)(40460700003)(55016003)(356005)(86362001)(82740400003)(40480700001)(26005)(36860700001)(7636003)(53546011)(82310400005)(83380400001)(9686003)(186003)(33716001)(6916009)(316002)(7416002)(966005)(5660300002)(478600001)(2906002)(41300700001)(4326008)(8936002)(70586007)(70206006)(8676002)(67856001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:51:34.3215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a88218-50e4-4a4d-abde-08db211abe0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:49:14PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-09 10:53, Nicolin Chen wrote:
> > Add arm_smmu_cache_invalidate_user() function for user space to invalidate
> > TLB entries and Context Descriptors, since either an IO page table entrie
> > or a Context Descriptor in the user space is still cached by the hardware.
> > 
> > The input user_data is defined in "struct iommu_hwpt_invalidate_arm_smmuv3"
> > that contains the essential data for corresponding invalidation commands.
> > 
> > Co-developed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 56 +++++++++++++++++++++
> >   1 file changed, 56 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index ac63185ae268..7d73eab5e7f4 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2880,9 +2880,65 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >       arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
> >   }
> > 
> > +static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
> > +                                        void *user_data)
> > +{
> > +     struct iommu_hwpt_invalidate_arm_smmuv3 *inv_info = user_data;
> > +     struct arm_smmu_cmdq_ent cmd = { .opcode = inv_info->opcode };
> > +     struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     size_t granule_size = inv_info->granule_size;
> > +     unsigned long iova = 0;
> > +     size_t size = 0;
> > +     int ssid = 0;
> > +
> > +     if (!smmu || !smmu_domain->s2 || domain->type != IOMMU_DOMAIN_NESTED)
> > +             return;
> > +
> > +     switch (inv_info->opcode) {
> > +     case CMDQ_OP_CFGI_CD:
> > +     case CMDQ_OP_CFGI_CD_ALL:
> > +             return arm_smmu_sync_cd(smmu_domain, inv_info->ssid, true);
> 
> Since we let the guest choose its own S1Fmt (and S1CDMax, yet not
> S1DSS?), how can we assume leaf = true here?

The s1dss is forwarded in the user_data structure too. So, the
driver should have set that too down to a nested STE. Will add
this missing pathway.

And you are right that the guest OS can use a 2-level table, so
we should set leaf = false to cover all cases, I think.

> > +     case CMDQ_OP_TLBI_NH_VA:
> > +             cmd.tlbi.asid = inv_info->asid;
> > +             fallthrough;
> > +     case CMDQ_OP_TLBI_NH_VAA:
> > +             if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||
> 
> Non-range invalidations with TG=0 are perfectly legal, and should not be
> ignored.

I assume that you are talking about the pgsize_bitmap check.

QEMU embeds a !tg case into the granule_size [1]. So it might
not be straightforward to cover that case. Let me see how to
untangle different cases and handle them accordingly.

[1] https://patchew.org/QEMU/20200824094811.15439-1-peter.maydell@linaro.org/20200824094811.15439-9-peter.maydell@linaro.org/

> > +                 granule_size & ~(1ULL << __ffs(granule_size)))
> 
> If that's intended to mean is_power_of_2(), please just use is_power_of_2().
> 
> > +                     return;
> > +
> > +             iova = inv_info->range.start;
> > +             size = inv_info->range.last - inv_info->range.start + 1;
> 
> If the design here is that user_data is so deeply driver-specific and
> special to the point that it can't possibly be passed as a type-checked
> union of the known and publicly-visible UAPI types that it is, wouldn't
> it make sense to just encode the whole thing in the expected format and
> not have to make these kinds of niggling little conversions at both ends?

Hmm, that makes sense to me.

I just tracked back the history of Eric's previous work. There
was a mismatch between guest and host that RIL isn't supported
by the hardware. Now, guest can have whatever information it'd
need from the host to send supported instructions.

> > +             if (!size)
> > +                     return;
> > +
> > +             cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
> > +             cmd.tlbi.leaf = inv_info->flags & IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF;
> > +             __arm_smmu_tlb_inv_range(&cmd, iova, size, granule_size, smmu_domain);
> > +             break;
> > +     case CMDQ_OP_TLBI_NH_ASID:
> > +             cmd.tlbi.asid = inv_info->asid;
> > +             fallthrough;
> > +     case CMDQ_OP_TLBI_NH_ALL:
> > +             cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
> > +             arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> > +             break;
> > +     case CMDQ_OP_ATC_INV:
> > +             ssid = inv_info->ssid;
> > +             iova = inv_info->range.start;
> > +             size = inv_info->range.last - inv_info->range.start + 1;
> > +             break;
> 
> Can we do any better than multiplying every single ATC_INV command, even
> for random bogus StreamIDs, into multiple commands across every physical
> device? In fact, I'm not entirely confident this isn't problematic, if
> the guest wishes to send invalidations for one device specifically while
> it's put some other device into a state where sending it a command would
> do something bad. At the very least, it's liable to be confusing if the
> guest sends a command for one StreamID but gets an error back for a
> different one.

We'd need here an sid translation from the guest value to the
host value to specify a device, so as not to multiply the cmd
with the device list, if I understand it correctly?

> And if we expect ATS, what about PRI? Per patch #4 you're currently
> offering that to the guest as well.

Oh, I should have probably blocked PRI. The PRI and the fault
injection will be followed after the basic 2-stage translation
patches. And I don't have a supporting hardware to test PRI.

> 
> > +     default:
> > +             return;
> 
> What about NSNH_ALL? That still needs to invalidate all the S1 context
> that the guest *thinks* it's invalidating.

NSNH_ALL is translated to NH_ALL at the guest level. But maybe
it should have been done here instead.

Thanks
Nic
