Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9B6BC23A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjCPANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCPANg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:13:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA9C1554D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxDAz8AaV0mmtsF/KgdBJYD5yV0zaRXutSnFKXM52CeT+6oK9LBdFt2OTctbdHbaI5P5rjpZJ/dSmU1neXuJzMNSFysOqYua5Ir+U23jzqf4pIxMlpI7AC69bfcBcX5qfcC0o7ChjXo9/WYoZA8gZB42ZL1XzX/lA2sSk8GqgA2qN7IZYY+sXyKonNwO3uns+FYhtDY7K/18wABkBKPp+/I39iEj2i635M8n5er9KmhnoTg8v+kMN2NoQbpKiK+/n0WfoPyRK84cEhOWaBZ36j4UNcVr8J4zSX1I8bSYBOegyrbRnyuz4/nqH+3RRN5hYCH/EcFyJOoIWg+hbDsY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGpGtz0fL4b/ZVLNISXdfrP6IMnpyLkptZw/W0FjHpU=;
 b=nWVcHhYJFroRy86MViaXtyVElEGXLPXWDb27369Xy/DRSAXC++lEQFuX31j4u/hdZ7lk40hGQ/ZFJ6eRJf91smoPBKWmkVC3iP8g1z7tkQFuq1Z8nZrZ5haoYLisUVEUkqWOT9kSeRL8PVenGz+kuuGXWHjKfFoGaNlsIEzDvv58QF86DDy9PmX6QYVmtPREh/yHTt0weBNoyFgGph0vAP2vbEsXDBeSL4GwsJxLYjt86l8gsRJr20lXhnN/c+lVPZArAmLe3AIf0//KEXFy4QYu/XSPzx373DZI30f5Ep4GPzUe6DSsz4Zw9/iw/DAgNoo8kSFSyyZAdWV4ivzZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGpGtz0fL4b/ZVLNISXdfrP6IMnpyLkptZw/W0FjHpU=;
 b=StwIoVy1QJipzdW7E8hDld4DFJGWulTKRIvCJ8ejra4wO9FEeqnAFXdDV8Zh1aWRBIhKL06VRFpD4K8XBPvJ4QXAEjLkN+Za5nFhybWTPjdF+dmRBOWZmYEFT8+OAL2NfJygZcu/nhZjeJLrfBaFC/PeCgX07IFruqzRRiAc9ZCcBBE341kggYczMVWoUqKkL7C42Nebg9k9eLgPAf0dper0onB5BAmHLPgIsIbwgySOmaRx8ckjR/y9ou6oDjNqc4mVMNogf1viJM8Yc/Xp9g6RU4IB8dk8ji1X+b3Wf8rQTU8KGDy3daqTah8eYmyC8OIGF9nojxogA8G/lfXyuQ==
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:13:30 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::1a) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Thu, 16 Mar 2023 00:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Thu, 16 Mar 2023 00:13:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 17:13:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 15 Mar
 2023 17:13:28 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 17:13:27 -0700
