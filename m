Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF076BD993
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCPTvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCPTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:51:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37FB06F0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT0dIk4Le2Jkastv5B0IkOgSdNTri6NB5vyyyXaLcfwFXbqN/fsNH2UH4tnUIFLko66IZFCSmfYFu0R/Xl8F2npJvwjYN+O5SxtS/hB23sqOaJ2sWN4qU3LOJAcOJYocglFkXT6y4+8DDnwbOyBCHwsfnB3jleneNXPRFd80fRwriAOQxEyhxtA3j/G3VCQTF5KlmGur882OcQDc2hnmdC7vNVsmsmMdpQ1MPN73G2pWWcdU9uTrfAxhDO+DUbXk014opyMHlpm/dFLVNVLWZH8kekOTnrtRpu1+dVRbgFq5/Z9WBFJY3RUPjYs5PMCIfnPjB0c0iLRyERBodKb8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eXqHdKir2xBgeU7fZND8Z6z+u1qRc/SC8fJS7Yx4yA=;
 b=V7jgFdMDrLPUxf84ki0Yvh7CPxflE0RaAkhacM48eJQXYJNAe9JjK3YrYwC+QqBoF7Q3paQErxGpJRe9pcidVIRX276RW7Azwgg6//T9oV4wT2FjDs5tbQkgy91t0xvetfLZiDU6OPnYhLI5HUOnX0DyyqnAyNtLYMW7c1u7x51eR9i/CpkaYcerCImm1RMIpnZQ/Eljr1aHggABKoVWxR6IbvhqtgTYaxqDoBoDsRV70ZAM/0BgueC1Hm5rxdxmfeOlU0V10WrNvEvKwMxDoKYo0i8ZBT6/soV93hpG1tiUxS9TYyXCXotNqM4qZ5FOZco0VsLbnlVmVMRBsxeU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eXqHdKir2xBgeU7fZND8Z6z+u1qRc/SC8fJS7Yx4yA=;
 b=JmxVtxKAV6q8qpwIz2HASmQrltpLbTG5g3GueXzY7TzitCgFAg3GXd63KFgHQoYOkmGnoPk+tuHd8rgSppcsiF9ZuYmj/VoWjP7/hCgM+Djo2LIXvJ4vY9VOlaIn2PFaWQrHi9bUtUR0s+hw5ZkMwjf0vt82Nb9DoSflQ9H4fCq+kemaBU/VI8mFmwCj2SyQDrYY6L420f4hwN+0anC9O4srEz1b1mUd6hf5QjUWe9l80Ok4X2qC33tes+ler1cnfIWo0jZs5DCmnfG00F4bjHq0IH1KNibpi/fDs3QaMkN6uSO6AVD/RfnBO86CcYa51BoFncJf2nuaz25q/Fd3yQ==
Received: from BN9PR03CA0198.namprd03.prod.outlook.com (2603:10b6:408:f9::23)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 19:51:35 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::b3) by BN9PR03CA0198.outlook.office365.com
 (2603:10b6:408:f9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30 via Frontend
 Transport; Thu, 16 Mar 2023 19:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.19 via Frontend Transport; Thu, 16 Mar 2023 19:51:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 16 Mar 2023
 12:51:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 16 Mar
 2023 12:51:21 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 16 Mar 2023 12:51:20 -0700
Date:   Thu, 16 Mar 2023 12:51:18 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Eric Auger" <eric.auger@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZBNzNo96O/Cnhe2R@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
 <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com>
 <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com>
 <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5ab261-df37-4c3e-20ad-08db2657d894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMthd2Dmc6/p5jTRsPz+jM3E9UzUkGoY/OwLKqBT9leN7/lZSVD1DdsKOfjbjf+hvR7Bm5tUlaaEXGD0Ew9Nal5Ytn2q4NYClTgfhamGEnoGAroPFcMiWAGzTJ2pownZlrolsGz5g7bbm9Y6MYnHRhyupjsu+8sZpa8U6zR5Qnr1Gg4Bj6hmooH3MGilptOs4+zUg4QdcTOjOHUUgMpLKhrl6Np3SOKX+oCheiAJMA0wJFf0ML4tKViPeHmkmgvM9qa97f+PvMCFoIMGWX0NjPTDHhKaSNdCpaqlK/OQD1JGV3ENnLUDXrYU3USXLBIRcpHifQ3feQTInyya9WdNF11oBwR51Nx2nNfzkro4RsECae2dyWuHiSLUIfSivMwxLJSWEsyBxXW5iTmHU6GVefT0Tv5iS8UbEhEzLRX3eINK8BU1rCWzdF6jYduMkVcfVO9b89gtmRbfe/bX5qTOACZvQrRBsJKcc4NqDgKHBhWeVxadGcKl0ymk+vBlmlrEzGWLlCGdv0w4VRs+HEHum0ujaK1rK6bwiPNKe9SbxzBQOPCf4O+Md45dZbskcm0wATB110QsvFkregrYGfA8bq2s5aNF873+1AeE7wZXg345iNSBYKrUlSnmq7SK9GEV+BYGIhTaWwpDmyJc6AadxkiuIimOlInF3bzC9vI5O+Rsm+E2V/gheg74s+EUbIlWHhJnIqhXJi6pinURRuqoNpjEoLlzbs0NxAUX7uH7TFEFH2MeEngDzVbmszwQGJfKfFYo12gO3Cp1gp5DGEriCXXrQPQNU7DWBbgc6GHW/mpgIwywYFSKxb4LgAMdRpr/uY1tOUL2ISV++MxkuMLoTA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(36860700001)(356005)(82740400003)(7636003)(2906002)(4326008)(7416002)(41300700001)(5660300002)(8936002)(40480700001)(82310400005)(55016003)(40460700003)(33716001)(186003)(9686003)(53546011)(26005)(336012)(426003)(83380400001)(47076005)(110136005)(316002)(54906003)(8676002)(70586007)(70206006)(966005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 19:51:33.8622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5ab261-df37-4c3e-20ad-08db2657d894
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer/Eric,

On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi wrote:
> External email: Use caution opening links or attachments
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 10 March 2023 16:21
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
> > <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> > kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
> > jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
> > iommu@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> > helper
> >
> > On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > > >
> > https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameer
> > > > > ali.kolothum.thodi@huawei.com/
> > > >
> > > > So "boot configration" is more like "don't change the RIDs"? Ie don't
> > enable
> > > > SRIOV?
> > >
> > > Yes. Don't think it will work with SR-IOV if you can't guarantee the RMR
> > specified
> > > SID.
> >
> > So I think we are probably good them because vSR-IOV is already not
> > supported by qemu, so it impossible for a VM to change the PCI
> > configuration in a way that would alter the RID to SID mapping?
> >
> 
> Provided we fix the issue mentioned by Eric. This was discussed here previously,
> 
> https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com/

Have we fixed the issue? I saw Lorenzo replying in that thread:
https://lore.kernel.org/linux-arm-kernel/Yi8nV8H4Jjlpadmk@lpieralisi/

Or, what's remaining here regarding this topic? Is it a blocker?

Thanks
Nic