Date:   Wed, 15 Mar 2023 17:13:25 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Message-ID: <ZBJfJUjbAUId68s1@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
 <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
 <ZAqFFolbw5xoJDfb@Asurada-Nvidia>
 <5cc56149-965a-bb47-f23f-6aa9d0ecce4e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5cc56149-965a-bb47-f23f-6aa9d0ecce4e@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f5e4d4-c465-4754-00f4-08db25b34589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioxHrwDWCXRTnbEme/pnf6LE6VILYxc5/srq7XvB2TPZ/A7NuTYNaifs/1FpXch9zO/7UfEP8CxWYhRmogcqbnZ6FJBbmrq/cj413psh+kKlms4iROTrvMpIQWB8JuByoKgwytFyAPHU1NUKUu1iLTQ/JC+Np8JCHcGVqAi+BlmN0pCl6MypIJNzTQa3rHDPizm30Lr+bz6HiUJAntdok+JJkias9aS1upCCitqyIdfYJjnYLz7kCtZU4tjzoW2w9rivaFIftISSijuuK16ZKQi9o+xeG2IEdMkrblGWRQBznGY4YYBKrJ+ztzH3OAkLeU2cw4EEv4crjeVeXK4CoaYjPxpwVXoR3UQQzaYHYn2Mcl/QbwTHFbiTsxVWlApEctSCFZCG0wMhD5Dka6geS+XDYcFeDkAxVnjpBe+2yRHaY8DpjN5bjSGwNnfhlR+hMe63NbKgkqU5SdN/4HuvoSHM9EL/51BW3VflmNvD7NJ4uQlkuawrN1rSXlgiM96mCz85dsB8N8grzib8Lfh79vgGTqTKMxh4hLJGHMV9NJ2j5SAUTA7u5YuOVx31+GfSQeWMZ+seNzwGpZVPdCCSifkj7cPx32Pd2EAASthDfnPjdJK8ciDTeXETwyp0tQN/UWUoLMB67f3L50BfJV92z/PSH53uwy0v7f09k0Rm0ONCWEmB3UtmqBzNPpshiZgUhTHD1q75OpEshgbue5HiyGvJ35AcqhOWLfwnmNkcLGgfQ+qsf6ZAFjqbt1XmyPEgKrFeWUQzPfFJrcAPrzU+mLwgJ9fNFSNPuLOAhzFbWQx4nEprVoQFkdb+cF8ILKZVxq6hz0VuywITDiOGT3vRcw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(7636003)(2906002)(41300700001)(83380400001)(7416002)(5660300002)(40460700003)(54906003)(8676002)(40480700001)(55016003)(8936002)(4326008)(6916009)(356005)(70206006)(70586007)(36860700001)(82740400003)(86362001)(316002)(82310400005)(426003)(186003)(478600001)(47076005)(33716001)(336012)(966005)(53546011)(9686003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:13:29.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f5e4d4-c465-4754-00f4-08db25b34589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:28:56PM +0000, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-10 01:17, Nicolin Chen wrote:
> > Hi Robin,
> > 
> > Thanks for the inputs.
> > 
> > On Thu, Mar 09, 2023 at 01:03:41PM +0000, Robin Murphy wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On 2023-03-09 10:53, Nicolin Chen wrote:
> > > > This is used to forward the host IDR values to the user space, so the
> > > > hypervisor and the guest VM can learn about the underlying hardware's
> > > > capabilities.
> > > > 
> > > > Also, set the driver_type to IOMMU_HW_INFO_TYPE_ARM_SMMUV3 to pass the
> > > > corresponding type sanity in the core.
> > > > 
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++
> > > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
> > > >    include/uapi/linux/iommufd.h                | 14 ++++++++++++
> > > >    3 files changed, 41 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index f2425b0f0cd6..c1aac695ae0d 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -2005,6 +2005,29 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
> > > >        }
> > > >    }
> > > > 
> > > > +static void *arm_smmu_hw_info(struct device *dev, u32 *length)
> > > > +{
> > > > +     struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > > +     struct iommu_hw_info_smmuv3 *info;
> > > > +     void *base_idr;
> > > > +     int i;
> > > > +
> > > > +     if (!master || !master->smmu)
> > > > +             return ERR_PTR(-ENODEV);
> > > > +
> > > > +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> > > > +     if (!info)
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     base_idr = master->smmu->base + ARM_SMMU_IDR0;
> > > > +     for (i = 0; i <= 5; i++)
> > > > +             info->idr[i] = readl_relaxed(base_idr + 0x4 * i);
> > > 
> > > You need to take firmware overrides etc. into account here. In
> > > particular, features like BTM may need to be hidden to work around
> > > errata either in the system integration or the SMMU itself. It isn't
> > > reasonable to expect every VMM to be aware of every erratum and
> > > workaround, and there may even be workarounds where we need to go out of
> > > our way to prevent guests from trying to use certain features in order
> > > to maintain correctness at S2.
> > 
> > We can add a bit of overrides after this for errata, perhaps?
> > 
> > I have some trouble with finding the errata docs. Would it be
> > possible for you to direct me to it with a link maybe?
> 
> The key Arm term is "Software Developer Errata Notice", or just SDEN.
> Here's the ones for MMU-600 and MMU-700:
> 
> https://developer.arm.com/documentation/SDEN-946810/latest/

This page shows "Arm CoreLink MMU-600 System Memory Management
Unit Software Developer Errata Notice" but the downloaded file
is "Arm CoreLink CI-700 Coherent Interconnect" errata notice.
And I don't quite understand what it's about.

> https://developer.arm.com/documentation/SDEN-1786925/latest/

Yea, this one I got an "MMU-700 System Memory Management Unit"
SMMU errata file that I can read and understand.

> Note that until now it has been extremely fortunate that in pretty much
> every case Linux either hasn't supported the affected feature at all, or
> has happened to avoid meeting the conditions. Once we do introduce
> nesting support that all goes out the window (and I'll have to think
> more when reviewing new errata in future...)
> 
> I've been putting off revisiting all the existing errata to figure out
> what we'd need to do until new nesting patches appeared, so I'll try to
> get to that soon now. I think in many cases it's likely to be best to
> just disallowing nesting entirely on affected implementations.

Do we have already a list of "affected implementations"? Or,
we would need to make such a list now? In a latter case, can
these affected implementations be detected from their IRD0-5
registers, so that we can simply do something in hw_info()?

Thanks
Nic
